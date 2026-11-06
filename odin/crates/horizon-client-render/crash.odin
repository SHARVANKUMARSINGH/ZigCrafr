//! Transpiled from Horizon Rust crate
package horizon_client_render_crash

import "core:fmt"
import "core:mem"
import "core:math"

// Crash reports, laid out like vanilla's CrashReport.getFriendlyReport: a comment, the time,
// a description, the error with its stack, then the details of the game and the machine.
// Written to `crash-reports/crash-<yyyy-MM-dd_HH.mm.ss>-client.txt` in the game folder when
// the main thread panics or `main` gets an error back. It leaves the machine only scrubbed, and
// only if the player allows crash reports (`telemetry`).
// use std::cell::{Cell, RefCell};
// use std::fmt::Write as _;
// use std::path::{Path, PathBuf};
// use std::sync::Mutex;
// use std::sync::atomic::{AtomicBool, Ordering};

// use chrono::{DateTime, Local};

// What the game is doing, set as it goes: graphics adapter, settings, packs, world.
DETAILS :: Mutex::new(Vec::new())
REPORTED :: AtomicBool::new(false)

    // rust: thread_local! {
    // How many `contain` calls this thread is inside.
CONTAINED :: const { Cell::new(0) }
    // The message of the last panic `contain` caught on this thread, from the hook.
CAUGHT :: const { RefCell::new(None) }
    // The native mod hook this thread is inside, for the panic hook to name.
IN_NATIVE_MOD :: const { Cell::new(None) }
}

// A call into one hook of a native mod.
NativeModCall :: struct {
    // The mod's `[mod] id`, None in a build that didn't name its mods.
    id: Maybe(^'static str),
    // Its place in dispatch order, which names it then.
    index: uint,
    hook: ^'static str,
}

// Marks this thread as inside `call` until the guard drops, which also happens while a panic
// unwinds. A hook called from a hook is named by the inner call.
enter_native_mod :: proc(call: NativeModCall) -> N {
    // Ported from Horizon
    return {}
}
    // rust: NativeModGuard {
    // rust: outer: IN_NATIVE_MOD.with(|c| c.replace(Some(call))),
}
}

// Puts back the call that `enter_native_mod` found.
NativeModGuard :: struct {
    outer: Maybe(NativeModCall),
}

    // rust: impl Drop for NativeModGuard {
drop :: proc(self: ^Self) {
}
    // rust: IN_NATIVE_MOD.with(|c| c.set(self.outer));
}
}

// `message`, with the native mod hook this thread is inside, if any.
attributed :: proc(message: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: match IN_NATIVE_MOD.with(Cell::get) {
    // rust: Some(NativeModCall {
    // rust: id: Some(id), hook, ..
    // rust: }) => format!("{message}\nin native mod {id}, hook {hook}"),
    // rust: Some(NativeModCall {
    // rust: id: None,
    // rust: index,
    // rust: hook,
    // rust: }) => format!("{message}\nin native mod #{index}, hook {hook}"),
    // rust: None => message,
}
}

// Runs `f`, and returns a panic in it as an error with the panic's message instead of letting
// it end the game. For work that is not the game's own and whose failure the caller recovers
// from, such as handing a shader pack's programs to the GPU driver's compiler: the panic goes
// to the log with its stack, and no crash report is made for it.
    // rust: pub fn contain<T>(f: impl FnOnce() -> T) -> Result<T, String> {
    // rust: CONTAINED.with(|c| c.set(c.get() + 1));
    // rust: let result = std::panic::catch_unwind(std::panic::AssertUnwindSafe(f));
    // rust: CONTAINED.with(|c| c.set(c.get() - 1));
    // rust: result.map_err(|payload| {
    // rust: CAUGHT
    // rust: .with(|c| c.borrow_mut().take())
    // rust: .unwrap_or_else(|| payload_text(&*payload))
    // rust: })
}

// For the hook: a panic inside `contain` is logged with its stack and kept for `contain` to
// return. False for any other panic.
contained_panic :: proc(info: ^std::panic::PanicHookInfo) -> b {
    // Ported from Horizon
    return {}
}
    // rust: if CONTAINED.with(Cell::get) == 0 {
    // rust: return false;
}
    // rust: let message = panic_message(info);
    // rust: let stack = stack_lines(
    // rust: &std::backtrace::Backtrace::force_capture().to_string(),
    // rust: true,
    // rust: );
    // rust: log::error!(
    // rust: "Recovered from an error: {message}\n{}",
    // rust: stack
    // rust: .lines()
    // rust: .map(|l| format!("\tat {l}"))
    // rust: .collect::<Vec<_>>()
    // rust: .join("\n")
    // rust: );
    // rust: CAUGHT.with(|c| *c.borrow_mut() = Some(message));
    // rust: true
}

