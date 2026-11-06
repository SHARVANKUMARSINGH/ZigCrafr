//! Transpiled from Horizon Rust crate
package horizon_server_process

import "core:fmt"
import "core:mem"
import "core:math"

// The programs the server runs. Started by the launcher, the server has no console, and each
// console program it started would open a terminal window on Windows: those open none. Run from
// a terminal, they share it, so what they print still reaches it.
// use std::{ffi::OsStr, process::Command};

command :: proc(program: impl AsRef<OsStr>) -> C {
    // Ported from Horizon
    return {}
}
    // rust: let command = Command::new(program);
    // rust: let command = {
//         use std::os::windows::process::CommandExt;
//         use windows_sys::Win32::System::{Console::GetConsoleWindow, Threading::CREATE_NO_WINDOW};
    // rust: let mut command = command;
        // SAFETY: no arguments; it returns this process's console window or null.
    // rust: if unsafe { GetConsoleWindow() }.is_null() {
    // rust: command.creation_flags(CREATE_NO_WINDOW);
}
    // rust: command
}
    // rust: command
}
