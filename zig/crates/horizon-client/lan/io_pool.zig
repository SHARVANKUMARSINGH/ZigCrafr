//! Transpiled from Horizon Rust crate
//! Module: horizon-client_io_pool
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The network threads of the play state: a fixed pool, one thread per two
//! cores, each polling its players' sockets (epoll, kqueue or Windows' AFD,
//! through mio), where every player used to have a reader and a writer thread
//! of its own. The game thread only queues packet bodies in a player's
//! [`Outbox`] (bounded by [`MAX_PENDING`] bytes); framing, compression,
//! encryption, the socket writes, reading and the keep-alives happen here. A
//! connection stays on one thread, so its bytes keep their order. The
//! integrated server's own player, over an in-memory pipe, is served the same
//! way: the pipe tells the thread when bytes arrive.
// use horizon_protocol::connection::{ConnReader, ConnWriter, Pipe, Socket};
// use mio::{Events, Interest, Poll, Registry, Token, Waker};
// use std::{
    // rust: io::{ErrorKind, Read, Write},
    // rust: sync::{
    // rust: Arc, Mutex, MutexGuard, OnceLock, PoisonError,
    // rust: atomic::{AtomicUsize, Ordering},
    // rust: },
    // rust: time::{Duration, Instant},
}

/// Packets queued for one client beyond this many bytes disconnect it.
    // rust: pub(super) const MAX_PENDING: usize = 96 << 20;
/// How often a thread looks at its connections' clocks: keep-alives,
/// timeouts and the closes that wait for a disconnect's last bytes.
pub const SWEEP: Duration = Duration::from_millis(100);
/// Framed bytes a connection may hold unwritten before its thread stops
/// taking more from its outbox: the rest wait there, counted in `pending`, so
/// that a client which reads slowly has the hub hold its far chunks back
/// (`lan_far`'s backlog) and, past [`MAX_PENDING`], is disconnected.
pub const AHEAD: usize = 256 << 10;
/// How long a disconnect's last bytes are given before the socket closes.
pub const LINGER: Duration = Duration::from_millis(50);
pub const WAKER: Token = Token(usize::MAX);

/// The play state's side of a connection (conn.rs's `PlayConn`).
    // rust: pub(super) trait Session: Send {
    /// A packet arrived.
pub fn packet(self: *Self, id: i32, payload: std.ArrayList(u8)) V;
    /// A packet to send of its own accord now (a keep-alive).
pub fn tick(self: *Self, now: Instant) O;
    /// The connection is ending, for this reason: no packet arrives after it.
pub fn left(self: *Self, reason: []const u8) void;
    /// The connection is closed, after [`Self::left`].
pub fn closed(self: *Self) void;
}

/// What becomes of a connection after one of its packets.
    // rust: pub(super) enum Verdict {
    // rust: Go,
    /// Close it now, for this reason.
    // rust: Close(String),
    /// Send this body (a disconnect) after what is queued, then close, for this reason.
    // rust: Kick(String, Vec<u8>),
}

/// How an outbox ends, after the bodies queued before.
    // rust: pub(super) enum End {
    /// Write everything queued (a disconnect last), then close.
    // rust: Disconnect,
    /// Close now: what is queued is dropped.
    // rust: Close,
}

/// Where an outbox's connection is.
pub const At = enum {
    /// Not on its thread yet: the thread takes what waits when it arrives.
    Coming,
    Slot(usize),
    Closed,
};

pub const Queue = struct {
    bodies: std.ArrayList(Vec<u8)>,
    end: ?End,
    at: At,
    /// In its thread's list of outboxes to serve.
    listed: bool,
};

