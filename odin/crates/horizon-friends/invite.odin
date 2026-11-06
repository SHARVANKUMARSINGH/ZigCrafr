//! Transpiled from Horizon Rust crate
package horizon_friends_invite

import "core:fmt"
import "core:mem"
import "core:math"

// The invite code that needs no server: the host's reachable endpoints and
// the session secret, in Crockford base32 groups with a checksum, e.g.
// `2A7KQ-M3XPD-...`. A guest dials the endpoints directly; when the host
// also uses a relay, the code carries the relay's address and the short
// code too, so the guest can fall back to it without any setting.
//
// Layout (bytes, then base32): version (2), secret (10), the direct port
// (u16), entries, then the first two bytes of SHA-256 over all of it.
// Entries: `0x04` IPv4 on the direct port, `0x05` IPv4 and its own port
// (a router mapping), `0x06`/`0x07` the same for IPv6, `0x10` a relay:
// address length, address, then the short code's 40 bits.
// use crate::code::{ALPHABET, Code, HALF};
// use sha2::{Digest, Sha256};
// use std::net::{IpAddr, Ipv4Addr, Ipv6Addr, SocketAddr};

VERSION :: 2
SECRET :: 10
// Endpoints a code carries at most.
MAX_ENDPOINTS :: 8
GROUP :: 5

// The relay a host also registered with: where, and its short code.
RelayRef :: struct {
    address: string,
    code: Code,
}

Invite :: struct {
    secret: [u8,
    // The host's direct socket: LAN, VPN and IPv6 addresses use this port.
    port: u16,
    endpoints: [dynamic]SocketAddr,
    relay: Maybe(RelayRef),
}
// The secret stays out of logs.
    // rust: impl std::fmt::Debug for Invite {
fmt :: proc(self: ^Self, f: ^std::fmt::Formatter<'_>) -> s {
    // Ported from Horizon
    return {}
}
    // rust: f.debug_struct("Invite")
    // rust: .field("port", &self.port)
    // rust: .field("endpoints", &self.endpoints)
    // rust: .field("relay", &self.relay.as_ref().map(|r| &r.address))
    // rust: .finish_non_exhaustive()
}
}

// What a player pasted.
Parsed :: enum {
    // Eight symbols: a relay's short code (needs that relay).
    Short(Code),
    Long(Invite),
}

// Why a code didn't parse, for the player.
CodeError :: enum {
    Characters,
    Typo,
    Version,
}
    // rust: impl std::fmt::Display for CodeError {
fmt :: proc(self: ^Self, f: ^std::fmt::Formatter<'_>) -> s {
    // Ported from Horizon
    return {}
}
    // rust: f.write_str(match self {
    // rust: Self::Characters => {
    // rust: "That isn't an invite code: codes are letters and digits in groups."
}
    // rust: Self::Typo => "The code has a typo: copy it again from your friend's message.",
    // rust: Self::Version => {
    // rust: "This invite comes from another version of Horizon. Update both games."
}
    // rust: })
}
}

symbol :: proc(c: char) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let c = match c.to_ascii_uppercase() {
    // rust: 'O' => '0',
    // rust: 'I' | 'L' => '1',
    // rust: c => c,
}
    // rust: ALPHABET
    // rust: .iter()
    // rust: .position(|&a| char::from(a) == c)
    // rust: .map(|i| i as u8)
}

encode32 :: proc(bytes: []u8) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = String::with_capacity(bytes.len() * 8 / 5 + 1);
    // rust: let (mut acc, mut bits) = (0u32, 0u32);
    // rust: for &b in bytes {
    // rust: acc = (acc << 8) | u32::from(b);
    // rust: bits += 8;
    // rust: while bits >= 5 {
    // rust: bits -= 5;
    // rust: out.push(char::from(ALPHABET[((acc >> bits) & 31) as usize]));
}
}
    // rust: if bits > 0 {
    // rust: out.push(char::from(ALPHABET[((acc << (5 - bits)) & 31) as usize]));
}
    // rust: out
}

