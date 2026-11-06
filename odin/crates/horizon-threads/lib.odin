//! Transpiled from Horizon Rust crate
package horizon_threads_lib

import "core:fmt"
import "core:mem"
import "core:math"

// Scheduling hints for the game's threads and its allocator: the few OS calls
// that the other crates, which forbid unsafe code, can't make themselves.

// The game window's boot screen, before wgpu's first frame paints over it.
    // rust: pub mod boot_paint;
    // rust: pub mod heap_census;
    // rust: pub mod jobs;
    // rust: pub mod process_memory;

// use std::sync::{
    // rust: OnceLock,
    // rust: atomic::{AtomicBool, Ordering},
}

// The worker threads the machine offers this process: `available_parallelism`'s
// answer (its share of the cores — CPU affinity, a container's quota), resolved
// once, since it doesn't change under a run and asking again on a later path
// can only disagree with the pools already started. `HORIZON_WORKER_THREADS`
// sets it instead, to cap every pool on a machine whose OS reports more cores
// than a run should take; a value that isn't a positive number is ignored.
// Each pool keeps its own share of the count (the streaming pool all but one,
// far decoration a third of it).
worker_count :: proc() -> u {
    // Ported from Horizon
    return {}
}
COUNT :: OnceLock::new()
    // rust: *COUNT.get_or_init(|| {
    // rust: parse_worker_count(std::env::var("HORIZON_WORKER_THREADS").ok())
    // rust: .unwrap_or_else(|| std::thread::available_parallelism().map_or(1, |n| n.get()))
    // rust: })
}

// `Some(n)` when `value` names a positive count (`" 4 "` counts; `"0"`,
// `"lots"`, a missing variable don't).
parse_worker_count :: proc(value: Maybe(string)) -> O {
    // Ported from Horizon
    return {}
}
    // rust: value?.trim().parse().ok().filter(|&n| n > 0)
}

// Ask the OS to run the calling thread ahead of the process's other
// threads, as vanilla's `MinecraftServer.spin` does for its server thread
// (`Thread.setPriority(8)` when there are more than four processors), so
// world generation and chunk encoding on every other core don't hold a tick
// back (the client asks the same for its render thread, so they don't hold
// a frame back either): user-interactive quality of service on macOS,
// above-normal priority on Windows. Nothing elsewhere: Linux lets an
// unprivileged thread lower its priority but not raise it (and the JVM
// leaves it there too). Whether the OS took it.
favour_current :: proc() -> b {
    // Ported from Horizon
    return {}
}
    // rust: if std::thread::available_parallelism().map_or(1, |n| n.get()) <= 4 {
    // rust: return false;
}
    // rust: favour()
}

favour :: proc() -> b {
    // Ported from Horizon
    return {}
}
    // SAFETY: sets the calling thread's own QoS class; no pointers.
    // rust: unsafe {
    // rust: libc::pthread_set_qos_class_self_np(libc::qos_class_t::QOS_CLASS_USER_INTERACTIVE, 0) == 0
}
}

favour :: proc() -> b {
    // Ported from Horizon
    return {}
}
//     use windows_sys::Win32::System::Threading::{
    // rust: GetCurrentThread, SetThreadPriority, THREAD_PRIORITY_ABOVE_NORMAL,
}
    // SAFETY: GetCurrentThread's pseudo handle needs no closing.
    // rust: unsafe { SetThreadPriority(GetCurrentThread(), THREAD_PRIORITY_ABOVE_NORMAL) != 0 }
}

favour :: proc() -> b {
    // Ported from Horizon
    return {}
}
    // rust: false
}

// The CPU time the calling thread has used, where only an OS call gives it
// precisely. Windows counts it exactly only in cycles of the time-stamp
// counter (`QueryThreadCycleTime`; `GetThreadTimes` moves in scheduler ticks
// of ~15.6 ms), so the counter's rate is measured once against the wall
// clock and cycles convert to time. `None` elsewhere: unix callers read
// `CLOCK_THREAD_CPUTIME_ID` themselves.
thread_cpu :: proc() -> O {
    // Ported from Horizon
    return {}
}
//     use std::{
    // rust: sync::OnceLock,
    // rust: time::{Duration, Instant},
}
//     use windows_sys::Win32::System::{
    // rust: Threading::GetCurrentThread, WindowsProgramming::QueryThreadCycleTime,
}
    // Time-stamp counter cycles per nanosecond.
