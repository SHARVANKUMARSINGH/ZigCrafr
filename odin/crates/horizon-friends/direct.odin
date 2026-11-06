//! Transpiled from Horizon Rust crate
package horizon_friends_direct

import "core:fmt"
import "core:mem"
import "core:math"

// Direct connections between a host and a guest: the addresses each end
// offers, and the race that dials all of the other's at once from the port
// it also listens on (so two NATs that map a port the same way for every
// destination let the two SYNs cross: TCP simultaneous open).
// use socket2::{Domain, Protocol, SockAddr, Socket, Type};
// use std::{
    // rust: io::{self, Read, Write},
    // rust: net::{IpAddr, Ipv4Addr, Ipv6Addr, SocketAddr, TcpListener, TcpStream},
    // rust: sync::{
    // rust: Arc,
    // rust: atomic::{AtomicBool, Ordering},
    // rust: mpsc::Sender,
    // rust: },
    // rust: time::{Duration, Instant},
}

// How long the ends try to reach each other directly.
RACE :: Duration::from_millis(3000)
RETRY :: Duration::from_millis(250)
MAGIC :: b"HZF1"
// A guest dialling an endpoint from an invite code (no relay involved).
CODE_MAGIC :: b"HZF2"

socket_for :: proc(addr: ^SocketAddr) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let s = Socket::new(
    // rust: Domain::for_address(*addr),
    // rust: Type::STREAM,
    // rust: Some(Protocol::TCP),
    // rust: )?;
    // rust: s.set_reuse_address(true)?;
    // rust: s.set_reuse_port(true)?;
    // rust: if addr.is_ipv6() {
    // rust: s.set_only_v6(true)?;
}
    // rust: Ok(s)
}

unspecified :: proc(v6: bool, port: u16) -> S {
    // Ported from Horizon
    return {}
}
    // rust: if v6 {
    // rust: SocketAddr::new(IpAddr::V6(Ipv6Addr::UNSPECIFIED), port)
    // rust: } else {
    // rust: SocketAddr::new(IpAddr::V4(Ipv4Addr::UNSPECIFIED), port)
}
}

// The direct socket's listeners: IPv4 on `port` (0 picks one), and IPv6 on
// the same port when the system has it.
listen :: proc(port: u16) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let bind = |addr: SocketAddr| -> io::Result<TcpListener> {
    // rust: let s = socket_for(&addr)?;
    // rust: s.bind(&SockAddr::from(addr))?;
    // rust: s.listen(16)?;
    // rust: let l: TcpListener = s.into();
    // rust: l.set_nonblocking(true)?;
    // rust: Ok(l)
}
    // rust: let v4 = bind(unspecified(false, port))?;
    // rust: let port = v4.local_addr()?.port();
    // rust: let mut out = vec![v4];
    // rust: if let Ok(v6) = bind(unspecified(true, port)) {
    // rust: out.push(v6);
}
    // rust: Ok((out, port))
}

// Connect to `to` from local `port` (shared with the listener), or from any
// port when that one can't be used (the same pair already connected).
connect_from :: proc(port: Maybe(u16), to: SocketAddr, timeout: Duration) -> i {
    // Ported from Horizon
    return {}
}
    // rust: if let Some(port) = port {
    // rust: let s = socket_for(&to)?;
    // rust: if s.bind(&SockAddr::from(unspecified(to.is_ipv6(), port)))
    // rust: .is_ok()
    // rust: {
    // rust: match s.connect_timeout(&SockAddr::from(to), timeout) {
    // rust: Ok(()) => return Ok(s.into()),
    // rust: Err(e)
    // rust: if e.kind() != io::ErrorKind::AddrInUse
    // rust: && e.kind() != io::ErrorKind::AddrNotAvailable =>
    // rust: {
    // rust: return Err(e);
}
    // rust: Err(_) => {}
}
}
}
    // rust: TcpStream::connect_timeout(&to, timeout)
}

// This end's candidates for a relayed session: its interface addresses
// with the direct port (loopback when the relay is local), then the address
// the relay saw (when it is not one of them).
    // rust: pub fn candidates(
    // rust: port: u16,
    // rust: relay: Option<SocketAddr>,
    // rust: observed: Option<SocketAddr>,
    // rust: ) -> Vec<SocketAddr> {
    // rust: let loopback = relay.is_some_and(|r| r.ip().is_loopback());
    // rust: let mut out: Vec<SocketAddr> = crate::reach::interface_addresses(loopback)
    // rust: .into_iter()
    // rust: .map(|ip| SocketAddr::new(ip, port))
    // rust: .collect();
    // rust: if let Some(o) = observed
    // rust: && !o.ip().is_unspecified()
    // rust: && !out.contains(&o)
    // rust: {
    // rust: out.push(o);
}
    // rust: out.truncate(crate::invite::MAX_ENDPOINTS);
    // rust: out
}

