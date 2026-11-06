//! Transpiled from Horizon Rust crate
package horizon_server_panel

import "core:fmt"
import "core:mem"
import "core:math"

// The web panel (docs/server.md, section 6): one page embedded in the binary, served by the supervisor on
// `[panel] bind` (127.0.0.1:8130 by default; a tailnet address to reach it from the owner's devices). It
// uses the control API's routes with a browser session instead of the token.
//
// - **Login.** `horizon-server panel` asks the API for a link with a one-time code, good for 10 minutes;
//   opening it swaps the code for an `HttpOnly; SameSite=Strict` session cookie. Anyone who can read the
//   server folder's token can make a link, and no one else can. Sessions end when the supervisor does.
// - **Rebinding and CSRF.** The `Host` header must name the panel's own address (`localhost` too on
//   loopback, a MagicDNS name on a tailnet). Every POST needs the `X-Horizon: 1` header, which a page from
//   another site can't send without the browser asking first.
// - **The page** loads nothing from elsewhere (a strict Content-Security-Policy) and can't be framed.

// use crate::{
    // rust: api::{self, Shared},
    // rust: http::{self, Request, Response},
}
// use std::{
    // rust: collections::VecDeque,
    // rust: net::{SocketAddr, TcpListener},
    // rust: sync::Arc,
    // rust: time::{Duration, Instant},
}

COOKIE :: "horizon_panel"
// How long a login link works.
LINK_LIFE :: Duration::from_secs(600)
// Failed logins allowed per minute before the panel refuses them for a while.
FAILURES_PER_MINUTE :: 10
SESSIONS :: 32

PAGE :: include_str!("../panel/index.html")
SCRIPT :: include_str!("../panel/panel.js")
STYLE :: include_str!("../panel/panel.css")

// The panel's address, its pending login codes and its sessions.
Auth :: struct {
    address: Maybe(SocketAddr),
    codes: Vec<(string,
    sessions: VecDeque<string>,
    failures: VecDeque<Instant>,
}

    // rust: impl Auth {
    // A one-time login link; `None` when the panel is off.
login_link :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let address = self.address?;
    // rust: self.codes.retain(|(_, at)| at.elapsed() < LINK_LIFE);
    // rust: let code = api::random_token();
    // rust: self.codes.push((code.clone(), Instant::now()));
    // rust: Some(format!("http://{address}/login?code={code}"))
}

    // Swaps a login code for a new session.
redeem :: proc(self: ^Self, code: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.failures
    // rust: .retain(|at| at.elapsed() < Duration::from_secs(60));
    // rust: if self.failures.len() >= FAILURES_PER_MINUTE {
    // rust: return Err(page_error(
    // rust: 429,
    // rust: "Too many failed logins: wait a minute, then open a new link.",
    // rust: ));
}
    // rust: self.codes.retain(|(_, at)| at.elapsed() < LINK_LIFE);
    // rust: let Some(i) = self
    // rust: .codes
    // rust: .iter()
    // rust: .position(|(c, _)| api::same_token(c, code))
    // rust: else {
    // rust: self.failures.push_back(Instant::now());
    // rust: return Err(page_error(
    // rust: 403,
    // rust: "This login link was used already or has expired. Run `horizon-server panel` for a new one.",
    // rust: ));
}
    // rust: self.codes.remove(i);
    // rust: let session = api::random_token();
    // rust: if self.sessions.len() == SESSIONS {
    // rust: self.sessions.pop_front();
}
    // rust: self.sessions.push_back(session.clone());
    // rust: Ok(session)
}

signed_in :: proc(self: ^Self, request: ^Request) -> b {
    // Ported from Horizon
    return {}
}
    // rust: request
    // rust: .cookie(COOKIE)
    // rust: .is_some_and(|s| self.sessions.iter().any(|t| api::same_token(t, s)))
}

sign_out :: proc(self: ^Self, request: ^Request) {
}
    // rust: if let Some(s) = request.cookie(COOKIE) {
    // rust: self.sessions.retain(|t| !api::same_token(t, s));
}
}
}

page_error :: proc(status: u16, message: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let body = format!(
    // rust: "<!doctype html><meta charset=utf-8><title>Horizon server</title>\
    // rust: <link rel=stylesheet href=/panel.css><main class=message><p>{}</p></main>",
    // rust: message
    // rust: .replace('&', "&amp;")
    // rust: .replace('<', "&lt;")
    // rust: .replace('>', "&gt;")
    // rust: );
    // rust: Response::text(status, "text/html; charset=utf-8", body)
}

// The `Host` header names the panel (or the control API) itself: its address, `localhost` on loopback, or a tailnet name
// (a MagicDNS short name or `*.ts.net`, with or without the port when `tailscale serve` passes it on).
host_allowed :: proc(host: string, address: SocketAddr) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if host == address.to_string() {
    // rust: return true;
}
    // rust: let (name, port) = match host.rsplit_once(':') {
    // rust: Some((name, port)) if !name.ends_with(']') || name.starts_with('[') => (name, Some(port)),
    // rust: _ => (host, None),
}
    // rust: let same_port = port == Some(&address.port().to_string());
    // rust: if address.ip().is_loopback() && name.eq_ignore_ascii_case("localhost") && same_port {
    // rust: return true;
}
    // rust: let tailnet_name = name.to_ascii_lowercase().ends_with(".ts.net")
    // rust: || (!name.is_empty()
    // rust: && !name.contains('.')
    // rust: && !name.contains('[')
    // rust: && !name.eq_ignore_ascii_case("localhost"));
    // rust: tailnet_name
    // rust: && (same_port || port.is_none())
    // rust: && name
    // rust: .chars()
    // rust: .all(|c| c.is_ascii_alphanumeric() || c == '-' || c == '.')
}

