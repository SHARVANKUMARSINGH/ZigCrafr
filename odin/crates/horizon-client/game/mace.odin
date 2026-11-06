//! Transpiled from Horizon Rust crate
package horizon_client_mace

import "core:fmt"
import "core:mem"
import "core:math"

// Maces (`MaceItem`): a hit after falling more than one and a half blocks is
// a smash attack. It adds damage for the height fallen (more with Density),
// stops the fall, cancels its damage and knocks the creatures around the
// target away. The rest of a weapon hit (`Player.itemAttackInteraction`)
// is here too: `hurtEnemy`, the post-attack enchantments and `postHurtEnemy`.
// use super::Game;
// use horizon_client::{
    // rust: enchant::EffectContext,
    // rust: items::ItemStack,
    // rust: mobs::{Damage, Mob, Species},
    // rust: particles::{ParticleOptions, ParticleType},
}
// use horizon_core::{
    // rust: geometry::{Aabb, Vec3},
    // rust: position::BlockPos,
    // rust: random::RandomSource,
}

// `MaceItem.SMASH_ATTACK_FALL_THRESHOLD`.
FALL_THRESHOLD :: 1.5
// `MaceItem.SMASH_ATTACK_HEAVY_THRESHOLD`.
HEAVY_THRESHOLD :: 5.0
// `MaceItem.SMASH_ATTACK_KNOCKBACK_RADIUS`.
KNOCKBACK_RADIUS :: 3.5
// `MaceItem.SMASH_ATTACK_KNOCKBACK_POWER`.
KNOCKBACK_POWER :: 0.7

// `Entity.isAlliedTo` between the player (`player` its UUID) and a mob
// without teams: `TamableAnimal.considersEntityAsAlly` (a pet it tamed) and
// `Allay.considersEntityAsAlly` (an allay that likes it).
    // rust: pub(super) fn ally_of_player(m: &Mob, player: Option<[i32; 4]>) -> bool {
    // rust: let tamable = matches!(
    // rust: m.species(),
    // rust: Species::Wolf
    // rust: | Species::Cat
    // rust: | Species::Parrot
    // rust: | Species::Nautilus
    // rust: | Species::ZombieNautilus
    // rust: );
    // rust: tamable && m.extra.tame && m.extra.owner.is_some() && m.extra.owner == player
    // rust: || m.species() == Species::Allay && m.extra.tame
}

// The entity a sweep leaves out: the one the attack hit (`target` of
// `Player.doSweepAttack`).
    // rust: pub(super) enum Spared {
    // rust: Nothing,
    // rust: Mob(u32),
    // rust: Stand(u32),
    // A player of the open world, by entity id.
    // rust: Player(i32),
}

// `Player.doSweepAttack`'s `1 + ratio * f`, where `f` is the attack damage
// after `baseDamageScaleFactor` (0.2 + strength^2 * 0.8).
sweep_base_damage :: proc(ratio: f32, attack_damage: f32, scale: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: 1.0 + ratio * attack_damage * (0.2 + scale * scale * 0.8)
}
// A smash's knockback on the players, put off while a guest's turn holds
// the other players.
    // rust: pub(super) struct SmashPush {
    // rust: center: Vec3,
    // rust: heavy: f64,
    // rust: attacker: Option<u32>,
    // rust: team: Option<horizon_client::scoreboard::Team>,
}
// `MaceItem.getKnockbackPower` and the push of one entity at `at`, `heavy`
// being 2 after a fall of more than five blocks.
smash_push :: proc(center: Vec3, heavy: f64, at: Vec3, velocity: ^Vec3, resistance: f64) {
}
    // rust: let d = [at.x - center.x, at.y - center.y, at.z - center.z];
    // rust: let distance_sqr = d[0] * d[0] + d[1] * d[1] + d[2] * d[2];
    // rust: if distance_sqr > KNOCKBACK_RADIUS.powi(2) {
    // rust: return;
}
    // rust: let length = distance_sqr.sqrt();
    // rust: let power =
    // rust: (KNOCKBACK_RADIUS - length) * f64::from(KNOCKBACK_POWER) * heavy * (1.0 - resistance);
    // rust: if power <= 0.0 {
    // rust: return;
}
    // Vec3.normalize: a vector shorter than 1e-5 has no direction.
    // rust: let (x, z) = if length < f64::from(1.0e-5f32) {
    // rust: (0.0, 0.0)
    // rust: } else {
    // rust: (d[0] / length * power, d[2] / length * power)
}
    // rust: *velocity = Vec3::new(
    // rust: velocity.x + x,
    // rust: velocity.y + f64::from(KNOCKBACK_POWER),
    // rust: velocity.z + z,
    // rust: );
}

    // rust: impl Game<'_> {
