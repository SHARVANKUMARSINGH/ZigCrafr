//! Transpiled from Horizon Rust crate
package horizon_threads_process_memory

import "core:fmt"
import "core:mem"
import "core:math"

// Read-only process memory diagnostics.
// The process's memory counters.
counters :: proc() -> O {
    // Ported from Horizon
    return {}
}
//     use windows_sys::Win32::System::ProcessStatus::{
    // rust: K32GetProcessMemoryInfo, PROCESS_MEMORY_COUNTERS,
}
//     use windows_sys::Win32::System::Threading::GetCurrentProcess;
    // rust: let size = std::mem::size_of::<PROCESS_MEMORY_COUNTERS>() as u32;
    // SAFETY: all-zero is a valid value of this plain C struct, and the call writes at most `size`
    // bytes into it; the current process's pseudo-handle needs no closing.
    // rust: unsafe {
    // rust: let mut counters: PROCESS_MEMORY_COUNTERS = std::mem::zeroed();
    // rust: counters.cb = size;
    // rust: (K32GetProcessMemoryInfo(GetCurrentProcess(), &mut counters, size) != 0).then_some(counters)
}
}

// The memory this process holds in RAM, in bytes.
resident_bytes :: proc() -> O {
    // Ported from Horizon
    return {}
}
    // rust: Some(counters()?.WorkingSetSize as u64)
}

// The memory this process holds in RAM, in bytes.
resident_bytes :: proc() -> O {
    // Ported from Horizon
    return {}
}
    // rust: let statm = std::fs::read_to_string("/proc/self/statm").ok()?;
    // rust: let pages: u64 = statm.split_whitespace().nth(1)?.parse().ok()?;
    // SAFETY: reads one system constant.
    // rust: let page = unsafe { libc::sysconf(libc::_SC_PAGESIZE) };
    // rust: Some(pages * u64::try_from(page).ok()?)
}

// The memory this process holds in RAM, in bytes.
resident_bytes :: proc() -> O {
    // Ported from Horizon
    return {}
}
    // rust: let size = std::mem::size_of::<libc::proc_taskinfo>() as libc::c_int;
    // SAFETY: all-zero is a valid value of this plain C struct, and the call writes at most `size`
    // bytes into it.
    // rust: unsafe {
    // rust: let mut info: libc::proc_taskinfo = std::mem::zeroed();
    // rust: let written = libc::proc_pidinfo(
    // rust: libc::getpid(),
    // rust: libc::PROC_PIDTASKINFO,
    // rust: 0,
    // rust: (&raw mut info).cast(),
    // rust: size,
    // rust: );
    // rust: (written == size).then_some(info.pti_resident_size)
}
}

// The memory this process holds in RAM, in bytes: not known on this system.
    // rust: windows,
    // rust: target_os = "linux",
    // rust: target_os = "android",
    // rust: target_vendor = "apple"
    // rust: )))]
resident_bytes :: proc() -> O {
    // Ported from Horizon
    return {}
}
    // rust: None
}

    // rust: mod tests {
//     use super::*;

touched_memory_counts_as_resident :: proc() {
}
SIZE :: 256 << 20
    // rust: let before = resident_bytes().unwrap();
    // rust: let block = vec![1u8; SIZE];
    // rust: let during = resident_bytes().unwrap();
    // rust: std::hint::black_box(&block);
    // rust: assert!(
    // rust: during >= before + SIZE as u64 / 2,
    // rust: "{before} then {during} bytes"
    // rust: );
}
}