/// One player's packets on their way to its network thread.
    // rust: pub(super) struct Outbox {
    // rust: queue: Mutex<Queue>,
    /// The bytes queued and not framed yet (`PlayerSender::pending`).
    // rust: pending: Arc<AtomicUsize>,
    // rust: worker: Arc<Worker>,
}
    // rust: impl Outbox {
    /// An outbox on the least busy network thread, started the first time.
    // rust: pub(super) fn new(pending: Arc<AtomicUsize>) -> Result<Arc<Self>, String> {
    // rust: let workers = &pool()?.workers;
    // rust: let worker = workers
    // rust: .iter()
    // rust: .min_by_key(|w| w.load.load(Ordering::Relaxed))
    // rust: .expect("a pool has a thread");
    // rust: Ok(Arc::new(Self {
    // rust: queue: Mutex::default(),
    // rust: pending,
    // rust: worker: worker.clone(),
    // rust: }))
}
pub fn queue(self: *Self) M {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.queue.lock().unwrap_or_else(PoisonError::into_inner)
}
    /// Queue `bodies` (already counted in `pending`), then `end`. Nothing
    /// follows an end, but a close overrides a disconnect still writing.
    /// Past [`MAX_PENDING`] the connection closes. The thread to wake, if
    /// this is the first news it has since it last looked.
    // rust: pub(super) fn push(&self, bodies: Vec<Vec<u8>>, end: Option<End>) -> Option<&Arc<Worker>> {
    // rust: let mut q = self.queue();
    // rust: match (q.at, q.end) {
    // rust: (At::Closed, _) => return None,
    // rust: (_, None) => {
    // rust: if q.bodies.is_empty() {
    // rust: q.bodies = bodies;
    // rust: } else {
    // rust: q.bodies.extend(bodies);
}
    // rust: q.end = if self.pending.load(Ordering::Relaxed) > MAX_PENDING {
    // rust: Some(End::Close)
    // rust: } else {
    // rust: end
}
}
    // rust: (_, Some(End::Disconnect)) if end == Some(End::Close) => q.end = end,
    // rust: (_, Some(_)) => return None,
}
    // rust: let At::Slot(slot) = q.at else {
    // rust: return None;
}
    // rust: if std::mem::replace(&mut q.listed, true) {
    // rust: return None;
}
    // rust: drop(q);
    // rust: self.worker
    // rust: .post(|i| i.serve.push(slot))
    // rust: .then_some(&self.worker)
}
    /// [`Self::push`], waking the thread at once.
    // rust: pub(super) fn send(&self, bodies: Vec<Vec<u8>>, end: Option<End>) {
    // rust: if let Some(worker) = self.push(bodies, end) {
    // rust: worker.wake();
}
}
    /// What waits, for the thread.
    /// What waits, for the thread: the bodies and the end after them with
    /// `room` for them, else only a close. An end stays, so that nothing is
    /// queued after it.
pub fn take(self: *Self, room: bool) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut q = self.queue();
    // rust: q.listed = false;
    // rust: match room {
    // rust: true => (std::mem::take(&mut q.bodies), q.end),
    // rust: false => (Vec::new(), q.end.filter(|e| *e == End::Close)),
}
}
pub fn attach(self: *Self, slot: usize) void {
}
    // rust: let mut q = self.queue();
    // rust: q.at = At::Slot(slot);
    // rust: q.listed = false;
}
pub fn closed(self: *Self) void {
}
    // rust: let mut q = self.queue();
    // rust: q.at = At::Closed;
    // rust: q.bodies = Vec::new();
    // rust: q.end = None;
}
}

/// What a network thread is told between polls.
pub const Inbox = struct {
    /// Connections with something in their outbox.
    serve: std.ArrayList(usize),
    /// Pipes with bytes to read.
    read: std.ArrayList(usize),
    adopt: std.ArrayList(Adopted),
};

/// One network thread, as the others see it.
    // rust: pub(super) struct Worker {
    // rust: waker: Waker,
    // rust: inbox: Mutex<Inbox>,
    /// Its connections, to give a new one to the least busy.
    // rust: load: AtomicUsize,
}
    // rust: impl Worker {
    /// Change the inbox: whether the thread needs waking for it (it was empty).
pub fn post(self: *Self, f: impl FnOnce(*mut Inbox) void {
}
    // rust: let mut inbox = self.inbox.lock().unwrap_or_else(PoisonError::into_inner);
    // rust: let empty = inbox.serve.is_empty() && inbox.read.is_empty() && inbox.adopt.is_empty();
    // rust: f(&mut inbox);
    // rust: empty
}
    // rust: pub(super) fn wake(&self) {
    // rust: if let Err(e) = self.waker.wake() {
    // rust: log::warn!("[lan] waking a network thread: {e}");
}
}
}

