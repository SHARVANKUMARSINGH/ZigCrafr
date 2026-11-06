//! Transpiled from Horizon Rust crate
package horizon_relay_lib

import "core:fmt"
import "core:mem"
import "core:math"

// Play with friends' relay. Hosts register and get a nameplate (the
// relay-visible half of an invite code); guests resolve it; the relay
// pairs each guest's connection with a fresh one from the host and copies
// bytes between them. Those bytes are the end-to-end encrypted session
// (docs/play-with-friends.md): the relay can't read them, only count them.
// State is in memory; nothing about players is logged.
    // rust: pub mod limits;

// use horizon_friends::{
    // rust: code,
    // rust: wire::{self, ErrorCode, FromRelay, ToRelay},
}
// use limits::{Bucket, Limiter, Rates};
// use std::{
    // rust: collections::HashMap,
    // rust: io::{self, Read, Write},
    // rust: net::{Shutdown, SocketAddr, TcpListener, TcpStream},
    // rust: sync::{
    // rust: Arc, Mutex, MutexGuard,
    // rust: atomic::{AtomicBool, AtomicU64, AtomicUsize, Ordering},
    // rust: mpsc::{Receiver, RecvTimeoutError, Sender, SyncSender, channel, sync_channel},
    // rust: },
    // rust: thread::JoinHandle,
    // rust: time::{Duration, Instant},
}

Config :: struct {
    max_hosts: uint,
    max_bridges: uint,
    max_pending_per_host: uint,
    // Connections open at once, of every kind (each is a thread).
    max_connections: uint,
    // Bytes a second each way per relayed stream.
    session_rate: f64,
    // Bytes a second for everything relayed.
    total_rate: f64,
    rates: Rates,
    // Count limits per client address (off when every client comes from
    // the same proxy address).
    per_address: bool,
    // Unknown codes a minute across all clients, and the burst.
    global_unknown_per_min: f64,
    global_unknown_burst: f64,
    // Read a PROXY protocol v1 line before anything else.
    proxy_protocol: bool,
    // The load balancers allowed to send that line (`RELAY_PROXY_FROM`, addresses or CIDR ranges).
    // A connection from anywhere else is closed unanswered: its line would be a client choosing its
    // own address. The relay refuses to start with `proxy_protocol` and none listed ([`Config::check`]).
    proxy_from: [dynamic]Net,
    idle: Duration,
    ping_every: Duration,
    host_timeout: Duration,
    first_line: Duration,
    attach_wait: Duration,
    ended_kept: Duration,
}
    // rust: impl Default for Config {
default :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: max_hosts: 1000,
    // rust: max_bridges: 200,
    // rust: max_pending_per_host: 8,
    // rust: max_connections: 4096,
    // rust: session_rate: 1024.0 * 1024.0,
    // rust: total_rate: 100.0 * 1_000_000.0 / 8.0,
    // rust: rates: Rates::default(),
    // rust: per_address: true,
    // rust: global_unknown_per_min: 120.0,
    // rust: global_unknown_burst: 30.0,
    // rust: proxy_protocol: false,
    // rust: proxy_from: Vec::new(),
    // rust: idle: Duration::from_secs(120),
    // rust: ping_every: Duration::from_secs(20),
    // rust: host_timeout: Duration::from_secs(60),
    // rust: first_line: Duration::from_secs(10),
    // rust: attach_wait: Duration::from_secs(10),
    // rust: ended_kept: Duration::from_secs(15 * 60),
}
}
}
    // rust: impl Config {
    // The defaults with the `RELAY_*` environment variables applied: an error for a setting the relay
    // can't run with as given ([`Config::check`]).