RATE :: OnceLock::new()
    // rust: let rate = *RATE.get_or_init(|| {
        // SAFETY: RDTSC has no preconditions on x86_64.
    // rust: let tsc = || unsafe { core::arch::x86_64::_rdtsc() };
    // rust: let (wall, start) = (Instant::now(), tsc());
    // rust: std::thread::sleep(Duration::from_millis(20));
    // rust: (tsc() - start) as f64 / wall.elapsed().as_nanos() as f64
    // rust: });
    // rust: let mut cycles = 0;
    // SAFETY: GetCurrentThread's pseudo handle needs no closing; a valid out pointer.
    // rust: if unsafe { QueryThreadCycleTime(GetCurrentThread(), &mut cycles) } == 0 {
    // rust: return None;
}
    // rust: Some(Duration::from_nanos((cycles as f64 / rate) as u64))
}

thread_cpu :: proc() -> O {
    // Ported from Horizon
    return {}
}
    // rust: None
}

// Set once as the game starts, before its helper threads do: they then go
// behind the server thread and the render thread (`behind_server`).
HELPERS_BEHIND :: AtomicBool::new(false)

// How many nice levels a helper thread goes below the process on Linux and Android.
BEHIND :: 10

// From now on, the helper threads that call `behind_server` as they start
// go behind the server thread (a dedicated server's or single player's)
// and the render thread. Call it before they start.
put_helpers_behind :: proc() {
}
    // rust: HELPERS_BEHIND.store(true, Ordering::Relaxed);
}

// Called by a helper thread as it starts (world generation, lighting and
// meshing, a connection's packet writer): work no tick or frame waits for.
// Once `put_helpers_behind` was called, on Linux and Android, where the server and
// render threads can't be raised (`favour_current`), the helper lowers
// itself instead, which an unprivileged thread may: 10 nice levels below
// the process, or, where nice runs out (a game started under nice 10 or
// more), the idle class, which runs the thread only when no ordinary thread
// wants its core. A tick or a frame then gets a core when it starts instead
// of waiting behind them. Nothing elsewhere. Whether the OS took it.
behind_server :: proc() -> b {
    // Ported from Horizon
    return {}
}
    // rust: HELPERS_BEHIND.load(Ordering::Relaxed) && behind()
}

behind :: proc() -> b {
    // Ported from Horizon
    return {}
}
    // SAFETY: these read and set the calling thread's own nice value or
    // policy (who 0, pid 0 is the calling thread on Linux and Android); `param` lives
    // across the call.
    // rust: unsafe {
    // rust: let nice = libc::getpriority(libc::PRIO_PROCESS as _, 0);
    // rust: if nice + BEHIND <= 19 {
    // rust: libc::setpriority(libc::PRIO_PROCESS as _, 0, nice + BEHIND) == 0
    // rust: } else {
    // rust: let param = libc::sched_param { sched_priority: 0 };
    // rust: libc::sched_setscheduler(0, libc::SCHED_IDLE, &param) == 0
}
}
}

behind :: proc() -> b {
    // Ported from Horizon
    return {}
}
    // rust: false
}

// Called by a far terrain thread as it starts (sampling, meshing and decorating
// distant tiles): work the near chunks, the ticks and the frames must never
// wait behind. On Linux and Android that is `behind_server`. On macOS and
// Windows, where `behind_server` changes nothing, the thread lowers itself one
// step: utility quality of service on macOS (background would throttle it to a
// crawl on battery) and below-normal priority on Windows, so the helpers that
// mesh and light the chunks around the player go first. Whether the OS took it.
far_terrain_current :: proc() -> b {
    // Ported from Horizon
    return {}
}
    // rust: far()
}

far :: proc() -> b {
    // Ported from Horizon
    return {}
}
    // rust: behind_server()
}

far :: proc() -> b {
    // Ported from Horizon
    return {}
}
    // SAFETY: sets the calling thread's own QoS class; no pointers.
    // rust: unsafe { libc::pthread_set_qos_class_self_np(libc::qos_class_t::QOS_CLASS_UTILITY, 0) == 0 }
}

