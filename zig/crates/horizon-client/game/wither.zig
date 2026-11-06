//! Transpiled from Horizon Rust crate
//! Module: horizon-client_wither
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The wither on the game side: building it (`WitherSkullBlock.checkSpawn`),
//! its boss bar, and its skulls hitting and exploding.
// use super::Game;
// use horizon_client::block_pattern::{BlockPattern, PatternMatch, WITHER_FULL};
// use horizon_client::{
    // rust: items::ItemStack,
    // rust: mobs::{Damage, DamageKind, Species, Who},
    // rust: projectiles::{Projectile, ProjectileKind},
}
// use horizon_core::{geometry::Direction, position::BlockPos};

    // rust: impl Game<'_> {
    /// `LivingEntity.createWitherRose`: a mob a wither killed leaves a wither
    /// rose where it stood (with mobGriefing, on air that can hold it), else
    /// drops one.
    // rust: pub(super) fn create_wither_rose(&mut self, m: &horizon_client::mobs::Mob) {
        // getKillCredit: the player who last hurt it, else the last mob (kept
        // for 100 ticks).
    // rust: let by_wither = m.ai.last_hurt_by_player <= 0
    // rust: && m.age as i32 - m.ai.last_hurt_by_time <= 100
    // rust: && matches!(m.ai.last_hurt_by, Some(Who::Mob(id))
    // rust: if self.mobs.iter().any(|o| o.id == id && o.alive() && o.species() == Species::Wither));
    // rust: if !by_wither {
    // rust: return;
}
    // rust: let pos = [
    // rust: m.position.x.floor() as i32,
    // rust: m.position.y.floor() as i32,
    // rust: m.position.z.floor() as i32,
    // rust: ];
    // rust: let registry = self.pack.assets.registry;
    // rust: let rose = registry.default_state("minecraft:wither_rose");
    // rust: if self.ui.rules.bool("mob_griefing")
    // rust: && let Some(rose) = rose
    // rust: && self
    // rust: .res
    // rust: .facts()
    // rust: .is_air(self.world.block(pos[0], pos[1], pos[2]))
    // rust: && self.with_level(|b, level, ticks| {
    // rust: b.can_survive(level, ticks, BlockPos::new(pos[0], pos[1], pos[2]), rose)
    // rust: })
    // rust: {
    // rust: let _ = self.level_set(pos, rose);
    // rust: return;
}
    // rust: self.spawn_item(
    // rust: ItemStack::new("minecraft:wither_rose", 1),
    // rust: [m.position.x, m.position.y, m.position.z],
    // rust: super::dispenser::new_item_motion(),
    // rust: 0,
    // rust: );
}
pub fn is_wither_skull(self: *Self, p: [i32; 3]) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let name = &*self
    // rust: .res
    // rust: .facts()
    // rust: .get(self.world.block(p[0], p[1], p[2]))
    // rust: .name;
    // rust: matches!(
    // rust: name,
    // rust: "minecraft:wither_skeleton_skull" | "minecraft:wither_skeleton_wall_skull"
    // rust: )
}
    /// `#minecraft:wither_summon_base_blocks` (soul sand and soul soil).
    // rust: pub(super) fn is_soul_base(&self, p: [i32; 3]) -> bool {
    // rust: let name = &*self
    // rust: .res
    // rust: .facts()
    // rust: .get(self.world.block(p[0], p[1], p[2]))
    // rust: .name;
    // rust: self.res
    // rust: .items()
    // rust: .block_tags
    // rust: .get("minecraft:wither_summon_base_blocks")
    // rust: .is_some_and(|t| t.contains(name))
}
    /// `pattern.find(level, pos)` for the wither patterns: '^' a wither
    /// skeleton skull, '#' a summon base block, '~' air.
    // rust: pub(super) fn find_wither_pattern(
    // rust: &self,
    // rust: pattern: BlockPattern,
    // rust: pos: [i32; 3],
    // rust: ) -> Option<PatternMatch> {
    // rust: pattern.find(pos, |key, p| match key {
    // rust: '^' => self.is_wither_skull(p),
    // rust: '#' => self.is_soul_base(p),
    // rust: _ => self.res.facts().is_air(self.world.block(p[0], p[1], p[2])),
    // rust: })
}
    /// `WitherSkullBlock.checkSpawn`, after a wither skeleton skull is
    /// placed: the T of three skulls on four soul sand or soul soil, built in
    /// any orientation, becomes a wither.
    // rust: pub(super) fn check_wither_spawn(&mut self, placed: [i32; 3]) -> horizon_client::Result<()> {
        // Nothing is built in Peaceful (`level.getDifficulty() != PEACEFUL`).
    // rust: if self.ui.difficulty == 0 || !self.is_wither_skull(placed) {
    // rust: return Ok(());
}
    // rust: let Some(found) = self.find_wither_pattern(WITHER_FULL, placed) else {
    // rust: return Ok(());
}
        // Clear the pattern, the wither appears on the middle of the bottom
        // row facing along the pattern's forwards axis, then neighbours update.
    // rust: let cells = found.front_cells();
    // rust: self.clear_pattern_blocks(&cells)?;
    // rust: let base = found.block(1, 2, 0);
    // rust: let at = [
    // rust: f64::from(base[0]) + 0.5,
    // rust: f64::from(base[1]) + 0.55,
    // rust: f64::from(base[2]) + 0.5,
    // rust: ];
    // rust: let yaw = if matches!(found.forwards, Direction::West | Direction::East) {
    // rust: 0.0
    // rust: } else {
    // rust: 90.0
}
    // rust: let id = self.create_triggered("minecraft:wither", at, yaw);
    // rust: if let Some(m) = id.and_then(|id| self.mobs.iter_mut().find(|m| m.id == id)) {
    // rust: m.persistent = true;
    // rust: horizon_client::mobs::wither::make_invulnerable(m);
}
        // SUMMONED_ENTITY for each player within 50 blocks of the wither's box.
    // rust: self.trigger_summoned(id, 50.0);
    // rust: self.update_pattern_blocks(&cells)
}
    /// `WitherSkull.onHitEntity` / `onHit`: 8 `wither_skull` damage from a
    /// skull with an owner (healing a wither owner 5 when it kills), else 5
    /// `magic`, withering on a living target that took it (10 seconds on
    /// Normal, 40 on Hard, none on Easy), then a power 1 blast.
    // rust: pub(super) fn wither_skull_hit(
    // rust: &mut self,
    // rust: p: &Projectile,
    // rust: who: Option<Who>,
    // rust: at: [f64; 3],
    // rust: ) -> horizon_client::Result<()> {
        // Projectile.getOwner: none once the owner is gone.
    // rust: let live_owner = match p.owner {
    // rust: Some(Who::Mob(id)) if self.mobs.iter().any(|m| m.id == id && !m.removed) => {
    // rust: Some(Who::Mob(id))
}
    // rust: Some(Who::Mob(_)) => None,
    // rust: other => other,
}
    // rust: let owner = match live_owner {
    // rust: Some(Who::Mob(id)) => Some(id),
    // rust: _ => None,
}
    // rust: let from = [p.previous.x, p.previous.y, p.previous.z];
    // rust: let skull = skull_source(live_owner, from);
    // rust: let (amount, kind) = (skull.amount, skull.kind);
    // rust: let wither_ticks = match self.difficulty_id() {
    // rust: 2 => 200,
    // rust: 3 => 800,
    // rust: _ => 0,
}
    // rust: match who {
    // rust: Some(Who::Player) => {
    // rust: if !self.creative {
                    // WitherSkull.onHitEntity's source: the wither launched
                    // it, and `magic` names no entity and no position.
    // rust: self.combat.projectile_owner = owner;
                    // EnchantmentHelper.doPostAttackEffects runs only on a
                    // target that lived.
    // rust: self.combat.post_attack_if_alive = true;
    // rust: if skull.from.is_none() {
    // rust: self.combat.projectile_direct = None;
}
    // rust: let hit = self.hurt_player_from(
    // rust: amount,
    // rust: skull.from,
    // rust: super::creatures::damage_type(kind, false),
    // rust: Some(owner),
    // rust: );
    // rust: if hit && wither_ticks > 0 {
    // rust: self.give_player_effect("minecraft:wither", wither_ticks, 1);
}
                    // A totem that fired saves the player inside hurtServer:
                    // still alive, so no heal.
    // rust: let killed = self.player.as_ref().is_some_and(|pl| {
    // rust: killed(hit, pl.health.dead_or_dying(), pl.health.totem_used)
    // rust: });
    // rust: if killed {
    // rust: self.heal_skull_owner(p, live_owner);
}
}
}
            // EnderDragonPart.hurtServer: EnderDragon.hurt routes it by the
            // part, a skull is no arrow a perched dragon shrugs off, and only
            // a player's skull takes health. A part is no LivingEntity
            // (no withering) and stays alive (no heal).
    // rust: Some(Who::Mob(id)) if id >= super::dragon::SPECIAL => {
    // rust: let by_player = live_owner == Some(Who::Player);
    // rust: self.hit_special(id, amount, by_player, kind, Some(&p.kind));
}
    // rust: Some(Who::Mob(id)) => {
    // rust: let owner_species = owner
    // rust: .and_then(|o| self.mobs.iter().find(|m| m.id == o))
    // rust: .map(|m| m.species());
    // rust: let source = Damage {
    // rust: kind,
    // rust: attacker: live_owner,
    // rust: from: skull.from,
    // rust: attacker_species: owner_species,
}
    // rust: let killed = match self.mobs.iter_mut().find(|m| m.id == id) {
                    // `WitherBoss.hurtServer`: nothing from a wither friend.
    // rust: Some(m)
    // rust: if owner_species.is_some_and(|o| {
    // rust: horizon_client::mobs::wither::shielded_from(m.species(), o)
    // rust: }) =>
    // rust: {
    // rust: false
}
    // rust: Some(m) => {
    // rust: let hit = m.damage(amount, source);
    // rust: if hit && m.alive() && m.species() != Species::Wither && wither_ticks > 0 {
    // rust: m.add_effect("minecraft:wither", wither_ticks, 1);
}
    // rust: hit && !m.alive()
}
    // rust: None => false,
}
    // rust: if killed {
    // rust: self.heal_skull_owner(p, live_owner);
}
}
    // rust: None => {}
}
    // rust: self.combat.explosion_owner = owner;
    // rust: self.combat.explosion_in_water = p.touching_water;
        // The blast's source names a player owner, for the dragon's kill credit.
    // rust: self.set_blast_by_player(live_owner == Some(Who::Player));
        // WitherSkull.getBlockExplosionResistance: only a blue skull's blast
        // caps a destroyable block's resistance at 0.8 (`isDangerous`).
    // rust: if matches!(
    // rust: p.kind,
    // rust: horizon_client::projectiles::ProjectileKind::WitherSkull { dangerous: true }
    // rust: ) {
    // rust: self.combat.blast_resistance_cap = Some(0.8);
}
    // rust: let result = self.with_hive_emptying_blast(|g| g.explode(at, 1.0));
    // rust: self.combat.blast_resistance_cap = None;
    // rust: self.set_blast_by_player(false);
    // rust: self.combat.explosion_owner = None;
    // rust: self.combat.explosion_in_water = false;
    // rust: result
}
    /// `livingOwner.heal(5.0F)` after the skull killed: `LivingEntity.heal`
    /// does nothing to an owner at no health.
