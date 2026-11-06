//! Transpiled from Horizon Rust crate
//! Module: horizon-client_spawner
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Monster spawners in the game: `SpawnerBlockEntity.serverTick` and
//! `clientTick` for every spawner (`mobs::spawner`), the mobs they add, a
//! spawn egg used on one (`SpawnEggItem.useOn`), their events and the mob
//! spinning inside (`SpawnerRenderer`).
// use super::Game;
// use horizon_client::{
    // rust: Result,
    // rust: containers::BlockEntity,
    // rust: mobs::{
    // rust: Mob, Who,
    // rust: spawner::{SpawnDataExt, Spawner, SpawnerAdded, SpawnerEvent, SpawnerExt, SpawnerSpawn},
    // rust: spawning,
    // rust: trial_spawner::{TrialSpawnerExt, TrialState},
    // rust: },
    // rust: particles::{ParticleOptions, ParticleType},
}
// use horizon_core::{geometry::Vec3, random::RandomSource};
// use horizon_world::nbt::Tag;
// use std::collections::{HashMap, HashSet};

    // rust: type Pos = (i32, i32, i32);

/// What a spawner tick decided to add, created once the level is free.
    // rust: pub(super) enum Planned {
    /// `finalizeSpawn` ran on a fresh mob; the spawn data's `equipment`.
    // rust: Finalized(Mob, Option<Tag>),
    /// A mob loaded from the spawn data (with its passengers) and its
    /// `equipment`.
    // rust: Loaded(Tag, Option<Tag>),
}

