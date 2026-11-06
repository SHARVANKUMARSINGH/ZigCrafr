//! Transpiled from Horizon Rust crate
package horizon_protocol_connection

import "core:fmt"
import "core:mem"
import "core:math"

// A blocking connection with vanilla's pipeline: optional AES/CFB8
// encryption, VarInt21 framing and threshold compression. After login it
// splits into a reader (for a receive thread) and a shareable writer, or
// gives its stream up ([`Connection::detach`]) to be polled without blocking,
// the halves then keeping only the framing, compression and encryption. It
// runs over TCP, or over an in-memory pipe between two threads of one process
// (vanilla's `LocalChannel`, which an integrated server's player uses).
// use crate::{Error, Result, buf::Reader, crypto::Cfb8, frame};
// use std::{
    // rust: io::{Read, Write},
    // rust: net::{Shutdown, SocketAddr, TcpStream, ToSocketAddrs},
    // rust: sync::{
    // rust: Arc, Condvar, Mutex,
    // rust: atomic::{AtomicI64, Ordering},
    // rust: },
    // rust: time::{Duration, Instant},
}

// Called when a [`Pipe`] end has bytes to read or was closed ([`Pipe::on_ready`]).
    // rust: type Notify = Arc<dyn Fn() + Send + Sync>;

// One direction of a [`Pipe`]: the bytes written and not read yet, and
// whether either end closed it.
Channel :: struct {
    state: Mutex<(std::collections::VecDeque<u8>,
    ready: Condvar,
    // The reading end's [`Pipe::on_ready`].
    notify: Mutex<Maybe(Notify)>,
}
    // rust: impl Channel {
close :: proc(self: ^Self) {
}
    // rust: self.state.lock().unwrap().1 = true;
    // rust: self.ready.notify_all();
    // rust: self.notify();
}
    // Tell a reader that doesn't block, outside the state's lock.
notify :: proc(self: ^Self) {
}
    // rust: let notify = self.notify.lock().unwrap().clone();
    // rust: if let Some(notify) = notify {
    // rust: notify();
}
}
}
// The channels of one end; dropping the end's last clone closes them, as
// a socket closes with its process.
End :: struct {
    incoming: ^Channel,
    outgoing: ^Channel,
}
    // rust: impl Drop for End {
drop :: proc(self: ^Self) {
}
    // rust: self.incoming.close();
    // rust: self.outgoing.close();
}
}
// One end of an in-memory byte pipe: what one end writes the other reads.
Pipe :: struct {
    end: ^End,
    // The read timeout (`set_read_timeout`).
    timeout: Mutex<Maybe(Duration)>,
    // Reads with nothing to read fail with `WouldBlock` instead of waiting.
    nonblocking: bool,
}
    // rust: impl Pipe {
    // Two connected ends.
pair :: proc() -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let (a, b) = (Arc::new(Channel::default()), Arc::new(Channel::default()));
    // rust: let end = |incoming, outgoing| Self {
    // rust: end: Arc::new(End { incoming, outgoing }),
    // rust: timeout: Mutex::new(None),
    // rust: nonblocking: false,
}
    // rust: (end(a.clone(), b.clone()), end(b, a))
}
try_clone :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: end: self.end.clone(),
    // rust: timeout: Mutex::new(*self.timeout.lock().unwrap()),
    // rust: nonblocking: self.nonblocking,
}
}
    // Reads with nothing to read fail with `WouldBlock`, as a non-blocking socket's do.
set_nonblocking :: proc(self: ^Self, nonblocking: bool) {
}
    // rust: self.nonblocking = nonblocking;
}
    // Call `notify` whenever bytes arrive at this end or the pipe closes (also
    // now, if either already happened), as a poller's readiness would: a
    // non-blocking reader then reads until `WouldBlock`.
on_ready :: proc(self: ^Self, notify: impl Fn() {
}
    // rust: let incoming = &self.end.incoming;
    // rust: *incoming.notify.lock().unwrap() = Some(Arc::new(notify));
    // rust: let state = incoming.state.lock().unwrap();
    // rust: let ready = !state.0.is_empty() || state.1;
    // rust: drop(state);
    // rust: if ready {
    // rust: incoming.notify();
}
}
    // Close both directions: reads at either end then see the end of the stream.
shutdown :: proc(self: ^Self) {
}
    // rust: self.end.incoming.close();
    // rust: self.end.outgoing.close();
}
}
    // rust: impl Read for Pipe {
read :: proc(self: ^Self, out: []u8) -> s {
    // Ported from Horizon
    return {}
}
    // rust: let deadline = self.timeout.lock().unwrap().map(|t| Instant::now() + t);
    // rust: let mut state = self.end.incoming.state.lock().unwrap();
    // rust: if self.nonblocking && state.0.is_empty() && !state.1 {
    // rust: return Err(std::io::ErrorKind::WouldBlock.into());
}
    // rust: while state.0.is_empty() && !state.1 {
    // rust: state = match deadline {
    // rust: None => self.end.incoming.ready.wait(state).unwrap(),
    // rust: Some(deadline) => {
    // rust: let left = deadline.saturating_duration_since(Instant::now());
    // rust: if left.is_zero() {
    // rust: return Err(std::io::ErrorKind::TimedOut.into());
}
    // rust: self.end.incoming.ready.wait_timeout(state, left).unwrap().0
}
}
}
    // rust: state.0.read(out)
}
}
    // rust: impl Write for Pipe {
