//! Transpiled from Horizon Rust crate
//! Module: horizon-threads_jobs
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! One pool of worker threads for the whole process, shared by every source of
//! background work: chunk generation, light and meshing (the client's and each
//! of the server thread's levels), chunk encoding, far terrain.
//!
//! Before it, each of those started its own threads, about one per core each:
//! a single player world ran four or five such pools at once, ~100 threads on a
//! 32-thread CPU, and they fought each other and the render and server threads
//! for cores. Here the threads are counted once, for the machine
//! ([`configure`]), and the work goes to them in the order it matters.
//!
//! A [`Source`] keeps its own queue (it can rank its jobs again when the player
//! moves, or drop the ones that left the view); a worker that is free asks every
//! source for the [`Rank`] of its next job and runs the most urgent one: the
//! [`Class`] first, then the source's key (a chunk's distance from the player).
//! Every free worker takes the next job as soon as it is free, so no core waits
//! while work is queued, whichever source queued it. Jobs are coarse (a chunk, a
//! section, a tile: a millisecond or more), so one lock for the choice costs
//! nothing next to them.
//!
//! A worker asks the sources for their next rank under the pool's read lock
//! of its sources and nothing else, so a source may call [`Pool::notify`]
//! anywhere, its queue's lock held or not; a notify never waits for a worker.
// use std::panic::{AssertUnwindSafe, catch_unwind};
// use std::sync::atomic::{AtomicBool, AtomicU64, AtomicUsize, Ordering};
// use std::sync::{Arc, Condvar, Mutex, MutexGuard, OnceLock, RwLock};
// use std::time::{Duration, Instant};

/// How urgent a job is, before its source's key: every queued job of a lower
/// class runs before any of a higher one.
pub const Class = enum {
    /// Work something waits for now: saves, a tick's chunk encoding.
    Urgent,
    /// The chunks around the player: generation, light, meshing.
    Near,
    /// Far terrain: runs on what the near work leaves, and never on every
    /// worker at once, so near work that arrives finds a worker free.
    Far,
};

/// A job's place in the pool's order: lower runs first.
pub const Rank = struct {
    class: Class,
    /// The source's own order within the class (a column's distance).
    key: i64,
};

    // rust: impl Rank {
    // rust: pub const fn new(class: Class, key: i64) -> Self {
    // rust: Self { class, key }
}
}

/// Work queued for the pool.
    // rust: pub trait Source: Send + Sync {
    /// The rank of the job [`Source::run`] would take next, or None while
    /// nothing is queued. Called under the pool's lock: cheap, no blocking.
pub fn next(self: *Self) O;
    /// Take the next job and run it on worker `worker` (0..[`Pool::threads`]).
    /// False if there was none after all.
pub fn run(self: *Self, worker: usize) b;
    /// Worker `worker` has waited [`IDLE_RELEASE`] with no work: free what it
    /// keeps between jobs.
pub fn idle(self: *Self, _worker: usize) void {
}
    /// Every worker is idle: free what the workers share.
pub fn all_idle(self: *Self) void {
}
    /// What a heap-census build tags its jobs' allocations (`crate::heap_tag`).
pub fn label(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: std::any::type_name::<Self>()
}
}

/// How long a worker waits with no job before it frees its buffers.
pub const IDLE_RELEASE: Duration = Duration::from_secs(5);

/// Per-worker state for a source: worker `i` only ever touches slot `i`, so
/// the locks are never contended. The source owns it, so it goes with the source.
pub const PerWorker = struct {
    slots: *[Mutex<?T]>,
};

    // rust: impl<T> PerWorker<T> {
pub fn new(workers: usize) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: slots: (0..workers.max(1)).map(|_| Mutex::new(None)).collect(),
}
}
    /// `f` with worker `worker`'s state, made by `init` the first time.
    // rust: pub fn with<R>(
    // rust: &self,
    // rust: worker: usize,
    // rust: init: impl FnOnce() -> T,
    // rust: f: impl FnOnce(&mut T) -> R,
    // rust: ) -> R {
    // rust: let mut slot = lock(&self.slots[worker % self.slots.len()]);
    // rust: f(slot.get_or_insert_with(init))
}
    /// `f` with worker `worker`'s state if it has one.
    // rust: pub fn with_existing<R>(&self, worker: usize, f: impl FnOnce(&mut T) -> R) -> Option<R> {
    // rust: lock(&self.slots[worker % self.slots.len()]).as_mut().map(f)
}
    /// Drop worker `worker`'s state.
