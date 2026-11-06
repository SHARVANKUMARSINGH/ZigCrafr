//! Transpiled from Horizon Rust crate
package horizon_world_decoration_order

import "core:fmt"
import "core:mem"
import "core:math"

// The order in which chunks around a player are decorated.
//
// Biome decoration is order dependent: a chunk's features write into its
// eight neighbours, and a tree, ore blob or sculk patch placed first changes
// where (and whether) the next chunk's features fit, and so how many random
// draws they take. Vanilla decorates on a single `worldgen` executor, in an
// order its chunk system makes nearly deterministic: player loading tickets
// are added nearest first, four at a time (`ThrottlingChunkTaskDispatcher`),
// generation tasks run by ticket level, and each `ChunkGenerationTask`
// decorates its square layer x-outer, z-inner. Two vanilla runs on the same
// seed decorate the same chunks around a teleported player with about 6% of
// the overlapping chunk pairs swapped; a world decorated in any other order
// grows visibly different forests, ore veins and sculk.
//
// [`DecorationOrder`] replays that scheduler for a player standing still,
// with every asynchronous step finishing at once: player tickets in rings of
// Chebyshev distance, each ring in the iteration order of the fastutil hash
// set that queues them (`PlayerTicketTracker.toUpdate`, at the 8192-slot
// capacity a single player's area gives it), at most four in flight; each
// ticket raises the levels around it, a chunk at level 33 or less gets a
// FULL task that decorates its 3x3 square, one at level 34 an
// INITIALIZE_LIGHT task that decorates itself; tasks run by level, then in
// the order they were queued, and a ticket is released once the 5x5 square
// around it is FULL. Against vanilla's own order (JFR
// `minecraft.ChunkGeneration` events) it swaps as many overlapping pairs as
// a second vanilla run does.
//
// Only chunks within two of each other interact (their write regions
// overlap), so a chunk may be decorated as soon as no lower-ranked chunk
// within two of it is still waiting: [`DecorationOrder::blocked`]. Chunks
// further apart still decorate in parallel.
// use horizon_core::fast_hash::FxHashMap;
// use std::collections::VecDeque;

DecorationOrder :: struct {
    // Looked up 24 times per chunk `blocked` is asked about, each time the
    // streamer schedules decoration: a fast hasher, not SipHash.
    rank: FxHashMap<(i32,
    next: u64,
}

    // rust: impl DecorationOrder {
    // The rank of a chunk; lower ranks decorate first.
rank :: proc(self: ^Self, x: i32, z: i32) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.rank.get(&(x, z)).copied()
}

    // Rank the chunks a player at `center` with view distance `radius`
    // gets decorated, in the order vanilla decorates them, after every chunk
    // ranked before; `decorated` ones are skipped. Ranked chunks that are
    // still undecorated are ranked again, as vanilla re-sorts queued tickets
    // when the player moves.
    // rust: pub fn reassign(
    // rust: &mut self,
    // rust: center: (i32, i32),
    // rust: radius: i32,
    // rust: decorated: impl Fn(i32, i32) -> bool,
    // rust: ) {
    // rust: for (x, z) in vanilla_order(center, radius) {
    // rust: if !decorated(x, z) {
    // rust: self.rank.insert((x, z), self.next);
    // rust: self.next += 1;
}
}
}

    // Rank a chunk that no ticket reached (forced or extra areas), after
    // every ranked one.
rank_or_append :: proc(self: ^Self, x: i32, z: i32) -> u {
    // Ported from Horizon
    return {}
}
    // rust: let next = &mut self.next;
    // rust: *self.rank.entry((x, z)).or_insert_with(|| {
    // rust: *next += 1;
    // rust: *next - 1
    // rust: })
}

    // Whether a lower-ranked chunk within two of `(x, z)` still has to be
    // decorated (`pending`) first.
