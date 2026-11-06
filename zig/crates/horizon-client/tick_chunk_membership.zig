//! Transpiled from Horizon Rust crate
//! Module: horizon-client_tick_chunk_membership
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Tick scheduler membership, invalidated by resident key changes or resets.
// use crate::{
    // rust: chunk_map::{ChunkMap, ChunkMembershipDelta},
    // rust: fast_hash::FxHashSet,
}

    // rust: type Key = (i32, i32);

pub const TickChunkMembership = struct {
    keys: FxHashSet<Key>,
    revision: ?u64,
    added: std.ArrayList(Key),
    removed: std.ArrayList(Key),
    /// Loaded chunks with saved ticks that have not started ticking yet
    /// (`LevelChunkTicks.pendingTicks`, unpacked by `startTickingChunk`).
    waiting: FxHashSet<Key>,
};

    // rust: impl TickChunkMembership {
    /// A scheduler reset must re-register resident chunks even if the world did
    /// not change. Keep this invalidation with the keys so callers cannot forget.
pub fn clear(self: *Self) void {
}
    // rust: self.keys.clear();
    // rust: self.revision = None;
    // rust: self.added.clear();
    // rust: self.removed.clear();
    // rust: self.waiting.clear();
}

    /// Returns false in O(1) when resident membership is unchanged. On change,
    /// update the existing set and record only registration/removal deltas.
pub fn synchronize(self: *Self, chunks: *ChunkMap) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let revision = chunks.membership_revision();
    // rust: if self.revision == Some(revision) {
    // rust: return false;
}
    // rust: self.added.clear();
    // rust: self.removed.clear();

    // rust: if let Some(deltas) = self.revision.and_then(|rev| chunks.deltas_since(rev)) {
    // rust: let mut removed_waiting = FxHashSet::default();
    // rust: for (_, delta) in deltas {
    // rust: match delta {
    // rust: ChunkMembershipDelta::Added(key) => {
    // rust: if let Some(pos) = self.removed.iter().position(|&k| k == key) {
                            // The chunk is back where it was: the removal it
                            // cancels is no news, and it keeps its saved ticks.
    // rust: self.removed.swap_remove(pos);
    // rust: self.keys.insert(key);
    // rust: if removed_waiting.remove(&key) {
    // rust: self.waiting.insert(key);
}
    // rust: } else if self.keys.insert(key) {
    // rust: self.added.push(key);
}
}
    // rust: ChunkMembershipDelta::Removed(key) => {
    // rust: if let Some(pos) = self.added.iter().position(|&k| k == key) {
    // rust: self.added.swap_remove(pos);
    // rust: self.keys.remove(&key);
    // rust: self.waiting.remove(&key);
    // rust: } else if self.keys.remove(&key) {
    // rust: self.removed.push(key);
    // rust: if self.waiting.remove(&key) {
    // rust: removed_waiting.insert(key);
}
}
}
    // rust: ChunkMembershipDelta::Reset => unreachable!(),
}
}
    // rust: self.revision = Some(revision);
    // rust: return true;
}

    // rust: self.keys.retain(|key| {
    // rust: if chunks.contains_key(key) {
    // rust: true
    // rust: } else {
    // rust: self.removed.push(*key);
    // rust: self.waiting.remove(key);
    // rust: false
}
    // rust: });
    // rust: for &key in chunks.keys() {
    // rust: if self.keys.insert(key) {
    // rust: self.added.push(key);
}
}
    // rust: self.revision = Some(revision);
    // rust: true
}

    /// Allows registration to borrow the owning Game without cloning its set.
pub fn take_added(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: std::mem::take(&mut self.added)
}

    /// Retain scratch capacity after registration.
pub fn recycle_added(self: *Self, mut added: std.ArrayList(Key)) void {
}
    // rust: added.clear();
    // rust: self.added = added;
}

pub fn removed(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: &self.removed
}

    /// `key` was registered with saved ticks to unpack once it ticks.
pub fn wait(self: *Self, key: Key) void {
}
    // rust: self.waiting.insert(key);
}

    /// The waiting chunks that `ticking` says now tick, no longer waiting.
pub fn start_ticking(self: *Self, mut ticking: impl FnMut(Key) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.waiting.is_empty() {
    // rust: return Vec::new();
}
    // rust: let started: Vec<Key> = self
    // rust: .waiting
    // rust: .iter()
    // rust: .copied()
    // rust: .filter(|&k| ticking(k))
    // rust: .collect();
    // rust: for key in &started {
    // rust: self.waiting.remove(key);
}
    // rust: started
}
}

    // rust: mod tests {