from_env :: proc() -> R {
    // Ported from Horizon
    return {}
}
    // rust: fn var<T: std::str::FromStr>(name: &str) -> Option<T> {
    // rust: std::env::var(name).ok()?.trim().parse().ok()
}
    // rust: let mut c = Self::default();
    // rust: if let Some(v) = var("RELAY_MAX_HOSTS") {
    // rust: c.max_hosts = v;
}
    // rust: if let Some(v) = var("RELAY_MAX_HOSTS_PER_ADDRESS") {
    // rust: c.rates.hosts_per_address = v;
}
    // rust: if let Some(v) = var("RELAY_MAX_BRIDGES") {
    // rust: c.max_bridges = v;
}
    // rust: if let Some(v) = var("RELAY_MAX_PENDING_PER_HOST") {
    // rust: c.max_pending_per_host = v;
}
    // rust: if let Some(v) = var("RELAY_MAX_CONNECTIONS") {
    // rust: c.max_connections = v;
}
    // rust: if let Some(v) = var::<f64>("RELAY_SESSION_KBPS") {
    // rust: c.session_rate = v * 1024.0;
}
    // rust: if let Some(v) = var::<f64>("RELAY_TOTAL_MBPS") {
    // rust: c.total_rate = v * 1_000_000.0 / 8.0;
}
    // rust: if let Some(v) = var::<f64>("RELAY_GLOBAL_UNKNOWN_PER_MIN") {
    // rust: c.global_unknown_per_min = v;
}
    // rust: if let Some(v) = var::<u8>("RELAY_PER_ADDRESS_LIMITS") {
    // rust: c.per_address = v != 0;
}
    // rust: if let Some(v) = var::<u8>("RELAY_PROXY_PROTOCOL") {
    // rust: c.proxy_protocol = v != 0;
}
    // rust: if let Ok(list) = std::env::var("RELAY_PROXY_FROM") {
    // rust: c.proxy_from = Net::parse_list(&list).map_err(|e| format!("RELAY_PROXY_FROM: {e}"))?;
}
    // rust: c.check()?;
    // rust: Ok(c)
}

    // Why the relay must not start with these settings, if it mustn't.
check :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if self.proxy_protocol && self.proxy_from.is_empty() {
    // rust: return Err("RELAY_PROXY_PROTOCOL=1 needs RELAY_PROXY_FROM: the load balancers' addresses or \
    // rust: ranges (e.g. 10.0.0.0/8). Without it any client could send a PROXY line and choose \
    // rust: the address its limits count."
    // rust: .into());
}
    // rust: Ok(())
}
}

// An address or a CIDR range: `10.1.2.3`, `10.0.0.0/8`, `fd00::/8`.
Net :: struct {
    address: std::net::IpAddr,
    prefix: u8,
}
    // rust: impl Net {
parse :: proc(text: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let text = text.trim();
    // rust: let (address, prefix) = match text.split_once('/') {
    // rust: Some((a, p)) => (a, Some(p)),
    // rust: None => (text, None),
}
    // rust: let address: std::net::IpAddr = address
    // rust: .parse()
    // rust: .map_err(|_| format!("{text:?} is not an address or a range"))?;
    // rust: let bits = if address.is_ipv4() { 32 } else { 128 };
    // rust: let prefix = match prefix {
    // rust: None => bits,
    // rust: Some(p) => p
    // rust: .parse::<u8>()
    // rust: .ok()
    // rust: .filter(|p| *p <= bits)
    // rust: .ok_or_else(|| format!("{text:?}: the prefix is 0 to {bits}"))?,
}
    // rust: Ok(Self { address, prefix })
}

    // A comma-separated list; empty entries are skipped, a bad one is an error.
parse_list :: proc(text: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: text.split(',')
    // rust: .filter(|t| !t.trim().is_empty())
    // rust: .map(Self::parse)
    // rust: .collect()
}

contains :: proc(self: ^Self, ip: std::net::IpAddr) -> b {
    // Ported from Horizon
    return {}
}
//         use std::net::IpAddr;
        // An IPv4 client of a dual-stack listener arrives as ::ffff:a.b.c.d.
    // rust: let ip = match ip {
    // rust: IpAddr::V6(v6) => v6.to_ipv4_mapped().map_or(ip, IpAddr::V4),
    // rust: v4 => v4,
}
    // rust: match (self.address, ip) {
    // rust: (IpAddr::V4(net), IpAddr::V4(ip)) => {
    // rust: let mask = u32::MAX
    // rust: .checked_shl(32 - u32::from(self.prefix))
    // rust: .unwrap_or(0);
    // rust: u32::from(net) & mask == u32::from(ip) & mask
}
    // rust: (IpAddr::V6(net), IpAddr::V6(ip)) => {
    // rust: let mask = u128::MAX
    // rust: .checked_shl(128 - u32::from(self.prefix))
    // rust: .unwrap_or(0);
    // rust: u128::from(net) & mask == u128::from(ip) & mask
}
    // rust: _ => false,
}
}
}

// What the relay reports (and logs): counts only.
Counts :: struct {
    hosts: uint,
    // Bridges open, and joins matched with a host and waiting for its attach (each holds one of
    // `max_bridges` from the match on).
    bridges: uint,
    registrations: u64,
    joins: u64,
    unknown: u64,
    rate_limited: u64,
    relayed_bytes: u64,
}
    // rust: impl Counts {