far :: proc() -> b {
    // Ported from Horizon
    return {}
}
//     use windows_sys::Win32::System::Threading::{
    // rust: GetCurrentThread, SetThreadPriority, THREAD_PRIORITY_BELOW_NORMAL,
}
    // SAFETY: GetCurrentThread's pseudo handle needs no closing.
    // rust: unsafe { SetThreadPriority(GetCurrentThread(), THREAD_PRIORITY_BELOW_NORMAL) != 0 }
}

// For a far terrain thread that `far_terrain_current` lowered: behind the
// near terrain while it loads (`behind`), and back to the default once it
// is in. Kept at utility quality of service for good, macOS ran the far
// terrain on the efficiency cores long after the near chunks were in, and
// it took minutes to settle. On Linux and Android an unprivileged thread
// can't raise its priority again: it stays behind (`behind_server`), as it
// always has there, and this changes nothing. Whether the OS took it.
far_terrain_behind :: proc(behind: bool) -> b {
    // Ported from Horizon
    return {}
}
    // Both set the class or priority outright: calling again is harmless.
    // rust: if behind { far() } else { far_back() }
}

far_terrain_behind :: proc(_behind: bool) -> b {
    // Ported from Horizon
    return {}
}
    // rust: false
}

far_back :: proc() -> b {
    // Ported from Horizon
    return {}
}
    // SAFETY: sets the calling thread's own QoS class; no pointers.
    // rust: unsafe { libc::pthread_set_qos_class_self_np(libc::qos_class_t::QOS_CLASS_DEFAULT, 0) == 0 }
}

far_back :: proc() -> b {
    // Ported from Horizon
    return {}
}
//     use windows_sys::Win32::System::Threading::{
    // rust: GetCurrentThread, SetThreadPriority, THREAD_PRIORITY_NORMAL,
}
    // SAFETY: GetCurrentThread's pseudo handle needs no closing.
    // rust: unsafe { SetThreadPriority(GetCurrentThread(), THREAD_PRIORITY_NORMAL) != 0 }
}

// Run the calling thread only on a core nothing else wants: work that may
// take seconds and that nothing waits for yet (the stronghold rings while a
// world opens). The idle class on Linux, background quality of service on
// macOS, idle priority on Windows. Whether the OS took it.
idle_current :: proc() -> b {
    // Ported from Horizon
    return {}
}
    // rust: idle()
}

idle :: proc() -> b {
    // Ported from Horizon
    return {}
}
    // rust: let param = libc::sched_param { sched_priority: 0 };
    // SAFETY: sets the calling thread's own policy (pid 0); `param` lives
    // across the call.
    // rust: unsafe { libc::sched_setscheduler(0, libc::SCHED_IDLE, &param) == 0 }
}

idle :: proc() -> b {
    // Ported from Horizon
    return {}
}
    // SAFETY: sets the calling thread's own QoS class; no pointers.
    // rust: unsafe { libc::pthread_set_qos_class_self_np(libc::qos_class_t::QOS_CLASS_BACKGROUND, 0) == 0 }
}

idle :: proc() -> b {
    // Ported from Horizon
    return {}
}
//     use windows_sys::Win32::System::Threading::{
    // rust: GetCurrentThread, SetThreadPriority, THREAD_PRIORITY_IDLE,
}
    // SAFETY: GetCurrentThread's pseudo handle needs no closing.
    // rust: unsafe { SetThreadPriority(GetCurrentThread(), THREAD_PRIORITY_IDLE) != 0 }
}

idle :: proc() -> b {
    // Ported from Horizon
    return {}
}
    // rust: false
}

// How many stop requests (Ctrl-C, SIGTERM, SIGHUP) arrived since `catch_stop_signals`.
stop_requests :: proc() -> u {
    // Ported from Horizon
    return {}
}
    // rust: STOP_REQUESTS.load(std::sync::atomic::Ordering::SeqCst)
}

STOP_REQUESTS :: std::sync::atomic::AtomicU32::new(0)