pub fn heal_skull_owner(self: *Self, p: *Projectile, owner: ?Who) void {
}
    // rust: match owner {
    // rust: Some(Who::Mob(id)) => {
    // rust: if let Some(w) = self.mobs.iter_mut().find(|m| m.id == id && m.alive()) {
    // rust: w.heal(5.0);
}
}
            // The player (or the guest acting now) who owns the skull.
    // rust: Some(Who::Player) if p.guest.is_none() || p.guest == self.lan_acting => {
    // rust: self.apply_effect_action(horizon_client::effects::EffectAction::Heal(5.0));
}
    // rust: _ => {}
}
}
}
/// `!target.isAlive()` after a hit that landed: a totem that fired keeps the
/// player alive.
    // rust: pub(super) fn killed(hurt: bool, dead_or_dying: bool, totem_used: bool) -> bool {
    // rust: hurt && dead_or_dying && !totem_used
}
/// `WitherSkull.onHitEntity`'s damage source.
    // rust: pub(super) struct SkullSource {
    // rust: pub(super) amount: f32,
    // rust: pub(super) kind: DamageKind,
    /// The source's position: the skull's for `witherSkull(skull, owner)`,
    /// none for `magic()`, which has no entity.
    // rust: pub(super) from: Option<[f64; 3]>,
}
/// 8 `wither_skull` from a skull with a living owner, else 5 `magic`.
/// `skull` is where the skull is.
    // rust: pub(super) fn skull_source(owner: Option<Who>, skull: [f64; 3]) -> SkullSource {
    // rust: match owner {
    // rust: Some(_) => SkullSource {
    // rust: amount: 8.0,
    // rust: kind: DamageKind::WitherSkull,
    // rust: from: Some(skull),
    // rust: },
    // rust: None => SkullSource {
    // rust: amount: 5.0,
    // rust: kind: DamageKind::Magic,
    // rust: from: None,
    // rust: },
}
}
/// Wither skulls drawn as the skull model, blue when dangerous.
    // rust: pub(super) fn skull_kind(p: &Projectile) -> Option<bool> {
    // rust: match p.kind {
    // rust: ProjectileKind::WitherSkull { dangerous } => Some(dangerous),
    // rust: _ => None,
}
}
    // rust: mod tests {
//     use super::*;

pub fn an_unowned_skull_hurts_as_magic_from_nowhere() void {
}
        // DamageSources.magic(): no entity and no position, so nothing to
        // blame or push away from.
    // rust: let at = [1.0, 64.0, 2.0];
    // rust: let unowned = skull_source(None, at);
    // rust: assert_eq!((unowned.amount, unowned.kind), (5.0, DamageKind::Magic));
    // rust: assert_eq!(unowned.from, None);
        // witherSkull(skull, owner): from where the skull is.
    // rust: let owned = skull_source(Some(Who::Mob(3)), at);
    // rust: assert_eq!((owned.amount, owned.kind), (8.0, DamageKind::WitherSkull));
    // rust: assert_eq!(owned.from, Some(at));
    // rust: assert_eq!(skull_source(Some(Who::Player), at), owned);
}

pub fn a_totem_that_fires_is_no_kill() void {
}
    // rust: assert!(killed(true, true, false));
        // The totem restores health next tick: alive inside hurtServer.
    // rust: assert!(!killed(true, true, true));
    // rust: assert!(!killed(true, false, false));
    // rust: assert!(!killed(false, true, false));
}
}
