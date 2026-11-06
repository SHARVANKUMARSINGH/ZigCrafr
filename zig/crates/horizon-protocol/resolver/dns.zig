//! Transpiled from Horizon Rust crate
//! Module: horizon-protocol_dns
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The SRV question as JNDI's DNS client asks it: the system's name servers in
//! turn, one UDP try of 1 s (`com.sun.jndi.dns.timeout.retries` = 1), TCP when
//! the reply is truncated, and the answer's first SRV record. By hand, so the
//! game needs no async runtime or resolver library for one question.
// use std::{
    // rust: io::{Read, Write},
    // rust: net::{SocketAddr, TcpStream, UdpSocket},
    // rust: time::Duration,
}

pub const TYPE_SRV: u16 = 33;
/// JNDI's `com.sun.jndi.dns.timeout.initial`, per name server.
    // rust: pub(super) const SERVER_TIMEOUT: Duration = Duration::from_secs(1);

/// JNDI reads them from resolv.conf on Unix and from the network adapters on
/// Windows, where it leaves out the scoped IPv6 ones.
    // rust: pub(super) fn system_name_servers() -> Vec<SocketAddr> {
    // rust: std::fs::read_to_string("/etc/resolv.conf")
    // rust: .map_or_else(|_| Vec::new(), |conf| name_servers(&conf))
}

    // rust: pub(super) fn system_name_servers() -> Vec<SocketAddr> {
    // rust: let mut servers = Vec::new();
    // rust: for adapter in ipconfig::get_adapters().unwrap_or_default() {
    // rust: if adapter.oper_status() != ipconfig::OperStatus::IfOperStatusUp {
    // rust: continue;
}
    // rust: for &ip in adapter.dns_servers().iter().filter(|ip| !scoped(**ip)) {
    // rust: let server = SocketAddr::new(ip, 53);
    // rust: if !servers.contains(&server) {
    // rust: servers.push(server);
}
}
}
    // rust: servers
}

    // rust: pub(super) fn system_name_servers() -> Vec<SocketAddr> {
    // rust: Vec::new()
}

/// Link-local and site-local IPv6 addresses (such as Windows' `fec0:0:0:ffff::1`
/// defaults), which only work with a scope the adapter's list doesn't carry.
pub fn scoped(ip: std::net::IpAddr) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: matches!(ip, std::net::IpAddr::V6(v6) if matches!(v6.segments()[0] & 0xffc0, 0xfe80 | 0xfec0))
}

/// `nameserver` lines of resolv.conf, in order.
pub fn name_servers(conf: []const u8) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: conf.lines()
    // rust: .filter_map(|line| line.strip_prefix("nameserver"))
    // rust: .filter_map(|rest| rest.split_whitespace().next())
    // rust: .filter_map(|ip| ip.split('%').next()?.parse::<std::net::IpAddr>().ok())
    // rust: .map(|ip| SocketAddr::new(ip, 53))
    // rust: .collect()
}

pub const Reply = enum {
    /// The server answered: the first SRV record, if any.
    Answer(Option<(String, u16)>),
    Truncated,
    /// No reply, a server failure or a malformed reply: ask the next server.
    Unusable,
};

    // rust: pub(super) fn query_srv(
    // rust: name: &str,
    // rust: servers: &[SocketAddr],
    // rust: timeout: Duration,
    // rust: ) -> Option<(String, u16)> {
    // rust: let mut id = [0; 2];
    // rust: getrandom::fill(&mut id).ok()?;
    // rust: let id = u16::from_be_bytes(id);
    // rust: let query = encode_query(id, name)?;
    // rust: for &server in servers {
    // rust: let reply = match ask_udp(server, &query, timeout).map(|reply| parse_reply(id, &reply)) {
    // rust: Some(Reply::Truncated) => ask_tcp(server, &query, timeout)
    // rust: .map_or(Reply::Unusable, |reply| parse_reply(id, &reply)),
    // rust: reply => reply.unwrap_or(Reply::Unusable),
}
    // rust: if let Reply::Answer(srv) = reply {
    // rust: return srv;
}
}
    // rust: None
}