decode32 :: proc(symbols: []u8) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = Vec::with_capacity(symbols.len() * 5 / 8);
    // rust: let (mut acc, mut bits) = (0u32, 0u32);
    // rust: for &v in symbols {
    // rust: acc = ((acc << 5) | u32::from(v)) & 0xFFFF;
    // rust: bits += 5;
    // rust: if bits >= 8 {
    // rust: bits -= 8;
    // rust: out.push((acc >> bits) as u8);
}
}
    // Padding bits must be zero (a canonical encoding).
    // rust: (acc & ((1 << bits) - 1) == 0).then_some(out)
}

checksum :: proc(bytes: []u8) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: let h = Sha256::digest(bytes);
    // rust: [h[0], h[1]]
}

// The 40 bits of a short code (20 per half).
short_bits :: proc(code: ^Code) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let mut v = 0u64;
    // rust: for c in code.nameplate.chars().chain(code.secret.chars()) {
    // rust: v = (v << 5) | u64::from(symbol(c)?);
}
    // rust: Some(v)
}
short_from_bits :: proc(v: u64) -> C {
    // Ported from Horizon
    return {}
}
    // rust: let s: String = (0..2 * HALF)
    // rust: .rev()
    // rust: .map(|i| char::from(ALPHABET[((v >> (5 * i)) & 31) as usize]))
    // rust: .collect();
    // rust: let (n, sec) = s.split_at(HALF);
    // rust: Code {
    // rust: nameplate: n.to_owned(),
    // rust: secret: sec.to_owned(),
}
}

    // rust: impl Invite {
    // A fresh secret from the OS random generator.
    // rust: pub fn new(
    // rust: port: u16,
    // rust: endpoints: Vec<SocketAddr>,
    // rust: relay: Option<RelayRef>,
    // rust: ) -> std::io::Result<Self> {
    // rust: let mut secret = [0u8; SECRET];
    // rust: crate::fill_random(&mut secret)?;
    // rust: Ok(Self {
    // rust: secret,
    // rust: port,
    // rust: endpoints,
    // rust: relay,
    // rust: })
}
    // The SPAKE2 password of direct sessions.
secret_text :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: encode32(&self.secret)
}
bytes :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut b = vec![VERSION];
    // rust: b.extend_from_slice(&self.secret);
    // rust: b.extend_from_slice(&self.port.to_be_bytes());
    // rust: for e in self.endpoints.iter().take(MAX_ENDPOINTS) {
    // rust: let own = e.port() != self.port;
    // rust: match e.ip() {
    // rust: IpAddr::V4(ip) => {
    // rust: b.push(if own { 0x05 } else { 0x04 });
    // rust: b.extend_from_slice(&ip.octets());
}
    // rust: IpAddr::V6(ip) => {
    // rust: b.push(if own { 0x07 } else { 0x06 });
    // rust: b.extend_from_slice(&ip.octets());
}
}
    // rust: if own {
    // rust: b.extend_from_slice(&e.port().to_be_bytes());
}
}
    // rust: if let Some(r) = &self.relay
    // rust: && let Some(bits) = short_bits(&r.code)
    // rust: && r.address.len() <= 255
    // rust: {
    // rust: b.push(0x10);
    // rust: b.push(r.address.len() as u8);
    // rust: b.extend_from_slice(r.address.as_bytes());
    // rust: b.extend_from_slice(&bits.to_be_bytes()[3..]);
}
    // rust: let sum = checksum(&b);
    // rust: b.extend_from_slice(&sum);
    // rust: b
}
    // The code to share, in groups of five.
