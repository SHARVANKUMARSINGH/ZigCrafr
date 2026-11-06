//! Transpiled from Horizon Rust crate
package horizon_client_stopwatches

import "core:fmt"
import "core:mem"
import "core:math"

// `Stopwatches`: the named wall-clock timers of `/stopwatch`, saved in
// `data/minecraft/stopwatches.dat` as the elapsed milliseconds of each.
// use crate::save;
// use horizon_world::nbt::{Compound, JavaString, Tag};
// use std::{
    // rust: collections::BTreeMap,
    // rust: path::{Path, PathBuf},
    // rust: sync::OnceLock,
    // rust: time::Instant,
}

// `Util.getMillis`, measured from the first call.
current_time :: proc() -> i {
    // Ported from Horizon
    return {}
}
START :: OnceLock::new()
    // rust: START.get_or_init(Instant::now).elapsed().as_millis() as i64
}

Stopwatch :: struct {
    creation_time: i64,
    accumulated: i64,
}
    // rust: impl Stopwatch {
elapsed_ms :: proc(self: ^Self, now: i64) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.accumulated + (now - self.creation_time)
}
}

Stopwatches :: struct {
    watches: BTreeMap<string,
    dirty: bool,
}
file :: proc(root: ^Path) -> P {
    // Ported from Horizon
    return {}
}
    // rust: root.join("data/minecraft/stopwatches.dat")
}
    // rust: impl Stopwatches {
load :: proc(root: ^Path) -> S {
    // Ported from Horizon
    return {}
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
save :: proc(self: ^Self, root: ^Path) {
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
ids :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
    // rust: self.watches.keys().cloned().collect()
}
    // `add`: false when the id exists.
create :: proc(self: ^Self, id: string) -> b {
    // Ported from Horizon
    return {}
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
    // `update` with a fresh stopwatch.
restart :: proc(self: ^Self, id: string) -> b {
    // Ported from Horizon
    return {}
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
remove :: proc(self: ^Self, id: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let removed = self.watches.remove(id).is_some();
    // rust: self.dirty |= removed;
    // rust: removed
}
    // `Stopwatch.elapsedSeconds`.
elapsed_seconds :: proc(self: ^Self, id: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.watches
    // rust: .get(id)
    // rust: .map(|w| w.elapsed_ms(current_time()) as f64 / 1000.0)
}
}
