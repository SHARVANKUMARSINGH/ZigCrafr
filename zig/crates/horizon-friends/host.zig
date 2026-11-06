//! Transpiled from Horizon Rust crate
//! Module: horizon-friends_host
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The host's end. It listens on its direct port, works out how it can be
//! reached (interfaces, a router mapping, STUN) and puts that with a fresh
//! secret into the invite code: guests with the code dial it directly, no
//! server involved. When a relay is configured (the player's own, or any
//! they trust), it also registers there for a short code and serves relayed
//! sessions (with their own direct race, then the relay as fallback).
//! Every session ends at the integrated server's port. Everything runs on
//! its own threads; the game polls [`Host::poll`] and [`Host::state`].
// use crate::{
    // rust: Code, PathMode,
    // rust: crypto::{self, Role},
    // rust: direct,
    // rust: invite::{Invite, RelayRef},
    // rust: reach::{self, Reach, Verdict},
    // rust: resolve_relay, session,
    // rust: wire::{self, FromRelay, ToRelay},
}
// use std::{
    // rust: collections::HashMap,
    // rust: io::{self, BufReader},
    // rust: net::{Shutdown, SocketAddr, TcpListener, TcpStream},
    // rust: sync::{
    // rust: Arc, Mutex,
    // rust: atomic::{AtomicBool, AtomicU32, AtomicUsize, Ordering},
    // rust: mpsc::{Receiver, Sender, channel},
    // rust: },
    // rust: thread::JoinHandle,
    // rust: time::{Duration, Instant},
}

/// Wrong short codes tried at the relay before the host retires it.
pub const MAX_WRONG: u32 = 5;
/// Wrong short codes over one sharing session before the host leaves the
/// relay for good (the full code keeps working directly). Each short code
/// has a fresh 20-bit secret, so this caps a relay's chance of guessing one
/// at 50 / 2^20 per session.
pub const MAX_WRONG_TOTAL: u32 = 50;
/// The longest wait before registering again after a retired short code.
pub const MAX_RETIRE_DELAY: Duration = Duration::from_secs(300);
/// Sessions open at once (IntegratedServer.MAX_PLAYERS).
pub const MAX_SESSIONS: usize = 8;
/// The direct port asked for first, so a port forwarded by hand keeps
/// working from one session to the next (`HORIZON_FRIENDS_PORT`).
pub const DEFAULT_PORT: u16 = 25580;
/// Code handshakes in progress at once (scanners can't pile them up).
pub const MAX_HANDSHAKES: usize = 8;
/// The most an inbound stream's opening (hello, key exchange, confirmation)
/// may take, however slowly its bytes come.
pub const HANDSHAKE: Duration = Duration::from_secs(10);

pub const HostConfig = struct {
    /// The integrated server's port (Open to LAN's).
    lan: SocketAddr,
    protocol: i32,
    game: []const u8,
    /// A relay to register with as well (short code, relay fallback).
    relay: ?[]const u8,
    path: PathMode,
    /// The direct port to ask for (0: any).
    port: u16,
    reach: reach::Options,
};

/// What the host's game shows.
pub const HostState = struct {
    /// The invite code; None while the host is still finding its addresses.
    invite: ?[]const u8,
    /// The relay's short code, when registered with one.
    short: ?Code,
    /// Who can join, and what to do when friends on the internet can't.
    summary: []const u8,
    verdict: ?Verdict,
    /// Why the relay isn't serving, when one is configured.
    relay_problem: ?[]const u8,
    port: u16,
};

