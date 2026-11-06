//! Transpiled from Horizon Rust crate
//! Module: horizon-client_native_ticks
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Entities ticking for native mods (`native_entity_tick_pre`, `native_entity_tick_post`:
//! NeoForge's `EntityTickEvent.Pre` and `.Post`). A family of entities ticks in its own loop,
//! and the loops of the mobs and the items hold their lists out of `Game`, so a family hands
//! its ticking entities to a `TickRound` before the loop and hears the Posts after it; the
//! minecarts and boats, whose loops can call the hooks, ask for each one in turn.
// use super::Game;
// use horizon_client::mobs::MobType;
// use std::sync::Arc;

/// The type of an entity in a round, as the hooks name it.
    // rust: pub(super) enum TickKind {
    // rust: Fixed(&'static str),
    // rust: Mob(Arc<MobType>),
}

    // rust: impl TickKind {
pub fn id(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Fixed(id) => id,
    // rust: Self::Mob(kind) => &kind.id,
}
}
}

/// The entities of one family in one tick.
    // rust: pub(super) struct TickRound {
    /// Whether this game is a server the mods hear: otherwise nothing is told or kept.
    // rust: listening: bool,
    /// The entities the Pre let through, in order, for the Post.
    // rust: ticking: Vec<(u32, TickKind)>,
    /// The entities a Pre canceled.
    // rust: canceled: Vec<u32>,
}

    // rust: impl TickRound {
    /// Whether a mod canceled the tick of entity `id`.
    // rust: pub(super) fn canceled(&self, id: u32) -> bool {
    // rust: !self.canceled.is_empty() && self.canceled.contains(&id)
}
    /// Whether the mods hear this round.
    // rust: pub(super) fn listening(&self) -> bool {
    // rust: self.listening
}
    /// The entity `id`, told its Pre, went before it ticked (an item merged into an earlier
    /// one): it hears no Post.
    // rust: pub(super) fn not_ticked(&mut self, id: u32) {
    // rust: if self.listening {
    // rust: self.ticking.retain(|(other, _)| *other != id);
}
}
}

    // rust: impl Game<'_> {
    /// A round for a family about to tick: on a server only (the server thread or a dedicated
    /// server, never a client), and only while a mod listens
    /// (`native_entity_tick_listened`). Its list is kept between ticks.
    // rust: pub(super) fn native_tick_round(&mut self) -> TickRound {
    // rust: let server = self.serving.is_some() || self.options.dedicated.is_some();
    // rust: let mut listened = false;
    // rust: if server {
    // rust: self.native_entity_tick_listened(&mut listened);
}
    // rust: let listening = server && listened;
    // rust: TickRound {
    // rust: listening,
    // rust: ticking: if listening {
    // rust: std::mem::take(&mut self.creatures.tick_buffer)
    // rust: } else {
    // rust: Vec::new()
    // rust: },
    // rust: canceled: Vec::new(),
}
}

    /// `native_entity_tick_pre` for the entity `id` of `kind` about to tick in a family that
    /// hears its Posts together: whether it ticks.
    // rust: pub(super) fn native_tick_pre_batch(
    // rust: &mut self,
    // rust: round: &mut TickRound,
    // rust: id: u32,
    // rust: kind: TickKind,
    // rust: ) -> bool {
    // rust: if !round.listening {
    // rust: return true;
}
    // rust: let mut canceled = false;
    // rust: self.native_entity_tick_pre(self.dim.id(), id, kind.id(), &mut canceled);
    // rust: if canceled {
    // rust: round.canceled.push(id);
    // rust: } else {
    // rust: round.ticking.push((id, kind));
}
    // rust: !canceled
}

    /// `native_entity_tick_post` for each entity the round let through, and the round is over.
    // rust: pub(super) fn native_tick_post_batch(&mut self, mut round: TickRound) {
    // rust: if !round.listening {
    // rust: return;
}
    // rust: let dimension = self.dim.id();
    // rust: for (id, kind) in &round.ticking {
    // rust: self.native_entity_tick_post(dimension, *id, kind.id());
}
    // rust: round.ticking.clear();
    // rust: self.creatures.tick_buffer = round.ticking;
}

    /// `native_entity_tick_pre` for one entity about to tick: whether it does.
    // rust: pub(super) fn native_tick_pre_one(
    // rust: &mut self,
    // rust: round: &mut TickRound,
    // rust: id: u32,
    // rust: kind: &str,
    // rust: ) -> bool {
    // rust: if !round.listening {
    // rust: return true;
}
    // rust: let mut canceled = false;
    // rust: self.native_entity_tick_pre(self.dim.id(), id, kind, &mut canceled);
    // rust: if canceled {
    // rust: round.canceled.push(id);
}
    // rust: !canceled
}

    /// `native_entity_tick_post` for one entity that ticked.
    // rust: pub(super) fn native_tick_post_one(&mut self, round: &TickRound, id: u32, kind: &str) {
    // rust: if round.listening {
    // rust: self.native_entity_tick_post(self.dim.id(), id, kind);
}
}
}

    // rust: mod tests {
//     use super::*;

pub fn round() T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: TickRound {
    // rust: listening: true,
    // rust: ..TickRound::default()
}
}

    /// A canceled entity is skipped, and one that went before its tick (an item merged into an
    /// earlier one) hears no Post; a round nobody listens to keeps nothing.
pub fn a_round_keeps_the_entities_that_tick() void {
}
    // rust: let mut r = round();
    // rust: r.ticking.push((1, TickKind::Fixed("minecraft:item")));
    // rust: r.ticking.push((2, TickKind::Fixed("minecraft:item")));
    // rust: r.canceled.push(3);
    // rust: assert!(r.canceled(3));
    // rust: assert!(!r.canceled(1));
    // rust: r.not_ticked(2);
    // rust: let left: Vec<_> = r
    // rust: .ticking
    // rust: .iter()
    // rust: .map(|(id, kind)| (*id, kind.id()))
    // rust: .collect();
    // rust: assert_eq!(left, [(1, "minecraft:item")]);
    // rust: let mut quiet = TickRound::default();
    // rust: assert!(!quiet.listening());
    // rust: quiet.not_ticked(1);
    // rust: assert!(quiet.ticking.is_empty() && !quiet.canceled(1));
}
}