// Count stop requests from outside instead of dying on them: vanilla's "Client Shutdown Thread"
// (`Main.java`) halts the integrated server when the JVM shuts down, and the JVM does that on
// these signals, so a killed game still saves. The caller's event loop turns the first request
// into a normal quit; a second one (the save is stuck) ends the process at once.
catch_stop_signals :: proc() {
}
    // rust: extern "C" fn handle(_: libc::c_int) {
    // rust: if STOP_REQUESTS.fetch_add(1, Ordering::SeqCst) >= 1 {
            // SAFETY: _exit is async-signal-safe; 130 is the shell's code for a Ctrl-C death.
    // rust: unsafe { libc::_exit(130) }
}
}
    // rust: let handler = handle as extern "C" fn(libc::c_int);
    // rust: for signal in [libc::SIGINT, libc::SIGTERM, libc::SIGHUP] {
        // SAFETY: the handler only touches an atomic and calls _exit, both async-signal-safe.
    // rust: unsafe {
            // A signal ignored from the start stays ignored, as the JVM leaves it (`nohup`'s SIGHUP:
            // a server started that way outlives its terminal).
    // rust: if libc::signal(signal, handler as libc::sighandler_t) == libc::SIG_IGN {
    // rust: libc::signal(signal, libc::SIG_IGN);
}
}
}
}

// Windows and the other systems keep their default: a closed window is a `CloseRequested`.
catch_stop_signals :: proc() {
}

// The game's global allocator (`#[global_allocator]` in its `main.rs`).
// World generation, meshing and the tick allocate and free small blocks on
// every worker at once; the system heaps serialise them (Windows' heap was
// 16% of a chunk's generation time), mimalloc keeps a heap per thread.
    // rust: pub type Allocator = mimalloc::MiMalloc;
// The game's mimalloc allocator.
ALLOCATOR :: mimalloc::MiMalloc

// The global allocator of a build with the `alloc-census` feature: live
// heap bytes by startup step and thread, for `horizon-ctl memory`.
    // rust: pub use heap_census::CensusAllocator;
// Whether this build counts the heap by tag (feature `alloc-census`).
HEAP_CENSUS :: cfg!(feature = "alloc-census")
// Tag the calling thread's allocations `name` while the guard lives, in a
// build that counts the heap ([`HEAP_CENSUS`]); nothing otherwise.
heap_tag :: proc(name: ^'static str) -> O {
    // Ported from Horizon
    return {}
}
    // rust: HEAP_CENSUS.then(|| heap_census::tag(name))
}

// `mi_option_purge_delay` in mimalloc.h (index 15 in v2 and v3); the bindings
// don't name it.
PURGE_DELAY :: 15

// Set the allocator up, first thing in `main`: free pages go back to the OS
// at once instead of a second later. With mimalloc's delay the game held a
// quarter more memory than with the system heap; without it a few percent,
// and generation keeps most of its speed-up.
configure_allocator :: proc() {
}
    // SAFETY: sets one integer option, which mimalloc reads at each purge.
    // rust: unsafe {
    // rust: libmimalloc_sys::mi_option_set(PURGE_DELAY, 0);
}
}

// The bytes the allocator has committed now and at its peak (mimalloc's
// process info), for `horizon-ctl memory`.
allocator_commit :: proc() -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let mut info = [0usize; 8];
    // rust: let [
    // rust: elapsed,
    // rust: user,
    // rust: system,
    // rust: rss,
    // rust: peak_rss,
    // rust: commit,
    // rust: peak_commit,
    // rust: faults,
    // rust: ] = &mut info;
    // SAFETY: writes eight integers through pointers to them.
    // rust: unsafe {
    // rust: libmimalloc_sys::mi_process_info(
    // rust: elapsed,
    // rust: user,
    // rust: system,
    // rust: rss,
    // rust: peak_rss,
    // rust: commit,
    // rust: peak_commit,
    // rust: faults,
    // rust: );
}
    // rust: (info[5], info[6])
}

// Give back to the OS the memory the allocator holds free, after something
// large was dropped: mimalloc's free pages, then the system heap's, which
// native libraries still use: glibc keeps freed pages in the arena of the
// thread that allocated them, and macOS in its zones until memory runs short.
release_free_memory :: proc() {
}
    // SAFETY: frees only pages no allocation uses (this thread's heap, shared arenas).
    // rust: unsafe {
    // rust: libmimalloc_sys::mi_collect(true);
}
    // rust: release();
}

release :: proc() {
}
    // SAFETY: returns free heap pages of every arena to the OS; no live
    // allocation moves.
    // rust: unsafe {
    // rust: libc::malloc_trim(0);
}
}

release :: proc() {
}
    // rust: unsafe extern "C" {
