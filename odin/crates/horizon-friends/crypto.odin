//! Transpiled from Horizon Rust crate
package horizon_friends_crypto

import "core:fmt"
import "core:mem"
import "core:math"

// End-to-end protection between a host and a guest, whatever carries the
// bytes. SPAKE2 turns the code's short secret into a session key without
// giving anyone on the path (the relay included) a way to test guesses
// offline; every stream of the session then derives its own
// ChaCha20-Poly1305 keys from it and two fresh randoms, and starts with a
// key confirmation so a wrong code or a changed byte ends it.
// use chacha20poly1305::{
    // rust: ChaCha20Poly1305, KeyInit,
    // rust: aead::{Aead, Payload},
}
// use hkdf::Hkdf;
// use sha2::Sha256;
// use spake2::{Ed25519Group, Identity, Password, Spake2};
// use std::io::{self, Read, Write};

// The most game bytes in one frame.
MAX_PAYLOAD :: 16 * 1024
TAG :: 16
CONFIRM :: b"horizon-friends v1 confirm"

DATA :: 0
CONTROL :: 1
CONFIRMATION :: 2

Role :: enum {
    Host,
    Guest,
}

// The session key both ends derive from the code.
Key :: struct {

// The error a mismatched code produces: the peer's confirmation does not
// open with our key.
wrong_code :: proc() -> i {
    // Ported from Horizon
    return {}
}
    io: :Error::new(io::ErrorKind::PermissionDenied,
}
is_wrong_code :: proc(e: ^io::Error) -> b {
    // Ported from Horizon
    return {}
}
    // rust: e.kind() == io::ErrorKind::PermissionDenied
}

// SPAKE2 over a stream: both ends send their message, then read the
// other's. The identity binds the key to this nameplate and session.
    // rust: pub fn exchange<S: Read + Write>(
    // rust: stream: &mut S,
    // rust: secret: &str,
    // rust: nameplate: &str,
    // rust: session: u64,
    // rust: ) -> io::Result<Key> {
    // rust: let identity = format!("horizon-friends v1/{nameplate}/{session}");
    // rust: let (state, outbound) = Spake2::<Ed25519Group>::start_symmetric(
    // rust: &Password::new(secret.as_bytes()),
    // rust: &Identity::new(identity.as_bytes()),
    // rust: );
    // rust: let len = u8::try_from(outbound.len()).map_err(io::Error::other)?;
    // rust: let mut message = vec![len];
    // rust: message.extend_from_slice(&outbound);
    // rust: stream.write_all(&message)?;
    // rust: stream.flush()?;
    // rust: let mut len = [0u8; 1];
    // rust: stream.read_exact(&mut len)?;
    // rust: let mut inbound = vec![0u8; usize::from(len[0])];
    // rust: stream.read_exact(&mut inbound)?;
    // rust: let key = state
    // rust: .finish(&inbound)
    // rust: .map_err(|e| io::Error::new(io::ErrorKind::InvalidData, format!("{e:?}")))?;
    // rust: let mut out = [0u8; 32];
    // rust: let hk = Hkdf::<Sha256>::new(None, &key);
    // rust: hk.expand(b"horizon-friends v1 session", &mut out)
    // rust: .expect("32 bytes is a valid HKDF output");
    // rust: Ok(Key(out))
}

nonce :: proc(counter: u64) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: let mut n = [0u8; 12];
    // rust: n[4..].copy_from_slice(&counter.to_be_bytes());
    // rust: n
}

cipher :: proc(key: ^Key, salt: []u8, info: []u8) -> C {
    // Ported from Horizon
    return {}
}
    // rust: let mut okm = [0u8; 32];
    // rust: Hkdf::<Sha256>::new(Some(salt), &key.0)
    // rust: .expand(info, &mut okm)
    // rust: .expect("32 bytes is a valid HKDF output");
    // rust: ChaCha20Poly1305::new(&okm.into())
}

Frame :: enum {
    Data(Vec<u8>),
    Control(Vec<u8>),
}

SecureWriter :: struct {
    inner: W,
    cipher: ChaCha20Poly1305,
    counter: u64,
}
    // rust: impl<W: Write> SecureWriter<W> {