write :: proc(self: ^Self, data: []u8) -> s {
    // Ported from Horizon
    return {}
}
    // rust: let mut state = self.end.outgoing.state.lock().unwrap();
    // rust: if state.1 {
    // rust: return Err(std::io::ErrorKind::BrokenPipe.into());
}
    // rust: state.0.extend(data);
    // rust: self.end.outgoing.ready.notify_all();
    // rust: drop(state);
    // rust: self.end.outgoing.notify();
    // rust: Ok(data.len())
}
flush :: proc(self: ^Self) -> s {
    // Ported from Horizon
    return {}
}
    // rust: Ok(())
}
}

// What a connection runs over.
Stream :: enum {
    Tcp(TcpStream),
    Memory(Pipe),
    // Given up by [`Connection::detach`]: reads and writes fail.
    Detached,
}
detached :: proc() -> s {
    // Ported from Horizon
    return {}
}
    // rust: std::io::ErrorKind::NotConnected.into()
}
    // rust: impl Stream {
try_clone :: proc(self: ^Self) -> s {
    // Ported from Horizon
    return {}
}
    // rust: Ok(match self {
    // rust: Self::Tcp(s) => Self::Tcp(s.try_clone()?),
    // rust: Self::Memory(p) => Self::Memory(p.try_clone()),
    // rust: Self::Detached => Self::Detached,
    // rust: })
}
set_read_timeout :: proc(self: ^Self, timeout: Maybe(Duration)) -> s {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::Tcp(s) => s.set_read_timeout(timeout),
    // rust: Self::Memory(p) => {
    // rust: *p.timeout.lock().unwrap() = timeout;
    // rust: Ok(())
}
    // rust: Self::Detached => Ok(()),
}
}
shutdown :: proc(self: ^Self) {
}
    // rust: match self {
    // rust: Self::Tcp(s) => {
    // rust: let _ = s.shutdown(Shutdown::Both);
}
    // rust: Self::Memory(p) => p.shutdown(),
    // rust: Self::Detached => {}
}
}
}
    // rust: impl Read for Stream {
read :: proc(self: ^Self, out: []u8) -> s {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::Tcp(s) => s.read(out),
    // rust: Self::Memory(p) => p.read(out),
    // rust: Self::Detached => Err(detached()),
}
}
}
    // rust: impl Write for Stream {
write :: proc(self: ^Self, data: []u8) -> s {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::Tcp(s) => s.write(data),
    // rust: Self::Memory(p) => p.write(data),
    // rust: Self::Detached => Err(detached()),
}
}
flush :: proc(self: ^Self) -> s {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::Tcp(s) => s.flush(),
    // rust: Self::Memory(p) => p.flush(),
    // rust: Self::Detached => Err(detached()),
}
}
}

// A connection's stream, given up by [`Connection::detach`].
Socket :: enum {
    Tcp(TcpStream),
    Memory(Pipe),
}

// Packets received/sent and bytes in/out, for the debug screen.
Counters :: struct {
    received: AtomicI64,
    sent: AtomicI64,
    bytes_in: AtomicI64,
    bytes_out: AtomicI64,
}

ConnReader :: struct {
    stream: Stream,
    // Bytes read: `buffer[start..end]` are not consumed yet, and reads go
    // straight into `buffer[end..]`.
    buffer: [dynamic]u8,
    start: uint,
    end: uint,
    inflater: frame::Inflater,
    decrypt: Maybe(Cfb8),
    threshold: Maybe(uint),
    counters: ^Counters,
    // Set for a server of an older release: what arrives is renumbered.
    adapter: Maybe(^crate::adapter::Session),
    // Set on a server for a client of an older release: what arrives is renumbered.
    older_client: Maybe(^crate::adapter::ClientSession),
}
// Closes a connection from another thread: a read or a write blocked on it fails.
Closer :: struct {
    // rust: impl Closer {
close :: proc(self: ^Self) {
}
    // rust: self.0.shutdown();
}
}

ConnWriter :: struct {
    stream: Stream,
    encrypt: Maybe(Cfb8),
    threshold: Maybe(uint),
    counters: ^Counters,
    // Set for a server of an older release: what is sent is renumbered.
    adapter: Maybe(^crate::adapter::Session),
    // Set on a server for a client of an older release: what is sent is renumbered.
    older_client: Maybe(^crate::adapter::ClientSession),
}
// `InetAddress.getByName` under Java's default `java.net.preferIPv6Addresses=false`: IPv4
// addresses first, whatever order the system resolver gives (macOS lists IPv6 first). Vanilla
// connects to that first address only; the rest stay here as fallbacks.
ipv4_first :: proc(mut addrs: [dynamic]SocketAddr) -> V {
    // Ported from Horizon
    return {}
}
    // rust: addrs.sort_by_key(SocketAddr::is_ipv6);
    // rust: addrs
}
// RFC 8305's connection attempt delay: how long an address has alone before the next
// one is tried beside it.
ATTEMPT_DELAY :: Duration::from_millis(250)
// Both halves before the split.
Connection :: struct {
    reader: ConnReader,
    writer: ConnWriter,
}
    // rust: impl Connection {
