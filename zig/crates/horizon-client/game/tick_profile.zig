//! Transpiled from Horizon Rust crate
//! Module: horizon-client_tick_profile
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! What each kind of mob costs the server tick, for `horizon-report` (dedicated/report.rs): while
//! a report records, one tick in [`SAMPLE_EVERY`] times every mob's own tick and adds it up by
//! level and mob type. Off, a mob costs one thread-local read; sampled, two clock reads and a
//! map update. A mob's riders tick inside its own tick, so they count for it.
// use horizon_client::{fast_hash::FxHashMap, mobs::MobType};
// use std::{
    // rust: cell::{Cell, RefCell},
    // rust: time::Instant,
}

/// One server tick in this many is sampled while a report records.
    // rust: pub(super) const SAMPLE_EVERY: usize = 4;

/// The time and the ticks of one mob type in one level.
pub const Cost = struct {
    kind: []const u8,
    nanos: u64,
    mob_ticks: u64,
};

    // rust: thread_local! {
pub const SAMPLING: Cell<bool> = const { Cell::new(false) };
pub const COSTS: RefCell<FxHashMap<(*'static str, usize), Cost>> = RefCell::default();
}

/// Sample (or stop sampling) the mob ticks this thread runs next.
    // rust: pub(super) fn set_sampling(on: bool) {
    // rust: SAMPLING.with(|s| s.set(on));
}

/// When this tick is sampled, the start of a mob's tick.
    // rust: pub(super) fn start() -> Option<Instant> {
    // rust: SAMPLING.with(Cell::get).then(Instant::now)
}

/// A sampled mob of type `kind` in level `dim` ticked since `started`.
    // rust: pub(super) fn add(dim: &'static str, kind: &MobType, started: Instant) {
    // rust: add_kind(dim, std::ptr::from_ref(kind) as usize, &kind.id, started);
}

/// [`add`] for the type at address `key` named `id`.
pub fn add_kind(dim: *'static str, key: usize, id: []const u8, started: Instant) void {
}
    // rust: let nanos = started.elapsed().as_nanos() as u64;
    // rust: COSTS.with(|c| {
    // rust: let mut costs = c.borrow_mut();
    // rust: let cost = costs.entry((dim, key)).or_insert_with(|| Cost {
    // rust: kind: id.to_owned(),
    // rust: nanos: 0,
    // rust: mob_ticks: 0,
    // rust: });
    // rust: cost.nanos += nanos;
    // rust: cost.mob_ticks += 1;
    // rust: });
}

/// One level's mob type: its sampled time and mob ticks.
    // rust: pub(super) struct MobCost {
    // rust: pub dimension: &'static str,
    // rust: pub kind: String,
    // rust: pub nanos: u64,
    // rust: pub mob_ticks: u64,
}

/// The costs sampled since the last call, costliest first; clears them.
    // rust: pub(super) fn take() -> Vec<MobCost> {
    // rust: let costs = COSTS.with(|c| std::mem::take(&mut *c.borrow_mut()));
    // rust: let mut out: Vec<MobCost> = costs
    // rust: .into_iter()
    // rust: .map(|((dimension, _), c)| MobCost {
    // rust: dimension,
    // rust: kind: c.kind,
    // rust: nanos: c.nanos,
    // rust: mob_ticks: c.mob_ticks,
    // rust: })
    // rust: .collect();
    // rust: out.sort_by(|a, b| b.nanos.cmp(&a.nanos).then_with(|| a.kind.cmp(&b.kind)));
    // rust: out
}

/// What sampling one mob costs on this machine, in nanoseconds: the report's own overhead.
    // rust: pub(super) fn sample_cost_nanos() -> f64 {
pub const N: u32 = 20_000;
    // rust: let was = SAMPLING.with(Cell::get);
    // rust: let kept = COSTS.with(|c| std::mem::take(&mut *c.borrow_mut()));
    // rust: set_sampling(true);
    // rust: let timer = Instant::now();
    // rust: for _ in 0..N {
    // rust: if let Some(started) = start() {
    // rust: add_kind("calibration", 1, "calibration", started);
}
}
    // rust: let per = timer.elapsed().as_nanos() as f64 / f64::from(N);
    // rust: set_sampling(was);
    // rust: COSTS.with(|c| *c.borrow_mut() = kept);
    // rust: per
}

    // rust: mod tests {
//     use super::*;

    /// A mob type at a made-up address.
pub fn add(dim: *'static str) void {
}
    // rust: add_kind(dim, key, id, started);
}

    /// Mobs add up by level and type, only on sampled ticks; taking them clears them.
pub fn costs_add_up_by_level_and_type_while_sampling() void {
}
    // rust: let (zombie, cow) = ((1, "minecraft:zombie"), (2, "minecraft:cow"));
    // rust: set_sampling(false);
    // rust: assert!(start().is_none(), "nothing is timed while off");
    // rust: set_sampling(true);
    // rust: for _ in 0..3 {
    // rust: let t = start().expect("sampled");
    // rust: std::thread::sleep(std::time::Duration::from_millis(1));
    // rust: add("minecraft:overworld", zombie, t);
}
    // rust: add("minecraft:overworld", cow, Instant::now());
    // rust: add("minecraft:the_nether", zombie, Instant::now());
    // rust: set_sampling(false);
    // rust: let costs = take();
    // rust: assert_eq!(costs.len(), 3, "{costs:?}");
    // rust: assert_eq!(costs[0].kind, "minecraft:zombie");
    // rust: assert_eq!(costs[0].dimension, "minecraft:overworld");
    // rust: assert_eq!(costs[0].mob_ticks, 3);
    // rust: assert!(costs[0].nanos >= 3_000_000, "{}", costs[0].nanos);
    // rust: let nether = costs
    // rust: .iter()
    // rust: .find(|c| c.dimension == "minecraft:the_nether")
    // rust: .unwrap();
    // rust: assert_eq!(
    // rust: (nether.kind.as_str(), nether.mob_ticks),
    // rust: ("minecraft:zombie", 1)
    // rust: );
    // rust: assert!(take().is_empty());
}

    /// Calibrating leaves what was sampled, and the switch, as they were.
pub fn calibration_keeps_the_samples() void {
}
    // rust: set_sampling(true);
    // rust: add("minecraft:overworld", (3, "minecraft:pig"), Instant::now());
    // rust: let per = sample_cost_nanos();
    // rust: assert!(per > 0.0 && per < 100_000.0, "{per}");
    // rust: assert!(start().is_some(), "still sampling");
    // rust: set_sampling(false);
    // rust: let costs = take();
    // rust: assert_eq!(costs.len(), 1);
    // rust: assert_eq!(costs[0].kind, "minecraft:pig");
}
}