pub fn ask_udp(server: SocketAddr, query: []const u8, timeout: Duration) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let local: SocketAddr = if server.is_ipv4() {
    // rust: ([0, 0, 0, 0], 0).into()
    // rust: } else {
    // rust: ([0u16; 8], 0).into()
}
    // rust: let socket = UdpSocket::bind(local).ok()?;
    // rust: socket.set_read_timeout(Some(timeout)).ok()?;
    // rust: socket.connect(server).ok()?;
    // rust: socket.send(query).ok()?;
    // rust: let mut buf = vec![0; 512];
    // rust: let len = socket.recv(&mut buf).ok()?;
    // rust: buf.truncate(len);
    // rust: Some(buf)
}

pub fn ask_tcp(server: SocketAddr, query: []const u8, timeout: Duration) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut stream = TcpStream::connect_timeout(&server, timeout).ok()?;
    // rust: stream.set_read_timeout(Some(timeout)).ok()?;
    // rust: let mut framed = (query.len() as u16).to_be_bytes().to_vec();
    // rust: framed.extend_from_slice(query);
    // rust: stream.write_all(&framed).ok()?;
    // rust: let mut len = [0; 2];
    // rust: stream.read_exact(&mut len).ok()?;
    // rust: let mut buf = vec![0; u16::from_be_bytes(len) as usize];
    // rust: stream.read_exact(&mut buf).ok()?;
    // rust: Some(buf)
}

/// A recursive SRV question (RFC 1035 §4.1) for an absolute name.
pub fn encode_query(id: u16, name: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut msg = Vec::with_capacity(18 + name.len());
    // rust: msg.extend_from_slice(&id.to_be_bytes());
    // rust: msg.extend_from_slice(&[0x01, 0x00, 0, 1, 0, 0, 0, 0, 0, 0]); // RD; one question
    // rust: for label in name.trim_end_matches('.').split('.') {
    // rust: if label.is_empty() || label.len() > 63 {
    // rust: return None;
}
    // rust: msg.push(label.len() as u8);
    // rust: msg.extend_from_slice(label.as_bytes());
}
    // rust: msg.push(0);
    // rust: if msg.len() - 12 > 255 {
    // rust: return None;
}
    // rust: msg.extend_from_slice(&TYPE_SRV.to_be_bytes());
    // rust: msg.extend_from_slice(&1u16.to_be_bytes()); // IN
    // rust: Some(msg)
}

pub fn parse_reply(id: u16, msg: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: parse_answer(id, msg).unwrap_or(Reply::Unusable)
}

pub fn parse_answer(id: u16, msg: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let u16_at = |at: usize| Some(u16::from_be_bytes([*msg.get(at)?, *msg.get(at + 1)?]));
    // rust: let flags = u16_at(2)?;
    // rust: if u16_at(0)? != id || flags & 0x8000 == 0 {
    // rust: return None;
}
    // rust: if flags & 0x0200 != 0 {
    // rust: return Some(Reply::Truncated);
}
    // rust: match flags & 0xf {
    // rust: 0 => {}
    // rust: 3 => return Some(Reply::Answer(None)), // NXDOMAIN
    // rust: _ => return None,
}
    // rust: let mut at = 12;
    // rust: for _ in 0..u16_at(4)? {
    // rust: at = read_name(msg, at)?.1 + 4;
}
    // rust: for _ in 0..u16_at(6)? {
    // rust: at = read_name(msg, at)?.1;
    // rust: let (kind, len) = (u16_at(at)?, u16_at(at + 8)? as usize);
    // rust: let data = at + 10;
    // rust: msg.get(data..data + len)?;
    // rust: if kind == TYPE_SRV && len >= 7 {
    // rust: let (target, _) = read_name(msg, data + 6)?;
    // rust: return Some(Reply::Answer(Some((target, u16_at(data + 4)?))));
}
    // rust: at = data + len;
}
    // rust: Some(Reply::Answer(None))
}

