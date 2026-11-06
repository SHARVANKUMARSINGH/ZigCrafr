//! Transpiled from Horizon Rust crate
package horizon_server_http

import "core:fmt"
import "core:mem"
import "core:math"

// Just enough HTTP/1.1 for the control API on 127.0.0.1 and the web panel (docs/server.md, sections 6 and
// 8): one request per connection, bodies with a Content-Length. No async runtime and no dependency: a
// thread per connection is plenty for a CLI, a panel tab and an MCP client.

// use std::{
    // rust: io::{BufRead, BufReader, Read, Write},
    // rust: net::{SocketAddr, TcpListener, TcpStream},
    // rust: time::Duration,
}

// The largest request body the API takes (a console command, a settings change).
MAX_BODY :: 1 << 20
// The longest request line or header line taken.
MAX_LINE :: 8 << 10

Request :: struct {
    method: string,
    path: string,
    query: string,
    headers: Vec<(string,
    body: [dynamic]u8,
}

    // rust: impl Request {
header :: proc(self: ^Self, name: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.headers
    // rust: .iter()
    // rust: .find(|(k, _)| k.eq_ignore_ascii_case(name))
    // rust: .map(|(_, v)| v.as_str())
}
    // One `key=value` from the query string (no percent-decoding: the API's values are numbers and
    // tokens).
param :: proc(self: ^Self, key: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.query
    // rust: .split('&')
    // rust: .filter_map(|p| p.split_once('='))
    // rust: .find(|(k, _)| *k == key)
    // rust: .map(|(_, v)| v)
}
    // One cookie the browser sent.
cookie :: proc(self: ^Self, name: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.headers
    // rust: .iter()
    // rust: .filter(|(k, _)| k.eq_ignore_ascii_case("cookie"))
    // rust: .flat_map(|(_, v)| v.split(';'))
    // rust: .filter_map(|c| c.trim().split_once('='))
    // rust: .find(|(k, _)| *k == name)
    // rust: .map(|(_, v)| v)
}
}

Response :: struct {
    status: u16,
    content_type: ^'static str,
    headers: Vec<(^'static str,
    body: string,
    // Writes the body itself instead of `body`, after the head (a file, a stream of events); the
    // connection's end ends the body unless it sets a Content-Length.
    stream: Maybe(^dyn FnOnce(^TcpStream) + Send),
}

    // rust: impl Response {
json :: proc(status: u16, value: ^serde_json::Value) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self::text(status, "application/json", value.to_string())
}
error :: proc(status: u16, message: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self::json(status, &serde_json::json!({ "error": message }))
}
text :: proc(status: u16, content_type: ^'static str, body: impl Into<string>) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: status,
    // rust: content_type,
    // rust: headers: Vec::new(),
    // rust: body: body.into(),
    // rust: stream: None,
}
}
    // A file sent as it is read, for a download (`name` is what the browser saves it as).
file :: proc(path: std::path::PathBuf, name: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let Ok(length) = std::fs::metadata(&path).map(|m| m.len()) else {
    // rust: return Self::error(404, "no such file");
}
    // rust: let mut response = Self::text(200, "application/octet-stream", "")
    // rust: .with("Content-Length", length.to_string())
    // rust: .with(
    // rust: "Content-Disposition",
    // rust: format!("attachment; filename=\"{name}\""),
    // rust: );
    // rust: response.stream = Some(Box::new(move |mut stream: &TcpStream| {
    // rust: if let Ok(mut file) = std::fs::File::open(&path) {
    // rust: let _ = std::io::copy(&mut file, &mut stream);
}
    // rust: }));
    // rust: response
}
with :: proc(header: ^'static str, value: impl Into<string>) -> S {
    // Ported from Horizon
    return {}
}
    // rust: self.headers.push((header, value.into()));
    // rust: self
}
}

reason :: proc(status: u16) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: match status {
    // rust: 200 => "OK",
    // rust: 303 => "See Other",
    // rust: 400 => "Bad Request",
    // rust: 401 => "Unauthorized",
    // rust: 403 => "Forbidden",
    // rust: 404 => "Not Found",
    // rust: 405 => "Method Not Allowed",
    // rust: 409 => "Conflict",
    // rust: 413 => "Payload Too Large",
    // rust: 429 => "Too Many Requests",
    // rust: _ => "Error",
}
}

