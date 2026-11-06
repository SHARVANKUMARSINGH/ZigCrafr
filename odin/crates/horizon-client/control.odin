//! Transpiled from Horizon Rust crate
package horizon_client_control

import "core:fmt"
import "core:mem"
import "core:math"

// Local control socket: lets a script or `horizon-ctl` drive a running game.
//
// Each connection sends commands as text lines and receives one JSON line per
// command. Commands are executed on the game thread between frames; replies
// that depend on a later frame (screenshots, benchmarks) arrive when ready.
//
// Two transports carry the same lines. On Linux and macOS the endpoint is a
// Unix domain socket. Where those don't exist (Windows), or when the endpoint
// path ends in `.json`, the game listens on a random localhost TCP port and
// writes `{"transport":"tcp","port":N,"token":"..."}` to the path, readable
// only by its user; a client's first line must then be `auth TOKEN`.
// use crate::block_entity_render::StaticCacheFrameStats;
// use std::{
    // rust: io::{self, BufRead, BufReader, Read, Write},
    // rust: net::{Ipv4Addr, TcpListener, TcpStream},
    // rust: path::{Path, PathBuf},
    // rust: sync::{
    // rust: Arc,
    // rust: atomic::{AtomicBool, AtomicUsize, Ordering},
    // rust: mpsc,
    // rust: },
    // rust: thread,
}

    // rust: pub use std::os::unix::net::{UnixListener, UnixStream};

// A connection to the control endpoint, over either transport.
Stream :: enum {
    Unix(UnixStream),
    Tcp(TcpStream),
}

    // rust: impl Stream {
try_clone :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: Ok(match self {
    // rust: Self::Unix(s) => Self::Unix(s.try_clone()?),
    // rust: Self::Tcp(s) => Self::Tcp(s.try_clone()?),
    // rust: })
}
    // A read timeout (None waits forever).
set_read_timeout :: proc(self: ^Self, timeout: Maybe(std::time::Duration)) -> i {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::Unix(s) => s.set_read_timeout(timeout),
    // rust: Self::Tcp(s) => s.set_read_timeout(timeout),
}
}
}
    // rust: impl Read for Stream {
read :: proc(self: ^Self, buf: []u8) -> i {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::Unix(s) => s.read(buf),
    // rust: Self::Tcp(s) => s.read(buf),
}
}
}
    // rust: impl Write for Stream {
write :: proc(self: ^Self, buf: []u8) -> i {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::Unix(s) => s.write(buf),
    // rust: Self::Tcp(s) => s.write(buf),
}
}
flush :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::Unix(s) => s.flush(),
    // rust: Self::Tcp(s) => s.flush(),
}
}
}

// Whether the endpoint at `path` is a TCP port described by a JSON file.
uses_tcp :: proc(path: ^Path) -> b {
    // Ported from Horizon
    return {}
}
    // rust: !cfg!(unix) || path.extension().is_some_and(|e| e == "json")
}

// The TCP endpoint file: (port, token).
read_endpoint :: proc(path: ^Path) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let text = std::fs::read_to_string(path)?;
    // rust: let bad = || io::Error::new(io::ErrorKind::InvalidData, "not a control endpoint file");
    // rust: let v: serde_json::Value = serde_json::from_str(&text).map_err(|_| bad())?;
    // rust: let port = v["port"]
    // rust: .as_u64()
    // rust: .and_then(|p| u16::try_from(p).ok())
    // rust: .ok_or_else(bad)?;
    // rust: let token = v["token"].as_str().ok_or_else(bad)?.to_owned();
    // rust: Ok((port, token))
}

// Connect to a running game's control endpoint (and authenticate over TCP).
connect :: proc(path: ^Path) -> i {
    // Ported from Horizon
    return {}
}
    // rust: if !uses_tcp(path) {
    // rust: return UnixStream::connect(path).map(Stream::Unix);
}
    // rust: let (port, token) = read_endpoint(path)?;
    // rust: let mut stream = TcpStream::connect((Ipv4Addr::LOCALHOST, port))?;
    // rust: stream.set_nodelay(true)?;
    // rust: writeln!(stream, "auth {token}")?;
    // rust: let mut reply = String::new();
    // rust: BufReader::new(stream.try_clone()?).read_line(&mut reply)?;
    // rust: if !reply.contains("\"ok\"") {
    // rust: return Err(io::Error::new(
    // rust: io::ErrorKind::PermissionDenied,
    // rust: format!("the game refused the token: {}", reply.trim()),
    // rust: ));
}
    // rust: Ok(Stream::Tcp(stream))
}

