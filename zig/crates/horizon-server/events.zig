//! Transpiled from Horizon Rust crate
//! Module: horizon-server_events
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The event stream (`GET /api/v1/events`, docs/api/server.md): every log line, the supervisor's phase, and
//! the game's typed events (players joining, leaving and kicked, chat, deaths), numbered in one sequence. A
//! client that asks for `text/event-stream` gets server-sent events as they happen, and resumes after a
//! reconnection from `Last-Event-ID`; any other gets the events after `since` as JSON.

// use crate::{
    // rust: api::{Phase, Shared},
    // rust: engine,
    // rust: http::{Request, Response},
}
// use serde_json::{Value, json};
// use std::{
    // rust: collections::VecDeque,
    // rust: io::Write,
    // rust: sync::Arc,
    // rust: thread,
    // rust: time::{Duration, Instant},
}

/// The events kept for a client that reconnects or polls.
pub const KEPT: usize = 2000;
/// How often the game's events are fetched.
pub const POLL: Duration = Duration::from_millis(250);
/// A comment this often keeps proxies from closing a quiet stream, and finds clients that left.
pub const KEEP_ALIVE: Duration = Duration::from_secs(15);

/// The events, numbered from 1 since the supervisor started.
pub const Events = struct {
    kept: VecDeque<Value>,
    last: u64,
};

    // rust: impl Events {
    /// The events numbered above `since` whose type `wanted` takes, and the newest number.
    // rust: pub(crate) fn after(&self, since: u64, wanted: &dyn Fn(&str) -> bool) -> (u64, Vec<Value>) {
    // rust: let skip = self
    // rust: .kept
    // rust: .len()
    // rust: .saturating_sub((self.last.saturating_sub(since)) as usize);
    // rust: let events = self
    // rust: .kept
    // rust: .iter()
    // rust: .skip(skip)
    // rust: .filter(|e| wanted(e["type"].as_str().unwrap_or_default()))
    // rust: .cloned()
    // rust: .collect();
    // rust: (self.last, events)
}
}

    // rust: impl Shared {
    /// Adds an event of type `kind` and wakes the streams.
pub fn emit(self: *Self, kind: []const u8, mut event: Value) void {
}
    // rust: let mut events = self.events.lock().unwrap();
    // rust: events.last += 1;
    // rust: event["id"] = events.last.into();
    // rust: event["type"] = kind.into();
    // rust: if events.kept.len() == KEPT {
    // rust: events.kept.pop_front();
}
    // rust: events.kept.push_back(event);
    // rust: drop(events);
    // rust: self.event_added.notify_all();
}

    /// A log line, for `logs` and as a `log` event.
pub fn log_line(self: *Self, line: []const u8) void {
}
    // rust: self.emit("log", json!({ "line": line }));
    // rust: self.log.lock().unwrap().push(line);
}
}

/// Fetches the game's typed events (`server-events` on its control endpoint) while it runs.
pub fn poll_game(shared: *Shared) void {
}
    // rust: let _ = thread::Builder::new().name("events".into()).spawn(move || {
    // rust: let mut control: Option<(u32, engine::Control)> = None;
    // rust: let mut since = 0u64;
    // rust: loop {
    // rust: thread::sleep(POLL);
    // rust: let (pid, running) = {
    // rust: let state = shared.state.lock().unwrap();
    // rust: (state.engine_pid, state.phase == Phase::Running)
}
    // rust: let (Some(pid), true) = (pid, running) else {
    // rust: control = None;
    // rust: continue;
}
            // A new game numbers its events from 1 again.
    // rust: let mut history = false;
    // rust: if control.as_ref().is_none_or(|(p, _)| *p != pid) {
    // rust: control = engine::Control::connect(&shared.dir).ok().map(|c| (pid, c));
    // rust: since = 0;
                // What the game recorded before this first fetch (its saves while it started) happened before
                // the management protocol's clients could hear of it.
    // rust: history = true;
}
    // rust: let Some((_, game)) = control.as_mut() else {
    // rust: continue;
}
    // rust: let Ok(reply) = game.ask(&format!("server-events {since}")) else {
    // rust: control = None;
    // rust: continue;
}
    // rust: for event in reply["events"].as_array().into_iter().flatten() {
    // rust: let mut event = event.clone();
    // rust: since = since.max(event["seq"].as_u64().unwrap_or(since));
    // rust: let kind = event["type"].as_str().unwrap_or("game").to_owned();
    // rust: if let Some(fields) = event.as_object_mut() {
    // rust: fields.remove("seq");
}
    // rust: if !(history && matches!(kind.as_str(), "saving" | "saved")) {
    // rust: crate::management::game_event(&shared, &kind, &event);
}
    // rust: shared.emit(&kind, event);
}
}
    // rust: });
}