// `read_line` under a limit: more than MAX_LINE without a '\n' is an error
// (InvalidInput), not a line that grows for as long as the client streams.
read_line_bounded :: proc(reader: ^impl BufRead, line: ^string) -> s {
    // Ported from Horizon
    return {}
}
    // rust: let n = reader.by_ref().take(MAX_LINE as u64 + 1).read_line(line)?;
    // rust: if n > MAX_LINE {
    // rust: return Err(std::io::Error::new(
    // rust: std::io::ErrorKind::InvalidInput,
    // rust: "line too long",
    // rust: ));
}
    // rust: Ok(n)
}

// Reads one request from a connection, plain or TLS (the management protocol's `websocket::Link`).
read_request :: proc(stream: impl Read) -> R {
    // Ported from Horizon
    return {}
}
bad :: proc(m: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Response::error(400, m)
}
    // rust: fn read_line(
    // rust: reader: &mut impl BufRead,
    // rust: line: &mut String,
    // rust: what: &str,
    // rust: ) -> Result<usize, Response> {
    // rust: read_line_bounded(reader, line).map_err(|e| {
    // rust: if e.kind() == std::io::ErrorKind::InvalidInput {
    // rust: bad("line too long")
    // rust: } else {
    // rust: bad(what)
}
    // rust: })
}
    // rust: let mut reader = BufReader::new(stream);
    // rust: let mut line = String::new();
    // rust: read_line(&mut reader, &mut line, "no request")?;
    // rust: let mut parts = line.split_whitespace();
    // rust: let (Some(method), Some(target)) = (parts.next(), parts.next()) else {
    // rust: return Err(bad("malformed request line"));
}
    // rust: let (path, query) = target.split_once('?').unwrap_or((target, ""));
    // rust: let mut headers = Vec::new();
    // rust: loop {
    // rust: let mut line = String::new();
    // rust: if read_line(&mut reader, &mut line, "headers")? == 0 || line.trim().is_empty() {
    // rust: break;
}
    // rust: if headers.len() > 64 {
    // rust: return Err(bad("too many headers"));
}
    // rust: if let Some((k, v)) = line.split_once(':') {
    // rust: headers.push((k.trim().to_owned(), v.trim().to_owned()));
}
}
    // rust: let length = headers
    // rust: .iter()
    // rust: .find(|(k, _)| k.eq_ignore_ascii_case("content-length"))
    // rust: .map_or(Ok(0), |(_, v)| v.parse::<usize>())
    // rust: .map_err(|_| bad("bad Content-Length"))?;
    // rust: if length > MAX_BODY {
    // rust: return Err(Response::error(413, "the body is too large"));
}
    // rust: let mut body = vec![0; length];
    // rust: reader
    // rust: .read_exact(&mut body)
    // rust: .map_err(|_| bad("the body is shorter than its Content-Length"))?;
    // rust: Ok(Request {
    // rust: method: method.to_owned(),
    // rust: path: path.to_owned(),
    // rust: query: query.to_owned(),
    // rust: headers,
    // rust: body,
    // rust: })
}

write_response :: proc(mut stream: ^TcpStream, mut response: Response) {
}
    // rust: let _ = write_head(stream, &response);
    // rust: if let Some(body) = response.stream.take() {
    // rust: body(stream);
    // rust: let _ = stream.flush();
}
}

// The status line, the headers and `body`: all of a response but its `stream`.
write_head :: proc(mut out: impl Write, response: ^Response) -> s {
    // Ported from Horizon
    return {}
}
    // A WebSocket upgrade: only the headers the handshake needs, then the socket is the stream's.
    // rust: let mut head = if response.status == 101 {
    // rust: "HTTP/1.1 101 Switching Protocols\r\n".to_owned()
    // rust: } else {
    // rust: format!(
    // rust: "HTTP/1.1 {} {}\r\nContent-Type: {}\r\nCache-Control: no-store\r\nConnection: close\r\n",
    // rust: response.status,
    // rust: reason(response.status),
    // rust: response.content_type,
    // rust: )
}
    // rust: if response.stream.is_none() && response.status != 101 {
    // rust: head.push_str(&format!("Content-Length: {}\r\n", response.body.len()));
}
    // rust: for (name, value) in &response.headers {
    // rust: head.push_str(&format!("{name}: {value}\r\n"));
}
    // rust: head.push_str("\r\n");
    // rust: out.write_all(head.as_bytes())?;
    // rust: out.write_all(response.body.as_bytes())?;
    // rust: out.flush()
}