// Sets one line of the report's details (replacing the last value under `key`).
set_detail :: proc(key: ^'static str, value: impl Into<string>) {
}
    // rust: let mut details = DETAILS.lock().unwrap_or_else(|e| e.into_inner());
    // rust: let value = value.into();
    // rust: match details.iter_mut().find(|(k, _)| *k == key) {
    // rust: Some(entry) => entry.1 = value,
    // rust: None => details.push((key, value)),
}
}

clear_detail :: proc(key: ^'static str) {
}
    // rust: DETAILS
    // rust: .lock()
    // rust: .unwrap_or_else(|e| e.into_inner())
    // rust: .retain(|(k, _)| *k != key);
}

details :: proc() -> V {
    // Ported from Horizon
    return {}
}
    // rust: DETAILS.lock().unwrap_or_else(|e| e.into_inner()).clone()
}

// Vanilla picks a line from a list of jokes; these only say what happened.
    // rust: const COMMENTS: &[&str] = &[
    // rust: "Something went wrong.",
    // rust: "The game stopped here.",
    // rust: "This should not have happened.",
    // rust: "Details below.",
    // rust: ];

// One crash, ready to be written.
Report :: struct {
    time: DateTime<Local>,
    description: string,
    // The error's message, first line of the stack section.
    error: string,
    // Where it happened and how it got there: one frame a line (`function (file:line:col)`).
    stack: string,
    thread: string,
    // `client` or `server`, the end of the file name.
    side: ^'static str,
    details: Vec<(string,
    log: [dynamic]string,
}

// `crash-2026-10-14_09.05.07-client.txt`
file_name :: proc(time: ^DateTime<Local>, side: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: format!("crash-{}-{side}.txt", time.format("%Y-%m-%d_%H.%M.%S"))
}

    // rust: impl Report {
    // The report's text.
text :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let comment = COMMENTS[self.time.timestamp().rem_euclid(COMMENTS.len() as i64) as usize];
    // rust: let mut out = String::new();
    // rust: let _ = writeln!(out, "---- Horizon Crash Report ----");
    // rust: let _ = writeln!(out, "// {comment}\n");
    // rust: let _ = writeln!(out, "Time: {}", self.time.format("%Y-%m-%d %H:%M:%S"));
    // rust: let _ = writeln!(out, "Description: {}\n", self.description);
    // rust: let _ = writeln!(out, "{}", self.error);
    // rust: for line in self.stack.lines() {
    // rust: let _ = writeln!(out, "\tat {line}");
}
    // rust: let _ = writeln!(
    // rust: out,
    // rust: "\n\nA detailed walkthrough of the error, its code path and all known details is as follows:"
    // rust: );
    // rust: let _ = writeln!(out, "{}\n", "-".repeat(87));
    // rust: let _ = writeln!(out, "-- Head --");
    // rust: let _ = writeln!(out, "Thread: {}\n", self.thread);
    // rust: let _ = writeln!(out, "-- System Details --");
    // rust: let _ = writeln!(out, "Details:");
    // rust: for (key, value) in &self.details {
    // rust: let _ = writeln!(out, "\t{key}: {value}");
}
    // rust: let _ = writeln!(out, "\n-- Last {} log lines --", self.log.len());
    // rust: for line in &self.log {
    // rust: let _ = writeln!(out, "{line}");
}
    // rust: out
}

    // Writes the report in `home/crash-reports` and returns its path.
save :: proc(self: ^Self, home: ^Path) -> s {
    // Ported from Horizon
    return {}
}
    // rust: let dir = crate::logging::crash_reports_dir(home);
    // rust: std::fs::create_dir_all(&dir)?;
    // rust: let path = dir.join(file_name(&self.time, self.side));
    // rust: std::fs::write(&path, self.text())?;
    // rust: Ok(path)
}
}

// The release this binary is (`v0.2.3`); a nightly's label (`Nightly 2026-10-28 · 0c02067`); for a
// release from before 0.2, its tag and the client's crate version; for a build from source, that
// version alone.
version :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: if let Some(label) = horizon_core::release::nightly_label() {
    // rust: return label;
}
    // rust: let version = env!("CARGO_PKG_VERSION");
    // rust: match (horizon_core::release::RELEASE, release_tag()) {
    // rust: (Some(_), Some(tag)) => tag,
    // rust: (None, Some(tag)) => format!("{tag} (client {version})"),
    // rust: (_, None) => version.to_owned(),
}
}

