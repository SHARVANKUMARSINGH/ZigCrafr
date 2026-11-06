//! Transpiled from Horizon Rust crate
package horizon_client_deflect

import "core:fmt"
import "core:mem"
import "core:math"

// A player's blow at a ghast's fireball or a wind charge
// (`#minecraft:redirectable_projectile`): `Player.attack` turns it with
// `ProjectileDeflection.AIM_DEFLECT` instead of hurting anything. It flies on
// along the player's view and is the player's now (`Projectile.deflect`
// sets the owner), so a ghast it meets dies of it (`Ghast.isReflectedFireball`).
// use super::{Game, lan::LanHost, ray_box, view_vector};
// use horizon_client::{
    // rust: mobs::Who,
    // rust: projectiles::{Projectile, ProjectileKind},
}
// use horizon_core::geometry::{Aabb, Vec3};

// `AbstractHurtingProjectile.getPickRadius`: the crosshair finds it a block
// round its box.
PICK_RADIUS :: 1.0

// `#minecraft:redirectable_projectile`: a ghast's fireball and both wind charges.
    // rust: pub(super) fn redirectable(p: &Projectile) -> bool {
    // rust: !p.stuck
    // rust: && matches!(
    // rust: p.kind,
    // rust: ProjectileKind::LargeFireball { .. }
    // rust: | ProjectileKind::WindCharge
    // rust: | ProjectileKind::BreezeWindCharge
    // rust: )
}

// `Projectile.onRedirectProjectile`: another projectile hit `p`, which turns
// with `deflect(AIM_DEFLECT, hitter's owner, hitter's owner, true, 1.0)`.
// It flies along the owner's look (`Entity.getLookAngle`; unchanged when the
// owner is gone), is that owner's now, and its acceleration power is back
// to 0.1 (`AbstractHurtingProjectile.onDeflection` by an attack).
    // rust: pub(super) fn aim_deflect(
    // rust: p: &mut Projectile,
    // rust: look: Option<Vec3>,
    // rust: owner: Option<Who>,
    // rust: owner_uuid: Option<[i32; 4]>,
    // rust: guest: Option<u32>,
    // rust: ) {
    // rust: if let Some(look) = look {
    // rust: p.velocity = look;
    // rust: p.needs_sync = true;
}
    // rust: (p.owner, p.owner_uuid, p.guest) = (owner, owner_uuid, guest);
    // rust: p.acceleration = 0.1;
}

// `Entity.getPickRadius`: only `AbstractHurtingProjectile` has one (1); a shulker
// bullet's is 0.
pick_radius :: proc(p: ^Projectile) -> f {
    // Ported from Horizon
    return {}
}
    // rust: if matches!(p.kind, ProjectileKind::ShulkerBullet { .. }) {
    // rust: 0.0
    // rust: } else {
    // rust: PICK_RADIUS
}
}

// A projectile a player's blow reaches: a redirectable one, or a shulker bullet
// (`isPickable` and `isAttackable`), which `ShulkerBullet.hurtServer` pops.
    // rust: pub(super) fn attackable(p: &Projectile) -> bool {
    // rust: redirectable(p) || (!p.stuck && matches!(p.kind, ProjectileKind::ShulkerBullet { .. }))
}

