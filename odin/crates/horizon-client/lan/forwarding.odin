//! Transpiled from Horizon Rust crate
package horizon_client_forwarding

import "core:fmt"
import "core:mem"
import "core:math"

// Velocity "modern" player information forwarding for a dedicated server behind a proxy.
//
// The proxy authenticates the player and the server (`online-mode=false`) trusts what it forwards. Written
// from the behaviour of a real Velocity 4.3.1, not from any other project's source: the exchange was recorded
// with a stand-in backend and is described in docs/velocity-forwarding.md.
//
// The server asks on [`CHANNEL`] with one byte, the highest forwarding version it understands. The proxy
// answers with a 32-byte HMAC-SHA256 signature followed by the signed data, made with the secret both sides
// share: `version` (VarInt), the player's `address` (string), `uuid` (16 bytes), `name` (string) and the
// profile `properties` (VarInt count; each a name, a value, a bool and the signature string when it is set).

// use horizon_protocol::{buf::Reader, packets::login};
// use sha2::{Digest, Sha256};
// use std::net::IpAddr;

// The login plugin channel the proxy answers on.
CHANNEL :: "velocity:player_info"

// The version asked for and the only one accepted: address, UUID, name and properties.
VERSION :: 1

// What the proxy vouches for.
Forwarded :: struct {
    address: IpAddr,
    uuid: u128,
    name: string,
    properties: [dynamic]login::Property,
}

// The request's data: the highest version this server reads.
request :: proc() -> V {
    // Ported from Horizon
    return {}
}
    // rust: vec![VERSION]
}

// Checks the proxy's answer against the shared `secret` and reads what it forwards.
verify :: proc(secret: []u8, payload: []u8) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if payload.len() < 32 {
    // rust: return Err("the forwarded data is too short".into());
}
    // rust: let (signature, data) = payload.split_at(32);
    // rust: if !equal(&hmac_sha256(secret, data), signature) {
    // rust: return Err("the forwarded data is not signed with this server's secret".into());
}
    // rust: let bad = |e: horizon_protocol::Error| format!("the forwarded data is damaged: {e}");
    // rust: let mut r = Reader::new(data);
    // rust: let version = r.varint().map_err(bad)?;
    // rust: if version != i32::from(VERSION) {
    // rust: return Err(format!(
    // rust: "the proxy forwarded version {version}, not {VERSION}"
    // rust: ));
}
    // rust: let address = r.string(64).map_err(bad)?;
    // rust: let address: IpAddr = address
    // rust: .parse()
    // rust: .map_err(|_| format!("the forwarded address {address:?} is not an IP address"))?;
    // rust: let uuid = r.uuid().map_err(bad)?;
    // rust: let name = r.string(16).map_err(bad)?;
    // rust: let count = r.count(64).map_err(bad)?;
    // rust: let mut properties = Vec::with_capacity(count);
    // rust: for _ in 0..count {
    // rust: let name = r.string(64).map_err(bad)?;
    // rust: let value = r.string(32767).map_err(bad)?;
    // rust: let signature = if r.bool().map_err(bad)? {
    // rust: Some(r.string(1024).map_err(bad)?)
    // rust: } else {
    // rust: None
}
    // rust: properties.push(login::Property {
    // rust: name,
    // rust: value,
    // rust: signature,
    // rust: });
}
    // rust: if r.remaining() != 0 {
    // rust: return Err("the forwarded data has trailing bytes".into());
}
    // rust: Ok(Forwarded {
    // rust: address,
    // rust: uuid,
    // rust: name,
    // rust: properties,
    // rust: })
}

// HMAC-SHA256 (RFC 2104).
hmac_sha256 :: proc(key: []u8, data: []u8) -> [ {
    // Ported from Horizon
    return {}
}
BLOCK :: 64
    // rust: let mut padded = [0u8; BLOCK];
    // rust: if key.len() > BLOCK {
    // rust: padded[..32].copy_from_slice(&Sha256::digest(key));
    // rust: } else {
    // rust: padded[..key.len()].copy_from_slice(key);
}
    // rust: let inner = Sha256::new()
    // rust: .chain_update(padded.map(|b| b ^ 0x36))
    // rust: .chain_update(data)
    // rust: .finalize();
    // rust: Sha256::new()
    // rust: .chain_update(padded.map(|b| b ^ 0x5c))
    // rust: .chain_update(inner)
    // rust: .finalize()
    // rust: .into()
}

// Compares without stopping at the first difference, so the time says nothing about the signature.
equal :: proc(a: []u8, b: []u8) -> b {
    // Ported from Horizon
    return {}
}
    // rust: a.len() == b.len() && a.iter().zip(b).fold(0u8, |acc, (x, y)| acc | (x ^ y)) == 0
}

    // rust: mod tests {
//     use super::*;
//     use horizon_protocol::buf::Writer;