// The release this binary came with: the version release.yml built in (docs/versioning.md), else
// the folder the launcher installed it in, named after the tag (releases from before 0.2). A
// nightly is its version as the launcher installs it (`nightly-2026-10-28-0c02067`).
release_tag :: proc() -> O {
    // Ported from Horizon
    return {}
}
    // rust: if let Some(nightly) = horizon_core::release::nightly_version() {
    // rust: return Some(nightly);
}
    // rust: if let Some(version) = horizon_core::release::RELEASE {
    // rust: return Some(format!("v{version}"));
}
    // rust: let exe = std::env::current_exe().ok()?;
    // rust: let folder = exe.parent()?.file_name()?.to_str()?;
    // rust: (folder.starts_with('v') && folder[1..].starts_with(|c: char| c.is_ascii_digit()))
    // rust: .then(|| folder.to_owned())
}

command_output :: proc(program: string, args: ^[string]) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let out = std::process::Command::new(program)
    // rust: .args(args)
    // rust: .output()
    // rust: .ok()?;
    // rust: let text = String::from_utf8_lossy(&out.stdout).trim().to_owned();
    // rust: (out.status.success() && !text.is_empty()).then_some(text)
}

read :: proc(path: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: std::fs::read_to_string(path).ok()
}

// `PRETTY_NAME` of /etc/os-release and the kernel, or the system's own version string.
operating_system :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: let arch = std::env::consts::ARCH;
    // rust: let version = if cfg!(target_os = "linux") {
    // rust: let name = read("/etc/os-release").and_then(|t| {
    // rust: t.lines()
    // rust: .find_map(|l| l.strip_prefix("PRETTY_NAME="))
    // rust: .map(|v| v.trim_matches('"').to_owned())
    // rust: });
    // rust: let kernel = read("/proc/sys/kernel/osrelease").map(|k| k.trim().to_owned());
    // rust: match (name, kernel) {
    // rust: (Some(n), Some(k)) => Some(format!("{n}, kernel {k}")),
    // rust: (n, k) => n.or(k),
}
    // rust: } else if cfg!(target_os = "macos") {
    // rust: command_output("sw_vers", &["-productVersion"]).map(|v| format!("macOS {v}"))
    // rust: } else if cfg!(windows) {
    // rust: horizon_telemetry::system::windows_version()
    // rust: } else {
    // rust: None
}
    // rust: format!(
    // rust: "{} ({arch}) version {}",
    // rust: std::env::consts::OS,
    // rust: version.unwrap_or_else(|| "unknown".into())
    // rust: )
}

// Logical processors and the CPU's name (`12x AMD Ryzen 5 5600X ...`).
cpu :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: let threads = std::thread::available_parallelism().map_or(0, |n| n.get());
    // rust: let name = if cfg!(target_os = "linux") {
    // rust: read("/proc/cpuinfo").and_then(|t| horizon_telemetry::system::linux_cpu_name(&t))
    // rust: } else if cfg!(target_os = "macos") {
    // rust: command_output("sysctl", &["-n", "machdep.cpu.brand_string"])
    // rust: } else if cfg!(windows) {
    // rust: horizon_telemetry::system::windows_cpu()
    // rust: } else {
    // rust: std::env::var("PROCESSOR_IDENTIFIER").ok()
}
    // rust: format!(
    // rust: "{threads}x {}",
    // rust: name.unwrap_or_else(|| std::env::consts::ARCH.into())
    // rust: )
}

// Total memory and what this process uses, in MiB where the system says.
memory :: proc() -> S {
    // Ported from Horizon
    return {}
}
MIB :: 1024 * 1024
    // rust: let kib = |text: &str, key: &str| -> Option<u64> {
    // rust: text.lines()
    // rust: .find(|l| l.starts_with(key))?
    // rust: .split_whitespace()
    // rust: .nth(1)?
    // rust: .parse()
    // rust: .ok()
}
    // rust: let (total, used) = if cfg!(target_os = "linux") {
    // rust: (
    // rust: read("/proc/meminfo")
    // rust: .and_then(|t| kib(&t, "MemTotal:"))
    // rust: .map(|k| k * 1024),
    // rust: read("/proc/self/status")
    // rust: .and_then(|t| kib(&t, "VmRSS:"))
    // rust: .map(|k| k * 1024),
    // rust: )
    // rust: } else if cfg!(target_os = "macos") {
    // rust: (
    // rust: command_output("sysctl", &["-n", "hw.memsize"]).and_then(|v| v.parse().ok()),
    // rust: None,
    // rust: )
    // rust: } else if cfg!(windows) {
    // rust: (
    // rust: command_output(
    // rust: "powershell",
    // rust: &[
    // rust: "-NoProfile",
    // rust: "-Command",
    // rust: "(Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory",
    // rust: ],
    // rust: )
    // rust: .and_then(|v| v.parse().ok()),
    // rust: None,
    // rust: )
    // rust: } else {
    // rust: (None, None)
}
    // rust: match (total, used) {
    // rust: (Some(t), Some(u)) => format!(
    // rust: "{} MiB used by the game, {} MiB installed",
    // rust: u / MIB,
    // rust: t / MIB
    // rust: ),
    // rust: (Some(t), None) => format!("{} MiB installed", t / MIB),
    // rust: _ => "unknown".into(),
}
}