malloc_zone_pressure_relief :: proc(zone: *mut std::ffi::c_void, goal: uint) -> u {
    // Ported from Horizon
    return {}
}
}
    // SAFETY: a null zone means every zone and a goal of 0 as much as it can;
    // it frees only pages no allocation uses.
    // rust: unsafe {
    // rust: malloc_zone_pressure_relief(std::ptr::null_mut(), 0);
}
}

release :: proc() {
}

// The REPARSE_DATA_BUFFER of a mount point naming `name` (UTF-16, `\??\` prefixed). The length
// fields are 16 bits: a name too long for them is an error, so the caller copies instead.
mount_point_buffer :: proc(name: ^[u16]) -> s {
    // Ported from Horizon
    return {}
}
IO_REPARSE_TAG_MOUNT_POINT :: 0xA000_0003
    // rust: let too_long = || std::io::Error::from(std::io::ErrorKind::InvalidInput);
    // rust: let name_bytes = u16::try_from(name.len() * 2).map_err(|_| too_long())?;
    // Substitute name, its NUL, then an empty print name and its NUL.
    // rust: let print_offset = name_bytes.checked_add(2).ok_or_else(too_long)?;
    // rust: let data_len = name_bytes.checked_add(12).ok_or_else(too_long)?;
    // rust: let mut buffer = Vec::with_capacity(16 + name.len() * 2 + 4);
    // rust: buffer.extend(IO_REPARSE_TAG_MOUNT_POINT.to_le_bytes());
    // rust: buffer.extend(data_len.to_le_bytes());
    // rust: buffer.extend(0u16.to_le_bytes());
    // rust: buffer.extend(0u16.to_le_bytes());
    // rust: buffer.extend(name_bytes.to_le_bytes());
    // rust: buffer.extend(print_offset.to_le_bytes());
    // rust: buffer.extend(0u16.to_le_bytes());
    // rust: buffer.extend(name.iter().flat_map(|c| c.to_le_bytes()));
    // rust: buffer.extend([0; 4]);
    // rust: Ok(buffer)
}

// A directory junction, which Windows creates without privileges (a directory symlink needs
// developer mode): the resource pack overlay links its untouched directories with them.
junction :: proc(target: ^std::path::Path, at: ^std::path::Path) -> s {
    // Ported from Horizon
    return {}
}
    // What `mklink /J` does, without its ~100 ms `cmd` process per directory: an empty
    // directory given a mount point reparse point (REPARSE_DATA_BUFFER) naming the target.
//     use std::os::windows::{ffi::OsStrExt, fs::OpenOptionsExt, io::AsRawHandle};
FILE_FLAG_OPEN_REPARSE_POINT :: 0x0020_0000
FILE_FLAG_BACKUP_SEMANTICS :: 0x0200_0000
FSCTL_SET_REPARSE_POINT :: 0x0009_00A4
    // rust: let target = std::path::absolute(target)?;
    // rust: let target = target.as_os_str().to_string_lossy();
    // rust: let target = target.strip_prefix(r"\\?\").unwrap_or(&target);
    // rust: let name: Vec<u16> = std::ffi::OsStr::new(&format!(r"\??\{target}"))
    // rust: .encode_wide()
    // rust: .collect();
    // rust: let buffer = mount_point_buffer(&name)?;
    // rust: std::fs::create_dir(at)?;
    // rust: let set = std::fs::OpenOptions::new()
    // rust: .write(true)
    // rust: .custom_flags(FILE_FLAG_OPEN_REPARSE_POINT | FILE_FLAG_BACKUP_SEMANTICS)
    // rust: .open(at)
    // rust: .and_then(|dir| {
    // rust: let mut returned = 0;
            // SAFETY: a live directory handle, and `buffer` outlives the call.
    // rust: let ok = unsafe {
    // rust: windows_sys::Win32::System::IO::DeviceIoControl(
    // rust: dir.as_raw_handle(),
    // rust: FSCTL_SET_REPARSE_POINT,
    // rust: buffer.as_ptr().cast(),
    // rust: buffer.len() as u32,
    // rust: std::ptr::null_mut(),
    // rust: 0,
    // rust: &mut returned,
    // rust: std::ptr::null_mut(),
    // rust: )
}
    // rust: if ok == 0 {
    // rust: Err(std::io::Error::last_os_error())
    // rust: } else {
    // rust: Ok(())
}
    // rust: });
    // rust: if set.is_err() {
    // rust: let _ = std::fs::remove_dir(at);
}
    // rust: set
}

