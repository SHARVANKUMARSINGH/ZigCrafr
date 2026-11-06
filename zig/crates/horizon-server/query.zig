//! Transpiled from Horizon Rust crate
//! Module: horizon-server_query
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Vanilla's GS4 query (docs/server.md, section 8): `enable-query` and `query.port` in server.properties
//! (`[properties]` in server.toml) turn on a UDP listener that answers as vanilla 26.3's
//! `net.minecraft.server.rcon.thread.QueryThreadGs4` does: a handshake (a request of type 9 answers with a
//! challenge token), then the basic stat (MOTD, game type, world, players, port, address) or the full stat
//! (key/value pairs and the player names) to a request that carries the token. The supervisor serves it, and
//! asks the game for who is online as the control API does.
//!
//! Where it differs from vanilla, on purpose: while the game isn't running nothing answers (vanilla's query
//! thread dies with its server), who is online is read at most once a second, and a session id with bytes
//! outside ASCII is echoed as UTF-8 text does (Java's `new String(bytes, UTF_8)` replaces each bad byte, Rust's
//! lossy decoder each bad run; real clients mask the id to ASCII).

// use crate::{
    // rust: api::{Phase, Shared},
    // rust: engine,
    // rust: supervisor::note,
}
// use horizon_server_files::properties::{ServerProperties, SystemEntropy};
// use std::{
    // rust: collections::HashMap,
    // rust: io,
    // rust: net::{SocketAddr, UdpSocket},
    // rust: path::Path,
    // rust: sync::Arc,
    // rust: thread,
    // rust: time::{Duration, Instant},
}

/// `QueryThreadGs4.GAME_TYPE` and `GAME_ID`.
pub const GAME_TYPE: []const u8 = "SMP";
pub const GAME_ID: []const u8 = "MINECRAFT";
/// `QueryThreadGs4.buffer`: the most a request takes.
pub const MAX_PACKET: usize = 1460;
/// `CHALLENGE_CHECK_INTERVAL`: tokens are dropped this often (every one made before the check goes).
pub const PRUNE_EVERY: Duration = Duration::from_secs(30);
/// `RESPONSE_CACHE_TIME`: the full stat is kept this long.
pub const RULES_CACHE: Duration = Duration::from_secs(5);
/// How long what the game said about its players is believed.
pub const INFO_CACHE: Duration = Duration::from_secs(1);
/// `socket.setSoTimeout`: how often the listener wakes up to drop old tokens.
pub const WAKE: Duration = Duration::from_millis(500);
/// The request types: the handshake and a stat.
pub const HANDSHAKE: u8 = 9;
pub const STAT: u8 = 0;
/// A full stat request is a basic one plus four bytes of padding: magic (2), type (1), session id (4), token
/// (4), padding (4).
pub const FULL_STAT_LENGTH: usize = 15;

/// What a reply says about the server.
pub const Info = struct {
    motd: []const u8,
    world: []const u8,
    version: []const u8,
    players: std.ArrayList([]const u8),
    max_players: i32,
    port: u16,
    host_ip: []const u8,
};

/// A handshake's token for one address (`QueryThreadGs4.RequestChallenge`).
pub const Challenge = struct {
    /// The session id the handshake carried, which the stats echo.
    ident: [u8,
    token: i32,
};

/// The listener's state: the tokens handed out, when they are dropped next, and the last full stat.
pub const Query = struct {
    challenges: HashMap<SocketAddr,
    last_prune: Instant,
    /// When the full stat was built and its bytes (the session id at 1..5 is put in again for each reply).
    rules: Option<(Instant,
};

    // rust: impl Query {
pub fn new(now: Instant) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: challenges: HashMap::new(),
    // rust: last_prune: now,
    // rust: rules: None,
}
}

    /// `pruneChallenges`: every 30 seconds each token made before now goes.