// The report's details: Horizon's and the machine's, then what the game set as it ran. A dedicated
// server renders nothing: it leaves out the render settings it read from options.txt.
system_details :: proc(side: string) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut out = vec![
    // rust: ("Horizon Version".to_owned(), version()),
    // rust: (
    // rust: "Minecraft Version".to_owned(),
    // rust: horizon_core::VANILLA_VERSION.to_owned(),
    // rust: ),
    // rust: ("Operating System".to_owned(), operating_system()),
    // rust: ("CPU".to_owned(), cpu()),
    // rust: ("Memory".to_owned(), memory()),
    // rust: ];
    // rust: out.extend(
    // rust: details()
    // rust: .into_iter()
    // rust: .filter(|(k, _)| side != "server" || *k != "Render Settings")
    // rust: .map(|(k, v)| (k.to_owned(), v)),
    // rust: );
    // rust: out
}

// The thread's name as vanilla's reports say it: the main thread is the client's "Render thread"
// and the dedicated server's "Server thread".
thread_name :: proc(side: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let current = std::thread::current();
    // rust: match current.name() {
    // rust: Some("main") | None if side == "server" => "Server thread".into(),
    // rust: Some("main") | None => "Render thread".into(),
    // rust: Some(name) => name.into(),
}
}

// What starts the stderr line naming a saved report, the path follows: the Launch API's
// promise to launchers (docs/api/launch.md), so it never changes within a line of that API.
SAVED_LINE :: "Horizon: crash report saved to "

// Writes the report and tells where it is; the log gets the error too.
deliver :: proc(home: ^Path, report: Report) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if REPORTED.swap(true, Ordering::SeqCst) {
    // rust: return None;
}
    // The panic is on stderr already: the stack goes to the log only.
    // rust: crate::logging::write_only(
    // rust: log::Level::Error,
    // rust: &format!(
    // rust: "Horizon crashed: {}\n{}",
    // rust: report.error,
    // rust: report
    // rust: .stack
    // rust: .lines()
    // rust: .map(|l| format!("\tat {l}"))
    // rust: .collect::<Vec<_>>()
    // rust: .join("\n")
    // rust: ),
    // rust: );
    // rust: crate::logging::flush();
    // rust: crate::telemetry::keep_crash(home, &report);
    // A player of a shared game folder (`--player-dir`) finds the report beside its own log.
    // rust: match report.save(crate::logging::player_dir_override().unwrap_or(home)) {
    // rust: Ok(path) => {
    // rust: eprintln!("{SAVED_LINE}{}", path.display());
    // rust: Some(path)
}
    // rust: Err(e) => {
    // rust: eprintln!("Horizon: could not save a crash report: {e}");
    // rust: eprintln!("{}", report.text());
    // rust: None
}
}
}

// The report for a hung server tick, written by the watchdog thread
// (`ServerWatchdog`): the stuck thread's stack is not available to Rust, so
// the report carries none.
report_watchdog :: proc(home: ^Path, side: ^'static str, message: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: deliver(
    // rust: home,
    // rust: Report {
    // rust: time: Local::now(),
    // rust: description: "Watching Server".into(),
    // rust: error: format!("{message} (Watching Server)"),
    // rust: stack: String::new(),
    // rust: thread: thread_name(side),
    // rust: side,
    // rust: details: system_details(side),
    // rust: log: crate::logging::recent_lines(),
    // rust: },
    // rust: )
}

payload_text :: proc(payload: ^(dyn std::any::Any + Send) {
}
    // rust: payload
    // rust: .downcast_ref::<&str>()
    // rust: .map(|s| s.to_string())
    // rust: .or_else(|| payload.downcast_ref::<String>().cloned())
    // rust: .unwrap_or_else(|| "Box<dyn Any>".into())
}

panic_message :: proc(info: ^std::panic::PanicHookInfo) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let text = payload_text(info.payload());
    // rust: attributed(match info.location() {
    // rust: Some(at) => format!("panicked at {at}:\n{text}"),
    // rust: None => format!("panicked:\n{text}"),
    // rust: })
}

