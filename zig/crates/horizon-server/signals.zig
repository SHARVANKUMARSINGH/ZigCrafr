//! Transpiled from Horizon Rust crate
//! Module: horizon-server_signals
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Stop requests from outside: Ctrl-C in the terminal, SIGTERM from systemd or launchd, SIGHUP when the
//! terminal closes, the console window closing on Windows. The handler only counts them; the supervisor
//! sees the count and stops the game cleanly (a second request stops it at once).

// use std::sync::atomic::{AtomicU32, Ordering};

pub const REQUESTS: AtomicU32 = AtomicU32::new(0);

/// How many stop requests arrived.
pub fn requests() u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: REQUESTS.load(Ordering::SeqCst)
}

pub fn install() void {
}
    // rust: extern "C" fn handle(_: libc::c_int) {
    // rust: REQUESTS.fetch_add(1, Ordering::SeqCst);
}
    // rust: let handler = handle as extern "C" fn(libc::c_int);
    // rust: for signal in [libc::SIGINT, libc::SIGTERM, libc::SIGHUP] {
        // SAFETY: the handler only increments an atomic, which is async-signal-safe.
    // rust: unsafe {
    // rust: libc::signal(signal, handler as libc::sighandler_t);
}
}
}

pub fn install() void {
}
    // rust: unsafe extern "system" fn handle(_: u32) -> windows_sys::core::BOOL {
    // rust: REQUESTS.fetch_add(1, Ordering::SeqCst);
    // rust: 1
}
    // SAFETY: the handler only increments an atomic; it stays valid for the life of the process.
    // rust: unsafe {
    // rust: windows_sys::Win32::System::Console::SetConsoleCtrlHandler(Some(handle), 1);
}
}

pub fn install() void {
}
