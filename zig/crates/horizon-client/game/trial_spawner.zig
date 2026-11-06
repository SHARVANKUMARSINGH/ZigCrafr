//! Transpiled from Horizon Rust crate
//! Module: horizon-client_trial_spawner
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Trial spawners in the game: `TrialSpawner.tickServer` for every trial
//! spawner (`mobs::trial_spawner`), the block's state as it changes, the mobs
//! it adds and the rewards it ejects.
// use super::{Game, natural_spawning::GameLevel, spawner::Planned};
// use horizon_client::{
    // rust: Result,
    // rust: containers::BlockEntity,
    // rust: items::ItemStack,
    // rust: mobs::{
    // rust: Who,
    // rust: spawner::SpawnerSpawn,
    // rust: trial_spawner::{
    // rust: TRIAL_OMEN_TICKS_PER_LEVEL, TrialEvent, TrialPlayer, TrialSpawner, TrialSpawnerExt,
    // rust: TrialSpawnerLevel, TrialState, Uuid,
    // rust: },
    // rust: },
}
// use horizon_core::{
    // rust: geometry::Vec3,
    // rust: random::{LegacyRandom, RandomSource},
}
// use horizon_world::nbt::Tag;
// use std::collections::HashMap;

    // rust: type Pos = (i32, i32, i32);

    // rust: impl TrialSpawnerLevel for GameLevel<'_, '_> {
