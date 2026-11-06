//! Transpiled from Horizon Rust crate
package horizon_client_zombie_villagers

import "core:fmt"
import "core:mem"
import "core:math"

// Zombie villagers in the world: zombies turning the villagers they kill
// into zombie villagers (`Zombie.killedEntity`), the golden apple that starts
// a cure (`ZombieVillager.mobInteract`), and the cured villager that
// remembers who saved it (`ZombieVillager.finishConversion`).
// use super::{Game, commands::Target};
// use horizon_client::{
    // rust: advancements as adv,
    // rust: gossip::GossipType,
    // rust: lan::playerdata,
    // rust: mobs::{Mob, Species, villager, zombie_villager},
}
// use horizon_core::random::RandomSource;
// use horizon_world::food::Difficulty;

// The `Zombie` subclasses that convert the villagers they kill.
is_zombie :: proc(s: Species) -> b {
    // Ported from Horizon
    return {}
}
    // rust: matches!(
    // rust: s,
    // rust: Species::Zombie
    // rust: | Species::Husk
    // rust: | Species::Drowned
    // rust: | Species::ZombieVillager
    // rust: | Species::ZombifiedPiglin
    // rust: )
}
// Whether a zombie turns the villager it killed: always on Hard, half the
// time on Normal (`Zombie.killedEntity`).
infects :: proc(difficulty: Difficulty, coin: impl FnOnce() -> b {
    // Ported from Horizon
    return {}
}
    // rust: match difficulty {
    // rust: Difficulty::Hard => true,
    // rust: Difficulty::Normal => !coin(),
    // rust: _ => false,
}
}

    // rust: impl Game<'_> {
    // `ZombieVillager.handleEntityEvent(16)`: only the client plays the cure sound.
    // rust: pub(super) fn zombie_villager_cure_sound(&mut self, id: u32) {
    // rust: if let Some(m) = self.mobs.iter_mut().find(|m| m.id == id)
    // rust: && let Some(horizon_client::mobs::MobEvent::Sound(name, at, volume, pitch)) =
    // rust: zombie_villager::cure_sound(m)
    // rust: {
    // rust: self.audio
    // rust: .play_unshared(&format!("minecraft:{name}"), Some(at), volume, pitch);
}
}

    // `Zombie.killedEntity`: a villager killed by a zombie may rise as a
    // zombie villager keeping its profession, trades and gossip.
    // rust: pub(super) fn zombie_killed(&mut self, killer: u32, victim: u32) {
    // rust: let Some(k) = self.mobs.iter().position(|m| m.id == killer) else {
    // rust: return;
}
    // rust: let Some(v) = self.mobs.iter().position(|m| m.id == victim) else {
    // rust: return;
}
    // rust: if !is_zombie(self.mobs[k].species())
    // rust: || self.mobs[v].species() != Species::Villager
    // rust: || self.mobs[v].alive()
    // rust: || self.mobs[v].removed
    // rust: {
    // rust: return;
}
    // rust: let difficulty = self.world.health_rules.difficulty;
    // rust: let random = &mut self.mobs[k].random;
    // rust: if !infects(difficulty, || random.next_boolean()) {
    // rust: return;
}
        // The villager is gone without dying: no drops, no death animation.
    // rust: let old = self.mobs[v].clone();
    // rust: self.mobs[v].removed = true;
    // rust: self.mobs[v].health = 0.0;
    // rust: let at = [old.position.x, old.position.y, old.position.z];
    // rust: let Some(id) = self.spawn_mob("minecraft:zombie_villager", at, old.persistent) else {
    // rust: return;
}
    // rust: let ensure = self.mobs.iter().position(|m| m.id == victim);
    // rust: if let Some(i) = ensure {
    // rust: self.ensure_offers(i);
}
    // rust: let old = ensure.map_or(old, |i| self.mobs[i].clone());
    // rust: let Some(z) = self.mobs.iter_mut().find(|m| m.id == id) else {
    // rust: return;
}
    // rust: convert_to_zombie_villager(&old, z);
    // rust: if !self.mobs[k].silent {
    // rust: let at = self.mobs[k].position;
    // rust: self.level_event_at(
    // rust: 1026,
    // rust: [
    // rust: at.x.floor() as i32,
    // rust: at.y.floor() as i32,
    // rust: at.z.floor() as i32,
    // rust: ],
    // rust: 0,
    // rust: );
}
}

    // `ZombieVillager.mobInteract`: a golden apple on a weakened zombie
    // villager starts the cure and is eaten; without weakness it does
    // nothing. Returns whether the click was used.
    // rust: pub(super) fn interact_zombie_villager(&mut self, index: usize, item: &str) -> bool {
    // rust: let m = &self.mobs[index];
    // rust: if m.species() != Species::ZombieVillager || item != "minecraft:golden_apple" {
    // rust: return false;
}
    // rust: if !m.has_effect("minecraft:weakness") {
    // rust: return true;
}
    // rust: self.consume_held();
        // `player.getUUID()`: the acting player, a server's guest included.
    // rust: let starter = Some(self.acting_player_uuid());
    // rust: let time = zombie_villager::WAIT_MIN
    // rust: + self
    // rust: .world
    // rust: .random
    // rust: .next_int_bound(zombie_villager::WAIT_SPREAD)
    // rust: .unwrap_or(0);
    // rust: let mut events = Vec::new();
    // rust: zombie_villager::start_converting(&mut self.mobs[index], starter, time, &mut events);
    // rust: let _ = self.handle_mob_events(events);
    // rust: self.swing_arm();
    // rust: true
}

    // `ZombieVillager.finishConversion`: the villager returns with its
    // data, trades, experience and gossip, and the curing player earns the
    // village's trust.
    // rust: pub(super) fn cure_zombie_villager(&mut self, id: u32) {
    // rust: let Some(i) = self.mobs.iter().position(|m| m.id == id) else {
    // rust: return;
}
    // rust: if self.mobs[i].removed || zombie_villager::cure(&self.mobs[i]).is_none() {
    // rust: return;
}
    // rust: let old = self.mobs[i].clone();
    // rust: self.mobs[i].removed = true;
    // rust: let at = [old.position.x, old.position.y, old.position.z];
    // rust: let Some(vid) = self.spawn_mob("minecraft:villager", at, old.persistent) else {
    // rust: return;
}
    // rust: let Some(v) = self.mobs.iter_mut().find(|m| m.id == vid) else {
    // rust: return;
}
    // rust: convert_to_villager(&old, v);
        // `level.getPlayerByUUID(conversionStarter)`: the player who fed the
        // apple, if still in this level (the host or a server's guest).
    // rust: let starter = zombie_villager::cure(&old).and_then(|c| c.starter);
    // rust: let curer = starter.and_then(|uuid| Some((uuid, self.player_here(uuid)?)));
        // `Villager.onReputationEventFrom(ZOMBIE_VILLAGER_CURED)`.
    // rust: let Some(v) = self.mobs.iter_mut().find(|m| m.id == vid) else {
    // rust: return;
}
    // rust: if let Some((uuid, _)) = curer {
    // rust: let g = &mut villager::ext_mut(v).gossips;
    // rust: g.add(uuid, GossipType::MajorPositive, 20);
    // rust: g.add(uuid, GossipType::MinorPositive, 25);
}
    // rust: let cured = v.clone();
    // rust: let villager_view = self.mob_entity(&cured);
    // rust: let zombie_view = self.mob_entity(&old);
    // rust: if let Some((_, who)) = curer {
    // rust: self.for_player(who, |g| {
    // rust: g.trigger_cured_zombie_villager(&zombie_view, &villager_view)
    // rust: });
}
    // rust: if !old.silent {
    // rust: self.level_event_at(
    // rust: 1027,
    // rust: [
    // rust: old.position.x.floor() as i32,
    // rust: old.position.y.floor() as i32,
    // rust: old.position.z.floor() as i32,
    // rust: ],
    // rust: 0,
    // rust: );
}
}

    // `ServerLevel.getPlayerByUUID`: the player with `uuid` in this level.
