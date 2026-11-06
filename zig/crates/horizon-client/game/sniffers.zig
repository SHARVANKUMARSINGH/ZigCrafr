//! Transpiled from Horizon Rust crate
//! Module: horizon-client_sniffers
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Sniffers on the game side: the egg a bred pair lays
//! (`Sniffer.spawnChildFromBreeding`), the snifflet that hatches from an
//! egg block (`SnifferEggBlock.tick`) and the dust and sound of digging.
// use super::Game;
// use horizon_client::{
    // rust: items::ItemStack,
    // rust: mobs::{Mob, Species, sniffer},
}
// use horizon_core::{geometry::Vec3, random::RandomSource};

    // rust: impl Game<'_> {
    /// The egg item at the parent (`Sniffer.spawnChildFromBreeding`; the
    /// brain already played the plop and dropped the experience).
    // rust: pub(super) fn lay_sniffer_egg(&mut self, parent: &Mob) {
    // rust: let at = [parent.position.x, parent.position.y, parent.position.z];
        // new ItemEntity(level, x, y, z, stack): a little random push.
    // rust: let vx = self.world.random.next_double() * 0.2 - 0.1;
    // rust: let vz = self.world.random.next_double() * 0.2 - 0.1;
    // rust: self.spawn_item(
    // rust: ItemStack::new("minecraft:sniffer_egg", 1),
    // rust: at,
    // rust: [vx, 0.2, vz],
    // rust: 10,
    // rust: );
}
    /// A snifflet where the egg was.
    // rust: pub(super) fn hatch_sniffer(&mut self, pos: [i32; 3]) {
    // rust: let at = [
    // rust: f64::from(pos[0]) + 0.5,
    // rust: f64::from(pos[1]) + 0.5,
    // rust: f64::from(pos[2]) + 0.5,
    // rust: ];
    // rust: if let Some(id) = self.spawn_mob("minecraft:sniffer", at, true)
    // rust: && let Some(m) = self.mobs.iter_mut().find(|m| m.id == id)
    // rust: {
    // rust: m.extra.age = sniffer::BABY_START_AGE;
    // rust: let yaw = self.world.random.next_float() * 360.0 - 180.0;
    // rust: m.yaw = yaw;
    // rust: m.body_yaw = yaw;
    // rust: m.head_yaw = yaw;
}
}
    /// The sniffer's client-side effects: `SnifferSoundInstance` when it
    /// starts digging, `Sniffer.emitDiggingParticles` (block dust and the
    /// block's hit sound between the 1.7th and the 6th second of the
    /// digging animation) and `playSearchingSound`.
    // rust: pub(super) fn tick_sniffer_effects(&mut self) {
        // Vanilla runs these on each client: a sniffer within 32 blocks of
        // any player in the level (the host and the guests) shows them.
    // rust: let players = self.level_players();
    // rust: if players.is_empty() {
    // rust: return;
}
    // rust: for i in 0..self.mobs.len() {
    // rust: let m = &self.mobs[i];
    // rust: if m.species() != Species::Sniffer
    // rust: || !m.alive()
    // rust: || !players
    // rust: .iter()
    // rust: .any(|p| m.position.distance_squared(p.position) <= 32.0 * 32.0)
    // rust: {
    // rust: continue;
}
    // rust: let id = m.id;
    // rust: let at = [m.position.x, m.position.y, m.position.z];
    // rust: if !m.silent && sniffer::state(m) == sniffer::SEARCHING && m.age.is_multiple_of(20) {
    // rust: self.audio
    // rust: .play("minecraft:entity.sniffer.searching", Some(at), 1.0, 1.0);
    // rust: continue;
}
    // rust: if !sniffer::digging(m) {
    // rust: continue;
}
    // rust: let Some(ms) = m.anim.states[3].millis(m.age as f32) else {
    // rust: continue;
}
    // rust: if ms == 0 {
                // Sniffer.onDiggingStart: broadcast entity event 63.
    // rust: self.lan_entity_event(id as i32, 63, at);
}
    // rust: if ms <= 1700 || ms >= 6000 {
    // rust: continue;
}
    // rust: let head = sniffer::head_block(&self.mobs[i]);
    // rust: let below = self.world.block(head[0], head[1] - 1, head[2]);
    // rust: if self
    // rust: .particle_sprite(below, [head[0], head[1] - 1, head[2]])
    // rust: .is_none()
    // rust: {
    // rust: continue;
}
    // rust: let dust = [
    // rust: f64::from(head[0]) + 0.5,
    // rust: f64::from(head[1]) + 0.5 - f64::from(0.65_f32),
    // rust: f64::from(head[2]) + 0.5,
    // rust: ];
            // Drawn in this window when it has one, and sent to the players
            // within 32 blocks (the server thread's window is one of them).
    // rust: self.landing_dust(None, below, Vec3::new(dust[0], dust[1], dust[2]), 30, 0.0);
    // rust: if !self.mobs[i].silent && self.mobs[i].age.is_multiple_of(10) {
    // rust: let hit = self.res.facts().get(below).sounds.hit.clone();
    // rust: self.audio.play(&hit, Some(at), 0.5, 0.5);
}
}
}
}