pub const HostEvent = enum {
    /// A new invite code (the first, or after the relay's short code changed).
    Code(String),
    /// A guest's session is carried directly or through the relay.
    Connected {,
    session: u64,
    direct: bool,
    // rust: },
    Disconnected {,
    session: u64,
    // rust: },
    /// Someone tried a wrong code (`count`: on this code so far).
    WrongCode {,
    count: u32,
    // rust: },
    /// Too many wrong short codes this session: the host left the relay, and
    /// friends join with the full code only.
    RelayStopped,
};

/// How long to wait before registering again after the `retired`th short
/// code was retired for wrong secrets: 1 s, 2 s, 4 s ... up to 5 minutes.
pub fn retire_delay(retired: u32) D {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let doubling = retired.saturating_sub(1).min(16);
    // rust: Duration::from_secs(1 << doubling).min(MAX_RETIRE_DELAY)
}

/// Wrong short-code guesses through the relay. The count for the current
/// code starts over with each registration; the total and the retired codes
/// last for the whole sharing session, so registering again can't buy the
/// relay (or whoever drives its joins) fresh guesses.
pub const Guesses = struct {
    /// Wrong on the current short code.
    code: u32,
    total: u32,
    /// Key exchanges in progress: each may be one more wrong guess.
    pending: u32,
    retired: u32,
};

/// What `run_relay` does once the control connection ended cleanly.
pub const Next = enum {
    /// Register again now.
    Now,
    /// The code was retired: wait, then register again.
    Wait(Duration),
    /// Too many wrong guesses this session: leave the relay.
    Stop,
};

    // rust: impl Guesses {
    /// Reserve a guess for one relayed key exchange; false when a wrong
    /// answer from every exchange in progress could pass a limit.
pub fn reserve(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let free =
    // rust: self.code + self.pending < MAX_WRONG && self.total + self.pending < MAX_WRONG_TOTAL;
    // rust: if free {
    // rust: self.pending += 1;
}
    // rust: free
}
pub fn release(self: *Self) void {
}
    // rust: self.pending = self.pending.saturating_sub(1);
}
    /// A wrong secret: the count on this code, and whether to retire it.
pub fn wrong(self: *Self) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.code += 1;
    // rust: self.total += 1;
    // rust: (self.code, self.retiring())
}
pub fn retiring(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.code >= MAX_WRONG || self.total >= MAX_WRONG_TOTAL
}
pub fn registered(self: *Self) void {
}
    // rust: self.code = 0;
}
pub fn next(self: *Self) N {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.total >= MAX_WRONG_TOTAL {
    // rust: Next::Stop
    // rust: } else if self.code >= MAX_WRONG {
    // rust: self.retired += 1;
    // rust: Next::Wait(retire_delay(self.retired))
    // rust: } else {
    // rust: Next::Now
}
}
}

/// A guess reserved in [`Guesses`], released when dropped (count the wrong
/// answer first).
pub const Reserved = struct {};
    // rust: impl Drop for Reserved {
pub fn drop(self: *Self) void {
}
    // rust: self.0.guesses.lock().unwrap().release();
}
}

pub const Shared = struct {
    config: HostConfig,
    stop: AtomicBool,
    state: Mutex<HostState>,
    events: Mutex<Sender<HostEvent>>,
    /// The invite (endpoints and secret), rebuilt when the relay part changes.
    invite: Mutex<?Invite>,
    /// The current relay control connection (shut down to stop).
    control: Mutex<?TcpStream>,
    /// Inbound direct streams waiting for their relayed session.
    routes: Mutex<HashMap<u64,
    sessions: AtomicUsize,
    handshakes: AtomicUsize,
    wrong: AtomicU32,
    guesses: Mutex<Guesses>,
    reach: Mutex<?Reach>,
};
    // rust: impl Shared {
pub fn emit(self: *Self, e: HostEvent) void {
}
    // rust: let _ = self.events.lock().unwrap().send(e);
}
pub fn stopped(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.stop.load(Ordering::Relaxed)
}
    /// Rebuild the code from the invite and the relay's short code.
pub fn publish(self: *Self, short: ?Code) void {
}
    // rust: let text = {
    // rust: let mut invite = self.invite.lock().unwrap();
    // rust: let Some(inv) = invite.as_mut() else { return };
    // rust: inv.relay = match (&short, &self.config.relay) {
    // rust: (Some(code), Some(address)) => Some(RelayRef {
    // rust: address: address.clone(),
    // rust: code: code.clone(),
    // rust: }),
    // rust: _ => None,
}
    // rust: inv.encode()
}
    // rust: {
    // rust: let mut s = self.state.lock().unwrap();
    // rust: if s.invite.as_deref() == Some(&text) && s.short == short {
    // rust: return;
}
    // rust: s.invite = Some(text.clone());
    // rust: s.short = short;
}
    // rust: self.emit(HostEvent::Code(text));
}
}