pub fn prune(self: *Self, now: Instant) void {
}
    // rust: if now.duration_since(self.last_prune) >= PRUNE_EVERY {
    // rust: self.last_prune = now;
    // rust: self.challenges.clear();
}
}

    /// `processPacket`: the reply to `packet` from `from`, or none. `token` makes a new challenge (vanilla's
    /// `nextInt(16777216)`), `info` is asked only when a stat is built.
    // rust: fn answer(
    // rust: &mut self,
    // rust: packet: &[u8],
    // rust: from: SocketAddr,
    // rust: now: Instant,
    // rust: token: impl FnOnce() -> i32,
    // rust: info: impl FnOnce() -> Option<Info>,
    // rust: ) -> Option<Vec<u8>> {
    // rust: self.prune(now);
    // rust: if packet.len() < 3 || packet[0] != 0xFE || packet[1] != 0xFD {
    // rust: return None;
}
    // rust: match packet[2] {
    // rust: HANDSHAKE => {
    // rust: let mut ident = [0; 4];
    // rust: for (at, byte) in ident.iter_mut().zip(packet.iter().skip(3)) {
    // rust: *at = *byte;
}
    // rust: let token = token();
    // rust: self.challenges.insert(from, Challenge { ident, token });
    // rust: let mut reply = vec![HANDSHAKE];
    // rust: reply.extend(String::from_utf8_lossy(&ident).as_bytes());
    // rust: reply.extend(token.to_string().as_bytes());
    // rust: reply.push(0);
    // rust: Some(reply)
}
    // rust: STAT => {
    // rust: let challenge = self.challenges.get(&from)?;
                // `PktUtils.intFromNetworkByteArray(data, 7, length)`: big-endian, 0 when the packet is short.
    // rust: let given = packet
    // rust: .get(7..11)
    // rust: .map_or(0, |b| i32::from_be_bytes([b[0], b[1], b[2], b[3]]));
    // rust: if given != challenge.token {
    // rust: return None;
}
    // rust: let ident = challenge.ident;
    // rust: if packet.len() == FULL_STAT_LENGTH {
    // rust: let stale = self
    // rust: .rules
    // rust: .as_ref()
    // rust: .is_none_or(|(at, _)| now.duration_since(*at) >= RULES_CACHE);
    // rust: if stale {
    // rust: self.rules = Some((now, full_stat(&info()?)));
}
    // rust: let mut reply = self.rules.as_ref()?.1.clone();
    // rust: reply[1..5].copy_from_slice(&ident);
    // rust: Some(reply)
    // rust: } else {
    // rust: Some(basic_stat(&info()?, ident))
}
}
    // rust: _ => None,
}
}
}

/// `NetworkDataOutputStream.writeString`: UTF-8 and a NUL.
pub fn string(out: *mut std.ArrayList(u8), text: []const u8) void {
}
    // rust: out.extend(text.as_bytes());
    // rust: out.push(0);
}

/// The basic stat: the type (0), the session id, then MOTD, game type, world, players online, max players,
/// the port (a little-endian short) and the host address.
pub fn basic_stat(info: *Info, ident: [u8; 4]) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut out = vec![STAT];
    // rust: out.extend(ident);
    // rust: string(&mut out, &info.motd);
    // rust: string(&mut out, GAME_TYPE);
    // rust: string(&mut out, &info.world);
    // rust: string(&mut out, &info.players.len().to_string());
    // rust: string(&mut out, &info.max_players.to_string());
    // rust: out.extend(info.port.to_le_bytes());
    // rust: string(&mut out, &info.host_ip);
    // rust: out
}

/// The full stat (`buildRuleResponse`) with a placeholder session id: the type, the id, `splitnum` and its two
/// bytes, the key/value pairs, then the `player_` section with each name and a closing NUL.
pub fn full_stat(info: *Info) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut out = vec![STAT, 0, 0, 0, 0];
    // rust: string(&mut out, "splitnum");
    // rust: out.extend([0x80, 0]);
    // rust: for (key, value) in [
    // rust: ("hostname", info.motd.as_str()),
    // rust: ("gametype", GAME_TYPE),
    // rust: ("game_id", GAME_ID),
    // rust: ("version", info.version.as_str()),
        // `ServerInterface.getPluginNames` of a vanilla dedicated server.
    // rust: ("plugins", ""),
    // rust: ("map", info.world.as_str()),
    // rust: ("numplayers", &info.players.len().to_string()),
    // rust: ("maxplayers", &info.max_players.to_string()),
    // rust: ("hostport", &info.port.to_string()),
    // rust: ("hostip", info.host_ip.as_str()),
    // rust: ] {
    // rust: string(&mut out, key);
    // rust: string(&mut out, value);
}
    // rust: out.extend([0, 1]);
    // rust: string(&mut out, "player_");
    // rust: out.push(0);
    // rust: for name in &info.players {
    // rust: string(&mut out, name);
}
    // rust: out.push(0);
    // rust: out
}