encode :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let text = encode32(&self.bytes());
    // rust: text.as_bytes()
    // rust: .chunks(GROUP)
    // rust: .map(|c| std::str::from_utf8(c).unwrap())
    // rust: .collect::<Vec<_>>()
    // rust: .join("-")
}
decode :: proc(bytes: []u8) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if bytes.len() < 1 + SECRET + 2 + 2 {
    // rust: return Err(CodeError::Characters);
}
    // rust: let (body, sum) = bytes.split_at(bytes.len() - 2);
    // rust: if checksum(body) != sum {
    // rust: return Err(CodeError::Typo);
}
    // rust: if body[0] != VERSION {
    // rust: return Err(CodeError::Version);
}
    // rust: let mut secret = [0u8; SECRET];
    // rust: secret.copy_from_slice(&body[1..1 + SECRET]);
    // rust: let port = u16::from_be_bytes([body[1 + SECRET], body[2 + SECRET]]);
    // rust: let mut rest = &body[3 + SECRET..];
    // rust: let mut take = |n: usize| -> Result<&[u8], CodeError> {
    // rust: if rest.len() < n {
    // rust: return Err(CodeError::Version);
}
    // rust: let (a, b) = rest.split_at(n);
    // rust: rest = b;
    // rust: Ok(a)
}
    // rust: let mut endpoints = Vec::new();
    // rust: let mut relay = None;
    // rust: while let Ok(tag) = take(1) {
    // rust: let tag = tag[0];
    // rust: match tag {
    // rust: 0x04..=0x07 => {
    // rust: let ip = if tag < 0x06 {
    // rust: let o: [u8; 4] = take(4)?.try_into().unwrap();
    // rust: IpAddr::V4(Ipv4Addr::from(o))
    // rust: } else {
    // rust: let o: [u8; 16] = take(16)?.try_into().unwrap();
    // rust: IpAddr::V6(Ipv6Addr::from(o))
}
    // rust: let p = if tag & 1 == 1 {
    // rust: let p = take(2)?;
    // rust: u16::from_be_bytes([p[0], p[1]])
    // rust: } else {
    // rust: port
}
    // rust: endpoints.push(SocketAddr::new(ip, p));
}
    // rust: 0x10 => {
    // rust: let len = usize::from(take(1)?[0]);
    // rust: let address =
    // rust: String::from_utf8(take(len)?.to_vec()).map_err(|_| CodeError::Version)?;
    // rust: let b = take(5)?;
    // rust: let bits = b.iter().fold(0u64, |v, &x| (v << 8) | u64::from(x));
    // rust: relay = Some(RelayRef {
    // rust: address,
    // rust: code: short_from_bits(bits),
    // rust: });
}
    // rust: _ => return Err(CodeError::Version),
}
}
    // rust: Ok(Self {
    // rust: secret,
    // rust: port,
    // rust: endpoints,
    // rust: relay,
    // rust: })
}
}

// Read what a player pasted: a short relay code or a full invite.
parse_detailed :: proc(text: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let mut symbols = Vec::with_capacity(text.len());
    // rust: for c in text.chars() {
    // rust: if c.is_whitespace() || c == '-' {
    // rust: continue;
}
    // rust: symbols.push(symbol(c).ok_or(CodeError::Characters)?);
}
    // rust: if symbols.len() == 2 * HALF {
    // rust: let s: String = symbols
    // rust: .iter()
    // rust: .map(|&v| char::from(ALPHABET[v as usize]))
    // rust: .collect();
    // rust: return Code::parse(&s)
    // rust: .map(Parsed::Short)
    // rust: .ok_or(CodeError::Characters);
}
    // rust: let bytes = decode32(&symbols).ok_or(CodeError::Typo)?;
    // rust: Invite::decode(&bytes).map(Parsed::Long)
}
parse :: proc(text: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: parse_detailed(text).ok()
}

    // rust: mod tests {
//     use super::*;

sample :: proc() -> I {
    // Ported from Horizon
    return {}
}
    // rust: Invite {
    // rust: secret: *b"0123456789",
    // rust: port: 25580,
    // rust: endpoints: vec![
    // rust: "203.0.113.5:41234".parse().unwrap(),
    // rust: "192.168.1.20:25580".parse().unwrap(),
    // rust: "100.72.51.8:25580".parse().unwrap(),
    // rust: "[2001:db8::20]:25580".parse().unwrap(),
    // rust: ],
    // rust: relay: None,
}
}