/// What the spawner code keeps between ticks.
    // rust: pub(super) struct SpawnerState {
    /// Every entity type id (`EntityType.byString`), read once.
    // rust: entity_types: Option<HashSet<String>>,
    /// The mob shown in each spawner and the id it was made for
    /// (`getOrCreateDisplayEntity`).
    // rust: displays: HashMap<Pos, (String, Mob)>,
}

    // rust: impl Game<'_> {
    /// `EntityType.byString`: the type is in the registry.
    // rust: pub(super) fn entity_type_exists(&self, id: &str) -> bool {
    // rust: self.spawners
    // rust: .entity_types
    // rust: .as_ref()
    // rust: .is_some_and(|t| t.contains(id))
}
    // rust: pub(super) fn load_entity_types(&mut self) {
    // rust: if self.spawners.entity_types.is_some() {
    // rust: return;
}
    // rust: let path = self.options.resources.join("entity-types.json");
    // rust: let types = std::fs::read(path)
    // rust: .ok()
    // rust: .and_then(|b| serde_json::from_slice::<serde_json::Value>(&b).ok())
    // rust: .and_then(|v| {
    // rust: v.as_object().map(|o| {
    // rust: o.keys()
    // rust: .map(|k| horizon_client::command::args::normalize(k))
    // rust: .collect()
    // rust: })
    // rust: })
    // rust: .unwrap_or_default();
    // rust: self.spawners.entity_types = Some(types);
}
    /// The server tick of the spawner at `key`. Its client tick comes after
    /// every block entity's (`client_tick_spawners`).
    ///
    /// The caller only reaches this for a `BlockEntity::Spawner`, and changing
    /// the block removes or replaces that entity, so the block is not read
    /// again here.
    // rust: pub(super) fn tick_spawner(&mut self, key: Pos) -> Result<()> {
    // rust: let Some(BlockEntity::Spawner(mut spawner)) = self.world.block_entities.take(&key) else {
    // rust: return Ok(());
}
    // rust: let result = self.server_tick_spawner(key, &mut spawner);
    // rust: self.world
    // rust: .block_entities
    // rust: .put(key, BlockEntity::Spawner(spawner));
    // rust: result
}
    /// The client ticks of these spawners, then the shown mobs of spawners
    /// that are gone go.
    // rust: pub(super) fn client_tick_spawners(&mut self, keys: &[Pos]) {
    // rust: for &key in keys {
    // rust: self.client_tick_spawner(key);
}
    // rust: let entities = &self.world.block_entities;
    // rust: self.spawners.displays.retain(|k, _| {
    // rust: matches!(
    // rust: entities.get(k),
    // rust: Some(BlockEntity::Spawner(_) | BlockEntity::TrialSpawner(_))
    // rust: )
    // rust: });
}
pub fn server_tick_spawner(self: *Self, key: Pos, spawner: *mut Spawner) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.server_tick_spawner_of(key, spawner, None)
}
    /// `BaseSpawner.serverTick` at `key`: a spawner block's, or the spawner minecart
    /// `cart` is at (its `broadcastEvent` is an entity event on the cart).
    // rust: pub(super) fn server_tick_spawner_of(
    // rust: &mut self,
    // rust: key: Pos,
    // rust: spawner: &mut Spawner,
    // rust: cart: Option<u32>,
    // rust: ) -> Result<()> {
        // `BaseSpawner.serverTick` does nothing without an alive player in
        // range (`isNearPlayer`) or with the rule off: no level to build for it.
    // rust: let at = [key.0, key.1, key.2].map(|c| f64::from(c) + 0.5);
    // rust: let range = f64::from(spawner.required_player_range);
    // rust: if !self.alive_player_near(at[0], at[1], at[2], range)
    // rust: || !self.ui.rules.bool("spawner_blocks_work")
    // rust: {
    // rust: return Ok(());
}
    // rust: let pos = [key.0, key.1, key.2];
    // rust: let mut random = std::mem::replace(
    // rust: &mut self.world.random,
    // rust: horizon_core::random::LegacyRandom::new(0),
    // rust: );
    // rust: let mut events = Vec::new();
    // rust: let mut planned: Vec<Planned> = Vec::new();
    // rust: {
    // rust: let level = self.natural_level();
    // rust: let mut spawn = |l: &super::natural_spawning::GameLevel, r: &SpawnerSpawn| {
    // rust: l.game.plan_spawner_mob(l, r, &mut planned)
}
    // rust: spawner.server_tick(&level, &mut random, pos, &mut spawn, &mut events);
}
    // rust: self.world.random = random;
    // rust: let ids = self.add_planned(planned);
    // rust: self.apply_spawner_events(key, events, &ids, cart)
}
    /// Creates the mobs a spawner tick planned; their provisional ids
    /// (counting down from u32::MAX) map to the mobs' ids.
    // rust: pub(super) fn add_planned(&mut self, planned: Vec<Planned>) -> HashMap<u32, u32> {
    // rust: let mut ids = HashMap::new();
    // rust: for (i, plan) in planned.into_iter().enumerate() {
    // rust: let provisional = u32::MAX - i as u32;
    // rust: let id = match plan {
    // rust: Planned::Finalized(mut mob, equipment) => {
    // rust: self.next_entity += 1;
    // rust: mob.id = self.next_entity;
    // rust: let id = mob.id;
    // rust: self.mobs.push(mob);
    // rust: self.native_mobs_joined(self.mobs.len() - 1, false);
    // rust: self.enchant_spawn_equipment(id);
    // rust: self.halloween_spawn_head(id);
    // rust: self.spawn_jockeys(id, false);
    // rust: Some((id, equipment))
}
    // rust: Planned::Loaded(tag, equipment) => {
    // rust: self.load_mob(tag, None).map(|id| (id, equipment))
}
}
    // rust: if let Some((id, equipment)) = id {
                // `nextSpawnData.getEquipment().ifPresent(mob::equip)`.
    // rust: if let Some(table) = equipment {
    // rust: self.equip_from_table(id, &table);
}
    // rust: ids.insert(provisional, id);
}
}
    // rust: ids
}
    /// The spawner's `loadEntityRecursive` and `tryAddFreshEntityWithPassengers`:
    /// the mob it will add (created after the tick) and its box.
    // rust: pub(super) fn plan_spawner_mob(
    // rust: &self,
    // rust: l: &super::natural_spawning::GameLevel,
    // rust: r: &SpawnerSpawn,
    // rust: planned: &mut Vec<Planned>,
    // rust: ) -> Option<SpawnerAdded> {
    // rust: let kind = self.res.mob_types().get(r.id)?.clone();
    // rust: let [x, y, z] = r.position;
    // rust: let at = Vec3::new(x, y, z);
    // rust: let bounds = if r.finalize {
    // rust: let mut mob = Mob::new(0, kind, at, r.yaw);
    // rust: let facts = self.biome_facts(x.floor() as i32, y.floor() as i32, z.floor() as i32);
    // rust: let difficulty = self.local_difficulty(r.position);
    // rust: spawning::finalize(&mut mob, &facts, &difficulty);
            // TrialSpawner.spawnMob: setPersistenceRequired.
    // rust: mob.persistent = r.trial;
    // rust: horizon_client::mobs::raider::finalize(
    // rust: &mut mob,
    // rust: horizon_client::mobs::raider::Reason::Other,
    // rust: );
            // Shulker.finalizeSpawn faces it south.
    // rust: if mob.species() == horizon_client::mobs::Species::Shulker {
    // rust: mob.yaw = 0.0;
    // rust: mob.previous_yaw = 0.0;
    // rust: mob.body_yaw = 0.0;
    // rust: mob.previous_body_yaw = 0.0;
    // rust: mob.head_yaw = 0.0;
    // rust: mob.previous_head_yaw = 0.0;
}
    // rust: let bounds = mob.bounds();
    // rust: planned.push(Planned::Finalized(mob, r.equipment.cloned()));
    // rust: bounds
    // rust: } else {
            // A UUID already in the level is refused.
    // rust: let mut tag = r.entity.clone();
    // rust: if let Some(uuid) = horizon_client::entity_nbt::uuid(&Tag::Compound(tag.clone()))
    // rust: && self.persist.uuids.values().any(|u| *u == uuid)
    // rust: {
    // rust: return None;
}
    // rust: let double = |v: f64| Tag::Double(v.to_bits());
    // rust: tag.insert(
    // rust: "Pos".into(),
    // rust: Tag::List(vec![double(x), double(y), double(z)]),
    // rust: );
    // rust: tag.insert(
    // rust: "Rotation".into(),
    // rust: Tag::List(vec![
    // rust: Tag::Float(r.yaw.to_bits()),
    // rust: Tag::Float(0f32.to_bits()),
    // rust: ]),
    // rust: );
    // rust: if r.trial {
    // rust: tag.insert("PersistenceRequired".into(), Tag::Byte(1));
}
    // rust: let mut tag = Tag::Compound(tag);
            // EntityType.loadEntityRecursive applies the spawner's placement
            // callback to every passenger as well as the root.
    // rust: super::commands::place_summoned(&mut tag, r.position);
    // rust: let mob = horizon_client::entity_nbt::mob_from_nbt(
    // rust: &tag,
    // rust: self.res.mob_types(),
    // rust: 0,
    // rust: Some(self.pack.assets.registry),
    // rust: )?;
    // rust: let bounds = mob.bounds();
    // rust: planned.push(Planned::Loaded(tag, r.equipment.cloned()));
    // rust: bounds
}
    // rust: l.pending.borrow_mut().push(bounds);
    // rust: l.pending_ids.borrow_mut().push((r.id.to_owned(), bounds));
    // rust: Some(SpawnerAdded {
    // rust: id: u32::MAX - (planned.len() as u32 - 1),
    // rust: bounds,
    // rust: mob: true,
    // rust: })
}
    /// What a spawner's tick or a spawn egg did, shown and sent.
    // rust: fn apply_spawner_events(
    // rust: &mut self,
    // rust: key: Pos,
    // rust: events: Vec<SpawnerEvent>,
    // rust: ids: &HashMap<u32, u32>,
    // rust: cart: Option<u32>,
    // rust: ) -> Result<()> {
    // rust: let pos = [key.0, key.1, key.2];
    // rust: for event in events {
    // rust: match event {
                // A cart has no block to update: `sendBlockUpdated` finds nothing to send.
    // rust: SpawnerEvent::BlockUpdated if cart.is_some() => {}
    // rust: SpawnerEvent::BlockUpdated => self.spawner_block_updated(key),
                // `broadcastEvent`: `level.broadcastEntityEvent(cart, id)`.
    // rust: SpawnerEvent::BlockEvent(id) if cart.is_some() => {
    // rust: let at = pos.map(|c| f64::from(c) + 0.5);
    // rust: self.lan_entity_event(cart.unwrap_or_default() as i32, id as i8, at);
}
    // rust: SpawnerEvent::BlockEvent(id) => {
    // rust: self.lan_block_event(pos, id, 0);
                    // The client copy's onEventTriggered.
    // rust: if let Some(BlockEntity::Spawner(s)) = self.world.block_entities.get_mut(&key) {
    // rust: s.client_event(id);
}
}
    // rust: SpawnerEvent::LevelEvent(id) => self.level_event_at(id, pos, 0),
    // rust: SpawnerEvent::EntityPlace(mob, at) => {
    // rust: let who = ids.get(&mob).map(|id| Who::Mob(*id));
    // rust: self.post_block_game_event("minecraft:entity_place", at, who, None);
}
    // rust: SpawnerEvent::SpawnAnim(mob) => {
    // rust: if let Some(id) = ids.get(&mob) {
    // rust: self.mob_poof(*id);
}
}
}
}
    // rust: Ok(())
}
    /// `sendBlockUpdated`: the clients load the new update tag (the client
    /// copy's delay follows it, its display mob is made again).
