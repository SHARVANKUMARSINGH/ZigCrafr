//! Transpiled from Horizon Rust crate
package horizon_server_rcon

import "core:fmt"
import "core:mem"
import "core:math"

// Vanilla's RCON (docs/server.md, section 8): `enable-rcon`, `rcon.port` and `rcon.password` in
// server.properties (`[properties]` in server.toml) turn on a remote console, which listens as vanilla 26.3's
// `net.minecraft.server.rcon.thread.RconThread` does and speaks `RconClient`'s protocol: little-endian packets
// of a length, a request id, a type, a payload and two NULs. The supervisor serves it, so it answers while the
// game restarts, and a command goes to the game as `horizon-server cmd` sends it.
//
// Where it differs from vanilla, on purpose: a packet is read from the stream (vanilla takes one `read` for
// one packet, so a command that TCP splits closes the connection), the password is compared in constant time,
// and a connection that hasn't logged in within [`LOGIN_WITHIN`] is closed, with at most [`MAX_CLIENTS`] open
// at once (vanilla has neither limit). A reply is cut in packets of 4096 characters, where vanilla cuts at
// 4096 UTF-16 units.

// use crate::{
    // rust: api::{Phase, Shared, same_token},
    // rust: engine,
    // rust: supervisor::note,
}
// use horizon_server_files::properties::{ServerProperties, SystemEntropy};
// use serde_json::Value;
// use std::{
    // rust: io::{self, Read, Write},
    // rust: net::{SocketAddr, TcpListener, TcpStream},
    // rust: path::Path,
    // rust: sync::{
    // rust: Arc,
    // rust: atomic::{AtomicUsize, Ordering},
    // rust: },
    // rust: thread,
    // rust: time::{Duration, Instant},
}

// `RconClient.SERVERDATA_AUTH`: the login, with the password as its payload.
AUTH :: 3
// `SERVERDATA_EXECCOMMAND`: a command to run.
EXEC :: 2
// `SERVERDATA_AUTH_RESPONSE`: the answer to a login.
AUTH_RESPONSE :: 2
// `SERVERDATA_RESPONSE_VALUE`: the output of a command.
RESPONSE :: 0
// The request id of a refused login.
AUTH_FAILURE :: -1
// `RconClient.buf`: the most a request takes, the length included.
MAX_REQUEST :: 1460
// The characters of a reply in one packet (`sendCmdResponse`).
CHUNK :: 4096
// How long a connection may take to log in.
LOGIN_WITHIN :: Duration::from_secs(30)
// The connections open at once.
MAX_CLIENTS :: 16

Settings :: struct {
    host: string,
    port: u16,
    password: string,
}

// What server.properties makes of RCON, as `RconThread.create` reads it.
Setup :: enum {
    // `enable-rcon=false`.
    Off,
    // On, but vanilla leaves it off with this warning.
    Refused(String),
    On(Settings),
}

setup :: proc(dir: ^Path) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let file = crate::config::read_properties(&dir.join(crate::config::PROPERTIES))?;
    // rust: let p = ServerProperties::new(file, &mut SystemEntropy::default())?;
    // rust: if !p.enable_rcon {
    // rust: return Ok(Setup::Off);
}
    // rust: let Some(port) = u16::try_from(p.rcon_port).ok().filter(|port| *port > 0) else {
    // rust: return Ok(Setup::Refused(format!(
    // rust: "Invalid rcon port {} found in server.properties, rcon disabled!",
    // rust: p.rcon_port
    // rust: )));
}
    // rust: if p.rcon_password.is_empty() {
    // rust: return Ok(Setup::Refused(
    // rust: "No rcon password set in server.properties, rcon disabled!".into(),
    // rust: ));
}
    // rust: Ok(Setup::On(Settings {
    // rust: host: if p.server_ip.is_empty() {
    // rust: "0.0.0.0".into()
    // rust: } else {
    // rust: p.server_ip
    // rust: },
    // rust: port,
    // rust: password: p.rcon_password,
    // rust: }))
}