pub fn game_time(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.game.world.game_time
}
pub fn mob_spawning(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.game.ui.rules.bool("spawn_mobs")
}
pub fn players(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let guests = self.game.lan_present().into_iter().map(|g| TrialPlayer {
    // rust: uuid: g.uuid,
    // rust: block: g.position.map(|v| v.floor() as i32),
    // rust: eye: g.eye,
    // rust: creative: g.creative,
    // rust: spectator: g.spectator,
    // rust: position: g.position,
    // rust: height: g.height,
    // rust: alive: g.alive,
    // rust: omen: g.omen,
    // rust: });
    // rust: let (Some(p), Some(view)) = (self.game.player.as_ref(), self.game.player_view()) else {
    // rust: return guests.collect();
}
    // rust: let host = TrialPlayer {
    // rust: uuid: self.game.acting_uuid(),
    // rust: block: [p.position.x, p.position.y, p.position.z].map(|v| v.floor() as i32),
    // rust: eye: view.eye,
    // rust: creative: self.game.creative,
    // rust: spectator: self.game.spectator(),
    // rust: position: [p.position.x, p.position.y, p.position.z],
    // rust: height: p.dimensions.height,
    // rust: alive: self.game.level.health > 0.0,
    // rust: omen: super::lan_mobs::omen_of(&self.game.potions.effects),
}
    // rust: std::iter::once(host).chain(guests).collect()
}
pub fn visual_hit(self: *Self, from: [f64; 3], to: [f64; 3]) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let v = |p: [f64; 3]| Vec3::new(p[0], p[1], p[2]);
    // rust: self.w.visual_hit(v(from), v(to))
}
pub fn entity_block(self: *Self, uuid: Uuid) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (id, _) = self.game.persist.uuids.iter().find(|(_, u)| **u == uuid)?;
    // rust: let m = self.game.mobs.iter().find(|m| m.id == *id)?;
    // rust: (!m.removed && m.alive())
    // rust: .then(|| [m.position.x, m.position.y, m.position.z].map(|v| v.floor() as i32))
}
pub fn entity_box(self: *Self, uuid: Uuid) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (id, _) = self.game.persist.uuids.iter().find(|(_, u)| **u == uuid)?;
    // rust: let m = self.game.mobs.iter().find(|m| m.id == *id)?;
    // rust: let b = m.bounds();
    // rust: (!m.removed && m.alive()).then(|| {
    // rust: (
    // rust: [m.position.x, m.position.y, m.position.z],
    // rust: (b.max_position().y - b.min_position().y) as f32,
    // rust: )
    // rust: })
}
pub fn no_block_collision(self: *Self, block: [i32; 3]) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.w
    // rust: .block_collision_boxes(block[0], block[1], block[2])
    // rust: .is_empty()
}
pub fn loot_items(self: *Self, table: []const u8, seed: i64) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(loot) = horizon_client::structure_blocks::loot_data(
    // rust: &self.game.options.resources,
    // rust: &self.game.pack_files(),
    // rust: ) else {
    // rust: return Vec::new();
}
    // rust: loot.roll_split(table, &mut LegacyRandom::new(seed))
    // rust: .iter()
    // rust: .map(horizon_client::structure_blocks::loot_item_with_components)
    // rust: .collect()
}
pub fn seed(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.game.level.seed
}
}

    // rust: impl Game<'_> {
    /// The server tick of the trial spawner at `key`. Its client tick comes
    /// after every block entity's.
    // rust: pub(super) fn tick_trial_spawner(&mut self, key: Pos) -> Result<()> {
    // rust: let Some((current, ominous)) = self.trial_spawner_block(key) else {
    // rust: return Ok(());
}
    // rust: let Some(BlockEntity::TrialSpawner(mut spawner)) = self.world.block_entities.take(&key)
    // rust: else {
    // rust: return Ok(());
}
    // rust: let result = self.server_tick_trial_spawner(key, &mut spawner, current, ominous);
    // rust: self.world
    // rust: .block_entities
    // rust: .put(key, BlockEntity::TrialSpawner(spawner));
    // rust: result
}
    /// The trial spawner block at `key`: its state and ominous flag.
    // rust: pub(super) fn trial_spawner_block(&self, key: Pos) -> Option<(TrialState, bool)> {
    // rust: let block = self
    // rust: .pack
    // rust: .assets
    // rust: .registry
    // rust: .state(self.world.block(key.0, key.1, key.2))?;
    // rust: if block.name != "minecraft:trial_spawner" {
    // rust: return None;
}
    // rust: let state = block
    // rust: .properties
    // rust: .get("trial_spawner_state")
    // rust: .and_then(|s| TrialState::from_name(s))
    // rust: .unwrap_or_default();
    // rust: Some((
    // rust: state,
    // rust: block.properties.get("ominous").is_some_and(|v| v == "true"),
    // rust: ))
}
    // rust: fn server_tick_trial_spawner(
    // rust: &mut self,
    // rust: key: Pos,
    // rust: spawner: &mut TrialSpawner,
    // rust: current: TrialState,
    // rust: ominous: bool,
    // rust: ) -> Result<()> {
    // rust: let pos = [key.0, key.1, key.2];
    // rust: let mut random = std::mem::replace(&mut self.world.random, LegacyRandom::new(0));
    // rust: let mut sequences = std::mem::take(&mut self.rand_sequences);
    // rust: let mut events = Vec::new();
    // rust: let mut planned: Vec<Planned> = Vec::new();
    // rust: let mut uuids: Vec<(u32, Uuid)> = Vec::new();
    // rust: let mut ejected: Vec<(ItemStack, [f64; 3])> = Vec::new();
    // rust: let next = {
    // rust: let level = self.natural_level();
    // rust: let loot = horizon_client::structure_blocks::loot_data(
    // rust: &self.options.resources,
    // rust: &self.pack_files(),
    // rust: );
    // rust: let seed = self.level.seed;
    // rust: let mut spawn = |l: &GameLevel, r: &SpawnerSpawn| {
    // rust: let added = l.game.plan_spawner_mob(l, r, &mut planned)?;
    // rust: let uuid = match planned.last_mut() {
    // rust: Some(Planned::Loaded(Tag::Compound(tag), _)) => {
    // rust: let tag_uuid =
    // rust: horizon_client::entity_nbt::uuid(&Tag::Compound(tag.clone()));
    // rust: tag_uuid.unwrap_or_else(|| {
    // rust: let uuid = horizon_client::save::random_uuid();
    // rust: tag.insert("UUID".into(), Tag::IntArray(uuid.to_vec()));
    // rust: uuid
    // rust: })
}
    // rust: _ => horizon_client::save::random_uuid(),
}
    // rust: uuids.push((added.id, uuid));
    // rust: Some(uuid)
}
            // TrialSpawner.ejectReward: the table's items, each thrown up out
            // of the spawner (DefaultDispenseItemBehavior.spawnItem, accuracy 2).
    // rust: let mut eject = |table: &str, random: &mut LegacyRandom| {
    // rust: let Some(loot) = &loot else {
    // rust: return false;
}
    // rust: let drops = match loot.random_sequence(table) {
    // rust: Some(s) => loot.roll_split(table, sequences.get(s, seed)),
    // rust: None => loot.roll_split(table, random),
}
    // rust: for stack in &drops {
                    // The power, which only scales the direction's x and z (0 going up).
    // rust: random.next_double();
    // rust: let spread = 0.017_227_5 * 2.0;
    // rust: let v = [
    // rust: random.triangle(0.0, spread),
    // rust: random.triangle(0.2, spread),
    // rust: random.triangle(0.0, spread),
    // rust: ];
    // rust: ejected.push((
    // rust: horizon_client::structure_blocks::loot_item_with_components(stack),
    // rust: v,
    // rust: ));
}
    // rust: !drops.is_empty()
}
    // rust: spawner.server_tick(
    // rust: &level,
    // rust: &mut random,
    // rust: pos,
    // rust: current,
    // rust: ominous,
    // rust: &mut spawn,
    // rust: &mut eject,
    // rust: &mut events,
    // rust: )
}
    // rust: self.world.random = random;
    // rust: self.rand_sequences = sequences;
    // rust: let ids = self.add_planned(planned);
    // rust: let mut by_uuid = HashMap::new();
    // rust: for (provisional, uuid) in uuids {
    // rust: if let Some(id) = ids.get(&provisional) {
    // rust: self.persist.uuids.insert(*id, uuid);
    // rust: by_uuid.insert(uuid, *id);
}
}
    // rust: let center = pos.map(|v| f64::from(v) + 0.5);
        // Vec3.atBottomCenterOf(pos).relative(UP, 1.2), lowered by spawnItem.
    // rust: let above = [center[0], center[1] + 0.7 - 0.125, center[2]];
    // rust: for (stack, v) in ejected {
    // rust: self.spawn_item(stack, above, v, 0);
}
    // rust: if next != current || ominous != spawner.is_ominous {
    // rust: self.set_trial_spawner_state(key, next, spawner.is_ominous)?;
}
    // rust: for event in events {
    // rust: match event {
    // rust: TrialEvent::BlockUpdated => self.mark_block_entity_updated(key),
    // rust: TrialEvent::LevelEvent(id, at, data) => self.level_event_at(id, at, data),
    // rust: TrialEvent::Sound(name) => {
    // rust: self.audio
    // rust: .play(&format!("minecraft:{name}"), Some(center), 1.0, 1.0)
}
                // Written with the state above.
    // rust: TrialEvent::OminousSet(_) => {}
    // rust: TrialEvent::EntityPlace(uuid, at) => {
    // rust: let who = by_uuid.get(&uuid).map(|id| Who::Mob(*id));
    // rust: self.post_block_game_event("minecraft:entity_place", at, who, None);
}
    // rust: TrialEvent::TrialOmen(uuid) => self.bad_omen_to_trial_omen(uuid),
    // rust: TrialEvent::Discard(uuid) => {
    // rust: let id = self.persist.uuids.iter().find(|(_, u)| **u == uuid);
    // rust: if let Some((id, _)) = id
    // rust: && let Some(m) = self.mobs.iter_mut().find(|m| m.id == *id)
    // rust: {
    // rust: m.removed = true;
}
}
    // rust: TrialEvent::SoundAt(name, at, pitch) => self.audio.play(
    // rust: &format!("minecraft:{name}"),
    // rust: Some(at.map(|v| f64::from(v) + 0.5)),
    // rust: 1.0,
    // rust: pitch,
    // rust: ),
    // rust: TrialEvent::ItemSpawner {
    // rust: item,
    // rust: position,
    // rust: delay,
    // rust: } => self.add_ominous_item_spawner(item, position, delay),
}
}
    // rust: Ok(())
}
    /// `setState` (and `removeOminous`): the block's state and ominous flag.
    // rust: pub(super) fn set_trial_spawner_state(
    // rust: &mut self,
    // rust: key: Pos,
    // rust: state: TrialState,
    // rust: ominous: bool,
    // rust: ) -> Result<()> {
    // rust: let current = self.world.block(key.0, key.1, key.2);
    // rust: let Some(mut block) = self.pack.assets.registry.state(current).cloned() else {
    // rust: return Ok(());
}
    // rust: block
    // rust: .properties
    // rust: .insert("trial_spawner_state".into(), state.name().into());
    // rust: block
    // rust: .properties
    // rust: .insert("ominous".into(), ominous.to_string());
    // rust: let id = self.pack.assets.registry.resolve(&block)?;
    // rust: self.level_set([key.0, key.1, key.2], id)
}
    /// `transformBadOmenIntoTrialOmen`: Bad Omen becomes Trial Omen, 15
    /// minutes per level, with Trial Omen's sound when it is new. `uuid` is
    /// the player found: the one in the game's frame, else a guest.