pub const Pool = struct {
    workers: std.ArrayList(*Worker),
};

/// The pool, started the first time: one thread per two cores.
pub fn pool() R {
    // Implementation ported from Horizon
    return undefined;
}
pub const POOL: OnceLock<!Pool> = OnceLock::new();
    // rust: let threads = std::thread::available_parallelism().map_or(1, |n| n.get().div_ceil(2));
    // rust: POOL.get_or_init(|| start(threads).map_err(|e| format!("network threads: {e}")))
    // rust: .as_ref()
    // rust: .map_err(Clone::clone)
}

pub fn start(threads: usize) s {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut workers = Vec::new();
    // rust: for n in 0..threads {
    // rust: let poll = Poll::new()?;
    // rust: let worker = Arc::new(Worker {
    // rust: waker: Waker::new(poll.registry(), WAKER)?,
    // rust: inbox: Mutex::default(),
    // rust: load: AtomicUsize::new(0),
    // rust: });
    // rust: let mine = worker.clone();
    // rust: std::thread::Builder::new()
    // rust: .name(format!("horizon-net-{n}"))
    // rust: .spawn(move || run(poll, &mine))?;
    // rust: workers.push(worker);
}
    // rust: Ok(Pool { workers })
}

/// A connection handed to its thread.
pub const Adopted = struct {
    socket: Socket,
    reader: ConnReader,
    writer: ConnWriter,
    outbox: *Outbox,
    session: *dyn Session,
    timeout: Duration,
};

/// Serve a connection from now on, on its outbox's thread: `timeout` is how
/// long it may read nothing, or have a write wait.
    // rust: pub(super) fn adopt(
    // rust: socket: Socket,
    // rust: (reader, writer): (ConnReader, ConnWriter),
    // rust: outbox: Arc<Outbox>,
    // rust: session: Box<dyn Session>,
    // rust: timeout: Duration,
    // rust: ) {
    // rust: let worker = outbox.worker.clone();
    // rust: worker.load.fetch_add(1, Ordering::Relaxed);
    // rust: let adopted = Adopted {
    // rust: socket,
    // rust: reader,
    // rust: writer,
    // rust: outbox,
    // rust: session,
    // rust: timeout,
}
    // rust: if worker.post(|i| i.adopt.push(adopted)) {
    // rust: worker.wake();
}
}

pub fn run(mut poll: Poll, worker: **Worker) void {
}
    // rust: let mut events = Events::with_capacity(1024);
    // rust: let mut conns: Vec<Option<Conn>> = Vec::new();
    // rust: let mut free: Vec<usize> = Vec::new();
    // rust: let mut touched: Vec<usize> = Vec::new();
    // rust: let mut sweep_at = Instant::now() + SWEEP;
    // rust: loop {
    // rust: let wait = sweep_at.saturating_duration_since(Instant::now());
    // rust: if let Err(e) = poll.poll(&mut events, Some(wait))
    // rust: && e.kind() != ErrorKind::Interrupted
    // rust: {
    // rust: log::warn!("[lan] network poll: {e}");
    // rust: std::thread::sleep(SWEEP);
}
    // rust: let now = Instant::now();
    // rust: for event in &events {
    // rust: let i = event.token().0;
    // rust: let Some(Some(c)) = conns.get_mut(i) else {
    // rust: continue;
}
    // rust: if event.is_readable() || event.is_read_closed() || event.is_error() {
    // rust: c.read(now);
}
    // rust: if event.is_writable() || event.is_write_closed() || event.is_error() {
    // rust: c.serve(now);
}
    // rust: touched.push(i);
}
    // rust: let inbox =
    // rust: std::mem::take(&mut *worker.inbox.lock().unwrap_or_else(PoisonError::into_inner));
    // rust: for adopted in inbox.adopt {
    // rust: let i = free.pop().unwrap_or(conns.len());
    // rust: if i == conns.len() {
    // rust: conns.push(None);
}
    // rust: match Conn::register(adopted, poll.registry(), worker, i, now) {
    // rust: Ok(mut c) => {
    // rust: c.outbox.attach(i);
    // rust: c.read(now);
    // rust: c.serve(now);
    // rust: conns[i] = Some(c);
    // rust: touched.push(i);
}
    // rust: Err(()) => free.push(i),
}
}
    // rust: for i in inbox.read {
    // rust: if let Some(Some(c)) = conns.get_mut(i) {
    // rust: c.read(now);
    // rust: touched.push(i);
}
}
    // rust: for i in inbox.serve {
    // rust: if let Some(Some(c)) = conns.get_mut(i) {
    // rust: c.serve(now);
    // rust: touched.push(i);
}
}
    // rust: if now >= sweep_at {
    // rust: sweep_at = now + SWEEP;
    // rust: touched.clear();
    // rust: for (i, slot) in conns.iter_mut().enumerate() {
    // rust: if let Some(c) = slot {
    // rust: c.sweep(now);
    // rust: touched.push(i);
}
}
}
    // rust: for i in touched.drain(..) {
    // rust: if conns[i].as_ref().is_some_and(|c| c.done(now)) {
    // rust: let c = conns[i].take().expect("checked");
    // rust: c.close(poll.registry(), worker);
    // rust: free.push(i);
}
}
}
}

