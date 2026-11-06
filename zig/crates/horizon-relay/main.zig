//! Transpiled from Horizon Rust crate
//! Module: horizon-relay_main
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! `horizon-relay`: listens on `$PORT` (7000 when unset; `RELAY_BIND` for one
//! address), limits from the `RELAY_*` variables (docs/play-with-friends.md).
//! Prints counts every five minutes, nothing else.
// use horizon_relay::{Config, Relay};
// use std::{net::TcpListener, time::Duration};

pub fn main() void {
}
    // rust: let port: u16 = std::env::var("PORT")
    // rust: .ok()
    // rust: .and_then(|p| p.trim().parse().ok())
    // rust: .unwrap_or(7000);
    // RELAY_BIND picks one address (e.g. only a tailnet); else dual-stack
    // where the system allows it, else IPv4.
    // rust: let bind = std::env::var("RELAY_BIND")
    // rust: .ok()
    // rust: .filter(|b| !b.trim().is_empty());
    // rust: let listener = match bind {
    // rust: Some(address) => TcpListener::bind((address.trim(), port)),
    // rust: None => TcpListener::bind(("::", port)).or_else(|_| TcpListener::bind(("0.0.0.0", port))),
}
    // rust: .unwrap_or_else(|e| {
    // rust: eprintln!("horizon-relay: can't listen on port {port}: {e}");
    // rust: std::process::exit(1);
    // rust: });
    // rust: let config = Config::from_env().unwrap_or_else(|e| {
    // rust: eprintln!("horizon-relay: {e}");
    // rust: std::process::exit(1);
    // rust: });
    // rust: println!(
    // rust: "horizon-relay {} listening on port {port} (hosts {}, bridges {}, {} KiB/s per stream, per-address limits {})",
    // rust: env!("CARGO_PKG_VERSION"),
    // rust: config.max_hosts,
    // rust: config.max_bridges,
    // rust: (config.session_rate / 1024.0) as u64,
    // rust: if config.per_address { "on" } else { "off" },
    // rust: );
    // rust: let relay = Relay::new(config);
    // rust: let r = relay.clone();
    // rust: std::thread::spawn(move || {
    // rust: loop {
    // rust: std::thread::sleep(Duration::from_secs(300));
    // rust: println!("{}", r.counts().json());
}
    // rust: });
    // rust: relay.serve(listener);
}
