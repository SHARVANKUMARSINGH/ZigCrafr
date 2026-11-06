//! Transpiled from Horizon Rust crate
package horizon_client_render_spans

import "core:fmt"
import "core:mem"
import "core:math"

// Named timings within a frame, for finding what makes a frame slow:
// `HORIZON_SPIKES=MS` prints the spans of every frame whose CPU time
// exceeds MS milliseconds, and of every server tick (dedicated or
// integrated) longer than MS. Each span keeps its wall time and the
// thread's CPU time inside it, so a span that waited (for a lock, the GPU
// or a core on a busy machine) shows apart from one that worked. Costs two
// clock reads per span when enabled and a relaxed load otherwise.
// use std::{
    // rust: cell::{Cell, RefCell},
    // rust: sync::atomic::{AtomicBool, Ordering},
    // rust: time::{Duration, Instant},
}

ENABLED :: AtomicBool::new(false)
    // rust: thread_local! {
SPANS :: const { RefCell::new(Vec::new()) }
    // Spans recorded on this thread alone, wall time only ([`record_here`]).
HERE :: const { Cell::new(false) }
    // How many timed spans the thread is inside: the next span's [`Span::depth`].
DEPTH :: const { Cell::new(0) }
    // What this thread's slowest steps were busy with since it last took them ([`note`]).
NOTES :: const { RefCell::new(Vec::new()) }
}

// The most spans a thread holds before they are taken ([`take_raw`]): a worker thread
// that records spans (`lod_reduce`, `lt_*`) while they are on for every thread is never
// taken from, so it drops what it held instead of growing for as long as they stay on.
UNTAKEN_MAX :: 1 << 14

// The shortest step a [`note`] keeps, in milliseconds.
NOTE_MS :: 10.0
// The notes a thread keeps between two [`take_notes`]: its slowest steps.
NOTES_KEPT :: 3

// A named timing: wall milliseconds and the thread's CPU milliseconds in it.
Span :: struct {
    name: ^'static str,
    ms: f32,
    cpu_ms: f32,
    // How many timed spans it ran inside (0: none): `tick_mobs` is inside `tick`.
    depth: u8,
}

enable :: proc(on: bool) {
}
    // rust: ENABLED.store(on, Ordering::Relaxed);
}
// Whether spans are being recorded.
enabled :: proc() -> b {
    // Ported from Horizon
    return {}
}
    // rust: ENABLED.load(Ordering::Relaxed)
}
// Record this thread's spans even with spans off, their wall time only (no CPU clock read):
// what the render thread's slow frames spent their time in, for the opt-in performance
// statistics (`telemetry::Session::frame`). The thread takes them every frame ([`take`]).
record_here :: proc(on: bool) {
}
    // rust: HERE.with(|h| h.set(on));
}
// Whether this thread records spans: all of them on, or [`record_here`].
recording_here :: proc() -> b {
    // Ported from Horizon
    return {}
}
    // rust: ENABLED.load(Ordering::Relaxed) || HERE.with(Cell::get) || trace::on()
}
// The thread's CPU time when spans are on for every thread (`HORIZON_SPIKES`): only they
// print it.
cpu_if_enabled :: proc() -> O {
    // Ported from Horizon
    return {}
}
    // rust: if ENABLED.load(Ordering::Relaxed) {
    // rust: thread_cpu()
    // rust: } else {
    // rust: None
}
}
// Run `f`, recording its duration under `name` when spans are enabled.
    // rust: pub fn time<T>(name: &'static str, f: impl FnOnce() -> T) -> T {
    // rust: let _span = guard(name);
    // rust: f()
}
// A span that ends where it is dropped: [`time`] for a step with several ways out (early
// returns). Nothing is read while spans are off.
Guard :: struct {
    open: Option<(^'static str,
    _heap: Maybe(horizon_threads::heap_census::Tag),
}
// Start a span named `name` that ends when the returned [`Guard`] is dropped.
guard :: proc(name: ^'static str) -> G {
    // Ported from Horizon
    return {}
}
    // rust: let _heap = horizon_threads::heap_tag(name);
    // rust: if !recording_here() {
    // rust: return Guard { open: None, _heap };
}
    // rust: let depth = DEPTH.with(|d| d.replace(d.get().saturating_add(1)));
    // rust: Guard {
    // rust: open: Some((name, Instant::now(), cpu_if_enabled(), depth)),
    // rust: _heap,
}
}
    // rust: impl Drop for Guard {