// A `std::backtrace` as one line a frame, `function (file:line:col)`. Captured in a panic hook
// (`from_panic`), it starts at the frame that panicked: the hook's and the panic machinery's
// frames go. Paths inside the workspace lose the build machine's prefix.
stack_lines :: proc(backtrace: string, from_panic: bool) -> S {
    // Ported from Horizon
    return {}
}
    // The workspace as it was on the machine that built this binary (it need not exist here).
    // A report names workspace files the same way on every host, whatever
    // separator the build machine used.
    // rust: let manifest = env!("CARGO_MANIFEST_DIR").replace('\\', "/");
    // rust: let root = manifest
    // rust: .strip_suffix("crates/horizon-client-render")
    // rust: .unwrap_or(&manifest);
    // rust: let mut frames: Vec<(String, Option<String>)> = Vec::new();
    // rust: for line in backtrace.lines() {
    // rust: let line = line.trim();
    // rust: if let Some(at) = line.strip_prefix("at ") {
    // rust: if let Some(frame) = frames.last_mut() {
    // rust: frame.1 = Some(short_path(&at.replace('\\', "/"), root).to_owned());
}
    // rust: } else if let Some((n, name)) = line.split_once(": ")
    // rust: && n.chars().all(|c| c.is_ascii_digit())
    // rust: {
    // rust: frames.push((name.to_owned(), None));
}
}
    // rust: let machinery = |name: &str| {
    // rust: [
    // rust: "std::panicking::",
    // rust: "core::panicking::",
    // rust: "std::sys::backtrace::",
    // rust: "__rustc::",
    // rust: ]
    // rust: .iter()
    // rust: .any(|p| name.starts_with(p))
    // rust: || name.contains("rust_begin_unwind")
}
    // The hook's frames, then the panic machinery's, then the code that panicked.
    // rust: let top = frames.iter().take(30).position(|(name, _)| machinery(name));
    // rust: let first = match top.filter(|_| from_panic) {
    // rust: Some(start) => {
    // rust: start
    // rust: + frames[start..]
    // rust: .iter()
    // rust: .take_while(|(name, _)| machinery(name))
    // rust: .count()
}
    // rust: None => 0,
}
    // Some platforms keep std's own capture frames (`<std::backtrace::Backtrace>::create`).
    // rust: let first = first
    // rust: + frames[first..]
    // rust: .iter()
    // rust: .take_while(|(name, _)| name.trim_start_matches('<').starts_with("std::backtrace"))
    // rust: .count();
    // rust: frames[first..]
    // rust: .iter()
    // rust: .map(|(name, at)| match at {
    // rust: Some(at) => format!("{name} ({at})\n"),
    // rust: None => format!("{name}\n"),
    // rust: })
    // rust: .collect()
}

// A source path without the build machine's folders: relative to the workspace, or from the
// crate's folder for dependencies (`winit-0.30.13/src/event_loop.rs:642:56`).
    // rust: fn short_path<'a>(path: &'a str, root: &str) -> &'a str {
    // rust: if let Some(rest) = path.strip_prefix(root) {
    // rust: return rest;
}
    // rust: if let Some(i) = path.find("/registry/src/") {
    // rust: let rest = &path[i + "/registry/src/".len()..];
    // rust: if let Some((_index, krate)) = rest.split_once('/') {
    // rust: return krate;
}
}
    // rust: path
}

// A report for a panic, with the stack captured now (RUST_BACKTRACE or not).
panic_report :: proc(info: ^std::panic::PanicHookInfo, side: ^'static str) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Report {
    // rust: time: Local::now(),
    // rust: description: "Unexpected error".into(),
    // rust: error: panic_message(info),
    // rust: stack: stack_lines(
    // rust: &std::backtrace::Backtrace::force_capture().to_string(),
    // rust: true,
    // rust: ),
    // rust: thread: thread_name(side),
    // rust: side,
    // rust: details: system_details(side),
    // rust: log: crate::logging::recent_lines(),
}
}

// Whether `name` is one of the shared worker pool's threads (`horizon_threads::jobs`), vanilla's
// `Util` worker threads.
is_worker_thread :: proc(name: Maybe(string)) -> b {
    // Ported from Horizon
    return {}
}
    // rust: name.is_some_and(|n| n.starts_with("horizon-worker-"))
}

// `Util.onThreadException`: a panic on a worker thread is made a report titled "Exception on
// worker thread", with the thread's name, as `BlockableEventLoop.relayDelayCrash` hands it to
// the main thread.
worker_panic_report :: proc(info: ^std::panic::PanicHookInfo, side: ^'static str) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Report {
    // rust: description: "Exception on worker thread".into(),
    // rust: ..panic_report(info, side)
}
}