pub fn clear(self: *Self, worker: usize) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: lock(&self.slots[worker % self.slots.len()]).take()
}
}

pub const Entry = struct {
    id: u64,
    source: *dyn Source,
    /// Workers running one of its jobs.
    running: AtomicUsize,
    /// Taken out of the pool: the worker that ends its last job tells
    /// [`Registration`]'s drop, which waits for it.
    retired: AtomicBool,
    /// When one of its jobs last ended (or it was registered).
    last_job: Mutex<Instant>,
    /// It was told it is idle ([`release_quiet_sources`]) since that job.
    quiet: AtomicBool,
};

pub const Inner = struct {
    /// Read by every choice, written only to add or take out a source.
    sources: RwLock<std.ArrayList(*Entry)>,
    next_id: AtomicU64,
    /// Bumped by every [`Pool::notify`]: a worker that found nothing sleeps
    /// until it changes, so a job queued while it looked is not missed. A
    /// notify is two atomic operations while every worker is busy, and takes
    /// `sleep` (held by no source code) only to wake one: the thread queuing
    /// work (a frame, a tick) never waits behind a worker's choice.
    epoch: AtomicU64,
    sleepers: AtomicUsize,
    sleep: Mutex<()>,
    wake: Condvar,
    /// Signalled when a retired source's job ends.
    finished: Condvar,
    /// Workers running a [`Class::Far`] job.
    far: AtomicUsize,
    /// Workers that freed their buffers and took no job since.
    released: AtomicUsize,
    threads: AtomicUsize,
    idle_release: Duration,
};

/// The pool: [`pool`] for the process's own, [`Pool::new`] for a test's.
pub const Pool = struct {
    inner: *Inner,
    threads: usize,
};

/// A source's place in the pool; dropping it takes the source out and waits
/// for the jobs of it that are running (so never drop it in one of its own jobs).
pub const Registration = struct {
    inner: *Inner,
    id: u64,
};

    // rust: fn lock<T>(m: &Mutex<T>) -> MutexGuard<'_, T> {
    // A panic in a job is caught; the pool's own state is never left half
    // changed, so a poisoned lock is still consistent.
    // rust: m.lock().unwrap_or_else(|e| e.into_inner())
}

pub const CONFIGURED: AtomicUsize = AtomicUsize::new(0);
pub const POOL: OnceLock<Pool> = OnceLock::new();

/// The number of workers the machine gets by default: one thread per core
/// but one, which the render and server threads share with them (they run
/// ahead of the workers: [`crate::favour_current`], [`crate::behind_server`]).
pub fn default_threads() u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: crate::worker_count().saturating_sub(1).max(1)
}

/// Size the process's pool before its first use (later calls change
/// nothing): `threads` workers, or `HORIZON_JOB_THREADS` when it is set.
pub fn configure(threads: usize) void {
}
    // rust: CONFIGURED.store(threads.max(1), Ordering::Relaxed);
}