// Keep this process's standard handles out of the processes it starts. Windows hands a child
// every inheritable handle of its parent, not only the three standard handles it is given
// (CreateProcessW with bInheritHandles, as `std::process::Command` starts it). horizon-ctl's own
// standard handles are inheritable when its caller gave it pipes (a script that reads its output,
// an MCP client), so the game it launches would hold the caller's pipe open for its whole life and
// the caller, waiting for the end of horizon-ctl's output, would wait until the game quits. A
// child given `Stdio::inherit()` still gets them: `Command` duplicates the handles it passes.
// Unix needs none of this: a child's 0-2 are replaced and the rest are close-on-exec.
keep_stdio_from_children :: proc() {
}
//     use windows_sys::Win32::Foundation::{
    // rust: HANDLE_FLAG_INHERIT, INVALID_HANDLE_VALUE, SetHandleInformation,
}
//     use windows_sys::Win32::System::Console::{
    // rust: GetStdHandle, STD_ERROR_HANDLE, STD_INPUT_HANDLE, STD_OUTPUT_HANDLE,
}
    // rust: for which in [STD_INPUT_HANDLE, STD_OUTPUT_HANDLE, STD_ERROR_HANDLE] {
        // SAFETY: GetStdHandle has no preconditions; SetHandleInformation only gets a handle this
        // process holds, and when it fails (no console, a pseudo-handle) the handle stays as it was.
    // rust: unsafe {
    // rust: let handle = GetStdHandle(which);
    // rust: if !handle.is_null() && handle != INVALID_HANDLE_VALUE {
    // rust: SetHandleInformation(handle, HANDLE_FLAG_INHERIT, 0);
}
}
}
}

    // rust: mod tests {
    // Without `HORIZON_WORKER_THREADS`, the count is the machine's.
worker_count_defaults_to_the_machine :: proc() {
}
    // rust: if std::env::var_os("HORIZON_WORKER_THREADS").is_some() {
    // rust: return;
}
    // rust: let machine = std::thread::available_parallelism().map_or(1, |n| n.get());
    // rust: assert_eq!(super::worker_count(), machine);
}

    // Only a positive number overrides the machine's count.
worker_count_override_parses :: proc() {
}
    // rust: for (value, parsed) in [
    // rust: (None, None),
    // rust: (Some("4"), Some(4)),
    // rust: (Some(" 4 "), Some(4)),
    // rust: (Some("0"), None),
    // rust: (Some("-2"), None),
    // rust: (Some("lots"), None),
    // rust: (Some(""), None),
    // rust: ] {
    // rust: assert_eq!(super::parse_worker_count(value.map(String::from)), parsed);
}
}

    // After it, this process's standard output is no longer handed to the processes it starts.
standard_handles_stay_out_of_children :: proc() {
}
//         use windows_sys::Win32::Foundation::{
    // rust: GetHandleInformation, HANDLE_FLAG_INHERIT, INVALID_HANDLE_VALUE,
}
//         use windows_sys::Win32::System::Console::{GetStdHandle, STD_OUTPUT_HANDLE};
    // rust: super::keep_stdio_from_children();
        // SAFETY: reads the flags of this process's own standard output handle.
    // rust: unsafe {
    // rust: let handle = GetStdHandle(STD_OUTPUT_HANDLE);
    // rust: let mut flags = 0;
    // rust: if !handle.is_null()
    // rust: && handle != INVALID_HANDLE_VALUE
    // rust: && GetHandleInformation(handle, &mut flags) != 0
    // rust: {
    // rust: assert_eq!(flags & HANDLE_FLAG_INHERIT, 0);
}
}
}

    // The hint holds on the platforms that take it.
favouring_a_thread_takes_where_the_os_allows_it :: proc() {
}
    // rust: let took = std::thread::spawn(super::favour).join().unwrap();
    // rust: assert_eq!(took, cfg!(any(target_vendor = "apple", windows)));
    // rust: std::thread::spawn(|| {
    // rust: assert!(super::favour());
    // rust: let mut class = libc::qos_class_t::QOS_CLASS_UNSPECIFIED;
    // rust: let mut relative = 0;
            // SAFETY: reads the calling thread's own QoS class into locals.
    // rust: let read = unsafe {
    // rust: libc::pthread_get_qos_class_np(libc::pthread_self(), &mut class, &mut relative)
}
    // rust: assert_eq!(read, 0);
    // rust: assert!(matches!(
    // rust: class,
    // rust: libc::qos_class_t::QOS_CLASS_USER_INTERACTIVE
    // rust: ));
    // rust: })
    // rust: .join()
    // rust: .unwrap();
}

    // A helper goes behind only once a dedicated server asks for it, and
    // then, on Linux and Android, 10 nice levels below the process or in the idle class.