pub fn bad_omen_to_trial_omen(self: *Self, uuid: Uuid) void {
}
    // rust: let eye = if self.acting_uuid() == uuid {
    // rust: transform_bad_omen(&mut self.potions.effects)
    // rust: .then(|| self.eye_position().unwrap_or_default())
    // rust: } else {
    // rust: let acting = self.lan_acting;
    // rust: let Some(guest) = self.lan.as_mut().and_then(|h| {
    // rust: h.hub.guests.iter_mut().find(|g| {
    // rust: horizon_client::lan::playerdata::uuid_ints(g.uuid) == uuid
    // rust: && Some(g.conn) != acting
    // rust: })
    // rust: }) else {
    // rust: return;
}
    // rust: let [x, y, z] = guest.position;
    // rust: let eye = [x, y + guest.eye_height(), z];
    // rust: transform_bad_omen(&mut guest.effects).then_some(eye)
}
    // rust: if let Some(eye) = eye {
    // rust: self.audio
    // rust: .play("minecraft:event.mob_effect.trial_omen", Some(eye), 1.0, 1.0);
}
}
    /// `sendBlockUpdated` of a block entity: the clients load its new update tag.
    // rust: pub(super) fn mark_block_entity_updated(&mut self, key: Pos) {
    // rust: if let Some(log) = self.world.block_log.as_mut() {
    // rust: log.push(key);
}
    // rust: self.world.modified.insert((key.0 >> 4, key.2 >> 4));
}
}

