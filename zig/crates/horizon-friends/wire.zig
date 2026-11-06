//! Transpiled from Horizon Rust crate
//! Module: horizon-friends_wire
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The relay protocol: one JSON object per line until a connection is
//! bridged, then the raw session stream (see docs/play-with-friends.md).
// use serde::{Deserialize, Serialize};
// use std::io::{self, BufRead, Read, Write};

/// Protocol version both the relay and the clients speak.
pub const VERSION: u32 = 1;
/// The longest line either side accepts.
pub const MAX_LINE: usize = 4096;

/// Lines a client sends.
pub const ToRelay = enum {
    /// Register a world; the connection stays open as the host's control
    /// connection.
    Host {,
    v: u32,
    protocol: i32,
    game: String,
    // rust: },
    /// Join the world behind a nameplate.
    Join {,
    v: u32,
    nameplate: String,
    protocol: i32,
    game: String,
    // rust: },
    /// The host's new connection for a session the relay announced.
    Attach {,
    v: u32,
    session: u64,
    token: String,
    // rust: },
    Pong,
};

/// Lines the relay sends.
pub const FromRelay = enum {
    Registered {,
    nameplate: String,
    token: String,
        /// The address the relay saw the connection come from.
    observed: Option<String>,
    // rust: },
    /// A guest is joining: attach a new connection for the session.
    Join {,
    session: u64,
    // rust: },
    /// The connection now carries the session: raw bytes from here on.
    Bridged {,
    session: u64,
    observed: Option<String>,
    // rust: },
    Ping,
    Error {,
    code: ErrorCode,
        /// The host's game version, for `version_mismatch`.
    game: Option<String>,
    // rust: },
};

pub const ErrorCode = enum {
    UnknownCode,
    Ended,
    VersionMismatch,
    HostUnreachable,
    Full,
    RateLimited,
    BadRequest,
};
    // rust: impl ErrorCode {
pub fn as_str(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::UnknownCode => "unknown_code",
    // rust: Self::Ended => "ended",
    // rust: Self::VersionMismatch => "version_mismatch",
    // rust: Self::HostUnreachable => "host_unreachable",
    // rust: Self::Full => "full",
    // rust: Self::RateLimited => "rate_limited",
    // rust: Self::BadRequest => "bad_request",
}
}
}

/// Write one message as a line.
    // rust: pub fn send<W: Write, T: Serialize>(w: &mut W, message: &T) -> io::Result<()> {
    // rust: let mut line = serde_json::to_vec(message).map_err(io::Error::other)?;
    // rust: line.push(b'\n');
    // rust: w.write_all(&line)?;
    // rust: w.flush()
}

/// Read one line of at most [`MAX_LINE`] bytes, a byte at a time so nothing
/// after it is consumed: the bytes that follow `bridged` belong to the
/// session. None at a clean end of stream.
    // rust: pub fn read_line<R: Read>(r: &mut R) -> io::Result<Option<Vec<u8>>> {
    // rust: let mut line = Vec::new();
    // rust: let mut byte = [0u8; 1];
    // rust: loop {
    // rust: match r.read(&mut byte) {
    // rust: Ok(0) if line.is_empty() => return Ok(None),
    // rust: Ok(0) => return Err(io::ErrorKind::UnexpectedEof.into()),
    // rust: Ok(_) if byte[0] == b'\n' => return Ok(Some(line)),
    // rust: Ok(_) => {
    // rust: if line.len() == MAX_LINE {
    // rust: return Err(io::Error::new(io::ErrorKind::InvalidData, "line too long"));
}
    // rust: line.push(byte[0]);
}
    // rust: Err(e) if e.kind() == io::ErrorKind::Interrupted => {}
    // rust: Err(e) => return Err(e),
}
}
}