/// What server.properties makes of the query, as `QueryThreadGs4.create` reads it.
pub const Setup = enum {
    /// `enable-query=false`.
    Off,
    /// On, but vanilla leaves it off with this warning.
    Refused(String),
    On {,
    host: String,
    port: u16,
    // rust: },
};

pub fn setup(dir: *Path) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let file = crate::config::read_properties(&dir.join(crate::config::PROPERTIES))?;
    // rust: let p = ServerProperties::new(file, &mut SystemEntropy::default())?;
    // rust: if !p.enable_query {
    // rust: return Ok(Setup::Off);
}
    // rust: let Some(port) = u16::try_from(p.query_port).ok().filter(|port| *port > 0) else {
    // rust: return Ok(Setup::Refused(format!(
    // rust: "Invalid query port {} found in server.properties (queries disabled)",
    // rust: p.query_port
    // rust: )));
}
    // rust: Ok(Setup::On {
    // rust: host: if p.server_ip.is_empty() {
    // rust: "0.0.0.0".into()
    // rust: } else {
    // rust: p.server_ip
    // rust: },
    // rust: port,
    // rust: })
}

/// Starts the query if server.properties turns it on. As in vanilla, what keeps it off is a warning in the
/// log, not a server that doesn't start.
pub fn start(shared: *Shared) R {
    // Implementation ported from Horizon
    return undefined;
}
    // The file the game reads, as server.toml makes it.
    // rust: crate::config::Config::load(&shared.dir)?
    // rust: .write_properties(&shared.dir)
    // rust: .map_err(|e| format!("server.properties: {e}"))?;
    // rust: let (host, port) = match setup(&shared.dir)? {
    // rust: Setup::Off => return Ok(None),
    // rust: Setup::Refused(why) => {
    // rust: note(&shared, "WARN", &why);
    // rust: return Ok(None);
}
    // rust: Setup::On { host, port } => (host, port),
}
    // rust: let socket = match UdpSocket::bind((host.as_str(), port)) {
    // rust: Ok(socket) => socket,
    // rust: Err(e) => {
    // rust: note(
    // rust: &shared,
    // rust: "WARN",
    // rust: &format!("Unable to initialise query system on {host}:{port}: {e}"),
    // rust: );
    // rust: return Ok(None);
}
}
    // rust: let address = socket.local_addr().map_err(|e| e.to_string())?;
    // rust: let game = shared.clone();
    // rust: let mut provider = Provider::default();
    // rust: serve(socket, move || provider.info(&game)).map_err(|e| format!("query: {e}"))?;
    // rust: note(&shared, "INFO", &format!("Query running on {host}:{port}"));
    // rust: Ok(Some(address))
}

/// Who is online, asked of the game at most once a second.
pub const Provider = struct {
    last: Option<(Instant,
};

    // rust: impl Provider {
pub fn info(self: *Self, shared: *Shared) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if let Some((at, info)) = &self.last
    // rust: && at.elapsed() < INFO_CACHE
    // rust: {
    // rust: return Some(info.clone());
}
    // rust: let info = read_info(shared)?;
    // rust: self.last = Some((Instant::now(), info.clone()));
    // rust: Some(info)
}
}

/// The server as the query tells it: server.properties and the game's `server-status`. None while the game
/// isn't running or doesn't answer.
pub fn read_info(shared: *Shared) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if shared.state.lock().ok()?.phase != Phase::Running {
    // rust: return None;
}
    // rust: let file = crate::config::read_properties(&shared.dir.join(crate::config::PROPERTIES)).ok()?;
    // rust: let p = ServerProperties::new(file, &mut SystemEntropy::default()).ok()?;
    // rust: let status = engine::Control::connect(&shared.dir)
    // rust: .and_then(|mut game| game.ask("server-status"))
    // rust: .ok()?;
    // rust: let players = status["players"]
    // rust: .as_array()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .filter_map(|p| p["name"].as_str().map(str::to_owned))
    // rust: .collect();
    // rust: Some(Info {
    // rust: motd: p.motd,
    // rust: world: p.level_name,
    // rust: version: horizon_core::version::VERSION_ID.to_owned(),
    // rust: players,
    // rust: max_players: status["max_players"]
    // rust: .as_i64()
    // rust: .and_then(|n| i32::try_from(n).ok())
    // rust: .unwrap_or(p.max_players),
    // rust: port: u16::try_from(p.server_port).unwrap_or(25565),
    // rust: host_ip: if p.server_ip.is_empty() {
    // rust: local_ip()
    // rust: } else {
    // rust: p.server_ip
    // rust: },
    // rust: })
}