json :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: format!(
    // rust: "{{\"ok\":true,\"hosts\":{},\"bridges\":{},\"registrations\":{},\"joins\":{},\"unknown\":{},\"rate_limited\":{},\"relayed_bytes\":{}}}",
    // rust: self.hosts,
    // rust: self.bridges,
    // rust: self.registrations,
    // rust: self.joins,
    // rust: self.unknown,
    // rust: self.rate_limited,
    // rust: self.relayed_bytes
    // rust: )
}
}

// What the host's control connection sends next.
Out :: enum {
    Line(FromRelay),
    // The host stopped answering or went away.
    Closed,
}
HostEntry :: struct {
    token: string,
    protocol: i32,
    game: string,
    to_host: Sender<Out>,
    pending: uint,
}
Pending :: struct {
    nameplate: string,
    attach: SyncSender<(TcpStream,
}
Inner :: struct {
    hosts: HashMap<string,
    ended: HashMap<string,
    pending: HashMap<u64,
}

State :: struct {
    config: Config,
    inner: Mutex<Inner>,
    limiter: Mutex<Limiter>,
    global_unknown: Mutex<Bucket>,
    total: Mutex<Bucket>,
    bridges: AtomicUsize,
    connections: AtomicUsize,
    registrations: AtomicU64,
    joins: AtomicU64,
    unknown: AtomicU64,
    rate_limited: AtomicU64,
    relayed_bytes: AtomicU64,
    stop: AtomicBool,
}

// The state behind `mutex`, even if a connection's thread panicked holding it: one bad connection
// must not make every later one panic too.
    // rust: fn locked<T>(mutex: &Mutex<T>) -> MutexGuard<'_, T> {
    // rust: mutex
    // rust: .lock()
    // rust: .unwrap_or_else(|poisoned| poisoned.into_inner())
}

Relay :: struct {
    state: ^State,
}

random_u64 :: proc() -> u {
    // Ported from Horizon
    return {}
}
    // rust: let mut b = [0u8; 8];
    // rust: getrandom::fill(&mut b).expect("OS random generator");
    // rust: u64::from_le_bytes(b)
}
random_token :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut b = [0u8; 16];
    // rust: getrandom::fill(&mut b).expect("OS random generator");
    // rust: b.iter().map(|x| format!("{x:02x}")).collect()
}

    // rust: impl Relay {
new :: proc(config: Config) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let now = Instant::now();
    // rust: Self {
    // rust: state: Arc::new(State {
    // rust: limiter: Mutex::new(Limiter::new(config.rates.clone(), config.per_address)),
    // rust: global_unknown: Mutex::new(Bucket::new(
    // rust: config.global_unknown_per_min / 60.0,
    // rust: config.global_unknown_burst,
    // rust: now,
    // rust: )),
    // rust: total: Mutex::new(Bucket::new(config.total_rate, config.total_rate / 4.0, now)),
    // rust: config,
    // rust: inner: Mutex::new(Inner::default()),
    // rust: bridges: AtomicUsize::new(0),
    // rust: connections: AtomicUsize::new(0),
    // rust: registrations: AtomicU64::new(0),
    // rust: joins: AtomicU64::new(0),
    // rust: unknown: AtomicU64::new(0),
    // rust: rate_limited: AtomicU64::new(0),
    // rust: relayed_bytes: AtomicU64::new(0),
    // rust: stop: AtomicBool::new(false),
    // rust: }),
}
}
    // A relay on a free loopback port, served on a thread (tests).
spawn_local :: proc(config: Config) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let listener = TcpListener::bind("127.0.0.1:0")?;
    // rust: let address = listener.local_addr()?;
    // rust: let relay = Self::new(config);
    // rust: let r = relay.clone();
    // rust: let t = std::thread::spawn(move || r.serve(listener));
    // rust: Ok((relay, address, t))
}
counts :: proc(self: ^Self) -> C {
    // Ported from Horizon
    return {}
}
    // rust: counts(&self.state)
}
stop :: proc(self: ^Self) {
}
    // rust: self.state.stop.store(true, Ordering::Relaxed);
}
    // Accept connections until [`Relay::stop`].
serve :: proc(self: ^Self, listener: TcpListener) {
}
    // rust: let _ = listener.set_nonblocking(true);
    // rust: while !self.state.stop.load(Ordering::Relaxed) {
    // rust: match listener.accept() {
    // rust: Ok((stream, peer)) => {
                    // Beyond the cap the connection is closed unanswered.
    // rust: if self.state.connections.fetch_add(1, Ordering::Relaxed)
    // rust: >= self.state.config.max_connections
    // rust: {
    // rust: self.state.connections.fetch_sub(1, Ordering::Relaxed);
    // rust: continue;
}
    // rust: let state = self.state.clone();
    // rust: let spawned =
    // rust: std::thread::Builder::new()
    // rust: .name("relay-conn".into())
    // rust: .spawn(move || {
    // rust: let _ = stream.set_nonblocking(false);
    // rust: let _ = handle(&state, stream, peer);
    // rust: state.connections.fetch_sub(1, Ordering::Relaxed);
    // rust: });
    // rust: if spawned.is_err() {
    // rust: self.state.connections.fetch_sub(1, Ordering::Relaxed);
}
}
    // rust: Err(e) if e.kind() == io::ErrorKind::WouldBlock => {
    // rust: std::thread::sleep(Duration::from_millis(10));
}
    // rust: Err(_) => std::thread::sleep(Duration::from_millis(50)),
}
}
}
}