holds_mace :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.inventory[self.selected]
    // rust: .as_ref()
    // rust: .is_some_and(|s| &*s.item == "minecraft:mace")
}
    // `MaceItem.canSmashAttack` for the player: falling and not gliding.
can_smash_attack :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.player
    // rust: .as_ref()
    // rust: .is_some_and(|p| p.fall_distance > FALL_THRESHOLD && !p.fall_flying)
}
    // A held mace about to smash (`MaceItem.getItemDamageSource`: the attack
    // is `mace_smash` damage).
    // rust: pub(super) fn smash_attack(&self) -> bool {
    // rust: self.holds_mace() && self.can_smash_attack()
}
    // The damage source of the player's hit from `from` with the held item.
    // rust: pub(super) fn attack_source(&self, from: [f64; 3]) -> Damage {
    // rust: if self.smash_attack() {
    // rust: Damage::mace(from)
    // rust: } else {
    // rust: Damage::player(from)
}
}
    // `MaceItem.getAttackDamageBonus` against `victim`: 4 per block for the
    // first three blocks fallen, 2 for the next five, 1 after that, plus
    // `smash_damage_per_fallen_block` (Density) for every block.
    // rust: pub(super) fn smash_damage_bonus(&mut self, victim: &str) -> f32 {
    // rust: if !self.smash_attack() {
    // rust: return 0.0;
}
    // rust: let fall = self.player.as_ref().map_or(0.0, |p| p.fall_distance);
    // rust: let damage = if fall <= 3.0 {
    // rust: 4.0 * fall
    // rust: } else if fall <= 8.0 {
    // rust: 12.0 + 2.0 * (fall - 3.0)
    // rust: } else {
    // rust: 22.0 + fall - 8.0
}
    // rust: let held = self.inventory[self.selected].clone();
    // rust: let ctx = EffectContext {
    // rust: this: Some(victim),
    // rust: attacker: Some("minecraft:player"),
    // rust: direct_attacker: Some("minecraft:player"),
    // rust: is_direct: true,
    // rust: damage_type: Some("minecraft:mace_smash"),
    // rust: items: Some(world_items!(self)),
    // rust: ..Default::default()
}
        // EnchantmentHelper.modifyFallBasedDamage(..., 0)
    // rust: let per_block = world_stations!(self).enchantments.modify_value(
    // rust: held.as_ref(),
    // rust: "minecraft:smash_damage_per_fallen_block",
    // rust: &ctx,
    // rust: &mut self.world.random,
    // rust: 0.0,
    // rust: );
    // rust: (damage + f64::from(per_block) * fall) as f32
}
    // `source.getEntity()` of a blow as `SulfurCube.knockback` reads it: its eye position
    // (`getEyePosition`), view direction (`getLookAngle`, `calculateViewVector(xRot, yRot)`)
    // and feet (`position`). The player is the one acting, a mob one in the list.
    // rust: pub(super) fn attacker_aim(
    // rust: &self,
    // rust: who: Option<horizon_client::mobs::Who>,
    // rust: ) -> Option<horizon_client::mobs::Aim> {
    // rust: match who? {
    // rust: horizon_client::mobs::Who::Player => {
    // rust: let p = self.player.as_ref()?;
    // rust: let look = horizon_world::view_direction::view_vector(self.pitch, self.yaw);
    // rust: Some(horizon_client::mobs::Aim {
    // rust: eye: self.eye_position()?,
    // rust: look: [look.x, look.y, look.z],
    // rust: feet: [p.position.x, p.position.y, p.position.z],
    // rust: })
}
    // rust: horizon_client::mobs::Who::Mob(id) => {
    // rust: let m = self.mobs.iter().find(|m| m.id == id)?;
    // rust: Some(horizon_client::mobs::Aim {
    // rust: eye: [m.position.x, m.eye_y(), m.position.z],
    // rust: look: m.look_angle(),
    // rust: feet: [m.position.x, m.position.y, m.position.z],
    // rust: })
}
}
}
    // Only the connected owner's acting context supplies a verified identity.
    // Guests and unresolved sources retain the existing damage API behavior.
    // rust: pub(super) fn owner_damage_uuid(&self) -> Option<[i32; 4]> {
    // rust: if self.lan_acting.is_some() && self.lan_acting_uuid.is_none() {
    // rust: return None;
}
    // rust: let actual = self
    // rust: .lan_acting_uuid
    // rust: .map(horizon_client::lan::playerdata::uuid_ints)
    // rust: .or(self.level.player_uuid)?;
    // rust: let owner = self
    // rust: .serving
    // rust: .as_ref()
    // rust: .map(|s| horizon_client::lan::playerdata::uuid_ints(s.owner))
    // rust: .or(self.level.player_uuid)?;
    // rust: (actual == owner).then_some(actual)
}
    // `LivingEntity.hurtServer` of the mob at `index` by the player's hit:
    // the weapon's `armor_effectiveness` enchantments (Breach) thin its armor.
    // rust: pub(super) fn hurt_by_player(&mut self, index: usize, amount: f32, source: Damage) -> bool {
    // rust: let player_uuid = (source.attacker == Some(horizon_client::mobs::Who::Player))
    // rust: .then(|| self.owner_damage_uuid())
    // rust: .flatten();
    // rust: let _attacker = self.knockback_scope(self.player.as_ref().map_or(0, |p| p.entity_id));
    // rust: let held = self.held().cloned();
    // rust: let aim = self.attacker_aim(source.attacker);
    // rust: let kind = self.mobs[index].kind.id.clone();
    // rust: let mut amount = amount;
        // After the invulnerability guard, as `LivingIncomingDamageEvent` fires.
    // rust: if !crate::mod_api::mods().is_empty() && !self.mobs[index].refuses_damage(&source) {
    // rust: let victim = &self.mobs[index];
    // rust: let position = victim.position;
    // rust: let view = super::view_vector(victim.head_yaw, victim.head_pitch);
    // rust: let mut canceled = false;
    // rust: self.native_living_incoming_damage_v2(
    // rust: victim.id as i32,
    // rust: &kind,
    // rust: super::creatures::source_damage_type(source),
    // rust: self.player.as_ref().map_or(0, |player| player.entity_id),
    // rust: source.from,
    // rust: [position.x, position.y, position.z],
    // rust: view,
    // rust: held.as_ref(),
    // rust: &mut amount,
    // rust: &mut canceled,
    // rust: );
    // rust: if canceled {
    // rust: return false;
}
}
    // rust: let ctx = EffectContext {
    // rust: this: Some(&kind),
    // rust: attacker: Some("minecraft:player"),
    // rust: direct_attacker: Some("minecraft:player"),
    // rust: is_direct: true,
    // rust: damage_type: Some(match source.kind {
    // rust: horizon_client::mobs::DamageKind::MaceSmash => "minecraft:mace_smash",
    // rust: horizon_client::mobs::DamageKind::Spear => "minecraft:spear",
    // rust: _ => "minecraft:player_attack",
    // rust: }),
    // rust: items: Some(world_items!(self)),
    // rust: ..Default::default()
}
    // rust: let enchantments = &world_stations!(self).enchantments;
    // rust: let random = &mut self.world.random;
        // CombatRules.getDamageAfterAbsorb: EnchantmentHelper.modifyArmorEffectiveness.
    // rust: let mut breach = |fraction: f32| {
    // rust: enchantments.modify_value(
    // rust: held.as_ref(),
    // rust: "minecraft:armor_effectiveness",
    // rust: &ctx,
    // rust: random,
    // rust: fraction,
    // rust: )
}
    // rust: let old_health = self.mobs[index].health;
        // The causing entity's aim, for what turns a blow by where it points
        // (`SulfurCube.knockback`).
    // rust: self.mobs[index].attacker_aim = aim;
        // Absorbed tenths left by a hit that came another way (a player's projectile) are
        // not this player's.
    // rust: self.mobs[index].dealt_absorbed = 0;
    // rust: let hurt = match player_uuid {
    // rust: Some(uuid) => {
    // rust: self.mobs[index].damage_with_player_uuid(amount, source, uuid, Some(&mut breach))
}
    // rust: None => self.mobs[index].damage_with(amount, source, Some(&mut breach)),
}
    // rust: self.mobs[index].attacker_aim = None;
        // LivingEntity.actuallyHurt: Stats.DAMAGE_DEALT_ABSORBED for the attacking player,
        // awarded here, during that player's own attack (a server's guest has its own
        // statistics only inside `as_guest`).
    // rust: let absorbed = std::mem::take(&mut self.mobs[index].dealt_absorbed);
    // rust: if absorbed > 0 {
    // rust: self.award_custom_stat("damage_dealt_absorbed", absorbed);
}
    // rust: if hurt && self.mobs[index].health != old_health {
    // rust: self.mob_damage_event(self.mobs[index].id);
}
    // rust: hurt
}
    // `Player.itemAttackInteraction` after the player's hit landed on the mob
    // at `index`: the item's `hurtEnemy` (the "used" statistic of a weapon),
    // the post-attack enchantments, then `postHurtEnemy` with the weapon's
    // wear.
    // rust: pub(super) fn weapon_hit(&mut self, index: usize) {
    // rust: let Some(stack) = self.held().cloned() else {
    // rust: return;
}
    // rust: let weapon = self
    // rust: .res
    // rust: .items()
    // rust: .get(&stack.item)
    // rust: .and_then(|i| i.weapon_damage.map(|d| (d, i.max_damage)));
    // rust: self.native_hurt_enemy_event(&stack, index);
    // rust: let smash = self.smash_attack();
    // rust: if smash {
    // rust: self.mace_hurt_enemy(index);
}
    // rust: if weapon.is_some() {
    // rust: self.award_stat("used", &stack.item, 1);
}
    // rust: self.post_attack(index);
        // MaceItem.postHurtEnemy
    // rust: if smash && let Some(p) = self.player.as_mut() {
    // rust: p.fall_distance = 0.0;
}
    // rust: self.weapon_wear(&stack);
}
    // `ItemStack.postHurtEnemy`: `hurtAndBreak(weapon.itemDamagePerAttack)` of
    // the weapon in the acting hand.
    // rust: pub(super) fn weapon_wear(&mut self, stack: &ItemStack) {
    // rust: let weapon = self
    // rust: .res
    // rust: .items()
    // rust: .get(&stack.item)
    // rust: .and_then(|i| i.weapon_damage.map(|d| (d, i.max_damage)));
    // rust: if let Some((per_attack, max)) = weapon
    // rust: && max > 0
    // rust: && !self.creative
    // rust: {
    // rust: self.damage_held(per_attack);
}
}
    // `MaceItem.hurtEnemy` for a smash: the fall stops and its damage is
    // waived from where the hit landed, the ground or air smash sounds, and
    // the knockback around the target.