secure :: proc(response: Response) -> R {
    // Ported from Horizon
    return {}
}
    // rust: response
    // rust: .with(
    // rust: "Content-Security-Policy",
    // rust: "default-src 'none'; script-src 'self'; style-src 'self'; img-src 'self' data:; \
    // rust: connect-src 'self'; frame-ancestors 'none'; base-uri 'none'; form-action 'self'",
    // rust: )
    // rust: .with("X-Content-Type-Options", "nosniff")
    // rust: .with("X-Frame-Options", "DENY")
    // rust: .with("Referrer-Policy", "no-referrer")
}

handle :: proc(shared: ^^Shared, address: SocketAddr, request: ^Request) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if !request
    // rust: .header("host")
    // rust: .is_some_and(|h| host_allowed(h, address))
    // rust: {
    // rust: return Response::error(403, "wrong Host");
}
    // rust: let method = request.method.as_str();
    // rust: let path = request.path.as_str();
    // rust: match (method, path) {
    // rust: ("GET", "/") => return Response::text(200, "text/html; charset=utf-8", PAGE),
    // rust: ("GET", "/panel.js") => {
    // rust: return Response::text(200, "text/javascript; charset=utf-8", SCRIPT);
}
    // rust: ("GET", "/panel.css") => return Response::text(200, "text/css; charset=utf-8", STYLE),
    // rust: ("GET", "/login") => {
    // rust: let code = request.param("code").unwrap_or_default();
    // rust: return match shared.panel.lock().unwrap().redeem(code) {
    // rust: Ok(session) => Response::text(303, "text/plain", "")
    // rust: .with("Location", "/")
    // rust: .with(
    // rust: "Set-Cookie",
    // rust: format!("{COOKIE}={session}; HttpOnly; SameSite=Strict; Path=/"),
    // rust: ),
    // rust: Err(response) => response,
}
}
    // rust: _ => {}
}
    // rust: if method != "GET" && request.header("x-horizon") != Some("1") {
    // rust: return Response::error(403, "missing the X-Horizon header");
}
    // rust: if (method, path) == ("POST", "/logout") {
    // rust: shared.panel.lock().unwrap().sign_out(request);
    // rust: return Response::json(200, &serde_json::json!({ "ok": true })).with(
    // rust: "Set-Cookie",
    // rust: format!("{COOKIE}=; HttpOnly; SameSite=Strict; Path=/; Max-Age=0"),
    // rust: );
}
    // rust: if !path.starts_with("/api/v1/") {
    // rust: return Response::error(404, "no such page");
}
    // rust: if !shared.panel.lock().unwrap().signed_in(request) {
    // rust: return Response::error(
    // rust: 401,
    // rust: "sign in with a link from `horizon-server panel` on the server",
    // rust: );
}
    // rust: if path == "/api/v1/panel/login" {
    // rust: return Response::error(403, "login links come from `horizon-server panel` only");
}
    // rust: api::route(shared, request)
}

// Starts the panel on `address`.
start :: proc(shared: ^Shared, address: SocketAddr) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let listener = TcpListener::bind(address).map_err(|e| e.to_string())?;
    // rust: shared.panel.lock().unwrap().address = Some(address);
    // rust: http::serve(listener, move |request| {
    // rust: secure(handle(&shared, address, request))
    // rust: })
    // rust: .map_err(|e| e.to_string())
}

    // rust: mod tests {
//     use super::*;
//     use std::io::{Read, Write};

hosts :: proc() {
}
    // rust: let local: SocketAddr = "127.0.0.1:8130".parse().unwrap();
    // rust: assert!(host_allowed("127.0.0.1:8130", local));
    // rust: assert!(host_allowed("localhost:8130", local));
    // rust: assert!(!host_allowed("localhost:8131", local));
    // rust: assert!(!host_allowed("evil.example:8130", local));
    // rust: assert!(!host_allowed("127.0.0.1.nip.io:8130", local));
    // rust: let tailnet: SocketAddr = "100.100.1.2:8130".parse().unwrap();
    // rust: assert!(host_allowed("100.100.1.2:8130", tailnet));
    // rust: assert!(host_allowed("myserver:8130", tailnet));
    // rust: assert!(host_allowed("myserver.tail1234.ts.net", tailnet));
    // rust: assert!(!host_allowed("localhost:8130", tailnet));
    // rust: assert!(!host_allowed("evil.example", tailnet));
    // rust: let v6: SocketAddr = "[::1]:8130".parse().unwrap();
    // rust: assert!(host_allowed("[::1]:8130", v6));
    // rust: assert!(!host_allowed("[::2]:8130", v6));
}

    // One raw request to the panel; the status line, the headers and the body.