pub const Host = struct {
    shared: *Shared,
    events: Receiver<HostEvent>,
    threads: std.ArrayList(JoinHandle<())>,
};

    // rust: impl Host {
    /// Start sharing in the background: the code arrives as an event once
    /// the host knows its addresses (a few seconds).
pub fn start(config: HostConfig) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (tx, events) = channel();
    // rust: let (listeners, port) = direct::listen(config.port).or_else(|_| direct::listen(0))?;
    // rust: let shared = Arc::new(Shared {
    // rust: config,
    // rust: stop: AtomicBool::new(false),
    // rust: state: Mutex::new(HostState {
    // rust: port,
    // rust: ..HostState::default()
    // rust: }),
    // rust: events: Mutex::new(tx),
    // rust: invite: Mutex::new(None),
    // rust: control: Mutex::new(None),
    // rust: routes: Mutex::new(HashMap::new()),
    // rust: sessions: AtomicUsize::new(0),
    // rust: handshakes: AtomicUsize::new(0),
    // rust: wrong: AtomicU32::new(0),
    // rust: guesses: Mutex::new(Guesses::default()),
    // rust: reach: Mutex::new(None),
    // rust: });
    // rust: let mut threads = Vec::new();
    // rust: let s = shared.clone();
    // rust: threads.push(
    // rust: std::thread::Builder::new()
    // rust: .name("horizon-friends-listen".into())
    // rust: .spawn(move || route_inbound(listeners, s))?,
    // rust: );
    // rust: let s = shared.clone();
    // rust: threads.push(
    // rust: std::thread::Builder::new()
    // rust: .name("horizon-friends-reach".into())
    // rust: .spawn(move || share(s, port))?,
    // rust: );
    // rust: Ok(Self {
    // rust: shared,
    // rust: events,
    // rust: threads,
    // rust: })
}
pub fn state(self: *Self) H {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.shared.state.lock().unwrap().clone()
}
pub fn poll(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.events.try_iter().collect()
}
    /// Guests whose sessions are open (connecting or playing).
pub fn sessions(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.shared.sessions.load(Ordering::Relaxed)
}
    /// End the code: close the direct port, delete the router mapping, leave
    /// the relay. Sessions already playing go on until the integrated server
    /// closes them.
pub fn stop(self: *Self) void {
}
    // rust: self.shared.stop.store(true, Ordering::Relaxed);
    // rust: if let Some(c) = self.shared.control.lock().unwrap().take() {
    // rust: let _ = c.shutdown(Shutdown::Both);
}
    // rust: for t in self.threads.drain(..) {
    // rust: let _ = t.join();
}
    // rust: if let Some(r) = self.shared.reach.lock().unwrap().as_mut() {
    // rust: r.release();
}
}
}
    // rust: impl Drop for Host {
pub fn drop(self: *Self) void {
}
    // rust: self.stop();
}
}

/// Find the addresses, publish the code, keep the router mapping alive,
/// serve the relay when there is one.
pub fn share(shared: *Shared, port: u16) void {
}
    // rust: let config = &shared.config;
    // rust: let reach = if config.path == PathMode::RelayOnly {
    // rust: Reach {
    // rust: port,
    // rust: ..Reach::default()
}
    // rust: } else {
    // rust: Reach::discover(port, &config.reach)
}
    // rust: let endpoints = if config.path == PathMode::RelayOnly {
    // rust: Vec::new()
    // rust: } else {
    // rust: reach.endpoints()
}
    // rust: let invite = match Invite::new(port, endpoints, None) {
    // rust: Ok(i) => i,
    // rust: Err(_) => return,
}
    // rust: {
    // rust: let mut s = shared.state.lock().unwrap();
    // rust: s.summary = if config.path == PathMode::RelayOnly {
    // rust: "Friends join through the relay only.".into()
    // rust: } else {
    // rust: reach.summary()
}
    // rust: s.verdict = Some(reach.verdict());
}
    // rust: *shared.invite.lock().unwrap() = Some(invite);
    // rust: *shared.reach.lock().unwrap() = Some(reach);
    // rust: if shared.stopped() {
    // rust: return;
}
    // rust: shared.publish(None);
    // rust: let relay = match &config.relay {
    // rust: Some(r) => {
    // rust: let s = shared.clone();
    // rust: let r = r.clone();
    // rust: std::thread::Builder::new()
    // rust: .name("horizon-friends-relay".into())
    // rust: .spawn(move || run_relay(s, r))
    // rust: .ok()
}
    // rust: None => None,
}
    // Renew the router mapping at half-lease until stopped.
    // rust: while !shared.stopped() {
    // rust: std::thread::sleep(Duration::from_millis(100));
    // rust: let mut reach = shared.reach.lock().unwrap();
    // rust: if let Some(m) = reach.as_mut().and_then(|r| r.mapping.as_mut())
    // rust: && m.due()
    // rust: && m.renew().is_err()
    // rust: {
            // Try again in a minute rather than hammering the router.
    // rust: m.renewed = Instant::now() - m.lifetime / 2 + Duration::from_secs(60);
}
}
    // rust: if let Some(t) = relay {
    // rust: let _ = t.join();
}
}

