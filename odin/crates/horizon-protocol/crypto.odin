//! Transpiled from Horizon Rust crate
package horizon_protocol_crypto

import "core:fmt"
import "core:mem"
import "core:math"

// Connection encryption (Crypt.getCipher: AES/CFB8/NoPadding with the shared
// secret as key and IV) and MD5 name-based UUIDs for offline-mode profiles
// (UUIDUtil.createOfflinePlayerUUID), the online-mode server hash
// (Crypt.digestData) and the shared secret. Only the AES forward cipher is
// needed: CFB8 encrypts the shift register in both directions.
// use sha1::{Digest, Sha1};

    // rust: mod blocks;
    // rust: pub use blocks::Blocks as Aes128;
// use blocks::LANES;

// AES/CFB8 stream state for one direction of a connection.
Cfb8 :: struct {
    aes: Aes128,
    // The last 16 ciphertext bytes (the IV before any).
    register: [u8,
}
    // rust: impl Cfb8 {
    // Minecraft uses the 16-byte shared secret as both key and IV.
new :: proc(key: ^[u8; 16], iv: ^[u8; 16]) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: aes: Aes128::new(key),
    // rust: register: *iv,
}
}
    // Each byte's keystream is the encrypted register, which holds the
    // ciphertext before it: encryption goes one byte at a time.
encrypt :: proc(self: ^Self, data: []u8) {
}
    // rust: self.aes.cfb8_encrypt(&mut self.register, data);
}
    // Decryption knows every ciphertext byte up front, so the registers of
    // [`LANES`] bytes in a row are known together and encrypted at once.
decrypt :: proc(self: ^Self, data: []u8) {
}
    // rust: for run in data.chunks_mut(LANES) {
            // The register, then this run's ciphertext: byte i's register
            // is window[i..i + 16].
    // rust: let mut window = [0u8; 16 + LANES];
    // rust: window[..16].copy_from_slice(&self.register);
    // rust: window[16..16 + run.len()].copy_from_slice(run);
    // rust: let mut blocks: [[u8; 16]; LANES] =
    // rust: std::array::from_fn(|i| window[i..i + 16].try_into().unwrap());
    // rust: self.aes.encrypt_lanes(&mut blocks);
    // rust: for (b, k) in run.iter_mut().zip(&blocks) {
    // rust: *b ^= k[0];
}
    // rust: self.register
    // rust: .copy_from_slice(&window[run.len()..run.len() + 16]);
}
}
}

// Fill `out` with the operating system's cryptographic randomness.
random_bytes :: proc(out: []u8) -> c {
    // Ported from Horizon
    return {}
}
    // rust: getrandom::fill(out).map_err(|e| crate::Error::new(format!("No secure random source: {e}")))
}

// Crypt.generateSecretKey: a random AES-128 key, the connection's shared secret.
generate_secret :: proc() -> c {
    // Ported from Horizon
    return {}
}
    // rust: let mut key = [0u8; 16];
    // rust: random_bytes(&mut key)?;
    // rust: Ok(key)
}

// `new BigInteger(digest).toString(16)`: the digest read as a signed
// two's-complement number, in lowercase hex without leading zeros.
java_hex_digest :: proc(digest: []u8) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let negative = digest.first().is_some_and(|b| b & 0x80 != 0);
    // rust: let mut magnitude = digest.to_vec();
    // rust: if negative {
        // Two's complement: invert and add one.
    // rust: let mut carry = true;
    // rust: for b in magnitude.iter_mut().rev() {
    // rust: *b = !*b;
    // rust: if carry {
    // rust: let (v, c) = b.overflowing_add(1);
    // rust: *b = v;
    // rust: carry = c;
}
}
}
    // rust: let hex: String = magnitude.iter().map(|b| format!("{b:02x}")).collect();
    // rust: let hex = hex.trim_start_matches('0');
    // rust: let hex = if hex.is_empty() { "0" } else { hex };
    // rust: if negative {
    // rust: format!("-{hex}")
    // rust: } else {
    // rust: hex.to_owned()
}
}

