//! Transpiled from Horizon Rust crate
//! Module: horizon-client_discovery
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! LAN game discovery: LanServerPinger announces a hosted world on the
//! multicast group 224.0.2.60:4445 every 1.5 seconds as
//! `[MOTD]text[/MOTD][AD]port[/AD]`, and LanServerDetection collects those
//! announcements for the multiplayer screen.
// use std::{
    // rust: io,
    // rust: net::{Ipv4Addr, SocketAddr, SocketAddrV4, UdpSocket},
    // rust: sync::{
    // rust: Arc, Mutex,
    // rust: atomic::{AtomicBool, Ordering},
    // rust: },
    // rust: thread::JoinHandle,
    // rust: time::Duration,
}

pub const GROUP: Ipv4Addr = Ipv4Addr::new(224, 0, 2, 60);
pub const PORT: u16 = 4445;
/// LanServerPinger sleeps 1500 ms between announcements.
pub const INTERVAL: Duration = Duration::from_millis(1500);

/// LanServerPinger.createPingString.
pub fn ping_string(motd: []const u8, port: u16) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: ping_string_text(motd, &port.to_string())
}
/// LanServerPinger.createPingString with the address as text.
pub fn ping_string_text(motd: []const u8, address: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: format!("[MOTD]{motd}[/MOTD][AD]{address}[/AD]")
}
/// String.indexOf(needle, from) on a Rust string (byte offsets).
pub fn index_of(s: []const u8, needle: []const u8, from: usize) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: s.get(from..)?.find(needle).map(|i| i + from)
}
/// LanServerPinger.parseMotd; "missing no" when there is none.
pub fn parse_motd(s: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(start) = s.find("[MOTD]") else {
    // rust: return "missing no".to_owned();
}
    // rust: match index_of(s, "[/MOTD]", start + "[MOTD]".len()) {
    // rust: Some(end) => s[start + "[MOTD]".len()..end].to_owned(),
    // rust: None => "missing no".to_owned(),
}
}
/// LanServerPinger.parseAddress: the text between [AD] and [/AD] after the
/// only [/MOTD], as announced (vanilla does not check it is a port).
pub fn parse_address(s: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let end_motd = s.find("[/MOTD]")?;
    // rust: if index_of(s, "[/MOTD]", end_motd + "[/MOTD]".len()).is_some() {
    // rust: return None;
}
    // rust: let start = index_of(s, "[AD]", end_motd + "[/MOTD]".len())?;
    // rust: let end = index_of(s, "[/AD]", start + "[AD]".len())?;
    // rust: Some(s[start + "[AD]".len()..end].to_owned())
}
/// LanServerDetection.LanServerList.addServer: an announcement from `ip`.
/// A new address joins the list; a known one keeps its first MOTD. True
/// when the list changed.
pub fn add_server(games: *mut std.ArrayList(LanGame), ping: []const u8, ip: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let motd = parse_motd(ping);
    // rust: let Some(address) = parse_address(ping) else {
    // rust: return false;
}
    // rust: let address = format!("{ip}:{address}");
    // rust: if games.iter().any(|g| g.address == address) {
    // rust: return false;
}
    // rust: games.push(LanGame { motd, address });
    // rust: true
}

/// Announces one hosted world until dropped.
pub const Pinger = struct {
    stop: *AtomicBool,
    thread: ?JoinHandle<()>,
};
    // rust: impl Pinger {
pub fn start(motd: []const u8, port: u16) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let socket = UdpSocket::bind(("0.0.0.0", 0))?;
    // rust: let stop = Arc::new(AtomicBool::new(false));
    // rust: let flag = stop.clone();
    // rust: let message = ping_string(&motd, port);
    // rust: let thread = std::thread::Builder::new()
    // rust: .name("horizon-lan-ping".into())
    // rust: .spawn(move || {
    // rust: let target = SocketAddr::V4(SocketAddrV4::new(GROUP, PORT));
    // rust: while !flag.load(Ordering::Relaxed) {
    // rust: let _ = socket.send_to(message.as_bytes(), target);
    // rust: let mut slept = Duration::ZERO;
    // rust: while slept < INTERVAL && !flag.load(Ordering::Relaxed) {
    // rust: std::thread::sleep(Duration::from_millis(50));
    // rust: slept += Duration::from_millis(50);
}
}
    // rust: })?;
    // rust: Ok(Self {
    // rust: stop,
    // rust: thread: Some(thread),
    // rust: })
}
}
    // rust: impl Drop for Pinger {
pub fn drop(self: *Self) void {
}
    // rust: self.stop.store(true, Ordering::Relaxed);
    // rust: if let Some(t) = self.thread.take() {
    // rust: let _ = t.join();
}
}
}

/// A world announced on the local network.
pub const LanGame = struct {
    motd: []const u8,
    address: []const u8,
};
    // rust: type Games = Arc<Mutex<Vec<LanGame>>>;

/// Listens for announcements until the last clone is dropped.
pub const Scanner = struct {
    inner: *ScanInner,
};
pub const ScanInner = struct {
    games: Games,
    stop: *AtomicBool,
    /// How many games `take_found` has handed out.
    taken: Mutex<usize>,
};
    // rust: impl Drop for ScanInner {