/// Inbound streams on the direct port: a relayed session's direct race, or
/// a guest with the code.
pub fn route_inbound(listeners: std.ArrayList(TcpListener), shared: *Shared) void {
}
    // rust: while !shared.stopped() {
    // rust: let mut idle = true;
    // rust: for l in &listeners {
    // rust: let Ok((mut s, _)) = l.accept() else { continue };
    // rust: idle = false;
    // rust: if shared.handshakes.load(Ordering::Relaxed) >= MAX_HANDSHAKES {
    // rust: continue;
}
    // rust: shared.handshakes.fetch_add(1, Ordering::Relaxed);
    // rust: let shared = shared.clone();
    // rust: let _ = std::thread::Builder::new()
    // rust: .name("horizon-friends-inbound".into())
    // rust: .spawn(move || {
    // rust: let _ = s.set_nonblocking(false);
    // rust: let Ok(deadline) = crate::deadline(&s, HANDSHAKE) else {
    // rust: shared.handshakes.fetch_sub(1, Ordering::Relaxed);
    // rust: return;
}
    // rust: match direct::read_hello(&mut s) {
    // rust: Ok(direct::Hello::Relayed(session)) => {
    // rust: shared.handshakes.fetch_sub(1, Ordering::Relaxed);
    // rust: let route = {
    // rust: let mut routes = shared.routes.lock().unwrap();
    // rust: routes.retain(|_, (_, until)| *until > Instant::now());
    // rust: routes.get(&session).map(|(tx, _)| tx.clone())
}
    // rust: if let Some(tx) = route
    // rust: && direct::answer(&mut s, session).is_ok()
    // rust: {
    // rust: let _ = tx.send(s);
}
}
    // rust: Ok(direct::Hello::Code(session)) => {
    // rust: serve_code(&shared, s, session, deadline)
}
    // rust: Err(_) => {
    // rust: shared.handshakes.fetch_sub(1, Ordering::Relaxed);
}
}
    // rust: });
}
    // rust: if idle {
    // rust: std::thread::sleep(Duration::from_millis(20));
}
}
}

/// A guest who dialled an endpoint from the code: agree on the key from
/// the code's secret, then carry the session (`deadline` bounds the
/// handshake, not the game).
pub fn serve_code(shared: **Shared, mut s: TcpStream, session: u64, deadline: crate::Deadline) void {
}
    // rust: let secret = shared
    // rust: .invite
    // rust: .lock()
    // rust: .unwrap()
    // rust: .as_ref()
    // rust: .map(Invite::secret_text);
    // rust: let secured = (|| -> io::Result<session::Secure> {
    // rust: let secret = secret.ok_or_else(|| io::Error::other("not ready"))?;
    // rust: direct::answer_code(&mut s, session)?;
    // rust: let key = crypto::exchange(&mut s, &secret, "direct", session)?;
    // rust: session::secure(s, &key, Role::Host)
    // rust: })();
    // rust: drop(deadline);
    // rust: shared.handshakes.fetch_sub(1, Ordering::Relaxed);
    // rust: match secured {
    // rust: Ok(secure) => carry(shared, session, secure, true),
    // rust: Err(e) if crypto::is_wrong_code(&e) => {
    // rust: let count = shared.wrong.fetch_add(1, Ordering::Relaxed) + 1;
    // rust: shared.emit(HostEvent::WrongCode { count });
}
    // rust: Err(_) => {}
}
}