// Starts RCON if server.properties turns it on. As in vanilla, what keeps it off is a warning in the log,
// not a server that doesn't start.
start :: proc(shared: ^Shared) -> R {
    // Ported from Horizon
    return {}
}
    // The file the game reads, as server.toml makes it.
    // rust: crate::config::Config::load(&shared.dir)?
    // rust: .write_properties(&shared.dir)
    // rust: .map_err(|e| format!("server.properties: {e}"))?;
    // rust: let settings = match setup(&shared.dir)? {
    // rust: Setup::Off => return Ok(None),
    // rust: Setup::Refused(why) => {
    // rust: note(&shared, "WARN", &why);
    // rust: return Ok(None);
}
    // rust: Setup::On(settings) => settings,
}
    // rust: let (host, port) = (settings.host.as_str(), settings.port);
    // rust: let listener = match TcpListener::bind((host, port)) {
    // rust: Ok(listener) => listener,
    // rust: Err(e) => {
    // rust: note(
    // rust: &shared,
    // rust: "WARN",
    // rust: &format!("Unable to initialise RCON on {host}:{port}: {e}"),
    // rust: );
    // rust: return Ok(None);
}
}
    // rust: let address = listener.local_addr().map_err(|e| e.to_string())?;
    // rust: let (game, log) = (shared.clone(), shared.clone());
    // rust: serve(
    // rust: listener,
    // rust: settings.password,
    // rust: Limits {
    // rust: clients: MAX_CLIENTS,
    // rust: login: LOGIN_WITHIN,
    // rust: },
    // rust: move |line| run_on_game(&game, line),
    // rust: move |message| note(&log, "WARN", message),
    // rust: )
    // rust: .map_err(|e| format!("RCON: {e}"))?;
    // rust: note(&shared, "INFO", &format!("RCON running on {host}:{port}"));
    // rust: Ok(Some(address))
}

// The control request that runs `line` as an RCON command: the console's, with the `Rcon` source
// (`RconConsoleSource`), so the operators hear of it when `broadcast-rcon-to-ops` is on.
control_request :: proc(line: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: format!("rcon {}", line.trim_start_matches('/'))
}

// What the game's console printed for `line`, or why it couldn't run it. The lines are joined as they are in
// vanilla (`RconConsoleSource` appends each message to one buffer).
run_on_game :: proc(shared: ^Shared, line: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if line.contains(['\n', '\r']) {
    // rust: return Err("a command is one line".into());
}
    // rust: if line.trim().is_empty() {
    // rust: return Ok(String::new());
}
    // rust: if shared.state.lock().unwrap().phase != Phase::Running {
    // rust: return Err("the game isn't running right now".into());
}
    // rust: let reply = engine::Control::connect(&shared.dir)
    // rust: .and_then(|mut game| game.ask(&control_request(line)))
    // rust: .map_err(|e| format!("the game didn't answer: {e}"))?;
    // rust: if let Some(error) = reply["error"].as_str() {
    // rust: return Err(error.to_owned());
}
    // rust: Ok(reply["output"]
    // rust: .as_array()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .filter_map(Value::as_str)
    // rust: .collect())
}

Limits :: struct {
    // The connections open at once; one more is closed at once.
    clients: uint,
    // How long a connection may take to log in.
    login: Duration,
}

// Frees a connection's place when its thread ends.
Place :: struct {

    // rust: impl Drop for Place {
drop :: proc(self: ^Self) {
}
    // rust: self.0.fetch_sub(1, Ordering::SeqCst);
}
}