player_here :: proc(self: ^Self, uuid: [i32; 4]) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match self.target_by_uuid(playerdata::ints_uuid(uuid))? {
    // rust: Target::Player => Some(Target::Player),
    // rust: Target::Guest(conn) => {
    // rust: let g = self.lan.as_ref()?.hub.guest(conn)?;
    // rust: (g.dimension == self.dim.id()).then_some(Target::Guest(conn))
}
    // rust: _ => None,
}
}

    // `CuredZombieVillagerTrigger`.
    // rust: fn trigger_cured_zombie_villager(
    // rust: &mut self,
    // rust: zombie: &adv::EntityView,
    // rust: villager: &adv::EntityView,
    // rust: ) {
    // rust: let me = self.player_entity_for("minecraft:cured_zombie_villager");
    // rust: let (zombie, villager) = (zombie.clone(), villager.clone());
    // rust: self.trigger("minecraft:cured_zombie_villager", move |c, w| {
    // rust: let origin = me.position;
    // rust: let ctx = |e| adv::Entities {
    // rust: this: Some(e),
    // rust: origin,
    // rust: tool: None,
    // rust: block_pos: None,
}
    // rust: adv::conditions(&c["player"], &ctx(&me), w)
    // rust: && adv::conditions(&c["zombie"], &ctx(&zombie), w)
    // rust: && adv::conditions(&c["villager"], &ctx(&villager), w)
    // rust: });
}
}