/// Connect a settled session to the integrated server and carry it.
pub fn carry(shared: **Shared, session: u64) void {
}
    // rust: if shared.sessions.fetch_add(1, Ordering::Relaxed) >= MAX_SESSIONS {
    // rust: shared.sessions.fetch_sub(1, Ordering::Relaxed);
    // rust: let _ = r.get_ref().shutdown(Shutdown::Both);
    // rust: return;
}
    // rust: let Ok(server) = TcpStream::connect_timeout(&shared.config.lan, Duration::from_secs(5)) else {
    // rust: let _ = r.get_ref().shutdown(Shutdown::Both);
    // rust: shared.sessions.fetch_sub(1, Ordering::Relaxed);
    // rust: return;
}
    // rust: shared.emit(HostEvent::Connected { session, direct });
    // rust: if let Ok(t) = crate::pump(server, r, w) {
    // rust: let _ = t.join();
}
    // rust: shared.sessions.fetch_sub(1, Ordering::Relaxed);
    // rust: shared.emit(HostEvent::Disconnected { session });
}

// ----- The relay (optional) ---------------------------------------------------------------------

pub fn connect_relay(relay: []const u8, port: ?u16) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let wait = Duration::from_secs(5);
    // rust: let mut last = io::Error::other("no address");
    // rust: let mut timed_out = Vec::new();
    // rust: for address in resolve_relay(relay)? {
    // rust: match direct::connect_from(port, address, wait) {
    // rust: Ok(s) => {
    // rust: let _ = s.set_nodelay(true);
    // rust: return Ok((s, address));
}
    // rust: Err(e) => {
    // rust: if port.is_some() && e.kind() == io::ErrorKind::TimedOut {
    // rust: timed_out.push(address);
}
    // rust: last = e;
}
}
}
    // A relay on Windows ignores a new connection from the address of one it
    // closed less than its TIME_WAIT ago (the last guest's attach from the
    // direct port), where Linux takes it: those get one more try from any
    // port, once every address had its try from the direct port.
    // rust: for address in timed_out {
    // rust: match direct::connect_from(None, address, wait) {
    // rust: Ok(s) => {
    // rust: let _ = s.set_nodelay(true);
    // rust: return Ok((s, address));
}
    // rust: Err(e) => last = e,
}
}
    // rust: Err(last)
}

/// Register, serve the control connection, register again when it drops
/// (a new short code) until stopped.
pub fn run_relay(shared: *Shared, relay: []const u8) void {
}
    // rust: let mut backoff = Duration::from_secs(1);
    // rust: while !shared.stopped() {
    // rust: match register(&shared, &relay) {
    // rust: Ok(()) => {
    // rust: backoff = Duration::from_secs(1);
    // rust: shared.state.lock().unwrap().relay_problem = None;
    // rust: let next = shared.guesses.lock().unwrap().next();
    // rust: match next {
    // rust: Next::Now => {}
    // rust: Next::Wait(delay) => {
                        // Retired for wrong secrets: a relay that keeps
                        // guessing waits longer for every new code.
    // rust: shared.publish(None);
    // rust: let until = Instant::now() + delay;
    // rust: while Instant::now() < until && !shared.stopped() {
    // rust: std::thread::sleep(Duration::from_millis(50));
}
}
    // rust: Next::Stop => {
    // rust: shared.publish(None);
    // rust: shared.emit(HostEvent::RelayStopped);
    // rust: break;
}
}
}
    // rust: Err(e) => {
    // rust: if shared.stopped() {
    // rust: break;
}
    // rust: shared.state.lock().unwrap().relay_problem =
    // rust: Some(format!("Couldn't reach the relay {relay}: {e}"));
    // rust: shared.publish(None);
    // rust: let until = Instant::now() + backoff;
    // rust: while Instant::now() < until && !shared.stopped() {
    // rust: std::thread::sleep(Duration::from_millis(50));
}
    // rust: backoff = (backoff * 2).min(Duration::from_secs(30));
}
}
}
}