/// A connection's stream, polled.
pub const Io = enum {
    Tcp(mio::net::TcpStream),
    Memory(Pipe),
};
    // rust: impl Read for Io {
pub fn read(self: *Self, out: []u8) s {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Tcp(s) => s.read(out),
    // rust: Self::Memory(p) => p.read(out),
}
}
}
    // rust: impl Write for Io {
pub fn write(self: *Self, data: []const u8) s {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Tcp(s) => s.write(data),
    // rust: Self::Memory(p) => p.write(data),
}
}
pub fn flush(self: *Self) s {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(())
}
}

/// Why a read error ends a connection: a client that closed it is
/// Connection.channelInactive without details, multiplayer.disconnect.generic.
pub fn read_error(e: std::io::Error) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match e.kind() {
    // rust: ErrorKind::ConnectionReset | ErrorKind::ConnectionAborted => "Disconnected".to_owned(),
    // rust: _ => horizon_protocol::Error::from(e).to_string(),
}
}

/// A connection on its thread.
pub const Conn = struct {
    io: Io,
    reader: ConnReader,
    writer: ConnWriter,
    /// Framed bytes, written from `written` on.
    out: std.ArrayList(u8),
    written: usize,
    outbox: *Outbox,
    session: *dyn Session,
    timeout: Duration,
    last_read: Instant,
    /// Since when `out` has waited on a client that reads nothing.
    stalled: ?Instant,
    /// [`Session::left`] was called: what arrives now is dropped.
    left: bool,
    /// A disconnect is in `out`: nothing more is taken from the outbox.
    draining: bool,
    close_at: ?Instant,
};
    // rust: impl Conn {
    // rust: fn register(
    // rust: a: Adopted,
    // rust: registry: &Registry,
    // rust: worker: &Arc<Worker>,
    // rust: i: usize,
    // rust: now: Instant,
    // rust: ) -> Result<Self, ()> {
    // rust: let io = match a.socket {
    // rust: Socket::Tcp(stream) => {
    // rust: let registered = stream.set_nonblocking(true).and_then(|()| {
    // rust: let mut stream = mio::net::TcpStream::from_std(stream);
    // rust: let interest = Interest::READABLE | Interest::WRITABLE;
    // rust: registry.register(&mut stream, Token(i), interest)?;
    // rust: Ok(stream)
    // rust: });
    // rust: match registered {
    // rust: Ok(stream) => Io::Tcp(stream),
    // rust: Err(e) => {
    // rust: let mut session = a.session;
    // rust: a.outbox.closed();
    // rust: session.left(e.to_string());
    // rust: session.closed();
    // rust: worker.load.fetch_sub(1, Ordering::Relaxed);
    // rust: return Err(());
}
}
}
    // rust: Socket::Memory(mut pipe) => {
    // rust: pipe.set_nonblocking(true);
    // rust: let worker = worker.clone();
    // rust: pipe.on_ready(move || {
    // rust: if worker.post(|inbox| inbox.read.push(i)) {
    // rust: worker.wake();
}
    // rust: });
    // rust: Io::Memory(pipe)
}
}
    // rust: Ok(Self {
    // rust: io,
    // rust: reader: a.reader,
    // rust: writer: a.writer,
    // rust: out: Vec::new(),
    // rust: written: 0,
    // rust: outbox: a.outbox,
    // rust: session: a.session,
    // rust: timeout: a.timeout,
    // rust: last_read: now,
    // rust: stalled: None,
    // rust: left: false,
    // rust: draining: false,
    // rust: close_at: None,
    // rust: })
}