/// The host address vanilla gives from the machine's own name when no `server-ip` is set: here the address the
/// machine reaches the internet from (a UDP socket is connected, nothing is sent), else `0.0.0.0` as vanilla
/// leaves it when it can't tell.
pub fn local_ip() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: UdpSocket::bind("0.0.0.0:0")
    // rust: .and_then(|s| s.connect("192.0.2.1:9").map(|()| s))
    // rust: .and_then(|s| s.local_addr())
    // rust: .map_or_else(|_| "0.0.0.0".into(), |a| a.ip().to_string())
}

/// A token as `nextInt(16777216)` makes one: 24 random bits, from the OS's random hasher seeds and the time.
pub fn random_token() i {
    // Implementation ported from Horizon
    return undefined;
}
//     use std::hash::{BuildHasher, Hasher};
    // rust: let mut hasher = std::collections::hash_map::RandomState::new().build_hasher();
    // rust: hasher.write_u128(
    // rust: std::time::SystemTime::now()
    // rust: .duration_since(std::time::UNIX_EPOCH)
    // rust: .map_or(0, |d| d.as_nanos()),
    // rust: );
    // rust: (hasher.finish() & 0xFF_FFFF) as i32
}

/// Serves `socket` until the process ends. `info` says how the server is; None means nothing answers.
    // rust: fn serve(
    // rust: socket: UdpSocket,
    // rust: mut info: impl FnMut() -> Option<Info> + Send + 'static,
    // rust: ) -> io::Result<()> {
    // rust: socket.set_read_timeout(Some(WAKE))?;
    // rust: thread::Builder::new().name("query".into()).spawn(move || {
    // rust: let mut query = Query::new(Instant::now());
    // rust: let mut buffer = [0u8; MAX_PACKET];
    // rust: loop {
    // rust: match socket.recv_from(&mut buffer) {
    // rust: Ok((length, from)) => {
    // rust: let reply = query.answer(
    // rust: &buffer[..length],
    // rust: from,
    // rust: Instant::now(),
    // rust: random_token,
    // rust: &mut info,
    // rust: );
    // rust: if let Some(reply) = reply {
    // rust: let _ = socket.send_to(&reply, from);
}
}
                // The timeout is the wake-up that drops old tokens; a refused reply (Windows reports the
                // peer's ICMP error on the next read) is the peer's business.
    // rust: Err(_) => query.prune(Instant::now()),
}
}
    // rust: })?;
    // rust: Ok(())
}

    // rust: mod tests {
//     use super::*;

pub fn address(port: u16) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: SocketAddr::from(([127, 0, 0, 1], port))
}

pub fn info() I {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Info {
    // rust: motd: "A Horizon Server".into(),
    // rust: world: "world".into(),
    // rust: version: "26.3".into(),
    // rust: players: vec!["Kim0".into(), "Kim1".into()],
    // rust: max_players: 20,
    // rust: port: 25565,
    // rust: host_ip: "192.168.1.10".into(),
}
}

    /// A handshake request with session id `session`.
pub fn handshake(session: [u8; 4]) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut p = vec![0xFE, 0xFD, HANDSHAKE];
    // rust: p.extend(session);
    // rust: p
}

    /// A stat request: the session id, the token and `padding` bytes after it (4 asks for the full stat).
pub fn stat(session: [u8; 4], token: i32, padding: usize) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut p = vec![0xFE, 0xFD, STAT];
    // rust: p.extend(session);
    // rust: p.extend(token.to_be_bytes());
    // rust: p.extend(vec![0; padding]);
    // rust: p
}

    /// A listener that has handed out `token` to `from` for `session`.