counts :: proc(s: ^State) -> C {
    // Ported from Horizon
    return {}
}
    // rust: Counts {
    // rust: hosts: locked(&s.inner).hosts.len(),
    // rust: bridges: s.bridges.load(Ordering::Relaxed),
    // rust: registrations: s.registrations.load(Ordering::Relaxed),
    // rust: joins: s.joins.load(Ordering::Relaxed),
    // rust: unknown: s.unknown.load(Ordering::Relaxed),
    // rust: rate_limited: s.rate_limited.load(Ordering::Relaxed),
    // rust: relayed_bytes: s.relayed_bytes.load(Ordering::Relaxed),
}
}

refuse :: proc(stream: ^TcpStream, code: ErrorCode) -> i {
    // Ported from Horizon
    return {}
}
    // rust: wire::send(stream, &FromRelay::Error { code, game: None })
}

// `PROXY TCP4 <src> <dst> <sport> <dport>`: the client's address.
proxy_line :: proc(line: []u8) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let text = std::str::from_utf8(line).ok()?.trim_end_matches('\r');
    // rust: let parts: Vec<&str> = text.split(' ').collect();
    // rust: match parts.as_slice() {
    // rust: ["PROXY", "TCP4" | "TCP6", src, _, sport, _] => {
    // rust: Some(SocketAddr::new(src.parse().ok()?, sport.parse().ok()?))
}
    // rust: _ => None,
}
}

// IPv4 clients of a dual-stack listener show up as `::ffff:a.b.c.d`:
// their address as IPv4, which is what the other end can dial.
unmap :: proc(peer: SocketAddr) -> S {
    // Ported from Horizon
    return {}
}
    // rust: match peer {
    // rust: SocketAddr::V6(v6) => match v6.ip().to_ipv4_mapped() {
    // rust: Some(v4) => SocketAddr::new(v4.into(), v6.port()),
    // rust: None => peer,
    // rust: },
    // rust: v4 => v4,
}
}

handle :: proc(state: ^^State, mut stream: TcpStream, peer: SocketAddr) -> i {
    // Ported from Horizon
    return {}
}
    // rust: if state.stop.load(Ordering::Relaxed) {
    // rust: return Ok(());
}
    // rust: let mut peer = unmap(peer);
    // The first line (and an HTTP request) within `first_line` in all.
    // rust: let first_line = horizon_friends::deadline(&stream, state.config.first_line)?;
    // rust: stream.set_read_timeout(Some(state.config.first_line))?;
    // rust: let _ = stream.set_nodelay(true);
    // rust: let mut line = wire::read_line(&mut stream)?.ok_or(io::ErrorKind::UnexpectedEof)?;
    // rust: if state.config.proxy_protocol {
    // rust: if !state
    // rust: .config
    // rust: .proxy_from
    // rust: .iter()
    // rust: .any(|net| net.contains(peer.ip()))
    // rust: {
            // Not from our load balancer: its PROXY line would be the client's own say.
    // rust: return Ok(());
}
    // rust: peer = proxy_line(&line)
    // rust: .map(unmap)
    // rust: .ok_or_else(|| io::Error::new(io::ErrorKind::InvalidData, "no PROXY line"))?;
    // rust: line = wire::read_line(&mut stream)?.ok_or(io::ErrorKind::UnexpectedEof)?;
}
    // rust: if line.starts_with(b"GET ") {
    // rust: return http(state, &mut stream, &line, peer);
}
    // rust: drop(first_line);
    // rust: let Ok(hello) = serde_json::from_slice::<ToRelay>(&line) else {
    // rust: return refuse(&mut stream, ErrorCode::BadRequest);
}
    // rust: match hello {
    // rust: ToRelay::Host { v, protocol, game } if v == wire::VERSION => {
    // rust: host(state, stream, peer, protocol, game)
}
    // rust: ToRelay::Join {
    // rust: v,
    // rust: nameplate,
    // rust: protocol,
    // rust: ..
    // rust: } if v == wire::VERSION => join(state, stream, peer, &nameplate, protocol),
    // rust: ToRelay::Attach { v, session, token } if v == wire::VERSION => {
    // rust: attach(state, stream, peer, session, &token)
}
    // rust: _ => refuse(&mut stream, ErrorCode::BadRequest),
}
}