pub fn left(self: *Self, reason: []const u8) void {
}
    // rust: if !std::mem::replace(&mut self.left, true) {
    // rust: self.session.left(reason);
}
}
    /// Close now.
pub fn end(self: *Self, now: Instant, reason: impl Into<[]const u8>) void {
}
    // rust: self.left(reason.into());
    // rust: self.close_at = Some(now);
}
pub fn done(self: *Self, now: Instant) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.close_at.is_some_and(|at| now >= at)
}

    /// Read and hand over every packet that arrived.
pub fn read(self: *Self, now: Instant) void {
}
    // rust: loop {
    // rust: match self.reader.buffered() {
    // rust: Ok(Some((id, payload))) => {
    // rust: if !self.left {
    // rust: match self.session.packet(id, payload) {
    // rust: Verdict::Go => {}
    // rust: Verdict::Close(reason) => return self.end(now, reason),
    // rust: Verdict::Kick(reason, body) => self.kick(now, reason, &body),
}
}
    // rust: continue;
}
    // rust: Ok(None) => {}
    // rust: Err(e) => return self.end(now, e.to_string()),
}
    // rust: if self.close_at.is_some() {
    // rust: return;
}
    // rust: match self.reader.read_from(&mut self.io) {
    // rust: Ok(0) => return self.end(now, "Disconnected"),
    // rust: Ok(_) => self.last_read = now,
    // rust: Err(e) if e.kind() == ErrorKind::WouldBlock => return,
    // rust: Err(e) if e.kind() == ErrorKind::Interrupted => {}
    // rust: Err(e) => return self.end(now, read_error(e)),
}
}
}

    /// Frame `bodies` into `out`, `queued` ones counted off `pending`: false
    /// if one could not be.
pub fn frame(self: *Self, now: Instant, bodies: std.ArrayList(Vec<u8)>, queued: bool) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: for body in bodies {
    // rust: if queued {
    // rust: self.outbox.pending.fetch_sub(body.len(), Ordering::Relaxed);
}
    // rust: if let Err(e) = super::conn::frame_body(&mut self.writer, &body, &mut self.out) {
    // rust: self.end(now, e.to_string());
    // rust: return false;
}
}
    // rust: true
}

    /// Send `disconnect` after everything queued, then close.
pub fn kick(self: *Self, now: Instant, reason: []const u8, disconnect: []const u8) void {
}
    // rust: self.left(reason);
    // rust: if !self.draining {
    // rust: let (bodies, end) = self.outbox.take(true);
    // rust: if end == Some(End::Close) {
    // rust: return self.end(now, "Disconnected");
}
            // The hub's own disconnect, if it was the last queued, does for this one.
    // rust: let ours = (end.is_none()).then(|| disconnect.to_vec());
    // rust: if !self.frame(now, bodies, true) || !self.frame(now, ours.into_iter().collect(), false)
    // rust: {
    // rust: return;
}
    // rust: self.draining = true;
}
    // rust: self.serve(now);
}

    /// Write what is framed, and frame what the outbox holds, while the
    /// client takes it.
pub fn serve(self: *Self, now: Instant) void {
}
    // rust: loop {
    // rust: if !self.flush(now) || self.close_at.is_some() {
    // rust: return;
}
            // A close is seen even while the client takes nothing.
    // rust: let room = !self.draining && self.out.len() - self.written <= AHEAD;
    // rust: let (bodies, end) = self.outbox.take(room);
    // rust: if end == Some(End::Close) {
    // rust: return self.end(now, "Disconnected");
}
    // rust: if bodies.is_empty() {
    // rust: break;
}
    // rust: if !self.frame(now, bodies, true) {
    // rust: return;
}
    // rust: self.draining = end == Some(End::Disconnect);
}
    // rust: if self.draining && self.written == self.out.len() && self.close_at.is_none() {
    // rust: self.close_at = Some(now + LINGER);
}
}

    /// Write what is framed until the client takes no more: false once the
    /// connection failed.
