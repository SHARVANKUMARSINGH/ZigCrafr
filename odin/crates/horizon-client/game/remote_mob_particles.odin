//! Transpiled from Horizon Rust crate
package horizon_client_remote_mob_particles

import "core:fmt"
import "core:mem"
import "core:math"

// Particles a client of a server draws for a mob's entity event, which the
// server does not send as a particle packet.
// use super::Game;
// use horizon_client::{
    // rust: items::ItemStack,
    // rust: mobs::Species,
    // rust: particles::{ParticleOptions, ParticleType},
}
// use horizon_core::{
    // rust: geometry::{
    // rust: Vec3,
    // rust: trig::{DEG_TO_RAD, Mth},
    // rust: },
    // rust: random::RandomSource,
}

    // rust: impl Game<'_> {
    // `Fox.handleEntityEvent(45)`: eight crumbs of the item in its mouth,
    // thrown from in front of it along `Entity.getLookAngle`.
    // rust: pub(super) fn fox_eat_particles(&mut self, id: u32) {
    // rust: let Some(m) = self
    // rust: .mobs
    // rust: .iter_mut()
    // rust: .find(|m| m.id == id && m.species() == Species::Fox)
    // rust: else {
    // rust: return;
}
    // rust: let Some(item) = m.extra.main_hand.clone() else {
    // rust: return;
}
        // Entity.calculateViewVector(xRot, yRot): the look's x and z.
    // rust: let x_rad = m.head_pitch * DEG_TO_RAD;
    // rust: let y_rad = -m.yaw * DEG_TO_RAD;
    // rust: let look = [
    // rust: f64::from(y_rad.msin() * x_rad.mcos()),
    // rust: f64::from(y_rad.mcos() * x_rad.mcos()),
    // rust: ];
    // rust: let at = [m.position.x, m.position.y, m.position.z];
    // rust: let mut spawned = Vec::new();
    // rust: for _ in 0..8 {
    // rust: let d = Vec3::new(
    // rust: (f64::from(m.random.next_float()) - 0.5) * 0.1,
    // rust: f64::from(m.random.next_float()) * 0.1 + 0.1,
    // rust: 0.0,
    // rust: )
    // rust: .rotate_x(-m.head_pitch * DEG_TO_RAD)
    // rust: .rotate_y(-m.yaw * DEG_TO_RAD);
    // rust: spawned.push((
    // rust: [at[0] + look[0] / 2.0, at[1], at[2] + look[1] / 2.0],
    // rust: [d.x, d.y + 0.05, d.z],
    // rust: ));
}
    // rust: let options = self.item_particle(&ItemStack::new(&item, 1));
    // rust: for (p, v) in spawned {
    // rust: self.particles.add(&options, p, v);
}
}
    // `Witch.handleEntityEvent(15)`: `nextInt(35) + 10` purple puffs about
    // half a block over its head; the count is drawn again every pass, as
    // the Java loop condition does.
    // rust: pub(super) fn witch_magic_particles(&mut self, id: u32) {
    // rust: let Some(m) = self
    // rust: .mobs
    // rust: .iter_mut()
    // rust: .find(|m| m.id == id && m.species() == Species::Witch)
    // rust: else {
    // rust: return;
}
    // rust: let (x, z) = (m.position.x, m.position.z);
    // rust: let top = m.bounds().max_position().y;
    // rust: let spread = f64::from(0.13_f32);
    // rust: let mut spawned = Vec::new();
    // rust: let mut i = 0;
    // rust: while i < m.random.next_int_bound(35).unwrap_or(0) + 10 {
    // rust: spawned.push([
    // rust: x + m.random.next_gaussian() * spread,
    // rust: top + 0.5 + m.random.next_gaussian() * spread,
    // rust: z + m.random.next_gaussian() * spread,
    // rust: ]);
    // rust: i += 1;
}
    // rust: let options = ParticleOptions::simple(ParticleType::Witch);
    // rust: for p in spawned {
    // rust: self.particles.add(&options, p, [0.0, 0.0, 0.0]);
}
}
    // `Ravager.handleEntityEvent(69)`: forty puffs of smoke from the middle
    // of its box, then `applyRoarKnockbackClient`: this client's own player
    // within 4 blocks is thrown away from it.
    // rust: pub(super) fn remote_ravager_roar(&mut self, id: i32) {
    // rust: let Some(m) = self
    // rust: .mobs
    // rust: .iter()
    // rust: .find(|m| m.id == id as u32 && m.species() == Species::Ravager)
    // rust: else {
    // rust: return;
}
    // rust: let (center, at, area) = (
    // rust: m.center(),
    // rust: m.position,
    // rust: m.bounds().inflate(Vec3::new(4.0, 4.0, 4.0)),
    // rust: );
    // rust: let options = ParticleOptions::simple(ParticleType::Poof);
    // rust: for _ in 0..40 {
    // rust: let r = self.particles.random();
    // rust: let v = [
    // rust: r.next_gaussian() * 0.2,
    // rust: r.next_gaussian() * 0.2,
    // rust: r.next_gaussian() * 0.2,
    // rust: ];
    // rust: self.particles.add(&options, center, v);
}
    // rust: if let Some(view) = self.player_view()
    // rust: && view.alive
    // rust: && view.bounds.intersects(area)
    // rust: && let Some(p) = self.player.as_mut()
    // rust: {
            // strongKnockback.
    // rust: let (xd, zd) = (p.position.x - at.x, p.position.z - at.z);
    // rust: let dd = (xd * xd + zd * zd).max(0.001);
    // rust: p.velocity = p
    // rust: .velocity
    // rust: .add_vector(Vec3::new(xd / dd * 4.0, 0.2, zd / dd * 4.0));
}
}
}
