//! Transpiled from Horizon Rust crate
//! Module: horizon-client_breezes
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Breeze particles (`Breeze.tick`): block dust at its feet while it stands,
//! a burst of twenty while it slides and a short trail along a long jump.
// use super::Game;
// use horizon_client::{
    // rust: mobs::{Species, breeze},
    // rust: particles::Particle,
}

    // rust: impl Game<'_> {
    // rust: pub(super) fn tick_breeze_effects(&mut self) {
    // rust: let Some(camera) = self.player.as_ref().map(|p| p.position) else {
    // rust: return;
}
    // rust: for i in 0..self.mobs.len() {
    // rust: let m = &self.mobs[i];
    // rust: if m.species() != Species::Breeze
    // rust: || !m.alive()
    // rust: || m.position.distance_squared(camera) > 32.0 * 32.0
    // rust: {
    // rust: continue;
}
    // rust: let pose = breeze::pose(m);
    // rust: let (amount, jump_trail) = match pose {
    // rust: breeze::SLIDING => (20, false),
    // rust: breeze::LONG_JUMPING => (3, true),
    // rust: _ => (1, false),
}
    // rust: if jump_trail {
    // rust: self.mobs[i].extra.scratch[1] += 1;
    // rust: if self.mobs[i].extra.scratch[1] > 5 {
    // rust: continue;
}
    // rust: } else {
    // rust: self.mobs[i].extra.scratch[1] = 0;
}
    // rust: let m = &self.mobs[i];
    // rust: let (x, y, z) = (
    // rust: m.position.x.floor() as i32,
    // rust: m.position.y.floor() as i32,
    // rust: m.position.z.floor() as i32,
    // rust: );
    // rust: let mut at = [x, y, z];
    // rust: let mut state = self.world.block(x, y, z);
    // rust: if self.res.facts().is_air(state) {
    // rust: at[1] = (m.position.y - 0.2).floor() as i32;
    // rust: state = self.world.block(x, at[1], z);
}
    // rust: let Some((sprite, tint)) = self.particle_sprite(state, at) else {
    // rust: continue;
}
    // rust: let at = if jump_trail {
    // rust: [
    // rust: m.position.x + m.velocity.x,
    // rust: m.position.y + m.velocity.y + f64::from(0.1_f32),
    // rust: m.position.z + m.velocity.z,
    // rust: ]
    // rust: } else {
    // rust: [m.position.x, m.position.y, m.position.z]
}
    // rust: for _ in 0..amount {
    // rust: let particle =
    // rust: Particle::terrain(&mut self.world.random, at, [0.0; 3], sprite.clone(), tint);
    // rust: self.particles.push(particle);
}
}
}
}