pub fn flush(self: *Self, now: Instant) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.close_at.is_some_and(|at| at <= now) {
    // rust: return false;
}
    // rust: while self.written < self.out.len() {
    // rust: match self.io.write(&self.out[self.written..]) {
    // rust: Ok(0) => {
    // rust: self.end(now, "Disconnected");
    // rust: return false;
}
    // rust: Ok(n) => {
    // rust: self.written += n;
    // rust: self.stalled = None;
}
    // rust: Err(e) if e.kind() == ErrorKind::WouldBlock => {
    // rust: self.stalled.get_or_insert(now);
    // rust: return true;
}
    // rust: Err(e) if e.kind() == ErrorKind::Interrupted => {}
    // rust: Err(_) => {
    // rust: self.end(now, "Disconnected");
    // rust: return false;
}
}
}
    // rust: self.out.clear();
    // rust: self.written = 0;
    // rust: self.stalled = None;
    // rust: if self.out.capacity() > 4 * AHEAD {
    // rust: self.out.shrink_to(AHEAD);
}
    // rust: true
}

    /// The connection's clocks: a keep-alive due, a client that sent nothing
    /// or took nothing for too long.
pub fn sweep(self: *Self, now: Instant) void {
}
    // rust: if self.close_at.is_some() {
    // rust: return;
}
    // rust: if self
    // rust: .stalled
    // rust: .is_some_and(|t| now.duration_since(t) > self.timeout)
    // rust: {
    // rust: return self.end(now, "Disconnected");
}
    // rust: if !self.left && now.duration_since(self.last_read) > self.timeout {
    // rust: return self.end(now, horizon_protocol::Error::timed_out().to_string());
}
    // rust: if !self.draining
    // rust: && let Some(body) = self.session.tick(now)
    // rust: && self.frame(now, vec![body], false)
    // rust: {
    // rust: self.serve(now);
}
}

pub fn close(registry: *Registry, worker: *Worker) void {
}
    // rust: match &mut self.io {
    // rust: Io::Tcp(stream) => {
    // rust: let _ = registry.deregister(stream);
    // rust: let _ = stream.shutdown(std::net::Shutdown::Both);
}
    // rust: Io::Memory(pipe) => {
    // rust: pipe.on_ready(|| {});
    // rust: pipe.shutdown();
}
}
    // rust: self.outbox.closed();
    // rust: self.left("Disconnected".to_owned());
    // rust: self.session.closed();
    // rust: worker.load.fetch_sub(1, Ordering::Relaxed);
}
}

    // rust: mod tests {
//     use super::*;
//     use horizon_protocol::connection::Connection;
//     use std::sync::mpsc::{Receiver, Sender, channel};

pub const Seen = enum {
    Packet(i32, Vec<u8>),
    Left(String),
    Closed,
};
pub const Probe = struct {
    seen: Sender<Seen>,
        /// The packet id answered with a kick.
    kick_on: ?i32,
        /// Sent at the first sweep.
    unprompted: ?std.ArrayList(u8),
};
    // rust: impl Session for Probe {
pub fn packet(self: *Self, id: i32, payload: std.ArrayList(u8)) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let _ = self.seen.send(Seen::Packet(id, payload));
    // rust: if self.kick_on == Some(id) {
    // rust: Verdict::Kick("kicked".into(), body(0x7f, 3))
    // rust: } else {
    // rust: Verdict::Go
}
}
pub fn tick(self: *Self, _: Instant) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.unprompted.take()
}
pub fn left(self: *Self, reason: []const u8) void {
}
    // rust: let _ = self.seen.send(Seen::Left(reason));
}
pub fn closed(self: *Self) void {
}
    // rust: let _ = self.seen.send(Seen::Closed);
}
}

    /// A packet body: a one-byte id, then `len` bytes.