// `Mob.convertTo` (`ConversionType.SINGLE`, keeping equipment and the
// pick-up-loot flag): what any converted mob carries over.
carry_over :: proc(from: ^Mob, to: ^Mob) {
}
    // rust: to.position = from.position;
    // rust: to.previous = from.position;
    // rust: to.velocity = from.velocity;
    // rust: to.yaw = from.yaw;
    // rust: to.previous_yaw = from.yaw;
    // rust: to.body_yaw = from.body_yaw;
    // rust: to.previous_body_yaw = from.body_yaw;
    // rust: to.head_yaw = from.head_yaw;
    // rust: to.previous_head_yaw = from.head_yaw;
    // rust: to.head_pitch = from.head_pitch;
    // rust: to.previous_head_pitch = from.head_pitch;
    // rust: to.fall_distance = from.fall_distance;
    // rust: to.hurt_time = from.hurt_time;
    // rust: to.on_ground = from.on_ground;
    // rust: to.fire_ticks = from.fire_ticks;
    // rust: to.persistent = from.persistent;
    // rust: to.custom_name = from.custom_name.clone();
    // rust: to.custom_name_text = from.custom_name_text.clone();
    // rust: to.name_visible = from.name_visible;
    // rust: to.invisible = from.invisible;
    // rust: to.extra.pick_up_loot = from.extra.pick_up_loot;
    // ConversionType.convertCommon: the flags a converted mob keeps.
    // rust: to.extra.left_handed = from.extra.left_handed;
    // rust: to.no_ai = from.no_ai;
    // rust: to.invulnerable_flag = from.invulnerable_flag;
    // rust: to.no_gravity = from.no_gravity;
    // rust: to.silent = from.silent;
    // rust: to.extra.set_main_hand(from.extra.main_hand.clone());
    // rust: if let Some(stack) = from.extra.main_hand_stack() {
    // rust: to.extra.set_main_hand_stack(Some(stack.clone()));
}
    // rust: to.extra.off_hand = from.extra.off_hand.clone();
    // rust: to.extra.head = from.extra.head.clone();
    // rust: to.extra.chest = from.extra.chest.clone();
    // rust: to.extra.legs = from.extra.legs.clone();
    // rust: to.extra.feet = from.extra.feet.clone();
    // rust: to.extra.effects = from.extra.effects.clone();
    // VillagerData and the trades, experience and gossip.
    // rust: to.extra.variant = from.extra.variant;
    // rust: to.extra.variant2 = from.extra.variant2;
    // rust: to.extra.variant3 = from.extra.variant3.max(1);
    // rust: to.extra.trade = from.extra.trade.clone();
    // rust: if let Some(g) = villager::ext(from).map(|e| e.gossips.clone()) {
    // rust: villager::ext_mut(to).gossips = g;
}
}
// A villager rises as a zombie villager (never as an adult-age baby: a baby
// stays a baby for good).
    // rust: pub(super) fn convert_to_zombie_villager(from: &Mob, to: &mut Mob) {
    // rust: carry_over(from, to);
    // rust: to.extra.age = if from.is_baby() { i32::MIN / 2 } else { 0 };
}
// A cured zombie villager becomes a villager again, queasy for 10 seconds.
    // rust: pub(super) fn convert_to_villager(from: &Mob, to: &mut Mob) {
    // rust: carry_over(from, to);
    // rust: to.extra.age = if from.is_baby() { -24000 } else { 0 };
    // rust: to.add_effect("minecraft:nausea", 200, 0);
}

    // rust: mod tests {
//     use super::*;

