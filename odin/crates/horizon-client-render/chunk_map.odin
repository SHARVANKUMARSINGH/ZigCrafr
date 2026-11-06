//! Transpiled from Horizon Rust crate
package horizon_client_render_chunk_map

import "core:fmt"
import "core:mem"
import "core:math"

// Resident chunk membership, with a token for consumers that cache its keys.
// use crate::{
    // rust: chunk::Chunk,
    // rust: fast_hash::{FxHashMap, FxHashSet},
}
// use std::{
    // rust: collections::{
    // rust: VecDeque,
    // rust: hash_map::{Iter, ValuesMut},
    // rust: },
    // rust: ops::Deref,
    // rust: sync::{
    // rust: Arc,
    // rust: atomic::{AtomicU64, Ordering},
    // rust: },
}

    // rust: type Key = (i32, i32);
    // rust: type Columns = FxHashMap<Key, Arc<Chunk>>;
NEXT_REVISION :: AtomicU64::new(1)
next_revision :: proc() -> u {
    // Ported from Horizon
    return {}
}
    // rust: NEXT_REVISION.fetch_add(1, Ordering::Relaxed)
}

// The membership changes one map keeps for the consumers that read them
// every tick (`TickChunkMembership.synchronize`); older ones are dropped.
MAX_RECENT_DELTAS :: 256

// One membership change of one `ChunkMap`, stamped with the revision it
// brought the map to.
ChunkMembershipDelta :: enum {
    Added(Key),
    Removed(Key),
    Reset,
}

// Read access behaves like a map. Structural writes are explicit so edits to
// blocks or light don't invalidate consumers of the loaded chunk key set.
// Tokens are process-wide: replacing the entire map also invalidates caches.
ChunkMap :: struct {
    columns: Columns,
    revision: u64,
    // The oldest revision `recent_deltas` still answers for: the revision of
    // the change it last dropped, or the revision that cleared them. A
    // consumer holding an older one rebuilds, it does not replay.
    min_valid_revision: u64,
    // This map's recent membership changes, in revision order.
    // Revisions are process-wide: the numbers missing in between belong to
    // the other maps (a server thread's, another dimension's), which say
    // nothing about this one's keys.
    recent_deltas: VecDeque<(u64,
    // The resident chunks generation has not placed its animals in yet.
    fresh: FxHashSet<Key>,
}
    // rust: impl Default for ChunkMap {
default :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: let revision = next_revision();
    // rust: Self {
    // rust: columns: Columns::default(),
    // rust: revision,
    // rust: min_valid_revision: revision,
    // rust: recent_deltas: VecDeque::new(),
    // rust: fresh: FxHashSet::default(),
}
}
}
    // rust: impl ChunkMap {