drop :: proc(self: ^Self) {
}
    // rust: let Some((name, started, cpu, depth)) = self.open.take() else {
    // rust: return;
}
    // rust: let ms = started.elapsed().as_secs_f32() * 1000.0;
    // rust: let cpu_ms = cpu
    // rust: .and_then(|start| Some((thread_cpu()?, start)))
    // rust: .map_or(ms, |(end, start)| (end - start).as_secs_f32() * 1000.0);
    // rust: DEPTH.with(|d| d.set(depth));
    // rust: trace::span(name, started, ms);
    // rust: push(Span {
    // rust: name,
    // rust: ms,
    // rust: cpu_ms,
    // rust: depth,
    // rust: });
}
}
// Keeps a finished span for the thread's next [`take_raw`].
push :: proc(span: Span) {
}
    // rust: SPANS.with(|s| {
    // rust: let mut s = s.borrow_mut();
    // rust: if s.len() >= UNTAKEN_MAX {
    // rust: s.clear();
}
    // rust: s.push(span);
    // rust: });
}
// Attach per-tick counts without interpreting them as durations.
counters :: proc(counts: ^[(string) {
}
    // rust: if !enabled() {
    // rust: return;
}
    // rust: NOTES.with(|n| {
    // rust: n.borrow_mut().push((
    // rust: 0.0,
    // rust: counts
    // rust: .iter()
    // rust: .map(|(name, count)| format!("{name}={count}"))
    // rust: .collect::<Vec<_>>()
    // rust: .join(", "),
    // rust: ))
    // rust: });
}
// Notes that one step inside a span took `ms` milliseconds doing `what` (one player's
// packets, say), when this thread records spans and the step took at least [`NOTE_MS`]: a
// span says where a slow tick went, its notes whose doing it was. Only the slowest few are
// kept, and `what` is built only for a step that is.
note :: proc(ms: f32, what: impl FnOnce() -> S {
    // Ported from Horizon
    return {}
}
    // rust: if ms < NOTE_MS || !recording_here() {
    // rust: return;
}
    // rust: NOTES.with(|n| {
    // rust: let mut n = n.borrow_mut();
    // rust: if n.len() >= NOTES_KEPT {
    // rust: let Some((i, _)) = n
    // rust: .iter()
    // rust: .enumerate()
    // rust: .filter(|(_, (kept, _))| *kept < ms)
    // rust: .min_by(|a, b| a.1.0.total_cmp(&b.1.0))
    // rust: else {
    // rust: return;
}
    // rust: n.swap_remove(i);
}
    // rust: n.push((ms, what()));
    // rust: });
}
// This thread's notes ([`note`]), slowest first; clears them.
take_notes :: proc() -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut notes = NOTES.with(|n| std::mem::take(&mut *n.borrow_mut()));
    // rust: notes.sort_by(|a, b| b.0.total_cmp(&a.0));
    // rust: notes
}
// Consecutive steps of one function timed as spans: each [`Laps::lap`] records the time since
// the previous one (or since [`laps`]) under its name. Nothing is read while spans are off.
Laps :: struct {
// Start timing the steps of a function (see [`Laps`]).
laps :: proc() -> L {
    // Ported from Horizon
    return {}
}
    // rust: Laps(recording_here().then(|| (Instant::now(), cpu_if_enabled())))
}
    // rust: impl Laps {
    // Record the step that just ended under `name`, and start the next.
lap :: proc(self: ^Self, name: ^'static str) {
}
    // rust: let Some((started, cpu)) = &mut self.0 else {
    // rust: return;
}
    // rust: let now = Instant::now();
    // rust: let now_cpu = cpu.and_then(|_| thread_cpu());
    // rust: let ms = (now - *started).as_secs_f32() * 1000.0;
    // rust: let cpu_ms = now_cpu
    // rust: .zip(*cpu)
    // rust: .map_or(ms, |(end, start)| (end - start).as_secs_f32() * 1000.0);
    // rust: let depth = DEPTH.with(Cell::get);
    // rust: trace::span(name, *started, ms);
    // rust: push(Span {
    // rust: name,
    // rust: ms,
    // rust: cpu_ms,
    // rust: depth,
    // rust: });
    // rust: (*started, *cpu) = (now, now_cpu);
}
}
// The CPU time this thread has used, where the platform tells it: a tick
// with more wall time than CPU time waited (for a lock, or for a core on a
// busy machine).
thread_cpu :: proc() -> O {
    // Ported from Horizon
    return {}
}
    // rust: {
    // rust: let t = rustix::time::clock_gettime(rustix::time::ClockId::ThreadCPUTime);
    // rust: Some(Duration::new(t.tv_sec as u64, t.tv_nsec as u32))
}
    // rust: horizon_threads::thread_cpu()
}