// Reports panics: on the main thread a crash report (the panic then ends the game, exit code
// 101); on a worker thread (`Util.onThreadException`) a crash report too, and the game ends
// with it; on other threads the error goes to the log, as vanilla's uncaught exception handler
// does. The default hook still prints the panic. A panic inside `contain` is only logged. A
// panic inside a native mod's hook names the mod and the hook.
install :: proc(home: PathBuf, side: ^'static str) {
}
    // rust: let default = std::panic::take_hook();
    // rust: std::panic::set_hook(Box::new(move |info| {
    // rust: if contained_panic(info) {
    // rust: return;
}
    // rust: default(info);
    // rust: let main = std::thread::current().name() == Some("main");
    // rust: if main {
    // rust: deliver(&home, panic_report(info, side));
    // rust: } else if is_worker_thread(std::thread::current().name()) {
    // rust: deliver(&home, worker_panic_report(info, side));
            // The crash ends the game, as the relayed report does on vanilla's main thread.
    // rust: std::process::exit(101);
    // rust: } else {
    // rust: log::error!(
    // rust: "Caught previously unhandled exception in thread {}: {}",
    // rust: thread_name(side),
    // rust: panic_message(info)
    // rust: );
}
    // rust: }));
}

// Vanilla's debug crash (`key.debug.crash` held for ten seconds): the error `main` gets back,
// with the stack where it was raised.
DebugCrash :: struct {
    stack: string,
}

    // rust: impl DebugCrash {
MESSAGE :: "Manually triggered debug crash"
new :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: stack: stack_lines(
    // rust: &std::backtrace::Backtrace::force_capture().to_string(),
    // rust: false,
    // rust: ),
}
}
}

    // rust: impl std::fmt::Display for DebugCrash {
fmt :: proc(self: ^Self, f: ^std::fmt::Formatter) -> s {
    // Ported from Horizon
    return {}
}
    // rust: f.write_str(Self::MESSAGE)
}
}

    // rust: impl std::error::Error for DebugCrash {}

// A report for an error `main` got back: the game ends with it.
    // rust: pub fn report_error(
    // rust: home: &Path,
    // rust: side: &'static str,
    // rust: error: &(dyn std::error::Error + 'static),
    // rust: ) -> Option<PathBuf> {
    // rust: if let Some(debug) = error.downcast_ref::<DebugCrash>() {
    // rust: return deliver(
    // rust: home,
    // rust: Report {
    // rust: time: Local::now(),
    // rust: description: DebugCrash::MESSAGE.into(),
    // rust: error: DebugCrash::MESSAGE.into(),
    // rust: stack: debug.stack.clone(),
    // rust: thread: thread_name(side),
    // rust: side,
    // rust: details: system_details(side),
    // rust: log: crate::logging::recent_lines(),
    // rust: },
    // rust: );
}
    // rust: let mut message = error.to_string();
    // rust: let mut source = error.source();
    // rust: while let Some(e) = source {
    // rust: let _ = write!(message, "\nCaused by: {e}");
    // rust: source = e.source();
}
    // rust: deliver(
    // rust: home,
    // rust: Report {
    // rust: time: Local::now(),
    // rust: description: "Fatal error".into(),
    // rust: error: message,
    // rust: stack: String::new(),
    // rust: thread: thread_name(side),
    // rust: side,
    // rust: details: system_details(side),
    // rust: log: crate::logging::recent_lines(),
    // rust: },
    // rust: )
}

// Called every frame: panics once `HORIZON_DEBUG_CRASH` asks (development builds only).
debug_crash_tick :: proc() {
}
    // rust: static AT: std::sync::OnceLock<Option<(std::time::Instant, std::time::Duration)>> =
    // rust: std::sync::OnceLock::new();
    // rust: if let Some((first, after)) =
    // rust: AT.get_or_init(|| debug_crash_after().map(|d| (std::time::Instant::now(), d)))
    // rust: && first.elapsed() >= *after
    // rust: {
    // rust: panic!("Manually triggered debug crash");
}
}

// Development builds crash on purpose when `HORIZON_DEBUG_CRASH` is set (vanilla has F3+C held
// for ten seconds): the number is seconds after the first frame (default 5).
debug_crash_after :: proc() -> O {
    // Ported from Horizon
    return {}
}
    // rust: if !cfg!(debug_assertions) {
    // rust: return None;
}
    // rust: let value = std::env::var("HORIZON_DEBUG_CRASH").ok()?;
    // rust: let seconds = value.parse::<f64>().unwrap_or(5.0).max(0.0);
    // rust: Some(std::time::Duration::from_secs_f64(seconds))
}

    // rust: mod tests {
//     use super::*;

a_release_reports_its_built_in_version :: proc() {
}
        // release.yml builds with HORIZON_VERSION (docs/versioning.md): `v0.2.3`, wherever it is installed.
    // rust: if let Some(label) = horizon_core::release::nightly_label() {
    // rust: assert_eq!(super::version(), label);
    // rust: assert_eq!(release_tag(), horizon_core::release::nightly_version());
    // rust: return;
}
    // rust: match horizon_core::release::RELEASE {
    // rust: Some(version) => {
    // rust: assert_eq!(release_tag(), Some(format!("v{version}")));
    // rust: assert_eq!(super::version(), format!("v{version}"));
}
    // rust: None => assert!(release_tag().is_none() || super::version().contains("(client ")),
}
}