blocked :: proc(self: ^Self, x: i32, z: i32, pending: impl Fn(i32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let Some(own) = self.rank(x, z) else {
    // rust: return false;
}
    // rust: (-2..=2).any(|dz| {
    // rust: (-2..=2).any(|dx| {
    // rust: (dx, dz) != (0, 0)
    // rust: && self.rank(x + dx, z + dz).is_some_and(|r| r < own)
    // rust: && pending(x + dx, z + dz)
    // rust: })
    // rust: })
}

    // Forget the ranks `keep` rejects.
retain :: proc(self: ^Self, mut keep: impl FnMut(i32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.rank.retain(|&(x, z), _| keep(x, z));
}

    // Every ranked chunk, lowest rank first.
ordered :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut all: Vec<_> = self.rank.iter().map(|(&k, &r)| (r, k)).collect();
    // rust: all.sort_unstable();
    // rust: all.into_iter().map(|(_, k)| k).collect()
}
}

// `ThrottlingChunkTaskDispatcher`'s limit for player loading tickets.
TICKETS_IN_FLIGHT :: 4
// Capacity of `PlayerTicketTracker.toUpdate` around one player.
TICKET_SET_CAPACITY :: 8192
// `ChunkLevel.byStatus(ENTITY_TICKING)`, the player loading ticket's level.
TICKET_LEVEL :: 31
// The highest level that gets a FULL task, and the INITIALIZE_LIGHT level.
FULL_LEVEL :: 33
LIGHT_LEVEL :: 34

// `HashCommon.mix(ChunkPos.pack(x, z))`.
ticket_hash :: proc(x: i32, z: i32) -> u {
    // Ported from Horizon
    return {}
}
    // rust: let packed = u64::from(x as u32) | (u64::from(z as u32) << 32);
    // rust: let h = packed.wrapping_mul(0x9E37_79B9_7F4A_7C15);
    // rust: let h = h ^ (h >> 32);
    // rust: h ^ (h >> 16)
}

// The chunks decorated around a player at `center`, in vanilla's order.
vanilla_order :: proc(center: (i32) {
}
//     use std::cmp::Reverse;
    // rust: let mut tickets: Vec<(i32, i32)> = (-radius..=radius)
    // rust: .flat_map(|dx| (-radius..=radius).map(move |dz| (center.0 + dx, center.1 + dz)))
    // rust: .collect();
    // A fastutil open hash set iterates its slots from the last to the first.
    // rust: tickets.sort_by_key(|&(x, z)| {
    // rust: (
    // rust: (x - center.0).abs().max((z - center.1).abs()),
    // rust: Reverse(ticket_hash(x, z) & (TICKET_SET_CAPACITY - 1)),
    // rust: )
    // rust: });
    // Every chunk this touches lies within `half` of the centre: tickets
    // reach `LIGHT_LEVEL - TICKET_LEVEL` further, and FULL tasks decorate
    // one more ring.
    // rust: let half = radius.max(0) + LIGHT_LEVEL - TICKET_LEVEL + 1;
    // rust: ticket_order(
    // rust: tickets.into(),
    // rust: TICKETS_IN_FLIGHT,
    // rust: (center.0 - half, center.1 - half),
    // rust: (2 * half + 1) as usize,
    // rust: )
}

// The decoration order of `tickets` (level 31) added in turn, at most
// `in_flight` at a time. Dense grids of `side` chunks from `origin` hold
// every chunk this touches, in place of hash maps.
    // rust: fn ticket_order(
    // rust: mut tickets: VecDeque<(i32, i32)>,
    // rust: in_flight: usize,
    // rust: origin: (i32, i32),
    // rust: side: usize,
    // rust: ) -> Vec<(i32, i32)> {
//     use std::cmp::Reverse;
//     use std::collections::BinaryHeap;
    // rust: let reach = LIGHT_LEVEL - TICKET_LEVEL;
    // rust: let cell = |(x, z): (i32, i32)| ((x - origin.0) as usize) * side + (z - origin.1) as usize;
    // rust: let mut active: Vec<(i32, i32)> = Vec::new();
    // Queued task per chunk (level, sequence), `NONE` when there is none;
    // stale heap entries are skipped.