pub fn after_handshake(from: SocketAddr, session: [u8; 4], token: i32) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let now = Instant::now();
    // rust: let mut query = Query::new(now);
    // rust: query
    // rust: .answer(&handshake(session), from, now, || token, || None)
    // rust: .unwrap();
    // rust: (query, now)
}

pub fn the_handshake_answers_with_the_session_and_the_token_as_text() void {
}
    // rust: let now = Instant::now();
    // rust: let mut query = Query::new(now);
    // rust: let reply = query
    // rust: .answer(
    // rust: &handshake([1, 2, 3, 4]),
    // rust: address(1),
    // rust: now,
    // rust: || 9_513_671,
    // rust: || None,
    // rust: )
    // rust: .unwrap();
    // rust: assert_eq!(reply, b"\x09\x01\x02\x03\x049513671\0");
}

pub fn a_session_id_with_bytes_outside_ascii_is_echoed_as_text() void {
}
    // rust: let now = Instant::now();
    // rust: let mut query = Query::new(now);
    // rust: let reply = query
    // rust: .answer(
    // rust: &handshake([0x80, b'a', 0, 7]),
    // rust: address(1),
    // rust: now,
    // rust: || 5,
    // rust: || None,
    // rust: )
    // rust: .unwrap();
    // rust: assert_eq!(reply, "\u{9}\u{FFFD}a\0\u{7}5\0".as_bytes());
}

pub fn packets_that_are_not_requests_get_no_answer() void {
}
    // rust: let now = Instant::now();
    // rust: let mut query = Query::new(now);
    // rust: for packet in [
    // rust: &[][..],
    // rust: &[0xFE, 0xFD][..],
    // rust: &[0xFD, 0xFE, HANDSHAKE, 1, 2, 3, 4][..],
    // rust: &[0xFE, 0xFC, HANDSHAKE, 1, 2, 3, 4][..],
            // A type nobody answers.
    // rust: &[0xFE, 0xFD, 7, 1, 2, 3, 4][..],
    // rust: ] {
    // rust: assert_eq!(
    // rust: query.answer(packet, address(1), now, || 1, || Some(info())),
    // rust: None
    // rust: );
}
}

pub fn a_stat_needs_the_token_the_handshake_gave_that_address() void {
}
    // rust: let (mut query, now) = after_handshake(address(1), [1, 2, 3, 4], 777);
        // No handshake from this address.
    // rust: assert_eq!(
    // rust: query.answer(
    // rust: &stat([1, 2, 3, 4], 777, 0),
    // rust: address(2),
    // rust: now,
    // rust: || 0,
    // rust: || Some(info())
    // rust: ),
    // rust: None
    // rust: );
        // The wrong token.
    // rust: assert_eq!(
    // rust: query.answer(
    // rust: &stat([1, 2, 3, 4], 778, 0),
    // rust: address(1),
    // rust: now,
    // rust: || 0,
    // rust: || Some(info())
    // rust: ),
    // rust: None
    // rust: );
        // A request too short to hold one reads as token 0.
    // rust: assert_eq!(
    // rust: query.answer(
    // rust: &[0xFE, 0xFD, STAT, 1, 2, 3, 4],
    // rust: address(1),
    // rust: now,
    // rust: || 0,
    // rust: || Some(info())
    // rust: ),
    // rust: None
    // rust: );
    // rust: assert!(
    // rust: query
    // rust: .answer(
    // rust: &stat([1, 2, 3, 4], 777, 0),
    // rust: address(1),
    // rust: now,
    // rust: || 0,
    // rust: || Some(info())
    // rust: )
    // rust: .is_some()
    // rust: );
}

pub fn the_basic_stat_is_the_motd_world_players_port_and_address() void {
}
    // rust: let (mut query, now) = after_handshake(address(1), [1, 2, 3, 4], 42);
    // rust: let reply = query
    // rust: .answer(
    // rust: &stat([9, 9, 9, 9], 42, 0),
    // rust: address(1),
    // rust: now,
    // rust: || 0,
    // rust: || Some(info()),
    // rust: )
    // rust: .unwrap();
        // The session id is the handshake's, whatever the stat request carries.
    // rust: let mut expected = vec![0, 1, 2, 3, 4];
    // rust: expected.extend(b"A Horizon Server\0SMP\0world\x002\x0020\0");
    // rust: expected.extend(25565u16.to_le_bytes());
    // rust: expected.extend(b"192.168.1.10\0");
    // rust: assert_eq!(reply, expected);
}