// Its box for the crosshair: the entity's (a fireball 1 x 1, a wind charge or a
// shulker bullet 0.3125, from its feet up) grown by the pick radius, which only
// `AbstractHurtingProjectile` has (`getPickRadius`: 1; a shulker bullet's is 0).
pick_box :: proc(p: ^Projectile) -> A {
    // Ported from Horizon
    return {}
}
    // rust: let size = match p.kind {
    // rust: ProjectileKind::LargeFireball { .. } => 1.0,
    // rust: _ => 0.3125,
}
    // rust: let radius = pick_radius(p);
    // rust: let half = size / 2.0 + radius;
    // rust: Aabb::new(
    // rust: Vec3::new(
    // rust: p.position.x - half,
    // rust: p.position.y - radius,
    // rust: p.position.z - half,
    // rust: ),
    // rust: Vec3::new(
    // rust: p.position.x + half,
    // rust: p.position.y + size + radius,
    // rust: p.position.z + half,
    // rust: ),
    // rust: )
}

    // rust: impl Game<'_> {
    // The redirectable projectile under the crosshair within the attack
    // reach, and how far along the view it is.
    // rust: pub(super) fn redirectable_hit(&self) -> Option<(usize, f64)> {
    // rust: let (eye, dir) = self.aim()?;
    // rust: let reach: f64 = self.entity_reach;
    // rust: self.creatures
    // rust: .projectiles
    // rust: .iter()
    // rust: .enumerate()
    // rust: .filter(|(_, p)| attackable(p))
    // rust: .filter_map(|(i, p)| ray_box(eye, dir, reach, pick_box(p)).map(|t| (i, t)))
    // rust: .min_by(|a, b| a.1.total_cmp(&b.1))
}

    // `Player.attack` on a redirectable projectile nearer than any mob or
    // block in view: `AIM_DEFLECT` (its movement the unit view vector), the
    // player its owner, its acceleration power back to 0.1
    // (`onDeflection` by an attack), and the no-damage sound. True when a
    // projectile was turned.
    // rust: pub(super) fn attack_redirectable(&mut self) -> bool {
    // rust: let Some((i, t)) = self.redirectable_hit() else {
    // rust: return false;
}
    // rust: if self.mob_hit().is_some_and(|(_, d, _)| d < t) {
    // rust: return false;
}
    // rust: if let (Some(hit), Some(eye)) = (self.pick_unfiltered(), self.eye_position()) {
    // rust: let d = (0..3)
    // rust: .map(|a| (hit.point[a] - eye[a]).powi(2))
    // rust: .sum::<f64>()
    // rust: .sqrt();
    // rust: if d < t {
    // rust: return false;
}
}
    // rust: if matches!(
    // rust: self.creatures.projectiles[i].kind,
    // rust: ProjectileKind::ShulkerBullet { .. }
    // rust: ) {
    // rust: self.hit_shulker_bullet(None, i);
    // rust: } else {
    // rust: self.deflect(i);
}
    // rust: true
}

    // `ShulkerBullet.hurtServer` from a player's blow: the hurt sound, fifteen crit
    // particles (`sendParticles`, spread 0.2) and `destroy`. The blow is
    // `Player.attack` on a target that is not a mob: its sounds, then the swing.
    // rust: pub(super) fn hit_shulker_bullet(&mut self, host: Option<&LanHost>, i: usize) {
    // rust: let p = self.creatures.projectiles.remove(i);
    // rust: let at = [p.position.x, p.position.y, p.position.z];
    // rust: self.audio
    // rust: .play("minecraft:entity.shulker_bullet.hurt", Some(at), 1.0, 1.0);
    // rust: if let Some(ty) = horizon_client::particles::ParticleType::from_name("crit") {
    // rust: let options = horizon_client::particles::ParticleOptions::simple(ty);
    // rust: self.particles
    // rust: .send_particles(&options, at, [0.2, 0.2, 0.2], 0.0, 15);
    // rust: self.lan_level_particles(host, &options, at, [0.2, 0.2, 0.2], 0.0, 15, None);
}
    // rust: let (_, _, _, magic) = self.melee_damage("minecraft:shulker_bullet", false);
    // rust: self.vehicle_attack_sounds(p.aabb(), magic.then_some(p.id as i32));
    // rust: self.reset_attack_strength();
    // rust: self.swing_arm();
}

    // `Player.canInteractWithEntity(box, 3.0)` as the server checks an
    // attack packet: the projectile's box within the reach plus 3 of the eyes.
    // rust: pub(super) fn within_interaction_range(&self, i: usize) -> bool {
    // rust: let (Some(eye), Some(p)) = (self.eye_position(), self.creatures.projectiles.get(i)) else {
    // rust: return false;
}
    // rust: let b = pick_box(p);
    // rust: let (lo, hi) = (b.min_position(), b.max_position());
    // rust: let r = pick_radius(&self.creatures.projectiles[i]);
    // rust: let (lo, hi) = (
    // rust: [lo.x + r, lo.y + r, lo.z + r],
    // rust: [hi.x - r, hi.y - r, hi.z - r],
    // rust: );
    // rust: let d2: f64 = (0..3)
    // rust: .map(|a| (eye[a] - eye[a].clamp(lo[a], hi[a])).powi(2))
    // rust: .sum();
    // rust: let range = self.entity_reach + 3.0;
    // rust: d2 < range * range
}

    // `Entity.getLookAngle` of a projectile's owner: the host, the guest who
    // threw it, or a mob; none when the owner is not here.
    // rust: pub(super) fn owner_look(&self, owner: Option<Who>, guest: Option<u32>) -> Option<Vec3> {
    // rust: let (pitch, yaw) = match (owner?, guest) {
    // rust: (Who::Player, Some(conn)) => {
    // rust: let lan = self.lan.as_ref()?;
    // rust: let g = lan.hub.guests.iter().find(|g| g.conn == conn)?;
    // rust: (g.pitch, g.yaw)
}
    // rust: (Who::Player, None) => {
    // rust: self.player.as_ref()?;
    // rust: (self.pitch, self.yaw)
}
    // rust: (Who::Mob(id), _) => {
    // rust: let m = self.mobs.iter().find(|m| m.id == id)?;
    // rust: (m.head_pitch, m.yaw)
}
}
    // rust: Some(horizon_world::view_direction::view_vector(pitch, yaw))
}

    // `Projectile.deflect(AIM_DEFLECT, player, player, true)`.
    // rust: pub(super) fn deflect(&mut self, i: usize) {
    // rust: let dir = view_vector(self.yaw, self.pitch);
    // rust: let (guest, owner_uuid) = (self.lan_acting, Some(self.acting_player_uuid()));
    // rust: let p = &mut self.creatures.projectiles[i];
    // rust: p.velocity = Vec3::new(dir[0], dir[1], dir[2]);
    // rust: p.yaw = dir[0].atan2(dir[2]).to_degrees() as f32;
    // rust: p.pitch = dir[1].atan2(dir[0].hypot(dir[2])).to_degrees() as f32;
    // rust: p.owner = Some(Who::Player);
        // On a server, the guest who struck it (their projectile now).
    // rust: (p.guest, p.owner_uuid) = (guest, owner_uuid);
        // Not into the one who turned it on its way out.
    // rust: p.left_owner = false;
        // `AbstractHurtingProjectile.onDeflection` by an attack, and the
        // `needsSync` that `AIM_DEFLECT` sets: a server's players see it turn
        // at once, not at the fireball's next update ten ticks later.
    // rust: p.acceleration = 0.1;
    // rust: p.needs_sync = true;
    // rust: self.reset_attack_strength();
    // rust: self.swing_arm();
    // rust: let from = self
    // rust: .player
    // rust: .as_ref()
    // rust: .map(|p| [p.position.x, p.position.y, p.position.z]);
    // rust: self.audio
    // rust: .play("minecraft:entity.player.attack.nodamage", from, 1.0, 1.0);
}
}

    // rust: mod tests {