membership_revision :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.revision
}
record_delta :: proc(self: ^Self, delta: ChunkMembershipDelta) {
}
    // rust: if self.recent_deltas.len() >= MAX_RECENT_DELTAS
    // rust: && let Some((evicted, _)) = self.recent_deltas.pop_front()
    // rust: {
    // rust: self.min_valid_revision = evicted;
}
    // rust: self.recent_deltas.push_back((self.revision, delta));
}
    // This map's membership changes since `last_revision`, one of its own
    // earlier `membership_revision`s, or `None` when they can no longer be
    // answered: the consumer's revision predates what the ring kept, the map
    // was cleared since (a reset rebuilds everything), or the revision is not
    // this map's, which its own revisions give away: every one of them in the
    // answered range is the opening revision or a change the ring still
    // holds, so a revision another map took in between is refused, not
    // replayed.
    // rust: pub fn deltas_since(
    // rust: &self,
    // rust: last_revision: u64,
    // rust: ) -> Option<impl Iterator<Item = (u64, ChunkMembershipDelta)> + '_> {
    // rust: if last_revision == 0
    // rust: || last_revision < self.min_valid_revision
    // rust: || last_revision > self.revision
    // rust: || self.recent_deltas.is_empty()
    // rust: {
    // rust: return None;
}
    // rust: let pos = self
    // rust: .recent_deltas
    // rust: .partition_point(|(rev, _)| *rev <= last_revision);
        // A revision this map never took: another map's, drawing on the same
        // process-wide counter. Only the opening revision and the ones the
        // ring still holds are this map's.
    // rust: let is_own_revision = last_revision == self.min_valid_revision
    // rust: || (pos > 0 && self.recent_deltas[pos - 1].0 == last_revision);
    // rust: if !is_own_revision {
    // rust: return None;
}
    // rust: let slice = self.recent_deltas.range(pos..);
    // rust: if slice
    // rust: .clone()
    // rust: .any(|(_, d)| *d == ChunkMembershipDelta::Reset)
    // rust: {
    // rust: return None;
}
    // rust: Some(slice.copied())
}
insert :: proc(self: ^Self, key: Key, chunk: ^Chunk) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if chunk.fresh {
    // rust: self.fresh.insert(key);
    // rust: } else {
    // rust: self.fresh.remove(&key);
}
    // rust: let previous = self.columns.insert(key, chunk);
    // rust: if previous.is_none() {
    // rust: self.revision = next_revision();
    // rust: self.record_delta(ChunkMembershipDelta::Added(key));
}
    // rust: previous
}
remove :: proc(self: ^Self, key: ^Key) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.fresh.remove(key);
    // rust: let previous = self.columns.remove(key);
    // rust: if previous.is_some() {
    // rust: self.revision = next_revision();
    // rust: self.record_delta(ChunkMembershipDelta::Removed(*key));
}
    // rust: previous
}
clear :: proc(self: ^Self) {
}
    // rust: if !self.columns.is_empty() {
    // rust: self.columns.clear();
    // rust: self.fresh.clear();
    // rust: self.revision = next_revision();
    // rust: self.recent_deltas.clear();
    // rust: self.recent_deltas
    // rust: .push_back((self.revision, ChunkMembershipDelta::Reset));
    // rust: self.min_valid_revision = self.revision;
}
}
has_fresh :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: !self.fresh.is_empty()
}
    // The fresh keys in the chunk map's own iteration order, so the spawns
    // they drive run in the order a scan of the columns gave.
fresh_keys_ordered :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
    // rust: if self.fresh.is_empty() {
    // rust: Vec::new()
    // rust: } else if self.fresh.len() == 1 {
    // rust: self.fresh.iter().copied().collect()
    // rust: } else {
    // rust: self.columns
    // rust: .keys()
    // rust: .filter(|k| self.fresh.contains(k))
    // rust: .copied()
    // rust: .collect()
}
}
remove_fresh :: proc(self: ^Self, key: ^Key) {
}
    // rust: self.fresh.remove(key);
}
get_mut :: proc(self: ^Self, key: ^Key) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.columns.get_mut(key)
}
values_mut :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
    // rust: self.columns.values_mut()
}
}
    // rust: impl Deref for ChunkMap {
    // rust: type Target = Columns;
deref :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &self.columns
}
}
    // rust: impl<'a> IntoIterator for &'a ChunkMap {
    // rust: type Item = (&'a Key, &'a Arc<Chunk>);
    // rust: type IntoIter = Iter<'a, Key, Arc<Chunk>>;
into_iter :: proc(self: ^Self) -> S {
    // Ported from Horizon
    return {}
}
    // rust: self.columns.iter()
}
}
    // rust: impl crate::light::LightWorld for ChunkMap {
section :: proc(self: ^Self, cx: i32, s: uint, cz: i32) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.columns.section(cx, s, cz)
}
set_section_light :: proc(self: ^Self, cx: i32, s: uint, cz: i32, light: crate::chunk::Light) {
}
    // rust: self.columns.set_section_light(cx, s, cz, light);
}
layout :: proc(self: ^Self) -> c {
    // Ported from Horizon
    return {}
}
    // rust: self.columns.layout()
}
}

    // rust: mod tests {