connect :: proc(host: string, port: u16, timeout: Duration) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let addrs: Vec<_> = (host, port)
    // rust: .to_socket_addrs()
    // rust: .map_err(|e| Error::new(format!("Unknown host {host}: {e}")))?
    // rust: .collect();
    // rust: Self::connect_addresses(host, addrs, timeout)
}
    // Connect through Minecraft's SRV redirect. Status requests still use the
    // original address in their handshake (`ServerStatusPinger.pingServer`).
connect_server :: proc(host: string, port: u16, timeout: Duration) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Self::connect_server_with_address(host, port, timeout).map(|(connection, _, _)| connection)
}
    // `ConnectScreen.startConnecting`: login handshakes use the resolved host
    // and port, including an SRV redirect, rather than the status request's address.
    // rust: pub fn connect_server_with_address(
    // rust: host: &str,
    // rust: port: u16,
    // rust: timeout: Duration,
    // rust: ) -> Result<(Self, String, u16)> {
    // rust: let resolved = crate::resolver::resolve(host, port)?;
    // rust: let connection = Self::connect_addresses(host, resolved.addresses, timeout)?;
    // rust: Ok((connection, resolved.host, resolved.port))
}
    // Each address starts once the earlier ones fail or [`ATTEMPT_DELAY`] after the last
    // start, alongside those still trying, and the first to connect wins: a dead address
    // in a round-robin set costs 250 ms instead of the whole timeout.
connect_addresses :: proc(host: string, addrs: [dynamic]SocketAddr, timeout: Duration) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let addrs = ipv4_first(addrs);
    // rust: let (send, recv) = std::sync::mpsc::channel();
    // rust: let mut errors: Vec<Option<std::io::Error>> = addrs.iter().map(|_| None).collect();
    // rust: let (mut started, mut pending) = (0, 0);
    // rust: loop {
    // rust: if let Some(&addr) = addrs.get(started) {
    // rust: let (send, index) = (send.clone(), started);
    // rust: let spawned = std::thread::Builder::new()
    // rust: .name("horizon-connect".into())
    // rust: .spawn(move || {
    // rust: let _ = send.send((index, TcpStream::connect_timeout(&addr, timeout)));
    // rust: });
    // rust: match spawned {
    // rust: Ok(_) => pending += 1,
    // rust: Err(e) => errors[index] = Some(e),
}
    // rust: started += 1;
}
    // rust: if pending == 0 {
    // rust: if started < addrs.len() {
    // rust: continue;
}
    // rust: break;
}
    // rust: let reply = if started < addrs.len() {
    // rust: match recv.recv_timeout(ATTEMPT_DELAY) {
    // rust: Ok(reply) => reply,
    // rust: Err(_) => continue,
}
    // rust: } else {
    // rust: recv.recv().expect("a sender is held here")
}
    // rust: pending -= 1;
    // rust: match reply {
    // rust: (_, Ok(stream)) => return Self::from_stream(stream),
    // rust: (index, Err(e)) => errors[index] = Some(e),
}
}
        // Report the first address's failure: it is the one vanilla tries, and the IPv6
        // fallbacks after it often fail only because the client has no IPv6 route.
    // rust: match errors.into_iter().flatten().next() {
    // rust: Some(e) => Err(Error::new(format!("Connection refused: {e}"))),
    // rust: None => Err(Error::new(format!("Unknown host {host}"))),
}
}
from_stream :: proc(stream: TcpStream) -> R {
    // Ported from Horizon
    return {}
}
    // rust: stream.set_nodelay(true)?;
    // rust: Self::over(Stream::Tcp(stream))
}
    // A connection over one end of an in-memory [`Pipe`].
local :: proc(pipe: Pipe) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self::over(Stream::Memory(pipe)).expect("a pipe end clones")
}
over :: proc(stream: Stream) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let counters = Arc::new(Counters::default());
    // rust: let write = stream.try_clone()?;
    // rust: Ok(Self {
    // rust: reader: ConnReader {
    // rust: stream,
    // rust: buffer: Vec::new(),
    // rust: start: 0,
    // rust: end: 0,
    // rust: inflater: frame::Inflater::default(),
    // rust: decrypt: None,
    // rust: threshold: None,
    // rust: counters: counters.clone(),
    // rust: adapter: None,
    // rust: older_client: None,
    // rust: },
    // rust: writer: ConnWriter {
    // rust: stream: write,
    // rust: encrypt: None,
    // rust: threshold: None,
    // rust: counters,
    // rust: adapter: None,
    // rust: older_client: None,
    // rust: },
    // rust: })
}
    // Speak to a server of `version` from now on (before the handshake): packets are renumbered both
    // ways (crate::adapter). The pinned version needs nothing.
