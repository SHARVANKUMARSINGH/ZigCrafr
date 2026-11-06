//! Transpiled from Horizon Rust crate
package horizon_client_combat

import "core:fmt"
import "core:mem"
import "core:math"

// The player's `CombatTracker`: the damage taken lately, who dealt it and
// where the player fell from, turned into the vanilla death message.
// use super::{Game, commands::Target};
// use horizon_client::{
    // rust: health::HealthEvent,
    // rust: mobs::{Mob, Species},
    // rust: motion::MotionEvent,
    // rust: particles::{ParticleOptions, ParticleType},
    // rust: text::Text,
}
// use horizon_core::random::RandomSource;

// `EntityEvent.DROWN_PARTICLES`: broadcast with the drowning damage.
    // rust: pub(super) const DROWN_EVENT: i8 = 67;

Entry :: struct {
    damage_type: string,
    damage: f32,
    fall_location: Maybe(^'static str),
    fall_distance: f32,
    // The causing entity: its id (for comparisons) and display name.
    attacker: Option<(u32,
    // The causing player's main-hand stack when it has a custom name, as
    // held when the hit landed (a mob's is read when the message is built).
    item: Maybe(Text),
    // The direct entity's display name when no entity caused the damage
    // (`DamageSource.directEntity`: a potion with no thrower, a cloud).
    direct: Maybe(Text),
}
// What is stuck in a player's body: `LivingEntity.DATA_ARROW_COUNT_ID` and
// `DATA_STINGER_COUNT_ID` with the timers that pull them out
// (`removeArrowTime`, `removeStingerTime`). Kept with the combat record,
// which is swapped with the body it belongs to.
    // rust: pub(super) struct Stuck {
    // rust: pub(super) arrows: i32,
    // rust: pub(super) stingers: i32,
    // rust: remove_arrow_time: i32,
    // rust: remove_stinger_time: i32,
}
    // rust: impl Stuck {
    // `AbstractArrow.onHitEntity`: a hit that hurt, from an arrow that
    // does not pierce, leaves it stuck.
    // rust: pub(super) fn add_arrow(&mut self) {
    // rust: self.arrows += 1;
}
    // `Bee.doHurtTarget`: a sting that hurt.
    // rust: pub(super) fn add_stinger(&mut self) {
    // rust: self.stingers += 1;
}
    // The server's part of `LivingEntity.tick`: one in a count's worth of
    // `20 * (30 - count)` ticks falls out. Whether the counts changed.
    // rust: pub(super) fn tick(&mut self) -> bool {
    // rust: let (arrows, stingers) = (self.arrows, self.stingers);
    // rust: Self::decay(&mut self.arrows, &mut self.remove_arrow_time);
    // rust: Self::decay(&mut self.stingers, &mut self.remove_stinger_time);
    // rust: (arrows, stingers) != (self.arrows, self.stingers)
}
decay :: proc(count: ^i32, remove_time: ^i32) {
}
    // rust: if *count > 0 {
    // rust: if *remove_time <= 0 {
    // rust: *remove_time = 20 * (30 - *count);
}
    // rust: *remove_time -= 1;
    // rust: if *remove_time <= 0 {
    // rust: *count -= 1;
}
}
}
}
    // rust: pub(super) struct CombatTracker {
    // The arrows and bee stingers stuck in the body.
    // rust: pub(super) stuck: Stuck,
    // rust: entries: Vec<Entry>,
    // rust: last_damage: i64,
    // rust: in_combat: bool,
    // Attackers of damage dealt this tick, claimed by the matching
    // `RecordedDamage` event.
    // rust: pending: Vec<(String, (u32, Text), Option<Text>)>,
    // `pending` for a direct entity with no causing entity: only its name.
    // rust: pending_direct: Vec<(String, Text)>,
    // The lengths of `pending` and `pending_direct` before the first
    // attacker noted for the hurt being dealt now (`forget_noted`).
    // rust: noted_since: Option<(usize, usize)>,
    // `LivingEntity.lastHurtByMob` and its timestamp (the kill credit).
    // rust: last_hurt_by: Option<((u32, Text), i64)>,
    // The mob the player last hurt (`getLastHurtMob`) and when.
    // rust: pub(super) last_hurt_mob: Option<(u32, i64)>,
    // The mob whose projectile is hitting the player now.
    // rust: pub(super) projectile_owner: Option<u32>,
    // The display name of the projectile hitting the player now: the
    // `DamageSource.directEntity` the death message names when no owner is
    // known (`AbstractArrow.onHitEntity` makes an ownerless arrow its own
    // cause).
    // rust: pub(super) projectile_direct: Option<Text>,
    // The player whose primed TNT is going off now (`PrimedTnt.getOwner`):
    // its entity id and display name, the blast's causing entity.
    // rust: pub(super) blast_owner: Option<(u32, Text)>,
    // The guest behind `blast_owner`, when that player is a LAN guest; the
    // host's own blast leaves it None.
    // rust: pub(super) blast_guest: Option<u32>,
    // rust: pub(super) projectile_attacker: Option<(u32, Text)>,
    // The projectile hitting the player now is another player's that
    // `ServerPlayer.canHarmPlayer` refuses (the `pvp` rule, an ally).
    // rust: pub(super) refuse_player_hit: bool,
    // The hit on the player now runs its post-attack effects (thorns) only
    // if the player lives through it (`WitherSkull.onHitEntity`).
    // rust: pub(super) post_attack_if_alive: bool,
    // A firework rocket's burst is hurting the player now: the rocket is
    // the direct entity (`rocket_hurt_player`).
    // rust: pub(super) rocket_hit: bool,
    // The player whose melee hit is landing on the player now: where they
    // stand and the seconds their weapon disables a shield for
    // (`getSecondsToDisableBlocking`).
    // rust: pub(super) player_attacker: Option<([f64; 3], f32)>,
    // While set, a sweep attack's reach to the other players is kept here
    // instead of landing, for the caller that holds the LAN host.
    // rust: pub(super) sweeps: Option<Vec<super::lan_pvp::Sweep>>,
    // The mob exploding now (`ServerExplosion.source`): its team's friendly
    // fire decides whom the blast may hurt.
    // rust: pub(super) explosion_source: Option<u32>,
    // The exploding mob as predicates see it (`ServerExplosion.source`,
    // `ServerPlayer.currentExplosionCause`), for a mob already out of the list.
    // rust: pub(super) explosion_cause: Option<horizon_client::advancements::EntityView>,
    // The exploding mob named itself (`MobEvent::ExplosionSource`), so the
    // blast leaves it out (`getEntities(source, box)`). A source guessed
    // from the mobs near the centre is still hurt: it may be a bystander.
    // rust: pub(super) explosion_source_named: bool,
    // The blast's direct source is in water (`Explosion.getDirectSourceEntity`
    // `.isInWater`): paintings, item frames and cushions ignore it
    // (`BlockAttachedEntity.ignoreExplosion`).
    // rust: pub(super) explosion_in_water: bool,
    // The blast now going off comes from a primed TNT, creeper, wither
    // skull, wither or TNT minecart, the sources that empty a hive they
    // destroy (`BeehiveBlock.getDrops`).
    // rust: pub(super) hive_emptying_blast: bool,
    // The blast now going off comes from a primed TNT minecart, which
    // neither resists on nor breaks a rail or the block under one
    // (`MinecartTNT.getBlockExplosionResistance`, `shouldBlockExplode`).
    // rust: pub(super) rail_proof_blast: bool,
    // The mob that owns the projectile exploding now (`getIndirectSourceEntity`):
    // the mobs the blast hurts record it as their attacker.
    // rust: pub(super) explosion_owner: Option<u32>,
    // `WitherSkull.getBlockExplosionResistance`: a dangerous skull's blast
    // caps every destroyable block's resistance at this value.
    // rust: pub(super) blast_resistance_cap: Option<f32>,
    // Charged creepers whose blast just went off and that have not dropped
    // a head yet (`Creeper.droppedSkulls`): they are gone from the mob list,
    // but the mobs they killed still ask for their loot.
    // rust: pub(super) charged_exploders: Vec<u32>,
    // The mobs whose blast went off this tick and that left the mob list
    // (`MobEvent::ExplosionSource`): their names, for the death messages of
    // the mobs the blast killed.
    // rust: pub(super) exploded: Vec<(u32, Text)>,
    // The player's fall distance before this tick's movement (as of the
    // end of the last one).
    // rust: fall_before: f64,
}
    // rust: impl CombatTracker {
    // The last blow taken: its damage type and the causing entity's id (0
    // for none), for `LivingDeathEvent`.
    // rust: pub(super) fn last_blow(&self) -> Option<(&str, u32)> {
    // rust: let e = self.entries.last()?;
    // rust: Some((&e.damage_type, e.attacker.as_ref().map_or(0, |a| a.0)))
}
mark :: proc(self: ^Self) {
}
    // rust: let marks = (self.pending.len(), self.pending_direct.len());
    // rust: self.noted_since.get_or_insert(marks);
}
    // `CombatTracker.getKiller`'s credited attacker: the entity that last
    // hurt the body, within a hundred ticks of the hurt.
    // rust: pub(super) fn kill_credit(&self, now: i64) -> Option<u32> {
    // rust: let ((id, _), at) = self.last_hurt_by.as_ref()?;
    // rust: (now - at <= 100).then_some(*id)
}
    // `LivingEntity.getLastDamageSource` for an advancement's
    // `killing_blow`: the newest combat entry's type and causing entity.
    // rust: pub(super) fn killing_blow(&self) -> Option<(String, Option<u32>)> {
    // rust: self.entries.last().map(|e| {
    // rust: (
    // rust: e.damage_type.clone(),
    // rust: e.attacker.as_ref().map(|(id, _)| *id),
    // rust: )
    // rust: })
}
    // The player's hurt is over: when a native mod canceled it, the
    // attackers noted for it go, as no combat entry takes them and the next
    // hit of the same damage type must not be credited to them.
    // rust: pub(super) fn forget_noted(&mut self, canceled: bool) {
    // rust: if let Some((attackers, directs)) = self.noted_since.take()
    // rust: && canceled
    // rust: {
    // rust: self.pending.truncate(attackers);
    // rust: self.pending_direct.truncate(directs);
}
}
}
    // rust: impl Game<'_> {
    // `LivingEntity.makeDrownParticles`: eight bubbles around the entity,
    // moving with it.
    // rust: pub(super) fn drown_particles(&mut self, at: [f64; 3], velocity: [f64; 3]) {
    // rust: let bubble = ParticleOptions::simple(ParticleType::Bubble);
    // rust: for _ in 0..8 {
    // rust: let mut triangle = || {
    // rust: let r = self.particles.random();
    // rust: r.next_double() - r.next_double()
}
    // rust: let p = [at[0] + triangle(), at[1] + triangle(), at[2] + triangle()];
    // rust: self.particles.add(&bubble, p, velocity);
}
}
    // Entity event 67 from a server, for this client's own player or an
    // entity it draws.
    // rust: pub(super) fn remote_drown(&mut self, id: i32) {
    // rust: let own = self.remote.as_ref().is_some_and(|r| r.entity_id == id);
    // rust: let body = if own {
    // rust: self.player.as_ref().map(|p| {
    // rust: let (at, v) = (p.position, p.velocity);
    // rust: ([at.x, at.y, at.z], [v.x, v.y, v.z])
    // rust: })
    // rust: } else {
    // rust: self.mobs.iter().find(|m| m.id == id as u32).map(|m| {
    // rust: let (at, v) = (m.position, m.velocity);
    // rust: ([at.x, at.y, at.z], [v.x, v.y, v.z])
    // rust: })
}
    // rust: if let Some((at, v)) = body {
    // rust: self.drown_particles(at, v);
}
}
    // The display name of a mob: its custom name or its type's name.
    // rust: pub(super) fn mob_display_name(&self, id: u32) -> Option<Text> {
    // rust: let m = self.mobs.iter().find(|m| m.id == id)?;
    // rust: Some(match &m.custom_name {
    // rust: Some(name) => Text::literal(name.clone()),
    // rust: None => Text::translate(&format!("entity.{}", m.kind.id.replace(':', ".")), &[]),
    // rust: })
}
    // `getLastHurtByMob`: the last mob to hurt the player, for 100 ticks.
    // rust: pub(super) fn player_hurt_by(&self) -> Option<(horizon_client::mobs::Who, i64)> {
    // rust: let ((id, _), at) = self.combat.last_hurt_by.as_ref()?;
    // rust: (self.world.game_time - at <= 100).then_some((horizon_client::mobs::Who::Mob(*id), *at))
}
    // Remember who deals the next `damage_type` damage to the player.
    // rust: pub(super) fn note_attacker(&mut self, damage_type: &str, mob: u32) {
    // rust: if let Some(name) = self.mob_display_name(mob) {
    // rust: self.note_named_attacker(damage_type, mob, name);
}
}
    // `note_attacker` for an entity that is not one of `self.mobs` (the
    // ender dragon).
    // rust: pub(super) fn note_named_attacker(&mut self, damage_type: &str, id: u32, name: Text) {
    // rust: self.note_player_attacker(damage_type, id, name, None);
}
    // `note_named_attacker` for a player, with their custom-named main-hand
    // item for the death message's `.item` form.
    // rust: pub(super) fn note_player_attacker(
    // rust: &mut self,
    // rust: damage_type: &str,
    // rust: id: u32,
    // rust: name: Text,
    // rust: item: Option<Text>,
    // rust: ) {
    // rust: self.combat.mark();
    // rust: self.combat
    // rust: .pending
    // rust: .push((damage_type.to_owned(), (id, name), item));
}
    // The `DamageSource.directEntity` of the next `damage_type` damage when
    // nothing caused it (a splash potion nobody threw): the death message
    // names it instead (`getLocalizedDeathMessage`). It is no kill credit.
    // rust: pub(super) fn note_direct_entity(&mut self, damage_type: &str, name: Text) {
    // rust: self.combat.mark();
    // rust: self.combat
    // rust: .pending_direct
    // rust: .push((damage_type.to_owned(), name));
}
    // `CombatTracker.recordDamage` for the motion events of this tick.
    // rust: pub(super) fn record_combat(&mut self, events: &[MotionEvent]) {
    // rust: self.recheck_combat();
    // rust: for e in events {
    // rust: let (name, amount) = match e {
                // LivingEntity.getDamageAfterMagicAbsorb (Resistance) and
                // Player.actuallyHurt (absorption hearts) and
                // LivingEntity.hurtServer (the shield, only for an accepted
                // hit), in tenths.
    // rust: MotionEvent::Health(HealthEvent::Statistic { name, amount }) => {
    // rust: match *name {
    // rust: "resisted" => self.award_custom_stat("damage_resisted", *amount),
    // rust: "absorbed" => self.award_custom_stat("damage_absorbed", *amount),
    // rust: "blocked" => self.award_custom_stat("damage_blocked_by_shield", *amount),
    // rust: _ => {}
}
    // rust: continue;
}
    // rust: MotionEvent::Health(HealthEvent::RecordedDamage { source, amount }) => {
    // rust: let Some(d) = self.health_resources.damage.definition(*source) else {
    // rust: continue;
}
    // rust: (d.name.clone(), *amount)
}
    // rust: _ => continue,
}
    // rust: let (attacker, item) = self
    // rust: .combat
    // rust: .pending
    // rust: .iter()
    // rust: .position(|(t, _, _)| *t == name)
    // rust: .map(|i| {
    // rust: let (_, attacker, item) = self.combat.pending.remove(i);
    // rust: (Some(attacker), item)
    // rust: })
    // rust: .unwrap_or_default();
    // rust: let direct = match attacker {
    // rust: Some(_) => None,
    // rust: None => self
    // rust: .combat
    // rust: .pending_direct
    // rust: .iter()
    // rust: .position(|(t, _)| *t == name)
    // rust: .map(|i| self.combat.pending_direct.remove(i).1),
}
    // rust: let (fall_location, fall_distance) = self.fall_location();
    // rust: let now = self.world.game_time;
    // rust: if let Some(a) = &attacker {
    // rust: self.combat.last_hurt_by = Some((a.clone(), now));
    // rust: if !self.combat.in_combat {
    // rust: self.combat.in_combat = true;
}
}
            // Player.actuallyHurt: damage_taken in tenths.
    // rust: self.award_custom_stat("damage_taken", (amount * 10.0).round() as i32);
    // rust: self.combat.entries.push(Entry {
    // rust: damage_type: name,
    // rust: damage: amount,
    // rust: fall_location,
    // rust: fall_distance,
    // rust: attacker,
    // rust: item,
    // rust: direct,
    // rust: });
    // rust: self.combat.last_damage = now;
            // InfestedMobEffect.onMobHurt.
    // rust: if self.potions.effects.get("infested").is_some() {
    // rust: self.player_infested();
}
}
    // rust: self.combat.pending.clear();
    // rust: self.combat.pending_direct.clear();
    // rust: self.combat.noted_since = None;
    // rust: self.combat.projectile_direct = None;
    // rust: self.combat.projectile_attacker = None;
    // rust: self.combat.fall_before = self.player.as_ref().map_or(0.0, |p| p.fall_distance);
}
    // `FallLocation.getCurrentFallLocation` and the fall distance so far.