// The server id sent to the session service when joining an online-mode
// server: SHA-1 over the server id (ISO-8859-1), the shared secret and the
// server's encoded public key, as a signed hex number.
server_hash :: proc(server_id: string, secret: []u8, public_key: []u8) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut sha = Sha1::new();
    // ISO-8859-1: characters above U+00FF become '?' like String.getBytes.
    // rust: let latin1: Vec<u8> = server_id
    // rust: .chars()
    // rust: .map(|c| u8::try_from(u32::from(c)).unwrap_or(b'?'))
    // rust: .collect();
    // rust: sha.update(&latin1);
    // rust: sha.update(secret);
    // rust: sha.update(public_key);
    // rust: java_hex_digest(&sha.finalize())
}

// MD5 (RFC 1321).
md5 :: proc(input: []u8) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: const S: [u32; 64] = [
    // rust: 7, 12, 17, 22, 7, 12, 17, 22, 7, 12, 17, 22, 7, 12, 17, 22, 5, 9, 14, 20, 5, 9, 14, 20, 5,
    // rust: 9, 14, 20, 5, 9, 14, 20, 4, 11, 16, 23, 4, 11, 16, 23, 4, 11, 16, 23, 4, 11, 16, 23, 6, 10,
    // rust: 15, 21, 6, 10, 15, 21, 6, 10, 15, 21, 6, 10, 15, 21,
    // rust: ];
    // rust: let k: Vec<u32> = (0..64)
    // rust: .map(|i| ((i as f64 + 1.0).sin().abs() * 4_294_967_296.0) as u32)
    // rust: .collect();
    // rust: let (mut a0, mut b0, mut c0, mut d0) = (
    // rust: 0x6745_2301u32,
    // rust: 0xefcd_ab89u32,
    // rust: 0x98ba_dcfeu32,
    // rust: 0x1032_5476u32,
    // rust: );
    // rust: let mut msg = input.to_vec();
    // rust: msg.push(0x80);
    // rust: while msg.len() % 64 != 56 {
    // rust: msg.push(0);
}
    // rust: msg.extend_from_slice(&((input.len() as u64).wrapping_mul(8)).to_le_bytes());
    // rust: for chunk in msg.chunks(64) {
    // rust: let m: Vec<u32> = chunk
    // rust: .chunks(4)
    // rust: .map(|w| u32::from_le_bytes([w[0], w[1], w[2], w[3]]))
    // rust: .collect();
    // rust: let (mut a, mut b, mut c, mut d) = (a0, b0, c0, d0);
    // rust: for i in 0..64 {
    // rust: let (f, g) = match i / 16 {
    // rust: 0 => ((b & c) | (!b & d), i),
    // rust: 1 => ((d & b) | (!d & c), (5 * i + 1) % 16),
    // rust: 2 => (b ^ c ^ d, (3 * i + 5) % 16),
    // rust: _ => (c ^ (b | !d), (7 * i) % 16),
}
    // rust: let f = f.wrapping_add(a).wrapping_add(k[i]).wrapping_add(m[g]);
    // rust: a = d;
    // rust: d = c;
    // rust: c = b;
    // rust: b = b.wrapping_add(f.rotate_left(S[i]));
}
    // rust: a0 = a0.wrapping_add(a);
    // rust: b0 = b0.wrapping_add(b);
    // rust: c0 = c0.wrapping_add(c);
    // rust: d0 = d0.wrapping_add(d);
}
    // rust: let mut out = [0u8; 16];
    // rust: for (i, v) in [a0, b0, c0, d0].iter().enumerate() {
    // rust: out[i * 4..i * 4 + 4].copy_from_slice(&v.to_le_bytes());
}
    // rust: out
}