mace_hurt_enemy :: proc(self: ^Self, index: uint) {
}
    // rust: let target_on_ground = self.mobs[index].on_ground;
    // rust: if let Some(fall) = self.mace_smash_self(target_on_ground) {
    // rust: let target = &self.mobs[index];
    // rust: self.smash_knockback(target.position, Spared::Mob(target.id), fall);
}
}
    // The attacker's side of `MaceItem.hurtEnemy` for a smash: the fall
    // stops, its damage is waived from where the hit landed, and the ground
    // or air smash sound plays. The fall distance it was, if there is a
    // player.
mace_smash_self :: proc(self: ^Self, target_on_ground: bool) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let p = self.player.as_mut()?;
    // rust: p.velocity = Vec3::new(p.velocity.x, f64::from(0.01f32), p.velocity.z);
        // A server player's client is told (ClientboundSetEntityMotionPacket): it moves by
        // itself, so without it a Wind Burst's push would add to the speed of the fall.
    // rust: p.health.sync_velocity = true;
        // calculateImpactPosition: an earlier impact below the player stays.
    // rust: let impact = match p.impulse.impact_position {
    // rust: Some(at) if at.y <= p.position.y => at,
    // rust: _ => p.position,
}
    // rust: p.impulse.set_ignore_fall_damage(true, Some(impact));
    // rust: let fall = p.fall_distance;
    // rust: let feet = [p.position.x, p.position.y, p.position.z];
    // rust: let sound = if target_on_ground {
    // rust: p.spawn_extra_particles_on_fall = true;
    // rust: if fall > HEAVY_THRESHOLD {
    // rust: "minecraft:item.mace.smash_ground_heavy"
    // rust: } else {
    // rust: "minecraft:item.mace.smash_ground"
}
    // rust: } else {
    // rust: "minecraft:item.mace.smash_air"
}
    // rust: self.audio.play(sound, Some(feet), 1.0, 1.0);
    // rust: Some(fall)
}
    // `Player.itemAttackInteraction` after the player's hit hurt another
    // player: the weapon's side of it, as `weapon_hit` does for a mob. A
    // smash stops the fall and its Wind Burst (a `post_attack` explosion on
    // the attacker) launches the attacker.
    // rust: pub(super) fn weapon_hit_player(&mut self, victim_on_ground: bool) {
    // rust: let Some(stack) = self.held().cloned() else {
    // rust: return;
}
    // rust: let smash = self.smash_attack();
    // rust: if smash {
    // rust: self.mace_smash_self(victim_on_ground);
}
    // rust: if self
    // rust: .res
    // rust: .items()
    // rust: .get(&stack.item)
    // rust: .is_some_and(|i| i.weapon_damage.is_some())
    // rust: {
    // rust: self.award_stat("used", &stack.item, 1);
}
    // rust: self.post_attack_bursts(&stack, "minecraft:player");
        // MaceItem.postHurtEnemy
    // rust: if smash && let Some(p) = self.player.as_mut() {
    // rust: p.fall_distance = 0.0;
}
    // rust: self.weapon_wear(&stack);
}
    // `Player.itemAttackInteraction` after the player's hit hurt the armor
    // stand `id` (a living target) at `center`: as `weapon_hit` does for a
    // mob, a smash stops the fall and knocks the creatures around the stand
    // away, and the Wind Burst (a `post_attack` explosion on the attacker)
    // launches the attacker.
    // rust: pub(super) fn weapon_hit_stand(&mut self, id: u32, center: Vec3, on_ground: bool) {
    // rust: let Some(stack) = self.held().cloned() else {
    // rust: return;
}
    // rust: if self.smash_attack()
    // rust: && let Some(fall) = self.mace_smash_self(on_ground)
    // rust: {
    // rust: self.smash_knockback(center, Spared::Stand(id), fall);
}
    // rust: if self
    // rust: .res
    // rust: .items()
    // rust: .get(&stack.item)
    // rust: .is_some_and(|i| i.weapon_damage.is_some())
    // rust: {
    // rust: self.award_stat("used", &stack.item, 1);
}
    // rust: self.post_attack_bursts(&stack, "minecraft:armor_stand");
        // MaceItem.postHurtEnemy
    // rust: if self.smash_attack()
    // rust: && let Some(p) = self.player.as_mut()
    // rust: {
    // rust: p.fall_distance = 0.0;
}
    // rust: self.weapon_wear(&stack);
}
    // `MaceItem.knockback`: the dust pillar (level event 2013) under the
    // target, then every living entity within 3.5 blocks of it but the
    // player and the target pushed away and up, harder after a fall of more
    // than five blocks. Spectators, the player's allies (`isAlliedTo`: its
    // pets and the allays that like it), marker armor stands and creative
    // flyers are spared; the predicate's own tamed-animal test asks whether
    // the target owns the animal, which a mob never does.