// 128 random bits from the OS's random generator, as 32 hex digits: the TCP endpoint's token, which
// gates full control of the running game.
random_token :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut bytes = [0u8; 16];
    // rust: getrandom::fill(&mut bytes).expect("OS random generator");
    // rust: bytes.iter().map(|b| format!("{b:02x}")).collect()
}

// Writes the endpoint file so that only this user can read it, even over an older file
// (`horizon_server_files::private_file`).
// use horizon_server_files::private_file::write_private;

// Constant-time comparison of the presented token.
same_token :: proc(a: string, b: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: a.len() == b.len() && a.bytes().zip(b.bytes()).fold(0u8, |d, (x, y)| d | (x ^ y)) == 0
}

// One command line from a client, with the channel for its JSON reply.
Request :: struct {
    line: string,
    reply: mpsc::Sender<string>,
}

Server :: struct {
    path: PathBuf,
    requests: mpsc::Receiver<Request>,
    sender: mpsc::Sender<Request>,
    // Clients connected now (an MCP server keeps one open; horizon-ctl one per command).
    clients: ^AtomicUsize,
    // Set when the server is dropped: the listener stops accepting and exits.
    closed: ^AtomicBool,
    // The TCP port, to wake the listener when closing.
    port: Maybe(u16),
}

// `$HORIZON_CONTROL`, else `horizon-control.sock` in the user's runtime
// directory (`horizon-control.json` in the temporary directory on Windows).
default_path :: proc() -> P {
    // Ported from Horizon
    return {}
}
    // rust: if let Some(path) = std::env::var_os("HORIZON_CONTROL") {
    // rust: return path.into();
}
    // rust: if !cfg!(unix) {
    // rust: return std::env::temp_dir().join("horizon-control.json");
}
    // rust: let dir = std::env::var_os("XDG_RUNTIME_DIR").map_or_else(std::env::temp_dir, PathBuf::from);
    // rust: dir.join("horizon-control.sock")
}

// Whether `path` can be an endpoint at all, without touching it: a Unix socket's path has a
// length limit (`sockaddr_un`); a TCP endpoint is an ordinary file and has none.
check_path :: proc(path: ^Path) -> i {
    // Ported from Horizon
    return {}
}
    // rust: if uses_tcp(path) {
    // rust: return Ok(());
}
    // rust: std::os::unix::net::SocketAddr::from_pathname(path).map_err(|_| {
    // rust: io::Error::new(
    // rust: io::ErrorKind::InvalidInput,
    // rust: format!(
    // rust: "{} bytes is too long for a Unix socket path; use a shorter one",
    // rust: path.as_os_str().len()
    // rust: ),
    // rust: )
    // rust: })?;
    // rust: Ok(())
}

    // rust: impl Server {