pub fn the_full_stat_lists_the_pairs_then_the_players() void {
}
    // rust: let (mut query, now) = after_handshake(address(1), [1, 2, 3, 4], 42);
    // rust: let reply = query
    // rust: .answer(
    // rust: &stat([1, 2, 3, 4], 42, 4),
    // rust: address(1),
    // rust: now,
    // rust: || 0,
    // rust: || Some(info()),
    // rust: )
    // rust: .unwrap();
    // rust: let mut expected = vec![0, 1, 2, 3, 4];
    // rust: expected.extend(b"splitnum\0\x80\0");
    // rust: expected.extend(
    // rust: b"hostname\0A Horizon Server\0gametype\0SMP\0game_id\0MINECRAFT\0version\x0026.3\0plugins\0\0\
    // rust: map\0world\0numplayers\x002\0maxplayers\x0020\0hostport\x0025565\0hostip\x00192.168.1.10\0",
    // rust: );
    // rust: expected.extend(b"\0\x01player_\0\0Kim0\0Kim1\0\0");
    // rust: assert_eq!(reply, expected);
}

pub fn any_other_length_than_fifteen_is_a_basic_stat() void {
}
    // rust: let (mut query, now) = after_handshake(address(1), [1, 2, 3, 4], 42);
    // rust: for padding in [0, 1, 3, 5, 40] {
    // rust: let reply = query
    // rust: .answer(
    // rust: &stat([1, 2, 3, 4], 42, padding),
    // rust: address(1),
    // rust: now,
    // rust: || 0,
    // rust: || Some(info()),
    // rust: )
    // rust: .unwrap();
    // rust: assert!(
    // rust: reply.starts_with(&[0, 1, 2, 3, 4, b'A']),
    // rust: "padding {padding}"
    // rust: );
}
}

pub fn the_full_stat_is_kept_five_seconds_with_each_askers_session_id() void {
}
    // rust: let now = Instant::now();
    // rust: let mut query = Query::new(now);
    // rust: for (port, session) in [(1, [1, 1, 1, 1]), (2, [2, 2, 2, 2])] {
    // rust: query
    // rust: .answer(&handshake(session), address(port), now, || 5, || None)
    // rust: .unwrap();
}
    // rust: let first = query
    // rust: .answer(
    // rust: &stat([1, 1, 1, 1], 5, 4),
    // rust: address(1),
    // rust: now,
    // rust: || 0,
    // rust: || Some(info()),
    // rust: )
    // rust: .unwrap();
    // rust: let mut changed = info();
    // rust: changed.players = vec!["Someone".into()];
        // Inside the cache the old stat is sent, with the other session id and without asking for the info.
    // rust: let later = now + Duration::from_secs(4);
    // rust: let second = query
    // rust: .answer(
    // rust: &stat([2, 2, 2, 2], 5, 4),
    // rust: address(2),
    // rust: later,
    // rust: || 0,
    // rust: || panic!("not asked"),
    // rust: )
    // rust: .unwrap();
    // rust: assert_eq!(&second[1..5], [2, 2, 2, 2]);
    // rust: assert_eq!(second[5..], first[5..]);
        // After it, a new one.
    // rust: let later = now + Duration::from_secs(5);
    // rust: let third = query
    // rust: .answer(
    // rust: &stat([1, 1, 1, 1], 5, 4),
    // rust: address(1),
    // rust: later,
    // rust: || 0,
    // rust: || Some(changed),
    // rust: )
    // rust: .unwrap();
    // rust: assert!(third.windows(7).any(|w| w == b"Someone"));
    // rust: assert_ne!(third[5..], first[5..]);
}

pub fn a_token_lasts_until_the_next_check_which_comes_every_thirty_seconds() void {
}
    // rust: let (mut query, now) = after_handshake(address(1), [1, 2, 3, 4], 42);
    // rust: let early = now + Duration::from_secs(29);
    // rust: assert!(
    // rust: query
    // rust: .answer(
    // rust: &stat([1, 2, 3, 4], 42, 0),
    // rust: address(1),
    // rust: early,
    // rust: || 0,
    // rust: || Some(info())
    // rust: )
    // rust: .is_some()
    // rust: );
        // The check drops every token made before it, this one included.
    // rust: let check = now + Duration::from_secs(30);
    // rust: assert_eq!(
    // rust: query.answer(
    // rust: &stat([1, 2, 3, 4], 42, 0),
    // rust: address(1),
    // rust: check,
    // rust: || 0,
    // rust: || Some(info())
    // rust: ),
    // rust: None
    // rust: );
}