fall_location :: proc(self: ^Self) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let Some(p) = self.player.as_ref() else {
    // rust: return (None, 0.0);
}
    // rust: let distance = p.fall_distance.max(self.combat.fall_before) as f32;
    // rust: let location = if let Some(c) = p.last_climbable {
    // rust: let name = self
    // rust: .res
    // rust: .facts()
    // rust: .get(self.world.block(c.x, c.y, c.z))
    // rust: .name
    // rust: .clone();
    // rust: Some(match &*name {
    // rust: "minecraft:ladder" => "ladder",
    // rust: "minecraft:vine" => "vines",
    // rust: "minecraft:weeping_vines" | "minecraft:weeping_vines_plant" => "weeping_vines",
    // rust: "minecraft:twisting_vines" | "minecraft:twisting_vines_plant" => "twisting_vines",
    // rust: "minecraft:scaffolding" => "scaffolding",
    // rust: _ => "other_climbable",
    // rust: })
    // rust: } else {
    // rust: let f = self.res.facts().get(self.world.block(
    // rust: p.position.x.floor() as i32,
    // rust: (p.position.y + 0.1).floor() as i32,
    // rust: p.position.z.floor() as i32,
    // rust: ));
    // rust: (f.fluid == horizon_client::blocks::Fluid::Water || f.waterlogged).then_some("water")
}
    // rust: (location, distance)
}
    // `CombatTracker.recheckStatus`: forget old fights.
