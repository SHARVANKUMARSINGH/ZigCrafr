//! Transpiled from Horizon Rust crate
package horizon_friends_guest

import "core:fmt"
import "core:mem"
import "core:math"

// The guest's end: reach the host from the code (directly, or through a
// relay), agree on the key, then offer the session on a loopback port the
// game's client connects to like to any server.
// use crate::{
    // rust: Code, PathMode,
    // rust: crypto::{self, Role},
    // rust: direct,
    // rust: invite::{Invite, Parsed},
    // rust: resolve_relay,
    // rust: session::{self, Secure},
    // rust: wire::{self, ErrorCode, FromRelay, ToRelay},
}
// use std::{
    // rust: fmt, io,
    // rust: net::{Ipv4Addr, SocketAddr, TcpListener, TcpStream},
    // rust: sync::mpsc::channel,
    // rust: thread::JoinHandle,
    // rust: time::{Duration, Instant},
}

GuestConfig :: struct {
    // The code as pasted: a full invite, or a relay's short code.
    code: string,
    // The relay to use for short codes (the player's setting); a full
    // invite names its own.
    relay: Maybe(string),
    // The game's protocol number and version name (a relay refuses a
    // guest whose protocol differs from the host's).
    protocol: i32,
    game: string,
    path: PathMode,
}

// Why joining failed, in words for the player.
JoinError :: enum {
    BadCode(crate::invite::CodeError),
    // A short code without a relay to resolve it.
    NeedsRelay,
    // None of the code's endpoints answered, and no relay to fall back to.
    NotReachable,
    Unreachable(String),
    UnknownCode,
    Ended,
    VersionMismatch {,
    host: Option<String>,
    mine: String,
    // rust: },
    HostUnreachable,
    Full,
    RateLimited,
    WrongCode,
    Failed(String),
}
    // rust: impl fmt::Display for JoinError {
fmt :: proc(self: ^Self, f: ^fmt::Formatter<'_>) -> f {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::BadCode(e) => write!(f, "{e}"),
    // rust: Self::NeedsRelay => write!(
    // rust: f,
    // rust: "This short code works through your friend's relay: add the relay's address under Join a friend, or ask for the full code."
    // rust: ),
    // rust: Self::NotReachable => write!(
    // rust: f,
    // rust: "Couldn't reach your friend's game. Ask them to read the note under their code: they may need UPnP on their router, a forwarded port, a relay or a VPN."
    // rust: ),
    // rust: Self::Unreachable(e) => write!(f, "Couldn't reach the relay ({e})."),
    // rust: Self::UnknownCode => write!(
    // rust: f,
    // rust: "No world uses this code. Check it, or ask your friend for a new one."
    // rust: ),
    // rust: Self::Ended => write!(
    // rust: f,
    // rust: "This invite has ended: your friend stopped sharing or left the world."
    // rust: ),
    // rust: Self::VersionMismatch {
    // rust: host: Some(v),
    // rust: mine,
    // rust: } => {
    // rust: write!(f, "Your friend plays Minecraft {v}; you have {mine}.")
}
    // rust: Self::VersionMismatch { host: None, mine } => {
    // rust: write!(
    // rust: f,
    // rust: "Your friend plays another version of Minecraft than {mine}."
    // rust: )
}
    // rust: Self::HostUnreachable => write!(f, "Your friend's game didn't answer."),
    // rust: Self::Full => write!(
    // rust: f,
    // rust: "Your friend's world is full, or the invite service is busy. Try again in a moment."
    // rust: ),
    // rust: Self::RateLimited => {
    // rust: write!(f, "Too many attempts. Wait a few minutes, then try again.")
}
    // rust: Self::WrongCode => write!(f, "The code doesn't match. Check the last four characters."),
    // rust: Self::Failed(e) => write!(f, "Couldn't connect to your friend ({e})."),
}
}
}
    // rust: impl std::error::Error for JoinError {}

// A settled session, ready to carry the game's connection.
Tunnel :: struct {
    secure: Secure,
    // Whether the stream goes straight to the host (else through the relay).
    direct: bool,
}