//     use super::*;
//     use crate::chunk::Chunk;
//     use std::{collections::HashSet, sync::Arc};

pub fn compare(cache: *mut TickChunkMembership, old: *mut std.AutoHashMap(Key, void), map: *ChunkMap) void {
}
    // rust: let loaded: HashSet<_> = map.keys().copied().collect();
    // rust: let expected_added: HashSet<_> = loaded.difference(old).copied().collect();
    // rust: let expected_removed: HashSet<_> = old.difference(&loaded).copied().collect();
    // rust: if cache.synchronize(map) {
    // rust: let added = cache.take_added();
    // rust: assert_eq!(
    // rust: added.iter().copied().collect::<HashSet<_>>(),
    // rust: expected_added
    // rust: );
    // rust: assert_eq!(
    // rust: cache.removed().iter().copied().collect::<HashSet<_>>(),
    // rust: expected_removed
    // rust: );
    // rust: cache.recycle_added(added);
    // rust: } else {
    // rust: assert!(expected_added.is_empty() && expected_removed.is_empty());
}
    // rust: assert_eq!(cache.keys.iter().copied().collect::<HashSet<_>>(), loaded);
    // rust: *old = loaded;
}

pub fn matches_old_deltas_through_load_unload_replacement_and_reset() void {
}
    // rust: let mut map = ChunkMap::default();
    // rust: let chunk = Arc::new(Chunk::empty(0, 0));
    // rust: let mut cache = TickChunkMembership::default();
    // rust: let mut old = HashSet::new();
    // rust: compare(&mut cache, &mut old, &map);
    // rust: assert!(!cache.synchronize(&map));
    // rust: for key in [(-16, -8), (0, 0), (12, -1)] {
    // rust: map.insert(key, chunk.clone());
    // rust: compare(&mut cache, &mut old, &map);
}
    // rust: map.remove(&(-16, -8));
    // rust: map.insert((-15, -8), chunk.clone()); // Same count, different key.
    // rust: compare(&mut cache, &mut old, &map);
    // rust: map.insert((0, 0), Arc::new(Chunk::empty(0, 0)));
    // rust: assert!(!cache.synchronize(&map)); // Payload replacement needs no registration.
    // rust: cache.clear();
    // rust: old.clear(); // Scheduler replaced with unchanged resident map.
    // rust: compare(&mut cache, &mut old, &map);
    // rust: map.clear();
    // rust: compare(&mut cache, &mut old, &map);
    // rust: map = ChunkMap::default();
    // rust: assert!(cache.synchronize(&map)); // Distinct empty world has distinct token.
    // rust: map.insert((-2, 4), chunk);
    // rust: compare(&mut cache, &mut old, &map);
    // rust: cache.clear();
    // rust: old.clear();
    // rust: map = ChunkMap::default();
    // rust: compare(&mut cache, &mut old, &map);
}

pub fn waiting_chunks_start_ticking_once_and_unloaded_ones_stop_waiting() void {
}
    // rust: let mut map = ChunkMap::default();
    // rust: let mut cache = TickChunkMembership::default();
    // rust: for key in [(0, 0), (1, 0), (2, 0)] {
    // rust: map.insert(key, Arc::new(Chunk::empty(key.0, key.1)));
    // rust: cache.wait(key);
}
    // rust: cache.synchronize(&map);
    // rust: assert_eq!(cache.start_ticking(|k| k == (0, 0)), vec![(0, 0)]);
    // rust: assert!(cache.start_ticking(|k| k == (0, 0)).is_empty());
    // rust: map.remove(&(1, 0));
    // rust: cache.synchronize(&map);
    // rust: let mut started = cache.start_ticking(|_| true);
    // rust: started.sort_unstable();
    // rust: assert_eq!(started, vec![(2, 0)]);
}

pub fn scheduler_keeps_saved_ticks_on_stable_membership_and_removes_unloaded_chunks() void {
}
//         use horizon_core::{
    // rust: position::{BlockPos, ChunkPos},
    // rust: ticks::{ChunkTicks, SavedTick, TickPriority, TickTypeId},
}
//         use horizon_world::level::Ticks;