frame :: proc(self: ^Self, kind: u8, payload: []u8) -> i {
    // Ported from Horizon
    return {}
}
    // rust: debug_assert!(payload.len() <= MAX_PAYLOAD);
    // rust: let mut plain = Vec::with_capacity(1 + payload.len());
    // rust: plain.push(kind);
    // rust: plain.extend_from_slice(payload);
    // rust: let len = (plain.len() + TAG) as u16;
    // rust: let header = len.to_be_bytes();
    // rust: let sealed = self
    // rust: .cipher
    // rust: .encrypt(
    // rust: &nonce(self.counter).into(),
    // rust: Payload {
    // rust: msg: &plain,
    // rust: aad: &header,
    // rust: },
    // rust: )
    // rust: .map_err(|_| io::Error::other("encryption failed"))?;
    // rust: self.counter = self
    // rust: .counter
    // rust: .checked_add(1)
    // rust: .ok_or_else(|| io::Error::other("frame counter exhausted"))?;
    // rust: let mut out = Vec::with_capacity(2 + sealed.len());
    // rust: out.extend_from_slice(&header);
    // rust: out.extend_from_slice(&sealed);
    // rust: self.inner.write_all(&out)
}
    // Game bytes, split into frames.
write_data :: proc(self: ^Self, bytes: []u8) -> i {
    // Ported from Horizon
    return {}
}
    // rust: for chunk in bytes.chunks(MAX_PAYLOAD) {
    // rust: self.frame(DATA, chunk)?;
}
    // rust: self.inner.flush()
}
    // A message between the two tunnel ends.
write_control :: proc(self: ^Self, message: []u8) -> i {
    // Ported from Horizon
    return {}
}
    // rust: if message.len() > MAX_PAYLOAD {
    // rust: return Err(io::Error::new(
    // rust: io::ErrorKind::InvalidInput,
    // rust: "control message too long",
    // rust: ));
}
    // rust: self.frame(CONTROL, message)?;
    // rust: self.inner.flush()
}
get_ref :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &self.inner
}
}

SecureReader :: struct {
    inner: R,
    cipher: ChaCha20Poly1305,
    counter: u64,
}
    // rust: impl<R: Read> SecureReader<R> {
    // The next frame's kind and payload; None at a clean end of stream.
open :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let mut header = [0u8; 2];
    // rust: let mut got = 0;
    // rust: while got < 2 {
    // rust: match self.inner.read(&mut header[got..]) {
    // rust: Ok(0) if got == 0 => return Ok(None),
    // rust: Ok(0) => return Err(io::ErrorKind::UnexpectedEof.into()),
    // rust: Ok(n) => got += n,
    // rust: Err(e) if e.kind() == io::ErrorKind::Interrupted => {}
    // rust: Err(e) => return Err(e),
}
}
    // rust: let len = usize::from(u16::from_be_bytes(header));
    // rust: if !(TAG + 1..=TAG + 1 + MAX_PAYLOAD).contains(&len) {
    // rust: return Err(io::Error::new(
    // rust: io::ErrorKind::InvalidData,
    // rust: "bad frame length",
    // rust: ));
}
    // rust: let mut sealed = vec![0u8; len];
    // rust: self.inner.read_exact(&mut sealed)?;
    // rust: let plain = self
    // rust: .cipher
    // rust: .decrypt(
    // rust: &nonce(self.counter).into(),
    // rust: Payload {
    // rust: msg: &sealed,
    // rust: aad: &header,
    // rust: },
    // rust: )
    // rust: .map_err(|_| io::Error::new(io::ErrorKind::InvalidData, "frame failed to open"))?;
    // rust: self.counter += 1;
    // rust: Ok(Some((plain[0], plain[1..].to_vec())))
}
read_frame :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: match self.open()? {
    // rust: None => Ok(None),
    // rust: Some((DATA, p)) => Ok(Some(Frame::Data(p))),
    // rust: Some((CONTROL, p)) => Ok(Some(Frame::Control(p))),
    // rust: Some(_) => Err(io::Error::new(
    // rust: io::ErrorKind::InvalidData,
    // rust: "unexpected frame",
    // rust: )),
}
}
get_ref :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &self.inner
}
}

