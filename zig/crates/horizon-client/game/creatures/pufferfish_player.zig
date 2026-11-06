//! Transpiled from Horizon Rust crate
//! Module: horizon-client_pufferfish_player
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Pufferfish.playerTouch in the real player's tick, independent of fish AI.
// use super::super::{
    // rust: Game,
    // rust: entity::{Entity, with_entity},
}
// use horizon_client::{mobs::Species, scoreboard::teams_allow_damage};
// use horizon_core::geometry::Vec3;

    // rust: impl Game<'_> {
    /// `Pufferfish.playerTouch`: accepted player damage, then poison with this fish as source.
    // rust: pub(in crate::game) fn touch_pufferfish(&mut self) {
    // rust: if self.remote.is_some() || self.spectator() {
    // rust: return;
}
    // rust: let Some(player) = self.player.as_ref().filter(|p| !p.health.dead_or_dying()) else {
    // rust: return;
}
    // rust: let mut fish = self
    // rust: .mobs
    // rust: .iter()
    // rust: .filter(|m| m.species() == Species::Pufferfish && m.alive() && m.extra.size > 0)
    // rust: .peekable();
    // rust: if fish.peek().is_none() {
    // rust: return;
}
    // rust: let own = player.bounds();
        // Player.aiStep's contact query; the existing vehicle bounds are read,
        // without moving or simulating that vehicle.
    // rust: let vehicle = self.riding.and_then(|id| {
    // rust: self.entity_handles().find_map(
    // rust: |h| with_entity!(self,h,e => (e.id()==id && !e.is_removed()).then(||e.bounds())),
    // rust: )
    // rust: });
    // rust: let query = vehicle.map_or_else(
    // rust: || own.inflate(Vec3::new(1.0, 0.5, 1.0)),
    // rust: |b| own.union_bounds(b).inflate(Vec3::new(1.0, 0.0, 1.0)),
    // rust: );
    // rust: let touching: Vec<_> = fish
    // rust: .filter(|m| {
    // rust: query.intersects(m.bounds())
    // rust: && teams_allow_damage(self.mob_team_of(m), self.player_team())
    // rust: })
    // rust: .map(|m| {
    // rust: (
    // rust: m.id,
    // rust: m.extra.size,
    // rust: [m.position.x, m.position.y, m.position.z],
    // rust: self.mob_entity(m),
    // rust: )
    // rust: })
    // rust: .collect();
    // rust: for (id, puff, at, source) in touching {
    // rust: if !self.hurt_player_from(
    // rust: (1 + puff) as f32,
    // rust: Some(at),
    // rust: "minecraft:mob_attack",
    // rust: Some(Some(id)),
    // rust: ) {
    // rust: continue;
}
    // rust: let changes = self.potions.effects.changes;
    // rust: self.give_player_effect("minecraft:poison", 60 * puff, 0);
    // rust: if self.potions.effects.changes != changes {
    // rust: self.trigger_effects_changed_by(Some(source));
}
}
}
}