recheck_combat :: proc(self: ^Self) {
}
    // rust: let reset = if self.combat.in_combat { 300 } else { 100 };
    // rust: if !self.combat.entries.is_empty() && self.world.game_time - self.combat.last_damage > reset
    // rust: {
    // rust: self.combat.entries.clear();
    // rust: self.combat.in_combat = false;
}
}
damage_in_tag :: proc(self: ^Self, name: string, tag: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let damage = &self.health_resources.damage;
    // rust: damage.id(name).is_some_and(|id| {
    // rust: damage.in_tag(id, tag) || damage.in_tag(id, &format!("minecraft:{tag}"))
    // rust: })
}
    // `CombatTracker.getMostSignificantFall`.
most_significant_fall :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let (mut result, mut alternative) = (None, None);
    // rust: let (mut best_fall, mut alt_damage) = (0.0f32, 0.0f32);
    // rust: for (i, e) in self.combat.entries.iter().enumerate() {
    // rust: let fake = self.damage_in_tag(&e.damage_type, "always_most_significant_fall");
    // rust: let distance = if fake { f32::MAX } else { e.fall_distance };
    // rust: if (self.damage_in_tag(&e.damage_type, "is_fall") || fake)
    // rust: && distance > 0.0
    // rust: && (result.is_none() || distance > best_fall)
    // rust: {
    // rust: result = Some(i.saturating_sub(1));
    // rust: best_fall = distance;
}
    // rust: if e.fall_location.is_some() && (alternative.is_none() || e.damage > alt_damage) {
    // rust: alternative = Some(i);
    // rust: alt_damage = e.damage;
}
}
    // rust: if best_fall > 5.0 && result.is_some() {
    // rust: result
    // rust: } else if alt_damage > 5.0 {
    // rust: alternative
    // rust: } else {
    // rust: None
}
}
    // The display component of a custom-named held stack.