/// The process's pool, started on first use.
pub fn pool() * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: POOL.get_or_init(|| {
    // rust: let threads = std::env::var("HORIZON_JOB_THREADS")
    // rust: .ok()
    // rust: .and_then(|v| v.trim().parse::<usize>().ok())
    // rust: .filter(|&n| n > 0)
    // rust: .unwrap_or_else(|| match CONFIGURED.load(Ordering::Relaxed) {
    // rust: 0 => default_threads(),
    // rust: n => n,
    // rust: });
        // The name the crash reports know a worker by (vanilla's `Util` workers).
    // rust: Pool::new(threads, "horizon-worker")
    // rust: })
}

    // rust: impl Pool {
    /// A pool of `threads` workers named `name-<i>`. Workers that the system
    /// refuses to start leave it smaller ([`Pool::threads`] counts those that started).
pub fn new(threads: usize, name: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::with_idle_release(threads, name, IDLE_RELEASE)
}

    /// [`Pool::new`] whose workers free their buffers after `idle_release`.
pub fn with_idle_release(threads: usize, name: []const u8, idle_release: Duration) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let inner = Arc::new(Inner {
    // rust: sources: RwLock::new(Vec::new()),
    // rust: next_id: AtomicU64::new(0),
    // rust: epoch: AtomicU64::new(0),
    // rust: sleepers: AtomicUsize::new(0),
    // rust: sleep: Mutex::new(()),
    // rust: wake: Condvar::new(),
    // rust: finished: Condvar::new(),
    // rust: far: AtomicUsize::new(0),
    // rust: released: AtomicUsize::new(0),
    // rust: threads: AtomicUsize::new(threads.max(1)),
    // rust: idle_release,
    // rust: });
    // rust: let mut started = 0;
    // rust: for i in 0..threads.max(1) {
    // rust: let worker = inner.clone();
    // rust: let spawned = std::thread::Builder::new()
    // rust: .name(format!("{name}-{i}"))
    // rust: .spawn(move || {
                    // Ticks and frames come first.
    // rust: crate::behind_server();
    // rust: work(&worker, i);
    // rust: });
    // rust: if spawned.is_ok() {
    // rust: started += 1;
}
}
    // rust: inner.threads.store(started.max(1), Ordering::Relaxed);
    // rust: Self {
    // rust: inner,
    // rust: threads: started.max(1),
}
}

    /// The workers: the size of a source's [`PerWorker`] and of the work it
    /// keeps queued.
pub fn threads(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.threads
}

    /// Add a source; its jobs run until the registration is dropped.
pub fn register(self: *Self, source: *dyn Source) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let id = self.inner.next_id.fetch_add(1, Ordering::Relaxed);
    // rust: self.inner
    // rust: .sources
    // rust: .write()
    // rust: .unwrap_or_else(|e| e.into_inner())
    // rust: .push(Arc::new(Entry {
    // rust: id,
    // rust: source,
    // rust: running: AtomicUsize::new(0),
    // rust: retired: AtomicBool::new(false),
    // rust: last_job: Mutex::new(Instant::now()),
    // rust: quiet: AtomicBool::new(false),
    // rust: }));
    // rust: self.inner.notify(true);
    // rust: Registration {
    // rust: inner: self.inner.clone(),
    // rust: id,
}
}

    /// Wake a worker for a job just queued (after the queue's lock is released).
pub fn notify(self: *Self) void {
}
    // rust: self.inner.notify(false);
}

    /// Wake every worker: many jobs were queued at once.
pub fn notify_all(self: *Self) void {
}
    // rust: self.inner.notify(true);
}
}

    // rust: impl Inner {
pub fn notify(self: *Self, all: bool) void {
}
    // rust: self.epoch.fetch_add(1, Ordering::SeqCst);
    // rust: if self.sleepers.load(Ordering::SeqCst) > 0 {
            // A worker between counting itself asleep and waiting holds
            // `sleep`: taking it here means it is waiting when told.
    // rust: drop(lock(&self.sleep));
    // rust: if all {
    // rust: self.wake.notify_all();
    // rust: } else {
    // rust: self.wake.notify_one();
}
}
}
}

    // rust: impl Registration {
    /// Wake a worker for a job just queued: [`Pool::notify`].
pub fn notify(self: *Self) void {
}
    // rust: self.inner.notify(false);
}
pub fn notify_all(self: *Self) void {
}
    // rust: self.inner.notify(true);
}
}

    // rust: impl Drop for Registration {
pub fn drop(self: *Self) void {
}
    // rust: let entry = {
    // rust: let mut sources = self
    // rust: .inner
    // rust: .sources
    // rust: .write()
    // rust: .unwrap_or_else(|e| e.into_inner());
    // rust: let Some(at) = sources.iter().position(|e| e.id == self.id) else {
    // rust: return;
}
    // rust: sources.swap_remove(at)
}
        // No worker takes a job of it now (a worker counts itself running
        // while it holds the sources' read lock); wait for those that did.
    // rust: entry.retired.store(true, Ordering::SeqCst);
    // rust: let mut sleep = lock(&self.inner.sleep);
    // rust: while entry.running.load(Ordering::SeqCst) > 0 {
    // rust: sleep = self
    // rust: .inner
    // rust: .finished
    // rust: .wait(sleep)
    // rust: .unwrap_or_else(|e| e.into_inner());
}
    // rust: drop(sleep);
        // The source's last reference may go here, outside every lock.
    // rust: drop(entry);
}
}