// UUID.nameUUIDFromBytes("OfflinePlayer:" + name): MD5, version 3, IETF variant.
offline_uuid :: proc(name: string) -> u {
    // Ported from Horizon
    return {}
}
    // rust: let mut h = md5(format!("OfflinePlayer:{name}").as_bytes());
    // rust: h[6] = (h[6] & 0x0f) | 0x30;
    // rust: h[8] = (h[8] & 0x3f) | 0x80;
    // rust: u128::from_be_bytes(h)
}
// The canonical 8-4-4-4-12 form.
uuid_string :: proc(u: u128) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let h = format!("{u:032x}");
    // rust: format!(
    // rust: "{}-{}-{}-{}-{}",
    // rust: &h[..8],
    // rust: &h[8..12],
    // rust: &h[12..16],
    // rust: &h[16..20],
    // rust: &h[20..]
    // rust: )
}

    // rust: mod tests {
//     use super::*;

hex :: proc(s: string) -> V {
    // Ported from Horizon
    return {}
}
    // rust: (0..s.len())
    // rust: .step_by(2)
    // rust: .map(|i| u8::from_str_radix(&s[i..i + 2], 16).unwrap())
    // rust: .collect()
}

aes128_fips197_vector :: proc() {
}
    // rust: let key: [u8; 16] = hex("000102030405060708090a0b0c0d0e0f").try_into().unwrap();
    // rust: let mut block: [u8; 16] = hex("00112233445566778899aabbccddeeff").try_into().unwrap();
    // rust: Aes128::new(&key).encrypt_block(&mut block);
    // rust: assert_eq!(block.to_vec(), hex("69c4e0d86a7b0430d8cdb78070b4c55a"));
}

cfb8_nist_sp800_38a_vector :: proc() {
}
    // rust: let key: [u8; 16] = hex("2b7e151628aed2a6abf7158809cf4f3c").try_into().unwrap();
    // rust: let iv: [u8; 16] = hex("000102030405060708090a0b0c0d0e0f").try_into().unwrap();
    // rust: let plain = hex("6bc1bee22e409f96e93d7e117393172aae2d");
    // rust: let expected = hex("3b79424c9c0dd436bace9e0ed4586a4f32b9");
    // rust: let mut data = plain.clone();
        // Split across calls: the stream state carries over.
    // rust: let mut enc = Cfb8::new(&key, &iv);
    // rust: let (a, b) = data.split_at_mut(5);
    // rust: enc.encrypt(a);
    // rust: enc.encrypt(b);
    // rust: assert_eq!(data, expected);
    // rust: let mut dec = Cfb8::new(&key, &iv);
    // rust: dec.decrypt(&mut data);
    // rust: assert_eq!(data, plain);
}

    // Bytes from a fixed xorshift: the same every run.
noise :: proc(n: uint, mut seed: u64) -> V {
    // Ported from Horizon
    return {}
}
    // rust: (0..n)
    // rust: .map(|_| {
    // rust: seed ^= seed << 13;
    // rust: seed ^= seed >> 7;
    // rust: seed ^= seed << 17;
    // rust: seed as u8
    // rust: })
    // rust: .collect()
}

lanes_match_single_blocks_and_the_aes_crate :: proc() {
}
//         use aes::cipher::{BlockEncrypt, KeyInit};
    // rust: let key: [u8; 16] = noise(16, 1).try_into().unwrap();
    // rust: let aes = Aes128::new(&key);
    // rust: let reference = aes::Aes128::new(&key.into());
    // rust: let mut lanes: [[u8; 16]; LANES] =
    // rust: std::array::from_fn(|i| noise(16, 7 + i as u64).try_into().unwrap());
    // rust: let inputs = lanes;
    // rust: aes.encrypt_lanes(&mut lanes);
    // rust: for (input, out) in inputs.iter().zip(&lanes) {
    // rust: let mut one = *input;
    // rust: aes.encrypt_block(&mut one);
    // rust: assert_eq!(&one, out);
    // rust: let mut expected = aes::Block::from(*input);
    // rust: reference.encrypt_block(&mut expected);
    // rust: assert_eq!(out[..], expected[..]);
}
}

    // Decryption in runs of [`LANES`] gives what the one-byte-at-a-time
    // definition gives, however the stream is cut into reads.