// Serves `handle` on `listener` until the process ends, a thread per connection.
    // rust: pub fn serve(
    // rust: listener: TcpListener,
    // rust: handle: impl Fn(&Request) -> Response + Send + Sync + 'static,
    // rust: ) -> std::io::Result<()> {
    // rust: let handle = std::sync::Arc::new(handle);
    // rust: std::thread::Builder::new()
    // rust: .name("api".into())
    // rust: .spawn(move || {
    // rust: for stream in listener.incoming().flatten() {
    // rust: let handle = handle.clone();
    // rust: let _ = std::thread::Builder::new()
    // rust: .name("api-client".into())
    // rust: .spawn(move || {
    // rust: let _ = stream.set_read_timeout(Some(Duration::from_secs(10)));
    // rust: let response = match read_request(&stream) {
    // rust: Ok(request) => handle(&request),
    // rust: Err(response) => response,
}
    // rust: write_response(&stream, response);
    // rust: });
}
    // rust: })?;
    // rust: Ok(())
}

// One request to `address`, with a bearer token; the status and the body.
    // rust: pub fn request(
    // rust: address: SocketAddr,
    // rust: token: &str,
    // rust: method: &str,
    // rust: path: &str,
    // rust: body: Option<&serde_json::Value>,
    // rust: timeout: Duration,
    // rust: ) -> std::io::Result<(u16, String)> {
    // rust: let mut stream = TcpStream::connect_timeout(&address, Duration::from_secs(5))?;
    // rust: stream.set_read_timeout(Some(timeout))?;
    // rust: let body = body.map(ToString::to_string).unwrap_or_default();
    // rust: write!(
    // rust: stream,
    // rust: "{method} {path} HTTP/1.1\r\nHost: {address}\r\nAuthorization: Bearer {token}\r\nContent-Type: application/json\r\nContent-Length: {}\r\nConnection: close\r\n\r\n{body}",
    // rust: body.len()
    // rust: )?;
    // rust: stream.flush()?;
    // rust: let mut text = String::new();
    // rust: stream.read_to_string(&mut text)?;
    // rust: let (head, body) = text.split_once("\r\n\r\n").unwrap_or((&text, ""));
    // rust: let status = head
    // rust: .split_whitespace()
    // rust: .nth(1)
    // rust: .and_then(|s| s.parse().ok())
    // rust: .ok_or_else(|| std::io::Error::other("not an HTTP response"))?;
    // rust: Ok((status, body.to_owned()))
}

    // rust: mod tests {
//     use super::*;

round_trip :: proc() {
}
    // rust: let listener = TcpListener::bind("127.0.0.1:0").unwrap();
    // rust: let address = listener.local_addr().unwrap();
    // rust: serve(listener, |r| {
    // rust: Response::json(
    // rust: 200,
    // rust: &serde_json::json!({
    // rust: "method": r.method,
    // rust: "path": r.path,
    // rust: "since": r.param("since"),
    // rust: "auth": r.header("authorization"),
    // rust: "body": String::from_utf8_lossy(&r.body),
    // rust: }),
    // rust: )
    // rust: })
    // rust: .unwrap();
    // rust: let (status, body) = request(
    // rust: address,
    // rust: "t0k",
    // rust: "POST",
    // rust: "/api/v1/command?since=7",
    // rust: Some(&serde_json::json!({ "line": "list" })),
    // rust: Duration::from_secs(5),
    // rust: )
    // rust: .unwrap();
    // rust: assert_eq!(status, 200);
    // rust: let v: serde_json::Value = serde_json::from_str(&body).unwrap();
    // rust: assert_eq!(v["method"], "POST");
    // rust: assert_eq!(v["path"], "/api/v1/command");
    // rust: assert_eq!(v["since"], "7");
    // rust: assert_eq!(v["auth"], "Bearer t0k");
    // rust: assert_eq!(v["body"], r#"{"line":"list"}"#);
}

a_line_past_the_limit_is_a_400 :: proc() {
}
    // rust: let listener = TcpListener::bind("127.0.0.1:0").unwrap();
    // rust: let address = listener.local_addr().unwrap();
    // rust: serve(listener, |_| Response::text(200, "text/plain", "ok")).unwrap();
    // rust: let mut stream = TcpStream::connect(address).unwrap();
    // rust: stream
    // rust: .set_read_timeout(Some(Duration::from_secs(5)))
    // rust: .unwrap();
        // A request line that never ends, sent at once so the refused reply
        // (and the close) can't reset the write side first.
    // rust: let mut flood = b"GET /".to_vec();
    // rust: flood.extend_from_slice(&[b'a'; 100_000]);
    // rust: let _ = stream.write_all(&flood);
    // rust: let _ = stream.shutdown(std::net::Shutdown::Write);
    // rust: let mut text = String::new();
    // rust: let _ = stream.read_to_string(&mut text);
    // rust: assert!(text.starts_with("HTTP/1.1 400"), "{text}");
}
}