mob_main_hand_name :: proc(self: ^Self, id: u32) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let m = self.mobs.iter().find(|m| m.id == id)?;
    // rust: let mut stack = m.extra.main_hand_stack()?.clone();
    // rust: if !has_custom_name(&stack) {
    // rust: return None;
}
    // rust: if let Some(g) = horizon_client::mobs::gear::gear(m) {
    // rust: stack.data_mut().enchantments = g.slots[horizon_client::mobs::gear::MAIN].clone();
}
    // rust: Some(self.stack_display_name(&stack))
}
    // `getMainHandItem().getDisplayName()` of the player in place, when the
    // stack has a custom name.
    // rust: pub(super) fn main_hand_custom_name(&self) -> Option<Text> {
    // rust: let stack = self.inventory.get(self.selected)?.as_ref()?;
    // rust: has_custom_name(stack).then(|| self.stack_display_name(stack))
}
    // `main_hand_custom_name` of a player who is not in place: the guest
    // `conn` between turns, or none for the host while a guest acts (their
    // hotbar slot is kept by the swap).
player_main_hand_custom_name :: proc(self: ^Self, player: Maybe(u32)) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if player == self.lan_acting {
    // rust: return self.main_hand_custom_name();
}
    // rust: let g = self.lan.as_ref()?.hub.guest(player?)?;
    // rust: let stack = g.inventory.get(g.selected)?.as_ref()?;
    // rust: has_custom_name(stack).then(|| self.stack_display_name(stack))
}
    // The killer's item for `getLocalizedDeathMessage` and
    // `getMessageForAssistedFall`: a player's as recorded, a mob's now.