pub fn spawner_block_updated(self: *Self, key: Pos) void {
}
    // rust: if let Some(BlockEntity::Spawner(s)) = self.world.block_entities.get_mut(&key) {
    // rust: s.client_loaded();
}
    // rust: self.spawners.displays.remove(&key);
    // rust: if let Some(log) = self.world.block_log.as_mut() {
    // rust: log.push(key);
}
    // rust: self.world.modified.insert((key.0 >> 4, key.2 >> 4));
}
    /// `LivingEntity.makePoofParticles` (entity event 20) for a mob.
    // rust: pub(super) fn mob_poof(&mut self, id: u32) {
    // rust: let Some(m) = self.mobs.iter().find(|m| m.id == id) else {
    // rust: return;
}
    // rust: let at = m.position;
    // rust: self.lan_entity_event(id as i32, 20, [at.x, at.y, at.z]);
    // rust: self.poof_particles(id);
}
    /// `Mob.handleEntityEvent` 20 (`spawnAnim` on a client): the poof about
    /// mob `id`.
    // rust: pub(super) fn poof_particles(&mut self, id: u32) {
    // rust: let Some(m) = self.mobs.iter().find(|m| m.id == id) else {
    // rust: return;
}
    // rust: let (at, w, h) = (m.position, f64::from(m.width()), f64::from(m.height()));
    // rust: let options = ParticleOptions::simple(ParticleType::Poof);
    // rust: for _ in 0..20 {
    // rust: let r = self.particles.level_random();
    // rust: let xa = r.next_gaussian() * 0.02;
    // rust: let ya = r.next_gaussian() * 0.02;
    // rust: let za = r.next_gaussian() * 0.02;
    // rust: let x = at.x + w * (2.0 * r.next_double() - 1.0) - xa * 10.0;
    // rust: let y = at.y + h * r.next_double() - ya * 10.0;
    // rust: let z = at.z + w * (2.0 * r.next_double() - 1.0) - za * 10.0;
    // rust: self.particles.add(&options, [x, y, z], [xa, ya, za]);
}
}
    /// `LevelEventHandler` 2004: twenty smoke and flame pairs around the spawner.
    // rust: pub(super) fn spawner_burst(&mut self, pos: [i32; 3]) {
    // rust: let (smoke, flame) = (
    // rust: ParticleOptions::simple(ParticleType::Smoke),
    // rust: ParticleOptions::simple(ParticleType::Flame),
    // rust: );
    // rust: for _ in 0..20 {
    // rust: let r = self.particles.level_random();
    // rust: let x = f64::from(pos[0]) + 0.5 + (r.next_double() - 0.5) * 2.0;
    // rust: let y = f64::from(pos[1]) + 0.5 + (r.next_double() - 0.5) * 2.0;
    // rust: let z = f64::from(pos[2]) + 0.5 + (r.next_double() - 0.5) * 2.0;
    // rust: self.particles.add(&smoke, [x, y, z], [0.0; 3]);
    // rust: self.particles.add(&flame, [x, y, z], [0.0; 3]);
}
}
    /// The client copy's tick: particles and the spin while a player is near.