// Serves `listener` until the process ends, a thread per connection. `run` runs a command and `warn` logs.
    // rust: fn serve(
    // rust: listener: TcpListener,
    // rust: password: String,
    // rust: limits: Limits,
    // rust: run: impl Fn(&str) -> Result<String, String> + Send + Sync + 'static,
    // rust: warn: impl Fn(&str) + Send + Sync + 'static,
    // rust: ) -> io::Result<()> {
    // rust: let (password, run, warn) = (Arc::new(password), Arc::new(run), Arc::new(warn));
    // rust: let open = Arc::new(AtomicUsize::new(0));
    // rust: thread::Builder::new().name("rcon".into()).spawn(move || {
    // rust: for stream in listener.incoming().flatten() {
    // rust: if open.fetch_add(1, Ordering::SeqCst) >= limits.clients {
    // rust: open.fetch_sub(1, Ordering::SeqCst);
    // rust: continue;
}
    // rust: let place = Place(open.clone());
    // rust: let (password, run, warn) = (password.clone(), run.clone(), warn.clone());
    // rust: let login = limits.login;
    // rust: let _ = thread::Builder::new()
    // rust: .name("rcon-client".into())
    // rust: .spawn(move || {
                    // The place is free again before the client sees the connection close.
    // rust: let mut stream = stream;
    // rust: let _place = place;
    // rust: let from = stream
    // rust: .peer_addr()
    // rust: .map_or_else(|_| "?".into(), |a| a.ip().to_string());
                    // The client going away, or sending what isn't RCON, ends its connection.
    // rust: let _ = client(&mut stream, &password, login, &*run, &|why| {
    // rust: warn(&format!("RCON {why} from {from}"));
    // rust: });
    // rust: });
}
    // rust: })?;
    // rust: Ok(())
}

// One connection: login and commands until the client leaves, or sends what vanilla would close on.
    // rust: fn client(
    // rust: stream: &mut TcpStream,
    // rust: password: &str,
    // rust: login: Duration,
    // rust: run: &dyn Fn(&str) -> Result<String, String>,
    // rust: warn: &dyn Fn(&str),
    // rust: ) -> io::Result<()> {
    // rust: stream.set_nodelay(true)?;
    // rust: let deadline = Instant::now() + login;
    // rust: let mut authed = false;
    // rust: loop {
    // rust: let Some(request) = read_request(stream, (!authed).then_some(deadline))? else {
    // rust: return Ok(());
}
    // rust: match request.kind {
    // rust: AUTH => {
                // An empty password never matches, as in vanilla.
    // rust: authed = !request.text.is_empty() && same_token(&request.text, password);
    // rust: if authed {
    // rust: send(stream, request.id, AUTH_RESPONSE, "")?;
    // rust: } else {
    // rust: warn("login refused");
    // rust: send(stream, AUTH_FAILURE, AUTH_RESPONSE, "")?;
}
}
    // rust: EXEC if authed => {
    // rust: let output = run(&request.text)
    // rust: .unwrap_or_else(|why| format!("Error executing: {} ({why})", request.text));
    // rust: send_output(stream, request.id, &output)?;
}
    // rust: EXEC => send(stream, AUTH_FAILURE, AUTH_RESPONSE, "")?,
    // rust: other => send_output(stream, request.id, &format!("Unknown request {other:x}"))?,
}
}
}

Request :: struct {
    id: i32,
    kind: i32,
    // The payload up to its first NUL.
    text: string,
}

// Reads exactly `buf.len()` bytes, within `deadline` if there is one. `false` when the client had closed
// before the first.
fill :: proc(stream: ^TcpStream, buf: []u8, deadline: Maybe(Instant)) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let mut have = 0;
    // rust: while have < buf.len() {
    // rust: let left = deadline
    // rust: .map(|d| {
    // rust: d.checked_duration_since(Instant::now())
    // rust: .filter(|left| !left.is_zero())
    // rust: .ok_or(io::ErrorKind::TimedOut)
    // rust: })
    // rust: .transpose()?;
    // rust: stream.set_read_timeout(left)?;
    // rust: match stream.read(&mut buf[have..]) {
    // rust: Ok(0) if have == 0 => return Ok(false),
    // rust: Ok(0) => return Err(io::ErrorKind::UnexpectedEof.into()),
    // rust: Ok(n) => have += n,
    // rust: Err(e) if e.kind() == io::ErrorKind::Interrupted => {}
    // rust: Err(e) => return Err(e),
}
}
    // rust: Ok(true)
}