/// The most urgent queued job's source, counted as running, if any may run now.
pub fn choose(inner: *Inner) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let threads = inner.threads.load(Ordering::Relaxed);
    // Far work keeps one worker free for near work (when there are two or more).
    // rust: let far_cap = threads.saturating_sub(1).max(1);
    // rust: let sources = inner.sources.read().unwrap_or_else(|e| e.into_inner());
    // rust: let mut skip_far = false;
    // rust: loop {
    // rust: let far_open = !skip_far && inner.far.load(Ordering::SeqCst) < far_cap;
    // rust: let mut best: Option<(&Arc<Entry>, Rank)> = None;
    // rust: for entry in sources.iter() {
    // rust: let Some(rank) = entry.source.next() else {
    // rust: continue;
}
    // rust: if rank.class == Class::Far && !far_open {
    // rust: continue;
}
    // rust: if best.is_none_or(|(_, b)| rank < b) {
    // rust: best = Some((entry, rank));
}
}
    // rust: let (entry, rank) = best?;
    // rust: let far = rank.class == Class::Far;
    // rust: if far && !take_far_place(inner, far_cap) {
            // Another worker took the last far place meanwhile.
    // rust: skip_far = true;
    // rust: continue;
}
    // rust: entry.running.fetch_add(1, Ordering::SeqCst);
    // rust: return Some((entry.clone(), far));
}
}

/// Tell each source that has had no job for the idle delay, while others keep
/// the workers busy, that it is idle: its state in every worker
/// ([`Source::idle`]) and what its workers share ([`Source::all_idle`]). The
/// pool's own release needs every worker idle at once, which a client that
/// keeps meshing after its world loaded never is, while its server's
/// generator holds buffers and caches nothing reads until the player moves on.
pub fn release_quiet_sources(inner: *Inner) void {
}
    // rust: let quiet: Vec<Arc<Entry>> = inner
    // rust: .sources
    // rust: .read()
    // rust: .unwrap_or_else(|e| e.into_inner())
    // rust: .iter()
    // rust: .filter(|e| {
    // rust: !e.quiet.load(Ordering::SeqCst)
    // rust: && e.running.load(Ordering::SeqCst) == 0
    // rust: && lock(&e.last_job).elapsed() >= inner.idle_release
    // rust: && e.source.next().is_none()
    // rust: })
    // rust: .cloned()
    // rust: .collect();
    // rust: let mut freed = false;
    // rust: for entry in quiet {
    // rust: if entry.quiet.swap(true, Ordering::SeqCst) {
    // rust: continue;
}
    // rust: for worker in 0..inner.threads.load(Ordering::Relaxed) {
    // rust: let _ = catch_unwind(AssertUnwindSafe(|| entry.source.idle(worker)));
}
    // rust: let _ = catch_unwind(AssertUnwindSafe(|| entry.source.all_idle()));
    // rust: freed = true;
}
    // rust: if freed {
    // rust: crate::release_free_memory();
}
}

/// One more far job running, if fewer than `cap` are.
pub fn take_far_place(inner: *Inner, cap: usize) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut n = inner.far.load(Ordering::SeqCst);
    // rust: while n < cap {
    // rust: match inner
    // rust: .far
    // rust: .compare_exchange_weak(n, n + 1, Ordering::SeqCst, Ordering::SeqCst)
    // rust: {
    // rust: Ok(_) => return true,
    // rust: Err(now) => n = now,
}
}
    // rust: false
}