// The frame's spans as they were recorded, each after the spans inside it; clears them.
take_raw :: proc() -> V {
    // Ported from Horizon
    return {}
}
    // rust: SPANS.with(|s| std::mem::take(&mut *s.borrow_mut()))
}
// The frame's spans, summed by name, slowest first; clears them.
take :: proc() -> V {
    // Ported from Horizon
    return {}
}
    // rust: merge(&take_raw())
}
// What a frame spent its time in, from its spans as recorded ([`take_raw`]): the slowest of
// the outermost spans (summed by name, as a frame can tick several times), then the slowest
// span inside it while that one took at least half of it, and so on. The path of names
// (`tick/tick_mobs`) and the last one's milliseconds; `None` without spans.
culprit :: proc(raw: ^[Span]) -> O {
    // Ported from Horizon
    return {}
}
    // The spans directly inside each one: recorded just before it, one level deeper.
    // rust: let mut inside: Vec<Vec<usize>> = vec![Vec::new(); raw.len()];
    // rust: let mut outer: Vec<usize> = Vec::new();
    // rust: for (i, span) in raw.iter().enumerate() {
    // rust: while let Some(&j) = outer.last()
    // rust: && raw[j].depth > span.depth
    // rust: {
    // rust: outer.pop();
    // rust: inside[i].push(j);
}
    // rust: outer.push(i);
}
    // rust: let slowest = |group: &[usize]| {
    // rust: let mut sums: Vec<(&'static str, f32, Vec<usize>)> = Vec::new();
    // rust: for &i in group {
    // rust: match sums.iter_mut().find(|s| s.0 == raw[i].name) {
    // rust: Some(sum) => {
    // rust: sum.1 += raw[i].ms;
    // rust: sum.2.push(i);
}
    // rust: None => sums.push((raw[i].name, raw[i].ms, vec![i])),
}
}
    // rust: sums.into_iter().max_by(|a, b| a.1.total_cmp(&b.1))
}
    // rust: let (name, mut ms, mut at) = slowest(&outer)?;
    // rust: let mut path = name.to_owned();
    // rust: loop {
    // rust: let next: Vec<usize> = at.iter().flat_map(|&i| inside[i].iter().copied()).collect();
    // rust: match slowest(&next) {
    // rust: Some((name, inner_ms, spans)) if inner_ms >= ms * 0.5 => {
    // rust: path.push('/');
    // rust: path.push_str(name);
    // rust: (ms, at) = (inner_ms, spans);
}
    // rust: _ => return Some((path, ms)),
}
}
}
// Spans summed by name, slowest first.
merge :: proc(spans: ^[Span]) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut sums: Vec<Span> = Vec::new();
    // rust: for &span in spans {
    // rust: match sums.iter_mut().find(|s| s.name == span.name) {
    // rust: Some(sum) => {
    // rust: sum.ms += span.ms;
    // rust: sum.cpu_ms += span.cpu_ms;
}
    // rust: None => sums.push(span),
}
}
    // rust: sums.sort_by(|a, b| b.ms.total_cmp(&a.ms));
    // rust: sums
}
// `name wall` for spans of at least 0.5 ms, with `/cpu` when the thread
// worked for less than nine tenths of it: the slow-frame and slow-tick lines.
describe :: proc(spans: ^[Span]) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let list: Vec<String> = spans
    // rust: .iter()
    // rust: .filter(|s| s.ms >= 0.5)
    // rust: .map(|s| {
    // rust: if s.cpu_ms < s.ms * 0.9 {
    // rust: format!("{} {:.1}/{:.1}", s.name, s.ms, s.cpu_ms)
    // rust: } else {
    // rust: format!("{} {:.1}", s.name, s.ms)
}
    // rust: })
    // rust: .collect();
    // rust: list.join(", ")
}