NONE :: (i32::MAX, 0)
    // rust: let mut queued = vec![NONE; side * side];
    // rust: let mut heap = BinaryHeap::new();
    // rust: let mut sequence = 0u64;
    // rust: let mut full = vec![false; side * side];
    // rust: let mut seen = vec![false; side * side];
    // rust: let mut order = Vec::new();
    // Each ticket lowers the levels around it to 31 + its Chebyshev distance.
    // rust: let mut levels = vec![i32::MAX; side * side];
    // rust: let mut add = |ticket: (i32, i32),
    // rust: active: &mut Vec<(i32, i32)>,
    // rust: queued: &mut [(i32, u64)],
    // rust: heap: &mut BinaryHeap<Reverse<(i32, u64, (i32, i32))>>,
    // rust: full: &[bool]| {
    // rust: active.push(ticket);
    // rust: for x in ticket.0 - reach..=ticket.0 + reach {
    // rust: for z in ticket.1 - reach..=ticket.1 + reach {
    // rust: let own = TICKET_LEVEL + (x - ticket.0).abs().max((z - ticket.1).abs());
    // rust: let i = cell((x, z));
    // rust: levels[i] = levels[i].min(own);
    // rust: let l = levels[i];
    // rust: if full[i] {
    // rust: continue;
}
    // rust: if l < queued[i].0 {
    // rust: sequence += 1;
    // rust: queued[i] = (l, sequence);
    // rust: heap.push(Reverse((l, sequence, (x, z))));
}
}
}
}
    // rust: while active.len() < in_flight {
    // rust: let Some(t) = tickets.pop_front() else { break };
    // rust: add(t, &mut active, &mut queued, &mut heap, &full);
}
    // rust: while let Some(Reverse((l, s, chunk))) = heap.pop() {
    // rust: let i = cell(chunk);
    // rust: if queued[i] != (l, s) {
    // rust: continue;
}
    // rust: queued[i] = NONE;
    // rust: let r = i32::from(l <= FULL_LEVEL);
    // rust: for x in chunk.0 - r..=chunk.0 + r {
    // rust: for z in chunk.1 - r..=chunk.1 + r {
    // rust: let seen = &mut seen[cell((x, z))];
    // rust: if !*seen {
    // rust: *seen = true;
    // rust: order.push((x, z));
}
}
}
    // rust: if l <= FULL_LEVEL {
    // rust: full[i] = true;
}
    // rust: active.retain(|t| !(-2..=2).all(|dx| (-2..=2).all(|dz| full[cell((t.0 + dx, t.1 + dz))])));
    // rust: while active.len() < in_flight {
    // rust: let Some(t) = tickets.pop_front() else { break };
    // rust: add(t, &mut active, &mut queued, &mut heap, &full);
}
}
    // rust: order
}

// The chunks `/forceload add` over chunks `(x0, z0)..=(x1, z1)` decorates,
// in vanilla's order: ForceLoadCommand adds a FORCED ticket (level 31) per
// chunk, x-outer, z-inner, all at once.
forced_order :: proc(x0: i32, z0: i32, x1: i32, z1: i32) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let tickets = (x0..=x1)
    // rust: .flat_map(|x| (z0..=z1).map(move |z| (x, z)))
    // rust: .collect();
    // rust: let pad = LIGHT_LEVEL - TICKET_LEVEL + 1;
    // rust: let side = ((x1 - x0).max(z1 - z0) + 2 * pad + 1) as usize;
    // rust: ticket_order(tickets, usize::MAX, (x0 - pad, z0 - pad), side)
}

    // rust: mod tests {
//     use super::*;
//     use std::collections::HashMap;

    // Seed 8675309's geodes in chunks (-26, -1) and (14, -20) run into the
    // trial chambers of (-26, 0) and (14, -19); vanilla decorates the lower
    // z first, wherever the batch lies, so the chambers are drawn over them.