// Join with what the player pasted: a full invite is dialled directly
// (every endpoint at once), then through the relay it names, if any; a
// short code goes through the configured relay. Blocks for a few seconds.
join :: proc(config: ^GuestConfig) -> R {
    // Ported from Horizon
    return {}
}
    // rust: match crate::invite::parse_detailed(&config.code).map_err(JoinError::BadCode)? {
    // rust: Parsed::Short(code) => {
    // rust: let relay = config.relay.as_deref().ok_or(JoinError::NeedsRelay)?;
    // rust: join_relay(config, relay, &code)
}
    // rust: Parsed::Long(invite) => {
    // rust: if config.path != PathMode::RelayOnly
    // rust: && !invite.endpoints.is_empty()
    // rust: && let Some(t) = join_direct(&invite)?
    // rust: {
    // rust: return Ok(t);
}
    // rust: match &invite.relay {
    // rust: Some(r) if config.path != PathMode::DirectOnly => {
    // rust: join_relay(config, &r.address, &r.code)
}
    // rust: _ => Err(JoinError::NotReachable),
}
}
}
}

// Dial every endpoint of the code; the first that answers as a Horizon
// host gets the handshake, the others are dropped before it.
join_direct :: proc(invite: ^Invite) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let (tx, rx) = channel();
    // rust: let deadline = Instant::now() + Duration::from_secs(5);
    // rust: let mut session = [0u8; 8];
    // rust: crate::fill_random(&mut session).map_err(|e| JoinError::Failed(e.to_string()))?;
    // rust: let session = u64::from_le_bytes(session);
    // rust: for &endpoint in &invite.endpoints {
    // rust: let tx = tx.clone();
    // rust: let _ = std::thread::Builder::new()
    // rust: .name("horizon-friends-dial".into())
    // rust: .spawn(move || {
    // rust: if let Ok(mut s) = TcpStream::connect_timeout(&endpoint, Duration::from_secs(4))
    // rust: && direct::code_hello(&mut s, session).is_ok()
    // rust: {
    // rust: let _ = tx.send(s);
}
    // rust: });
}
    // rust: drop(tx);
    // rust: let left = deadline.saturating_duration_since(Instant::now());
    // rust: let Ok(mut stream) = rx.recv_timeout(left) else {
    // rust: return Ok(None);
}
    // rust: let key = crypto::exchange(&mut stream, &invite.secret_text(), "direct", session)
    // rust: .map_err(|e| JoinError::Failed(e.to_string()))?;
    // rust: let secure = session::secure(stream, &key, Role::Guest).map_err(|e| {
    // rust: if crypto::is_wrong_code(&e) {
    // rust: JoinError::WrongCode
    // rust: } else {
    // rust: JoinError::Failed(e.to_string())
}
    // rust: })?;
    // rust: Ok(Some(Tunnel {
    // rust: secure,
    // rust: direct: true,
    // rust: }))
}