// The run's timeline: every span ([`time`], [`guard`], [`Laps::lap`]) on every thread, as
// Chrome trace events that Perfetto (ui.perfetto.dev) opens as they are. `HORIZON_TRACE=FILE`
// writes it from the start; [`start`](trace::start) and [`stop`](trace::stop) write one for a
// while (`horizon-trace` on a dedicated server's console, `trace` on the control socket). Spans
// show on their threads where they ran, nested by time, so what ran beside what, and what a
// thread waited for, can be read off. Off, a span costs one relaxed load more.
    // rust: pub mod trace {
//     use std::{
    // rust: cell::Cell,
    // rust: fs::File,
    // rust: io::{BufWriter, Write as _},
    // rust: path::Path,
    // rust: sync::{
    // rust: Mutex, PoisonError,
    // rust: atomic::{AtomicBool, AtomicU32, Ordering},
    // rust: },
    // rust: time::Instant,
}

ON :: AtomicBool::new(false)
SINK :: Mutex::new(None)
    // Counts the traces started: a thread names itself again in each one.
TRACES :: AtomicU32::new(0)
NEXT_THREAD :: AtomicU32::new(1)
    // rust: thread_local! {
        // This thread's id in traces (0: none yet).
THREAD :: const { Cell::new(0) }
        // The trace this thread last named itself in.
NAMED_IN :: const { Cell::new(0) }
}
    // How often a trace's buffer goes to the file, at most: a run that ends without
    // [`stop`] loses no more than this.
FLUSH_EVERY :: std::time::Duration::from_secs(1)

Sink :: struct {
    file: BufWriter<File>,
    origin: Instant,
        // Until when it records ([`start`]'s `seconds`).
    until: Maybe(Instant),
    flushed: Instant,
        // Events written: the next one is preceded by a comma.
    events: u64,
}
    // rust: impl Sink {
event :: proc(self: ^Self, event: std::fmt::Arguments) {
}
    // rust: let comma = if self.events == 0 { "" } else { ",\n" };
    // rust: let _ = write!(self.file, "{comma}{{\"pid\":1,{event}}}");
    // rust: self.events += 1;
}
}

    // Whether a trace is being written.
on :: proc() -> b {
    // Ported from Horizon
    return {}
}
    // rust: ON.load(Ordering::Relaxed)
}

    // Starts a trace written to `path` (replacing a trace being written), for `seconds` or
    // until [`stop`].
start :: proc(path: ^Path, seconds: Maybe(u32)) -> s {
    // Ported from Horizon
    return {}
}
    // rust: let mut file = BufWriter::with_capacity(1 << 18, File::create(path)?);
    // rust: file.write_all(b"[\n")?;
    // rust: let now = Instant::now();
    // rust: let sink = Sink {
    // rust: file,
    // rust: origin: now,
    // rust: until: seconds.map(|s| now + std::time::Duration::from_secs(u64::from(s))),
    // rust: flushed: now,
    // rust: events: 0,
}
    // rust: let mut slot = SINK.lock().unwrap_or_else(PoisonError::into_inner);
    // rust: if let Some(old) = slot.take() {
    // rust: close(old);
}
    // rust: *slot = Some(sink);
    // rust: TRACES.fetch_add(1, Ordering::Relaxed);
    // rust: ON.store(true, Ordering::Relaxed);
    // rust: Ok(())
}

    // Starts the trace `HORIZON_TRACE` names, if it names one.
start_from_env :: proc() {
}
    // rust: if let Some(path) = std::env::var_os("HORIZON_TRACE")
    // rust: && let Err(e) = start(Path::new(&path), None)
    // rust: {
    // rust: log::warn!("Horizon: HORIZON_TRACE: {e}");
}
}

    // Ends the trace being written: the file is complete JSON. The events written so far
    // and whether one was being written.
stop :: proc() -> O {
    // Ported from Horizon
    return {}
}
    // rust: ON.store(false, Ordering::Relaxed);
    // rust: let sink = SINK.lock().unwrap_or_else(PoisonError::into_inner).take()?;
    // rust: let events = sink.events;
    // rust: close(sink);
    // rust: Some(events)
}

    // Whether the trace being written has run its time ([`start`]'s `seconds`): the caller
    // then [`stop`]s it.
due :: proc() -> b {
    // Ported from Horizon
    return {}
}
    // rust: on() && SINK
    // rust: .lock()
    // rust: .unwrap_or_else(PoisonError::into_inner)
    // rust: .as_ref()
    // rust: .and_then(|s| s.until)
    // rust: .is_some_and(|until| Instant::now() >= until)
}

