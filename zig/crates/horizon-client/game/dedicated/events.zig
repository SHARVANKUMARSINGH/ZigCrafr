//! Transpiled from Horizon Rust crate
//! Module: horizon-client_events
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! What happened on the dedicated server, typed, for horizon-server's event stream (`GET /api/v1/events`,
//! docs/api/server.md): players joining, leaving and kicked, chat, and deaths. The log says the same in
//! vanilla's words; these carry the player's UUID and the parts apart, so a bot needn't parse lines.
//! `server-events SINCE` on the control endpoint answers the events after the SINCE-th.
// use serde_json::{Value, json};
// use std::{collections::VecDeque, sync::Mutex};

/// The events kept for a reader that polls late.
pub const KEPT: usize = 1000;

pub const Events = struct {
    /// The number of the next event (the first is 1).
    next: u64,
    kept: VecDeque<Value>,
};

    // rust: static EVENTS: Mutex<Events> = Mutex::new(Events {
    // rust: next: 1,
    // rust: kept: VecDeque::new(),
    // rust: });

/// Records one event: its kind, the player's name and UUID, and what else it says.
    // rust: pub(in crate::game) fn record(kind: &str, name: &str, uuid: u128, mut fields: Value) {
    // rust: fields["name"] = name.into();
    // rust: fields["uuid"] = horizon_protocol::crypto::uuid_string(uuid).into();
    // rust: push(kind, fields);
}

/// Records an event of the server itself, with no player (`saving` and `saved`, around a world save; an IP
/// ban), and what else it says.
    // rust: pub(in crate::game) fn record_server(kind: &str, fields: Value) {
    // rust: push(kind, fields);
}

pub fn push(kind: []const u8, mut fields: Value) void {
}
    // rust: let mut events = EVENTS.lock().unwrap_or_else(|e| e.into_inner());
    // rust: fields["seq"] = events.next.into();
    // rust: fields["type"] = kind.into();
    // rust: fields["time"] = std::time::SystemTime::now()
    // rust: .duration_since(std::time::UNIX_EPOCH)
    // rust: .map_or(0, |d| d.as_millis() as u64)
    // rust: .into();
    // rust: events.next += 1;
    // rust: if events.kept.len() == KEPT {
    // rust: events.kept.pop_front();
}
    // rust: events.kept.push_back(fields);
}

/// `server-events SINCE`: the events numbered above `since`, and the number to ask from next.
    // rust: pub(super) fn since(since: u64) -> Value {
    // rust: let events = EVENTS.lock().unwrap_or_else(|e| e.into_inner());
    // rust: let after: Vec<&Value> = events
    // rust: .kept
    // rust: .iter()
    // rust: .filter(|e| e["seq"].as_u64().is_some_and(|s| s > since))
    // rust: .collect();
    // rust: json!({ "next": events.next - 1, "events": after })
}

    // rust: mod tests {
//     use super::*;

    // One test: the events are one process-wide list, so two tests recording at once would count each other's.
pub fn events_are_numbered_and_read_from_a_number() void {
}
    // rust: let first = since(u64::MAX)["next"].as_u64().unwrap();
    // rust: record("join", "Kim0", 1, json!({}));
    // rust: record("chat", "Kim0", 1, json!({ "message": "hi" }));
    // rust: let read = since(first);
    // rust: let events = read["events"].as_array().unwrap();
    // rust: assert_eq!(read["next"].as_u64(), Some(first + 2));
    // rust: assert_eq!(events.len(), 2);
    // rust: assert_eq!(events[1]["type"], "chat");
    // rust: assert_eq!(events[1]["message"], "hi");
    // rust: assert_eq!(events[1]["uuid"], "00000000-0000-0000-0000-000000000001");
    // rust: assert_eq!(since(first + 1)["events"].as_array().unwrap().len(), 1);
        // An event of the server itself (a world save) carries no player.
    // rust: record_server("saving", json!({}));
    // rust: let event = &since(first + 2)["events"][0];
    // rust: assert_eq!(event["type"], "saving");
    // rust: assert_eq!(event["seq"].as_u64(), Some(first + 3));
    // rust: assert!(event.get("name").is_none() && event.get("uuid").is_none());
}
}