/// The name at `at`, absolute (`a.b.`), and where the record continues.
pub fn read_name(msg: []const u8, mut at: usize) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut name = String::new();
    // rust: let mut end = None;
    // Pointers must go backwards; the bound ends a loop of labels and pointers.
    // rust: for _ in 0..128 {
    // rust: let len = *msg.get(at)? as usize;
    // rust: match len {
    // rust: 0 => {
    // rust: if name.is_empty() {
    // rust: name.push('.');
}
    // rust: return Some((name, end.unwrap_or(at + 1)));
}
    // rust: 0xc0.. => {
    // rust: let target = (len & 0x3f) << 8 | *msg.get(at + 1)? as usize;
    // rust: if target >= at {
    // rust: return None;
}
    // rust: end.get_or_insert(at + 2);
    // rust: at = target;
}
    // rust: 1..=63 => {
    // rust: let label = msg.get(at + 1..at + 1 + len)?;
    // rust: name.push_str(std::str::from_utf8(label).ok()?);
    // rust: name.push('.');
    // rust: at += 1 + len;
}
    // rust: _ => return None,
}
}
    // rust: None
}

    // rust: mod tests {
//     use super::*;

pub const NAME: []const u8 = "_minecraft._tcp.play.example.org.";

    /// The reply a server gives to `query`: its question, then a CNAME and the
    /// SRV records, each owner name compressed to the question's name.
pub fn reply(query: []const u8, rcode: u8, records: *[(u16) void {
}
    // rust: let mut msg = query.to_vec();
    // rust: msg[2] |= 0x80;
    // rust: msg[3] = 0x80 | rcode;
    // rust: let answers = records.len() as u16 + u16::from(!records.is_empty());
    // rust: msg[6..8].copy_from_slice(&answers.to_be_bytes());
    // rust: if !records.is_empty() {
            // CNAME first: the parser must step over records of other types.
    // rust: msg.extend_from_slice(&[0xc0, 12, 0, 5, 0, 1, 0, 0, 0, 60, 0, 2, 0xc0, 12]);
}
    // rust: for &(port, target) in records {
    // rust: let mut rdata = vec![0, 1, 0, 1];
    // rust: rdata.extend_from_slice(&port.to_be_bytes());
    // rust: for label in target.trim_end_matches('.').split('.') {
    // rust: rdata.push(label.len() as u8);
    // rust: rdata.extend_from_slice(label.as_bytes());
}
    // rust: rdata.push(0);
    // rust: msg.extend_from_slice(&[0xc0, 12, 0, 33, 0, 1, 0, 0, 0, 60]);
    // rust: msg.extend_from_slice(&(rdata.len() as u16).to_be_bytes());
    // rust: msg.extend_from_slice(&rdata);
}
    // rust: msg
}

pub fn answer(msg: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match parse_reply(7, msg) {
    // rust: Reply::Answer(srv) => Some(srv),
    // rust: _ => None,
}
}

pub fn query_is_a_recursive_srv_question() void {
}
    // rust: let query = encode_query(0x1234, NAME).unwrap();
    // rust: let mut expected = vec![0x12, 0x34, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0];
    // rust: expected.extend_from_slice(b"\x0a_minecraft\x04_tcp\x04play\x07example\x03org\x00");
    // rust: expected.extend_from_slice(&[0, 33, 0, 1]);
    // rust: assert_eq!(query, expected);
    // rust: assert!(encode_query(1, "a..b.").is_none());
    // rust: assert!(encode_query(1, &format!("{}.org.", "a".repeat(64))).is_none());
}

pub fn first_srv_record_of_the_answer_wins() void {
}
    // rust: let query = encode_query(7, NAME).unwrap();
    // rust: let msg = reply(
    // rust: &query,
    // rust: 0,
    // rust: &[(25570, "a.example.org."), (25571, "b.example.org.")],
    // rust: );
    // rust: assert_eq!(answer(&msg), Some(Some(("a.example.org.".into(), 25570))));
}

pub fn empty_answer_and_nxdomain_mean_no_redirect() void {
}
    // rust: let query = encode_query(7, NAME).unwrap();
    // rust: assert_eq!(answer(&reply(&query, 0, &[])), Some(None));
    // rust: assert_eq!(answer(&reply(&query, 3, &[])), Some(None));
}