// The next request, or `None` when the client has closed. A length vanilla closes on (it takes a request of
// 10 to 1460 bytes, the length's four included) is an error.
read_request :: proc(stream: ^TcpStream, deadline: Maybe(Instant)) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let mut length = [0; 4];
    // rust: if !fill(stream, &mut length, deadline)? {
    // rust: return Ok(None);
}
    // rust: let length = i32::from_le_bytes(length);
    // rust: let length = usize::try_from(length)
    // rust: .ok()
    // rust: .filter(|length| (10..=MAX_REQUEST - 4).contains(length))
    // rust: .ok_or_else(|| io::Error::new(io::ErrorKind::InvalidData, "not an RCON request"))?;
    // rust: let mut body = vec![0; length];
    // rust: if !fill(stream, &mut body, deadline)? {
    // rust: return Err(io::ErrorKind::UnexpectedEof.into());
}
    // rust: let int = |at: usize| i32::from_le_bytes([body[at], body[at + 1], body[at + 2], body[at + 3]]);
    // `PktUtils.stringFromByteArray`: the payload ends at the first NUL.
    // rust: let payload = &body[8..];
    // rust: let end = payload
    // rust: .iter()
    // rust: .position(|b| *b == 0)
    // rust: .unwrap_or(payload.len());
    // rust: Ok(Some(Request {
    // rust: id: int(0),
    // rust: kind: int(4),
    // rust: text: String::from_utf8_lossy(&payload[..end]).into_owned(),
    // rust: }))
}

// One packet, as `RconClient.send` writes it.
encode :: proc(id: i32, kind: i32, text: string) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut packet = Vec::with_capacity(text.len() + 14);
    // rust: packet.extend_from_slice(&(text.len() as i32 + 10).to_le_bytes());
    // rust: packet.extend_from_slice(&id.to_le_bytes());
    // rust: packet.extend_from_slice(&kind.to_le_bytes());
    // rust: packet.extend_from_slice(text.as_bytes());
    // rust: packet.extend_from_slice(&[0, 0]);
    // rust: packet
}

send :: proc(stream: ^TcpStream, id: i32, kind: i32, text: string) -> i {
    // Ported from Horizon
    return {}
}
    // rust: stream.write_all(&encode(id, kind, text))
}

// A command's output in packets of [`CHUNK`] characters: `sendCmdResponse` sends one, even when it is empty.
send_output :: proc(stream: ^TcpStream, id: i32, output: string) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let mut rest = output;
    // rust: loop {
    // rust: let end = rest
    // rust: .char_indices()
    // rust: .nth(CHUNK)
    // rust: .map_or(rest.len(), |(i, _)| i);
    // rust: send(stream, id, RESPONSE, &rest[..end])?;
    // rust: rest = &rest[end..];
    // rust: if rest.is_empty() {
    // rust: return Ok(());
}
}
}

    // rust: mod tests {
//     use super::*;

a_command_goes_to_the_game_as_an_rcon_one_without_its_slash :: proc() {
}
    // rust: assert_eq!(control_request("/say hi"), "rcon say hi");
    // rust: assert_eq!(control_request("time set day"), "rcon time set day");
}

    // A reply: its request id, type and payload.
reply :: proc(stream: ^TcpStream) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let mut length = [0; 4];
    // rust: stream.read_exact(&mut length).unwrap();
    // rust: let mut body = vec![0; i32::from_le_bytes(length) as usize];
    // rust: stream.read_exact(&mut body).unwrap();
    // rust: let int = |at: usize| i32::from_le_bytes(body[at..at + 4].try_into().unwrap());
    // rust: let text = String::from_utf8(body[8..body.len() - 2].to_vec()).unwrap();
    // rust: assert_eq!(body[body.len() - 2..], [0, 0], "two NULs end the payload");
    // rust: (int(0), int(4), text)
}

    // RCON on a port of its own, whose commands answer `echo:` and the command, or fail on `boom`.