// Through a relay with its short code (its own direct race, then the
// relay's byte stream).
join_relay :: proc(config: ^GuestConfig, relay_url: string, code: ^Code) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let relays = resolve_relay(relay_url).map_err(|e| JoinError::Unreachable(e.to_string()))?;
    // rust: let direct_allowed = config.path != PathMode::RelayOnly;
    // rust: let (listeners, port) = if direct_allowed {
    // rust: match direct::listen(0) {
    // rust: Ok((l, p)) => (l, Some(p)),
    // rust: Err(_) => (Vec::new(), None),
}
    // rust: } else {
    // rust: (Vec::new(), None)
}
    // rust: let mut last = io::Error::other("no address");
    // rust: let mut stream = None;
    // rust: for relay in &relays {
    // rust: match direct::connect_from(port, *relay, Duration::from_secs(5)) {
    // rust: Ok(s) => {
    // rust: stream = Some((s, *relay));
    // rust: break;
}
    // rust: Err(e) => last = e,
}
}
    // rust: let (mut stream, relay) = stream.ok_or_else(|| JoinError::Unreachable(last.to_string()))?;
    // rust: let failed = |e: io::Error| JoinError::Failed(e.to_string());
    // rust: stream
    // rust: .set_read_timeout(Some(Duration::from_secs(15)))
    // rust: .map_err(failed)?;
    // rust: let _ = stream.set_nodelay(true);
    // rust: wire::send(
    // rust: &mut stream,
    // rust: &ToRelay::Join {
    // rust: v: wire::VERSION,
    // rust: nameplate: code.nameplate.clone(),
    // rust: protocol: config.protocol,
    // rust: game: config.game.clone(),
    // rust: },
    // rust: )
    // rust: .map_err(failed)?;
    // rust: let (session, observed) = match wire::recv::<_, FromRelay>(&mut stream).map_err(failed)? {
    // rust: FromRelay::Bridged { session, observed } => (session, observed),
    // rust: FromRelay::Error { code, game } => {
    // rust: return Err(match code {
    // rust: ErrorCode::UnknownCode => JoinError::UnknownCode,
    // rust: ErrorCode::Ended => JoinError::Ended,
    // rust: ErrorCode::VersionMismatch => JoinError::VersionMismatch {
    // rust: host: game,
    // rust: mine: config.game.clone(),
    // rust: },
    // rust: ErrorCode::HostUnreachable => JoinError::HostUnreachable,
    // rust: ErrorCode::Full => JoinError::Full,
    // rust: ErrorCode::RateLimited => JoinError::RateLimited,
    // rust: ErrorCode::BadRequest => JoinError::Failed("the relay refused the request".into()),
    // rust: });
}
    // rust: other => return Err(JoinError::Failed(format!("unexpected answer {other:?}"))),
}
    // rust: let key = crypto::exchange(&mut stream, &code.secret, &code.nameplate, session)
    // rust: .map_err(|_| JoinError::HostUnreachable)?;
    // rust: let relayed = session::secure(stream, &key, Role::Guest).map_err(|e| {
    // rust: if crypto::is_wrong_code(&e) {
    // rust: JoinError::WrongCode
    // rust: } else {
    // rust: JoinError::HostUnreachable
}
    // rust: })?;
    // rust: let observed = observed.and_then(|o| o.parse::<SocketAddr>().ok());
    // rust: let candidates = port.map_or_else(Vec::new, |p| direct::candidates(p, Some(relay), observed));
    // rust: let settled = session::settle(
    // rust: relayed,
    // rust: &key,
    // rust: Role::Guest,
    // rust: config.path,
    // rust: session,
    // rust: port,
    // rust: candidates,
    // rust: Box::new(move |tx, deadline, stop| direct::accept(listeners, session, deadline, stop, tx)),
    // rust: )
    // rust: .map_err(|e| JoinError::Failed(e.to_string()))?;
    // rust: Ok(Tunnel {
    // rust: secure: settled.secure,
    // rust: direct: settled.direct,
    // rust: })
}

    // rust: impl Tunnel {
    // Offer the session on `127.0.0.1:port` for one connection (the game's
    // client); the returned thread ends when that connection does.
serve_loopback :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let listener = TcpListener::bind((Ipv4Addr::LOCALHOST, 0))?;
    // rust: let port = listener.local_addr()?.port();
    // rust: listener.set_nonblocking(true)?;
    // rust: let thread = std::thread::Builder::new()
    // rust: .name("horizon-friends-guest".into())
    // rust: .spawn(move || {
    // rust: let deadline = std::time::Instant::now() + Duration::from_secs(30);
    // rust: let plain = loop {
    // rust: match listener.accept() {
    // rust: Ok((s, from)) if from.ip().is_loopback() => break Some(s),
    // rust: Ok(_) => {}
    // rust: Err(e) if e.kind() == io::ErrorKind::WouldBlock => {
    // rust: if std::time::Instant::now() > deadline {
    // rust: break None;
}
    // rust: std::thread::sleep(Duration::from_millis(10));
}
    // rust: Err(_) => break None,
}
}
    // rust: drop(listener);
    // rust: let (reader, writer) = self.secure;
    // rust: let Some(plain) = plain else {
    // rust: let _ = reader.get_ref().shutdown(std::net::Shutdown::Both);
    // rust: return;
}
    // rust: let _ = plain.set_nonblocking(false);
    // rust: if let Ok(t) = crate::pump(plain, reader, writer) {
    // rust: let _ = t.join();
}
    // rust: })?;
    // rust: Ok((port, thread))
}
}