send :: proc(address: SocketAddr, text: string) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let mut stream = std::net::TcpStream::connect(address).unwrap();
    // rust: stream.write_all(text.as_bytes()).unwrap();
    // rust: let mut out = String::new();
    // rust: stream.read_to_string(&mut out).unwrap();
    // rust: let (head, body) = out.split_once("\r\n\r\n").unwrap();
    // rust: (head.to_owned(), body.to_owned())
}

sign_in_with_a_link :: proc() {
}
    // rust: let dir = std::env::temp_dir().join(format!("horizon-server-panel-{}", std::process::id()));
    // rust: std::fs::create_dir_all(&dir).unwrap();
    // rust: let shared = Shared::new(&dir);
    // rust: let listener = TcpListener::bind("127.0.0.1:0").unwrap();
    // rust: let address = listener.local_addr().unwrap();
    // rust: drop(listener);
    // rust: start(shared.clone(), address).unwrap();
    // rust: let host = format!("Host: {address}\r\n");
    // rust: let get = |path: &str, extra: &str| {
    // rust: send(
    // rust: address,
    // rust: &format!("GET {path} HTTP/1.1\r\n{host}{extra}Connection: close\r\n\r\n"),
    // rust: )
}
        // The page itself is public; the API is not.
    // rust: let (head, body) = get("/", "");
    // rust: assert!(head.starts_with("HTTP/1.1 200"), "{head}");
    // rust: assert!(head.contains("Content-Security-Policy"));
    // rust: assert!(body.contains("panel.js"));
    // rust: assert!(get("/api/v1/status", "").0.starts_with("HTTP/1.1 401"));
    // rust: let rebound = send(
    // rust: address,
    // rust: "GET / HTTP/1.1\r\nHost: evil.example\r\nConnection: close\r\n\r\n",
    // rust: );
    // rust: assert!(rebound.0.starts_with("HTTP/1.1 403"));
        // A link works once.
    // rust: let url = shared.panel.lock().unwrap().login_link().unwrap();
    // rust: let path = url.split_once(&address.to_string()).unwrap().1.to_owned();
    // rust: let (head, _) = get(&path, "");
    // rust: assert!(head.starts_with("HTTP/1.1 303"), "{head}");
    // rust: let cookie = head
    // rust: .lines()
    // rust: .find_map(|l| l.strip_prefix("Set-Cookie: "))
    // rust: .unwrap();
    // rust: assert!(cookie.contains("HttpOnly") && cookie.contains("SameSite=Strict"));
    // rust: let session = cookie.split(';').next().unwrap().to_owned();
    // rust: assert!(get(&path, "").0.starts_with("HTTP/1.1 403"));
    // rust: let with_cookie = format!("Cookie: other=1; {session}\r\n");
    // rust: let (head, body) = get("/api/v1/status", &with_cookie);
    // rust: assert!(head.starts_with("HTTP/1.1 200"), "{head}");
    // rust: assert!(body.contains("\"phase\":\"starting\""));
        // Changes need the header a foreign page can't send.
    // rust: let post = |extra: &str| {
    // rust: send(
    // rust: address,
    // rust: &format!(
    // rust: "POST /api/v1/restart HTTP/1.1\r\n{host}{with_cookie}{extra}Content-Length: 0\r\nConnection: close\r\n\r\n"
    // rust: ),
    // rust: )
    // rust: .0
}
    // rust: assert!(post("").starts_with("HTTP/1.1 403"));
    // rust: assert!(!shared.restart.load(std::sync::atomic::Ordering::SeqCst));
    // rust: assert!(post("X-Horizon: 1\r\n").starts_with("HTTP/1.1 200"));
    // rust: assert!(shared.restart.load(std::sync::atomic::Ordering::SeqCst));
        // Login links come only from the token API.
    // rust: assert!(
    // rust: send(
    // rust: address,
    // rust: &format!(
    // rust: "POST /api/v1/panel/login HTTP/1.1\r\n{host}{with_cookie}X-Horizon: 1\r\nContent-Length: 0\r\nConnection: close\r\n\r\n"
    // rust: ),
    // rust: )
    // rust: .0
    // rust: .starts_with("HTTP/1.1 403")
    // rust: );
        // Wrong codes are counted (the used link above was one), then refused for a while.
    // rust: for _ in 1..FAILURES_PER_MINUTE {
    // rust: assert!(get("/login?code=nope", "").0.starts_with("HTTP/1.1 403"));
}
    // rust: assert!(get("/login?code=nope", "").0.starts_with("HTTP/1.1 429"));
    // rust: std::fs::remove_dir_all(&dir).unwrap();
}
}