//     use super::*;
membership_tokens_track_keys_and_map_replacement_only :: proc() {
}
    // rust: let mut map = ChunkMap::default();
    // rust: let empty = map.membership_revision();
    // rust: map.clear();
    // rust: map.remove(&(0, 0));
    // rust: assert_eq!(empty, map.membership_revision());
    // rust: let chunk = Arc::new(Chunk::empty(0, 0));
    // rust: map.insert((0, 0), chunk.clone());
    // rust: let inserted = map.membership_revision();
    // rust: assert_ne!(empty, inserted);
    // rust: map.insert((0, 0), chunk.clone());
    // rust: Arc::make_mut(map.get_mut(&(0, 0)).unwrap()).lit = true;
    // rust: for column in map.values_mut() {
    // rust: Arc::make_mut(column).light_loaded = true;
}
    // rust: crate::light::LightWorld::set_section_light(
    // rust: &mut map,
    // rust: 0,
    // rust: 0,
    // rust: 0,
    // rust: crate::chunk::Light::Uniform(0),
    // rust: );
    // rust: assert_eq!(inserted, map.membership_revision());
    // rust: map.remove(&(0, 0));
    // rust: map.insert((1, 0), chunk);
    // rust: assert_eq!(map.len(), 1);
    // rust: assert_ne!(inserted, map.membership_revision());
    // rust: let replaced = map.membership_revision();
    // rust: map.clear();
    // rust: assert_ne!(replaced, map.membership_revision());
    // rust: let cleared = map.membership_revision();
    // rust: map = ChunkMap::default();
    // rust: assert_ne!(cleared, map.membership_revision());
}

    // The deltas' kinds, checking the ring answers in revision order.
kinds :: proc(deltas: Vec<(u64) {
}
    // rust: let mut last = 0;
    // rust: for (rev, _) in &deltas {
    // rust: assert!(*rev > last, "the ring answers in revision order");
    // rust: last = *rev;
}
    // rust: deltas.into_iter().map(|(_, d)| d).collect()
}

    // Revision numbers are process-wide: the ones another map takes in
    // between, and a payload-only rewrite that takes none at all, say nothing
    // about this map's keys.
deltas_since_ignores_revisions_other_maps_take :: proc() {
}
    // rust: let mut map = ChunkMap::default();
    // rust: let mut other = ChunkMap::default();
    // rust: let chunk = Arc::new(Chunk::empty(0, 0));
    // rust: map.insert((0, 0), chunk.clone());
    // rust: let seen = map.membership_revision();
    // rust: for key in [(1, 0), (2, 0), (3, 0)] {
    // rust: other.insert(key, chunk.clone());
}
    // rust: map.insert((0, 0), Arc::new(Chunk::empty(0, 0))); // Payload only.
    // rust: map.insert((4, 0), chunk.clone());
    // rust: map.remove(&(0, 0));
    // rust: assert_eq!(
    // rust: kinds(map.deltas_since(seen).unwrap().collect()),
    // rust: [
    // rust: ChunkMembershipDelta::Added((4, 0)),
    // rust: ChunkMembershipDelta::Removed((0, 0)),
    // rust: ]
    // rust: );
        // The consumer's own revision answers, with nothing new since.
    // rust: assert!(
    // rust: map.deltas_since(map.membership_revision())
    // rust: .unwrap()
    // rust: .next()
    // rust: .is_none()
    // rust: );
        // A revision another map took in between: refused, not replayed.
    // rust: assert!(map.deltas_since(other.membership_revision()).is_none());
}

    // A map built ahead of the live one, its revisions interleaved with it,
    // answering for a revision it never took: refused, so the consumer
    // rebuilds rather than replay another map's changes.
