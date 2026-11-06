//! Transpiled from Horizon Rust crate
//! Module: horizon-client_spear
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Spears (`KineticWeapon`): holding the use button charges the spear, and
//! from `delay_ticks` on every living entity along the view that the
//! player's speed allows is stabbed: the damage grows with the speed
//! relative to the target, the knockback and the dismount need the
//! attacker's own speed, and each condition runs out after its time
//! (`Item.use`, `ItemStack.onUseTick`, `KineticWeapon.damageEntities`,
//! `Player.stabAttack`). The hit's feedback (`onKineticHit`) reaches the
//! players around as entity event 2. A left click jabs instead
//! (`PiercingWeapon.attack`), which Lunge turns into a dash.
// use super::{Game, view_vector};
    // rust: pub(super) use horizon_client::spear::hits_in_reach;
// use horizon_client::{
    // rust: attack_strength::delay,
    // rust: collisions::SceneCollisions,
    // rust: first_person::Hand,
    // rust: items::ItemStack,
    // rust: mobs::Damage,
    // rust: spear::{HIT_FEEDBACK_TICKS, Kinetic, REACH},
}
// use horizon_core::{
    // rust: geometry::{Aabb, Vec3, traverse_blocks},
    // rust: position::BlockPos,
}

/// The key of this window's own player in `Game::kinetic_feedback`.
    // rust: pub(super) const OWN: i32 = i32::MIN;

    // rust: impl Game<'_> {
    /// `Item.use` of a kinetic weapon: `startUsingItem` with a new
    /// `recentKineticEnemies`, and `KineticWeapon.makeSound` at the user.
    // rust: pub(super) fn use_spear(&mut self, stack: &ItemStack) -> bool {
    // rust: let Some(kinetic) = Kinetic::of(&stack.item) else {
    // rust: return false;
}
    // rust: if self.start_using_item() {
    // rust: let actor = self.lan_acting;
    // rust: self.stabbed.retain(|(who, _), _| *who != actor);
    // rust: if let Some(p) = &self.player {
    // rust: let at = [p.position.x, p.position.y, p.position.z];
    // rust: self.audio.play(kinetic.sound, Some(at), 1.0, 1.0);
}
}
    // rust: true
}

    /// `ServerPlayer.getKnownMovement` of the acting player: what they moved
    /// in the last tick. A guest's comes with their moves. A rider's is its
    /// mount's move (`getKnownSpeed`: the vehicle's, or the move the driver's
    /// client sent for it), so a charge on horseback carries the horse's speed.
    // rust: pub(super) fn known_player_movement(&self) -> Vec3 {
    // rust: if let Some(i) = self
    // rust: .riding
    // rust: .and_then(|v| self.mobs.iter().position(|m| m.id == v))
    // rust: {
    // rust: return self.mob_speed(i).scale(1.0 / 20.0);
}
    // rust: if self.lan_acting.is_some() {
    // rust: return self.known_movement;
}
    // rust: self.player
    // rust: .as_ref()
    // rust: .map_or(Vec3::ZERO, |p| p.position.subtract(self.previous_position))
}

    /// `Entity.getKnownSpeed` of the mob at `index`, per second: its root
    /// vehicle's (`KineticWeapon.getMotion`).
pub fn mob_speed(self: *Self, index: usize) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut mob = &self.mobs[index];
    // rust: while let Some(vehicle) = mob
    // rust: .extra
    // rust: .mount
    // rust: .and_then(|v| self.mobs.iter().find(|m| m.id == v))
    // rust: {
    // rust: mob = vehicle;
}
    // rust: mob.position.subtract(mob.previous).scale(20.0)
}

    /// `Level.clip` with COLLIDER shapes and no fluids: where the segment
    /// first meets a block, if it does (tall grass lets a stab through).
pub fn clip_collider(self: *Self, from: Vec3, to: Vec3) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut scene = SceneCollisions {
    // rust: world: &self.world,
    // rust: binding: self.collision,
    // rust: subject: None,
}
    // rust: traverse_blocks(from, to, 512, |p: BlockPos| {
    // rust: let state = self.world.block(p.x, p.y, p.z);
    // rust: if self.res.facts().is_air(state) {
    // rust: return None;
}
    // rust: let shape = self
    // rust: .collision
    // rust: .collision_shape(&mut scene, state, [p.x, p.y, p.z])
    // rust: .ok()?;
    // rust: shape.clip(from, to, p).map(|hit| hit.location)
    // rust: })
    // rust: .ok()
    // rust: .flatten()
}

    /// The boxes of the mobs a spear can hit: alive, and not the vehicle
    /// ridden (`PiercingWeapon.canHitEntity`), with their index.
    // rust: pub(super) fn hittable_mob_boxes(&self) -> Vec<(usize, Aabb)> {
    // rust: (self.mobs.iter().enumerate())
    // rust: .filter(|(_, m)| m.alive() && !m.removed && self.riding != Some(m.id))
    // rust: .map(|(i, m)| (i, m.bounds()))
    // rust: .collect()
}

    /// `ProjectileUtil.getHitEntitiesAlong` with the spear's `AttackRange`.
