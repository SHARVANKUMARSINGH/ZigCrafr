//! Transpiled from Horizon Rust crate
//! Module: horizon-telemetry_server_status
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! How many play on a Minecraft server, by the server-list status ping every client sends to show
//! a server in its Multiplayer list (vanilla's `ServerStatusPinger`): a handshake asking for the
//! status state, a status request, and the server's JSON answer. Nothing about the asker is sent.
//!
//! The launcher shows the official server's count beside "N playing now", and the telemetry
//! server writes it down every minute for playhorizon.dev/stats (`history`, the `official`
//! series). [`OFFICIAL_ADDRESS`] is the official server's built-in address for both; the launcher
//! takes the current one from `launcher/links.json`.
// use std::io::{Read, Write};
// use std::net::{TcpStream, ToSocketAddrs};
// use std::time::Duration;

/// Horizon's official survival server (SMP). The launcher's server list offers the same entry
/// (`launcher/src/server_list.rs`) until links.json names another; the telemetry server's
/// `HORIZON_TELEMETRY_OFFICIAL_SERVER` overrides it there. Its SRV record leads to the port.
pub const OFFICIAL_ADDRESS: []const u8 = "play.playhorizon.dev";

/// The official server's earlier addresses: the game and the launcher move a server list's
/// entries for them to [`OFFICIAL_ADDRESS`], once. A move appends the old address here (and to
/// `official_server_previous` in `launcher/links.json`).
pub const OFFICIAL_PREVIOUS: *[[]const u8] = &["horizon.bunchy7s.dev"];

/// [`OFFICIAL_ADDRESS`] with the port its SRV record gives, for askers that don't look SRV up
/// (the telemetry server).
pub const OFFICIAL_STATUS_ADDRESS: []const u8 = "play.playhorizon.dev:24454";

/// The port a server address without one means.
pub const DEFAULT_PORT: u16 = 25565;

/// The protocol version the handshake names (`horizon_protocol`'s, 26.3). A server answers the
/// status of any version.
pub const PROTOCOL: i32 = 777;

/// The longest status answer read: room for a 64x64 icon in base64 and a long description.
pub const MAX_ANSWER: usize = 256 * 1024;

/// The players part of a status answer.
pub const Players = struct {
    online: u64,
    max: u64,
};

/// `host`, `host:port` or `[v6]:port` as host and port. SRV records are not looked up.
pub fn split_address(address: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let address = address.trim();
    // rust: if address.is_empty() {
    // rust: return None;
}
    // rust: if let Some(rest) = address.strip_prefix('[') {
    // rust: let (host, after) = rest.split_once(']')?;
    // rust: let port = match after.strip_prefix(':') {
    // rust: Some(p) => p.parse().ok()?,
    // rust: None if after.is_empty() => DEFAULT_PORT,
    // rust: None => return None,
}
    // rust: return Some((host.to_owned(), port));
}
    // rust: match address.rsplit_once(':') {
    // rust: Some((host, port)) if !host.contains(':') => Some((host.to_owned(), port.parse().ok()?)),
    // rust: _ => Some((address.to_owned(), DEFAULT_PORT)),
}
}

/// Asks `address` for its status within `timeout` (to connect, and again for each read and
/// write), and returns its player count.
pub fn players(address: []const u8, timeout: Duration) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (host, port) = split_address(address).ok_or("not a server address")?;
    // rust: players_at(address, (&host, port), timeout)
}