http :: proc(state: ^State, stream: ^TcpStream, line: []u8, peer: SocketAddr) -> i {
    // Ported from Horizon
    return {}
}
    // Drain the request headers (bounded) before answering.
    // rust: let mut headers = 0;
    // rust: while let Some(h) = wire::read_line(stream)? {
    // rust: headers += 1;
    // rust: if h.is_empty() || h == b"\r" || headers > 64 {
    // rust: break;
}
}
    // rust: let path = std::str::from_utf8(line)
    // rust: .ok()
    // rust: .and_then(|l| l.split(' ').nth(1))
    // rust: .unwrap_or("");
    // rust: let (status, body) = match path {
    // rust: "/health" => ("200 OK", counts(state).json()),
        // The address the relay sees for the caller: checks that the hosting
        // platform's proxy passes client addresses through.
    // rust: "/whoami" => ("200 OK", format!("{{\"address\":\"{peer}\"}}")),
    // rust: _ => ("404 Not Found", "{\"ok\":false}".to_owned()),
}
    // rust: let response = format!(
    // rust: "HTTP/1.1 {status}\r\nContent-Type: application/json\r\nContent-Length: {}\r\nConnection: close\r\n\r\n{body}",
    // rust: body.len()
    // rust: );
    // rust: stream.write_all(response.as_bytes())
}

// One of an address's open hosts, given back when the host's connection
// ends, however it ends.
HostSlot :: struct {
    // rust: impl Drop for HostSlot<'_> {
drop :: proc(self: ^Self) {
}
    // rust: locked(&self.0.limiter).close_host(self.1);
}
}

    // rust: fn host(
    // rust: state: &Arc<State>,
    // rust: mut stream: TcpStream,
    // rust: peer: SocketAddr,
    // rust: protocol: i32,
    // rust: game: String,
    // rust: ) -> io::Result<()> {
    // rust: let now = Instant::now();
    // rust: if !locked(&state.limiter).allow_register(peer.ip(), now) {
    // rust: state.rate_limited.fetch_add(1, Ordering::Relaxed);
    // rust: return refuse(&mut stream, ErrorCode::RateLimited);
}
    // One client holding its connections open must not take every host slot.
    // rust: if !locked(&state.limiter).open_host(peer.ip()) {
    // rust: return refuse(&mut stream, ErrorCode::Full);
}
    // rust: let _slot = HostSlot(state, peer.ip());
    // rust: let (tx, rx) = channel();
    // rust: let token = random_token();
    // rust: let nameplate = {
    // rust: let mut inner = locked(&state.inner);
    // rust: let kept = state.config.ended_kept;
    // rust: inner
    // rust: .ended
    // rust: .retain(|_, t| now.saturating_duration_since(*t) < kept);
    // rust: let mut found = None;
    // rust: if inner.hosts.len() < state.config.max_hosts {
    // rust: for _ in 0..64 {
    // rust: let n = code::nameplate(random_u64() as u32);
    // rust: if !inner.hosts.contains_key(&n) && !inner.ended.contains_key(&n) {
    // rust: found = Some(n);
    // rust: break;
}
}
}
    // rust: if let Some(n) = &found {
    // rust: inner.hosts.insert(
    // rust: n.clone(),
    // rust: HostEntry {
    // rust: token: token.clone(),
    // rust: protocol,
    // rust: game: game.chars().take(32).collect(),
    // rust: to_host: tx.clone(),
    // rust: pending: 0,
    // rust: },
    // rust: );
}
    // rust: found
}
    // rust: let Some(nameplate) = nameplate else {
    // rust: return refuse(&mut stream, ErrorCode::Full);
}
    // rust: state.registrations.fetch_add(1, Ordering::Relaxed);
    // rust: let result = serve_host(state, &mut stream, peer, &nameplate, &token, tx, rx);
    // rust: {
    // rust: let mut inner = locked(&state.inner);
    // rust: if inner
    // rust: .hosts
    // rust: .get(&nameplate)
    // rust: .is_some_and(|h| h.token == token)
    // rust: {
    // rust: inner.hosts.remove(&nameplate);
    // rust: inner.ended.insert(nameplate, Instant::now());
}
}
    // rust: let _ = stream.shutdown(Shutdown::Both);
    // rust: result
}