entry_item :: proc(self: ^Self, e: ^Entry) -> O {
    // Ported from Horizon
    return {}
}
    // rust: e.item
    // rust: .clone()
    // rust: .or_else(|| self.mob_main_hand_name(e.attacker.as_ref()?.0))
}
    // `CombatTracker.getDeathMessage` for a player whose display name is
    // `me`: a server's guest is not `PLAYER_NAME`.
    // rust: pub(super) fn combat_death_message_for(&mut self, me: Text) -> Text {
    // rust: self.recheck_combat();
    // rust: let entries = std::mem::take(&mut self.combat.entries);
    // rust: self.combat.in_combat = false;
    // rust: let Some(killing) = entries.last() else {
    // rust: return Text::translate("death.attack.generic", &[me]);
}
    // rust: let def = self
    // rust: .health_resources
    // rust: .damage
    // rust: .id(&killing.damage_type)
    // rust: .and_then(|id| self.health_resources.damage.definition(id))
    // rust: .map(|d| (d.message_id.clone(), d.death_message_type.clone()))
    // rust: .unwrap_or_else(|| ("generic".into(), "default".into()));
    // rust: self.combat.entries = entries;
    // rust: let knock = self.most_significant_fall();
    // rust: let entries = std::mem::take(&mut self.combat.entries);
    // rust: let killing = entries.last().expect("checked above");
    // rust: let killer = killing.attacker.clone();
    // rust: let direct = killing.direct.clone();
    // rust: if def.1 == "fall_variants"
    // rust: && let Some(knock) = knock.and_then(|i| entries.get(i))
    // rust: {
    // rust: let fall = self.damage_in_tag(&knock.damage_type, "is_fall")
    // rust: || self.damage_in_tag(&knock.damage_type, "always_most_significant_fall");
    // rust: if fall {
    // rust: let at = knock.fall_location.unwrap_or("generic");
    // rust: return Text::translate(&format!("death.fell.accident.{at}"), &[me]);
}
            // CombatTracker.getMessageForAssistedFall: the attacker's item
            // with a custom name gets the `.item` message.
    // rust: let (key, args) = match (&knock.attacker, &killer) {
    // rust: (Some(a), k) if k.as_ref().is_none_or(|k| k.0 != a.0) => {
    // rust: horizon_client::scoreboard::death_message_args(
    // rust: "death.fell.assist",
    // rust: &me,
    // rust: &a.1,
    // rust: self.entry_item(knock).as_ref(),
    // rust: )
}
    // rust: (_, Some(k)) => horizon_client::scoreboard::death_message_args(
    // rust: "death.fell.finish",
    // rust: &me,
    // rust: &k.1,
    // rust: self.entry_item(killing).as_ref(),
    // rust: ),
    // rust: _ => ("death.fell.killer".into(), vec![me]),
}
    // rust: return Text::translate(&key, &args);
}
    // rust: let key = format!("death.attack.{}", def.0);
    // rust: if def.1 == "intentional_game_design" {
    // rust: let link = Text::literal("[")
    // rust: .append(Text::translate(&format!("{key}.link"), &[]))
    // rust: .append(Text::literal("]"));
    // rust: return Text::translate(&format!("{key}.message"), &[me, link]);
}
        // `getLocalizedDeathMessage`: the causing entity's name, or the
        // direct entity's when nothing caused the damage.
    // rust: if let Some((_, name)) = killer {
            // DamageSource.getLocalizedDeathMessage: the cause's item with a
            // custom name gets the `<id>.item` message.
    // rust: let (key, args) = horizon_client::scoreboard::death_message_args(
    // rust: &key,
    // rust: &me,
    // rust: &name,
    // rust: self.entry_item(killing).as_ref(),
    // rust: );
    // rust: return Text::translate(&key, &args);
}
    // rust: if let Some(name) = direct {
    // rust: return Text::translate(&key, &[me, name]);
}
        // getKillCredit: the last mob that hurt the player in the past 100 ticks.
    // rust: if let Some(((_, name), at)) = &self.combat.last_hurt_by
    // rust: && self.world.game_time - at <= 100
    // rust: {
    // rust: return Text::translate(&format!("{key}.player"), &[me, name.clone()]);
}
        // No entity at all: the one-argument message, as vanilla sends it (a
        // template that names a killer then shows as written).
    // rust: Text::translate(&key, &[me])
}
    // `TamableAnimal.die`: with `showDeathMessages`, a tame wolf, cat,
    // parrot or nautilus's owner, when online in any dimension
    // (`EntityReference.getEntity` looks through every level), is sent how it
    // died. `killer` is the player who last hurt it (`None` inside for the
    // host), from `last_hurt_by_player`.
    // rust: pub(super) fn tell_owner_pet_died(&mut self, m: &Mob, killer: Option<Option<u32>>) {
    // rust: let tamable = matches!(
    // rust: m.species(),
    // rust: Species::Wolf
    // rust: | Species::Cat
    // rust: | Species::Parrot
    // rust: | Species::Nautilus
    // rust: | Species::ZombieNautilus
    // rust: );
    // rust: let Some(owner) = m.extra.owner.filter(|_| tamable && m.extra.tame) else {
    // rust: return;
}
    // rust: if !self.ui.rules.bool("show_death_messages") {
    // rust: return;
}
    // rust: let host = self.player.is_some()
    // rust: && self.options.dedicated.is_none()
    // rust: && horizon_client::mobs::tame::owned_by(
    // rust: Some(owner),
    // rust: self.level.player_uuid.unwrap_or_default(),
    // rust: );
    // rust: let uuid = horizon_client::lan::playerdata::ints_uuid(owner);
    // rust: let guest = !host
    // rust: && self
    // rust: .lan
    // rust: .as_ref()
    // rust: .is_some_and(|l| l.hub.guests.iter().any(|g| g.placed && g.uuid == uuid));
    // rust: if !host && !guest {
    // rust: return;
}
    // rust: let message = self.mob_death_message(m, killer);
    // rust: if host {
    // rust: self.system_message(message);
    // rust: } else if let Some(lan) = &self.lan {
    // rust: let content = horizon_client::lan::data::component_nbt(&message.component());
    // rust: lan.hub.system_message_to_player(uuid, content);
}
}
    // `CombatTracker.getDeathMessage` for a mob, from the hits it recorded
    // (`Mob::combat`), told the way the player's own tracker tells them.
    // rust: pub(super) fn mob_death_message(&mut self, m: &Mob, killer: Option<Option<u32>>) -> Text {