smash_knockback :: proc(self: ^Self, center: Vec3, target: Spared, fall: f64) {
}
        // Entity.getOnPos without a supporting block.
    // rust: let on_pos = [
    // rust: center.x.floor() as i32,
    // rust: (center.y - f64::from(1.0e-5f32)).floor() as i32,
    // rust: center.z.floor() as i32,
    // rust: ];
    // rust: self.level_event_at(2013, on_pos, 750);
    // rust: let heavy = if fall > HEAVY_THRESHOLD { 2.0 } else { 1.0 };
    // rust: let player = Some(self.acting_uuid());
    // rust: for m in self.mobs.iter_mut().filter(|m| {
    // rust: target != Spared::Mob(m.id) && m.alive() && !m.removed && !ally_of_player(m, player)
    // rust: }) {
    // rust: let resistance = m.knockback_resistance();
    // rust: smash_push(center, heavy, m.position, &mut m.velocity, resistance);
}
    // rust: for s in self
    // rust: .armor_stands
    // rust: .iter_mut()
    // rust: .filter(|s| !s.marker && target != Spared::Stand(s.id))
    // rust: {
    // rust: smash_push(center, heavy, s.position, &mut s.velocity, 0.0);
}
        // The host and the LAN guests are living entities too. A guest's turn
        // holds the other players (`as_guest`): the push waits for it to end.
    // rust: let push = SmashPush {
    // rust: center,
    // rust: heavy,
    // rust: attacker: self.lan_acting,
    // rust: team: self.player_team().cloned(),
}
    // rust: if self.lan_acting.is_some() {
    // rust: self.creatures.smash_pushes.push(push);
    // rust: } else {
    // rust: self.smash_push_players(&push);
}
}
    // `MaceItem.knockback` on the players but the attacker: the host unless
    // it attacked, and every guest but the attacker.