adapt :: proc(self: ^Self, version: crate::adapter::ServerVersion) {
}
    // rust: let session = (version != crate::adapter::ServerVersion::Current)
    // rust: .then(|| Arc::new(crate::adapter::Session::new(version)));
    // rust: self.reader.adapter = session.clone();
    // rust: self.writer.adapter = session;
}
    // Serve a client of `version` from now on (after its handshake): packets are renumbered both ways
    // (crate::adapter::ClientSession). The pinned version needs nothing.
serve_older :: proc(self: ^Self, version: crate::adapter::ServerVersion) {
}
    // rust: let session = (version != crate::adapter::ServerVersion::Current)
    // rust: .then(|| Arc::new(crate::adapter::ClientSession::new(version)));
    // rust: self.reader.older_client = session.clone();
    // rust: self.writer.older_client = session;
}
    // The older release this connection's client is on ([`Self::serve_older`]), `None` for the pinned one.
older_client :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.reader.older_client.as_ref().map(|s| s.version)
}
    // `Connection.isMemoryConnection`: through a [`Pipe`] rather than a socket.
is_memory :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: matches!(self.reader.stream, Stream::Memory(_))
}
    // ClientboundLoginCompressionPacket: negative thresholds disable compression.
set_compression :: proc(self: ^Self, threshold: i32) {
}
    // rust: let t = usize::try_from(threshold).ok();
    // rust: self.reader.threshold = t;
    // rust: self.writer.threshold = t;
}
    // Connection.setEncryptionKey: both directions keyed with the shared secret.
enable_encryption :: proc(self: ^Self, secret: ^[u8; 16]) {
}
    // rust: let mut decrypt = Cfb8::new(secret, secret);
        // Bytes already read past the last packet were sent encrypted.
    // rust: let r = &mut self.reader;
    // rust: decrypt.decrypt(&mut r.buffer[r.start..r.end]);
    // rust: self.reader.decrypt = Some(decrypt);
    // rust: self.writer.encrypt = Some(Cfb8::new(secret, secret));
}
send :: proc(self: ^Self, body: []u8) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.writer.send(body)
}
recv :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.reader.recv()
}
split :: proc(self: ^Self) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: (self.reader, self.writer)
}
    // Take the stream out, to read and write it elsewhere (a poller's thread,
    // without blocking): the halves keep the framing, compression and
    // encryption, and bytes already read past the last packet. What arrives
    // goes in through [`ConnReader::read_from`]; [`ConnWriter::frame_into`]
    // makes what is to be sent. Their own reads and writes fail from now on.
detach :: proc() -> ( {
    // Ported from Horizon
    return {}
}
    // rust: self.writer.stream = Stream::Detached;
    // rust: let socket = match std::mem::replace(&mut self.reader.stream, Stream::Detached) {
    // rust: Stream::Tcp(s) => Socket::Tcp(s),
    // rust: Stream::Memory(p) => Socket::Memory(p),
    // rust: Stream::Detached => unreachable!("a connection is detached once, by value"),
}
    // rust: (socket, self.reader, self.writer)
}
}

// The next frame in a reader's buffer.
Next :: enum {
    Packet((i32, Vec<u8>)),
    // A frame with no packet in it.
    Empty,
    // No whole frame yet: the bytes it needs, once its length is known (0 before).
    Partial(usize),
}
    // rust: impl ConnReader {
    // Read exactly `len` bytes as they are, with no framing.
read_raw :: proc(self: ^Self, len: uint) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = vec![0u8; len];
    // rust: self.stream.read_exact(&mut out)?;
    // rust: Ok(out)
}
    // Block until a whole packet arrives: (id, payload).
recv :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if let Some(packet) = self.adapter.as_ref().and_then(|a| a.next_incoming()) {
    // rust: return Ok(packet);
}
    // rust: loop {
    // rust: match self.next()? {
    // rust: Next::Packet((id, payload)) if self.older_client.is_some() => {
    // rust: let client = self.older_client.as_ref().expect("checked");
    // rust: if let Some(packet) = client.serverbound(id, payload)? {
    // rust: return Ok(packet);
}
}
    // rust: Next::Packet(packet) => match &self.adapter {
    // rust: None => return Ok(packet),
    // rust: Some(a) => {
    // rust: if let Some(packet) = a.clientbound(packet.0, packet.1)? {
    // rust: return Ok(packet);
}
    // rust: if let Some(packet) = a.next_incoming() {
    // rust: return Ok(packet);
}
}
    // rust: },
    // rust: Next::Empty => {}
    // rust: Next::Partial(wanted) => self.fill(wanted)?,
}
}
}
    // The next whole packet among the bytes already read, without reading
    // more: for a detached reader, after [`Self::read_from`]. Only an older
    // client's renumbering applies (a server's connection has no other).
buffered :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: loop {
    // rust: match self.next()? {
    // rust: Next::Packet((id, payload)) if self.older_client.is_some() => {
    // rust: let client = self.older_client.as_ref().expect("checked");
    // rust: if let Some(packet) = client.serverbound(id, payload)? {
    // rust: return Ok(Some(packet));
}
}
    // rust: Next::Packet(packet) => return Ok(Some(packet)),
    // rust: Next::Empty => {}
    // rust: Next::Partial(_) => return Ok(None),
}
}
}
    // Read once from `source` (a detached stream, without blocking) into the
    // buffer: the bytes read, 0 at the end of the stream, or its error
    // (`WouldBlock` when nothing waits).