// The host's control connection: joins and pings out, pongs in. A host
// silent for `host_timeout` is gone.
    // rust: fn serve_host(
    // rust: state: &Arc<State>,
    // rust: stream: &mut TcpStream,
    // rust: peer: SocketAddr,
    // rust: nameplate: &str,
    // rust: token: &str,
    // rust: tx: Sender<Out>,
    // rust: rx: Receiver<Out>,
    // rust: ) -> io::Result<()> {
    // rust: wire::send(
    // rust: stream,
    // rust: &FromRelay::Registered {
    // rust: nameplate: nameplate.to_owned(),
    // rust: token: token.to_owned(),
    // rust: observed: Some(peer.to_string()),
    // rust: },
    // rust: )?;
    // rust: let mut reader = stream.try_clone()?;
    // rust: reader.set_read_timeout(Some(state.config.host_timeout))?;
    // rust: std::thread::Builder::new()
    // rust: .name("relay-host-read".into())
    // rust: .spawn(move || {
    // rust: while let Ok(Some(_)) = wire::read_line(&mut reader) {}
    // rust: let _ = tx.send(Out::Closed);
    // rust: })?;
    // rust: while !state.stop.load(Ordering::Relaxed) {
    // rust: match rx.recv_timeout(state.config.ping_every) {
    // rust: Ok(Out::Line(m)) => wire::send(stream, &m)?,
    // rust: Ok(Out::Closed) | Err(RecvTimeoutError::Disconnected) => break,
    // rust: Err(RecvTimeoutError::Timeout) => wire::send(stream, &FromRelay::Ping)?,
}
}
    // rust: Ok(())
}

// One of `max_bridges`, reserved when a guest is matched with its host and given back when it drops:
// on every way out of the join (no attach, a refusal, an error, a panic) and at the bridge's end. A
// reservation counts from the match, not from the bridge, so joins waiting for their host's attach
// can't add up past the cap.
BridgeSlot :: struct {
    // rust: impl<'a> BridgeSlot<'a> {
take :: proc(count: ^'a AtomicUsize, max: uint) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if count.fetch_add(1, Ordering::AcqRel) >= max {
    // rust: count.fetch_sub(1, Ordering::AcqRel);
    // rust: return None;
}
    // rust: Some(Self(count))
}
}
    // rust: impl Drop for BridgeSlot<'_> {
drop :: proc(self: ^Self) {
}
    // rust: self.0.fetch_sub(1, Ordering::AcqRel);
}
}

