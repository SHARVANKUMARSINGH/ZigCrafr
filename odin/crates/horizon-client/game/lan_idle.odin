//! Transpiled from Horizon Rust crate
package horizon_client_lan_idle

import "core:fmt"
import "core:mem"
import "core:math"

// Idle mobs and items that need no new description this tick (#10253).
//
// An entity outside the entity-ticking range does not tick, and `ChunkMap.tick` does not send
// its changes (`EntityState::idle`) unless it changed section or needs sync. While it stays
// where it was, its state is read only for where it is, and to pair it with a client that
// starts tracking it. So such an entity is described bare (`EntityState::bare`: where it is,
// none of its data) when no client could pair with it this tick: it was in the tracker's last
// pass, has not moved, carries no passengers, and every client within its tracking range
// already tracks it. Otherwise it is described in full, so a pairing always sends the entity
// as it is.

// use horizon_client::fast_hash::FxHashMap;
// use horizon_client::lan::{hub::Hub, tracking};

// Per level, each idle entity's place and the tracking pass it was last described in.
    // rust: pub(super) struct IdleStates {
    // rust: levels: FxHashMap<String, FxHashMap<i32, (u32, Place)>>,
}

// Where an entity is: its position, rotation (yaw, pitch, head yaw), whether
// it is on the ground, and its velocity.
    // rust: pub(super) struct Place {
    // rust: pub position: [f64; 3],
    // rust: pub rotation: (f32, f32, f32),
    // rust: pub on_ground: bool,
    // rust: pub velocity: [f64; 3],
}

// The idle entities of the level in place, for one pass.
    // rust: pub(super) struct IdlePass<'a> {
    // rust: kept: &'a mut FxHashMap<i32, (u32, Place)>,
    // The level's tracking passes so far (`Hub::tracking_ticks`). An entity
    // described one pass earlier was in the tracker's last pass.
    // rust: now: u32,
    // The players the level's tracker runs for (`Hub::watches`: their
    // index), where they are horizontally, and their view distance in blocks:
    // the clients that could pair.
    // rust: viewers: Vec<(usize, [f64; 2], i32)>,
    // `entity-broadcast-range-percentage`, as the tracker scales ranges.
    // rust: percent: i32,
}

    // rust: impl IdleStates {
    // The level in place's idle entities, or None before its tracking ran.
    // rust: pub(super) fn pass(&mut self, hub: &Hub, percent: i32) -> Option<IdlePass<'_>> {
    // rust: let now = hub.tracking_ticks()?;
    // rust: let viewers = (hub.guests.iter().enumerate())
    // rust: .filter(|(_, g)| hub.watches(g))
    // rust: .map(|(i, g)| (i, [g.position[0], g.position[2]], g.view_distance * 16))
    // rust: .collect();
    // rust: let kept = self.levels.entry(hub.config.dimension.clone()).or_default();
    // rust: Some(IdlePass {
    // rust: kept,
    // rust: now,
    // rust: viewers,
    // rust: percent,
    // rust: })
}
}

    // rust: impl IdlePass<'_> {
    // Whether the idle entity `id` of type `kind`, now at `at`, can be
    // described bare: it was in the tracker's last pass at the same place,
    // carries no passengers (whose ranges widen its own), and every client
    // within its tracking range already tracks it. Notes it either way.
    // rust: pub(super) fn bare(&mut self, hub: &Hub, id: i32, kind: &str, at: &Place) -> bool {
    // rust: self.unchanged(id, kind, at, |i| hub.guests[i].tracker.is_tracking(id))
    // rust: && hub.riding.passengers(id).is_empty()
}

    // [`Self::bare`] but for the passengers, with whether the player `i`
    // tracks the entity.
    // rust: fn unchanged(
    // rust: &mut self,
    // rust: id: i32,
    // rust: kind: &str,
    // rust: at: &Place,
    // rust: tracks: impl Fn(usize) -> bool,
    // rust: ) -> bool {
        // A new one reads as noted two passes ago.
    // rust: let now = self.now;
    // rust: let noted = self.kept.entry(id).or_insert((now.wrapping_sub(2), *at));
    // rust: let still = noted.0.wrapping_add(1) == now && noted.1 == *at;
    // rust: *noted = (now, *at);
    // rust: if !still {
    // rust: return false;
}
        // The tracker's `sees`, but for the chunk it also asks the client to have.
    // rust: let range = self.percent * (i32::from(tracking::settings(kind).0) * 16) / 100;
    // rust: !self.viewers.iter().any(|&(i, [x, z], view)| {
    // rust: let range = f64::from(range.min(view));
    // rust: let (dx, dz) = (x - at.position[0], z - at.position[2]);
    // rust: dx * dx + dz * dz <= range * range && !tracks(i)
    // rust: })
}

    // Forget the entities this pass did not note: they left, or tick again.
    // rust: pub(super) fn finish(self) {
    // rust: let now = self.now;
    // rust: self.kept.retain(|_, (stamp, _)| *stamp == now);
}
}

    // rust: mod tests {
//     use super::*;

place :: proc(x: f64) -> P {
    // Ported from Horizon
    return {}
}
    // rust: Place {
    // rust: position: [x, 64.0, 0.0],
    // rust: rotation: (0.0, 0.0, 0.0),
    // rust: on_ground: true,
    // rust: velocity: [0.0; 3],
}
}

pass :: proc(kept: ^FxHashMap<i32) {
}
        // One client at the origin, one 400 blocks away; both see 10 chunks.
    // rust: IdlePass {
    // rust: kept,
    // rust: now,
    // rust: viewers: vec![(0, [0.0, 0.0], 160), (1, [400.0, 0.0], 160)],
    // rust: percent: 100,
}
}

    // An idle cow (tracked 10 chunks away) is described bare while it stays
    // put and every client in its range tracks it; in full when a client
    // there could pair with it, when it moved, and after a pass it was not in.
an_idle_entity_is_bare_until_a_client_could_pair_or_it_moves :: proc() {
}
    // rust: let mut kept = FxHashMap::default();
    // rust: let cow = "minecraft:cow";
    // rust: let at = place(100.0);
        // Its first pass describes it in full.
    // rust: assert!(!pass(&mut kept, 5).unchanged(7, cow, &at, |_| true));
        // Tracked by the client in range; the far one can't pair.
    // rust: let tracked = |i| i == 0;
    // rust: assert!(pass(&mut kept, 6).unchanged(7, cow, &at, tracked));
        // The client in range doesn't track it yet: it could pair.
    // rust: assert!(!pass(&mut kept, 7).unchanged(7, cow, &at, |_| false));
        // 100 blocks is past an item's 6 chunks: no client could pair.
    // rust: assert!(pass(&mut kept, 8).unchanged(7, "minecraft:item", &at, |_| false));
        // It moved.
    // rust: assert!(!pass(&mut kept, 9).unchanged(7, cow, &place(100.5), tracked));
        // A pass went by without it.
    // rust: assert!(!pass(&mut kept, 11).unchanged(7, cow, &place(100.5), tracked));
        // Only what a pass noted stays.
    // rust: pass(&mut kept, 12).finish();
    // rust: assert!(kept.is_empty());
}
}