start :: proc(path: ^Path) -> i {
    // Ported from Horizon
    return {}
}
    // rust: check_path(path)?;
        // An endpoint left by a crashed game refuses connections; replace it.
    // rust: if path.exists() && connect(path).is_err() {
    // rust: std::fs::remove_file(path)?;
}
    // rust: let (sender, requests) = mpsc::channel();
    // rust: let local = sender.clone();
    // rust: let clients = Arc::new(AtomicUsize::new(0));
    // rust: let counted = clients.clone();
    // rust: let closed = Arc::new(AtomicBool::new(false));
    // rust: let mut tcp_port = None;
    // rust: if uses_tcp(path) {
    // rust: let listener = TcpListener::bind((Ipv4Addr::LOCALHOST, 0))?;
    // rust: let token = random_token();
    // rust: let port = listener.local_addr()?.port();
    // rust: tcp_port = Some(port);
    // rust: write_private(
    // rust: path,
    // rust: serde_json::json!({ "transport": "tcp", "port": port, "token": token }).to_string(),
    // rust: )?;
    // rust: spawn_listener(
    // rust: move || listener.accept().map(|(s, _)| s),
    // rust: sender,
    // rust: counted,
    // rust: closed.clone(),
    // rust: move |stream: TcpStream| {
    // rust: let _ = stream.set_nodelay(true);
    // rust: let mut stream = Stream::Tcp(stream);
    // rust: authenticate(&mut stream, &token).then_some(stream)
    // rust: },
    // rust: )?;
    // rust: } else {
    // rust: {
    // rust: let listener = UnixListener::bind(path)?;
    // rust: spawn_listener(
    // rust: move || listener.accept().map(|(s, _)| s),
    // rust: sender,
    // rust: counted,
    // rust: closed.clone(),
    // rust: |s| Some(Stream::Unix(s)),
    // rust: )?;
}
}
    // rust: Ok(Self {
    // rust: path: path.to_owned(),
    // rust: requests,
    // rust: sender: local,
    // rust: clients,
    // rust: closed,
    // rust: port: tcp_port,
    // rust: })
}
    // Commands from inside the process only (`--benchmark` without `--control`).
local :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: let (sender, requests) = mpsc::channel();
    // rust: Self {
    // rust: path: PathBuf::new(),
    // rust: requests,
    // rust: sender,
    // rust: clients: Arc::default(),
    // rust: closed: Arc::default(),
    // rust: port: None,
}
}
    // How many clients are connected.
clients :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.clients.load(Ordering::Relaxed)
}
    // Sends commands as a socket client would, from another thread.
sender :: proc(self: ^Self) -> m {
    // Ported from Horizon
    return {}
}
    // rust: self.sender.clone()
}
path :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &self.path
}
try_recv :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.requests.try_recv().ok()
}
}

// Accept connections on a thread, one more thread per client.
    // rust: fn spawn_listener<S: Send + 'static>(
    // rust: mut accept_next: impl FnMut() -> io::Result<S> + Send + 'static,
    // rust: sender: mpsc::Sender<Request>,
    // rust: clients: Arc<AtomicUsize>,
    // rust: closed: Arc<AtomicBool>,
    // rust: accept: impl Fn(S) -> Option<Stream> + Send + Sync + 'static,
    // rust: ) -> io::Result<()> {
    // rust: let accept = std::sync::Arc::new(accept);
    // rust: thread::Builder::new()
    // rust: .name("horizon-control".into())
    // rust: .spawn(move || {
    // rust: loop {
    // rust: let next = accept_next();
    // rust: if closed.load(Ordering::Relaxed) {
    // rust: return;
}
    // rust: let Ok(stream) = next else {
    // rust: thread::sleep(std::time::Duration::from_millis(10));
    // rust: continue;
}
    // rust: let sender = sender.clone();
    // rust: let accept = accept.clone();
    // rust: let clients = clients.clone();
    // rust: let _ = thread::Builder::new()
    // rust: .name("horizon-control-client".into())
    // rust: .spawn(move || {
    // rust: if let Some(stream) = accept(stream) {
    // rust: clients.fetch_add(1, Ordering::Relaxed);
    // rust: serve(stream, &sender);
    // rust: clients.fetch_sub(1, Ordering::Relaxed);
}
    // rust: });
}
    // rust: })?;
    // rust: Ok(())
}

// The first line of a TCP client must be `auth TOKEN`.
authenticate :: proc(stream: ^Stream, token: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let mut line = Vec::new();
    // rust: let mut byte = [0u8; 1];
    // Read the line byte by byte so nothing after it is buffered away.
    // rust: while line.len() < 256 {
    // rust: match stream.read(&mut byte) {
    // rust: Ok(1) if byte[0] == b'\n' => break,
    // rust: Ok(1) => line.push(byte[0]),
    // rust: _ => return false,
}
}
    // rust: let line = String::from_utf8_lossy(&line);
    // rust: let ok = line
    // rust: .trim()
    // rust: .strip_prefix("auth ")
    // rust: .is_some_and(|t| same_token(t.trim(), token));
    // rust: let reply = if ok {
    // rust: r#"{"ok":true}"#
    // rust: } else {
    // rust: r#"{"error":"bad or missing token: the first line must be auth TOKEN"}"#
}
    // rust: let _ = writeln!(stream, "{reply}");
    // rust: ok
}

    // rust: impl Drop for Server {