//         use horizon_client::mobs::{DamageKind, Who};
    // rust: let me = mob_name(m);
        // The player behind a `Who::Player` hit: the last one to hurt it, or
        // the one in place (a server with nobody acting has none).
    // rust: let player = match killer {
    // rust: Some(Some(conn)) => Some((u32::MAX - 1 - conn, self.target_name(Target::Guest(conn)))),
    // rust: Some(None) => Some((u32::MAX, self.target_name(Target::Player))),
    // rust: None if self.player.is_some() || self.lan_acting.is_some() => {
    // rust: Some((u32::MAX, self.target_name(Target::Player)))
}
    // rust: None => None,
}
        // DamageSource.getLocalizedDeathMessage reads that player's main hand
        // as the message is built.
    // rust: let player_item = match killer {
    // rust: Some(conn) => self.player_main_hand_custom_name(conn),
    // rust: None => player.as_ref().and_then(|_| self.main_hand_custom_name()),
}
        // The cause's display name: a mob that is gone (a creeper that blew
        // up) is still named by its blast.
    // rust: let name = |g: &Self, who: Who| match who {
    // rust: Who::Player => player.clone(),
    // rust: Who::Mob(id) => g
    // rust: .mob_display_name(id)
    // rust: .or_else(|| {
    // rust: g.combat
    // rust: .exploded
    // rust: .iter()
    // rust: .find(|(e, _)| *e == id)
    // rust: .map(|(_, n)| n.clone())
    // rust: })
    // rust: .map(|n| (id, n)),
}
    // rust: let entries = m
    // rust: .combat
    // rust: .entries
    // rust: .iter()
    // rust: .map(|e| {
    // rust: let attacker = e.source.attacker.and_then(|w| name(self, w));
    // rust: let item = (e.source.attacker == Some(Who::Player))
    // rust: .then(|| player_item.clone())
    // rust: .flatten();
                // AbstractArrow.onHitEntity: an arrow nobody shot is its own
                // cause; a rocket nobody fired still names itself.
    // rust: let direct = match e.source.kind {
    // rust: _ if attacker.is_some() => None,
    // rust: DamageKind::Arrow => Some(Text::translate("entity.minecraft.arrow", &[])),
    // rust: DamageKind::Fireworks => {
    // rust: Some(Text::translate("entity.minecraft.firework_rocket", &[]))
}
    // rust: _ => None,
}
    // rust: Entry {
    // rust: damage_type: super::creatures::source_damage_type(e.source).to_owned(),
    // rust: damage: e.damage,
    // rust: fall_location: e.in_water.then_some("water"),
    // rust: fall_distance: e.fall_distance,
    // rust: attacker,
    // rust: item,
    // rust: direct,
}
    // rust: })
    // rust: .collect();
        // LivingEntity.getKillCredit: the player who hurt it lately, else the
        // last mob to hurt it within 100 ticks.
    // rust: let credit = if m.ai.last_hurt_by_player > 0 && player.is_some() {
    // rust: player.clone()
    // rust: } else {
    // rust: m.ai.last_hurt_by
    // rust: .filter(|_| m.age as i32 - m.ai.last_hurt_by_time <= 100)
    // rust: .and_then(|w| name(self, w))
}
    // rust: let now = self.world.game_time;
    // rust: let mut tracker = CombatTracker {
    // rust: entries,
    // rust: last_damage: now,
    // rust: in_combat: m.combat.in_combat,
    // rust: last_hurt_by: credit.map(|c| (c, now)),
    // rust: ..CombatTracker::default()
}
    // rust: std::mem::swap(&mut self.combat, &mut tracker);
    // rust: let text = self.combat_death_message_for(me);
    // rust: std::mem::swap(&mut self.combat, &mut tracker);
    // rust: text
}
}