a_panic_in_a_native_mods_hook_names_it :: proc() {
}
    // rust: let outer = enter_native_mod(NativeModCall {
    // rust: id: None,
    // rust: index: 1,
    // rust: hook: "render",
    // rust: });
    // rust: let inner = enter_native_mod(NativeModCall {
    // rust: id: Some("b"),
    // rust: index: 0,
    // rust: hook: "tick",
    // rust: });
    // rust: assert!(attributed("boom".into()).ends_with("\nin native mod b, hook tick"));
    // rust: drop(inner);
    // rust: assert!(attributed("boom".into()).ends_with("\nin native mod #1, hook render"));
    // rust: drop(outer);
    // rust: assert_eq!(attributed("boom".into()), "boom");
}

report :: proc() -> R {
    // Ported from Horizon
    return {}
}
    // rust: Report {
    // rust: time: chrono::TimeZone::with_ymd_and_hms(&Local, 2026, 10, 14, 9, 5, 7).unwrap(),
    // rust: description: "Unexpected error".into(),
    // rust: error: "panicked at src/game.rs:10:5:\nboom".into(),
    // rust: stack: "horizon_client::game::frame (src/game.rs:10:5)\n".into(),
    // rust: thread: "Render thread".into(),
    // rust: side: "client",
    // rust: details: vec![
    // rust: ("Horizon Version".into(), "0.1.0".into()),
    // rust: ("Minecraft Version".into(), "26.3".into()),
    // rust: ("Graphics".into(), "Test GPU (Vulkan), driver 1.0".into()),
    // rust: ],
    // rust: log: vec!["[09:05:06] [Render thread/INFO]: load assets: 1.20s".into()],
}
}

file_names_are_vanillas :: proc() {
}
    // rust: assert_eq!(
    // rust: file_name(&report().time, "client"),
    // rust: "crash-2026-10-14_09.05.07-client.txt"
    // rust: );
}

the_report_reads_like_vanillas :: proc() {
}
    // rust: let text = report().text();
    // rust: let lines: Vec<&str> = text.lines().collect();
    // rust: assert_eq!(lines[0], "---- Horizon Crash Report ----");
    // rust: assert!(lines[1].starts_with("// "));
    // rust: assert_eq!(lines[3], "Time: 2026-10-14 09:05:07");
    // rust: assert_eq!(lines[4], "Description: Unexpected error");
    // rust: assert_eq!(lines[6], "panicked at src/game.rs:10:5:");
    // rust: assert_eq!(lines[7], "boom");
    // rust: assert_eq!(
    // rust: lines[8],
    // rust: "\tat horizon_client::game::frame (src/game.rs:10:5)"
    // rust: );
    // rust: assert!(text.contains("-- Head --\nThread: Render thread\n"));
    // rust: assert!(text.contains(
    // rust: "-- System Details --\nDetails:\n\tHorizon Version: 0.1.0\n\tMinecraft Version: 26.3\n\tGraphics: Test GPU (Vulkan), driver 1.0\n"
    // rust: ));
    // rust: assert!(text.ends_with(
    // rust: "-- Last 1 log lines --\n[09:05:06] [Render thread/INFO]: load assets: 1.20s\n"
    // rust: ));
}

a_dedicated_servers_report_names_its_server_thread_and_no_render_settings :: proc() {
}
    // rust: let unnamed = |side: &'static str| {
    // rust: std::thread::spawn(move || thread_name(side))
    // rust: .join()
    // rust: .unwrap()
}
    // rust: assert_eq!(unnamed("server"), "Server thread");
    // rust: assert_eq!(unnamed("client"), "Render thread");
    // rust: set_detail("Render Settings", "render distance 12");
    // rust: let has = |side| {
    // rust: system_details(side)
    // rust: .iter()
    // rust: .any(|(k, _)| k == "Render Settings")
}
    // rust: assert!(has("client"));
    // rust: assert!(!has("server"));
    // rust: clear_detail("Render Settings");
}

stacks_start_at_the_panicking_frame :: proc() {
}
    // rust: let bt = format!(
    // rust: "   0: horizon_client::crash::panic_report\n             at {root}/src/crash.rs:296:16\n   1: std::panicking::panic_with_hook\n             at /rustc/abc/library/std/src/panicking.rs:823:13\n   2: core::panicking::panic_fmt\n             at /rustc/abc/library/core/src/panicking.rs:80:14\n   3: horizon_client::crash::debug_crash_tick\n             at {root}/src/crash.rs:359:9\n   4: winit::dispatch\n             at /home/someone/.cargo/registry/src/index.crates.io-1949cf8c6b5b557f/winit-0.30.13/src/event_loop.rs:642:56\n   5: main\n",
    // rust: root = env!("CARGO_MANIFEST_DIR")
    // rust: );
    // rust: assert_eq!(
    // rust: stack_lines(&bt, true),
    // rust: "horizon_client::crash::debug_crash_tick (crates/horizon-client-render/src/crash.rs:359:9)\nwinit::dispatch (winit-0.30.13/src/event_loop.rs:642:56)\nmain\n"
    // rust: );
}

