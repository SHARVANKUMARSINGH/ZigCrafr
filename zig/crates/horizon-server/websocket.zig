//! Transpiled from Horizon Rust crate
//! Module: horizon-server_websocket
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The server side of a WebSocket (RFC 6455) on a std `TcpStream`, for vanilla's management protocol
//! (`management.rs`): the handshake's accept key, and text frames in and out, over plain TCP or TLS (`Link`).
//! Messages are aggregated up to 64 KiB, as vanilla's `WebSocketFrameAggregator(65536)`; pings get their pong;
//! binary frames are dropped, as vanilla's pipeline only decodes text.

// use base64::Engine;
// use sha1::{Digest, Sha1};
// use std::{
    // rust: io::{self, Read, Write},
    // rust: net::TcpStream,
    // rust: sync::{Arc, Mutex},
    // rust: time::Duration,
}

/// What `Sec-WebSocket-Accept` answers for a `Sec-WebSocket-Key`.
pub fn accept_key(key: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut sha = Sha1::new();
    // rust: sha.update(key.trim().as_bytes());
    // rust: sha.update(b"258EAFA5-E914-47DA-95CA-C5AB0DC85B11");
    // rust: base64::engine::general_purpose::STANDARD.encode(sha.finalize())
}

/// The longest message read, as vanilla aggregates frames.
pub const MAX_MESSAGE: usize = 65536;

pub const TEXT: u8 = 1;
pub const CLOSE: u8 = 8;
pub const PING: u8 = 9;

/// A connection, plain or TLS, that one thread reads while any thread writes: TLS records are decrypted and
/// encrypted under a short lock, never held while waiting on the network, so a reply or a notification can go
/// out while the reader waits for the next message.
pub const Link = enum {
    Plain {,
    input: Mutex<TcpStream>,
    output: Mutex<TcpStream>,
    // rust: },
    Tls(Box<Tls>),
};

pub const Tls = struct {
    connection: Mutex<rustls::ServerConnection>,
    /// The socket's reading side and the bytes read from it that the TLS session hasn't taken yet.
    input: Mutex<(TcpStream,
    output: Mutex<TcpStream>,
};

    // rust: impl Link {
pub fn plain(stream: *TcpStream) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(Self::Plain {
    // rust: input: Mutex::new(stream.try_clone()?),
    // rust: output: Mutex::new(stream.try_clone()?),
    // rust: })
}

    /// The server's side of a TLS session on `stream`; the handshake happens on the first read.
pub fn tls(stream: *TcpStream, config: *rustls::ServerConfig) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let connection = rustls::ServerConnection::new(config).map_err(io::Error::other)?;
    // rust: Ok(Self::Tls(Box::new(Tls {
    // rust: connection: Mutex::new(connection),
    // rust: input: Mutex::new((stream.try_clone()?, Vec::new())),
    // rust: output: Mutex::new(stream.try_clone()?),
    // rust: })))
}

pub fn set_read_timeout(self: *Self, timeout: ?Duration) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Plain { input, .. } => input.lock().unwrap().set_read_timeout(timeout),
    // rust: Self::Tls(tls) => tls.input.lock().unwrap().0.set_read_timeout(timeout),
}
}

    /// Plain bytes, as `Read::read`; 0 once the client closed the connection.
pub fn read(self: *Self, buf: []u8) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let tls = match self {
    // rust: Self::Plain { input, .. } => return input.lock().unwrap().read(buf),
    // rust: Self::Tls(tls) => tls,
}
    // rust: let mut input = tls.input.lock().unwrap();
    // rust: let (stream, pending) = &mut *input;
    // rust: loop {
    // rust: {
    // rust: let mut connection = tls.connection.lock().unwrap();
    // rust: match connection.reader().read(buf) {
    // rust: Ok(n) => return Ok(n),
    // rust: Err(e) if e.kind() == io::ErrorKind::WouldBlock => {}
    // rust: Err(e) => return Err(e),
}
    // rust: if !pending.is_empty() {
    // rust: let mut rest = &pending[..];
    // rust: let read = connection.read_tls(&mut rest);
    // rust: let taken = pending.len() - rest.len();
    // rust: pending.drain(..taken);
    // rust: read?;
    // rust: let processed = connection.process_new_packets();
                    // The handshake's answers, or the alert that says why it failed.
    // rust: tls.send(&mut connection)?;
    // rust: processed.map_err(|e| io::Error::new(io::ErrorKind::InvalidData, e))?;
    // rust: continue;
}
}
    // rust: let mut raw = [0u8; 16 * 1024];
    // rust: let n = stream.read(&mut raw)?;
    // rust: if n == 0 {
    // rust: return Ok(0);
}
    // rust: pending.extend_from_slice(&raw[..n]);
}
}