pub fn client_tick_spawner(self: *Self, key: Pos) void {
}
    // rust: let near = {
    // rust: let Some(BlockEntity::Spawner(s)) = self.world.block_entities.get(&key) else {
    // rust: return;
}
    // rust: let range = f64::from(s.required_player_range);
    // rust: let center = [
    // rust: f64::from(key.0) + 0.5,
    // rust: f64::from(key.1) + 0.5,
    // rust: f64::from(key.2) + 0.5,
    // rust: ];
    // rust: self.player.as_ref().is_some_and(|p| {
    // rust: let d = (p.position.x - center[0]).powi(2)
    // rust: + (p.position.y - center[1]).powi(2)
    // rust: + (p.position.z - center[2]).powi(2);
    // rust: !p.health.dead_or_dying() && !self.spectator() && (range < 0.0 || d < range * range)
    // rust: })
}
    // rust: let display = self.update_spawner_display(key);
    // rust: let pos = [key.0, key.1, key.2];
    // rust: let random = self.particles.level_random();
    // rust: let Some(BlockEntity::Spawner(s)) = self.world.block_entities.get_mut(&key) else {
    // rust: return;
}
    // rust: if let Some(p) = s.client_tick(near, display, random, pos) {
    // rust: self.particles
    // rust: .add(&ParticleOptions::simple(ParticleType::Smoke), p, [0.0; 3]);
    // rust: self.particles
    // rust: .add(&ParticleOptions::simple(ParticleType::Flame), p, [0.0; 3]);
}
}
    /// `getOrCreateDisplayEntity`: the mob shown in the spawner, made again
    /// when its type changes. False when there is none.
    // rust: pub(super) fn update_spawner_display(&mut self, key: Pos) -> bool {
    // rust: let Some(kind) = self.spawner_display_kind(key) else {
    // rust: self.spawners.displays.remove(&key);
    // rust: return false;
}
    // rust: if self
    // rust: .spawners
    // rust: .displays
    // rust: .get(&key)
    // rust: .is_none_or(|(k, _)| *k != kind)
    // rust: {
    // rust: let Some(t) = self.res.mob_types().get(&kind).cloned() else {
    // rust: return false;
}
    // rust: let mob = Mob::new(u32::MAX, t, Vec3::ZERO, 0.0);
    // rust: self.spawners.displays.insert(key, (kind, mob));
}
    // rust: true
}
    /// The type of the mob a spawner shows: its next data's id, when the game
    /// knows the mob.
    /// A trial spawner shows one only in the states with a spinning mob.