pub fn register(shared: **Shared, relay_url: []const u8) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let config = &shared.config;
    // rust: let port = Some(shared.state.lock().unwrap().port);
    // The control connection uses any port: the direct port stays free for
    // the attach connections, whose observed address is the one that counts.
    // rust: let (mut control, relay) = connect_relay(relay_url, None)?;
    // rust: control.set_read_timeout(Some(Duration::from_secs(70)))?;
    // rust: wire::send(
    // rust: &mut control,
    // rust: &ToRelay::Host {
    // rust: v: wire::VERSION,
    // rust: protocol: config.protocol,
    // rust: game: config.game.clone(),
    // rust: },
    // rust: )?;
    // rust: let mut reader = BufReader::new(control.try_clone()?);
    // rust: let (nameplate, token) = match wire::recv_buffered::<_, FromRelay>(&mut reader)? {
    // rust: FromRelay::Registered {
    // rust: nameplate, token, ..
    // rust: } => (nameplate, token),
    // rust: FromRelay::Error { code, .. } => {
    // rust: return Err(io::Error::other(format!("it refused ({})", code.as_str())));
}
    // rust: other => return Err(io::Error::other(format!("unexpected answer {other:?}"))),
}
    // rust: let code = Code::new(&nameplate)?;
    // rust: *shared.control.lock().unwrap() = Some(control.try_clone()?);
    // rust: if shared.stopped() {
    // rust: let _ = control.shutdown(Shutdown::Both);
    // rust: return Ok(());
}
    // rust: shared.guesses.lock().unwrap().registered();
    // rust: shared.publish(Some(code.clone()));
    // rust: loop {
    // rust: let message = match wire::recv_buffered::<_, FromRelay>(&mut reader) {
    // rust: Ok(m) => m,
    // rust: Err(e) => {
    // rust: shared.control.lock().unwrap().take();
    // rust: return if shared.stopped() || shared.guesses.lock().unwrap().retiring() {
    // rust: Ok(())
    // rust: } else {
    // rust: Err(e)
}
}
}
    // rust: match message {
    // rust: FromRelay::Ping => wire::send(&mut control, &ToRelay::Pong)?,
    // rust: FromRelay::Join { session } => {
    // rust: if shared.sessions.load(Ordering::Relaxed) >= MAX_SESSIONS
    // rust: || !shared.guesses.lock().unwrap().reserve()
    // rust: {
    // rust: continue;
}
    // rust: let reserved = Reserved(shared.clone());
    // rust: let (shared, code, token, control, relay_url) = (
    // rust: shared.clone(),
    // rust: code.clone(),
    // rust: token.clone(),
    // rust: control.try_clone()?,
    // rust: relay_url.to_owned(),
    // rust: );
    // rust: let _ = std::thread::Builder::new()
    // rust: .name("horizon-friends-session".into())
    // rust: .spawn(move || {
    // rust: serve_relayed(
    // rust: &shared, reserved, &relay_url, &code, &token, session, port, relay,
    // rust: &control,
    // rust: )
    // rust: });
}
    // rust: _ => {}
}
}
}