server :: proc(limits: Limits) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let listener = TcpListener::bind("127.0.0.1:0").unwrap();
    // rust: let address = listener.local_addr().unwrap();
    // rust: let warned = Arc::new(std::sync::Mutex::new(Vec::new()));
    // rust: let log = warned.clone();
    // rust: serve(
    // rust: listener,
    // rust: "hunter2".into(),
    // rust: limits,
    // rust: |line| match line {
    // rust: "boom" => Err("it blew up".into()),
    // rust: "long" => Ok("é".repeat(CHUNK + 5)),
    // rust: "silent" => Ok(String::new()),
    // rust: line => Ok(format!("echo:{line}")),
    // rust: },
    // rust: move |message| log.lock().unwrap().push(message.to_owned()),
    // rust: )
    // rust: .unwrap();
    // rust: (address, warned)
}

limits :: proc() -> L {
    // Ported from Horizon
    return {}
}
    // rust: Limits {
    // rust: clients: MAX_CLIENTS,
    // rust: login: LOGIN_WITHIN,
}
}

connect :: proc(address: SocketAddr) -> T {
    // Ported from Horizon
    return {}
}
    // rust: let stream = TcpStream::connect(address).unwrap();
    // rust: stream
    // rust: .set_read_timeout(Some(Duration::from_secs(10)))
    // rust: .unwrap();
    // rust: stream
}

a_packet_is_vanillas :: proc() {
}
    // rust: assert_eq!(
    // rust: encode(7, AUTH_RESPONSE, ""),
    // rust: [10, 0, 0, 0, 7, 0, 0, 0, 2, 0, 0, 0, 0, 0]
    // rust: );
    // rust: assert_eq!(
    // rust: encode(-1, RESPONSE, "hi"),
    // rust: [
    // rust: 12, 0, 0, 0, 255, 255, 255, 255, 0, 0, 0, 0, b'h', b'i', 0, 0
    // rust: ]
    // rust: );
}

a_session_logs_in_and_runs_commands :: proc() {
}
    // rust: let (address, warned) = server(limits());
    // rust: let mut rcon = connect(address);
        // A command before the login, and a wrong password: refused, and the connection stays open.
    // rust: rcon.write_all(&encode(1, EXEC, "list")).unwrap();
    // rust: assert_eq!(
    // rust: reply(&mut rcon),
    // rust: (AUTH_FAILURE, AUTH_RESPONSE, String::new())
    // rust: );
    // rust: rcon.write_all(&encode(2, AUTH, "hunter3")).unwrap();
    // rust: assert_eq!(
    // rust: reply(&mut rcon),
    // rust: (AUTH_FAILURE, AUTH_RESPONSE, String::new())
    // rust: );
    // rust: rcon.write_all(&encode(3, AUTH, "")).unwrap();
    // rust: assert_eq!(
    // rust: reply(&mut rcon),
    // rust: (AUTH_FAILURE, AUTH_RESPONSE, String::new())
    // rust: );
    // rust: rcon.write_all(&encode(4, AUTH, "hunter2")).unwrap();
    // rust: assert_eq!(reply(&mut rcon), (4, AUTH_RESPONSE, String::new()));
    // rust: rcon.write_all(&encode(5, EXEC, "say hi")).unwrap();
    // rust: assert_eq!(reply(&mut rcon), (5, RESPONSE, "echo:say hi".into()));
        // A command that fails, one with no output, and a type vanilla doesn't know.
    // rust: rcon.write_all(&encode(6, EXEC, "boom")).unwrap();
    // rust: assert_eq!(
    // rust: reply(&mut rcon),
    // rust: (6, RESPONSE, "Error executing: boom (it blew up)".into())
    // rust: );
    // rust: rcon.write_all(&encode(7, EXEC, "silent")).unwrap();
    // rust: assert_eq!(reply(&mut rcon), (7, RESPONSE, String::new()));
    // rust: rcon.write_all(&encode(8, -2, "")).unwrap();
    // rust: assert_eq!(
    // rust: reply(&mut rcon),
    // rust: (8, RESPONSE, "Unknown request fffffffe".into())
    // rust: );
        // A login that fails takes the login back.
    // rust: rcon.write_all(&encode(9, AUTH, "nope")).unwrap();
    // rust: assert_eq!(reply(&mut rcon).0, AUTH_FAILURE);
    // rust: rcon.write_all(&encode(10, EXEC, "list")).unwrap();
    // rust: assert_eq!(reply(&mut rcon).0, AUTH_FAILURE);
    // rust: assert_eq!(
    // rust: warned.lock().unwrap().len(),
    // rust: 3,
    // rust: "each refused login is logged"
    // rust: );
}

