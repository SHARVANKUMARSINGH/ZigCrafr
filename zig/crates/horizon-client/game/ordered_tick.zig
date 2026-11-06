//! Transpiled from Horizon Rust crate
//! Module: horizon-client_ordered_tick
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! PURPOSE: ticks experience orbs, primed TNT and falling blocks in the order
//! they joined the level, between the other kinds' batches.
//! WHY: `ServerLevel.tick` ticks every entity in join order, one kind among
//! the rest; these three used to tick as three fixed batches (orbs after the
//! mobs, falling blocks and TNT after the gateways), so a TNT that joined
//! before a boat blew up after the boat moved (#6509, tick order slice 2).
//! REFS: vanilla `ServerLevel.tick` (`entityTickList.forEach`),
//! `EntityTickList`; `join_seq.rs`; `tools/test_tick_order_parity.py`.
//! LOGS: none. READS-BY: `Game::tick_world`, `tick_mobs`.
//! ENDS-WHEN: every kind ticks from the join-order walk.

// use super::{Game, Result};
// use horizon_client::join_seq::{JoinSeq, Joined};
// use horizon_core::random::RandomSource as _;

/// What this tick has ticked of the three kinds.
    // rust: pub(super) struct OrderedTicks {
    /// Joins at or above this started after the tick began; they tick next tick.
    // rust: born: JoinSeq,
    /// The last join number ticked, if any: later ones are still to come.
    // rust: pub(super) done: Option<JoinSeq>,
    /// Joins below this have had their spawn packet; the ones above joined
    /// since (a summoned falling block, a lit TNT) and tick after it goes out.
    // rust: pub(super) announced: JoinSeq,
    /// For each batch of another kind, in tick order (see [`Batch`]): the
    /// lowest join number among it and every batch after it.
    // rust: suffix_min: [JoinSeq; Batch::COUNT],
    /// The orbs' lava random, made on first use.
    // rust: lava_random: Option<horizon_core::random::LegacyRandom>,
}

/// The batches of the other kinds, in the order they tick.
    // rust: pub(super) enum Batch {
    // rust: ArmorStands,
    // rust: Boats,
    // rust: Carts,
    // rust: Tridents,
    // rust: Rockets,
    // rust: Items,
    // rust: Mobs,
    // rust: Projectiles,
}

    // rust: impl Batch {
pub const COUNT: usize = 8;
}

pub const Pending = enum {
    Orb,
    Tnt,
    Falling,
};

/// The lowest join number in a batch, or none when it is empty.
    // rust: pub(super) fn first_join<T: Joined>(list: &[T]) -> Option<JoinSeq> {
    // rust: list.iter().map(Joined::join_seq).min()
}