pub fn drop(self: *Self) void {
}
    // rust: self.stop.store(true, Ordering::Relaxed);
}
}
    // rust: impl Scanner {
    /// Bind the discovery port; without it the list simply stays empty.
pub fn start() S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let games: Games = Arc::default();
    // rust: let stop = Arc::new(AtomicBool::new(false));
        // Constructing multiplayer screens in unit tests must not open the LAN.
    // rust: if !cfg!(test)
    // rust: && !super::test_loopback()
    // rust: && let Ok(socket) = bind_listener()
    // rust: {
    // rust: let (games, stop) = (games.clone(), stop.clone());
    // rust: let _ = std::thread::Builder::new()
    // rust: .name("horizon-lan-scan".into())
    // rust: .spawn(move || listen(socket, games, stop));
}
    // rust: Self {
    // rust: inner: Arc::new(ScanInner {
    // rust: games,
    // rust: stop,
    // rust: taken: Mutex::new(0),
    // rust: }),
}
}
    // rust: pub(crate) fn for_tests(games: Vec<LanGame>) -> Self {
    // rust: Self {
    // rust: inner: Arc::new(ScanInner {
    // rust: games: Arc::new(Mutex::new(games)),
    // rust: stop: Arc::new(AtomicBool::new(false)),
    // rust: taken: Mutex::new(0),
    // rust: }),
}
}
    /// The worlds announced since the scan started, in order (vanilla's
    /// list keeps them while the multiplayer screen is open).
pub fn games(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.inner.games.lock().unwrap().clone()
}
    /// `LanServerList.takeDirty` with `updateNetworkServers`' new count: the
    /// games found since the last call, with their place in [`games`](Self::games).
pub fn take_found(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let games = self.inner.games.lock().unwrap();
    // rust: let mut taken = self.inner.taken.lock().unwrap();
    // rust: let found = games.iter().cloned().enumerate().skip(*taken).collect();
    // rust: *taken = games.len();
    // rust: found
}
}
pub fn bind_listener() i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let socket = UdpSocket::bind(("0.0.0.0", PORT))?;
    // rust: socket.join_multicast_v4(&GROUP, &Ipv4Addr::UNSPECIFIED)?;
    // rust: socket.set_read_timeout(Some(Duration::from_millis(250)))?;
    // rust: Ok(socket)
}
pub fn listen(socket: UdpSocket, games: Games, stop: *AtomicBool) void {
}
    // rust: let mut buf = [0u8; 1024];
    // rust: while !stop.load(Ordering::Relaxed) {
    // rust: let Ok((n, from)) = socket.recv_from(&mut buf) else {
    // rust: continue;
}
    // rust: let text = String::from_utf8_lossy(&buf[..n]);
    // rust: add_server(&mut games.lock().unwrap(), &text, &from.ip().to_string());
}
}

    // rust: mod tests {
//     use super::*;

    /// `takeDirty`: each world found is handed out once, in order.
pub fn found_worlds_are_taken_once() void {
}
    // rust: let scanner = Scanner {
    // rust: inner: Arc::new(ScanInner {
    // rust: games: Arc::default(),
    // rust: stop: Arc::default(),
    // rust: taken: Mutex::new(0),
    // rust: }),
}
    // rust: let found = |s: &Scanner| -> Vec<usize> { s.take_found().iter().map(|f| f.0).collect() };
    // rust: assert!(found(&scanner).is_empty());
    // rust: add_server(
    // rust: &mut scanner.inner.games.lock().unwrap(),
    // rust: &ping_string("A", 1),
    // rust: "10.0.0.2",
    // rust: );
    // rust: add_server(
    // rust: &mut scanner.inner.games.lock().unwrap(),
    // rust: &ping_string("B", 2),
    // rust: "10.0.0.3",
    // rust: );
    // rust: assert_eq!(found(&scanner), [0, 1]);
    // rust: assert!(found(&scanner).is_empty());
    // rust: add_server(
    // rust: &mut scanner.inner.games.lock().unwrap(),
    // rust: &ping_string("C", 3),
    // rust: "10.0.0.4",
    // rust: );
    // rust: assert_eq!(scanner.take_found()[0].1.motd, "C");
}

pub fn ping_string_round_trips() void {
}
    // rust: let s = ping_string("Steve - World", 25565);
    // rust: assert_eq!(s, "[MOTD]Steve - World[/MOTD][AD]25565[/AD]");
    // rust: assert_eq!(parse_motd(&s), "Steve - World");
    // rust: assert_eq!(parse_address(&s).as_deref(), Some("25565"));
    // rust: assert_eq!(parse_address("[AD]1[/AD]"), None);
    // rust: assert_eq!(parse_address("[/MOTD][AD]x[/AD][/MOTD]"), None);
    // rust: assert_eq!(parse_motd("junk"), "missing no");
    // rust: let mut games = Vec::new();
    // rust: assert!(add_server(&mut games, &s, "10.0.0.2"));
    // rust: assert!(!add_server(
    // rust: &mut games,
    // rust: &ping_string("Other", 25565),
    // rust: "10.0.0.2"
    // rust: ));
    // rust: assert_eq!(games[0].motd, "Steve - World");
}
}
