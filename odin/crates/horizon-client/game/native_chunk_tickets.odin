//! Transpiled from Horizon Rust crate
package horizon_client_native_chunk_tickets

import "core:fmt"
import "core:mem"
import "core:math"

// Chunks a native mod keeps loaded (NeoForge's `TicketController`): a train
// running where nobody is, a long contraption, a machine that must keep
// working (docs/native-mods.md, "Chunk tickets"). A held chunk is as a
// `/forceload`ed one, its level stays open, but `/forceload` neither lists
// nor releases it and it isn't saved.
// use super::Game;

// Native mods use these; nothing in Horizon does.
    // rust: impl Game<'_> {
    // Holds chunk `chunk` (`[x, z]`, block coordinates `>> 4`) of the level
    // in place loaded and ticking for `owner`, or, with `hold` false, lets
    // go of it. `owner` names what holds it, under the mod's namespace
    // (`create:train/4f0c…`, `create:contraption/12,64,-3`): the chunk stays
    // while any owner holds it, as NeoForge's `TicketController.forceChunk`
    // with an owner. A held chunk is loaded with the ring around it, its
    // blocks and entities tick as a `/forceload`ed one's do, and its level
    // stays open with nobody there. Tickets are kept until the owner lets go
    // or the server stops, not saved: keep what you hold (a level
    // attachment) and hold it again in `native_level_load`. True when the
    // set of owners changed; false for an owner without a namespace, a chunk
    // past the world's edge (as `/forceload` refuses it) and off a server. API @API:chunk_tickets@.
    // rust: pub(super) fn native_force_chunk(&mut self, owner: &str, chunk: [i32; 2], hold: bool) -> bool {
    // rust: let namespaced = owner
    // rust: .split_once(':')
    // rust: .is_some_and(|(ns, path)| !ns.is_empty() && !path.is_empty());
        // `/forceload`'s world: blocks -30,000,000 to 29,999,999, so a mod's
        // corrupt saved list asks for nothing past the edge (where the ring's
        // arithmetic would overflow).
    // rust: let in_world = chunk.iter().all(|c| (-1_875_000..1_875_000).contains(c));
    // rust: if !namespaced || !self.native_authoritative() || (hold && !in_world) {
    // rust: return false;
}
    // rust: let key = (chunk[0], chunk[1]);
    // rust: let level = self.mod_chunk_tickets.entry(self.dim).or_default();
    // rust: let changed = if hold {
    // rust: level.entry(key).or_default().insert(owner.to_owned())
    // rust: } else {
    // rust: let removed = level.get_mut(&key).is_some_and(|o| o.remove(owner));
    // rust: if level.get(&key).is_some_and(|o| o.is_empty()) {
    // rust: level.remove(&key);
}
    // rust: removed
}
    // rust: if !changed {
    // rust: return false;
}
    // rust: if level.contains_key(&key) {
    // rust: if self.streaming.mod_forced.insert(key) {
    // rust: self.streaming.rank_forced(key.0, key.1, key.0, key.1);
}
    // rust: } else {
    // rust: self.streaming.mod_forced.remove(&key);
}
    // rust: true
}

    // The chunks of the level in place `owner` holds (`native_force_chunk`),
    // sorted. API @API:chunk_tickets@.
    // rust: pub(super) fn native_forced_chunks(&self, owner: &str) -> Vec<[i32; 2]> {
    // rust: let mut held: Vec<[i32; 2]> = self
    // rust: .mod_chunk_tickets
    // rust: .get(&self.dim)
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .filter(|(_, owners)| owners.contains(owner))
    // rust: .map(|(&(x, z), _)| [x, z])
    // rust: .collect();
    // rust: held.sort_unstable();
    // rust: held
}
}