base32_round_trips :: proc() {
}
    // rust: for n in 0..40 {
    // rust: let bytes: Vec<u8> = (0..n).map(|i| (i * 37 + 11) as u8).collect();
    // rust: let text = encode32(&bytes);
    // rust: let symbols: Vec<u8> = text.chars().map(|c| symbol(c).unwrap()).collect();
    // rust: assert_eq!(decode32(&symbols).unwrap(), bytes);
}
}

codes_round_trip_and_stay_pasteable :: proc() {
}
    // rust: let invite = sample();
    // rust: let code = invite.encode();
    // rust: assert!(
    // rust: code.split('-')
    // rust: .all(|g| g.len() <= GROUP && g.chars().all(|c| ALPHABET.contains(&(c as u8))))
    // rust: );
        // A home with a router mapping, a LAN, a tailnet and IPv6: 79 symbols
        // in 16 groups; without IPv6, 52.
    // rust: assert_eq!(code.replace('-', "").len(), 79, "{code}");
    // rust: let mut v4 = invite.clone();
    // rust: v4.endpoints.pop();
    // rust: assert_eq!(v4.encode().replace('-', "").len(), 52);
    // rust: assert_eq!(parse(&code), Some(Parsed::Long(invite.clone())));
        // Case, spaces and look-alike letters don't matter.
    // rust: let sloppy = code.to_lowercase().replace('-', " ").replace('0', "o");
    // rust: assert_eq!(parse(&sloppy), Some(Parsed::Long(invite)));
}

a_relay_rides_along :: proc() {
}
    // rust: let mut invite = sample();
    // rust: invite.relay = Some(RelayRef {
    // rust: address: "relay.example.org:7000".into(),
    // rust: code: Code::parse("K7QM-3XPD").unwrap(),
    // rust: });
    // rust: let Some(Parsed::Long(back)) = parse(&invite.encode()) else {
    // rust: panic!()
}
    // rust: assert_eq!(back.relay, invite.relay);
    // rust: assert_eq!(back.endpoints, invite.endpoints);
}

typos_are_caught :: proc() {
}
    // rust: let code = sample().encode();
    // rust: let mut caught = 0;
    // rust: let symbols: Vec<char> = code.chars().collect();
    // rust: for i in (0..symbols.len()).filter(|&i| symbols[i] != '-') {
    // rust: let mut changed = symbols.clone();
    // rust: changed[i] = if changed[i] == 'Z' { 'Y' } else { 'Z' };
    // rust: let text: String = changed.into_iter().collect();
    // rust: if parse_detailed(&text).is_err() {
    // rust: caught += 1;
}
}
        // Every single-symbol change is refused (the checksum misses one in 65536).
    // rust: assert_eq!(caught, symbols.iter().filter(|&&c| c != '-').count());
        // A dropped group too.
    // rust: let shorter: String = code.split('-').skip(1).collect::<Vec<_>>().join("-");
    // rust: assert!(parse(&shorter).is_none());
}

short_codes_and_garbage :: proc() {
}
    // rust: assert_eq!(
    // rust: parse("k7qm-3xpd"),
    // rust: Some(Parsed::Short(Code::parse("K7QM-3XPD").unwrap()))
    // rust: );
    // rust: assert_eq!(parse_detailed("hello world!"), Err(CodeError::Characters));
    // rust: assert!(parse("").is_none());
        // Another version is told apart from a typo.
    // rust: let mut b = sample().bytes();
    // rust: b[0] = 3;
    // rust: let n = b.len() - 2;
    // rust: let sum = checksum(&b[..n]);
    // rust: b[n..].copy_from_slice(&sum);
    // rust: assert_eq!(parse_detailed(&encode32(&b)), Err(CodeError::Version));
}

debug_hides_the_secret :: proc() {
}
    // rust: assert!(!format!("{:?}", sample()).contains("0123456789"));
}
}