/// [`players`], connecting to `target` instead: where the address's SRV record leads. The
/// handshake still names the address, as vanilla's status ping does.
    // rust: pub fn players_at(
    // rust: address: &str,
    // rust: target: (&str, u16),
    // rust: timeout: Duration,
    // rust: ) -> Result<Players, String> {
    // rust: let (host, port) = split_address(address).ok_or("not a server address")?;
    // rust: let addr = target
    // rust: .to_socket_addrs()
    // rust: .map_err(|e| e.to_string())?
    // rust: .next()
    // rust: .ok_or("the name has no address")?;
    // rust: let mut stream = TcpStream::connect_timeout(&addr, timeout).map_err(|e| e.to_string())?;
    // rust: stream
    // rust: .set_read_timeout(Some(timeout))
    // rust: .and_then(|()| stream.set_write_timeout(Some(timeout)))
    // rust: .map_err(|e| e.to_string())?;
    // rust: stream
    // rust: .write_all(&request(&host, port))
    // rust: .map_err(|e| e.to_string())?;
    // rust: let json = read_answer(&mut stream)?;
    // rust: parse_players(&json)
}

/// The handshake (next state: status) and the status request, each framed with its length.
pub fn request(host: []const u8, port: u16) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut handshake = Vec::new();
    // rust: write_varint(&mut handshake, 0x00);
    // rust: write_varint(&mut handshake, PROTOCOL);
    // rust: write_varint(&mut handshake, host.len() as i32);
    // rust: handshake.extend_from_slice(host.as_bytes());
    // rust: handshake.extend_from_slice(&port.to_be_bytes());
    // rust: write_varint(&mut handshake, 1);
    // rust: let mut out = Vec::new();
    // rust: write_varint(&mut out, handshake.len() as i32);
    // rust: out.extend(handshake);
    // The status request: length 1, packet 0x00.
    // rust: out.extend([1, 0x00]);
    // rust: out
}

pub fn write_varint(out: *mut std.ArrayList(u8), value: i32) void {
}
    // rust: let mut v = value as u32;
    // rust: loop {
    // rust: if v & !0x7f == 0 {
    // rust: out.push(v as u8);
    // rust: return;
}
    // rust: out.push((v & 0x7f) as u8 | 0x80);
    // rust: v >>= 7;
}
}

pub fn read_varint(r: *mut impl Read) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut value = 0u32;
    // rust: for i in 0..5 {
    // rust: let mut byte = [0];
    // rust: r.read_exact(&mut byte).map_err(|e| e.to_string())?;
    // rust: value |= u32::from(byte[0] & 0x7f) << (7 * i);
    // rust: if byte[0] & 0x80 == 0 {
    // rust: return Ok(value as i32);
}
}
    // rust: Err("a varint longer than 5 bytes".into())
}

/// The status response packet's JSON.
pub fn read_answer(r: *mut impl Read) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let length = read_varint(r)?;
    // rust: if length <= 0 || length as usize > MAX_ANSWER {
    // rust: return Err(format!("a status answer of {length} bytes"));
}
    // rust: let mut packet = vec![0; length as usize];
    // rust: r.read_exact(&mut packet).map_err(|e| e.to_string())?;
    // rust: let mut body = packet.as_slice();
    // rust: if read_varint(&mut body)? != 0x00 {
    // rust: return Err("not a status answer".into());
}
    // rust: let text = read_varint(&mut body)?;
    // rust: if text < 0 || text as usize != body.len() {
    // rust: return Err("a status answer of the wrong length".into());
}
    // rust: String::from_utf8(body.to_vec()).map_err(|e| e.to_string())
}

/// `players.online` and `players.max` from a status answer.
pub fn parse_players(json: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let value: serde_json::Value = serde_json::from_str(json).map_err(|e| e.to_string())?;
    // rust: let players = value.get("players").ok_or("no players in the answer")?;
    // rust: let field = |k: &str| players.get(k).and_then(serde_json::Value::as_u64);
    // rust: Ok(Players {
    // rust: online: field("online").ok_or("no players.online")?,
    // rust: max: field("max").unwrap_or(0),
    // rust: })
}

    // rust: mod tests {
//     use super::*;
//     use std::net::TcpListener;

pub fn answer(json: []const u8) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut packet = Vec::new();
    // rust: write_varint(&mut packet, 0x00);
    // rust: write_varint(&mut packet, json.len() as i32);
    // rust: packet.extend_from_slice(json.as_bytes());
    // rust: let mut out = Vec::new();
    // rust: write_varint(&mut out, packet.len() as i32);
    // rust: out.extend(packet);
    // rust: out
}