drop :: proc(self: ^Self) {
}
    // rust: if self.path.as_os_str().is_empty() {
    // rust: return;
}
        // Wake the listener so it sees `closed` and exits (agent control turned off in-game).
    // rust: self.closed.store(true, Ordering::Relaxed);
    // rust: match self.port {
    // rust: Some(port) => drop(TcpStream::connect((Ipv4Addr::LOCALHOST, port))),
    // rust: None => drop(UnixStream::connect(&self.path)),
    // rust: None => {}
}
    // rust: let _ = std::fs::remove_file(&self.path);
}
}

// The longest request line a connection may send. The game reads and parses a request on its
// own thread between two ticks, so one without bound could stall the server (a proxy's
// `player-import` carries a whole player, a few hundred kilobytes at most).
MAX_LINE :: 16 << 20

serve :: proc(stream: Stream, sender: ^mpsc::Sender<Request>) {
}
    // rust: let Ok(mut writer) = stream.try_clone() else {
    // rust: return;
}
    // rust: let mut reader = BufReader::new(stream);
    // rust: loop {
    // rust: let mut bytes = Vec::new();
    // rust: match (&mut reader)
    // rust: .take(MAX_LINE + 1)
    // rust: .read_until(b'\n', &mut bytes)
    // rust: {
    // rust: Ok(0) | Err(_) => return,
    // rust: Ok(_) => {}
}
    // rust: if bytes.len() as u64 > MAX_LINE {
    // rust: let _ = writeln!(writer, r#"{{"error":"the request is longer than 16 MiB"}}"#);
    // rust: return;
}
    // rust: let Ok(line) = String::from_utf8(bytes) else {
    // rust: return;
}
    // rust: let line = line.trim_end_matches(['\n', '\r']).to_owned();
    // rust: if line.trim().is_empty() {
    // rust: continue;
}
    // rust: let (reply, response) = mpsc::channel();
    // rust: if sender.send(Request { line, reply }).is_err() {
    // rust: return;
}
        // The game dropping the reply sender means it exited mid-command.
    // rust: let text = response
    // rust: .recv()
    // rust: .unwrap_or_else(|_| r#"{"error":"game exited"}"#.to_owned());
    // rust: if writeln!(writer, "{text}").is_err() {
    // rust: return;
}
}
}

    // rust: mod tests {
//     use super::*;

    // The check agrees with the system at every length around its limit.
check_path_says_what_bind_does :: proc() {
}
    // rust: let dir = std::env::temp_dir().join(format!("hz-sock-{}", std::process::id()));
    // rust: std::fs::create_dir_all(&dir).unwrap();
    // rust: let (mut fits, mut too_long) = (false, false);
    // rust: for len in 1..=150 {
    // rust: let path = dir.join("x".repeat(len));
    // rust: let bound = UnixListener::bind(&path).is_ok();
    // rust: assert_eq!(check_path(&path).is_ok(), bound, "{}", path.display());
    // rust: let _ = std::fs::remove_file(&path);
    // rust: fits |= bound;
    // rust: too_long |= !bound;
}
    // rust: let _ = std::fs::remove_dir_all(&dir);
    // rust: assert!(fits && too_long, "the lengths tried must cross the limit");
}

    // A `.json` endpoint is a file and TCP: the socket limit is not its limit.
long_tcp_endpoint_opens :: proc() {
}
    // rust: let dir = std::env::temp_dir().join(format!("hz-long-{}", std::process::id()));
    // rust: std::fs::create_dir_all(&dir).unwrap();
    // rust: let path = dir.join(format!("{}.json", "x".repeat(150)));
    // rust: let server = Server::start(&path);
    // rust: assert!(server.is_ok(), "{:?}", server.err());
    // rust: drop(server);
    // rust: let _ = std::fs::remove_dir_all(&dir);
}