// Both ends open every direct stream the same way, whoever dialled: the
// magic and the session, then the other's must match.
introduce :: proc(stream: ^TcpStream, session: u64) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let mut hello = [0u8; 12];
    // rust: hello[..4].copy_from_slice(MAGIC);
    // rust: hello[4..].copy_from_slice(&session.to_be_bytes());
    // rust: stream.set_read_timeout(Some(Duration::from_secs(2)))?;
    // rust: stream.write_all(&hello)?;
    // rust: let mut theirs = [0u8; 12];
    // rust: stream.read_exact(&mut theirs)?;
    // rust: if theirs != hello {
    // rust: return Err(io::Error::new(
    // rust: io::ErrorKind::InvalidData,
    // rust: "not this session",
    // rust: ));
}
    // rust: Ok(())
}

// The session an inbound direct stream belongs to (the host's listener
// serves every session): reads the other end's introduction.
read_session :: proc(stream: ^TcpStream) -> i {
    // Ported from Horizon
    return {}
}
    // rust: stream.set_read_timeout(Some(Duration::from_secs(2)))?;
    // rust: let mut theirs = [0u8; 12];
    // rust: stream.read_exact(&mut theirs)?;
    // rust: if &theirs[..4] != MAGIC {
    // rust: return Err(io::Error::new(
    // rust: io::ErrorKind::InvalidData,
    // rust: "not a direct stream",
    // rust: ));
}
    // rust: Ok(u64::from_be_bytes(theirs[4..].try_into().unwrap()))
}
// What an inbound stream on the host's direct port is.
Hello :: enum {
    // A relayed session's direct race.
    Relayed(u64),
    // A guest with the invite code.
    Code(u64),
}
read_hello :: proc(stream: ^TcpStream) -> i {
    // Ported from Horizon
    return {}
}
    // rust: stream.set_read_timeout(Some(Duration::from_secs(5)))?;
    // rust: let mut theirs = [0u8; 12];
    // rust: stream.read_exact(&mut theirs)?;
    // rust: let session = u64::from_be_bytes(theirs[4..].try_into().unwrap());
    // rust: match &theirs[..4] {
    // rust: m if m == MAGIC => Ok(Hello::Relayed(session)),
    // rust: m if m == CODE_MAGIC => Ok(Hello::Code(session)),
    // rust: _ => Err(io::Error::new(
    // rust: io::ErrorKind::InvalidData,
    // rust: "not a Horizon stream",
    // rust: )),
}
}
// The guest's side of a code session's opening: send the hello, wait for
// its echo (proof a Horizon host listens there).
code_hello :: proc(stream: ^TcpStream, session: u64) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let mut hello = [0u8; 12];
    // rust: hello[..4].copy_from_slice(CODE_MAGIC);
    // rust: hello[4..].copy_from_slice(&session.to_be_bytes());
    // rust: stream.set_read_timeout(Some(Duration::from_secs(4)))?;
    // rust: stream.write_all(&hello)?;
    // rust: let mut theirs = [0u8; 12];
    // rust: stream.read_exact(&mut theirs)?;
    // rust: if theirs != hello {
    // rust: return Err(io::Error::new(
    // rust: io::ErrorKind::InvalidData,
    // rust: "not a Horizon host",
    // rust: ));
}
    // rust: Ok(())
}
// The host echoes a code session's hello.
answer_code :: proc(stream: ^TcpStream, session: u64) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let mut hello = [0u8; 12];
    // rust: hello[..4].copy_from_slice(CODE_MAGIC);
    // rust: hello[4..].copy_from_slice(&session.to_be_bytes());
    // rust: stream.write_all(&hello)
}
// Answer an inbound stream's introduction for `session`.
answer :: proc(stream: ^TcpStream, session: u64) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let mut hello = [0u8; 12];
    // rust: hello[..4].copy_from_slice(MAGIC);
    // rust: hello[4..].copy_from_slice(&session.to_be_bytes());
    // rust: stream.write_all(&hello)
}

// Dial each target from `port` until one connects, the deadline passes or
// `stop` is set; streams that connect are introduced and sent on.
    // rust: pub fn dial(
    // rust: port: Option<u16>,
    // rust: targets: Vec<SocketAddr>,
    // rust: session: u64,
    // rust: deadline: Instant,
    // rust: stop: Arc<AtomicBool>,
    // rust: found: Sender<TcpStream>,
    // rust: ) {
    // rust: for target in targets {
    // rust: let (stop, found) = (stop.clone(), found.clone());
    // rust: let _ = std::thread::Builder::new()
    // rust: .name("horizon-friends-dial".into())
    // rust: .spawn(move || {
    // rust: while !stop.load(Ordering::Relaxed) {
    // rust: let now = Instant::now();
    // rust: if now >= deadline {
    // rust: return;
}
    // rust: let tried = Instant::now();
    // rust: let wait = (deadline - now).min(Duration::from_millis(600));
    // rust: if let Ok(mut s) = connect_from(port, target, wait)
    // rust: && introduce(&mut s, session).is_ok()
    // rust: {
    // rust: let _ = found.send(s);
    // rust: return;
}
    // rust: let spent = tried.elapsed();
    // rust: if spent < RETRY {
    // rust: std::thread::sleep(RETRY - spent);
}
}
    // rust: });
}
}