close :: proc(mut sink: Sink) {
}
    // rust: let _ = sink.file.write_all(b"\n]\n");
    // rust: let _ = sink.file.flush();
}

    // A span of this thread from `started`, `ms` long.
    // rust: pub(super) fn span(name: &'static str, started: Instant, ms: f32) {
    // rust: if !on() {
    // rust: return;
}
    // rust: let tid = THREAD.with(|t| {
    // rust: if t.get() == 0 {
    // rust: t.set(NEXT_THREAD.fetch_add(1, Ordering::Relaxed));
}
    // rust: t.get()
    // rust: });
    // rust: let trace = TRACES.load(Ordering::Relaxed);
    // rust: let mut slot = SINK.lock().unwrap_or_else(PoisonError::into_inner);
    // rust: let Some(sink) = slot.as_mut() else {
    // rust: return;
}
    // rust: if NAMED_IN.with(|n| n.replace(trace)) != trace {
    // rust: let name = std::thread::current()
    // rust: .name()
    // rust: .unwrap_or("unnamed")
    // rust: .replace(['"', '\\'], "_");
    // rust: sink.event(format_args!(
    // rust: r#""ph":"M","name":"thread_name","tid":{tid},"args":{{"name":"{name}"}}"#
    // rust: ));
}
    // rust: let ts = started.saturating_duration_since(sink.origin).as_secs_f64() * 1e6;
    // rust: sink.event(format_args!(
    // rust: r#""ph":"X","name":"{name}","tid":{tid},"ts":{ts:.3},"dur":{:.3}"#,
    // rust: f64::from(ms) * 1e3
    // rust: ));
    // rust: let now = Instant::now();
    // rust: if now.duration_since(sink.flushed) >= FLUSH_EVERY {
    // rust: let _ = sink.file.flush();
    // rust: sink.flushed = now;
}
}
}

// The start's timeline: `HORIZON_STARTUP_TRACE=FILE` writes every named step of
// the start (resource tables, the renderer, the title, a world's open, a
// server's join, a dimension change) on whichever thread ran it, one Chrome
// trace event per line (`tools/startup_trace.py` reads it; wrapped in `[...]`,
// Perfetto opens it). Times are microseconds since the process started. Off,
// a step costs one relaxed load.
    // rust: pub mod startup {
//     use std::{
    // rust: io::Write as _,
    // rust: sync::{
    // rust: Mutex, OnceLock,
    // rust: atomic::{AtomicBool, AtomicU32, Ordering},
    // rust: },
    // rust: time::Instant,
}

ON :: AtomicBool::new(false)
SINK :: OnceLock::new()
ORIGIN :: OnceLock::new()
NEXT_THREAD :: AtomicU32::new(1)
    // rust: thread_local! {
        // This thread's trace id, given (with its name) on its first event.
THREAD :: const { std::cell::Cell::new(0) }
}

    // Opens the trace named by `HORIZON_STARTUP_TRACE`, timed from `origin`
    // (the process's start). Call once, first thing.
init :: proc(origin: Instant) {
}
    // rust: ORIGIN.get_or_init(|| origin);
    // rust: let sink = SINK.get_or_init(|| {
    // rust: let path = std::env::var_os("HORIZON_STARTUP_TRACE")?;
    // rust: std::fs::File::create(&path).ok().map(Mutex::new)
    // rust: });
    // rust: ON.store(sink.is_some(), Ordering::Relaxed);
}

    // Whether a trace is being written.
on :: proc() -> b {
    // Ported from Horizon
    return {}
}
    // rust: ON.load(Ordering::Relaxed)
}

micros :: proc(at: Instant) -> u {
    // Ported from Horizon
    return {}
}
    // rust: ORIGIN.get().map_or(0, |origin| {
    // rust: at.saturating_duration_since(*origin).as_micros()
    // rust: })
}