pub fn spawner_display_kind(self: *Self, key: Pos) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let id = match self.world.block_entities.get(&key)? {
    // rust: BlockEntity::Spawner(s) => s.next_data()?.id()?,
    // rust: BlockEntity::TrialSpawner(s) => {
    // rust: self.trial_spawner_block(key)?.0.spinning_mob_speed()?;
    // rust: s.next_spawn_data.as_ref()?.id()?
}
    // rust: _ => return None,
}
    // rust: self.res.mob_types().contains_key(&id).then_some(id)
}
    /// `SpawnEggItem.useOn` on a spawner: the egg sets its mob, and an op's
    /// egg its entity `data` too (`block_entity_item::spawn_egg_on_spawner`).
    /// None when the clicked block has no spawner.
    // rust: pub(super) fn use_spawn_egg_on_spawner(
    // rust: &mut self,
    // rust: pos: [i32; 3],
    // rust: kind: &str,
    // rust: data: Option<&horizon_world::nbt::Compound>,
    // rust: ) -> Option<bool> {
    // rust: let key = (pos[0], pos[1], pos[2]);
    // rust: let trial = match self.world.block_entities.get(&key) {
    // rust: Some(BlockEntity::Spawner(_)) => false,
    // rust: Some(BlockEntity::TrialSpawner(_)) => true,
    // rust: _ => return None,
}
    // rust: if !self.ui.rules.bool("spawner_blocks_work") {
    // rust: self.system_message(horizon_client::text::Text::translate(
    // rust: "advMode.notEnabled.spawner",
    // rust: &[],
    // rust: ));
    // rust: return Some(false);
}
    // rust: if trial {
            // TrialSpawnerBlockEntity.setEntityId and setEntityData:
            // overrideEntityToSpawn, which ends in setState(INACTIVE).
    // rust: if let Some(BlockEntity::TrialSpawner(t)) = self.world.block_entities.get_mut(&key) {
    // rust: match data {
    // rust: Some(data) => t.override_entity_data(kind, data),
    // rust: None => t.override_entity(kind),
}
}
    // rust: let ominous = self.trial_spawner_block(key).is_some_and(|(_, o)| o);
    // rust: let _ = self.set_trial_spawner_state(key, TrialState::Inactive, ominous);
    // rust: } else {
    // rust: let mut events = Vec::new();
    // rust: let mut random = std::mem::replace(
    // rust: &mut self.world.random,
    // rust: horizon_core::random::LegacyRandom::new(0),
    // rust: );
    // rust: if let Some(BlockEntity::Spawner(s)) = self.world.block_entities.get_mut(&key) {
    // rust: match data {
    // rust: Some(data) => s.set_entity_data(kind, data, &mut random, &mut events),
    // rust: None => s.set_entity_id(kind, &mut random, &mut events),
}
}
    // rust: self.world.random = random;
    // rust: let _ = self.apply_spawner_events(key, events, &HashMap::new(), None);
}
        // sendBlockUpdated(3) and the player's block_change game event.
    // rust: self.spawner_block_updated(key);
    // rust: self.update_spawner_display(key);
    // rust: self.post_block_game_event("minecraft:block_change", pos, Some(Who::Player), None);
    // rust: Some(true)
}
    /// `PlayerList.isOp` for the player acting now: a server's guest by their
    /// own level, else the window's player.
    // rust: pub(super) fn acting_player_is_op(&self) -> bool {
    // rust: self.lan_acting_permission
    // rust: .unwrap_or(self.ui.registries.permission)
    // rust: > 0
}
    /// Ticks spawners, trial spawners and vaults near the player on a remote
    /// client (`tick_remote`).
    // rust: pub(super) fn tick_remote_spawners(&mut self) {
    // rust: let Some(p) = self.player.as_ref() else {
    // rust: return;
}
    // rust: let center = [
    // rust: p.position.x.floor() as i32,
    // rust: p.position.y.floor() as i32,
    // rust: p.position.z.floor() as i32,
    // rust: ];
    // rust: let (keys, trial_keys, vault_keys) =
    // rust: nearby_remote_spawner_keys(&self.world.block_entities, center);
    // rust: self.client_tick_spawners(&keys);
    // rust: for key in trial_keys {
    // rust: self.client_tick_trial_spawner(key);
}
        // VaultBlock.getTicker on the client: VaultBlockEntity.Client.tick.
    // rust: for key in vault_keys {
    // rust: self.client_tick_vault(key);
}
}
    /// `SpawnerRenderer` and `TrialSpawnerRenderer`: the next mob of every
    /// spawner near the camera, small and turning.
    // rust: pub(super) fn spawner_geometry(
    // rust: &self,
    // rust: camera: glam::DVec3,
    // rust: alpha: f64,
    // rust: out: &mut Vec<horizon_client::mesher::Vertex>,
    // rust: ) {
    // rust: let atlas = &self.gui.atlas;
    // rust: let lookup = |name: &str| atlas.sprites.get(name).map(|r| [r.u0, r.v0, r.u1, r.v1]);
        // A shader pack's shadow pass draws a block entity only in the sections it draws
        // (`Renderer::shadow_pass_block_entities`, #8464): a spawner's mob out of the view and
        // out of those sections isn't drawn, where it would have gone to the shadow pass alone.
    // rust: let shadow_sections = self
    // rust: .renderer
    // rust: .as_ref()
    // rust: .filter(|_| self.pack_ids.is_some() && self.pack_shadow_casters.0);
    // rust: for (key, (_, mob)) in &self.spawners.displays {
    // rust: let at = glam::DVec3::new(f64::from(key.0), f64::from(key.1), f64::from(key.2));
    // rust: if at.distance_squared(camera) >= 64.0 * 64.0 {
    // rust: continue;
}
    // rust: if let Some(r) = shadow_sections
    // rust: && !r.shadow_pass_drew([key.0, key.1, key.2])
    // rust: && self.view_frustum.is_some_and(|v| {
    // rust: let o = (at - camera).as_vec3();
    // rust: !v.intersects(o - glam::Vec3::ONE, o + glam::Vec3::splat(2.0))
    // rust: })
    // rust: {
    // rust: continue;
}
    // rust: let (spin, scale) = match self.world.block_entities.get(key) {
    // rust: Some(BlockEntity::Spawner(s)) => {
    // rust: s.display_pose(alpha as f32, mob.width(), mob.height())
}
    // rust: Some(BlockEntity::TrialSpawner(s)) => horizon_client::mobs::spawner::display_pose(
    // rust: s.o_spin,
    // rust: s.spin,
    // rust: alpha as f32,
    // rust: mob.width(),
    // rust: mob.height(),
    // rust: ),
    // rust: _ => continue,
}
    // rust: let origin = glam::Mat4::from_translation(
    // rust: (at - camera).as_vec3() + glam::Vec3::new(0.5, 0.4, 0.5),
    // rust: ) * glam::Mat4::from_rotation_y(spin.to_radians())
    // rust: * glam::Mat4::from_translation(glam::Vec3::new(0.0, -0.2, 0.0))
    // rust: * glam::Mat4::from_rotation_x((-30.0_f32).to_radians())
    // rust: * glam::Mat4::from_scale(glam::Vec3::splat(scale));
    // rust: let light = self.world.light(key.0, key.1, key.2);
    // rust: let packed = (u32::from(light >> 4) * 16) | ((u32::from(light & 15) * 16) << 8);
    // rust: if mob.species() == horizon_client::mobs::Species::SulfurCube {
    // rust: self.sulfur_cube_body_geometry(
    // rust: mob,
    // rust: alpha as f32,
    // rust: horizon_client::mobs::render::base_transform_at(mob, alpha as f32, origin),
    // rust: packed,
    // rust: out,
    // rust: );
}
    // rust: horizon_client::mobs::render::render_posed(
    // rust: mob,
    // rust: alpha as f32,
    // rust: origin,
    // rust: &lookup,
    // rust: packed,
    // rust: self.res.mob_data(),
    // rust: out,
    // rust: );
}
}
}

