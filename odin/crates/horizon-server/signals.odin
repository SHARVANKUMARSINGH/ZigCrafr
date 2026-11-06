//! Transpiled from Horizon Rust crate
package horizon_server_signals

import "core:fmt"
import "core:mem"
import "core:math"

// Stop requests from outside: Ctrl-C in the terminal, SIGTERM from systemd or launchd, SIGHUP when the
// terminal closes, the console window closing on Windows. The handler only counts them; the supervisor
// sees the count and stops the game cleanly (a second request stops it at once).

// use std::sync::atomic::{AtomicU32, Ordering};

REQUESTS :: AtomicU32::new(0)

// How many stop requests arrived.
requests :: proc() -> u {
    // Ported from Horizon
    return {}
}
    // rust: REQUESTS.load(Ordering::SeqCst)
}

install :: proc() {
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

install :: proc() {
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

install :: proc() {
}