Lookup :: enum {
    Found(Sender<Out>, BridgeSlot<'a>),
    Unknown,
    Ended,
    Version(String),
    Full,
}

    // rust: fn join(
    // rust: state: &Arc<State>,
    // rust: mut stream: TcpStream,
    // rust: peer: SocketAddr,
    // rust: nameplate: &str,
    // rust: protocol: i32,
    // rust: ) -> io::Result<()> {
    // rust: let now = Instant::now();
    // rust: state.joins.fetch_add(1, Ordering::Relaxed);
    // The global budget for unknown codes is checked before the lookup, so a
    // refusal says nothing about whether the nameplate exists.
    // rust: let allowed =
    // rust: locked(&state.limiter).allow_join(peer.ip(), now) && locked(&state.global_unknown).has(now);
    // rust: if !allowed {
    // rust: state.rate_limited.fetch_add(1, Ordering::Relaxed);
    // rust: return refuse(&mut stream, ErrorCode::RateLimited);
}
    // rust: let Some(nameplate) = code::parse_nameplate(nameplate) else {
    // rust: return refuse(&mut stream, ErrorCode::BadRequest);
}
    // rust: let session = random_u64();
    // rust: let (atx, arx) = sync_channel(1);
    // rust: let lookup = {
    // rust: let mut inner = locked(&state.inner);
    // rust: let ended = inner
    // rust: .ended
    // rust: .get(&nameplate)
    // rust: .is_some_and(|t| now.saturating_duration_since(*t) < state.config.ended_kept);
    // rust: let lookup = match inner.hosts.get_mut(&nameplate) {
    // rust: None if ended => Lookup::Ended,
    // rust: None => Lookup::Unknown,
    // rust: Some(h) if h.protocol != protocol => Lookup::Version(h.game.clone()),
    // rust: Some(h) if h.pending >= state.config.max_pending_per_host => Lookup::Full,
    // rust: Some(h) => match BridgeSlot::take(&state.bridges, state.config.max_bridges) {
    // rust: Some(slot) => {
    // rust: h.pending += 1;
    // rust: Lookup::Found(h.to_host.clone(), slot)
}
    // rust: None => Lookup::Full,
    // rust: },
}
    // rust: if matches!(lookup, Lookup::Found(..)) {
    // rust: inner.pending.insert(
    // rust: session,
    // rust: Pending {
    // rust: nameplate: nameplate.clone(),
    // rust: attach: atx,
    // rust: },
    // rust: );
}
    // rust: lookup
}
    // rust: let (to_host, slot) = match lookup {
    // rust: Lookup::Found(tx, slot) => (tx, slot),
    // rust: Lookup::Unknown => {
    // rust: state.unknown.fetch_add(1, Ordering::Relaxed);
    // rust: locked(&state.limiter).unknown(peer.ip(), now);
    // rust: locked(&state.global_unknown).try_take(now);
    // rust: return refuse(&mut stream, ErrorCode::UnknownCode);
}
    // rust: Lookup::Ended => return refuse(&mut stream, ErrorCode::Ended),
    // rust: Lookup::Full => return refuse(&mut stream, ErrorCode::Full),
    // rust: Lookup::Version(game) => {
    // rust: return wire::send(
    // rust: &mut stream,
    // rust: &FromRelay::Error {
    // rust: code: ErrorCode::VersionMismatch,
    // rust: game: Some(game),
    // rust: },
    // rust: );
}
}
    // rust: let _ = to_host.send(Out::Line(FromRelay::Join { session }));
    // rust: let attached = arx.recv_timeout(state.config.attach_wait);
    // rust: {
    // rust: let mut inner = locked(&state.inner);
    // rust: inner.pending.remove(&session);
    // rust: if let Some(h) = inner.hosts.get_mut(&nameplate) {
    // rust: h.pending = h.pending.saturating_sub(1);
}
}
    // rust: match attached {
    // rust: Ok((host, host_peer)) => bridge(state, stream, peer, host, host_peer, session, slot),
    // rust: Err(_) => {
    // rust: drop(slot);
    // rust: refuse(&mut stream, ErrorCode::HostUnreachable)
}
}
}

    // rust: fn attach(
    // rust: state: &Arc<State>,
    // rust: mut stream: TcpStream,
    // rust: peer: SocketAddr,
    // rust: session: u64,
    // rust: token: &str,
    // rust: ) -> io::Result<()> {
    // rust: let target = {
    // rust: let inner = locked(&state.inner);
    // rust: inner
    // rust: .pending
    // rust: .get(&session)
    // rust: .filter(|p| {
    // rust: inner
    // rust: .hosts
    // rust: .get(&p.nameplate)
    // rust: .is_some_and(|h| h.token == token)
    // rust: })
    // rust: .map(|p| p.attach.clone())
}
    // rust: match target {
    // rust: Some(tx) => match tx.try_send((stream, peer)) {
    // rust: Ok(()) => Ok(()),
    // rust: Err(
    // rust: std::sync::mpsc::TrySendError::Full((mut stream, _))
    // rust: | std::sync::mpsc::TrySendError::Disconnected((mut stream, _)),
    // rust: ) => refuse(&mut stream, ErrorCode::BadRequest),
    // rust: },
    // rust: None => refuse(&mut stream, ErrorCode::BadRequest),
}
}

// Tell both ends they are bridged, then copy each way until either ends. `_slot` (the guest's
// reservation of one of `max_bridges`) is given back when this returns, however it returns.
    // rust: fn bridge(
    // rust: state: &Arc<State>,
    // rust: mut guest: TcpStream,
    // rust: guest_peer: SocketAddr,
    // rust: mut host: TcpStream,
    // rust: host_peer: SocketAddr,
    // rust: session: u64,
    // rust: _slot: BridgeSlot<'_>,
    // rust: ) -> io::Result<()> {
    // rust: (|| -> io::Result<()> {
    // rust: wire::send(
    // rust: &mut guest,
    // rust: &FromRelay::Bridged {
    // rust: session,
    // rust: observed: Some(guest_peer.to_string()),
    // rust: },
    // rust: )?;
    // rust: wire::send(
    // rust: &mut host,
    // rust: &FromRelay::Bridged {
    // rust: session,
    // rust: observed: Some(host_peer.to_string()),
    // rust: },
    // rust: )?;
    // rust: for s in [&guest, &host] {
    // rust: s.set_read_timeout(Some(state.config.idle))?;
    // rust: let _ = s.set_nodelay(true);
}
    // rust: let (g, h, st) = (guest.try_clone()?, host.try_clone()?, state.clone());
    // rust: let up = std::thread::Builder::new()
    // rust: .name("relay-copy".into())
    // rust: .spawn(move || copy(&st, g, h))?;
    // rust: copy(state, host, guest);
    // rust: let _ = up.join();
    // rust: Ok(())
    // rust: })()
}