//     use super::*;

only_ghast_fireballs_and_wind_charges_are_redirectable :: proc() {
}
    // rust: let at = Vec3::new(0.0, 64.0, 0.0);
    // rust: let large = Projectile::fireball(
    // rust: ProjectileKind::LargeFireball { power: 1 },
    // rust: at,
    // rust: None,
    // rust: [1.0, 0.0, 0.0],
    // rust: );
    // rust: let small = Projectile::fireball(ProjectileKind::SmallFireball, at, None, [1.0, 0.0, 0.0]);
    // rust: assert!(redirectable(&large));
    // rust: assert!(!redirectable(&small));
        // A shulker bullet takes a blow, with no pick radius round its box.
    // rust: let bullet = Projectile::new(
    // rust: ProjectileKind::ShulkerBullet {
    // rust: target: Some(Who::Player),
    // rust: dir: None,
    // rust: steps: 0,
    // rust: delta: [0.0; 3],
    // rust: seed: 0,
    // rust: },
    // rust: at,
    // rust: None,
    // rust: );
    // rust: assert!(attackable(&bullet) && !redirectable(&bullet));
    // rust: assert!(!attackable(&small));
    // rust: let b = pick_box(&bullet);
    // rust: assert_eq!(b.max_position().y, 64.3125);
        // The pick box: a block round the fireball's 1 x 1 box.
    // rust: let b = pick_box(&large);
    // rust: assert_eq!(b.min_position().x, -1.5);
    // rust: assert_eq!(b.max_position().y, 66.0);
}

wind_charge :: proc() -> P {
    // Ported from Horizon
    return {}
}
    // rust: let mut p = Projectile::new(
    // rust: ProjectileKind::WindCharge,
    // rust: Vec3::new(0.0, 70.0, 0.0),
    // rust: Some(Who::Mob(7)),
    // rust: );
    // rust: p.velocity = Vec3::new(0.0, 1.5, 0.0);
    // rust: p
}

a_redirected_wind_charge_flies_along_the_new_owners_look :: proc() {
}
    // rust: let mut p = wind_charge();
    // rust: let look = Vec3::new(0.0, -1.0, 0.0);
    // rust: aim_deflect(&mut p, Some(look), Some(Who::Player), Some([4; 4]), Some(3));
    // rust: assert_eq!(p.velocity, look);
    // rust: assert_eq!((p.owner, p.owner_uuid), (Some(Who::Player), Some([4; 4])));
    // rust: assert_eq!(p.guest, Some(3));
    // rust: assert_eq!(p.acceleration, 0.1);
    // rust: assert!(p.needs_sync);
}

with_no_owner_here_it_keeps_its_movement_but_changes_hands :: proc() {
}
    // rust: let mut p = wind_charge();
    // rust: p.owner_uuid = Some([7; 4]);
    // rust: aim_deflect(&mut p, None, None, None, None);
    // rust: assert_eq!(p.velocity, Vec3::new(0.0, 1.5, 0.0));
    // rust: assert_eq!((p.owner, p.owner_uuid), (None, None));
    // rust: assert_eq!(p.acceleration, 0.1);
    // rust: assert!(!p.needs_sync);
}
}