pub fn work(inner: *Inner, worker: usize) void {
}
    // rust: let mut released = false;
    // When this worker last ran a job. A wake that finds no job for it (another
    // worker took it, or a source woke the pool for nothing) doesn't restart its
    // wait: with jobs queued every few seconds on some worker, a pool of idle
    // workers would otherwise never free anything.
    // rust: let mut idle_since = Instant::now();
    // rust: loop {
    // rust: let epoch = inner.epoch.load(Ordering::SeqCst);
    // rust: if let Some((entry, far)) = choose(inner) {
    // rust: if released {
    // rust: inner.released.fetch_sub(1, Ordering::Relaxed);
    // rust: released = false;
}
            // A panicking job loses its own work, not the worker: the panic
            // hook has already reported it.
    // rust: let _ = catch_unwind(AssertUnwindSafe(|| {
    // rust: let _tag =
    // rust: crate::HEAP_CENSUS.then(|| crate::heap_census::tag(entry.source.label()));
    // rust: entry.source.run(worker)
    // rust: }));
    // rust: if far {
    // rust: inner.far.fetch_sub(1, Ordering::SeqCst);
}
    // rust: *lock(&entry.last_job) = Instant::now();
    // rust: entry.quiet.store(false, Ordering::SeqCst);
    // rust: entry.running.fetch_sub(1, Ordering::SeqCst);
    // rust: if entry.retired.load(Ordering::SeqCst) {
    // rust: drop(lock(&inner.sleep));
    // rust: inner.finished.notify_all();
}
    // rust: idle_since = Instant::now();
    // rust: release_quiet_sources(inner);
    // rust: continue;
}
    // rust: let sleep = lock(&inner.sleep);
    // rust: inner.sleepers.fetch_add(1, Ordering::SeqCst);
    // rust: let still = |_: &mut ()| inner.epoch.load(Ordering::SeqCst) == epoch;
    // rust: let timed_out = if released {
    // rust: drop(
    // rust: inner
    // rust: .wake
    // rust: .wait_while(sleep, still)
    // rust: .unwrap_or_else(|e| e.into_inner()),
    // rust: );
    // rust: false
    // rust: } else {
    // rust: let left = inner.idle_release.saturating_sub(idle_since.elapsed());
    // rust: let (sleep, wait) = inner
    // rust: .wake
    // rust: .wait_timeout_while(sleep, left, still)
    // rust: .unwrap_or_else(|e| e.into_inner());
    // rust: drop(sleep);
    // rust: wait.timed_out()
}
    // rust: inner.sleepers.fetch_sub(1, Ordering::SeqCst);
    // rust: if !timed_out {
    // rust: continue;
}
        // Nothing to do for a while (a server nobody is on, a player standing
        // still): free this worker's buffers until the next job needs them.
    // rust: released = true;
    // rust: let last = inner.released.fetch_add(1, Ordering::Relaxed) + 1
    // rust: == inner.threads.load(Ordering::Relaxed);
    // rust: let sources: Vec<_> = inner
    // rust: .sources
    // rust: .read()
    // rust: .unwrap_or_else(|e| e.into_inner())
    // rust: .iter()
    // rust: .map(|e| e.source.clone())
    // rust: .collect();
    // rust: for source in &sources {
    // rust: let _ = catch_unwind(AssertUnwindSafe(|| source.idle(worker)));
}
    // rust: if last {
    // rust: for source in &sources {
    // rust: let _ = catch_unwind(AssertUnwindSafe(|| source.all_idle()));
}
}
        // The allocator keeps freed pages until memory runs short: hand back
        // what this worker just freed (its own heap), and the shared arenas'
        // once every worker has.
    // rust: crate::release_free_memory();
}
}

    // rust: mod tests {
//     use super::*;
//     use std::collections::VecDeque;
//     use std::sync::mpsc;
//     use std::time::Instant;

    /// Jobs with fixed ranks; each records its name when it runs.