/// Read and decode one message; an end of stream is an error.
    // rust: pub fn recv<R: Read, T: for<'de> Deserialize<'de>>(r: &mut R) -> io::Result<T> {
    // rust: let line = read_line(r)?.ok_or(io::ErrorKind::UnexpectedEof)?;
    // rust: serde_json::from_slice(&line).map_err(|e| io::Error::new(io::ErrorKind::InvalidData, e))
}

/// The same over a buffered reader (the host's control connection, where
/// nothing follows the lines).
    // rust: pub fn recv_buffered<R: BufRead, T: for<'de> Deserialize<'de>>(r: &mut R) -> io::Result<T> {
    // rust: let mut line = Vec::new();
    // rust: let n = r.take(MAX_LINE as u64 + 1).read_until(b'\n', &mut line)?;
    // rust: if n == 0 {
    // rust: return Err(io::ErrorKind::UnexpectedEof.into());
}
    // rust: if line.last() != Some(&b'\n') {
    // rust: return Err(io::Error::new(io::ErrorKind::InvalidData, "line too long"));
}
    // rust: serde_json::from_slice(&line).map_err(|e| io::Error::new(io::ErrorKind::InvalidData, e))
}

    // rust: mod tests {
//     use super::*;

pub fn lines_round_trip() void {
}
    // rust: let mut buf = Vec::new();
    // rust: send(
    // rust: &mut buf,
    // rust: &ToRelay::Join {
    // rust: v: VERSION,
    // rust: nameplate: "K7QM".into(),
    // rust: protocol: 777,
    // rust: game: "26.3".into(),
    // rust: },
    // rust: )
    // rust: .unwrap();
    // rust: assert_eq!(
    // rust: String::from_utf8(buf.clone()).unwrap(),
    // rust: "{\"op\":\"join\",\"v\":1,\"nameplate\":\"K7QM\",\"protocol\":777,\"game\":\"26.3\"}\n"
    // rust: );
    // rust: send(
    // rust: &mut buf,
    // rust: &FromRelay::Error {
    // rust: code: ErrorCode::VersionMismatch,
    // rust: game: Some("26.2".into()),
    // rust: },
    // rust: )
    // rust: .unwrap();
    // rust: buf.extend_from_slice(b"raw");
    // rust: let mut r = &buf[..];
    // rust: let first: ToRelay = recv(&mut r).unwrap();
    // rust: assert!(matches!(first, ToRelay::Join { protocol: 777, .. }));
    // rust: let second: FromRelay = recv(&mut r).unwrap();
    // rust: assert_eq!(
    // rust: second,
    // rust: FromRelay::Error {
    // rust: code: ErrorCode::VersionMismatch,
    // rust: game: Some("26.2".into())
}
    // rust: );
        // Nothing after the line was consumed.
    // rust: assert_eq!(r, b"raw");
}

pub fn long_lines_and_garbage_are_refused() void {
}
    // rust: let long = vec![b'a'; MAX_LINE + 1];
    // rust: assert!(read_line(&mut &long[..]).is_err());
    // rust: let mut exact = vec![b'a'; MAX_LINE];
    // rust: exact.push(b'\n');
    // rust: assert_eq!(read_line(&mut &exact[..]).unwrap().unwrap().len(), MAX_LINE);
    // rust: assert!(recv::<_, ToRelay>(&mut &b"{\"op\":\"nope\"}\n"[..]).is_err());
    // rust: assert!(recv::<_, ToRelay>(&mut &b""[..]).is_err());
    // rust: assert!(read_line(&mut &b""[..]).unwrap().is_none());
    // rust: assert!(read_line(&mut &b"partial"[..]).is_err());
    // rust: let mut buffered = io::BufReader::new(&long[..]);
    // rust: assert!(recv_buffered::<_, ToRelay>(&mut buffered).is_err());
    // rust: let mut buffered = io::BufReader::new(&b"{\"op\":\"pong\"}\n"[..]);
    // rust: assert_eq!(
    // rust: recv_buffered::<_, ToRelay>(&mut buffered).unwrap(),
    // rust: ToRelay::Pong
    // rust: );
}
}