read_from :: proc(self: ^Self, source: ^impl Read) -> s {
    // Ported from Horizon
    return {}
}
    // rust: let wanted = match self.next_header() {
    // rust: Ok(Some(wanted)) => wanted,
    // rust: _ => 0,
}
    // rust: self.fill_from(source, wanted)
}
    // The bytes the next frame needs, once its length prefix is whole.
next_header :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(frame::header(&self.buffer[self.start..self.end])?.map(|(prefix, len)| prefix + len))
}
    // Take the next frame off the buffer, if it is whole.
next :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let Some(wanted) = self.next_header()? else {
    // rust: return Ok(Next::Partial(0));
}
    // rust: if self.end - self.start < wanted {
    // rust: return Ok(Next::Partial(wanted));
}
    // rust: let (prefix, _) = frame::header(&self.buffer[self.start..self.end])?.expect("whole");
    // rust: let frame = self.start + prefix..self.start + wanted;
    // rust: self.start = frame.end;
    // rust: Ok(match self.packet(frame)? {
    // rust: Some(packet) => {
    // rust: self.counters.received.fetch_add(1, Ordering::Relaxed);
    // rust: Next::Packet(packet)
}
    // rust: None => Next::Empty,
    // rust: })
}
    // The packet in `buffer[frame]`, or `None` for a frame with no packet in it:
    // vanilla's PacketDecoder only decodes a packet from a readable buffer, so an
    // empty compressed frame is skipped and the connection stays up.
packet :: proc(self: ^Self, frame: std::ops::Range<uint>) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let frame = &self.buffer[frame];
    // rust: match frame::body(frame, self.threshold, &mut self.inflater)? {
    // rust: frame::Body::Plain(at) => {
    // rust: let body = &frame[at..];
    // rust: if body.is_empty() {
    // rust: return Ok(None);
}
    // rust: let mut r = Reader::new(body);
    // rust: let id = r.varint()?;
    // rust: Ok(Some((id, body[r.position()..].to_vec())))
}
    // rust: frame::Body::Inflated(mut body) => {
    // rust: let mut r = Reader::new(&body);
    // rust: let id = r.varint()?;
    // rust: let at = r.position();
    // rust: body.drain(..at);
    // rust: Ok(Some((id, body)))
}
}
}
    // Read once from the stream into the buffer, with room for at least
    // `frame` bytes of unconsumed data (a whole frame, once its length is known).
fill :: proc(self: ^Self, frame: uint) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let mut stream = std::mem::replace(&mut self.stream, Stream::Detached);
    // rust: let read = self.fill_from(&mut stream, frame);
    // rust: self.stream = stream;
    // rust: match read {
    // rust: Ok(0) => Err(Error::end_of_stream()),
    // rust: Ok(_) => Ok(()),
            // A signal (a profiler attaching, SIGCHLD...) cut the read short
            // before any byte came: nothing is wrong with the connection, the
            // caller reads again.
    // rust: Err(e) if e.kind() == std::io::ErrorKind::Interrupted => Ok(()),
            // The read timeout passed: Windows reports TimedOut, Unix
            // WouldBlock.
    // rust: Err(e)
    // rust: if matches!(
    // rust: e.kind(),
    // rust: std::io::ErrorKind::TimedOut | std::io::ErrorKind::WouldBlock
    // rust: ) =>
    // rust: {
    // rust: Err(Error::timed_out())
}
    // rust: Err(e) => Err(e.into()),
}
}
    // [`Self::fill`] from `source`: the bytes read, decrypted into the buffer.
fill_from :: proc(self: ^Self, source: ^impl Read, frame: uint) -> s {
    // Ported from Horizon
    return {}
}
READ :: 1 << 16
    // rust: let pending = self.end - self.start;
    // rust: let room = READ.max(frame.saturating_sub(pending));
    // rust: if self.buffer.len() - self.end < room {
    // rust: self.buffer.copy_within(self.start..self.end, 0);
    // rust: (self.start, self.end) = (0, pending);
    // rust: if self.buffer.len() < pending + room {
    // rust: self.buffer.resize(pending + room, 0);
}
}
    // rust: let n = source.read(&mut self.buffer[self.end..])?;
    // rust: self.counters
    // rust: .bytes_in
    // rust: .fetch_add(n as i64, Ordering::Relaxed);
    // rust: let data = &mut self.buffer[self.end..self.end + n];
    // rust: if let Some(c) = &mut self.decrypt {
    // rust: c.decrypt(data);
}
    // rust: self.end += n;
    // rust: Ok(n)
}
    // A [`Closer`] for this connection.
closer :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(Closer(self.stream.try_clone()?))
}
set_read_timeout :: proc(self: ^Self, timeout: Maybe(Duration)) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(self.stream.set_read_timeout(timeout)?)
}
}
    // rust: impl ConnWriter {
    // Write bytes as they are, with no framing: the legacy server list ping
    // (`LegacyServerPinger`) is not a framed protocol.