hex :: proc(s: string) -> V {
    // Ported from Horizon
    return {}
}
    // rust: (0..s.len())
    // rust: .step_by(2)
    // rust: .map(|i| u8::from_str_radix(&s[i..i + 2], 16).unwrap())
    // rust: .collect()
}

hmac_matches_the_rfc_4231_vectors :: proc() {
}
    // rust: assert_eq!(
    // rust: hmac_sha256(&[0x0b; 20], b"Hi There").to_vec(),
    // rust: hex("b0344c61d8db38535ca8afceaf0bf12b881dc200c9833da726e9376c2e32cff7")
    // rust: );
    // rust: assert_eq!(
    // rust: hmac_sha256(b"Jefe", b"what do ya want for nothing?").to_vec(),
    // rust: hex("5bdcc146bf60754e6a042426089575c75a003f089d2739839dec58b964ec3843")
    // rust: );
        // A key longer than the block is hashed first (RFC 4231 test case 6).
    // rust: assert_eq!(
    // rust: hmac_sha256(
    // rust: &[0xaa; 131],
    // rust: b"Test Using Larger Than Block-Size Key - Hash Key First"
    // rust: )
    // rust: .to_vec(),
    // rust: hex("60e431591ee0b67f0d8a26aacbf5b77f8e0bc6213728c5140546040f0ee37f54")
    // rust: );
}

    // What a Velocity 4.3.1 proxy answered to `request()` for a player named Tester, recorded with a
    // stand-in backend and the throwaway secret below.
SECRET :: b"ISWncFxltwFE"
RECORDED :: "189e73f57e7fe3d387de5f252fc0226e8288e5b15f23ee12924b34cf216b7f6901093132372e302e302e31f3d28cb072253cb1baeb2dadd2be89ae0654657374657200"

a_recorded_answer_is_read :: proc() {
}
    // rust: let got = verify(SECRET, &hex(RECORDED)).unwrap();
    // rust: assert_eq!(got.address, "127.0.0.1".parse::<IpAddr>().unwrap());
    // rust: assert_eq!(got.uuid, 0xf3d28cb0_7225_3cb1_baeb_2dadd2be89ae);
    // rust: assert_eq!(got.name, "Tester");
    // rust: assert!(got.properties.is_empty());
}

another_secret_or_a_changed_byte_is_refused :: proc() {
}
    // rust: let mut payload = hex(RECORDED);
    // rust: assert!(verify(b"not the secret", &payload).is_err());
    // rust: *payload.last_mut().unwrap() ^= 1;
    // rust: assert!(verify(SECRET, &payload).unwrap_err().contains("not signed"));
    // rust: assert!(verify(SECRET, &payload[..10]).is_err());
}

    // Signs `data` the way the proxy does, for the cases the recording doesn't cover.
signed :: proc(data: ^Writer) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = hmac_sha256(SECRET, &data.data).to_vec();
    // rust: out.extend_from_slice(&data.data);
    // rust: out
}

    // rust: fn body(
    // rust: version: i32,
    // rust: address: &str,
    // rust: name: &str,
    // rust: properties: &[(&str, &str, Option<&str>)],
    // rust: ) -> Writer {
    // rust: let mut w = Writer::new();
    // rust: w.varint(version);
    // rust: w.string(address);
    // rust: w.uuid(7);
    // rust: w.string(name);
    // rust: w.varint(properties.len() as i32);
    // rust: for (key, value, signature) in properties {
    // rust: w.string(key);
    // rust: w.string(value);
    // rust: w.bool(signature.is_some());
    // rust: if let Some(signature) = signature {
    // rust: w.string(signature);
}
}
    // rust: w
}

properties_are_read_with_and_without_a_signature :: proc() {
}
    // rust: let w = body(
    // rust: 1,
    // rust: "::1",
    // rust: "Alex",
    // rust: &[("textures", "abc", Some("sig")), ("extra", "x", None)],
    // rust: );
    // rust: let got = verify(SECRET, &signed(&w)).unwrap();
    // rust: assert_eq!(got.address, "::1".parse::<IpAddr>().unwrap());
    // rust: assert_eq!(got.properties.len(), 2);
    // rust: assert_eq!(got.properties[0].signature.as_deref(), Some("sig"));
    // rust: assert_eq!(got.properties[1].signature, None);
}

other_versions_and_bad_data_are_refused :: proc() {
}
    // rust: assert!(verify(SECRET, &signed(&body(4, "127.0.0.1", "A", &[]))).is_err());
    // rust: assert!(verify(SECRET, &signed(&body(1, "localhost", "A", &[]))).is_err());
    // rust: assert!(
    // rust: verify(
    // rust: SECRET,
    // rust: &signed(&body(1, "127.0.0.1", "much too long a name", &[]))
    // rust: )
    // rust: .is_err()
    // rust: );
    // rust: let mut w = body(1, "127.0.0.1", "A", &[]);
    // rust: w.u8(0);
    // rust: assert!(
    // rust: verify(SECRET, &signed(&w))
    // rust: .unwrap_err()
    // rust: .contains("trailing")
    // rust: );
}
}