tcp_endpoint_round_trip :: proc() {
}
    // rust: let path =
    // rust: std::env::temp_dir().join(format!("horizon-ctl-test-{}.json", std::process::id()));
    // rust: let server = Server::start(&path).unwrap();
    // rust: let text = std::fs::read_to_string(&path).unwrap();
    // rust: assert!(text.contains("\"tcp\""));
    // rust: let mut client = connect(&path).unwrap();
    // rust: writeln!(client, "status").unwrap();
    // rust: let request = loop {
    // rust: if let Some(r) = server.try_recv() {
    // rust: break r;
}
    // rust: thread::sleep(std::time::Duration::from_millis(5));
}
    // rust: assert_eq!(request.line, "status");
    // rust: request.reply.send(r#"{"ok":true}"#.into()).unwrap();
    // rust: let mut reply = String::new();
    // rust: BufReader::new(client).read_line(&mut reply).unwrap();
    // rust: assert_eq!(reply.trim(), r#"{"ok":true}"#);
    // rust: drop(server);
    // rust: assert!(!path.exists());
}

    // A request past the limit is answered with an error and never reaches the game.
a_request_longer_than_the_limit_is_refused :: proc() {
}
    // rust: let path =
    // rust: std::env::temp_dir().join(format!("horizon-ctl-long-{}.json", std::process::id()));
    // rust: let server = Server::start(&path).unwrap();
    // rust: let client = connect(&path).unwrap();
    // rust: let mut writing = client.try_clone().unwrap();
        // The server stops reading at the limit and closes: the rest may not be taken.
    // rust: let writer = thread::spawn(move || {
    // rust: let chunk = vec![b'x'; 1 << 20];
    // rust: for _ in 0..=(MAX_LINE >> 20) {
    // rust: if writing.write_all(&chunk).is_err() {
    // rust: return;
}
}
    // rust: let _ = writing.write_all(b"\n");
    // rust: });
    // rust: let mut reply = String::new();
    // rust: BufReader::new(client).read_line(&mut reply).unwrap();
    // rust: assert!(reply.contains("longer than"), "{reply}");
    // rust: let _ = writer.join();
    // rust: assert!(
    // rust: server.try_recv().is_none(),
    // rust: "the game was handed the request"
    // rust: );
    // rust: drop(server);
}

tcp_refuses_a_wrong_token :: proc() {
}
    // rust: let path =
    // rust: std::env::temp_dir().join(format!("horizon-ctl-bad-{}.json", std::process::id()));
    // rust: let _server = Server::start(&path).unwrap();
    // rust: let (port, _) = read_endpoint(&path).unwrap();
    // rust: let mut stream = TcpStream::connect((Ipv4Addr::LOCALHOST, port)).unwrap();
    // rust: writeln!(stream, "auth nope").unwrap();
    // rust: let mut reply = String::new();
    // rust: BufReader::new(stream).read_line(&mut reply).unwrap();
    // rust: assert!(reply.contains("error"));
}

tokens_differ :: proc() {
}
    // rust: assert_ne!(random_token(), random_token());
    // rust: assert_eq!(random_token().len(), 32);
    // rust: assert!(same_token("abc", "abc") && !same_token("abc", "abd") && !same_token("a", "ab"));
}

frame_summary_reports_block_entity_cache_work :: proc() {
}
    // rust: let mut stats = FrameStats::default();
    // rust: stats.record(10.0);
    // rust: stats.record_cpu(5.0);
    // rust: stats.record_block_entities(StaticCacheFrameStats {
    // rust: snapshot_rebuilds: 2,
    // rust: snapshot_bytes_built: 128,
    // rust: static_bytes_uploaded: 96,
    // rust: static_entities_drawn: 4,
    // rust: dynamic_entities_drawn: 3,
    // rust: ..Default::default()
    // rust: });

    // rust: let summary = stats.summary();
    // rust: assert_eq!(summary["static_snapshot_rebuilds"], 2);
    // rust: assert_eq!(summary["static_snapshot_bytes_built"], 128);
    // rust: assert_eq!(summary["static_bytes_uploaded"], 96);
    // rust: assert_eq!(summary["static_entities_drawn"], 4);
    // rust: assert_eq!(summary["dynamic_entities_drawn"], 3);
    // rust: assert_eq!(summary["static_entities_drawn_avg_per_frame"], 4.0);
    // rust: assert_eq!(summary["dynamic_entities_drawn_avg_per_frame"], 3.0);
}
}