write_raw :: proc(self: ^Self, data: []u8) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.stream.write_all(data)?;
    // rust: self.stream.flush()?;
    // rust: Ok(())
}
    // A packet body as this connection's client takes it: renumbered for a client of an older release
    // ([`Connection::serve_older`]), `None` when it has no such packet; as it is otherwise.
    // rust: pub fn for_client<'a>(&self, body: &'a [u8]) -> Result<Option<std::borrow::Cow<'a, [u8]>>> {
    // rust: match &self.older_client {
    // rust: None => Ok(Some(std::borrow::Cow::Borrowed(body))),
    // rust: Some(client) => Ok(client.clientbound(body)?.map(std::borrow::Cow::Owned)),
}
}
    // Send one packet body (VarInt id + payload).
send :: proc(self: ^Self, body: []u8) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if self.older_client.is_some() {
    // rust: return match self.for_client(body)? {
    // rust: Some(body) => self.send_contents(&frame::contents(&body, self.threshold)?),
    // rust: None => Ok(()),
}
}
    // rust: if let Some(a) = self.adapter.clone() {
    // rust: if let Some(body) = a.serverbound(body)? {
    // rust: self.send_contents(&frame::contents(&body, self.threshold)?)?;
}
    // rust: for body in a.take_outgoing() {
    // rust: self.send_contents(&frame::contents(&body, self.threshold)?)?;
}
    // rust: return Ok(());
}
    // rust: self.send_contents(&frame::contents(body, self.threshold)?)
}
    // Send a frame whose contents [`frame::contents`] made with this
    // writer's threshold.
send_contents :: proc(self: ^Self, contents: []u8) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let mut framed = Vec::with_capacity(contents.len() + 3);
    // rust: self.frame_into(contents, &mut framed);
    // rust: self.stream.write_all(&framed)?;
    // rust: Ok(())
}
    // The bytes [`Self::send_contents`] writes, appended to `out` instead: a
    // detached writer's, written later, in the order framed (the cipher
    // runs on).
frame_into :: proc(self: ^Self, contents: []u8, out: ^[dynamic]u8) {
}
    // rust: let at = out.len();
    // rust: crate::buf::write_varint(out, contents.len() as i32);
    // rust: out.extend_from_slice(contents);
    // rust: if let Some(c) = &mut self.encrypt {
    // rust: c.encrypt(&mut out[at..]);
}
    // rust: self.counters.sent.fetch_add(1, Ordering::Relaxed);
    // rust: self.counters
    // rust: .bytes_out
    // rust: .fetch_add((out.len() - at) as i64, Ordering::Relaxed);
}
shutdown :: proc(self: ^Self) {
}
    // rust: self.stream.shutdown();
}
}

    // rust: mod tests {
//     use super::*;
//     use std::net::TcpListener;

ipv4_first_keeps_each_familys_order :: proc() {
}
    // rust: let a = |s: &str| s.parse::<SocketAddr>().unwrap();
    // rust: let resolved = vec![
    // rust: a("[2001:db8::1]:25565"),
    // rust: a("192.0.2.1:25565"),
    // rust: a("[2001:db8::2]:25565"),
    // rust: a("10.0.0.1:25565"),
    // rust: ];
    // rust: assert_eq!(
    // rust: ipv4_first(resolved),
    // rust: [
    // rust: a("192.0.2.1:25565"),
    // rust: a("10.0.0.1:25565"),
    // rust: a("[2001:db8::1]:25565"),
    // rust: a("[2001:db8::2]:25565"),
    // rust: ]
    // rust: );
}

peer :: proc(c: ^Connection) -> S {
    // Ported from Horizon
    return {}
}
    // rust: match &c.reader.stream {
    // rust: Stream::Tcp(s) => s.peer_addr().unwrap(),
    // rust: Stream::Memory(_) | Stream::Detached => panic!("not a socket"),
}
}

    // Binds `[::1]`, or `None` where the machine has no IPv6 loopback.
ipv6_loopback :: proc() -> O {
    // Ported from Horizon
    return {}
}
    // rust: let listener = TcpListener::bind("[::1]:0");
    // rust: if listener.is_err() {
    // rust: eprintln!("skipped: no IPv6 loopback");
}
    // rust: listener.ok()
}

connects_to_ipv4_although_the_resolver_lists_ipv6_first :: proc() {
}
        // Both listen, as with a server whose IPv6 address accepts and then resets.
    // rust: let Some(v6_listener) = ipv6_loopback() else {
    // rust: return;
}
    // rust: let v4_listener = TcpListener::bind("127.0.0.1:0").unwrap();
    // rust: let v6 = v6_listener.local_addr().unwrap();
    // rust: let v4 = v4_listener.local_addr().unwrap();
    // rust: let c =
    // rust: Connection::connect_addresses("test", vec![v6, v4], Duration::from_secs(5)).unwrap();
    // rust: assert_eq!(peer(&c), v4);
}