/// Swap Bad Omen for Trial Omen on `effects`; true when Trial Omen is new.
pub fn transform_bad_omen(effects: *mut horizon_client::effects::PlayerEffects) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(amplifier) = effects.amplifier("bad_omen") else {
    // rust: return false;
}
    // rust: effects.list.retain(|e| e.id != "bad_omen");
    // rust: let new = effects.get("trial_omen").is_none();
    // rust: effects.add(horizon_client::effects::EffectInstance::new(
    // rust: "trial_omen",
    // rust: TRIAL_OMEN_TICKS_PER_LEVEL * (amplifier + 1),
    // rust: 0,
    // rust: ));
    // rust: new
}

    // rust: mod omen_tests {
//     use super::*;
//     use horizon_client::{
    // rust: effects::{EffectInstance, PlayerEffects},
    // rust: mobs::trial_spawner::Omen,
}

pub fn bad_omen_becomes_trial_omen_per_level() void {
}
    // rust: let omen_of = super::super::lan_mobs::omen_of;
    // rust: let mut e = PlayerEffects::default();
    // rust: assert_eq!(omen_of(&e), None);
    // rust: e.add(EffectInstance::new("bad_omen", 100, 1));
    // rust: assert_eq!(omen_of(&e), Some(Omen::Bad));
    // rust: assert!(transform_bad_omen(&mut e));
    // rust: assert!(e.get("bad_omen").is_none());
    // rust: assert_eq!(
    // rust: e.get("trial_omen").unwrap().duration,
    // rust: TRIAL_OMEN_TICKS_PER_LEVEL * 2
    // rust: );
    // rust: assert_eq!(omen_of(&e), Some(Omen::Trial));
    // rust: assert!(!transform_bad_omen(&mut e));
}
}