/// One guest through the relay: attach, agree on the key from the short
/// code, settle on a direct or relayed stream, carry it.
    // rust: fn serve_relayed(
    // rust: shared: &Arc<Shared>,
    // rust: reserved: Reserved,
    // rust: relay_url: &str,
    // rust: code: &Code,
    // rust: token: &str,
    // rust: session: u64,
    // rust: port: Option<u16>,
    // rust: relay: SocketAddr,
    // rust: control: &TcpStream,
    // rust: ) {
    // rust: let config = &shared.config;
    // rust: let Ok((mut stream, _)) = connect_relay(relay_url, port) else {
    // rust: return;
}
    // What the relay sees of an attach from another port is no address of
    // this host's: nothing listens there.
    // rust: let from_port = stream.local_addr().ok().map(|a| a.port()) == port;
    // rust: let _ = stream.set_read_timeout(Some(Duration::from_secs(15)));
    // rust: let attach = ToRelay::Attach {
    // rust: v: wire::VERSION,
    // rust: session,
    // rust: token: token.to_owned(),
}
    // rust: if wire::send(&mut stream, &attach).is_err() {
    // rust: return;
}
    // rust: let observed = match wire::recv::<_, FromRelay>(&mut stream) {
    // rust: Ok(FromRelay::Bridged { observed, .. }) => observed
    // rust: .filter(|_| from_port)
    // rust: .and_then(|o| o.parse::<SocketAddr>().ok()),
    // rust: _ => return,
}
    // rust: let Ok(key) = crypto::exchange(&mut stream, &code.secret, &code.nameplate, session) else {
    // rust: return;
}
    // rust: let relayed = match session::secure(stream, &key, Role::Host) {
    // rust: Ok(s) => {
    // rust: drop(reserved);
    // rust: s
}
        // Not only a wrong confirmation: the host sends its own before it
        // reads the guest's, so a peer that checks it against its guess and
        // hangs up has had its guess as well.
    // rust: Err(_) => {
    // rust: let (count, retire) = shared.guesses.lock().unwrap().wrong();
    // rust: drop(reserved);
    // rust: shared.emit(HostEvent::WrongCode { count });
    // rust: if retire {
                // Retire the short code: dropping the control connection
                // ends it at the relay, and `run_relay` registers anew.
    // rust: let _ = control.shutdown(Shutdown::Both);
}
    // rust: return;
}
}
    // rust: let candidates = port.map_or_else(Vec::new, |p| direct::candidates(p, Some(relay), observed));
    // rust: let routes = shared.clone();
    // rust: let settled = session::settle(
    // rust: relayed,
    // rust: &key,
    // rust: Role::Host,
    // rust: config.path,
    // rust: session,
    // rust: port,
    // rust: candidates,
    // rust: Box::new(move |tx, deadline, _stop| {
    // rust: routes
    // rust: .routes
    // rust: .lock()
    // rust: .unwrap()
    // rust: .insert(session, (tx, deadline + Duration::from_millis(500)));
    // rust: }),
    // rust: );
    // rust: shared.routes.lock().unwrap().remove(&session);
    // rust: if let Ok(settled) = settled {
    // rust: carry(shared, session, settled.secure, settled.direct);
}
}

    // rust: mod tests {
//     use super::*;

    /// One relayed key exchange that ends without a confirmation.
pub fn guess_wrong(g: *mut Guesses) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: assert!(g.reserve());
    // rust: let (_, retire) = g.wrong();
    // rust: g.release();
    // rust: retire
}

pub fn wrong_guesses_add_up_across_registrations() void {
}
    // rust: let mut g = Guesses::default();
    // rust: let mut waits = Vec::new();
    // rust: loop {
    // rust: g.registered();
    // rust: let retired: Vec<bool> = (0..MAX_WRONG).map(|_| guess_wrong(&mut g)).collect();
            // Only the fifth wrong secret on a code retires it.
    // rust: assert_eq!(retired.iter().filter(|r| **r).count(), 1);
    // rust: assert!(retired[MAX_WRONG as usize - 1]);
            // No more guesses on a retired code.
    // rust: assert!(!g.reserve());
    // rust: match g.next() {
    // rust: Next::Wait(d) => waits.push(d.as_secs()),
    // rust: Next::Stop => break,
    // rust: Next::Now => panic!("a retired code registers again at once"),
}
}
    // rust: assert_eq!(g.total, MAX_WRONG_TOTAL);
        // Every new code waits twice as long; then the host leaves the relay.
    // rust: assert_eq!(waits, [1, 2, 4, 8, 16, 32, 64, 128, 256]);
    // rust: g.registered();
    // rust: assert!(!g.reserve(), "the total is spent");
}

pub fn exchanges_in_progress_count_against_the_limit() void {
}
    // rust: let mut g = Guesses::default();
    // rust: for _ in 0..MAX_WRONG {
    // rust: assert!(g.reserve());
}
        // A sixth at once could be a sixth wrong guess on this code.
    // rust: assert!(!g.reserve());
        // A friend who got in frees the guess.
    // rust: g.release();
    // rust: assert!(g.reserve());
        // Nothing was wrong: no code retired, no wait.
    // rust: assert_eq!(g.next(), Next::Now);
}

pub fn the_wait_doubles_up_to_five_minutes() void {
}
    // rust: let secs: Vec<u64> = (1..=12).map(|n| retire_delay(n).as_secs()).collect();
    // rust: assert_eq!(secs, [1, 2, 4, 8, 16, 32, 64, 128, 256, 300, 300, 300]);
    // rust: assert_eq!(retire_delay(u32::MAX), MAX_RETIRE_DELAY);
}
}