write :: proc(event: std::fmt::Arguments) {
}
    // rust: let Some(Some(sink)) = SINK.get() else {
    // rust: return;
}
    // rust: let tid = THREAD.with(|id| {
    // rust: if id.get() == 0 {
    // rust: id.set(NEXT_THREAD.fetch_add(1, Ordering::Relaxed));
    // rust: let name = std::thread::current()
    // rust: .name()
    // rust: .unwrap_or("unnamed")
    // rust: .replace(['"', '\\'], "_");
    // rust: let mut file = sink.lock().unwrap_or_else(std::sync::PoisonError::into_inner);
    // rust: let _ = writeln!(
    // rust: file,
    // rust: r#"{{"ph":"M","name":"thread_name","pid":1,"tid":{},"args":{{"name":"{name}"}}}}"#,
    // rust: id.get()
    // rust: );
}
    // rust: id.get()
    // rust: });
    // rust: let mut file = sink
    // rust: .lock()
    // rust: .unwrap_or_else(std::sync::PoisonError::into_inner);
    // rust: let _ = writeln!(file, r#"{{"pid":1,"tid":{tid},{event}}}"#);
}

    // A step running until it is dropped.
Step :: struct {
    name: ^'static str,
    started: Instant,
    traced: bool,
        // A heap-census build's tag for the step's allocations.
    _heap: Maybe(horizon_threads::heap_census::Tag),
}
    // rust: impl Drop for Step {
drop :: proc(self: ^Self) {
}
    // rust: if !self.traced {
    // rust: return;
}
    // rust: let end = Instant::now();
    // rust: write(format_args!(
    // rust: r#""ph":"X","name":"{}","ts":{},"dur":{}"#,
    // rust: self.name,
    // rust: micros(self.started),
    // rust: end.saturating_duration_since(self.started).as_micros()
    // rust: ));
}
}

    // Starts a step named `name` (a literal: no quotes or backslashes).
step :: proc(name: ^'static str) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let traced = on();
    // rust: (traced || horizon_threads::HEAP_CENSUS).then(|| Step {
    // rust: name,
    // rust: started: Instant::now(),
    // rust: traced,
    // rust: _heap: horizon_threads::heap_tag(name),
    // rust: })
}

    // Runs `f` as a step named `name`.
    // rust: pub fn time<T>(name: &'static str, f: impl FnOnce() -> T) -> T {
    // rust: let _step = step(name);
    // rust: f()
}

    // A moment of the start: the title drawn, the world in view.
mark :: proc(name: ^'static str) {
}
    // rust: if on() {
    // rust: write(format_args!(
    // rust: r#""ph":"i","s":"g","name":"{name}","ts":{}"#,
    // rust: micros(Instant::now())
    // rust: ));
}
}

    // The first time `name` happens, as a mark. `once` is the caller's flag.
mark_once :: proc(once: ^AtomicBool, name: ^'static str) {
}
    // rust: if on() && !once.swap(true, Ordering::Relaxed) {
    // rust: mark(name);
}
}

    // Set while a world opens, a server is joined or the dimension changes,
    // until the view first fills ([`view_filled`]).
FILLING :: AtomicBool::new(false)

    // A world starts loading: the next full view is marked.
arm :: proc(name: ^'static str) {
}
    // rust: if on() {
    // rust: mark(name);
    // rust: FILLING.store(true, Ordering::Relaxed);
}
}

    // Whether a world's view is still filling (between [`arm`] and the
    // `world.view_full` mark).
filling :: proc() -> b {
    // Ported from Horizon
    return {}
}
    // rust: on() && FILLING.load(Ordering::Relaxed)
}

    // Values at this moment, as a counter track named `name` (Perfetto draws
    // each value as a line): what the view waits on while it fills.
counters :: proc(name: ^'static str, values: ^[(^'static str) {
}
    // rust: if !on() {
    // rust: return;
}
    // rust: let args: Vec<String> = values
    // rust: .iter()
    // rust: .map(|(k, v)| format!(r#""{k}":{v}"#))
    // rust: .collect();
    // rust: write(format_args!(
    // rust: r#""ph":"C","name":"{name}","ts":{},"args":{{{}}}"#,
    // rust: micros(Instant::now()),
    // rust: args.join(",")
    // rust: ));
}

    // Called each frame in a world: marks `world.view_full` the first frame
    // after [`arm`] where nothing waits to load, generate, light, mesh or
    // upload and the resident columns cover perf_bench's share of the view
    // (0.8 pi r^2: corners are never loaded).
view_filled :: proc(resident: uint, pending: uint, radius: u32) {
}
    // rust: if FILLING.load(Ordering::Relaxed)
    // rust: && pending == 0
    // rust: && resident as f64 >= 0.8 * std::f64::consts::PI * f64::from(radius * radius)
    // rust: && FILLING.swap(false, Ordering::Relaxed)
    // rust: {
    // rust: mark("world.view_full");
}
}
}

    // rust: mod tests {