pub fn addresses_split_into_host_and_port() void {
}
    // rust: let split = |a| split_address(a);
    // rust: assert_eq!(
    // rust: split("horizon.bunchy7s.dev"),
    // rust: Some(("horizon.bunchy7s.dev".into(), 25565))
    // rust: );
    // rust: assert_eq!(
    // rust: split("example.org:25570"),
    // rust: Some(("example.org".into(), 25570))
    // rust: );
    // rust: assert_eq!(split("[::1]:25566"), Some(("::1".into(), 25566)));
    // rust: assert_eq!(split("[::1]"), Some(("::1".into(), 25565)));
    // rust: assert_eq!(split("example.org:http"), None);
    // rust: assert_eq!(split(" "), None);
}

pub fn varints_are_vanillas() void {
}
    // rust: for (value, bytes) in [
    // rust: (0, vec![0x00]),
    // rust: (127, vec![0x7f]),
    // rust: (128, vec![0x80, 0x01]),
    // rust: (25565, vec![0xdd, 0xc7, 0x01]),
    // rust: (-1, vec![0xff, 0xff, 0xff, 0xff, 0x0f]),
    // rust: ] {
    // rust: let mut out = Vec::new();
    // rust: write_varint(&mut out, value);
    // rust: assert_eq!(out, bytes, "{value}");
    // rust: assert_eq!(read_varint(&mut bytes.as_slice()).unwrap(), value);
}
}

pub fn a_server_answers_its_player_count() void {
}
    // rust: let listener = TcpListener::bind("127.0.0.1:0").unwrap();
    // rust: let port = listener.local_addr().unwrap().port();
    // rust: let server = std::thread::spawn(move || {
    // rust: let (mut socket, _) = listener.accept().unwrap();
    // rust: let expected = request("127.0.0.1", port);
    // rust: let mut got = vec![0; expected.len()];
    // rust: socket.read_exact(&mut got).unwrap();
    // rust: assert_eq!(got, expected);
    // rust: let json = r#"{"version":{"name":"26.3","protocol":777},"players":{"max":100,"online":12,"sample":[]},"description":{"text":"Horizon"}}"#;
    // rust: socket.write_all(&answer(json)).unwrap();
    // rust: });
    // rust: let players = players(&format!("127.0.0.1:{port}"), Duration::from_secs(2)).unwrap();
    // rust: assert_eq!(
    // rust: players,
    // rust: Players {
    // rust: online: 12,
    // rust: max: 100
}
    // rust: );
    // rust: server.join().unwrap();
}

pub fn bad_answers_are_refused() void {
}
    // rust: assert!(read_answer(&mut [0x00].as_slice()).is_err());
    // rust: assert!(read_answer(&mut answer("{}")[..2].as_ref()).is_err());
    // rust: let mut wrong_id = answer("{}");
    // rust: wrong_id[1] = 0x01;
    // rust: assert!(read_answer(&mut wrong_id.as_slice()).is_err());
    // rust: assert!(parse_players(r#"{"players":{"max":5}}"#).is_err());
    // rust: assert!(parse_players("not json").is_err());
    // rust: assert_eq!(
    // rust: read_answer(&mut answer(r#"{"players":{"online":3}}"#).as_slice()).unwrap(),
    // rust: r#"{"players":{"online":3}}"#
    // rust: );
    // rust: assert_eq!(
    // rust: parse_players(r#"{"players":{"online":3}}"#).unwrap(),
    // rust: Players { online: 3, max: 0 }
    // rust: );
}

pub fn nobody_listening_fails_within_the_timeout() void {
}
    // rust: let listener = TcpListener::bind("127.0.0.1:0").unwrap();
    // rust: let port = listener.local_addr().unwrap().port();
    // rust: drop(listener);
    // rust: assert!(players(&format!("127.0.0.1:{port}"), Duration::from_millis(500)).is_err());
}
}