// Frame durations since the last reset, summarized like the Java recorder,
// with the CPU part of each frame and GPU times from timestamp queries.
FrameStats :: struct {
    millis: [dynamic]f32,
    cpu: [dynamic]f32,
    gpu: [dynamic]f32,
    // Milliseconds per frame phase (`PHASES`), one entry per rendered frame.
    phases: Vec<[f32,
    static_snapshot_rebuilds: u64,
    static_snapshot_bytes_built: u64,
    static_bytes_uploaded: u64,
    static_entities_drawn: u64,
    dynamic_entities_drawn: u64,
}

// The parts of a frame's CPU time: world streaming and uploads, game ticks,
// building the frame's geometry and HUD, and the renderer's own work.
PHASES :: ["update", "tick", "prepare", "render"]

percentiles :: proc(values: ^[f32]) -> s {
    // Ported from Horizon
    return {}
}
    // rust: let mut sorted = values.to_vec();
    // rust: sorted.sort_by(f32::total_cmp);
    // rust: let n = sorted.len();
    // rust: if n == 0 {
    // rust: return serde_json::Value::Null;
}
    // rust: let total: f64 = sorted.iter().map(|&m| f64::from(m)).sum();
    // rust: let percentile = |p: f64| sorted[((n as f64 * p).ceil() as usize).clamp(1, n) - 1];
    // rust: serde_json::json!({
    // rust: "avg_ms": total / n as f64,
    // rust: "p50_ms": percentile(0.5),
    // rust: "p95_ms": percentile(0.95),
    // rust: "p99_ms": percentile(0.99),
    // rust: "max_ms": sorted[n - 1],
    // rust: })
}

    // rust: impl FrameStats {
LIMIT :: 1 << 20
record :: proc(self: ^Self, millis: f32) {
}
    // rust: if self.millis.len() < Self::LIMIT {
    // rust: self.millis.push(millis);
}
}
    // The frame's own work: its duration minus waits for the GPU, the
    // display and the frame limiter.
record_cpu :: proc(self: ^Self, millis: f32) {
}
    // rust: if self.cpu.len() < Self::LIMIT {
    // rust: self.cpu.push(millis);
}
}
record_phases :: proc(self: ^Self, millis: [f32; PHASES.len() {
}
    // rust: if self.phases.len() < Self::LIMIT {
    // rust: self.phases.push(millis);
}
}
    // Average milliseconds per phase over the frames whose CPU time is at
    // least `min_cpu` (all frames for 0): where the slow frames go.
phase_average :: proc(self: ^Self, min_cpu: f32) -> s {
    // Ported from Horizon
    return {}
}
    // rust: let mut sums = [0.0f64; PHASES.len()];
    // rust: let mut n = 0;
    // rust: for (i, phases) in self.phases.iter().enumerate() {
    // rust: if self.cpu.get(i).is_some_and(|&c| c >= min_cpu) {
    // rust: for (sum, m) in sums.iter_mut().zip(phases) {
    // rust: *sum += f64::from(*m);
}
    // rust: n += 1;
}
}
    // rust: PHASES
    // rust: .iter()
    // rust: .zip(sums)
    // rust: .map(|(name, sum)| (name.to_string(), (sum / f64::from(n.max(1))).into()))
    // rust: .collect::<serde_json::Map<_, _>>()
    // rust: .into()
}
record_gpu :: proc(self: ^Self, millis: ^[f32]) {
}
    // rust: if self.gpu.len() < Self::LIMIT {
    // rust: self.gpu.extend_from_slice(millis);
}
}
    // Block-entity cache counters for the frame just rendered.
