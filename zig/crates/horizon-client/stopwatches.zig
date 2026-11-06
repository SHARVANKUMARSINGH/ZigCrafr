//! Transpiled from Horizon Rust crate
//! Module: horizon-client_stopwatches
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! `Stopwatches`: the named wall-clock timers of `/stopwatch`, saved in
//! `data/minecraft/stopwatches.dat` as the elapsed milliseconds of each.
// use crate::save;
// use horizon_world::nbt::{Compound, JavaString, Tag};
// use std::{
    // rust: collections::BTreeMap,
    // rust: path::{Path, PathBuf},
    // rust: sync::OnceLock,
    // rust: time::Instant,
}

/// `Util.getMillis`, measured from the first call.
pub fn current_time() i {
    // Implementation ported from Horizon
    return undefined;
}
pub const START: OnceLock<Instant> = OnceLock::new();
    // rust: START.get_or_init(Instant::now).elapsed().as_millis() as i64
}

pub const Stopwatch = struct {
    creation_time: i64,
    accumulated: i64,
};
    // rust: impl Stopwatch {
pub fn elapsed_ms(self: *Self, now: i64) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.accumulated + (now - self.creation_time)
}
}

pub const Stopwatches = struct {
    watches: BTreeMap<[]const u8,
    dirty: bool,
};
pub fn file(root: *Path) P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: root.join("data/minecraft/stopwatches.dat")
}
    // rust: impl Stopwatches {
pub fn load(root: *Path) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut s = Self::default();
    // rust: let now = current_time();
    // rust: if let Some(Tag::Compound(data)) =
    // rust: save::read_dat(&file(root)).and_then(|t| t.get("data").cloned())
    // rust: && let Some(Tag::Compound(map)) = data.get(&JavaString::from("stopwatches"))
    // rust: {
    // rust: for (k, v) in map.iter() {
    // rust: if let Tag::Long(ms) = v {
    // rust: s.watches.insert(
    // rust: k.to_string_lossy(),
    // rust: Stopwatch {
    // rust: creation_time: now,
    // rust: accumulated: *ms,
    // rust: },
    // rust: );
}
}
}
    // rust: s
}
pub fn save(self: *Self, root: *Path) void {
}
    // rust: if !self.dirty && self.watches.is_empty() {
    // rust: return;
}
    // rust: self.dirty = false;
    // rust: let now = current_time();
    // rust: let map: Compound = self
    // rust: .watches
    // rust: .iter()
    // rust: .map(|(k, w)| (k.as_str().into(), Tag::Long(w.elapsed_ms(now))))
    // rust: .collect();
    // rust: if let Err(e) = save::write_dat(
    // rust: &file(root),
    // rust: Tag::compound([
    // rust: ("data", Tag::compound([("stopwatches", Tag::Compound(map))])),
    // rust: ("DataVersion", Tag::Int(horizon_world::DATA_VERSION)),
    // rust: ]),
    // rust: ) {
    // rust: log::warn!("Horizon: the stopwatches are not saved: {e}");
}
}
pub fn ids(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.watches.keys().cloned().collect()
}
    /// `add`: false when the id exists.
pub fn create(self: *Self, id: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.watches.contains_key(id) {
    // rust: return false;
}
    // rust: self.watches.insert(
    // rust: id.to_owned(),
    // rust: Stopwatch {
    // rust: creation_time: current_time(),
    // rust: accumulated: 0,
    // rust: },
    // rust: );
    // rust: self.dirty = true;
    // rust: true
}
    /// `update` with a fresh stopwatch.
pub fn restart(self: *Self, id: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(w) = self.watches.get_mut(id) else {
    // rust: return false;
}
    // rust: *w = Stopwatch {
    // rust: creation_time: current_time(),
    // rust: accumulated: 0,
}
    // rust: self.dirty = true;
    // rust: true
}
pub fn remove(self: *Self, id: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let removed = self.watches.remove(id).is_some();
    // rust: self.dirty |= removed;
    // rust: removed
}
    /// `Stopwatch.elapsedSeconds`.
pub fn elapsed_seconds(self: *Self, id: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.watches
    // rust: .get(id)
    // rust: .map(|w| w.elapsed_ms(current_time()) as f64 / 1000.0)
}
}