helpers_go_behind_only_when_asked :: proc() {
}
    // rust: assert!(!std::thread::spawn(super::behind_server).join().unwrap());
    // rust: super::put_helpers_behind();
    // rust: std::thread::spawn(|| {
            // SAFETY: reads the calling thread's own nice value.
    // rust: let before = unsafe { libc::getpriority(libc::PRIO_PROCESS as _, 0) };
    // rust: assert!(super::behind_server());
            // SAFETY: reads the calling thread's own nice value and policy.
    // rust: let (after, policy) = unsafe {
    // rust: (
    // rust: libc::getpriority(libc::PRIO_PROCESS as _, 0),
    // rust: libc::sched_getscheduler(0),
    // rust: )
}
    // rust: if before + super::BEHIND <= 19 {
    // rust: assert_eq!(after, before + super::BEHIND);
    // rust: } else {
    // rust: assert_eq!(policy, libc::SCHED_IDLE);
}
    // rust: })
    // rust: .join()
    // rust: .unwrap();
    // rust: assert!(!std::thread::spawn(super::behind_server).join().unwrap());
}

    // The idle hint holds on the three platforms.
idling_a_thread_takes :: proc() {
}
    // rust: let took = std::thread::spawn(super::idle_current).join().unwrap();
    // rust: assert_eq!(
    // rust: took,
    // rust: cfg!(any(target_os = "linux", target_vendor = "apple", windows))
    // rust: );
    // rust: std::thread::spawn(|| {
    // rust: assert!(super::idle_current());
            // SAFETY: reads the calling thread's own policy.
    // rust: assert_eq!(unsafe { libc::sched_getscheduler(0) }, libc::SCHED_IDLE);
    // rust: })
    // rust: .join()
    // rust: .unwrap();
}

    // The option set is the purge delay: mimalloc v3's default for it is
    // 1000 ms, and it is 0 once configured.
configuring_the_allocator_purges_at_once :: proc() {
}
        // SAFETY: reads and sets one integer option.
    // rust: let get = || unsafe { libmimalloc_sys::mi_option_get(super::PURGE_DELAY) };
    // rust: if std::env::var_os("MIMALLOC_PURGE_DELAY").is_none() {
    // rust: assert_eq!(get(), 1000);
}
    // rust: super::configure_allocator();
    // rust: assert_eq!(get(), 0);
}
}

    // rust: mod junction_tests {
mount_point_buffer_layout :: proc() {
}
    // rust: let name: Vec<u16> = r"\??\C:\a".encode_utf16().collect();
    // rust: let bytes = u16::try_from(name.len() * 2).unwrap();
    // rust: let buffer = super::mount_point_buffer(&name).unwrap();
    // rust: assert_eq!(buffer[..4], 0xA000_0003u32.to_le_bytes());
    // rust: assert_eq!(buffer[4..6], (bytes + 12).to_le_bytes());
    // rust: assert_eq!(buffer[8..10], 0u16.to_le_bytes());
    // rust: assert_eq!(buffer[10..12], bytes.to_le_bytes());
    // rust: assert_eq!(buffer[12..14], (bytes + 2).to_le_bytes());
    // rust: assert_eq!(buffer.len(), 16 + usize::from(bytes) + 4);
        // Past the 8-byte header, the length field counts the rest of the buffer.
    // rust: assert_eq!(usize::from(bytes) + 12, buffer.len() - 8);
}

names_too_long_for_the_length_fields_are_errors :: proc() {
}
        // 32764 units is 65528 bytes: the name fits, its length field sums do not.
    // rust: let name = vec![b'a' as u16; 32_764];
    // rust: assert!(super::mount_point_buffer(&name).is_err());
    // rust: assert!(super::mount_point_buffer(&vec![0; 32_768]).is_err());
    // rust: assert!(super::mount_point_buffer(&[0; 100]).is_ok());
}
}