falls_back_to_ipv6_when_ipv4_refuses :: proc() {
}
    // rust: let Some(v6_listener) = ipv6_loopback() else {
    // rust: return;
}
    // rust: let v6 = v6_listener.local_addr().unwrap();
    // rust: let closed = TcpListener::bind("127.0.0.1:0")
    // rust: .unwrap()
    // rust: .local_addr()
    // rust: .unwrap();
    // rust: let c = Connection::connect_addresses("test", vec![v6, closed], Duration::from_secs(5))
    // rust: .unwrap();
    // rust: assert_eq!(peer(&c), v6);
}

a_dead_address_does_not_hold_up_the_next :: proc() {
}
        // TEST-NET-1 never answers (or is unreachable at once).
    // rust: let dead: SocketAddr = "192.0.2.1:25565".parse().unwrap();
    // rust: let listener = TcpListener::bind("127.0.0.1:0").unwrap();
    // rust: let live = listener.local_addr().unwrap();
    // rust: let start = Instant::now();
    // rust: let c = Connection::connect_addresses("test", vec![dead, live], Duration::from_secs(10))
    // rust: .unwrap();
    // rust: assert_eq!(peer(&c), live);
    // rust: assert!(
    // rust: start.elapsed() < Duration::from_secs(5),
    // rust: "{:?}",
    // rust: start.elapsed()
    // rust: );
}

every_failure_reports_the_first_address :: proc() {
}
    // rust: let closed = |_| {
    // rust: TcpListener::bind("127.0.0.1:0")
    // rust: .unwrap()
    // rust: .local_addr()
    // rust: .unwrap()
}
    // rust: let error = |host, addrs| {
    // rust: Connection::connect_addresses(host, addrs, Duration::from_secs(5))
    // rust: .err()
    // rust: .unwrap()
    // rust: .to_string()
}
    // rust: let refused = error("test", (0..3).map(closed).collect());
    // rust: assert!(refused.starts_with("Connection refused"), "{refused}");
    // rust: assert_eq!(error("nowhere", Vec::new()), "Unknown host nowhere");
}

a_silent_peer_times_out_and_a_closed_one_ends_the_stream :: proc() {
}
    // rust: let listener = TcpListener::bind("127.0.0.1:0").unwrap();
    // rust: let port = listener.local_addr().unwrap().port();
    // rust: let mut c = Connection::connect("127.0.0.1", port, Duration::from_secs(5)).unwrap();
    // rust: let (server, _) = listener.accept().unwrap();
    // rust: c.reader
    // rust: .set_read_timeout(Some(Duration::from_millis(100)))
    // rust: .unwrap();
    // rust: let silent = c.recv().unwrap_err();
    // rust: assert!(silent.is_timed_out(), "{silent}");
    // rust: assert_eq!(silent.to_string(), "Timed out");
    // rust: drop(server);
    // rust: let closed = c.recv().unwrap_err();
    // rust: assert!(closed.is_end_of_stream(), "{closed}");
}

loopback_with_compression_and_encryption :: proc() {
}
    // rust: let listener = TcpListener::bind("127.0.0.1:0").unwrap();
    // rust: let port = listener.local_addr().unwrap().port();
    // rust: let server = std::thread::spawn(move || {
    // rust: let (stream, _) = listener.accept().unwrap();
    // rust: let mut c = Connection::from_stream(stream).unwrap();
    // rust: let (id, payload) = c.recv().unwrap();
    // rust: assert_eq!((id, payload.as_slice()), (0, &b"plain"[..]));
    // rust: c.enable_encryption(&[7; 16]);
    // rust: c.set_compression(64);
    // rust: let (id, payload) = c.recv().unwrap();
    // rust: assert_eq!((id, payload.len()), (5, 1000));
    // rust: let mut body = vec![9];
    // rust: body.extend_from_slice(b"reply");
    // rust: c.send(&body).unwrap();
    // rust: });
    // rust: let mut c = Connection::connect("127.0.0.1", port, Duration::from_secs(5)).unwrap();
    // rust: let mut body = vec![0];
    // rust: body.extend_from_slice(b"plain");
    // rust: c.send(&body).unwrap();
    // rust: c.enable_encryption(&[7; 16]);
    // rust: c.set_compression(64);
    // rust: let mut big = vec![5];
    // rust: big.extend(std::iter::repeat_n(3u8, 1000));
    // rust: c.send(&big).unwrap();
    // rust: let (id, payload) = c.recv().unwrap();
    // rust: assert_eq!((id, payload.as_slice()), (9, &b"reply"[..]));
    // rust: server.join().unwrap();
}

local_pipe_carries_packets_and_closes :: proc() {
}
    // rust: let (a, b) = Pipe::pair();
    // rust: let server = std::thread::spawn(move || {
    // rust: let mut c = Connection::local(b);
    // rust: c.set_compression(64);
    // rust: let (id, payload) = c.recv().unwrap();
    // rust: assert_eq!((id, payload.len()), (5, 1000));
    // rust: c.send(&[9, 1, 2]).unwrap();
    // rust: let (_, writer) = c.split();
    // rust: writer.shutdown();
    // rust: });
    // rust: let mut c = Connection::local(a);
    // rust: c.set_compression(64);
    // rust: let mut big = vec![5];
    // rust: big.extend(std::iter::repeat_n(3u8, 1000));
    // rust: c.send(&big).unwrap();
    // rust: assert_eq!(c.recv().unwrap(), (9, vec![1, 2]));
    // rust: assert_eq!(c.reader.counters.sent.load(Ordering::Relaxed), 1);
    // rust: assert_eq!(c.reader.counters.received.load(Ordering::Relaxed), 1);
    // rust: server.join().unwrap();
    // rust: assert!(c.recv().is_err());
}

    // Packets from one byte to past the read size, compressed and
    // encrypted, arrive whole and in order however the reads cut them.