pub fn server_failures_and_bad_replies_ask_the_next_server() void {
}
    // rust: let query = encode_query(7, NAME).unwrap();
    // rust: let good = reply(&query, 0, &[(25570, "a.example.org.")]);
    // rust: assert!(matches!(
    // rust: parse_reply(7, &reply(&query, 2, &[])),
    // rust: Reply::Unusable
    // rust: ));
    // rust: assert!(matches!(parse_reply(8, &good), Reply::Unusable)); // another id
    // rust: assert!(matches!(parse_reply(7, &query), Reply::Unusable)); // not a response
    // rust: for cut in 0..good.len() {
    // rust: assert!(matches!(parse_reply(7, &good[..cut]), Reply::Unusable));
}
    // rust: let mut forward = good.clone();
    // rust: let at = query.len(); // the first answer's owner pointer
    // rust: assert_eq!(forward[at..at + 2], [0xc0, 12]);
    // rust: forward[at + 1] = 0xff; // a pointer forwards
    // rust: assert!(matches!(parse_reply(7, &forward), Reply::Unusable));
    // rust: let mut truncated = good;
    // rust: truncated[2] |= 0x02;
    // rust: assert!(matches!(parse_reply(7, &truncated), Reply::Truncated));
}

pub fn resolv_conf_name_servers_in_order() void {
}
    // rust: let conf = "# generated\nsearch lan\nnameserver 192.168.1.1\nnameserver fe80::1%en0\n\
    // rust: nameserver  ::1 \nnameserver bogus\noptions ndots:1\n";
    // rust: let servers: Vec<String> = name_servers(conf).iter().map(|s| s.to_string()).collect();
    // rust: assert_eq!(servers, ["192.168.1.1:53", "[fe80::1]:53", "[::1]:53"]);
}

pub fn windows_skips_scoped_ipv6_name_servers() void {
}
    // rust: let ip = |s: &str| s.parse::<std::net::IpAddr>().unwrap();
    // rust: for s in ["fe80::1", "fec0:0:0:ffff::1", "febf::1"] {
    // rust: assert!(scoped(ip(s)), "{s}");
}
    // rust: for s in ["1.1.1.1", "2606:4700:4700::1111", "::1", "fc00::1"] {
    // rust: assert!(!scoped(ip(s)), "{s}");
}
}

    /// A local name server: a silent one first, then one that answers truncated
    /// over UDP and in full over TCP, like a real server with a big answer.
pub fn asks_each_server_in_turn_and_retries_truncated_replies_over_tcp() void {
}
    // rust: let silent = UdpSocket::bind("127.0.0.1:0").unwrap();
    // rust: let (udp, tcp) = loop {
    // rust: let udp = UdpSocket::bind("127.0.0.1:0").unwrap();
    // rust: if let Ok(tcp) = std::net::TcpListener::bind(udp.local_addr().unwrap()) {
    // rust: break (udp, tcp);
}
}
    // rust: let servers = [silent.local_addr().unwrap(), udp.local_addr().unwrap()];
    // rust: let server = std::thread::spawn(move || {
    // rust: let mut buf = [0; 512];
    // rust: let (len, from) = udp.recv_from(&mut buf).unwrap();
    // rust: let mut truncated = reply(&buf[..len], 0, &[]);
    // rust: truncated[2] |= 0x02;
    // rust: udp.send_to(&truncated, from).unwrap();
    // rust: let (mut stream, _) = tcp.accept().unwrap();
    // rust: let mut len = [0; 2];
    // rust: stream.read_exact(&mut len).unwrap();
    // rust: let mut query = vec![0; u16::from_be_bytes(len) as usize];
    // rust: stream.read_exact(&mut query).unwrap();
    // rust: let full = reply(&query, 0, &[(25570, "backend.example.org.")]);
    // rust: stream
    // rust: .write_all(&(full.len() as u16).to_be_bytes())
    // rust: .unwrap();
    // rust: stream.write_all(&full).unwrap();
    // rust: });
    // rust: let srv = query_srv(NAME, &servers, Duration::from_millis(200));
    // rust: server.join().unwrap();
    // rust: assert_eq!(srv, Some(("backend.example.org.".into(), 25570)));
}
}