pub fn register(ticks: *mut Ticks, key: Key) void {
}
    // rust: let pos = ChunkPos::new(key.0, key.1);
    // rust: let saved = SavedTick {
    // rust: kind: TickTypeId(1),
    // rust: pos: BlockPos::new(key.0 * 16, 0, key.1 * 16),
    // rust: delay: 5,
    // rust: priority: TickPriority::Normal,
}
    // rust: ticks
    // rust: .add_chunk(
    // rust: pos,
    // rust: ChunkTicks::from_saved(vec![saved]),
    // rust: ChunkTicks::from_saved(vec![saved]),
    // rust: )
    // rust: .unwrap();
    // rust: ticks.blocks.unpack_chunk(pos, 100);
    // rust: ticks.fluids.unpack_chunk(pos, 100);
}
    // rust: let mut map = ChunkMap::default();
    // rust: let chunk = Arc::new(Chunk::empty(0, 0));
    // rust: let mut cache = TickChunkMembership::default();
    // rust: let mut old_keys = HashSet::new();
    // rust: let mut old_ticks = Ticks::default();
    // rust: let mut new_ticks = Ticks::default();
    // rust: let keys = [(-3, -1), (2, 4), (-2, -1)];
    // rust: for step in 0..7 {
    // rust: match step {
    // rust: 0 => {
    // rust: map.insert(keys[0], chunk.clone());
    // rust: map.insert(keys[1], chunk.clone());
}
    // rust: 2 => {
    // rust: map.remove(&keys[0]);
    // rust: map.insert(keys[2], chunk.clone());
}
    // rust: 3 => {
    // rust: map.insert(keys[1], chunk.clone());
}
    // rust: 4 => {
                    // Reset only the scheduler: resident token is unchanged.
    // rust: new_ticks = Ticks::default();
    // rust: old_ticks = Ticks::default();
    // rust: cache.clear();
    // rust: old_keys.clear();
}
    // rust: 5 => {
    // rust: map.clear();
}
    // rust: 6 => {
    // rust: map = ChunkMap::default();
    // rust: map.insert(keys[0], chunk.clone());
    // rust: new_ticks = Ticks::default();
    // rust: old_ticks = Ticks::default();
    // rust: cache.clear();
    // rust: old_keys.clear();
}
    // rust: _ => {}
}
    // rust: let loaded: HashSet<_> = map.keys().copied().collect();
    // rust: for &key in loaded.difference(&old_keys) {
    // rust: register(&mut old_ticks, key);
}
    // rust: for &key in old_keys.difference(&loaded) {
    // rust: old_ticks.remove_chunk(ChunkPos::new(key.0, key.1));
}
    // rust: old_keys = loaded;
    // rust: if cache.synchronize(&map) {
    // rust: let added = cache.take_added();
    // rust: for &key in &added {
    // rust: register(&mut new_ticks, key);
}
    // rust: for &key in cache.removed() {
    // rust: new_ticks.remove_chunk(ChunkPos::new(key.0, key.1));
}
    // rust: cache.recycle_added(added);
}
    // rust: for key in keys {
    // rust: let pos = ChunkPos::new(key.0, key.1);
    // rust: for (old, new) in [
    // rust: (&old_ticks.blocks, &new_ticks.blocks),
    // rust: (&old_ticks.fluids, &new_ticks.fluids),
    // rust: ] {
    // rust: assert_eq!(
    // rust: old.chunk(pos).map(|c| c.queued()),
    // rust: new.chunk(pos).map(|c| c.queued())
    // rust: );
    // rust: assert_eq!(new.chunk(pos).is_some(), map.contains_key(&key));
}
}
}
}

    /// A removal the next addition cancels puts the chunk back where it was,
    /// saved ticks included: the delta replay answers as the full scan does.
pub fn cancel_removal_between_synchronizations_restores_membership_and_waiting() void {
}
    // rust: let mut map = ChunkMap::default();
    // rust: let chunk = Arc::new(Chunk::empty(0, 0));
    // rust: let mut cache = TickChunkMembership::default();
    // rust: let key = (3, 7);

    // rust: map.insert(key, chunk.clone());
    // rust: assert!(cache.synchronize(&map));
    // rust: assert_eq!(cache.take_added(), vec![key]);
    // rust: cache.wait(key);
    // rust: assert!(cache.waiting.contains(&key));

    // rust: map.remove(&key);
    // rust: map.insert(key, chunk);

    // rust: assert!(cache.synchronize(&map));
    // rust: assert!(cache.take_added().is_empty());
    // rust: assert!(cache.removed().is_empty());
    // rust: assert!(cache.keys.contains(&key));
    // rust: assert!(cache.waiting.contains(&key));
    // rust: assert_eq!(cache.start_ticking(|k| k == key), vec![key]);

        // The unload after that one is still news.
    // rust: map.remove(&key);
    // rust: assert!(cache.synchronize(&map));
    // rust: assert_eq!(cache.removed(), &[key]);
    // rust: assert!(!cache.keys.contains(&key));
}
}