copy :: proc(state: ^State, mut from: TcpStream, mut to: TcpStream) {
}
    // rust: let rate = state.config.session_rate;
    // rust: let mut bucket = Bucket::new(rate, (rate / 2.0).max(16384.0), Instant::now());
    // rust: let mut buf = vec![0u8; 16 * 1024];
    // rust: loop {
    // rust: let n = match from.read(&mut buf) {
    // rust: Ok(0) | Err(_) => break,
    // rust: Ok(n) => n,
}
    // rust: let now = Instant::now();
    // rust: let wait = bucket
    // rust: .take(n as f64, now)
    // rust: .max(locked(&state.total).take(n as f64, now));
    // rust: if !wait.is_zero() {
    // rust: std::thread::sleep(wait);
}
    // rust: if to.write_all(&buf[..n]).is_err() {
    // rust: break;
}
    // rust: state.relayed_bytes.fetch_add(n as u64, Ordering::Relaxed);
}
    // rust: let _ = from.shutdown(Shutdown::Both);
    // rust: let _ = to.shutdown(Shutdown::Both);
}

    // rust: mod tests {
//     use super::*;

a_poisoned_lock_still_opens :: proc() {
}
    // rust: let mutex = Arc::new(Mutex::new(7));
    // rust: let held = mutex.clone();
    // rust: let _ = std::thread::spawn(move || {
    // rust: let _guard = held.lock().unwrap();
    // rust: panic!("a connection's thread panics holding the lock");
    // rust: })
    // rust: .join();
    // rust: assert!(mutex.is_poisoned());
    // rust: assert_eq!(*locked(&mutex), 7);
}

mapped_addresses_become_ipv4 :: proc() {
}
    // rust: assert_eq!(
    // rust: unmap("[::ffff:203.0.113.7]:5000".parse().unwrap()),
    // rust: "203.0.113.7:5000".parse().unwrap()
    // rust: );
    // rust: let v6: SocketAddr = "[2001:db8::1]:5000".parse().unwrap();
    // rust: assert_eq!(unmap(v6), v6);
}

proxy_protocol_needs_its_load_balancers :: proc() {
}
    // rust: let on = Config {
    // rust: proxy_protocol: true,
    // rust: ..Config::default()
}
    // rust: assert!(on.check().unwrap_err().contains("RELAY_PROXY_FROM"));
    // rust: let listed = Config {
    // rust: proxy_from: Net::parse_list("10.0.0.0/8, 2001:db8::/32,192.0.2.7").unwrap(),
    // rust: ..on
}
    // rust: assert!(listed.check().is_ok());
    // rust: assert!(Config::default().check().is_ok());
    // rust: for bad in ["10.0.0.0/33", "nope", "10.0.0.1/x", "::/129"] {
    // rust: assert!(Net::parse_list(bad).is_err(), "{bad}");
}
}

ranges_hold_their_addresses :: proc() {
}
    // rust: let ip = |s: &str| s.parse::<std::net::IpAddr>().unwrap();
    // rust: let ten = Net::parse("10.0.0.0/8").unwrap();
    // rust: assert!(ten.contains(ip("10.200.3.4")) && !ten.contains(ip("11.0.0.1")));
    // rust: assert!(
    // rust: ten.contains(ip("::ffff:10.1.1.1")),
    // rust: "IPv4 on a dual-stack listener"
    // rust: );
    // rust: let one = Net::parse("192.0.2.7").unwrap();
    // rust: assert!(one.contains(ip("192.0.2.7")) && !one.contains(ip("192.0.2.8")));
    // rust: let v6 = Net::parse("2001:db8::/32").unwrap();
    // rust: assert!(v6.contains(ip("2001:db8:1::5")) && !v6.contains(ip("2001:db9::1")));
    // rust: assert!(!v6.contains(ip("10.0.0.1")));
    // rust: assert!(Net::parse("0.0.0.0/0").unwrap().contains(ip("203.0.113.1")));
}

proxy_lines :: proc() {
}
    // rust: assert_eq!(
    // rust: proxy_line(b"PROXY TCP4 203.0.113.7 10.0.0.1 51000 7000\r"),
    // rust: Some("203.0.113.7:51000".parse().unwrap())
    // rust: );
    // rust: assert_eq!(
    // rust: proxy_line(b"PROXY TCP6 2001:db8::1 2001:db8::2 51000 7000"),
    // rust: Some("[2001:db8::1]:51000".parse().unwrap())
    // rust: );
    // rust: assert_eq!(proxy_line(b"PROXY UNKNOWN"), None);
    // rust: assert_eq!(proxy_line(b"{\"op\":\"pong\"}"), None);
}
}