forced_chunks_decorate_x_outer_z_inner :: proc() {
}
    // rust: let rank = |order: &[(i32, i32)], c| order.iter().position(|&o| o == c).unwrap();
    // rust: let west = forced_order(-32, -16, -17, -1);
    // rust: assert!(rank(&west, (-26, -1)) < rank(&west, (-26, 0)));
    // rust: let east = forced_order(0, -32, 15, -17);
    // rust: assert!(rank(&east, (14, -20)) < rank(&east, (14, -19)));
    // rust: assert_eq!(west[0], (-33, -17));
    // rust: assert_eq!(west.len(), 22 * 22);
}

    // The hash map version this module had before its dense grids.
hashed_order :: proc(center: (i32) {
}
//         use std::cmp::Reverse;
//         use std::collections::{BinaryHeap, HashSet, VecDeque};
    // rust: let mut tickets: Vec<(i32, i32)> = (-radius..=radius)
    // rust: .flat_map(|dx| (-radius..=radius).map(move |dz| (center.0 + dx, center.1 + dz)))
    // rust: .collect();
        // A fastutil open hash set iterates its slots from the last to the first.
    // rust: tickets.sort_by_key(|&(x, z)| {
    // rust: (
    // rust: (x - center.0).abs().max((z - center.1).abs()),
    // rust: Reverse(ticket_hash(x, z) & (TICKET_SET_CAPACITY - 1)),
    // rust: )
    // rust: });
    // rust: let mut tickets: VecDeque<_> = tickets.into();
    // rust: let mut active: Vec<(i32, i32)> = Vec::new();
        // Queued task per chunk (level, sequence); stale heap entries are skipped.
    // rust: let mut queued: HashMap<(i32, i32), (i32, u64)> = HashMap::new();
    // rust: let mut heap = BinaryHeap::new();
    // rust: let mut sequence = 0u64;
    // rust: let mut full = HashSet::new();
    // rust: let mut seen = HashSet::new();
    // rust: let mut order = Vec::new();
        // Each ticket lowers the levels around it to 31 + its Chebyshev distance.
    // rust: let mut levels: HashMap<(i32, i32), i32> = HashMap::new();
    // rust: let mut add = |ticket: (i32, i32),
    // rust: active: &mut Vec<(i32, i32)>,
    // rust: queued: &mut HashMap<(i32, i32), (i32, u64)>,
    // rust: heap: &mut BinaryHeap<Reverse<(i32, u64, (i32, i32))>>,
    // rust: full: &HashSet<(i32, i32)>| {
    // rust: active.push(ticket);
    // rust: let reach = LIGHT_LEVEL - TICKET_LEVEL;
    // rust: for x in ticket.0 - reach..=ticket.0 + reach {
    // rust: for z in ticket.1 - reach..=ticket.1 + reach {
    // rust: let own = TICKET_LEVEL + (x - ticket.0).abs().max((z - ticket.1).abs());
    // rust: let l = levels.entry((x, z)).or_insert(i32::MAX);
    // rust: *l = (*l).min(own);
    // rust: let l = *l;
    // rust: if full.contains(&(x, z)) {
    // rust: continue;
}
    // rust: if queued.get(&(x, z)).is_none_or(|&(old, _)| l < old) {
    // rust: sequence += 1;
    // rust: queued.insert((x, z), (l, sequence));
    // rust: heap.push(Reverse((l, sequence, (x, z))));
}
}
}
}
    // rust: for _ in 0..TICKETS_IN_FLIGHT {
    // rust: if let Some(t) = tickets.pop_front() {
    // rust: add(t, &mut active, &mut queued, &mut heap, &full);
}
}
    // rust: while let Some(Reverse((l, s, chunk))) = heap.pop() {
    // rust: if queued.get(&chunk) != Some(&(l, s)) {
    // rust: continue;
}
    // rust: queued.remove(&chunk);
    // rust: let r = i32::from(l <= FULL_LEVEL);
    // rust: for x in chunk.0 - r..=chunk.0 + r {
    // rust: for z in chunk.1 - r..=chunk.1 + r {
    // rust: if seen.insert((x, z)) {
    // rust: order.push((x, z));
}
}
}
    // rust: if l <= FULL_LEVEL {
    // rust: full.insert(chunk);
}
    // rust: active.retain(|t| {
    // rust: !(-2..=2).all(|dx| (-2..=2).all(|dz| full.contains(&(t.0 + dx, t.1 + dz))))
    // rust: });
    // rust: while active.len() < TICKETS_IN_FLIGHT {
    // rust: let Some(t) = tickets.pop_front() else { break };
    // rust: add(t, &mut active, &mut queued, &mut heap, &full);
}
}
    // rust: order
}