pub const Fixed = struct {
    jobs: Mutex<VecDeque<(Rank,
    ran: mpsc::Sender<*'static str>,
    hold: ?Arc<(Mutex<bool,
};
    // rust: impl Source for Fixed {
pub fn next(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: lock(&self.jobs).iter().map(|(r, _)| *r).min()
}
pub fn run(self: *Self, _worker: usize) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let job = {
    // rust: let mut jobs = lock(&self.jobs);
    // rust: let Some(at) = jobs
    // rust: .iter()
    // rust: .enumerate()
    // rust: .min_by_key(|(_, (r, _))| *r)
    // rust: .map(|(i, _)| i)
    // rust: else {
    // rust: return false;
}
    // rust: jobs.remove(at).unwrap()
}
    // rust: if let Some(hold) = &self.hold {
    // rust: let (open, cv) = &**hold;
    // rust: let mut open = lock(open);
    // rust: while !*open {
    // rust: open = cv.wait(open).unwrap();
}
}
    // rust: let _ = self.ran.send(job.1);
    // rust: true
}
}
pub fn fixed(jobs: *[(Rank) void {
}
    // rust: Arc::new(Fixed {
    // rust: jobs: Mutex::new(jobs.iter().copied().collect()),
    // rust: ran,
    // rust: hold: None,
    // rust: })
}
pub fn recv_n(rx: *mpsc::Receiver<*'static str>, n: usize) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (0..n)
    // rust: .map(|_| rx.recv_timeout(Duration::from_secs(10)).unwrap())
    // rust: .collect()
}

pub fn one_worker_runs_every_source_in_rank_order() void {
}
    // rust: let pool = Pool::new(1, "test-job");
    // rust: let (tx, rx) = mpsc::channel();
        // Held until both sources are in, so the order is the pool's choice.
    // rust: let gate = Arc::new((Mutex::new(false), Condvar::new()));
    // rust: let first = Arc::new(Fixed {
    // rust: jobs: Mutex::new([(Rank::new(Class::Urgent, i64::MIN), "gate")].into()),
    // rust: ran: tx.clone(),
    // rust: hold: Some(gate.clone()),
    // rust: });
    // rust: let _g = pool.register(first);
    // rust: let a = fixed(
    // rust: &[
    // rust: (Rank::new(Class::Near, 5), "near5"),
    // rust: (Rank::new(Class::Far, 0), "far0"),
    // rust: ],
    // rust: tx.clone(),
    // rust: );
    // rust: let b = fixed(
    // rust: &[
    // rust: (Rank::new(Class::Near, 1), "near1"),
    // rust: (Rank::new(Class::Urgent, 9), "urgent9"),
    // rust: ],
    // rust: tx,
    // rust: );
    // rust: let _a = pool.register(a);
    // rust: let _b = pool.register(b);
    // rust: *gate.0.lock().unwrap() = true;
    // rust: gate.1.notify_all();
    // rust: assert_eq!(
    // rust: recv_n(&rx, 5),
    // rust: ["gate", "urgent9", "near1", "near5", "far0"]
    // rust: );
}

pub fn far_work_leaves_a_worker_for_near_work() void {
}
    // rust: let pool = Pool::new(3, "test-job");
    // rust: let gate = Arc::new((Mutex::new(false), Condvar::new()));
    // rust: let (tx, rx) = mpsc::channel();
    // rust: let far = Arc::new(Fixed {
    // rust: jobs: Mutex::new((0..6).map(|i| (Rank::new(Class::Far, i), "far")).collect()),
    // rust: ran: tx.clone(),
    // rust: hold: Some(gate.clone()),
    // rust: });
    // rust: let _far = pool.register(far);
        // Two far jobs hold two workers; the third stays free for this one.
    // rust: std::thread::sleep(Duration::from_millis(100));
    // rust: let near = fixed(&[(Rank::new(Class::Near, 0), "near")], tx);
    // rust: let near_reg = pool.register(near);
    // rust: near_reg.notify();
    // rust: assert_eq!(rx.recv_timeout(Duration::from_secs(10)).unwrap(), "near");
    // rust: *gate.0.lock().unwrap() = true;
    // rust: gate.1.notify_all();
    // rust: assert_eq!(recv_n(&rx, 6), ["far"; 6]);
}

    /// A source that counts its jobs, queued from outside while the workers run.
pub const Counter = struct {
    left: Mutex<u64>,
    done: AtomicUsize,
    per_worker: PerWorker<u64>,
    idle: AtomicBool,
    all_idle: AtomicBool,
};
    // rust: impl Source for Counter {
pub fn next(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (*lock(&self.left) > 0).then_some(Rank::new(Class::Near, 0))
}
pub fn run(self: *Self, worker: usize) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: {
    // rust: let mut left = lock(&self.left);
    // rust: if *left == 0 {
    // rust: return false;
}
    // rust: *left -= 1;
}
    // rust: self.per_worker.with(worker, || 0, |n| *n += 1);
    // rust: self.done.fetch_add(1, Ordering::Relaxed);
    // rust: true
}
pub fn idle(self: *Self, worker: usize) void {
}
    // rust: self.per_worker.clear(worker);
    // rust: self.idle.store(true, Ordering::Relaxed);
}
pub fn all_idle(self: *Self) void {
}
    // rust: self.all_idle.store(true, Ordering::Relaxed);
}
}