pub fn stab_targets(self: *Self, eye: Vec3, look: Vec3, movement: Vec3) V {
    // Implementation ported from Horizon
    return undefined;
}
        // AttackRange.effectiveMinRange and effectiveMaxRange for a player.
    // rust: let (min, max) = if self.creative {
    // rust: (REACH.min_creative, REACH.max_creative)
    // rust: } else {
    // rust: (REACH.min, REACH.max)
}
    // rust: let reach = (min, max, REACH.hitbox_margin);
    // rust: let clip = |from, to| self.clip_collider(from, to);
    // rust: let boxes = self.hittable_mob_boxes();
    // rust: hits_in_reach(&boxes, eye, look, movement, reach, clip)
    // rust: .into_iter()
    // rust: .map(|(i, _)| i)
    // rust: .collect()
}

    /// `KineticWeapon.damageEntities`: one tick of the spear in use, `ticks`
    /// ticks into the use.
    // rust: pub(super) fn spear_tick(&mut self, stack: &ItemStack, ticks: u32) {
    // rust: let Some(kinetic) = Kinetic::of(&stack.item) else {
    // rust: return;
}
    // rust: let used = ticks as i32 - kinetic.delay_ticks;
    // rust: let (Some(eye), Some(feet)) = (
    // rust: self.eye_position(),
    // rust: self.player.as_ref().map(|p| p.position),
    // rust: ) else {
    // rust: return;
}
    // rust: if used < 0 || self.spectator() {
    // rust: return;
}
    // rust: let eye = Vec3::new(eye[0], eye[1], eye[2]);
    // rust: let look = view_vector(self.yaw, self.pitch);
    // rust: let look = Vec3::new(look[0], look[1], look[2]);
    // rust: let movement = self.known_player_movement();
    // rust: let attacker_speed = look.dot(movement.scale(20.0));
    // rust: let now = self.world.game_time;
    // rust: let actor = self.lan_acting;
    // rust: let mut affected = false;
    // rust: for i in self.stab_targets(eye, look, movement) {
    // rust: let key = (actor, self.mobs[i].id);
    // rust: let recent = self
    // rust: .stabbed
    // rust: .get(&key)
    // rust: .is_some_and(|&t| now - t < i64::from(kinetic.contact_cooldown_ticks));
    // rust: if recent {
    // rust: continue;
}
    // rust: self.stabbed.insert(key, now);
    // rust: let target_speed = look.dot(self.mob_speed(i));
    // rust: let relative = (attacker_speed - target_speed).max(0.0);
            // An entity factor of 1 for a player.
    // rust: let dismounts = kinetic.dismount.test(used, attacker_speed, relative, 1.0);
    // rust: let pushes = kinetic.knockback.test(used, attacker_speed, relative, 1.0);
    // rust: let damages = kinetic.damage.test(used, attacker_speed, relative, 1.0);
    // rust: if dismounts || pushes || damages {
                // The attack damage attribute's base value (1) and the speed.
    // rust: let amount = 1.0 + (relative * f64::from(kinetic.damage_multiplier)).floor() as f32;
    // rust: affected |= self.stab_mob(i, amount, damages, pushes, dismounts);
}
}
    // rust: if affected {
            // Level.broadcastEntityEvent(player, 2), felt by the player too.
    // rust: if self.audio.capture.is_some() {
    // rust: self.lan_kinetic_hits.push(actor);
}
    // rust: let who = actor.map_or(OWN, |conn| conn as i32);
    // rust: self.kinetic_hit_feedback(who, &kinetic, [feet.x, feet.y, feet.z]);
            // SPEAR_MOBS_TRIGGER: the living entities stabbed in this use.
    // rust: let stabbed = self.stabbed.keys().filter(|(who, _)| *who == actor).count();
    // rust: self.trigger_spear_mobs(stabbed);
}
}

    /// `Player.stabAttack` on the mob at `index`: whether it was affected.
    // rust: fn stab_mob(
    // rust: &mut self,
    // rust: index: usize,
    // rust: base_damage: f32,
    // rust: deals_damage: bool,
    // rust: deals_knockback: bool,
    // rust: dismounts: bool,
    // rust: ) -> bool {
    // rust: let kind = format!(
    // rust: "minecraft:{}",
    // rust: self.mobs[index].kind.id.trim_start_matches("minecraft:")
    // rust: );
    // rust: let id = self.mobs[index].id;
    // rust: let Some(p) = self.player.as_ref() else {
    // rust: return false;
}
    // rust: let _attacker = self.knockback_scope(p.entity_id);
    // rust: let from = [p.position.x, p.position.y, p.position.z];
        // The enchantments' share, scaled by the attack strength unless the
        // weapon is in use.
    // rust: let magic_boost = self.enchant_damage_bonus(&kind);
    // rust: let (base_damage, magic_boost) = if self.using.is_none() {
    // rust: let scale = self.attack_strength_scale();
    // rust: (
    // rust: base_damage * (0.2 + scale * scale * 0.8),
    // rust: magic_boost * scale,
    // rust: )
    // rust: } else {
    // rust: (base_damage, magic_boost)
}
    // rust: let total = if deals_damage {
    // rust: base_damage + magic_boost
    // rust: } else {
    // rust: 0.0
}
    // rust: let old_health = self.mobs[index].health;
    // rust: let hurt = deals_damage && self.hurt_by_player(index, total, Damage::spear(from));
    // rust: if hurt && old_health > 0.0 && !self.mobs[index].alive() {
    // rust: self.native_kill_event(index);
}
        // causeExtraKnockback: a push of 0.4, then the weapon's Knockback.
    // rust: if deals_knockback {
    // rust: let (xd, zd) = self.extra_knockback_direction();
    // rust: let source = Damage::spear(from);
    // rust: self.mobs[index].knockback(0.4, xd, zd, &source);
    // rust: let (strength, _) = self.extra_knockback(&kind, 0.0);
    // rust: self.mobs[index].knockback(f64::from(strength), xd, zd, &source);
            // ...and the attacker stops sprinting.
    // rust: self.stop_sprint_after_extra_knockback();
}
    // rust: let dismounted = dismounts && self.mobs[index].extra.mount.is_some();
    // rust: if dismounted {
    // rust: self.dismount_mob(id);
}
    // rust: if !hurt && !deals_knockback && !dismounted {
    // rust: return false;
}
    // rust: let mob = &self.mobs[index];
    // rust: let (feet, width, height) = (
    // rust: [mob.position.x, mob.position.y, mob.position.z],
    // rust: mob.kind.width,
    // rust: mob.kind.height,
    // rust: );
        // attackVisualEffects: no attack sound, the enchantments' magic crit.
    // rust: if magic_boost > 0.0 {
    // rust: self.critical_hit(self.lan_acting, id as i32, feet, width, height, true);
}
    // rust: self.combat.last_hurt_mob = Some((id, self.world.game_time));
        // itemAttackInteraction: hurtEnemy (statistic, wear), and the
        // post-attack enchantments when the target was hurt.
    // rust: if let Some(stack) = self.held().cloned() {
    // rust: self.award_stat("used", &stack.item, 1);
    // rust: if hurt {
    // rust: self.post_attack(index);
}
    // rust: self.weapon_wear(&stack);
}
        // damageStatsAndHearts.
    // rust: let actual = old_health - self.mobs[index].health;
    // rust: self.award_custom_stat("damage_dealt", (actual * 10.0).round() as i32);
    // rust: if actual > 2.0 {
    // rust: let indicator = horizon_client::particles::ParticleOptions::simple(
    // rust: horizon_client::particles::ParticleType::DamageIndicator,
    // rust: );
    // rust: self.particles.send_particles(
    // rust: &indicator,
    // rust: [feet[0], feet[1] + height * 0.5, feet[2]],
    // rust: [0.1, 0.0, 0.1],
    // rust: 0.2,
    // rust: (actual * 0.5) as u32,
    // rust: );
            // The players a server serves are sent them too (the window of the server thread).
    // rust: self.lan_send_particles(super::lan_particles::QueuedParticle {
    // rust: dimension: self.dim.id(),
    // rust: options: indicator,
    // rust: state: None,
    // rust: at: [feet[0], feet[1] + height * 0.5, feet[2]],
    // rust: spread: [0.1, 0.0, 0.1],
    // rust: speed: [0.2; 3],
    // rust: count: (actual * 0.5) as u32 as i32,
    // rust: randomization: 0,
    // rust: });
}
    // rust: if hurt {
    // rust: self.last_hurt_by_player.insert(id, self.lan_acting);
}
    // rust: if let Some(p) = self.player.as_mut()
    // rust: && !self.creative
    // rust: {
    // rust: p.cause_food_exhaustion(0.1);
}
    // rust: true
}

    /// `Player.cannotAttackWithItem` for the held item: a spear needs its
    /// `minimum_attack_charge` of 1, counting `tolerance` ticks more than the
    /// `ticker` ticks charged.
    // rust: pub(super) fn cannot_attack_with_item(&self, ticker: i32, tolerance: i32) -> bool {
    // rust: self.held().is_some_and(|s| Kinetic::of(&s.item).is_some())
    // rust: && (ticker + tolerance) as f32 / delay(self.main_hand_attack_speed()) < 1.0
}

    /// `PiercingWeapon.attack` of the spear in the main hand, for a left
    /// click: every mob along the view is stabbed, then `postPiercingAttack`
    /// (Lunge), the hit sound and the swing. Gives the sound of the jab
    /// (`makeSound`), which everyone but the user hears from the server.
    // rust: pub(super) fn jab(&mut self) -> Option<&'static str> {
    // rust: let kinetic = self.held().and_then(|s| Kinetic::of(&s.item))?;
    // rust: let eye = self.eye_position()?;
    // rust: let eye = Vec3::new(eye[0], eye[1], eye[2]);
    // rust: let look = view_vector(self.yaw, self.pitch);
    // rust: let look = Vec3::new(look[0], look[1], look[2]);
        // The attack damage attribute.
    // rust: let damage = self.attack_damage();
    // rust: let movement = self.known_player_movement();
    // rust: let mut hit = false;
    // rust: for i in self.stab_targets(eye, look, movement) {
    // rust: hit |= self.stab_mob(i, damage, true, true, false);
}
        // Player.onAttack, then postPiercingAttack.
    // rust: self.attack_ticks = 0;
    // rust: self.post_piercing_attack();
    // rust: if hit {
    // rust: self.play_at_feet(kinetic.hit_sound);
}
        // swingAndResetAttackStrength (ServerPlayer): a swing that starts
        // resets the attack strength.
    // rust: let swings = self.swings_started;
    // rust: self.swing_hand(Hand::Main, kinetic.attack_animation());
    // rust: if self.swings_started != swings {
    // rust: self.reset_attack_strength();
}
    // rust: Some(kinetic.attack_sound)
}

    /// A sound at the player's feet.
    // rust: pub(super) fn play_at_feet(&mut self, sound: &str) {
    // rust: if let Some(p) = &self.player {
    // rust: let at = [p.position.x, p.position.y, p.position.z];
    // rust: self.audio.play(sound, Some(at), 1.0, 1.0);
}
}

    /// `LivingEntity.onKineticHit` for `entity`: the hit feels (the spear
    /// moves back, `kinetic_hit_ticks`) and sounds, at most once every ten
    /// ticks.
    // rust: pub(super) fn kinetic_hit_feedback(&mut self, entity: i32, kinetic: &Kinetic, at: [f64; 3]) {
    // rust: let now = self.world.game_time;
    // rust: if self
    // rust: .kinetic_feedback
    // rust: .get(&entity)
    // rust: .is_none_or(|&t| now - t > HIT_FEEDBACK_TICKS)
    // rust: {
    // rust: self.kinetic_feedback.insert(entity, now);
    // rust: self.audio
    // rust: .play_unshared(kinetic.hit_sound, Some(at), 1.0, 1.0);
}
}

    /// `getTicksSinceLastKineticHitFeedback` of this window's player.
    // rust: pub(super) fn kinetic_hit_ticks(&self, partial: f32) -> f32 {
    // rust: self.kinetic_feedback
    // rust: .get(&OWN)
    // rust: .map_or(0.0, |&t| (self.world.game_time - t) as f32 + partial)
}

    /// `LivingEntity.handleEntityEvent(2)` on a server's client: the
    /// player `id` (this one, or another) was hit by the spear it uses.
    // rust: pub(super) fn remote_kinetic_hit(&mut self, id: i32) {
    // rust: let own = self.remote.as_ref().is_some_and(|r| r.entity_id == id);
    // rust: let (item, at) = if own {
    // rust: let item = self
    // rust: .using
    // rust: .and_then(|(slot, _)| self.stack_in(slot))
    // rust: .map(|s| s.item.clone());
    // rust: let at = self.player.as_ref().map(|p| p.position);
    // rust: (item, at)
    // rust: } else {
    // rust: let mob = self
    // rust: .mobs
    // rust: .iter()
    // rust: .find(|m| m.id == id as u32 && m.extra.using_item > 0);
    // rust: let item = mob.and_then(|m| {
    // rust: if m.extra.using_off_hand {
    // rust: m.extra.off_hand.clone()
    // rust: } else {
    // rust: m.extra.main_hand.clone()
}
    // rust: });
    // rust: (item, mob.map(|m| m.position))
}
    // rust: if let (Some(kinetic), Some(at)) = (item.as_deref().and_then(Kinetic::of), at) {
    // rust: self.kinetic_hit_feedback(if own { OWN } else { id }, &kinetic, [at.x, at.y, at.z]);
}
}
}