// Protect one stream of the session: swap randoms, derive the keys for
// each direction, confirm. Fails with [`wrong_code`] when the peer used
// another key.
    // rust: pub fn secure<R: Read, W: Write>(
    // rust: mut read: R,
    // rust: mut write: W,
    // rust: key: &Key,
    // rust: role: Role,
    // rust: ) -> io::Result<(SecureReader<R>, SecureWriter<W>)> {
    // rust: let mut mine = [0u8; 16];
    // rust: crate::fill_random(&mut mine)?;
    // rust: write.write_all(&mine)?;
    // rust: write.flush()?;
    // rust: let mut theirs = [0u8; 16];
    // rust: read.read_exact(&mut theirs)?;
    // rust: let (guest, host) = match role {
    // rust: Role::Guest => (mine, theirs),
    // rust: Role::Host => (theirs, mine),
}
    // rust: let mut salt = [0u8; 32];
    // rust: salt[..16].copy_from_slice(&guest);
    // rust: salt[16..].copy_from_slice(&host);
    // rust: let to_guest = cipher(key, &salt, b"horizon-friends v1 host->guest");
    // rust: let to_host = cipher(key, &salt, b"horizon-friends v1 guest->host");
    // rust: let (send, recv) = match role {
    // rust: Role::Host => (to_guest, to_host),
    // rust: Role::Guest => (to_host, to_guest),
}
    // rust: let mut writer = SecureWriter {
    // rust: inner: write,
    // rust: cipher: send,
    // rust: counter: 0,
}
    // rust: let mut reader = SecureReader {
    // rust: inner: read,
    // rust: cipher: recv,
    // rust: counter: 0,
}
    // rust: writer.frame(CONFIRMATION, CONFIRM)?;
    // rust: writer.inner.flush()?;
    // rust: match reader.open() {
    // rust: Ok(Some((CONFIRMATION, p))) if p == CONFIRM => Ok((reader, writer)),
    // rust: Ok(_) => Err(io::Error::new(
    // rust: io::ErrorKind::InvalidData,
    // rust: "no confirmation",
    // rust: )),
    // rust: Err(e) if e.kind() == io::ErrorKind::InvalidData => Err(wrong_code()),
    // rust: Err(e) => Err(e),
}
}

    // rust: mod tests {
//     use super::*;
//     use std::net::{TcpListener, TcpStream};

pair :: proc() -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let l = TcpListener::bind("127.0.0.1:0").unwrap();
    // rust: let a = TcpStream::connect(l.local_addr().unwrap()).unwrap();
    // rust: let (b, _) = l.accept().unwrap();
    // rust: (a, b)
}

    // rust: fn both<A: Send + 'static, B: Send + 'static>(
    // rust: a: impl FnOnce() -> A + Send + 'static,
    // rust: b: impl FnOnce() -> B + Send + 'static,
    // rust: ) -> (A, B) {
    // rust: let t = std::thread::spawn(a);
    // rust: let rb = b();
    // rust: (t.join().unwrap(), rb)
}

    // rust: fn keys(
    // rust: host_secret: &'static str,
    // rust: guest_secret: &'static str,
    // rust: ) -> (Key, Key, TcpStream, TcpStream) {
    // rust: let (mut h, mut g) = pair();
    // rust: let (hk, gk) = both(
    // rust: {
    // rust: let mut h2 = h.try_clone().unwrap();
    // rust: move || exchange(&mut h2, host_secret, "K7QM", 9).unwrap()
    // rust: },
    // rust: {
    // rust: let mut g2 = g.try_clone().unwrap();
    // rust: move || exchange(&mut g2, guest_secret, "K7QM", 9).unwrap()
    // rust: },
    // rust: );
    // rust: h.flush().unwrap();
    // rust: g.flush().unwrap();
    // rust: (hk, gk, h, g)
}