/// `SpawnerBlockEntity.clientTick` / `BaseSpawner.clientTick`: spawner, trial
/// spawner and vault keys within 64 blocks (Chebyshev distance) of `center`
/// among `entities`. Non-spawner block entities are ignored before distance
/// calculation, and coordinate difference uses `abs_diff` to prevent overflow.
    // rust: pub(super) fn nearby_remote_spawner_keys<'a>(
    // rust: entities: impl IntoIterator<Item = (&'a Pos, &'a BlockEntity)>,
    // rust: center: [i32; 3],
    // rust: ) -> (Vec<Pos>, Vec<Pos>, Vec<Pos>) {
    // rust: let mut keys = Vec::new();
    // rust: let mut trial_keys = Vec::new();
    // rust: let mut vault_keys = Vec::new();
    // rust: for (&pos, be) in entities {
    // rust: let target = match be {
    // rust: BlockEntity::Spawner(_) => &mut keys,
    // rust: BlockEntity::TrialSpawner(_) => &mut trial_keys,
    // rust: BlockEntity::Vault(_) => &mut vault_keys,
    // rust: _ => continue,
}
    // rust: let d = pos
    // rust: .0
    // rust: .abs_diff(center[0])
    // rust: .max(pos.1.abs_diff(center[1]))
    // rust: .max(pos.2.abs_diff(center[2]));
    // rust: if d <= 64 {
    // rust: target.push(pos);
}
}
    // rust: (keys, trial_keys, vault_keys)
}

    // rust: mod tests {