/// `GET /api/v1/events[?since=N][&types=join,chat,...]`.
pub fn route(shared: **Shared, request: *Request) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let types: Vec<String> = request
    // rust: .param("types")
    // rust: .map(|t| t.split(',').map(str::to_owned).collect())
    // rust: .unwrap_or_default();
    // rust: let wanted = move |kind: &str| types.is_empty() || types.iter().any(|t| t == kind);
    // rust: let since = request
    // rust: .param("since")
    // rust: .or_else(|| request.header("last-event-id"))
    // rust: .and_then(|s| s.parse().ok());
    // rust: let streamed = request
    // rust: .header("accept")
    // rust: .is_some_and(|a| a.contains("text/event-stream"));
    // rust: if !streamed {
    // rust: let (last, events) = shared
    // rust: .events
    // rust: .lock()
    // rust: .unwrap()
    // rust: .after(since.unwrap_or(0), &wanted);
    // rust: return Response::json(200, &json!({ "next": last, "events": events }));
}
    // Without a number, the stream starts with the request: what happens while the reply's headers go out
    // is sent.
    // rust: let mut cursor = since.unwrap_or_else(|| shared.events.lock().unwrap().last);
    // rust: let shared = shared.clone();
    // rust: let mut response = Response::text(200, "text/event-stream", "");
    // rust: response.stream = Some(Box::new(move |mut stream| {
    // rust: let mut quiet_since = Instant::now();
    // rust: loop {
    // rust: let events = {
    // rust: let events = shared.events.lock().unwrap();
    // rust: let events = if events.last == cursor {
    // rust: shared
    // rust: .event_added
    // rust: .wait_timeout(events, KEEP_ALIVE)
    // rust: .unwrap()
    // rust: .0
    // rust: } else {
    // rust: events
}
    // rust: let (last, after) = events.after(cursor, &wanted);
    // rust: cursor = last;
    // rust: after
}
    // rust: let mut text = String::new();
    // rust: for event in &events {
    // rust: text += &format!(
    // rust: "id: {}\nevent: {}\ndata: {event}\n\n",
    // rust: event["id"],
    // rust: event["type"].as_str().unwrap_or_default()
    // rust: );
}
    // rust: if text.is_empty() && quiet_since.elapsed() >= KEEP_ALIVE {
    // rust: text = ": keep-alive\n\n".into();
}
    // rust: if !text.is_empty() {
    // rust: quiet_since = Instant::now();
    // rust: if stream
    // rust: .write_all(text.as_bytes())
    // rust: .and_then(|()| stream.flush())
    // rust: .is_err()
    // rust: {
    // rust: return;
}
}
}
    // rust: }));
    // rust: response
}

    // rust: mod tests {
//     use super::*;

pub fn event_reply(response: Response) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: assert!(response.stream.is_none());
    // rust: json!({
    // rust: "status": response.status,
    // rust: "content_type": response.content_type,
    // rust: "headers": response.headers,
    // rust: "body": serde_json::from_str::<Value>(&response.body).unwrap(),
    // rust: })
}

pub fn events_after_a_number_by_type() void {
}
    // rust: let mut events = Events::default();
    // rust: for i in 0..KEPT + 5 {
    // rust: events.last += 1;
    // rust: if events.kept.len() == KEPT {
    // rust: events.kept.pop_front();
}
    // rust: let kind = if i % 2 == 0 { "log" } else { "chat" };
    // rust: events
    // rust: .kept
    // rust: .push_back(json!({ "id": events.last, "type": kind }));
}
    // rust: let all = |_: &str| true;
    // rust: let (last, after) = events.after(events.last - 3, &all);
    // rust: assert_eq!(last, (KEPT + 5) as u64);
    // rust: assert_eq!(
    // rust: after
    // rust: .iter()
    // rust: .map(|e| e["id"].as_u64().unwrap())
    // rust: .collect::<Vec<_>>(),
    // rust: [last - 2, last - 1, last]
    // rust: );
        // Asked from before the oldest kept: everything kept.
    // rust: assert_eq!(events.after(0, &all).1.len(), KEPT);
    // rust: let chat = |t: &str| t == "chat";
    // rust: assert!(
    // rust: events
    // rust: .after(last - 10, &chat)
    // rust: .1
    // rust: .iter()
    // rust: .all(|e| e["type"] == "chat")
    // rust: );
    // rust: assert!(events.after(last, &all).1.is_empty());
}