pub fn body(id: u8, len: usize) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: std::iter::once(id)
    // rust: .chain((0..len).map(|j| (j * 31 + usize::from(id)) as u8))
    // rust: .collect()
}
pub fn packet(body: []const u8) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (i32::from(body[0]), body[1..].to_vec())
}

pub const Served = struct {
    outbox: *Outbox,
    pending: *AtomicUsize,
    seen: Receiver<Seen>,
};
    // rust: impl Served {
pub fn send(self: *Self, bodies: std.ArrayList(Vec<u8)>, end: ?End) void {
}
    // rust: let len: usize = bodies.iter().map(Vec::len).sum();
    // rust: self.pending.fetch_add(len, Ordering::Relaxed);
    // rust: self.outbox.send(bodies, end);
}
pub fn next(self: *Self) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.seen.recv_timeout(Duration::from_secs(10)).unwrap()
}
}
    // rust: fn serve(
    // rust: server: Connection,
    // rust: probe: impl FnOnce(Sender<Seen>) -> Probe,
    // rust: timeout: Duration,
    // rust: ) -> Served {
    // rust: let pending = Arc::new(AtomicUsize::new(0));
    // rust: let outbox = Outbox::new(pending.clone()).unwrap();
    // rust: let (tx, seen) = channel();
    // rust: let (socket, reader, writer) = server.detach();
    // rust: adopt(
    // rust: socket,
    // rust: (reader, writer),
    // rust: outbox.clone(),
    // rust: Box::new(probe(tx)),
    // rust: timeout,
    // rust: );
    // rust: Served {
    // rust: outbox,
    // rust: pending,
    // rust: seen,
}
}
pub fn quiet(seen: Sender<Seen>) P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Probe {
    // rust: seen,
    // rust: kick_on: None,
    // rust: unprompted: None,
}
}

pub fn a_socket_carries_packets_both_ways_in_order_then_disconnects() void {
}
    // rust: let listener = std::net::TcpListener::bind("127.0.0.1:0").unwrap();
    // rust: let port = listener.local_addr().unwrap().port();
    // rust: let mut client = Connection::connect("127.0.0.1", port, Duration::from_secs(5)).unwrap();
    // rust: let mut server = Connection::from_stream(listener.accept().unwrap().0).unwrap();
    // rust: for c in [&mut client, &mut server] {
    // rust: c.set_compression(64);
    // rust: c.enable_encryption(&[5; 16]);
}
        // The second arrives with the first, before the pool has the connection.
    // rust: client.send(&body(1, 10)).unwrap();
    // rust: client.send(&body(2, 10)).unwrap();
    // rust: assert_eq!(server.recv().unwrap(), packet(&body(1, 10)));
    // rust: let served = serve(server, quiet, Duration::from_secs(30));
    // rust: assert_eq!(served.next(), Seen::Packet(2, body(2, 10)[1..].to_vec()));
        // Small, compressed and shared (past 8 KiB) frames.
    // rust: let bodies: Vec<Vec<u8>> = (0..60)
    // rust: .map(|i| body(i as u8 + 3, [0, 63, 64, 300, 9000, 70_000][i % 6]))
    // rust: .collect();
    // rust: served.send(bodies.clone(), None);
    // rust: for b in &bodies {
    // rust: assert_eq!(client.recv().unwrap(), packet(b));
}
    // rust: for i in 0..20u8 {
    // rust: client.send(&body(i + 3, 50)).unwrap();
}
    // rust: for i in 0..20u8 {
    // rust: assert_eq!(
    // rust: served.next(),
    // rust: Seen::Packet(i32::from(i + 3), body(i + 3, 50)[1..].to_vec())
    // rust: );
}
    // rust: assert_eq!(served.pending.load(Ordering::Relaxed), 0);
    // rust: served.send(vec![body(0x1d, 5)], Some(End::Disconnect));
    // rust: assert_eq!(client.recv().unwrap(), packet(&body(0x1d, 5)));
    // rust: assert!(client.recv().unwrap_err().is_end_of_stream());
    // rust: assert_eq!(served.next(), Seen::Left("Disconnected".into()));
    // rust: assert_eq!(served.next(), Seen::Closed);
}