//     use super::*;

pub fn dummy_container_at_min_coordinate_does_not_panic_or_tick() void {
}
    // rust: let mut entities = HashMap::new();
        // Client dummy container menu placed at (i32::MIN, 0, 0) when remote
        // container lacks target block position (remote.rs:9393).
    // rust: entities.insert((i32::MIN, 0, 0), BlockEntity::Chest(Vec::new()));
    // rust: entities.insert(
    // rust: (i32::MIN, i32::MIN, i32::MIN),
    // rust: BlockEntity::Chest(Vec::new()),
    // rust: );
    // rust: entities.insert(
    // rust: (i32::MAX, i32::MAX, i32::MAX),
    // rust: BlockEntity::Chest(Vec::new()),
    // rust: );

        // Player at x = 1024: (pos.0 - center[0]) would be i32::MIN - 1024.
    // rust: let (keys, trial_keys, vault_keys) = nearby_remote_spawner_keys(&entities, [1024, 64, -50]);
    // rust: assert!(keys.is_empty());
    // rust: assert!(trial_keys.is_empty());
    // rust: assert!(vault_keys.is_empty());

        // Player at x = 0: (pos.0 - center[0]) would be i32::MIN - 0, and i32::MIN.abs() panics.
    // rust: let (keys, trial_keys, vault_keys) = nearby_remote_spawner_keys(&entities, [0, 0, 0]);
    // rust: assert!(keys.is_empty());
    // rust: assert!(trial_keys.is_empty());
    // rust: assert!(vault_keys.is_empty());
}