a_long_output_comes_in_packets_of_4096_characters :: proc() {
}
    // rust: let (address, _) = server(limits());
    // rust: let mut rcon = connect(address);
    // rust: rcon.write_all(&encode(1, AUTH, "hunter2")).unwrap();
    // rust: reply(&mut rcon);
    // rust: rcon.write_all(&encode(2, EXEC, "long")).unwrap();
    // rust: let first = reply(&mut rcon);
    // rust: let second = reply(&mut rcon);
    // rust: assert_eq!(
    // rust: (first.0, first.1, first.2.chars().count()),
    // rust: (2, RESPONSE, CHUNK)
    // rust: );
    // rust: assert_eq!((second.0, second.2.chars().count()), (2, 5));
}

a_packet_split_by_tcp_is_one_request :: proc() {
}
    // rust: let (address, _) = server(limits());
    // rust: let mut rcon = connect(address);
    // rust: let login = encode(1, AUTH, "hunter2");
    // rust: let (head, tail) = login.split_at(6);
    // rust: rcon.write_all(head).unwrap();
    // rust: rcon.flush().unwrap();
    // rust: thread::sleep(Duration::from_millis(50));
    // rust: rcon.write_all(tail).unwrap();
    // rust: assert_eq!(reply(&mut rcon), (1, AUTH_RESPONSE, String::new()));
        // Two requests in one write are two requests.
    // rust: let mut both = encode(2, EXEC, "a");
    // rust: both.extend(encode(3, EXEC, "b"));
    // rust: rcon.write_all(&both).unwrap();
    // rust: assert_eq!(reply(&mut rcon), (2, RESPONSE, "echo:a".into()));
    // rust: assert_eq!(reply(&mut rcon), (3, RESPONSE, "echo:b".into()));
}

what_vanilla_closes_on_closes :: proc() {
}
    // rust: let (address, _) = server(limits());
        // A length under 10, over what vanilla's buffer takes, or negative.
    // rust: for length in [9, MAX_REQUEST as i32 - 3, -1, i32::MAX] {
    // rust: let mut rcon = connect(address);
            // The server may close before the rest is written.
    // rust: let _ = rcon.write_all(&length.to_le_bytes());
    // rust: let _ = rcon.write_all(&[0; 16]);
    // rust: let mut byte = [0];
    // rust: assert!(
    // rust: matches!(rcon.read(&mut byte), Ok(0) | Err(_)),
    // rust: "length {length}"
    // rust: );
}
        // The largest request takes.
    // rust: let mut rcon = connect(address);
    // rust: rcon.write_all(&encode(1, AUTH, "hunter2")).unwrap();
    // rust: reply(&mut rcon);
    // rust: let command = "x".repeat(MAX_REQUEST - 14);
    // rust: rcon.write_all(&encode(2, EXEC, &command)).unwrap();
    // rust: assert_eq!(reply(&mut rcon).2, format!("echo:{command}"));
}