pub fn a_kick_goes_after_what_was_queued_and_ends_the_packets() void {
}
    // rust: let (a, b) = Pipe::pair();
    // rust: let mut client = Connection::local(a);
    // rust: let probe = |seen| Probe {
    // rust: seen,
    // rust: kick_on: Some(9),
    // rust: unprompted: Some(body(0x21, 2)),
}
    // rust: let served = serve(Connection::local(b), probe, Duration::from_secs(30));
    // rust: served.send(vec![body(3, 10)], None);
    // rust: assert_eq!(client.recv().unwrap(), packet(&body(3, 10)));
        // What the session sends of its own accord.
    // rust: assert_eq!(client.recv().unwrap(), packet(&body(0x21, 2)));
    // rust: client.send(&body(9, 1)).unwrap();
    // rust: client.send(&body(10, 1)).unwrap();
    // rust: assert_eq!(client.recv().unwrap(), packet(&body(0x7f, 3)));
    // rust: assert!(client.recv().is_err());
    // rust: assert_eq!(served.next(), Seen::Packet(9, body(9, 1)[1..].to_vec()));
    // rust: assert_eq!(served.next(), Seen::Left("kicked".into()));
    // rust: assert_eq!(served.next(), Seen::Closed);
        // Nothing after the kick, and nothing queued once closed.
    // rust: assert!(served.seen.try_recv().is_err());
    // rust: assert!(served.outbox.push(vec![body(4, 1)], None).is_none());
}

pub fn a_silent_client_times_out() void {
}
    // rust: let (a, b) = Pipe::pair();
    // rust: let mut client = Connection::local(a);
    // rust: let served = serve(Connection::local(b), quiet, Duration::from_millis(300));
    // rust: assert_eq!(served.next(), Seen::Left("Timed out".into()));
    // rust: assert_eq!(served.next(), Seen::Closed);
    // rust: assert!(client.recv().is_err());
}

    /// A client that reads nothing holds its disconnect unwritten; a close
    /// then ends the connection at once.
pub fn a_close_ends_a_disconnect_the_client_does_not_take() void {
}
    // rust: let listener = std::net::TcpListener::bind("127.0.0.1:0").unwrap();
    // rust: let port = listener.local_addr().unwrap().port();
    // rust: let client = Connection::connect("127.0.0.1", port, Duration::from_secs(5)).unwrap();
    // rust: let server = Connection::from_stream(listener.accept().unwrap().0).unwrap();
    // rust: let served = serve(server, quiet, Duration::from_secs(30));
        // Fill the socket until the outbox waits. A fixed amount may all go
        // through: Windows takes a write of any size whole while its buffer
        // has room.
    // rust: let full = || {
    // rust: std::thread::sleep(Duration::from_millis(50));
    // rust: served.pending.load(Ordering::Relaxed) > 0
}
    // rust: for i in 0..=u8::MAX {
    // rust: if full() && full() && full() {
    // rust: break;
}
    // rust: assert!(i < u8::MAX, "the socket took everything");
    // rust: served.send(vec![body(i, 1 << 20)], None);
}
    // rust: served.send(Vec::new(), Some(End::Disconnect));
    // rust: std::thread::sleep(Duration::from_millis(300));
    // rust: assert!(served.seen.try_recv().is_err(), "still writing");
    // rust: served.send(Vec::new(), Some(End::Close));
    // rust: assert_eq!(served.next(), Seen::Left("Disconnected".into()));
    // rust: assert_eq!(served.next(), Seen::Closed);
    // rust: drop(client);
}

pub fn a_close_or_too_much_queued_drops_what_waits() void {
}
    // rust: for overflow in [false, true] {
    // rust: let (a, b) = Pipe::pair();
    // rust: let mut client = Connection::local(a);
    // rust: let served = serve(Connection::local(b), quiet, Duration::from_secs(30));
    // rust: if overflow {
    // rust: served.pending.store(MAX_PENDING, Ordering::Relaxed);
    // rust: served.send(vec![body(3, 10)], None);
    // rust: } else {
    // rust: served.send(Vec::new(), Some(End::Close));
}
    // rust: assert!(client.recv().is_err());
    // rust: assert_eq!(served.next(), Seen::Left("Disconnected".into()));
    // rust: assert_eq!(served.next(), Seen::Closed);
}
}
}