pub fn write_all(self: *Self, data: []const u8) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Plain { output, .. } => {
    // rust: let mut output = output.lock().unwrap();
    // rust: output.write_all(data)?;
    // rust: output.flush()
}
    // rust: Self::Tls(tls) => {
    // rust: let mut connection = tls.connection.lock().unwrap();
    // rust: connection.writer().write_all(data)?;
    // rust: tls.send(&mut connection)
}
}
}

    /// Ends the connection (with TLS's close_notify first).
pub fn shutdown(self: *Self) void {
}
    // rust: let output = match self {
    // rust: Self::Plain { output, .. } => output,
    // rust: Self::Tls(tls) => {
    // rust: let mut connection = tls.connection.lock().unwrap();
    // rust: connection.send_close_notify();
    // rust: let _ = tls.send(&mut connection);
    // rust: &tls.output
}
}
    // rust: let _ = output.lock().unwrap().shutdown(std::net::Shutdown::Both);
}
}

    // rust: impl Tls {
    /// Writes out the records the session has ready.
pub fn send(self: *Self, connection: *mut rustls::ServerConnection) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut output = self.output.lock().unwrap();
    // rust: while connection.wants_write() {
    // rust: connection.write_tls(&mut *output)?;
}
    // rust: output.flush()
}
}

    // rust: impl Read for &Link {
pub fn read(self: *Self, buf: []u8) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Link::read(self, buf)
}
}

    // rust: impl Write for &Link {
pub fn write(self: *Self, buf: []const u8) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Link::write_all(self, buf)?;
    // rust: Ok(buf.len())
}

pub fn flush(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(())
}
}

/// One open WebSocket. Reads come from one thread; any thread may send.
pub const Socket = struct {
    link: Link,
    reading: Mutex<()>,
};

    // rust: impl Socket {
pub fn new(link: Link) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: link.set_read_timeout(None)?;
    // rust: Ok(Self {
    // rust: link,
    // rust: reading: Mutex::new(()),
    // rust: })
}

    /// The next text message, or `None` once the client closed the socket.
pub fn read_text(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let _reading = self.reading.lock().unwrap();
    // rust: let mut stream = &self.link;
    // rust: let mut message = Vec::new();
    // rust: let mut text = false;
    // rust: loop {
    // rust: let mut head = [0u8; 2];
    // rust: if let Err(e) = stream.read_exact(&mut head) {
    // rust: return if e.kind() == io::ErrorKind::UnexpectedEof {
    // rust: Ok(None)
    // rust: } else {
    // rust: Err(e)
}
}
    // rust: let (fin, opcode) = (head[0] & 0x80 != 0, head[0] & 0x0f);
    // rust: if head[1] & 0x80 == 0 {
    // rust: return Err(invalid("a client's frame must be masked"));
}
    // rust: let length = match head[1] & 0x7f {
    // rust: 126 => {
    // rust: let mut b = [0u8; 2];
    // rust: stream.read_exact(&mut b)?;
    // rust: u64::from(u16::from_be_bytes(b))
}
    // rust: 127 => {
    // rust: let mut b = [0u8; 8];
    // rust: stream.read_exact(&mut b)?;
    // rust: u64::from_be_bytes(b)
}
    // rust: n => u64::from(n),
}
    // rust: if length > MAX_MESSAGE as u64 || message.len() + length as usize > MAX_MESSAGE {
    // rust: return Err(invalid("the message is longer than 65536 bytes"));
}
    // rust: let mut mask = [0u8; 4];
    // rust: stream.read_exact(&mut mask)?;
    // rust: let mut payload = vec![0u8; length as usize];
    // rust: stream.read_exact(&mut payload)?;
    // rust: for (i, b) in payload.iter_mut().enumerate() {
    // rust: *b ^= mask[i % 4];
}
    // rust: match opcode {
    // rust: CLOSE => {
    // rust: let _ = self.send(CLOSE, &payload[..payload.len().min(2)]);
    // rust: return Ok(None);
}
    // rust: PING => self.send(0x0a, &payload)?,
    // rust: 0x0a => {}
    // rust: 0..=2 => {
    // rust: if opcode != 0 {
    // rust: message.clear();
    // rust: text = opcode == TEXT;
}
    // rust: message.extend_from_slice(&payload);
    // rust: if fin && text {
    // rust: return String::from_utf8(message)
    // rust: .map(Some)
    // rust: .map_err(|_| invalid("a text message must be UTF-8"));
}
    // rust: if fin {
    // rust: message = Vec::new();
}
}
    // rust: _ => return Err(invalid("unknown frame opcode")),
}
}
}