//     use super::Span;
//     use std::sync::{Mutex, MutexGuard};

    // Spans on for every thread ([`super::enable`]) is process-wide: a test that turns them on
    // would make another, run beside it, record what it expects left out. Those tests take
    // this lock.
spans_switch :: proc() -> M {
    // Ported from Horizon
    return {}
}
SWITCH :: Mutex::new(())
    // rust: SWITCH.lock().unwrap_or_else(|e| e.into_inner())
}

    // A slow tick's notes are its slowest steps, slowest first; short steps and steps on a
    // thread that records no spans leave none.
notes_keep_the_slowest_steps :: proc() {
}
    // rust: let _switch = spans_switch();
    // rust: super::record_here(false);
    // rust: super::note(500.0, || "unrecorded".into());
    // rust: assert!(super::take_notes().is_empty());
    // rust: super::record_here(true);
    // rust: for (ms, what) in [
    // rust: (12.0, "a"),
    // rust: (900.0, "b"),
    // rust: (3.0, "short"),
    // rust: (40.0, "c"),
    // rust: (11.0, "d"),
    // rust: (60.0, "e"),
    // rust: ] {
    // rust: super::note(ms, || what.into());
}
    // rust: let notes: Vec<(f32, String)> = super::take_notes();
    // rust: super::record_here(false);
    // rust: let names: Vec<&str> = notes.iter().map(|(_, w)| w.as_str()).collect();
    // rust: assert_eq!(names, ["b", "e", "c"]);
    // rust: assert!(super::take_notes().is_empty(), "taking them clears them");
}

    // Spans of one name add up; a span the thread spent mostly waiting
    // shows its CPU time after the wall time, short ones are left out.
spans_sum_by_name_and_show_waits :: proc() {
}
    // rust: super::SPANS.with(|s| {
    // rust: s.borrow_mut().extend([
    // rust: Span {
    // rust: name: "tick",
    // rust: ms: 2.0,
    // rust: cpu_ms: 2.0,
    // rust: depth: 0,
    // rust: },
    // rust: Span {
    // rust: name: "submit",
    // rust: ms: 30.0,
    // rust: cpu_ms: 0.2,
    // rust: depth: 0,
    // rust: },
    // rust: Span {
    // rust: name: "tick",
    // rust: ms: 3.0,
    // rust: cpu_ms: 2.9,
    // rust: depth: 0,
    // rust: },
    // rust: Span {
    // rust: name: "hud",
    // rust: ms: 0.3,
    // rust: cpu_ms: 0.3,
    // rust: depth: 0,
    // rust: },
    // rust: ]);
    // rust: });
    // rust: let spans = super::take();
    // rust: assert_eq!(
    // rust: spans[0],
    // rust: Span {
    // rust: name: "submit",
    // rust: ms: 30.0,
    // rust: cpu_ms: 0.2,
    // rust: depth: 0,
}
    // rust: );
    // rust: assert_eq!((spans[1].name, spans[1].ms), ("tick", 5.0));
    // rust: assert_eq!(super::describe(&spans), "submit 30.0/0.2, tick 5.0");
    // rust: assert!(super::take().is_empty());
}

    // A thread that records on its own keeps its spans with spans off, each with how many
    // spans it ran inside, after them.
a_recording_thread_keeps_its_spans_and_their_nesting :: proc() {
}
    // rust: std::thread::spawn(|| {
    // rust: super::record_here(true);
    // rust: super::time("tick", || {
    // rust: super::time("tick_mobs", || ());
    // rust: super::time("tick_items", || ());
    // rust: });
    // rust: super::time("renderer", || ());
    // rust: let raw = super::take_raw();
    // rust: let seen: Vec<_> = raw.iter().map(|s| (s.name, s.depth)).collect();
    // rust: assert_eq!(
    // rust: seen,
    // rust: [
    // rust: ("tick_mobs", 1),
    // rust: ("tick_items", 1),
    // rust: ("tick", 0),
    // rust: ("renderer", 0)
    // rust: ]
    // rust: );
    // rust: })
    // rust: .join()
    // rust: .unwrap();
}

    // A guarded span ends on every way out of its step, an early return's too, and holds the
    // spans that ran inside it until then; the next span outside it is back at its depth.