zombies_convert_by_difficulty :: proc() {
}
    // rust: assert!(infects(Difficulty::Hard, || unreachable!()));
    // rust: assert!(!infects(Difficulty::Easy, || false));
    // rust: assert!(!infects(Difficulty::Peaceful, || false));
        // Normal: a coin toss that spares the villager when it is true.
    // rust: assert!(infects(Difficulty::Normal, || false));
    // rust: assert!(!infects(Difficulty::Normal, || true));
}
every_zombie_kind_infects :: proc() {
}
    // rust: for s in [
    // rust: Species::Zombie,
    // rust: Species::Husk,
    // rust: Species::Drowned,
    // rust: Species::ZombieVillager,
    // rust: Species::ZombifiedPiglin,
    // rust: ] {
    // rust: assert!(is_zombie(s));
}
    // rust: assert!(!is_zombie(Species::Skeleton) && !is_zombie(Species::Villager));
}

    // `ConversionType.convertCommon` copies Silent, NoAI, LeftHanded,
    // NoGravity and Invulnerable onto the mob that replaces the old one.
infection_and_the_cure_keep_the_common_flags :: proc() {
}
//         use horizon_client::mobs::{Anim, Brain, MobType, Part};
//         use horizon_core::geometry::Vec3;
//         use std::sync::Arc;
    // rust: let mob = |id, species, name: &str| {
    // rust: let kind = MobType {
    // rust: id: name.into(),
    // rust: species,
    // rust: width: 0.6,
    // rust: height: 1.95,
    // rust: eye_height: 1.74,
    // rust: category: "monster".into(),
    // rust: max_health: 20.0,
    // rust: speed: 0.23,
    // rust: flying_speed: 0.4,
    // rust: attack_damage: 3.0,
    // rust: attack_knockback: 0.0,
    // rust: follow_range: 35.0,
    // rust: step_height: 0.6,
    // rust: armor: 0.0,
    // rust: armor_toughness: 0.0,
    // rust: knockback_resistance: 0.0,
    // rust: jump_strength: 0.42,
    // rust: attributes: Arc::default(),
    // rust: item_stack_limits: Arc::default(),
    // rust: gravity: 0.08,
    // rust: safe_fall_distance: 3.0,
    // rust: fall_damage_multiplier: 1.0,
    // rust: water_efficiency: 0.0,
    // rust: water_slowdown: 0.8,
    // rust: air_speed: 0.02,
    // rust: baby_scale: 0.5,
    // rust: head_rot_speed: 10.0,
    // rust: max_head_x_rot: 40.0,
    // rust: max_head_y_rot: 75.0,
    // rust: ambient_interval: 80,
    // rust: flags: Default::default(),
    // rust: model: Arc::new(Part {
    // rust: name: "root".into(),
    // rust: pose: [0.0; 9],
    // rust: polygons: Vec::new(),
    // rust: children: Vec::new(),
    // rust: }),
    // rust: layers: Default::default(),
    // rust: texture: String::new(),
    // rust: brain: Brain::Passive,
    // rust: anim: Anim::Humanoid { zombie_arms: true },
    // rust: sounds: ["entity.villager.ambient"; 3],
    // rust: step_sound: None,
    // rust: food: Arc::default(),
    // rust: tempt: Arc::default(),
}
    // rust: Mob::new(id, Arc::new(kind), Vec3::ZERO, 0.0)
}
    // rust: let mut villager = mob(1, Species::Villager, "minecraft:villager");
    // rust: villager.silent = true;
    // rust: villager.no_ai = true;
    // rust: villager.no_gravity = true;
    // rust: villager.invulnerable_flag = true;
    // rust: villager.extra.left_handed = true;
    // rust: let mut zombie = mob(2, Species::ZombieVillager, "minecraft:zombie_villager");
    // rust: assert!(!zombie.silent && !zombie.no_ai && !zombie.extra.left_handed);
    // rust: convert_to_zombie_villager(&villager, &mut zombie);
    // rust: assert!(zombie.silent);
    // rust: assert!(zombie.no_ai);
    // rust: assert!(zombie.no_gravity);
    // rust: assert!(zombie.invulnerable_flag);
    // rust: assert!(zombie.extra.left_handed);
    // rust: let mut cured = mob(3, Species::Villager, "minecraft:villager");
    // rust: convert_to_villager(&zombie, &mut cured);
    // rust: assert!(cured.silent);
    // rust: assert!(cured.no_ai);
    // rust: assert!(cured.no_gravity);
    // rust: assert!(cured.invulnerable_flag);
    // rust: assert!(cured.extra.left_handed);
}
}