a_connection_that_does_not_log_in_is_closed :: proc() {
}
    // rust: let (address, _) = server(Limits {
    // rust: clients: 1,
    // rust: login: Duration::from_secs(1),
    // rust: });
    // rust: let mut idle = connect(address);
        // The only place is taken: the next connection is closed at once.
    // rust: let mut second = connect(address);
    // rust: let mut byte = [0];
    // rust: assert!(matches!(second.read(&mut byte), Ok(0) | Err(_)));
    // rust: assert!(matches!(idle.read(&mut byte), Ok(0) | Err(_)));
        // Its place is free again.
    // rust: let mut again = connect(address);
    // rust: again.write_all(&encode(1, AUTH, "hunter2")).unwrap();
    // rust: assert_eq!(reply(&mut again).0, 1);
}

scratch :: proc(name: string) -> s {
    // Ported from Horizon
    return {}
}
    // rust: let dir =
    // rust: std::env::temp_dir().join(format!("horizon-server-rcon-{name}-{}", std::process::id()));
    // rust: let _ = std::fs::remove_dir_all(&dir);
    // rust: std::fs::create_dir_all(dir.join(".horizon")).unwrap();
    // rust: dir
}

properties :: proc(dir: ^Path, text: string) {
}
    // rust: std::fs::write(dir.join(crate::config::PROPERTIES), text).unwrap();
}

server_properties_turn_it_on_as_vanilla_reads_them :: proc() {
}
    // rust: let dir = scratch("setup");
    // rust: properties(&dir, "motd=hi\n");
    // rust: assert!(matches!(setup(&dir), Ok(Setup::Off)));
    // rust: properties(&dir, "enable-rcon=true\nrcon.password=pw\n");
    // rust: let Ok(Setup::On(on)) = setup(&dir) else {
    // rust: panic!("on")
}
    // rust: assert_eq!(
    // rust: (on.host.as_str(), on.port, on.password.as_str()),
    // rust: ("0.0.0.0", 25575, "pw")
    // rust: );
    // rust: properties(
    // rust: &dir,
    // rust: "enable-rcon=true\nrcon.password=pw\nrcon.port=25600\nserver-ip=127.0.0.1\n",
    // rust: );
    // rust: let Ok(Setup::On(on)) = setup(&dir) else {
    // rust: panic!("on")
}
    // rust: assert_eq!((on.host.as_str(), on.port), ("127.0.0.1", 25600));
    // rust: for (text, warning) in [
    // rust: (
    // rust: "enable-rcon=true\nrcon.password=pw\nrcon.port=0\n",
    // rust: "Invalid rcon port 0 found in server.properties, rcon disabled!",
    // rust: ),
    // rust: (
    // rust: "enable-rcon=true\nrcon.password=pw\nrcon.port=65536\n",
    // rust: "Invalid rcon port 65536 found in server.properties, rcon disabled!",
    // rust: ),
    // rust: (
    // rust: "enable-rcon=true\n",
    // rust: "No rcon password set in server.properties, rcon disabled!",
    // rust: ),
    // rust: ] {
    // rust: properties(&dir, text);
    // rust: let Ok(Setup::Refused(why)) = setup(&dir) else {
    // rust: panic!("refused: {text}")
}
    // rust: assert_eq!(why, warning);
}
    // rust: std::fs::remove_dir_all(&dir).unwrap();
}

    // The game's control endpoint, as far as `rcon` goes: it answers `say hi` and fails on `fail`.