pub fn send_text(self: *Self, text: []const u8) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.send(TEXT, text.as_bytes())
}

    /// Closes with a status code (1000: normal).
pub fn close(self: *Self, code: u16) void {
}
    // rust: let _ = self.send(CLOSE, &code.to_be_bytes());
    // rust: self.link.shutdown();
}

pub fn send(self: *Self, opcode: u8, payload: []const u8) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut frame = vec![0x80 | opcode];
    // rust: match payload.len() {
    // rust: n @ 0..=125 => frame.push(n as u8),
    // rust: n @ 126..=0xffff => {
    // rust: frame.push(126);
    // rust: frame.extend_from_slice(&(n as u16).to_be_bytes());
}
    // rust: n => {
    // rust: frame.push(127);
    // rust: frame.extend_from_slice(&(n as u64).to_be_bytes());
}
}
    // rust: frame.extend_from_slice(payload);
    // rust: self.link.write_all(&frame)
}
}

pub fn invalid(message: []const u8) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: io::Error::new(io::ErrorKind::InvalidData, message)
}

    // rust: mod tests {
//     use super::*;

pub fn the_accept_key_is_the_rfcs() void {
}
        // RFC 6455, section 1.3.
    // rust: assert_eq!(
    // rust: accept_key("dGhlIHNhbXBsZSBub25jZQ=="),
    // rust: "s3pPLMBiTxaQ9kYGzzhZRbK+xOo="
    // rust: );
}

    /// A client's frame: masked, as browsers send them.
pub fn frame(fin: bool, opcode: u8, payload: []const u8) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mask = [1u8, 2, 3, 4];
    // rust: let mut f = vec![if fin { 0x80 } else { 0 } | opcode];
    // rust: if payload.len() < 126 {
    // rust: f.push(0x80 | payload.len() as u8);
    // rust: } else {
    // rust: f.push(0x80 | 126);
    // rust: f.extend_from_slice(&(payload.len() as u16).to_be_bytes());
}
    // rust: f.extend_from_slice(&mask);
    // rust: f.extend(payload.iter().enumerate().map(|(i, b)| b ^ mask[i % 4]));
    // rust: f
}

pub fn messages_come_whole_and_pings_get_pongs() void {
}
    // rust: let listener = std::net::TcpListener::bind("127.0.0.1:0").unwrap();
    // rust: let mut client = TcpStream::connect(listener.local_addr().unwrap()).unwrap();
    // rust: let socket = Socket::new(Link::plain(&listener.accept().unwrap().0).unwrap()).unwrap();
    // rust: let long = "x".repeat(300);
    // rust: let mut sent = frame(false, TEXT, b"{\"a\":");
    // rust: sent.extend(frame(true, PING, b"hi"));
    // rust: sent.extend(frame(true, 0, b"1}"));
    // rust: sent.extend(frame(true, 2, b"binary is dropped"));
    // rust: sent.extend(frame(true, TEXT, long.as_bytes()));
    // rust: sent.extend(frame(true, CLOSE, &1000u16.to_be_bytes()));
    // rust: client.write_all(&sent).unwrap();
    // rust: assert_eq!(socket.read_text().unwrap().as_deref(), Some("{\"a\":1}"));
    // rust: assert_eq!(socket.read_text().unwrap(), Some(long));
    // rust: assert_eq!(socket.read_text().unwrap(), None);
    // rust: socket.send_text("ok").unwrap();
    // rust: let mut got = [0u8; 8];
    // rust: client.read_exact(&mut got).unwrap();
        // The pong, then the close's echo; the text after it.
    // rust: assert_eq!(&got[..4], &[0x8a, 2, b'h', b'i']);
    // rust: assert_eq!(&got[4..8], &[0x88, 2, 0x03, 0xe8]);
    // rust: let mut text = [0u8; 4];
    // rust: client.read_exact(&mut text).unwrap();
    // rust: assert_eq!(&text, &[0x81, 2, b'o', b'k']);
}

pub fn unmasked_and_oversized_frames_are_refused() void {
}
    // rust: let listener = std::net::TcpListener::bind("127.0.0.1:0").unwrap();
    // rust: let mut client = TcpStream::connect(listener.local_addr().unwrap()).unwrap();
    // rust: let socket = Socket::new(Link::plain(&listener.accept().unwrap().0).unwrap()).unwrap();
    // rust: client.write_all(&[0x81, 2, b'h', b'i']).unwrap();
    // rust: assert!(socket.read_text().is_err());
    // rust: let mut big = vec![0x81, 0x80 | 127];
    // rust: big.extend_from_slice(&(MAX_MESSAGE as u64 + 1).to_be_bytes());
    // rust: client.write_all(&big).unwrap();
    // rust: assert!(socket.read_text().is_err());
}
}