record_block_entities :: proc(self: ^Self, stats: StaticCacheFrameStats) {
}
    // rust: self.static_snapshot_rebuilds += stats.snapshot_rebuilds;
    // rust: self.static_snapshot_bytes_built += stats.snapshot_bytes_built;
    // rust: self.static_bytes_uploaded += stats.static_bytes_uploaded;
    // rust: self.static_entities_drawn += stats.static_entities_drawn;
    // rust: self.dynamic_entities_drawn += stats.dynamic_entities_drawn;
}
    // Every recorded frame time, in milliseconds, in order.
frame_millis :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &self.millis
}
    // CPU time of every recorded frame, in milliseconds.
cpu_millis :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &self.cpu
}
    // GPU time of every frame the GPU timed, in milliseconds.
gpu_millis :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &self.gpu
}
reset :: proc(self: ^Self) {
}
    // rust: self.millis.clear();
    // rust: self.cpu.clear();
    // rust: self.gpu.clear();
    // rust: self.phases.clear();
    // rust: self.static_snapshot_rebuilds = 0;
    // rust: self.static_snapshot_bytes_built = 0;
    // rust: self.static_bytes_uploaded = 0;
    // rust: self.static_entities_drawn = 0;
    // rust: self.dynamic_entities_drawn = 0;
}
summary :: proc(self: ^Self) -> s {
    // Ported from Horizon
    return {}
}
    // rust: let mut sorted = self.millis.clone();
    // rust: sorted.sort_by(f32::total_cmp);
    // rust: let n = sorted.len();
    // rust: if n == 0 {
    // rust: return serde_json::json!({ "frames": 0 });
}
    // rust: let total: f64 = sorted.iter().map(|&m| f64::from(m)).sum();
    // rust: let percentile = |p: f64| sorted[((n as f64 * p).ceil() as usize).clamp(1, n) - 1];
        // Average frame time of the slowest 1% (0.1%) of frames, as frames per second.
    // rust: let low = |per: usize| {
    // rust: let slowest = n.div_ceil(per);
    // rust: let slow: f64 = sorted[n - slowest..]
    // rust: .iter()
    // rust: .map(|&m| f64::from(m))
    // rust: .sum::<f64>()
    // rust: / slowest as f64;
    // rust: 1000.0 / slow
}
        // Where the slowest 1% of frames by CPU time go.
    // rust: let slow_phases = {
    // rust: let mut cpu = self.cpu.clone();
    // rust: cpu.sort_by(f32::total_cmp);
    // rust: let p99 = cpu
    // rust: .get(cpu.len().saturating_sub(cpu.len().div_ceil(100)))
    // rust: .copied();
    // rust: p99.map_or(serde_json::Value::Null, |p| self.phase_average(p))
}
    // rust: serde_json::json!({
    // rust: "frames": n,
    // rust: "seconds": total / 1000.0,
    // rust: "avg_fps": n as f64 * 1000.0 / total,
    // rust: "low_1pct_fps": low(100),
    // rust: "low_01pct_fps": low(1000),
    // rust: "p50_ms": percentile(0.5),
    // rust: "p95_ms": percentile(0.95),
    // rust: "p99_ms": percentile(0.99),
    // rust: "max_ms": sorted[n - 1],
    // rust: "cpu": percentiles(&self.cpu),
    // rust: "gpu": percentiles(&self.gpu),
    // rust: "phases_avg_ms": self.phase_average(0.0),
    // rust: "slow_phases_avg_ms": slow_phases,
    // rust: "static_snapshot_rebuilds": self.static_snapshot_rebuilds,
    // rust: "static_snapshot_bytes_built": self.static_snapshot_bytes_built,
    // rust: "static_bytes_uploaded": self.static_bytes_uploaded,
    // rust: "static_entities_drawn": self.static_entities_drawn,
    // rust: "dynamic_entities_drawn": self.dynamic_entities_drawn,
    // rust: "static_entities_drawn_avg_per_frame": self.static_entities_drawn as f64 / n as f64,
    // rust: "dynamic_entities_drawn_avg_per_frame": self.dynamic_entities_drawn as f64 / n as f64,
    // rust: })
}
}