packets_of_every_size_arrive_whole :: proc() {
}
    // rust: let (a, b) = Pipe::pair();
    // rust: let bodies: Vec<Vec<u8>> = (0..400u32)
    // rust: .map(|i| {
    // rust: let len = [1, 2, 63, 64, 65, 300, 4000, 70_000, 200_000][i as usize % 9];
    // rust: (0..len).map(|j| (j as u32 * 31 + i) as u8 & 0x7f).collect()
    // rust: })
    // rust: .collect();
    // rust: let sent = bodies.clone();
    // rust: let server = std::thread::spawn(move || {
    // rust: let mut c = Connection::local(b);
    // rust: c.set_compression(64);
    // rust: c.enable_encryption(&[3; 16]);
    // rust: for body in &sent {
    // rust: c.send(body).unwrap();
}
    // rust: c
    // rust: });
    // rust: let mut c = Connection::local(a);
    // rust: c.set_compression(64);
    // rust: c.enable_encryption(&[3; 16]);
    // rust: for body in &bodies {
    // rust: let (id, payload) = c.recv().unwrap();
    // rust: assert_eq!(id, i32::from(body[0]));
    // rust: assert_eq!(payload, body[1..]);
}
    // rust: drop(server.join().unwrap());
}

dropping_a_pipe_end_closes_it :: proc() {
}
    // rust: let (a, b) = Pipe::pair();
    // rust: let mut c = Connection::local(a);
    // rust: drop(b);
    // rust: assert!(c.recv().is_err());
    // rust: assert!(c.send(&[1]).is_err());
}

local_pipe_read_times_out :: proc() {
}
    // rust: let (a, _b) = Pipe::pair();
    // rust: let mut c = Connection::local(a);
    // rust: c.reader
    // rust: .set_read_timeout(Some(Duration::from_millis(20)))
    // rust: .unwrap();
    // rust: assert!(c.recv().is_err());
}

    // Encrypted bytes that arrive in the same read as the last plain packet
    // are decrypted once encryption is enabled.
encrypted_bytes_read_before_enabling_encryption :: proc() {
}
    // rust: let listener = TcpListener::bind("127.0.0.1:0").unwrap();
    // rust: let port = listener.local_addr().unwrap().port();
    // rust: let (sent, both_sent) = std::sync::mpsc::channel();
    // rust: let client = std::thread::spawn(move || {
    // rust: let mut c = Connection::connect("127.0.0.1", port, Duration::from_secs(5)).unwrap();
    // rust: c.send(&[0, 1, 2]).unwrap();
    // rust: c.enable_encryption(&[7; 16]);
    // rust: c.send(&[5, 4, 3]).unwrap();
    // rust: sent.send(c).unwrap();
    // rust: });
    // rust: let (stream, _) = listener.accept().unwrap();
    // rust: let mut c = Connection::from_stream(stream).unwrap();
    // rust: let _keep_open = both_sent.recv().unwrap();
    // rust: assert_eq!(c.recv().unwrap(), (0, vec![1, 2]));
    // rust: c.enable_encryption(&[7; 16]);
    // rust: assert_eq!(c.recv().unwrap(), (5, vec![4, 3]));
    // rust: client.join().unwrap();
}

    // A server may send a compressed frame that carries no packet: the
    // uncompressed length is 0 and the frame holds nothing else. Vanilla
    // skips it (its PacketDecoder only reads a packet from a readable
    // buffer), so the client stays connected.
an_empty_compressed_frame_is_skipped :: proc() {
}
    // rust: let listener = TcpListener::bind("127.0.0.1:0").unwrap();
    // rust: let port = listener.local_addr().unwrap().port();
    // rust: let server = std::thread::spawn(move || {
    // rust: let (stream, _) = listener.accept().unwrap();
    // rust: let mut c = Connection::from_stream(stream).unwrap();
    // rust: c.set_compression(64);
            // The empty frame: its length prefix, then the uncompressed
            // length 0 and nothing else.
    // rust: c.writer.send_contents(&[0]).unwrap();
    // rust: let mut body = vec![3];
    // rust: body.extend_from_slice(b"after");
    // rust: c.writer.send(&body).unwrap();
    // rust: });
    // rust: let mut c = Connection::connect("127.0.0.1", port, Duration::from_secs(5)).unwrap();
    // rust: c.set_compression(64);
    // rust: let (id, payload) = c.recv().unwrap();
    // rust: assert_eq!((id, payload.as_slice()), (3, &b"after"[..]));
    // rust: server.join().unwrap();
}
}