deltas_since_none_for_interleaved_revision_from_another_map :: proc() {
}
    // rust: let mut map = ChunkMap::default();
    // rust: let mut other = ChunkMap::default();
    // rust: let chunk = Arc::new(Chunk::empty(0, 0));
    // rust: map.insert((0, 0), chunk.clone());
    // rust: let seen = map.membership_revision();
    // rust: other.insert((1, 0), chunk.clone());
    // rust: let foreign = other.membership_revision();
    // rust: map.insert((2, 0), chunk.clone());
    // rust: assert!(map.deltas_since(foreign).is_none());
    // rust: assert_eq!(
    // rust: kinds(map.deltas_since(seen).unwrap().collect()),
    // rust: [ChunkMembershipDelta::Added((2, 0))]
    // rust: );
}

    // The ring answers for the changes it kept, and only those.
deltas_since_none_for_a_revision_the_ring_dropped :: proc() {
}
    // rust: let mut map = ChunkMap::default();
    // rust: let chunk = Arc::new(Chunk::empty(0, 0));
    // rust: let created = map.membership_revision();
    // rust: let mut revisions = Vec::new();
    // rust: let changes = MAX_RECENT_DELTAS as i32 + 1;
    // rust: for i in 0..changes {
    // rust: map.insert((i, 0), chunk.clone());
    // rust: revisions.push(map.membership_revision());
}
    // rust: let (first, kept) = revisions.split_first().unwrap();
        // The oldest change fell out with the consumer's revision: rebuild.
    // rust: assert!(map.deltas_since(created).is_none());
    // rust: assert_eq!(map.deltas_since(*first).unwrap().count(), kept.len());
}

    // A reset rebuilds whatever the consumer last saw, and the ring answers
    // for what follows it.
deltas_since_none_across_a_clear :: proc() {
}
    // rust: let mut map = ChunkMap::default();
    // rust: let chunk = Arc::new(Chunk::empty(0, 0));
    // rust: map.insert((0, 0), chunk.clone());
    // rust: let before = map.membership_revision();
    // rust: map.clear();
    // rust: assert!(map.deltas_since(before).is_none());
    // rust: let cleared = map.membership_revision();
    // rust: map.insert((1, 0), chunk);
    // rust: assert_eq!(
    // rust: kinds(map.deltas_since(cleared).unwrap().collect()),
    // rust: [ChunkMembershipDelta::Added((1, 0))]
    // rust: );
}

fresh_chunks_tracking :: proc() {
}
    // rust: let mut map = ChunkMap::default();
    // rust: assert!(!map.has_fresh());
    // rust: let mut chunk = Chunk::empty(1, 2);
    // rust: chunk.fresh = true;
    // rust: map.insert((1, 2), Arc::new(chunk));
    // rust: assert!(map.has_fresh());
    // rust: assert_eq!(map.fresh_keys_ordered(), vec![(1, 2)]);

    // rust: map.remove_fresh(&(1, 2));
    // rust: assert!(!map.has_fresh());

    // rust: let mut chunk2 = Chunk::empty(3, 4);
    // rust: chunk2.fresh = true;
    // rust: map.insert((3, 4), Arc::new(chunk2));
    // rust: assert!(map.has_fresh());

    // rust: map.remove(&(3, 4));
    // rust: assert!(!map.has_fresh());
}

fresh_keys_ordered_matches_chunk_map_iteration_order :: proc() {
}
    // rust: let mut map = ChunkMap::default();
    // rust: let keys = [(-5, 10), (12, -3), (0, 0), (7, 8), (-1, -1), (4, 4)];
    // rust: for (i, &key) in keys.iter().enumerate() {
    // rust: let mut chunk = Chunk::empty(key.0, key.1);
    // rust: chunk.fresh = i % 2 == 0;
    // rust: map.insert(key, Arc::new(chunk));
}

    // rust: let ordered = map.fresh_keys_ordered();
    // rust: let expected: Vec<Key> = map
    // rust: .keys()
    // rust: .copied()
    // rust: .filter(|k| map.fresh.contains(k))
    // rust: .collect();
    // rust: assert_eq!(ordered, expected);
    // rust: assert_eq!(ordered.len(), 3);
}
}