a_guarded_span_ends_where_its_step_returns :: proc() {
}
step :: proc(early: bool) -> u {
    // Ported from Horizon
    return {}
}
    // rust: let _span = super::guard("use_block");
    // rust: super::time("open_loot", || ());
    // rust: if early {
    // rust: return 1;
}
    // rust: super::time("open_maps", || ());
    // rust: 2
}
    // rust: std::thread::spawn(|| {
    // rust: super::record_here(true);
    // rust: assert_eq!(step(true), 1);
    // rust: assert_eq!(step(false), 2);
    // rust: super::time("use_item", || ());
    // rust: let raw = super::take_raw();
    // rust: let seen: Vec<_> = raw.iter().map(|s| (s.name, s.depth)).collect();
    // rust: assert_eq!(
    // rust: seen,
    // rust: [
    // rust: ("open_loot", 1),
    // rust: ("use_block", 0),
    // rust: ("open_loot", 1),
    // rust: ("open_maps", 1),
    // rust: ("use_block", 0),
    // rust: ("use_item", 0)
    // rust: ]
    // rust: );
    // rust: })
    // rust: .join()
    // rust: .unwrap();
}

    // A slow frame is put down to the slowest outer span, then to the span inside it that took
    // at least half of it; repeated spans (several ticks a frame) add up.
a_frame_is_put_down_to_the_step_that_took_most_of_it :: proc() {
}
    // rust: let span = |name, ms, depth| Span {
    // rust: name,
    // rust: ms,
    // rust: cpu_ms: ms,
    // rust: depth,
}
    // rust: let frame = [
    // rust: span("tick_mobs", 90.0, 1),
    // rust: span("tick_items", 5.0, 1),
    // rust: span("tick", 100.0, 0),
    // rust: span("tick_mobs", 90.0, 1),
    // rust: span("tick", 100.0, 0),
    // rust: span("r_uploads", 120.0, 1),
    // rust: span("renderer", 150.0, 0),
    // rust: ];
    // rust: assert_eq!(
    // rust: super::culprit(&frame),
    // rust: Some(("tick/tick_mobs".to_owned(), 180.0))
    // rust: );
        // Spread over many steps: the outer span alone.
    // rust: let spread = [
    // rust: span("tick_mobs", 40.0, 1),
    // rust: span("tick_items", 40.0, 1),
    // rust: span("tick", 300.0, 0),
    // rust: ];
    // rust: assert_eq!(super::culprit(&spread), Some(("tick".to_owned(), 300.0)));
    // rust: assert_eq!(super::culprit(&[]), None);
}

    // Laps record the steps between them while spans are on, and nothing while off.
laps_time_consecutive_steps :: proc() {
}
    // rust: let _switch = spans_switch();
    // rust: let _ = super::take();
    // rust: let mut off = super::laps();
    // rust: off.lap("unseen");
    // rust: super::enable(true);
    // rust: let mut laps = super::laps();
    // rust: std::thread::sleep(std::time::Duration::from_millis(2));
    // rust: laps.lap("first");
    // rust: laps.lap("second");
    // rust: super::enable(false);
    // rust: off.lap("still unseen");
    // rust: let spans = super::take();
    // rust: let names: Vec<_> = spans.iter().map(|s| s.name).collect();
    // rust: assert_eq!(names, ["first", "second"]);
    // rust: assert!(spans[0].ms >= 2.0);
}

    // The thread's CPU clock moves with work done on it, not with time
    // spent asleep.
thread_cpu_counts_work_not_sleep :: proc() {
}
    // rust: let start = super::thread_cpu().unwrap();
    // rust: std::thread::sleep(std::time::Duration::from_millis(50));
    // rust: let slept = super::thread_cpu().unwrap() - start;
        // Busy until the clock shows 10 ms of work (a loaded machine gives
        // the thread less than its wall time).
    // rust: let mut x = 0u64;
    // rust: let busy = std::time::Instant::now();
    // rust: let worked = loop {
    // rust: x = std::hint::black_box(x.wrapping_mul(31).wrapping_add(7));
    // rust: let worked = super::thread_cpu().unwrap() - start - slept;
    // rust: if worked.as_millis() >= 10 || busy.elapsed().as_secs() >= 10 {
    // rust: break worked;
}
}
    // rust: assert!(slept.as_millis() < 25, "{slept:?} while asleep");
    // rust: assert!(worked.as_millis() >= 10, "{worked:?} while busy");
}
}