pub fn no_job_is_missed_when_queued_while_workers_look() void {
}
    // rust: let pool = Pool::new(4, "test-job");
    // rust: let counter = Arc::new(Counter {
    // rust: left: Mutex::new(0),
    // rust: done: AtomicUsize::new(0),
    // rust: per_worker: PerWorker::new(pool.threads()),
    // rust: idle: AtomicBool::new(false),
    // rust: all_idle: AtomicBool::new(false),
    // rust: });
    // rust: let reg = pool.register(counter.clone());
    // rust: for _ in 0..20_000 {
    // rust: *lock(&counter.left) += 1;
    // rust: reg.notify();
}
    // rust: let deadline = Instant::now() + Duration::from_secs(20);
    // rust: while counter.done.load(Ordering::Relaxed) < 20_000 {
    // rust: assert!(Instant::now() < deadline, "jobs left behind");
    // rust: std::thread::sleep(Duration::from_millis(1));
}
}

    /// A pool woken far more often than its idle delay, with no job for most of
    /// its workers (the game queues a few meshes a second long after loading):
    /// each worker still frees its state once it has run nothing for the delay,
    /// and the whole pool once none has.
pub fn workers_woken_for_nothing_still_free_their_state() void {
}
    // rust: let release = Duration::from_millis(300);
    // rust: let pool = Pool::with_idle_release(4, "test-job", release);
    // rust: let counter = Arc::new(Counter {
    // rust: left: Mutex::new(0),
    // rust: done: AtomicUsize::new(0),
    // rust: per_worker: PerWorker::new(pool.threads()),
    // rust: idle: AtomicBool::new(false),
    // rust: all_idle: AtomicBool::new(false),
    // rust: });
    // rust: let reg = pool.register(counter.clone());
    // rust: let deadline = Instant::now() + release * 10;
    // rust: while !counter.all_idle.load(Ordering::Relaxed) {
    // rust: assert!(
    // rust: Instant::now() < deadline,
    // rust: "woken every 50 ms, the workers never released"
    // rust: );
    // rust: reg.notify_all();
    // rust: std::thread::sleep(Duration::from_millis(50));
}
    // rust: assert!(counter.idle.load(Ordering::Relaxed));
}

    /// One source idle while another keeps the workers busy (a client meshing
    /// beside its server's generator): the idle one is still told, once.
pub fn a_quiet_source_is_released_while_another_keeps_the_workers_busy() void {
}
    // rust: let release = Duration::from_millis(300);
    // rust: let pool = Pool::with_idle_release(2, "test-job", release);
    // rust: let counter = |left| {
    // rust: Arc::new(Counter {
    // rust: left: Mutex::new(left),
    // rust: done: AtomicUsize::new(0),
    // rust: per_worker: PerWorker::new(pool.threads()),
    // rust: idle: AtomicBool::new(false),
    // rust: all_idle: AtomicBool::new(false),
    // rust: })
}
    // rust: let (quiet, busy) = (counter(4), counter(0));
    // rust: let quiet_reg = pool.register(quiet.clone());
    // rust: let busy_reg = pool.register(busy.clone());
    // rust: quiet_reg.notify_all();
    // rust: let deadline = Instant::now() + release * 10;
    // rust: while !quiet.all_idle.load(Ordering::Relaxed) {
    // rust: assert!(
    // rust: Instant::now() < deadline,
    // rust: "the quiet source was never released"
    // rust: );
    // rust: *lock(&busy.left) += 1;
    // rust: busy_reg.notify();
    // rust: std::thread::sleep(Duration::from_millis(50));
}
    // rust: assert_eq!(quiet.done.load(Ordering::Relaxed), 4);
    // rust: assert!(quiet.idle.load(Ordering::Relaxed));
    // rust: assert!(quiet.per_worker.slots.iter().all(|s| lock(s).is_none()));
    // rust: assert!(
    // rust: !busy.all_idle.load(Ordering::Relaxed),
    // rust: "the busy source is not idle"
    // rust: );
}