// Accept on the listeners until the deadline or `stop`; inbound streams for
// `session` are answered and sent on.
    // rust: pub fn accept(
    // rust: listeners: Vec<TcpListener>,
    // rust: session: u64,
    // rust: deadline: Instant,
    // rust: stop: Arc<AtomicBool>,
    // rust: found: Sender<TcpStream>,
    // rust: ) {
    // rust: let _ = std::thread::Builder::new()
    // rust: .name("horizon-friends-accept".into())
    // rust: .spawn(move || {
    // rust: while !stop.load(Ordering::Relaxed) && Instant::now() < deadline {
    // rust: let mut idle = true;
    // rust: for l in &listeners {
    // rust: if let Ok((mut s, _)) = l.accept() {
    // rust: idle = false;
    // rust: let _ = s.set_nonblocking(false);
    // rust: if read_session(&mut s).ok() == Some(session)
    // rust: && answer(&mut s, session).is_ok()
    // rust: {
    // rust: let _ = found.send(s);
}
}
}
    // rust: if idle {
    // rust: std::thread::sleep(Duration::from_millis(20));
}
}
    // rust: });
}

    // rust: mod tests {
//     use super::*;
//     use std::sync::mpsc::channel;

candidates_have_the_port_and_the_observed_address :: proc() {
}
    // rust: let relay = SocketAddr::from(([127, 0, 0, 1], 1));
    // rust: let observed = SocketAddr::from(([203, 0, 113, 5], 40000));
    // rust: let c = candidates(5555, Some(relay), Some(observed));
    // rust: assert!(c.contains(&SocketAddr::from(([127, 0, 0, 1], 5555))));
    // rust: assert_eq!(c.last(), Some(&observed));
    // rust: let far = candidates(5555, None, None);
    // rust: assert!(
    // rust: far.iter()
    // rust: .all(|a| !a.ip().is_loopback() && a.port() == 5555)
    // rust: );
}

    // Two direct sockets on loopback: each listens on its port and dials
    // the other's from it; the session's streams meet and wrong sessions
    // don't.
the_race_connects_and_checks_the_session :: proc() {
}
    // rust: let (la, pa) = listen(0).unwrap();
    // rust: let (lb, pb) = listen(0).unwrap();
    // rust: assert_ne!(pa, pb);
    // rust: let stop = Arc::new(AtomicBool::new(false));
    // rust: let deadline = Instant::now() + Duration::from_secs(3);
    // rust: let (ta, ra) = channel();
    // rust: let (tb, rb) = channel();
    // rust: accept(la, 42, deadline, stop.clone(), ta.clone());
    // rust: accept(lb, 42, deadline, stop.clone(), tb.clone());
    // rust: dial(
    // rust: Some(pa),
    // rust: vec![SocketAddr::from(([127, 0, 0, 1], pb))],
    // rust: 42,
    // rust: deadline,
    // rust: stop.clone(),
    // rust: ta,
    // rust: );
    // rust: let mut a = ra.recv_timeout(Duration::from_secs(3)).unwrap();
    // rust: let mut b = rb.recv_timeout(Duration::from_secs(3)).unwrap();
    // rust: a.write_all(b"ping").unwrap();
    // rust: let mut got = [0u8; 4];
    // rust: b.read_exact(&mut got).unwrap();
    // rust: assert_eq!(&got, b"ping");
    // rust: stop.store(true, Ordering::Relaxed);

    // rust: let (lc, pc) = listen(0).unwrap();
    // rust: let (tc, rc) = channel();
    // rust: let deadline = Instant::now() + Duration::from_millis(800);
    // rust: let stop = Arc::new(AtomicBool::new(false));
    // rust: accept(lc, 7, deadline, stop.clone(), tc.clone());
    // rust: let (td, rd) = channel();
    // rust: dial(
    // rust: None,
    // rust: vec![SocketAddr::from(([127, 0, 0, 1], pc))],
    // rust: 8,
    // rust: deadline,
    // rust: stop,
    // rust: td,
    // rust: );
    // rust: assert!(rc.recv_timeout(Duration::from_secs(2)).is_err());
    // rust: assert!(rd.recv_timeout(Duration::from_millis(100)).is_err());
}
}