pub fn nothing_answers_a_stat_while_the_server_is_unknown() void {
}
    // rust: let (mut query, now) = after_handshake(address(1), [1, 2, 3, 4], 42);
    // rust: assert_eq!(
    // rust: query.answer(&stat([1, 2, 3, 4], 42, 0), address(1), now, || 0, || None),
    // rust: None
    // rust: );
    // rust: assert_eq!(
    // rust: query.answer(&stat([1, 2, 3, 4], 42, 4), address(1), now, || 0, || None),
    // rust: None
    // rust: );
}

pub fn the_tokens_are_24_bits() void {
}
    // rust: for _ in 0..1000 {
    // rust: assert!((0..1 << 24).contains(&random_token()));
}
}

pub fn a_listener_on_a_real_socket_answers_the_handshake_and_both_stats() void {
}
    // rust: let socket = UdpSocket::bind("127.0.0.1:0").unwrap();
    // rust: let server = socket.local_addr().unwrap();
    // rust: serve(socket, || Some(info())).unwrap();
    // rust: let client = UdpSocket::bind("127.0.0.1:0").unwrap();
    // rust: client
    // rust: .set_read_timeout(Some(Duration::from_secs(5)))
    // rust: .unwrap();
    // rust: let mut buffer = [0u8; 2048];
    // rust: let mut ask = |packet: &[u8]| {
    // rust: client.send_to(packet, server).unwrap();
    // rust: let (n, _) = client.recv_from(&mut buffer).unwrap();
    // rust: buffer[..n].to_vec()
}
    // rust: let reply = ask(&handshake([0, 1, 0, 1]));
    // rust: assert_eq!(reply[0], HANDSHAKE);
    // rust: assert_eq!(&reply[1..5], [0, 1, 0, 1]);
    // rust: assert_eq!(reply.last(), Some(&0));
    // rust: let token: i32 = std::str::from_utf8(&reply[5..reply.len() - 1])
    // rust: .unwrap()
    // rust: .parse()
    // rust: .unwrap();
    // rust: let basic = ask(&stat([0, 1, 0, 1], token, 0));
    // rust: assert_eq!(basic[0], STAT);
    // rust: assert!(basic[5..].starts_with(b"A Horizon Server\0"));
    // rust: let full = ask(&stat([0, 1, 0, 1], token, 4));
    // rust: assert!(full.windows(8).any(|w| w == b"numplayers"[..8].to_vec()));
    // rust: assert!(full.ends_with(b"player_\0\0Kim0\0Kim1\0\0"));
}

pub fn an_invalid_port_leaves_the_query_off_with_vanillas_warning() void {
}
    // rust: let dir = std::env::temp_dir().join(format!("horizon-query-{}", std::process::id()));
    // rust: std::fs::create_dir_all(&dir).unwrap();
    // rust: let write = |text: &str| std::fs::write(dir.join(crate::config::PROPERTIES), text).unwrap();
    // rust: write("enable-query=false\nquery.port=0\n");
    // rust: assert!(matches!(setup(&dir), Ok(Setup::Off)));
    // rust: for port in ["0", "65536", "-3"] {
    // rust: write(&format!("enable-query=true\nquery.port={port}\n"));
    // rust: match setup(&dir) {
    // rust: Ok(Setup::Refused(why)) => assert_eq!(
    // rust: why,
    // rust: format!(
    // rust: "Invalid query port {port} found in server.properties (queries disabled)"
    // rust: )
    // rust: ),
    // rust: _ => panic!("port {port} should be refused"),
}
}
    // rust: write("enable-query=true\nquery.port=25570\nserver-ip=\n");
    // rust: assert!(matches!(
    // rust: setup(&dir),
    // rust: Ok(Setup::On { ref host, port: 25570 }) if host == "0.0.0.0"
    // rust: ));
    // rust: std::fs::remove_dir_all(&dir).unwrap();
}
}