smash_push_players :: proc(self: ^Self, push: ^SmashPush) {
}
    // rust: if push.attacker.is_some() {
    // rust: self.smash_push_player(push);
}
    // rust: self.each_guest_hit_except(push.attacker, |g| g.smash_push_player(push));
}
    // The pushes guests' smashes put off.
    // rust: pub(super) fn flush_smash_pushes(&mut self) {
    // rust: for push in std::mem::take(&mut self.creatures.smash_pushes) {
    // rust: self.smash_push_players(&push);
}
}
    // `MaceItem.knockback` on the player here (the host, or the guest swapped
    // in): not a spectator, an ally of the attacker (`isAlliedTo`: the same
    // team) or a creative player flying.
smash_push_player :: proc(self: ^Self, push: ^SmashPush) {
}
    // rust: if self.spectator()
    // rust: || horizon_client::scoreboard::teams_allied(push.team.as_ref(), self.player_team())
    // rust: {
    // rust: return;
}
    // rust: let creative = self.creative;
    // rust: let Some(p) = self.player.as_mut() else {
    // rust: return;
}
    // rust: if creative && p.flying {
    // rust: return;
}
    // rust: let resistance = p.attribute("minecraft:knockback_resistance").unwrap_or(0.0);
    // rust: smash_push(
    // rust: push.center,
    // rust: push.heavy,
    // rust: p.position,
    // rust: &mut p.velocity,
    // rust: resistance,
    // rust: );
}
    // `Player.doSweepAttack`'s victims: every other living mob and every
    // armor stand (but a marker one) in `target`'s box inflated by
    // (1, 0.25, 1) and under three blocks from the player takes
    // `getEnchantedDamage(1 + sweeping ratio * attack damage) * strength`,
    // knocked back 0.4 along the player's yaw. The player's allies and the
    // target (`spared`) are spared.
    // rust: pub(super) fn sweep_damage(&mut self, target: Aabb, spared: Spared, scale: f32) {
    // rust: let Some(player) = self.player.as_ref() else {
    // rust: return;
}
    // rust: let _attacker = self.knockback_scope(player.entity_id);
    // rust: let from = [player.position.x, player.position.y, player.position.z];
    // rust: let area = target.inflate(Vec3::new(1.0, 0.25, 1.0));
    // rust: let near = |at: Vec3| {
    // rust: (0..3)
    // rust: .map(|a| [at.x, at.y, at.z][a] - from[a])
    // rust: .map(|d| d * d)
    // rust: .sum::<f64>()
    // rust: < 9.0
}
        // The enchantment's `sweeping_damage_ratio` attribute modifier (level /
        // (level + 1)) on the attribute's 0 to 1 range.
    // rust: let ratio = self
    // rust: .res
    // rust: .stations()
    // rust: .enchantments
    // rust: .attribute_add(
    // rust: self.inventory[self.selected].as_ref(),
    // rust: "minecraft:sweeping_damage_ratio",
    // rust: )
    // rust: .clamp(0.0, 1.0) as f32;
        // `f` of doSweepAttack: the attack damage attribute after
        // baseDamageScaleFactor (a sweep is never a smash or a critical hit).
    // rust: let spin = self.player.as_ref().map_or(0.0, |p| p.auto_spin_attack_dmg);
    // rust: let attribute = if spin > 0.0 {
    // rust: spin
    // rust: } else {
    // rust: self.attack_damage()
}
    // rust: let base = sweep_base_damage(ratio, attribute, scale);
    // rust: let (xd, zd) = self.extra_knockback_direction();
    // rust: let uuid = Some(self.acting_uuid());
    // rust: let allies = self.player_allies();
        // getEntitiesOfClass walks the entity sections (x, then z, then y)
        // under the box, each in the order its entities were added.
    // rust: let section = |at: Vec3| {
    // rust: (
    // rust: (at.x.floor() as i32) >> 4,
    // rust: (at.z.floor() as i32) >> 4,
    // rust: (at.y.floor() as i32) >> 4,
    // rust: )
}
    // rust: let mut victims: Vec<((i32, i32, i32), u32, bool)> = Vec::new();
    // rust: for m in &self.mobs {
    // rust: if spared != Spared::Mob(m.id)
    // rust: && m.alive()
    // rust: && !m.removed
    // rust: && !allies.contains(&m.id)
    // rust: && !ally_of_player(m, uuid)
    // rust: && m.bounds().intersects(area)
    // rust: && near(m.position)
    // rust: {
    // rust: victims.push((section(m.position), m.id, false));
}
}
    // rust: for s in &self.armor_stands {
    // rust: if !s.marker
    // rust: && spared != Spared::Stand(s.id)
    // rust: && s.bounds().intersects(area)
    // rust: && near(s.position)
    // rust: {
    // rust: victims.push((section(s.position), s.id, true));
}
}
    // rust: victims.sort_by_key(|&(key, id, _)| (key, id));
    // rust: for (_, id, is_stand) in victims {
    // rust: if is_stand {
    // rust: let Some(i) = self.armor_stands.iter().position(|s| s.id == id) else {
    // rust: continue;
}
                // knockback(0.4, ..) follows a hurtServer that landed, on a
                // stand that is still there (LivingEntity.knockback).
    // rust: if !self.punch_armor_stand(i) {
    // rust: continue;
}
    // rust: let mut knock = horizon_client::health::Knock {
    // rust: strength: 0.4,
    // rust: x: xd,
    // rust: z: zd,
}
    // rust: let source = horizon_client::health::HurtSource {
    // rust: damage_type: "minecraft:player_attack",
    // rust: causing: horizon_client::health::knockback_attacker(),
    // rust: direct: horizon_client::health::knockback_attacker(),
}
    // rust: if horizon_client::health::knockback_canceled(
    // rust: horizon_client::health::Hurting::ArmorStand(id as i32, source),
    // rust: &mut knock,
    // rust: ) || knock.strength <= 0.0
    // rust: {
    // rust: continue;
}
    // rust: let (mut kx, mut kz) = (knock.x, knock.z);
    // rust: while kx * kx + kz * kz < f64::from(1.0e-5_f32) {
    // rust: let r = &mut self.world.random;
    // rust: kx = (r.next_double() - r.next_double()) * 0.01;
    // rust: kz = (r.next_double() - r.next_double()) * 0.01;
}
    // rust: let len = (kx * kx + kz * kz).sqrt();
    // rust: if let Some(s) = self.armor_stands.iter_mut().find(|s| s.id == id) {
    // rust: s.velocity = Vec3::new(
    // rust: s.velocity.x / 2.0 - kx / len * knock.strength,
    // rust: if s.on_ground {
    // rust: (s.velocity.y / 2.0 + knock.strength).min(0.4)
    // rust: } else {
    // rust: s.velocity.y
    // rust: },
    // rust: s.velocity.z / 2.0 - kz / len * knock.strength,
    // rust: );
}
    // rust: continue;
}
    // rust: let Some(i) = self.mobs.iter().position(|m| m.id == id) else {
    // rust: continue;
}
    // rust: let kind = self.mobs[i].kind.id.clone();
    // rust: let kind = format!("minecraft:{}", kind.trim_start_matches("minecraft:"));
    // rust: let amount = self.enchanted_damage(&kind, base) * scale;
    // rust: let source = self.attack_source(from);
            // hurtServer first; the knockback and post-attack effects follow
            // only when it landed.
    // rust: let old_health = self.mobs[i].health;
    // rust: if self.hurt_by_player(i, amount, source) {
    // rust: if old_health > 0.0 && !self.mobs[i].alive() {
    // rust: self.native_kill_event(i);
}
    // rust: self.mobs[i].knockback(0.4, xd, zd, &source);
    // rust: self.last_hurt_by_player
    // rust: .insert(self.mobs[i].id, self.lan_acting);
    // rust: self.post_attack(i);
}
}
        // `getEntitiesOfClass(LivingEntity.class)` takes the other players too.
    // rust: let mut sweep = self.player_sweep(base, scale);
    // rust: sweep.hit_box = area;
    // rust: sweep.skip = match spared {
    // rust: Spared::Player(id) => Some(id),
    // rust: _ => None,
}
    // rust: self.sweep_other_players(sweep);
}
    // Level event 2013 (`ParticleUtils.spawnSmashAttackParticles`): dust
    // pillars of the block at `pos`, a cluster over it and a ring 3.5 out.
    // rust: pub(super) fn smash_dust(&mut self, pos: BlockPos, count: i32) {
    // rust: let state = self.world.block(pos.x, pos.y, pos.z);
    // rust: let Some((sprite, tint)) = self.particle_sprite(state, [pos.x, pos.y, pos.z]) else {
    // rust: return;
}
    // rust: let options = ParticleOptions::block(ParticleType::DustPillar, sprite, tint);
    // rust: let center = [
    // rust: f64::from(pos.x) + 0.5,
    // rust: f64::from(pos.y) + 1.0,
    // rust: f64::from(pos.z) + 0.5,
    // rust: ];
    // rust: let near = f64::from(0.2f32);
    // rust: let mut i = 0;
    // rust: while (i as f32) < count as f32 / 3.0 {
    // rust: let r = self.particles.random();
    // rust: let x = center[0] + r.next_gaussian() / 2.0;
    // rust: let z = center[2] + r.next_gaussian() / 2.0;
    // rust: let v = [
    // rust: r.next_gaussian() * near,
    // rust: r.next_gaussian() * near,
    // rust: r.next_gaussian() * near,
    // rust: ];
    // rust: self.particles.add(&options, [x, center[1], z], v);
    // rust: i += 1;
}
    // rust: let far = f64::from(0.05f32);
    // rust: let mut i = 0;
    // rust: while (i as f32) < count as f32 / 1.5 {
    // rust: let r = self.particles.random();
    // rust: let angle = f64::from(i);
    // rust: let x = center[0] + KNOCKBACK_RADIUS * angle.cos() + r.next_gaussian() / 2.0;
    // rust: let z = center[2] + KNOCKBACK_RADIUS * angle.sin() + r.next_gaussian() / 2.0;
    // rust: let v = [
    // rust: r.next_gaussian() * far,
    // rust: r.next_gaussian() * far,
    // rust: r.next_gaussian() * far,
    // rust: ];
    // rust: self.particles.add(&options, [x, center[1], z], v);
    // rust: i += 1;
}
}
}

    // rust: mod tests {
//     use super::*;

sweep_damage_is_one_without_the_enchantment :: proc() {
}
        // A fully charged diamond sword (8 attack damage): neighbours take 1.
    // rust: assert_eq!(sweep_base_damage(0.0, 8.0, 1.0), 1.0);
        // Sweeping Edge III adds the ratio of the (charged) attack damage.
    // rust: assert_eq!(sweep_base_damage(0.75, 8.0, 1.0), 7.0);
        // baseDamageScaleFactor at 0.95 strength.
    // rust: let scaled = sweep_base_damage(0.5, 8.0, 0.95);
    // rust: assert!((scaled - (1.0 + 0.5 * 8.0 * (0.2 + 0.95 * 0.95 * 0.8))).abs() < 1e-6);
}
}