contained_panics_come_back_as_errors :: proc() {
}
    // rust: assert_eq!(contain(|| 7), Ok(7));
    // rust: let error = contain(|| -> u8 { panic!("a pack's program") }).unwrap_err();
    // rust: assert!(error.contains("a pack's program"), "{error}");
        // Nested, and the thread is no longer inside one after.
    // rust: let outer = contain(|| contain(|| -> u8 { panic!("inner") }));
    // rust: assert!(outer.unwrap().unwrap_err().contains("inner"));
    // rust: assert_eq!(CONTAINED.with(Cell::get), 0);
}

the_debug_crash_is_reported_as_vanillas :: proc() {
}
    // rust: let error: Box<dyn std::error::Error> = DebugCrash::new().into();
    // rust: assert_eq!(error.to_string(), "Manually triggered debug crash");
    // rust: let debug = error.downcast_ref::<DebugCrash>().unwrap();
        // The stack starts where the crash was raised (DebugCrash::new, in this file).
    // rust: let first = debug.stack.lines().next().unwrap();
    // rust: assert!(first.contains("crash.rs"), "{}", debug.stack);
}

worker_threads_are_the_streaming_pool :: proc() {
}
    // rust: assert!(is_worker_thread(Some("horizon-worker-3")));
    // rust: assert!(!is_worker_thread(Some("main")));
    // rust: assert!(!is_worker_thread(None));
}

a_panic_becomes_a_report :: proc() {
}
        // A real panic through a hook, as the game's would be.
    // rust: let caught = std::sync::Arc::new(Mutex::new(Vec::new()));
    // rust: let sink = caught.clone();
    // rust: let previous = std::panic::take_hook();
    // rust: std::panic::set_hook(Box::new(move |info| {
    // rust: if panic_message(info).contains("the test crash") {
    // rust: sink.lock().unwrap().push(panic_report(info, "client"));
}
    // rust: }));
    // rust: let _ = std::panic::catch_unwind(|| panic!("the test crash"));
        // The same panic inside a native mod's hook, which the hook sees before the unwind.
    // rust: let _ = std::panic::catch_unwind(|| {
    // rust: let _guard = enter_native_mod(NativeModCall {
    // rust: id: Some("a"),
    // rust: index: 0,
    // rust: hook: "tick",
    // rust: });
    // rust: panic!("the test crash")
    // rust: });
    // rust: std::panic::set_hook(previous);
        // A caught panic leaves the thread as it found it.
    // rust: assert_eq!(attributed("boom".into()), "boom");
    // rust: let mut reports = std::mem::take(&mut *caught.lock().unwrap());
    // rust: assert_eq!(reports.len(), 2, "the hook ran for both panics");
    // rust: let in_mod = reports.pop().unwrap();
    // rust: assert!(
    // rust: in_mod.error.ends_with("\nin native mod a, hook tick"),
    // rust: "{}",
    // rust: in_mod.error
    // rust: );
    // rust: let report = reports.pop().unwrap();
    // rust: assert!(!report.error.contains("native mod"));
    // rust: assert!(report.error.contains("the test crash"));
    // rust: assert!(report.error.contains("crash.rs"));
        // The first frame is the test's own code, not the panic machinery.
    // rust: let first = report.stack.lines().next().unwrap();
    // rust: assert!(first.contains("crash.rs"), "{}", report.stack);
    // rust: let text = report.text();
    // rust: assert!(text.contains("Description: Unexpected error"));
    // rust: assert!(text.contains(&format!(
    // rust: "\tMinecraft Version: {}\n",
    // rust: horizon_core::VANILLA_VERSION
    // rust: )));
    // rust: assert!(text.contains("\tOperating System: "));
    // rust: assert!(text.contains("\tCPU: "));
    // rust: let home = std::env::temp_dir().join(format!("horizon-crash-save-{}", std::process::id()));
    // rust: let path = report.save(&home).unwrap();
    // rust: assert_eq!(std::fs::read_to_string(&path).unwrap(), text);
    // rust: assert!(
    // rust: path.file_name()
    // rust: .unwrap()
    // rust: .to_str()
    // rust: .unwrap()
    // rust: .ends_with("-client.txt")
    // rust: );
    // rust: let _ = std::fs::remove_dir_all(&home);
}
}