dense_grids_keep_the_hashed_order :: proc() {
}
    // rust: for (center, radius) in [
    // rust: ((0, 0), -1),
    // rust: ((0, 0), 0),
    // rust: ((0, 0), 1),
    // rust: ((12, -15), 8),
    // rust: ((-30_000, 29_999), 5),
    // rust: ((7, 3), 12),
    // rust: ((-61, 1234), 32),
    // rust: ] {
    // rust: assert_eq!(
    // rust: vanilla_order(center, radius),
    // rust: hashed_order(center, radius),
    // rust: "{center:?} radius {radius}"
    // rust: );
}
}

first_wave_matches_vanilla :: proc() {
}
        // Seed 1891623539983467248, player teleported into chunk 12,-15 with
        // view distance 8: vanilla (JFR) decorates the player's 3x3 square,
        // then the rest of the squares of the tickets at 12,-14, 11,-15 and
        // 13,-14.
    // rust: let order = vanilla_order((12, -15), 8);
    // rust: let rel: Vec<_> = order
    // rust: .iter()
    // rust: .take(18)
    // rust: .map(|&(x, z)| (x - 12, z + 15))
    // rust: .collect();
    // rust: assert_eq!(
    // rust: rel,
    // rust: [
    // rust: (-1, -1),
    // rust: (-1, 0),
    // rust: (-1, 1),
    // rust: (0, -1),
    // rust: (0, 0),
    // rust: (0, 1),
    // rust: (1, -1),
    // rust: (1, 0),
    // rust: (1, 1),
    // rust: (-1, 2),
    // rust: (0, 2),
    // rust: (1, 2),
    // rust: (-2, -1),
    // rust: (-2, 0),
    // rust: (-2, 1),
    // rust: (2, 0),
    // rust: (2, 1),
    // rust: (2, 2),
    // rust: ]
    // rust: );
    // rust: let unique: std::collections::HashSet<_> = order.iter().collect();
    // rust: assert_eq!(unique.len(), order.len());
    // rust: assert_eq!(order.len(), 23 * 23);
}

blocked_by_lower_ranks_within_two :: proc() {
}
    // rust: let mut order = DecorationOrder::default();
    // rust: order.reassign((0, 0), 2, |_, _| false);
    // rust: let first = order.ordered()[0];
    // rust: assert!(!order.blocked(first.0, first.1, |_, _| true));
    // rust: let last = *order.ordered().last().unwrap();
    // rust: assert!(order.blocked(last.0, last.1, |_, _| true));
    // rust: assert!(!order.blocked(last.0, last.1, |_, _| false));
}

decorated_chunks_keep_their_place :: proc() {
}
    // rust: let mut order = DecorationOrder::default();
    // rust: order.reassign((0, 0), 1, |_, _| false);
    // rust: let before = order.rank(0, 0);
    // rust: order.reassign((10, 0), 1, |x, _| x < 5);
    // rust: assert_eq!(order.rank(0, 0), before);
    // rust: assert!(order.rank(10, 0) > order.rank(2, 2));
}
}