pub fn spawner_outside_64_block_chebyshev_range_is_not_ticked() void {
}
    // rust: let mut entities = HashMap::new();
    // rust: entities.insert((65, 0, 0), BlockEntity::Spawner(Box::default()));
    // rust: entities.insert((0, -65, 0), BlockEntity::TrialSpawner(Box::default()));
    // rust: entities.insert((0, 0, 65), BlockEntity::Vault(Box::default()));
    // rust: entities.insert((-65, 65, -65), BlockEntity::Spawner(Box::default()));

    // rust: let (keys, trial_keys, vault_keys) = nearby_remote_spawner_keys(&entities, [0, 0, 0]);
    // rust: assert!(
    // rust: keys.is_empty(),
    // rust: "spawners outside 64 blocks must not be ticked"
    // rust: );
    // rust: assert!(
    // rust: trial_keys.is_empty(),
    // rust: "trial spawners outside 64 blocks must not be ticked"
    // rust: );
    // rust: assert!(
    // rust: vault_keys.is_empty(),
    // rust: "vaults outside 64 blocks must not be ticked"
    // rust: );
}

pub fn spawners_within_64_block_chebyshev_range_are_ticked() void {
}
    // rust: let mut entities = HashMap::new();
    // rust: let spawner_at_boundary = (164, 64, -200);
    // rust: let spawner_near_player = (110, 69, -202);
    // rust: let trial_at_boundary = (36, 128, -264); // Chebyshev dx=64, dy=64, dz=64
    // rust: let vault_at_center = (100, 64, -200);

    // rust: entities.insert(spawner_at_boundary, BlockEntity::Spawner(Box::default()));
    // rust: entities.insert(spawner_near_player, BlockEntity::Spawner(Box::default()));
    // rust: entities.insert(trial_at_boundary, BlockEntity::TrialSpawner(Box::default()));
    // rust: entities.insert(vault_at_center, BlockEntity::Vault(Box::default()));

    // rust: let (mut keys, trial_keys, vault_keys) =
    // rust: nearby_remote_spawner_keys(&entities, [100, 64, -200]);
    // rust: keys.sort_unstable();
    // rust: let mut expected_spawners = vec![spawner_at_boundary, spawner_near_player];
    // rust: expected_spawners.sort_unstable();

    // rust: assert_eq!(keys, expected_spawners);
    // rust: assert_eq!(trial_keys, vec![trial_at_boundary]);
    // rust: assert_eq!(vault_keys, vec![vault_at_center]);
}

pub fn extreme_coordinate_boundary_does_not_overflow() void {
}
    // rust: let mut entities = HashMap::new();
    // rust: let max_pos = (i32::MAX, i32::MAX, i32::MAX);
    // rust: let min_pos = (i32::MIN, i32::MIN, i32::MIN);
    // rust: let in_range_max = (i32::MAX, 10, -5);

    // rust: entities.insert(max_pos, BlockEntity::Spawner(Box::default()));
    // rust: entities.insert(min_pos, BlockEntity::Spawner(Box::default()));
    // rust: entities.insert(in_range_max, BlockEntity::Spawner(Box::default()));

        // Player at i32::MIN: distance to i32::MAX would overflow signed 32-bit arithmetic.
    // rust: let (keys, _, _) = nearby_remote_spawner_keys(&entities, [i32::MIN, i32::MIN, i32::MIN]);
    // rust: assert_eq!(keys, vec![min_pos]);

        // Player at i32::MAX: distance to i32::MIN would overflow signed 32-bit arithmetic.
    // rust: let (keys, _, _) = nearby_remote_spawner_keys(&entities, [i32::MAX, i32::MAX, i32::MAX]);
    // rust: assert_eq!(keys, vec![max_pos]);

        // Player at i32::MAX - 64: in_range_max should be included.
    // rust: let (keys, _, _) = nearby_remote_spawner_keys(&entities, [i32::MAX - 64, 10, -5]);
    // rust: assert!(keys.contains(&in_range_max));
}
}