// `!stack.isEmpty() && stack.has(DataComponents.CUSTOM_NAME)`: the held
// item that turns a death message into its `.item` form.
has_custom_name :: proc(stack: ^horizon_client::items::ItemStack) -> b {
    // Ported from Horizon
    return {}
}
    // rust: &*stack.item != "minecraft:air"
    // rust: && stack.count > 0
    // rust: && stack.data().is_some_and(|d| d.custom_name.is_some())
}

// `Entity.getDisplayName` of a mob: its custom name or its type's name.
mob_name :: proc(m: ^Mob) -> T {
    // Ported from Horizon
    return {}
}
    // rust: match (&m.custom_name_text, &m.custom_name) {
    // rust: (Some(text), _) => text.clone(),
    // rust: (None, Some(name)) => Text::literal(name.clone()),
    // rust: (None, None) => Text::translate(&format!("entity.{}", m.kind.id.replace(':', ".")), &[]),
}
}

    // rust: mod held_item_tests {
//     use super::has_custom_name;
//     use horizon_client::items::ItemStack;
//     use horizon_world::nbt::Tag;

    // `DamageSource.getLocalizedDeathMessage`: only a non-empty stack with
    // a `custom_name` component names the item.
only_a_renamed_stack_names_the_item :: proc() {
}
    // rust: let mut sword = ItemStack::new("minecraft:diamond_sword", 1);
    // rust: assert!(!has_custom_name(&sword));
        // Other components (here a repair cost) are not a custom name.
    // rust: sword.data_mut().repair_cost = 1;
    // rust: assert!(!has_custom_name(&sword));
    // rust: sword.data_mut().custom_name = Some(Tag::String("Peacemaker".into()));
    // rust: assert!(has_custom_name(&sword));
        // An empty stack never does, even with the component.
    // rust: let mut gone = sword.clone();
    // rust: gone.count = 0;
    // rust: assert!(!has_custom_name(&gone));
}
}
    // rust: mod noted_tests {