same_code_same_key_and_frames_flow :: proc() {
}
    // rust: let (hk, gk, h, g) = keys("3XPD", "3XPD");
    // rust: assert_eq!(hk.0, gk.0);
    // rust: let ((mut hr, mut hw), (mut gr, mut gw)) = both(
    // rust: move || secure(h.try_clone().unwrap(), h, &hk, Role::Host).unwrap(),
    // rust: move || secure(g.try_clone().unwrap(), g, &gk, Role::Guest).unwrap(),
    // rust: );
    // rust: let big: Vec<u8> = (0..MAX_PAYLOAD * 2 + 5).map(|i| i as u8).collect();
    // rust: gw.write_data(&big).unwrap();
    // rust: gw.write_control(b"{\"use\":true}").unwrap();
    // rust: hw.write_data(b"pong").unwrap();
    // rust: let mut got = Vec::new();
    // rust: while got.len() < big.len() {
    // rust: match hr.read_frame().unwrap().unwrap() {
    // rust: Frame::Data(d) => got.extend(d),
    // rust: Frame::Control(_) => panic!("control before data"),
}
}
    // rust: assert_eq!(got, big);
    // rust: assert!(
    // rust: matches!(hr.read_frame().unwrap(), Some(Frame::Control(c)) if c == b"{\"use\":true}")
    // rust: );
    // rust: assert!(matches!(gr.read_frame().unwrap(), Some(Frame::Data(d)) if d == b"pong"));
    // rust: drop(gw);
    // rust: drop(gr);
    // rust: assert!(hr.read_frame().unwrap().is_none());
}

a_wrong_secret_is_refused_on_both_ends :: proc() {
}
    // rust: let (hk, gk, h, g) = keys("3XPD", "3XPE");
    // rust: assert_ne!(hk.0, gk.0);
    // rust: let (a, b) = both(
    // rust: move || secure(h.try_clone().unwrap(), h, &hk, Role::Host).err(),
    // rust: move || secure(g.try_clone().unwrap(), g, &gk, Role::Guest).err(),
    // rust: );
    // rust: assert!(is_wrong_code(&a.unwrap()));
    // rust: assert!(is_wrong_code(&b.unwrap()));
}

the_session_is_part_of_the_key :: proc() {
}
    // rust: let (mut h, mut g) = pair();
    // rust: let (hk, gk) = both(
    // rust: move || exchange(&mut h, "3XPD", "K7QM", 1).unwrap(),
    // rust: move || exchange(&mut g, "3XPD", "K7QM", 2).unwrap(),
    // rust: );
    // rust: assert_ne!(hk.0, gk.0);
}

    // A byte changed in flight, frames replayed or reordered: the reader
    // stops. Built on in-memory buffers to edit the bytes.
tampering_is_detected :: proc() {
}
    // rust: let key = Key([7; 32]);
    // rust: let seal = |frames: &[&[u8]]| {
    // rust: let mut w = SecureWriter {
    // rust: inner: Vec::new(),
    // rust: cipher: cipher(&key, &[1; 32], b"horizon-friends v1 guest->host"),
    // rust: counter: 0,
}
    // rust: for f in frames {
    // rust: w.write_data(f).unwrap();
}
    // rust: w.inner
}
    // rust: let reader = |bytes: Vec<u8>| SecureReader {
    // rust: inner: io::Cursor::new(bytes),
    // rust: cipher: cipher(&key, &[1; 32], b"horizon-friends v1 guest->host"),
    // rust: counter: 0,
}
    // rust: let good = seal(&[b"hello", b"world"]);
    // rust: let mut r = reader(good.clone());
    // rust: assert!(matches!(r.read_frame().unwrap(), Some(Frame::Data(d)) if d == b"hello"));
    // rust: assert!(matches!(r.read_frame().unwrap(), Some(Frame::Data(d)) if d == b"world"));
    // rust: assert!(r.read_frame().unwrap().is_none());
        // One flipped bit.
    // rust: let mut bad = good.clone();
    // rust: bad[5] ^= 1;
    // rust: assert!(reader(bad).read_frame().is_err());
        // Frames swapped: the counter no longer matches.
    // rust: let first = 2 + usize::from(u16::from_be_bytes([good[0], good[1]]));
    // rust: let mut swapped = good[first..].to_vec();
    // rust: swapped.extend_from_slice(&good[..first]);
    // rust: assert!(reader(swapped).read_frame().is_err());
        // The first frame twice.
    // rust: let mut r = reader([&good[..first], &good[..first]].concat());
    // rust: r.read_frame().unwrap();
    // rust: assert!(r.read_frame().is_err());
        // A header claiming more than a frame can hold.
    // rust: assert!(reader(vec![0xFF, 0xFF, 0]).read_frame().is_err());
}
}