pub fn idle_workers_free_their_state() void {
}
    // rust: let release = Duration::from_millis(300);
    // rust: let pool = Pool::with_idle_release(2, "test-job", release);
    // rust: let counter = Arc::new(Counter {
    // rust: left: Mutex::new(10),
    // rust: done: AtomicUsize::new(0),
    // rust: per_worker: PerWorker::new(pool.threads()),
    // rust: idle: AtomicBool::new(false),
    // rust: all_idle: AtomicBool::new(false),
    // rust: });
    // rust: let reg = pool.register(counter.clone());
    // rust: reg.notify_all();
    // rust: let deadline = Instant::now() + release * 20;
    // rust: while !counter.all_idle.load(Ordering::Relaxed) {
    // rust: assert!(Instant::now() < deadline, "workers never released");
    // rust: std::thread::sleep(Duration::from_millis(20));
}
    // rust: assert!(counter.idle.load(Ordering::Relaxed));
    // rust: assert_eq!(counter.done.load(Ordering::Relaxed), 10);
    // rust: assert!(counter.per_worker.slots.iter().all(|s| lock(s).is_none()));
}

pub fn dropping_a_registration_waits_for_its_running_job() void {
}
    // rust: let pool = Pool::new(2, "test-job");
    // rust: let gate = Arc::new((Mutex::new(false), Condvar::new()));
    // rust: let (tx, rx) = mpsc::channel();
    // rust: let held = Arc::new(Fixed {
    // rust: jobs: Mutex::new(
    // rust: [
    // rust: (Rank::new(Class::Near, 0), "held"),
    // rust: (Rank::new(Class::Near, 1), "second"),
    // rust: ]
    // rust: .into(),
    // rust: ),
    // rust: ran: tx,
    // rust: hold: Some(gate.clone()),
    // rust: });
    // rust: let reg = pool.register(held.clone());
        // A worker takes the job off the queue before holding it on the gate: wait for
        // that take, not a fixed sleep past it (a busy runner may start it later), so
        // `drop(reg)` below always has a running job to wait for.
    // rust: let picked = Instant::now();
    // rust: while lock(&held.jobs).len() > 1 {
    // rust: assert!(
    // rust: picked.elapsed() < Duration::from_secs(10),
    // rust: "no worker picked the job up"
    // rust: );
    // rust: std::thread::sleep(Duration::from_millis(1));
}
    // rust: let opener = {
    // rust: let gate = gate.clone();
    // rust: std::thread::spawn(move || {
    // rust: std::thread::sleep(Duration::from_millis(200));
    // rust: *gate.0.lock().unwrap() = true;
    // rust: gate.1.notify_all();
    // rust: })
}
    // rust: let began = Instant::now();
    // rust: drop(reg);
        // Both jobs may have started (two workers); none runs after the drop.
    // rust: assert!(began.elapsed() >= Duration::from_millis(150));
    // rust: opener.join().unwrap();
    // rust: let ran: Vec<_> = rx.try_iter().collect();
    // rust: assert!(ran.contains(&"held"));
    // rust: std::thread::sleep(Duration::from_millis(100));
    // rust: assert!(rx.try_iter().next().is_none());
        // The pool's own references are gone.
    // rust: assert_eq!(Arc::strong_count(&held), 1);
}

pub fn a_panicking_job_keeps_its_worker() void {
}
pub const Boom = struct {};
    // rust: impl Source for Boom {
pub fn next(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (self.0.load(Ordering::Relaxed) < 2).then_some(Rank::new(Class::Near, 0))
}
pub fn run(self: *Self, _worker: usize) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.0.fetch_add(1, Ordering::Relaxed) == 0 {
    // rust: panic!("first job fails");
}
    // rust: true
}
}
    // rust: let pool = Pool::new(1, "test-job");
    // rust: let boom = Arc::new(Boom(AtomicUsize::new(0)));
    // rust: let reg = pool.register(boom.clone());
    // rust: reg.notify();
    // rust: let deadline = Instant::now() + Duration::from_secs(10);
    // rust: while boom.0.load(Ordering::Relaxed) < 2 {
    // rust: assert!(Instant::now() < deadline, "the worker died with the panic");
    // rust: std::thread::sleep(Duration::from_millis(5));
}
}
}
