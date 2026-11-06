//! Transpiled from Horizon Rust crate
//! Module: horizon-mod-api-gen_injection_tests
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

// use super::inject;

pub fn injection(name: []const u8, event: []const u8) s {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: serde_json::json!({
    // rust: "name": name,
    // rust: "event": event,
    // rust: "declaration": format!("fn {name}(&self) {{}}"),
    // rust: "event_declaration": format!("pub struct {event};"),
    // rust: })
}

pub fn rejects_duplicate_methods_and_event_names_across_injections() void {
}
    // rust: let api = "pub trait Hooks: Send + Sync {}";
    // rust: for declarations in [
    // rust: vec![
    // rust: injection("tick", "TickEvent"),
    // rust: injection("tick", "OtherEvent"),
    // rust: ],
    // rust: vec![
    // rust: injection("tick", "TickEvent"),
    // rust: injection("other", "TickEvent"),
    // rust: ],
    // rust: ] {
    // rust: assert!(inject(api, &serde_json::to_string(&declarations).unwrap()).is_err());
}
}

pub fn rejects_malformed_or_misnamed_declarations_at_the_boundary() void {
}
    // rust: let api = "pub trait Hooks: Send + Sync {}";
    // rust: let mut wrong_method = injection("tick", "TickEvent");
    // rust: wrong_method["declaration"] = "fn other(&self) {}".into();
    // rust: let mut wrong_event = injection("tick", "TickEvent");
    // rust: wrong_event["event_declaration"] = "pub struct OtherEvent;".into();
    // rust: let mut invalid_rust = injection("tick", "TickEvent");
    // rust: invalid_rust["event_declaration"] = "not a struct".into();
    // rust: for declaration in [wrong_method, wrong_event, invalid_rust] {
    // rust: assert!(inject(api, &serde_json::json!([declaration]).to_string()).is_err());
}
    // rust: for invalid in ["{}", "[{}]", "null", "not json"] {
    // rust: assert!(inject(api, invalid).is_err());
}
}
