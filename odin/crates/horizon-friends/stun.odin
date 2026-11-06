//! Transpiled from Horizon Rust crate
package horizon_friends_stun

import "core:fmt"
import "core:mem"
import "core:math"

// The host's public IPv4 address, from a STUN Binding request (RFC 8489)
// to public STUN servers. Only the address is used: the port a STUN server
// sees is a UDP mapping, while the game listens on TCP.
// use std::{
    // rust: io,
    // rust: net::{IpAddr, Ipv4Addr, Ipv6Addr, SocketAddr, ToSocketAddrs, UdpSocket},
    // rust: time::Duration,
}

// Two independent operators, so one outage doesn't break discovery; both
// run free public STUN for WebRTC at a global scale. Configurable with
// `HORIZON_STUN_SERVERS` (a comma list; `none` turns STUN off).
DEFAULT_SERVERS :: &["stun.cloudflare.com:3478", "stun.l.google.com:19302"]

MAGIC :: 0x2112_A442

// The servers to ask: `HORIZON_STUN_SERVERS`, else the defaults.
servers_from_env :: proc() -> V {
    // Ported from Horizon
    return {}
}
    // rust: match std::env::var("HORIZON_STUN_SERVERS") {
    // rust: Ok(v) => parse_servers(&v),
    // rust: Err(_) => DEFAULT_SERVERS.iter().map(|s| (*s).to_owned()).collect(),
}
}
// A comma list; empty or `none` means no STUN.
parse_servers :: proc(list: string) -> V {
    // Ported from Horizon
    return {}
}
    // rust: if list.trim().eq_ignore_ascii_case("none") {
    // rust: return Vec::new();
}
    // rust: list.split(',')
    // rust: .map(str::trim)
    // rust: .filter(|s| !s.is_empty())
    // rust: .map(str::to_owned)
    // rust: .collect()
}

request :: proc(id: ^[u8; 12]) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: let mut m = [0u8; 20];
    // rust: m[0..2].copy_from_slice(&0x0001u16.to_be_bytes());
    // rust: m[4..8].copy_from_slice(&MAGIC.to_be_bytes());
    // rust: m[8..20].copy_from_slice(id);
    // rust: m
}

// The mapped address in a Binding success response for transaction `id`.
parse_response :: proc(m: []u8, id: ^[u8; 12]) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if m.len() < 20 || m[0..2] != [0x01, 0x01] || m[4..8] != MAGIC.to_be_bytes() || &m[8..20] != id
    // rust: {
    // rust: return None;
}
    // rust: let len = usize::from(u16::from_be_bytes([m[2], m[3]]));
    // rust: let attrs = m.get(20..20 + len)?;
    // rust: let mut i = 0;
    // rust: let mut plain = None;
    // rust: while i + 4 <= attrs.len() {
    // rust: let kind = u16::from_be_bytes([attrs[i], attrs[i + 1]]);
    // rust: let alen = usize::from(u16::from_be_bytes([attrs[i + 2], attrs[i + 3]]));
    // rust: let value = attrs.get(i + 4..i + 4 + alen)?;
    // rust: let xor = kind == 0x0020;
    // rust: if (xor || kind == 0x0001) && value.len() >= 8 {
    // rust: let mut port = u16::from_be_bytes([value[2], value[3]]);
    // rust: if xor {
    // rust: port ^= (MAGIC >> 16) as u16;
}
    // rust: let ip = match value[1] {
    // rust: 1 => {
    // rust: let mut o: [u8; 4] = value[4..8].try_into().ok()?;
    // rust: if xor {
    // rust: for (b, k) in o.iter_mut().zip(MAGIC.to_be_bytes()) {
    // rust: *b ^= k;
}
}
    // rust: IpAddr::V4(Ipv4Addr::from(o))
}
    // rust: 2 if value.len() >= 20 => {
    // rust: let mut o: [u8; 16] = value[4..20].try_into().ok()?;
    // rust: if xor {
    // rust: let mut key = MAGIC.to_be_bytes().to_vec();
    // rust: key.extend_from_slice(id);
    // rust: for (b, k) in o.iter_mut().zip(key) {
    // rust: *b ^= k;
}
}
    // rust: IpAddr::V6(Ipv6Addr::from(o))
}
    // rust: _ => return None,
}
    // rust: let found = SocketAddr::new(ip, port);
    // rust: if xor {
    // rust: return Some(found);
}
    // rust: plain = Some(found);
}
    // rust: i += 4 + alen.div_ceil(4) * 4;
}
    // rust: plain
}