game :: proc(dir: ^Path) {
}
    // rust: let listener = TcpListener::bind("127.0.0.1:0").unwrap();
    // rust: let port = listener.local_addr().unwrap().port();
    // rust: std::fs::write(
    // rust: engine::control_path(dir),
    // rust: format!("{{\"port\":{port},\"token\":\"t\"}}"),
    // rust: )
    // rust: .unwrap();
    // rust: thread::spawn(move || {
    // rust: for stream in listener.incoming().flatten() {
    // rust: let mut lines = io::BufRead::lines(io::BufReader::new(stream.try_clone().unwrap()));
    // rust: let mut stream = stream;
    // rust: while let Some(Ok(line)) = lines.next() {
    // rust: let answer = match line.as_str() {
    // rust: "auth t" => "{\"ok\":true}",
    // rust: "rcon say hi" => "{\"output\":[\"[Server] \",\"hi\"]}",
    // rust: _ => "{\"error\":\"unknown request\"}",
}
    // rust: let _ = writeln!(stream, "{answer}");
}
}
    // rust: });
}

a_command_goes_to_the_game_as_an_rcon_request_that_says_what_the_console_says :: proc() {
}
    // rust: let dir = scratch("game");
    // rust: game(&dir);
    // rust: let shared = Shared::with_install(&dir, None);
    // rust: shared.set_phase(Phase::Restarting);
    // rust: assert_eq!(
    // rust: run_on_game(&shared, "say hi"),
    // rust: Err("the game isn't running right now".into())
    // rust: );
    // rust: shared.set_phase(Phase::Running);
        // The output of every message, one after the other, and a slash that vanilla's RCON takes too.
    // rust: assert_eq!(run_on_game(&shared, "say hi").as_deref(), Ok("[Server] hi"));
    // rust: assert_eq!(
    // rust: run_on_game(&shared, "/say hi").as_deref(),
    // rust: Ok("[Server] hi")
    // rust: );
    // rust: assert_eq!(run_on_game(&shared, "   ").as_deref(), Ok(""));
    // rust: assert_eq!(
    // rust: run_on_game(&shared, "say hi\nstop"),
    // rust: Err("a command is one line".into())
    // rust: );
    // rust: assert_eq!(
    // rust: run_on_game(&shared, "nonsense"),
    // rust: Err("unknown request".into())
    // rust: );
    // rust: std::fs::remove_dir_all(&dir).unwrap();
}

server_toml_starts_it :: proc() {
}
    // rust: let dir = scratch("start");
    // rust: game(&dir);
    // rust: let port = TcpListener::bind("127.0.0.1:0")
    // rust: .unwrap()
    // rust: .local_addr()
    // rust: .unwrap()
    // rust: .port();
        // The dotted keys are quoted in TOML.
        // `[server] bind` is `server-ip`, the address RCON listens on too.
    // rust: let toml = crate::config::TEMPLATE
    // rust: .replacen("bind = \"\"", "bind = \"127.0.0.1\"", 1)
    // rust: .replace(
    // rust: "[properties]
    // rust: ",
    // rust: &format!(
    // rust: "[properties]
    // rust: enable-rcon = true
    // rust: \"rcon.port\" = {port}
    // rust: \"rcon.password\" = \"hunter2\"
    // rust: "
    // rust: ),
    // rust: );
    // rust: std::fs::write(dir.join(crate::config::FILE), toml).unwrap();
    // rust: let shared = Shared::with_install(&dir, None);
    // rust: shared.set_phase(Phase::Running);
    // rust: let address = start(shared.clone()).unwrap().expect("RCON is on");
    // rust: assert_eq!(address, SocketAddr::from(([127, 0, 0, 1], port)));
    // rust: let mut rcon = connect(address);
    // rust: rcon.write_all(&encode(1, AUTH, "hunter2")).unwrap();
    // rust: assert_eq!(reply(&mut rcon), (1, AUTH_RESPONSE, String::new()));
    // rust: rcon.write_all(&encode(2, EXEC, "say hi")).unwrap();
    // rust: assert_eq!(reply(&mut rcon), (2, RESPONSE, "[Server] hi".into()));
    // rust: let (_, lines) = shared.log.lock().unwrap().since(0);
    // rust: let said = format!("RCON running on 127.0.0.1:{port}");
    // rust: assert!(lines.iter().any(|l| l.contains(&said)), "{lines:?}");
    // rust: std::fs::remove_dir_all(&dir).unwrap();
}
}
