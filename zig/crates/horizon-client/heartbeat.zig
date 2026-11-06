//! Transpiled from Horizon Rust crate
//! Module: horizon-client_heartbeat
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The anonymous "I'm playing" ping (`horizon_telemetry::live`, docs/telemetry.md) behind the
//! launcher's "N playing now". While the game runs, a thread of its own sends a random session
//! ID made here and kept only in memory, the version, the platform and whether a LAN or
//! play-with-friends world is open, every minute and at once when that last one changes.
//! It sends nothing when sending is turned off (`HORIZON_TELEMETRY_URL=off`) or with
//! `HORIZON_NO_HEARTBEAT=1` (automated runs).
// use std::sync::OnceLock;
// use std::sync::atomic::{AtomicBool, Ordering};
// use std::thread::Thread;
// use std::time::Duration;

// use horizon_telemetry::live::{self, Ping};

/// A world is open to LAN or to friends.
pub const LAN: AtomicBool = AtomicBool::new(false);
pub const PINGER: OnceLock<Thread> = OnceLock::new();

/// After a failure the next ping waits longer, doubling up to this.
pub const MAX_WAIT: Duration = Duration::from_secs(600);

/// Starts the pings, once. Call when the game itself starts (not a dedicated server, not a
/// benchmark or an automated run).
pub fn start() void {
}
    // rust: if PINGER.get().is_some() || std::env::var_os("HORIZON_NO_HEARTBEAT").is_some() {
    // rust: return;
}
    // rust: let Some(endpoint) = horizon_telemetry::endpoint() else {
    // rust: return;
}
    // rust: let spawned = std::thread::Builder::new()
    // rust: .name("Heartbeat".into())
    // rust: .spawn(move || run(&endpoint));
    // rust: match spawned {
    // rust: Ok(handle) => {
    // rust: let _ = PINGER.set(handle.thread().clone());
}
    // rust: Err(e) => log::warn!("Horizon: no live count ping: {e}"),
}
}

/// Whether a world is open to LAN or friends; a change is sent at once.
pub fn set_lan(open: bool) void {
}
    // rust: if LAN.swap(open, Ordering::Relaxed) != open
    // rust: && let Some(pinger) = PINGER.get()
    // rust: {
    // rust: pinger.unpark();
}
}

pub fn run(endpoint: []const u8) void {
}
    // rust: let session = live::session_id();
    // rust: let version = crate::telemetry::version();
    // rust: let mut wait = live::INTERVAL;
    // rust: let mut failed = false;
    // rust: loop {
    // rust: let ping = Ping::new(&session, &version, LAN.load(Ordering::Relaxed));
    // rust: match live::send(endpoint, &ping) {
    // rust: Ok(()) => {
    // rust: wait = live::INTERVAL;
    // rust: failed = false;
}
    // rust: Err(e) => {
                // Said once, not every minute the server is away.
    // rust: if !failed {
    // rust: log::info!("Horizon: the live count ping failed ({e}); trying again later");
}
    // rust: failed = true;
    // rust: wait = (wait * 2).min(MAX_WAIT);
}
}
        // Woken early by `set_lan`; a spurious wake only sends one ping more.
    // rust: std::thread::park_timeout(wait);
}
}