pub fn a_stream_sends_what_happens() void {
}
//         use std::io::{BufRead, BufReader};
    // rust: let dir =
    // rust: std::env::temp_dir().join(format!("horizon-server-events-{}", std::process::id()));
    // rust: std::fs::create_dir_all(&dir).unwrap();
    // rust: let shared = Shared::with_install(&dir, None);
    // rust: shared.log_line("before".into());
    // rust: let listener = std::net::TcpListener::bind("127.0.0.1:0").unwrap();
    // rust: let address = listener.local_addr().unwrap();
    // rust: let served = shared.clone();
    // rust: crate::http::serve(listener, move |request| route(&served, request)).unwrap();
    // rust: let mut stream = std::net::TcpStream::connect(address).unwrap();
    // rust: write!(
    // rust: stream,
    // rust: "GET /api/v1/events?types=join HTTP/1.1\r\nAccept: text/event-stream\r\n\r\n"
    // rust: )
    // rust: .unwrap();
    // rust: let mut reader = BufReader::new(stream);
    // rust: let mut line = String::new();
    // rust: while line != "\r\n" {
    // rust: line.clear();
    // rust: reader.read_line(&mut line).unwrap();
}
    // rust: shared.log_line("not a join".into());
    // rust: shared.emit("join", json!({ "name": "Kim0" }));
    // rust: let mut got = Vec::new();
    // rust: for _ in 0..3 {
    // rust: line.clear();
    // rust: reader.read_line(&mut line).unwrap();
    // rust: got.push(line.trim_end().to_owned());
}
    // rust: assert_eq!(got[0], "id: 3");
    // rust: assert_eq!(got[1], "event: join");
    // rust: assert!(
    // rust: got[2].starts_with("data: {") && got[2].contains("\"name\":\"Kim0\""),
    // rust: "{got:?}"
    // rust: );
        // Polled as JSON: everything after the first.
    // rust: let polled = route(
    // rust: &shared,
    // rust: &Request {
    // rust: method: "GET".into(),
    // rust: path: "/api/v1/events".into(),
    // rust: query: "since=1".into(),
    // rust: headers: Vec::new(),
    // rust: body: Vec::new(),
    // rust: },
    // rust: );
    // rust: let polled: Value = serde_json::from_str(&polled.body).unwrap();
    // rust: assert_eq!(polled["next"], 3);
    // rust: assert_eq!(polled["events"][0]["line"], "not a join");
    // rust: std::fs::remove_dir_all(&dir).unwrap();
}

pub fn event_replies_match_api_v1_goldens() void {
}
//         use std::io::Read;

    // rust: let golden: Value =
    // rust: serde_json::from_str(include_str!("../testdata/api-v1-events.json")).unwrap();
    // rust: let shared = Shared::with_install(std::path::Path::new("unused"), None);
    // rust: shared.log_line("ready".into());
    // rust: shared.emit("join", json!({ "name": "Alex" }));
    // rust: shared.emit("chat", json!({ "name": "Alex", "message": "hi" }));
    // rust: let poll = |query: &str, headers: Vec<(String, String)>| {
    // rust: event_reply(route(
    // rust: &shared,
    // rust: &Request {
    // rust: method: "GET".into(),
    // rust: path: "/api/v1/events".into(),
    // rust: query: query.into(),
    // rust: headers,
    // rust: body: Vec::new(),
    // rust: },
    // rust: ))
}
    // rust: assert_eq!(poll("", Vec::new()), golden["all"]);
    // rust: assert_eq!(poll("since=2", Vec::new()), golden["since"]);
    // rust: assert_eq!(poll("types=join,leave", Vec::new()), golden["types"]);
    // rust: assert_eq!(
    // rust: poll("", vec![("Last-Event-ID".into(), "1".into())]),
    // rust: golden["last_event_id"]
    // rust: );
    // rust: assert_eq!(poll("since=not-a-number", Vec::new()), golden["bad_since"]);
    // rust: assert_eq!(poll("types=unknown", Vec::new()), golden["unknown_type"]);

    // rust: let mut response = route(
    // rust: &shared,
    // rust: &Request {
    // rust: method: "GET".into(),
    // rust: path: "/api/v1/events".into(),
    // rust: query: "types=join,chat".into(),
    // rust: headers: vec![
    // rust: ("Accept".into(), "text/event-stream".into()),
    // rust: ("Last-Event-ID".into(), "1".into()),
    // rust: ],
    // rust: body: Vec::new(),
    // rust: },
    // rust: );
    // rust: assert_eq!(response.status, golden["stream"]["status"]);
    // rust: assert_eq!(response.content_type, golden["stream"]["content_type"]);
    // rust: assert_eq!(response.headers, Vec::<(&str, String)>::new());
    // rust: let expected = golden["stream"]["body"].as_str().unwrap().as_bytes();
    // rust: let listener = std::net::TcpListener::bind("127.0.0.1:0").unwrap();
    // rust: let mut client = std::net::TcpStream::connect(listener.local_addr().unwrap()).unwrap();
    // rust: let (server, _) = listener.accept().unwrap();
    // rust: let control = server.try_clone().unwrap();
    // rust: let write = response.stream.take().unwrap();
    // rust: let writer = std::thread::spawn(move || write(&server));
    // rust: let mut body = vec![0; expected.len()];
    // rust: client.read_exact(&mut body).unwrap();
    // rust: assert_eq!(body, expected);
    // rust: control.shutdown(std::net::Shutdown::Both).unwrap();
    // rust: shared.emit("join", json!({ "name": "Wake" }));
    // rust: writer.join().unwrap();
}
}
