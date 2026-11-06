//! Transpiled from Horizon Rust crate
//! Module: horizon-prepare_pool
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Running independent work at once: the exporter JVMs of each side, the asset copy, hashing.
//! `HORIZON_PREPARE_JOBS=1` runs everything one step after another.

// use std::sync::atomic::{AtomicBool, AtomicUsize, Ordering};
// use std::sync::Mutex;

/// How many threads each copying, hashing or compiling step spreads over: HORIZON_PREPARE_JOBS,
/// else the processors (at most 8). With 1 the lanes run one after another too.
    // rust: pub(crate) fn jobs() -> usize {
    // rust: std::env::var("HORIZON_PREPARE_JOBS")
    // rust: .ok()
    // rust: .and_then(|n| n.trim().parse::<usize>().ok())
    // rust: .filter(|n| *n > 0)
    // rust: .unwrap_or_else(|| {
    // rust: std::thread::available_parallelism()
    // rust: .map_or(1, |n| n.get())
    // rust: .min(8)
    // rust: })
}

/// `work` over every item on up to `jobs()` threads, the results in the items' order. The first
/// item that fails, in that order, gives the error; the threads stop taking items once one failed.
    // rust: pub(crate) fn map<T: Sync, R: Send>(
    // rust: items: &[T],
    // rust: work: impl Fn(&T) -> Result<R, String> + Sync,
    // rust: ) -> Result<Vec<R>, String> {
    // rust: map_with(jobs(), items, work)
}

    // rust: fn map_with<T: Sync, R: Send>(
    // rust: jobs: usize,
    // rust: items: &[T],
    // rust: work: impl Fn(&T) -> Result<R, String> + Sync,
    // rust: ) -> Result<Vec<R>, String> {
    // rust: let threads = jobs.min(items.len());
    // rust: if threads <= 1 {
    // rust: return items.iter().map(work).collect();
}
    // rust: let next = AtomicUsize::new(0);
    // rust: let failed = AtomicBool::new(false);
    // rust: let done = Mutex::new(Vec::with_capacity(items.len()));
    // rust: std::thread::scope(|scope| {
    // rust: for _ in 0..threads {
    // rust: scope.spawn(|| {
    // rust: let mut results = Vec::new();
    // rust: while !failed.load(Ordering::Relaxed) {
    // rust: let i = next.fetch_add(1, Ordering::Relaxed);
    // rust: let Some(item) = items.get(i) else { break };
    // rust: let result = work(item);
    // rust: failed.fetch_or(result.is_err(), Ordering::Relaxed);
    // rust: results.push((i, result));
}
    // rust: done.lock().unwrap().extend(results);
    // rust: });
}
    // rust: });
    // rust: let mut done = done.into_inner().unwrap();
    // rust: done.sort_by_key(|(i, _)| *i);
    // rust: done.into_iter().map(|(_, result)| result).collect()
}

/// One sequence of steps that needs nothing from the others.
    // rust: pub(crate) type Lane<'a, R> = Box<dyn FnOnce() -> Result<R, String> + Send + 'a>;

/// Runs the lanes at once, each to its end; the first lane's error, in the lanes' order, wins.
/// With `jobs()` 1 they run one after another and the first error stops them. A lane that
/// panics fails the preparation instead of the program.
    // rust: pub(crate) fn lanes<R: Send>(lanes: Vec<Lane<'_, R>>) -> Result<Vec<R>, String> {
    // rust: lanes_with(jobs(), lanes)
}

    // rust: fn lanes_with<R: Send>(jobs: usize, lanes: Vec<Lane<'_, R>>) -> Result<Vec<R>, String> {
    // rust: let stopped = |_| Err("A preparation step stopped unexpectedly".to_string());
    // rust: if jobs <= 1 {
    // rust: return lanes
    // rust: .into_iter()
    // rust: .map(|lane| {
    // rust: std::panic::catch_unwind(std::panic::AssertUnwindSafe(lane)).unwrap_or_else(stopped)
    // rust: })
    // rust: .collect();
}
    // rust: std::thread::scope(|scope| {
    // rust: let handles: Vec<_> = lanes.into_iter().map(|lane| scope.spawn(lane)).collect();
    // rust: let results: Vec<_> = handles
    // rust: .into_iter()
    // rust: .map(|h| h.join().unwrap_or_else(stopped))
    // rust: .collect();
    // rust: results.into_iter().collect()
    // rust: })
}

    // rust: mod tests {
//     use super::*;

pub fn results_keep_the_items_order_and_the_first_failure_wins() void {
}
    // rust: let items: Vec<u32> = (0..500).collect();
    // rust: for jobs in [1, 4] {
    // rust: let squares = map_with(jobs, &items, |n| Ok(n * n)).unwrap();
    // rust: assert_eq!(squares, items.iter().map(|n| n * n).collect::<Vec<_>>());
    // rust: let failure = map_with(jobs, &items, |n| {
    // rust: if n % 7 == 3 {
    // rust: Err(format!("bad {n}"))
    // rust: } else {
    // rust: Ok(*n)
}
    // rust: });
    // rust: assert_eq!(failure, Err("bad 3".into()));
    // rust: assert_eq!(map_with(jobs, &[] as &[u32], |n| Ok(*n)), Ok(vec![]));
}
}

pub fn lanes_run_at_once_to_their_end_and_the_first_error_is_reported() void {
}
    // rust: let finished = AtomicUsize::new(0);
    // rust: let lane = |result: Result<u8, String>| -> Lane<'_, u8> {
    // rust: Box::new(|| {
    // rust: finished.fetch_add(1, Ordering::Relaxed);
    // rust: result
    // rust: })
}
    // rust: let four = || {
    // rust: vec![
    // rust: lane(Ok(1)),
    // rust: lane(Err("second".into())),
    // rust: lane(Err("third".into())),
    // rust: lane(Ok(4)),
    // rust: ]
}
    // rust: assert_eq!(
    // rust: lanes_with(4, vec![lane(Ok(1)), lane(Ok(2))]),
    // rust: Ok(vec![1, 2])
    // rust: );
    // rust: assert_eq!(lanes_with(4, four()), Err("second".into()));
    // rust: assert_eq!(finished.swap(0, Ordering::Relaxed), 6);
        // One after another, the first error stops the rest.
    // rust: assert_eq!(lanes_with(1, four()), Err("second".into()));
    // rust: assert_eq!(finished.load(Ordering::Relaxed), 2);
    // rust: for jobs in [1, 4] {
    // rust: let panics: Lane<'_, u8> = Box::new(|| panic!("exporter thread"));
    // rust: assert!(lanes_with(jobs, vec![lane(Ok(1)), panics]).is_err());
}
}
}