/// Where the entity that joined as `join` is in `list`, if still there. A list
/// is usually in join order (spawns append), so a binary search finds it; a
/// list put back out of order falls back to the walk.
    // rust: fn find_join<T: Joined>(list: &[T], join: JoinSeq) -> Option<usize> {
    // rust: match list.binary_search_by_key(&join, Joined::join_seq) {
        // Join numbers are unique, so a hit is the entity even in a list out of order.
    // rust: Ok(i) => Some(i),
    // rust: Err(_) => list.iter().position(|e| e.join_seq() == join),
}
}

    // rust: impl Game<'_> {
    /// A level tick starts: what has joined so far ticks this tick.
    // rust: pub(super) fn begin_ordered_ticks(&mut self) {
    // rust: let firsts = [
    // rust: first_join(&self.armor_stands),
    // rust: first_join(&self.boats),
    // rust: first_join(&self.carts),
    // rust: first_join(&self.tridents),
    // rust: first_join(&self.rockets),
    // rust: first_join(&self.dropped),
    // rust: first_join(&self.mobs),
    // rust: first_join(&self.creatures.projectiles),
    // rust: ];
        // A batch ticks whole, so an entity of the three kinds goes after the
        // last batch that holds anything that joined before it.
    // rust: let mut suffix_min = [JoinSeq::MAX; Batch::COUNT];
    // rust: let mut lowest = JoinSeq::MAX;
    // rust: for (slot, first) in suffix_min.iter_mut().zip(firsts).rev() {
    // rust: lowest = lowest.min(first.unwrap_or(JoinSeq::MAX));
    // rust: *slot = lowest;
}
    // rust: self.ordered = OrderedTicks {
    // rust: announced: self.ordered.announced,
    // rust: born: JoinSeq::upcoming(),
    // rust: done: None,
    // rust: suffix_min,
    // rust: lava_random: None,
}
}

    /// Ticks, one at a time in join order, every orb, primed TNT and falling
    /// block that joined before `cut` and has not ticked this tick.
    // rust: pub(super) fn run_ordered_ticks(&mut self, cut: JoinSeq, late: bool) -> Result<()> {
    // rust: let mut first_error = None;
    // rust: let mut followed = None;
    // rust: let mut events = false;
    // rust: let entity_ticking = self.entity_ticking_area();
        // Who ticks in this run, sorted once: entities that join meanwhile are
        // at or above `born`, so the set cannot grow, only lose the removed.
    // rust: let (done, born, announced) =
    // rust: (self.ordered.done, self.ordered.born, self.ordered.announced);
    // rust: let wanted = |j: JoinSeq| done.is_none_or(|d| j > d) && j < cut && j < born;
    // rust: let mut pending: Vec<(JoinSeq, Pending)> = Vec::new();
    // rust: let mut offer = |j: JoinSeq, kind: Pending| {
            // Orbs are announced after their tick, always; TNT and falling
            // blocks that joined since the last packets wait for them.
    // rust: let right_pass = match kind {
    // rust: Pending::Orb => !late,
    // rust: _ => late == (j >= announced),
}
    // rust: if right_pass && wanted(j) {
    // rust: pending.push((j, kind));
}
}
    // rust: self.orbs.iter().for_each(|e| offer(e.join, Pending::Orb));
    // rust: self.tnts.iter().for_each(|e| offer(e.join, Pending::Tnt));
    // rust: self.falling
    // rust: .iter()
    // rust: .for_each(|e| offer(e.join, Pending::Falling));
    // rust: pending.sort_unstable_by_key(|&(j, _)| j);
    // rust: for (join, kind) in pending {
    // rust: self.ordered.done = Some(join);
            // ServerLevel.tick: only entities in entity-ticking chunks tick.
    // rust: match kind {
    // rust: Pending::Tnt => {
    // rust: let Some(i) = find_join(&self.tnts, join) else {
    // rust: continue;
}
    // rust: let at = self.tnts[i].position;
    // rust: if entity_ticking(at.x.floor() as i32, at.z.floor() as i32)
    // rust: && let Err(e) = self.tick_one_tnt(i)
    // rust: {
    // rust: first_error.get_or_insert(e);
}
}
    // rust: Pending::Falling => {
    // rust: let Some(i) = find_join(&self.falling, join) else {
    // rust: continue;
}
    // rust: let at = self.falling[i].position;
    // rust: if entity_ticking(at.x.floor() as i32, at.z.floor() as i32) {
    // rust: events = true;
    // rust: if let Err(e) = self.tick_one_falling(i) {
    // rust: first_error.get_or_insert(e);
}
}
}
    // rust: Pending::Orb => {
    // rust: let Some(i) = find_join(&self.orbs, join) else {
    // rust: continue;
}
    // rust: let followed = followed.get_or_insert_with(|| self.orb_followed());
    // rust: let o = &mut self.orbs[i];
    // rust: let distance = |feet: &[f64; 3]| -> f64 {
    // rust: (feet[0] - o.position.x).powi(2)
    // rust: + (feet[1] - o.position.y).powi(2)
    // rust: + (feet[2] - o.position.z).powi(2)
}
    // rust: let target = followed
    // rust: .iter()
    // rust: .filter(|(feet, _)| distance(feet) < 64.0)
    // rust: .min_by(|a, b| distance(&a.0).total_cmp(&distance(&b.0)))
    // rust: .map(|(_, target)| *target);
                    // An orb has no random of its own here: lava draws from one
                    // made on first use, apart from the level stream.
    // rust: let random = &mut self.ordered.lava_random;
    // rust: let mut next_float = || {
    // rust: random
    // rust: .get_or_insert_with(super::dispenser::entity_random)
    // rust: .next_float()
}
    // rust: let stays = {
    // rust: let audio = &mut self.audio;
    // rust: let mut on_sound = |pos: [f64; 3], pitch: f32| {
    // rust: audio.play("minecraft:entity.generic.burn", Some(pos), 0.4, pitch);
}
    // rust: o.tick(
    // rust: &self.world,
    // rust: self.res.facts(),
    // rust: self.collision,
    // rust: target,
    // rust: self.remote.is_none(),
    // rust: &mut next_float,
    // rust: Some(self.border.geometry()),
    // rust: &self.res.motion().fluids,
    // rust: &mut on_sound,
    // rust: )
}
                    // PowderSnowBlock.entityInside during the move, before an
                    // orb that is done is removed.
    // rust: let snow = (o.previous, o.position, o.bounds(), o.velocity);
    // rust: self.entity_powder_snow_particles(snow.0, snow.1, snow.2, snow.3, false);
    // rust: if !stays {
    // rust: self.orbs.remove(i);
}
}
}
}
    // rust: if events && let Err(e) = self.process_level_events() {
    // rust: first_error.get_or_insert(e);
}
    // rust: first_error.map_or(Ok(()), Err)
}

    /// Before a batch of another kind ticks: the three kinds' entities that
    /// joined before everything still to tick in the batches from this one on.
    // rust: pub(super) fn ordered_before(&mut self, batch: Batch) -> Result<()> {
    // rust: let cut = self.ordered.suffix_min[batch as usize];
    // rust: if cut == JoinSeq::MAX {
    // rust: return Ok(());
}
    // rust: self.run_ordered_ticks(cut, false)
}
}

    // rust: mod tests {
//     use super::find_join;
//     use horizon_client::join_seq::{JoinList, JoinSeq, Joined as _};

pub const E = struct {
    join: JoinSeq,
};
    // rust: horizon_client::impl_joined!(E);

    /// The run looks each entity up by join number: in a list in join order,
    /// one put back out of order, and after the entity left.
pub fn find_join_finds_by_number_in_or_out_of_order() void {
}
    // rust: let mut list = JoinList::default();
    // rust: for _ in 0..5 {
    // rust: list.push(E {
    // rust: join: JoinSeq::UNJOINED,
    // rust: });
}
    // rust: let joins: Vec<JoinSeq> = list.iter().map(|e| e.join_seq()).collect();
    // rust: for (i, &j) in joins.iter().enumerate() {
    // rust: assert_eq!(find_join(&list, j), Some(i));
}
    // rust: list.swap(0, 4);
    // rust: list.swap(1, 3);
    // rust: assert_eq!(find_join(&list, joins[0]), Some(4));
    // rust: assert_eq!(find_join(&list, joins[4]), Some(0));
    // rust: assert_eq!(find_join(&list, joins[1]), Some(3));
    // rust: let gone = list.remove(2).join_seq();
    // rust: assert_eq!(find_join(&list, gone), None);
}
}