//     use super::CombatTracker;
//     use horizon_client::text::Text;

    // A canceled hit forgets what was noted for it, also before its hurt
    // started (a PvP blow, `/damage`), and nothing a landed hit noted.
a_canceled_hit_forgets_only_its_own_attackers :: proc() {
}
    // rust: let mut c = CombatTracker::default();
    // rust: let arrow = |c: &mut CombatTracker, id| {
    // rust: c.mark();
    // rust: c.pending.push((
    // rust: "minecraft:arrow".into(),
    // rust: (id, Text::literal("skeleton")),
    // rust: None,
    // rust: ));
}
    // rust: arrow(&mut c, 1);
    // rust: c.forget_noted(false);
    // rust: arrow(&mut c, 2);
    // rust: c.mark();
    // rust: c.pending_direct
    // rust: .push(("minecraft:arrow".into(), Text::literal("arrow")));
    // rust: c.forget_noted(true);
    // rust: assert_eq!(c.pending.iter().map(|p| p.1.0).collect::<Vec<_>>(), [1]);
    // rust: assert!(c.pending_direct.is_empty());
        // A hit noted and landed, then one noted and canceled: the landed
        // one keeps its attacker.
    // rust: c.forget_noted(false);
    // rust: arrow(&mut c, 3);
    // rust: c.forget_noted(false);
    // rust: arrow(&mut c, 4);
    // rust: c.forget_noted(true);
    // rust: assert_eq!(c.pending.iter().map(|p| p.1.0).collect::<Vec<_>>(), [1, 3]);
}
}
    // rust: mod stuck_tests {
//     use super::Stuck;

    // `LivingEntity.tick`: with `n` stuck the timer starts at
    // `20 * (30 - n)` and one falls out when it runs down.
arrows_fall_out_after_twenty_ticks_times_the_gap_to_thirty :: proc() {
}
    // rust: let mut s = Stuck::default();
    // rust: s.add_arrow();
    // rust: s.add_arrow();
    // rust: let wait = 20 * (30 - 2);
    // rust: for _ in 0..wait - 1 {
    // rust: assert!(!s.tick());
}
    // rust: assert!(s.tick());
    // rust: assert_eq!(s.arrows, 1);
        // The timer starts again from the new count.
    // rust: for _ in 0..20 * (30 - 1) - 1 {
    // rust: assert!(!s.tick());
}
    // rust: assert!(s.tick());
    // rust: assert_eq!(s.arrows, 0);
    // rust: assert!(!s.tick());
}

stingers_have_their_own_timer :: proc() {
}
    // rust: let mut s = Stuck::default();
    // rust: s.add_stinger();
    // rust: s.add_arrow();
    // rust: for _ in 0..20 * 29 - 1 {
    // rust: assert!(!s.tick());
}
        // Both timers run 580 ticks.
    // rust: assert!(s.tick());
    // rust: assert_eq!((s.arrows, s.stingers), (0, 0));
}
}