// Ask one server (resolved to IPv4), retrying twice.
query :: proc(server: string, timeout: Duration) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let target = server
    // rust: .to_socket_addrs()?
    // rust: .find(SocketAddr::is_ipv4)
    // rust: .ok_or_else(|| io::Error::new(io::ErrorKind::NotFound, "no IPv4 address"))?;
    // rust: let socket = UdpSocket::bind("0.0.0.0:0")?;
    // rust: socket.set_read_timeout(Some(timeout / 3))?;
    // rust: let mut id = [0u8; 12];
    // rust: crate::fill_random(&mut id)?;
    // rust: let mut buf = [0u8; 576];
    // rust: for _ in 0..3 {
    // rust: socket.send_to(&request(&id), target)?;
    // rust: loop {
    // rust: match socket.recv_from(&mut buf) {
    // rust: Ok((n, from)) if from == target => {
    // rust: if let Some(a) = parse_response(&buf[..n], &id) {
    // rust: return Ok(a);
}
}
    // rust: Ok(_) => {}
    // rust: Err(_) => break,
}
}
}
    // rust: Err(io::Error::new(io::ErrorKind::TimedOut, "no STUN answer"))
}

// The public IPv4 address from the first server that answers.
public_ip :: proc(servers: ^[string], timeout: Duration) -> O {
    // Ported from Horizon
    return {}
}
    // rust: servers
    // rust: .iter()
    // rust: .find_map(|s| query(s, timeout).ok())
    // rust: .map(|a| a.ip())
}

    // rust: pub(crate) mod tests {
//     use super::*;

    // A STUN server answering with XOR-MAPPED-ADDRESS = `answer`.
    // rust: pub(crate) fn mock(answer: SocketAddr) -> SocketAddr {
    // rust: let s = UdpSocket::bind("127.0.0.1:0").unwrap();
    // rust: let addr = s.local_addr().unwrap();
    // rust: std::thread::spawn(move || {
    // rust: let mut buf = [0u8; 576];
    // rust: while let Ok((n, from)) = s.recv_from(&mut buf) {
    // rust: if n < 20 {
    // rust: continue;
}
    // rust: let id: [u8; 12] = buf[8..20].try_into().unwrap();
    // rust: let _ = s.send_to(&response(&id, answer), from);
}
    // rust: });
    // rust: addr
}
    // rust: pub(crate) fn response(id: &[u8; 12], a: SocketAddr) -> Vec<u8> {
    // rust: let IpAddr::V4(ip) = a.ip() else { panic!() };
    // rust: let mut attr = vec![0x00, 0x20, 0x00, 0x08, 0x00, 0x01];
    // rust: attr.extend_from_slice(&(a.port() ^ (MAGIC >> 16) as u16).to_be_bytes());
    // rust: let o = ip.octets();
    // rust: let k = MAGIC.to_be_bytes();
    // rust: attr.extend((0..4).map(|i| o[i] ^ k[i]));
    // rust: let mut m = vec![0x01, 0x01];
    // rust: m.extend_from_slice(&(attr.len() as u16).to_be_bytes());
    // rust: m.extend_from_slice(&MAGIC.to_be_bytes());
    // rust: m.extend_from_slice(id);
    // rust: m.extend(attr);
    // rust: m
}

asks_and_reads_the_mapped_address :: proc() {
}
    // rust: let answer: SocketAddr = "203.0.113.9:40000".parse().unwrap();
    // rust: let server = mock(answer);
    // rust: assert_eq!(
    // rust: query(&server.to_string(), Duration::from_secs(2)).unwrap(),
    // rust: answer
    // rust: );
        // The first server that answers wins; dead ones are skipped.
    // rust: let dead = UdpSocket::bind("127.0.0.1:0")
    // rust: .unwrap()
    // rust: .local_addr()
    // rust: .unwrap()
    // rust: .to_string();
    // rust: assert_eq!(
    // rust: public_ip(&[dead, server.to_string()], Duration::from_millis(300)),
    // rust: Some(answer.ip())
    // rust: );
}

responses_are_checked :: proc() {
}
    // rust: let id = [7u8; 12];
    // rust: let a: SocketAddr = "198.51.100.4:1234".parse().unwrap();
    // rust: let good = response(&id, a);
    // rust: assert_eq!(parse_response(&good, &id), Some(a));
    // rust: assert_eq!(parse_response(&good, &[8u8; 12]), None);
    // rust: let mut error = good.clone();
    // rust: error[1] = 0x11;
    // rust: assert_eq!(parse_response(&error, &id), None);
    // rust: assert_eq!(parse_response(&good[..10], &id), None);
}

server_lists :: proc() {
}
    // rust: assert_eq!(parse_servers("none"), Vec::<String>::new());
    // rust: assert_eq!(parse_servers(" a:1 , b:2,"), vec!["a:1", "b:2"]);
}
}