cfb8_decrypts_like_the_byte_by_byte_definition :: proc() {
}
    // rust: let key: [u8; 16] = noise(16, 3).try_into().unwrap();
    // rust: let iv: [u8; 16] = noise(16, 4).try_into().unwrap();
    // rust: let plain = noise(5000, 5);
    // rust: let mut cipher = plain.clone();
    // rust: Cfb8::new(&key, &iv).encrypt(&mut cipher);
        // The definition: P[i] = C[i] ^ E(register)[0], register += C[i].
    // rust: let aes = Aes128::new(&key);
    // rust: let mut register = iv;
    // rust: let expected: Vec<u8> = cipher
    // rust: .iter()
    // rust: .map(|&c| {
    // rust: let mut block = register;
    // rust: aes.encrypt_block(&mut block);
    // rust: register.copy_within(1.., 0);
    // rust: register[15] = c;
    // rust: c ^ block[0]
    // rust: })
    // rust: .collect();
    // rust: assert_eq!(expected, plain);
    // rust: for cuts in [
    // rust: &[5000][..],
    // rust: &[1, 7, 8, 9, 15, 16, 17, 1000, 3927],
    // rust: &[3, 4997],
    // rust: ] {
    // rust: let mut data = cipher.clone();
    // rust: let mut dec = Cfb8::new(&key, &iv);
    // rust: let mut rest = &mut data[..];
    // rust: for &n in cuts {
    // rust: let (head, tail) = rest.split_at_mut(n);
    // rust: dec.decrypt(head);
    // rust: rest = tail;
}
    // rust: assert!(rest.is_empty());
    // rust: assert_eq!(data, plain, "cuts {cuts:?}");
}
}

    // The digests of single names published with the protocol docs.
server_hash_vectors :: proc() {
}
    // rust: let hash = |name: &str| java_hex_digest(&Sha1::digest(name.as_bytes()));
    // rust: assert_eq!(hash("Notch"), "4ed1f46bbe04bc756bcb17c0c7ce3e4632f06a48");
    // rust: assert_eq!(hash("jeb_"), "-7c9d5b0044c130109a5d7b5fb5c317c02b4e28c1");
    // rust: assert_eq!(hash("simon"), "88e16a1019277b15d58faf0541e11910eb756f6");
        // The three inputs are hashed in order: one update equals three.
    // rust: assert_eq!(server_hash("", b"Not", b"ch"), hash("Notch"));
    // rust: assert_eq!(java_hex_digest(&[0; 4]), "0");
    // rust: assert_eq!(java_hex_digest(&[0xff; 2]), "-1");
    // rust: assert_eq!(java_hex_digest(&[0x80, 0]), "-8000");
}

secrets_are_random :: proc() {
}
    // rust: let (a, b) = (generate_secret().unwrap(), generate_secret().unwrap());
    // rust: assert_ne!(a, b);
}

md5_and_offline_uuids :: proc() {
}
    // rust: assert_eq!(md5(b"").to_vec(), hex("d41d8cd98f00b204e9800998ecf8427e"));
    // rust: assert_eq!(
    // rust: md5(b"abc").to_vec(),
    // rust: hex("900150983cd24fb0d6963f7d28e17f72")
    // rust: );
    // rust: assert_eq!(
    // rust: md5(&[b'a'; 100]).to_vec(),
    // rust: hex("36a92cc94a9e0fa21f625f8bfb007adf")
    // rust: );
    // rust: assert_eq!(
    // rust: uuid_string(offline_uuid("Notch")),
    // rust: "b50ad385-829d-3141-a216-7e7d7539ba7f"
    // rust: );
}
}
