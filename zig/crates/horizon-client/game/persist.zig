//! Transpiled from Horizon Rust crate
//! Module: horizon-client_persist
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Saving and loading the game state that lives outside chunk blocks:
//! entities (`entities/*.mca`, per chunk like vanilla's `EntityStorage`) and
//! scheduled block/fluid ticks (chunk `block_ticks`/`fluid_ticks`).
// use super::{FallingBlock, Game};
// use horizon_client::{
    // rust: Result,
    // rust: chunk::Chunk,
    // rust: entity_nbt,
    // rust: mobs::Who,
    // rust: save::{ChunkExtras, random_uuid, text, uuid_from_text, uuid_text},
    // rust: scoreboard::Scoreboard,
}
// use horizon_core::{
    // rust: geometry::{Direction, Vec3},
    // rust: position::{BlockPos, ChunkPos},
    // rust: random::RandomSource,
    // rust: ticks::ChunkTicks,
}
// use horizon_world::attachments::{ATTACHMENTS_KEY, attachment_compound};
// use horizon_world::{level::MovingPiston, nbt::Tag, registry::BlockStateId};
// use std::{
    // rust: collections::{HashMap, HashSet},
    // rust: sync::Arc,
}

/// What Horizon remembers about loaded entities to save them faithfully.
pub const EntityMemory = struct {
    /// UUIDs of entities by Horizon entity ID: the one each was loaded with,
    /// or made up once something needed it (a save, a native mod's attachment).
    // rust: pub(super) uuids: HashMap<u32, [i32; 4]>,
    /// The compound each mob or item entity was loaded with.
    // rust: pub(super) raw: HashMap<u32, Tag>,
    /// Entities of types Horizon does not simulate, kept per chunk and
    /// written back unchanged.
    unknown: HashMap<(i32,
    /// The compound of orbs, arrows, falling blocks, tridents, crystals and the
    /// dragon as they were loaded, found again by type and position (one that
    /// has moved since loading is saved afresh); their UUIDs are in `uuids`.
    anon: HashMap<([]const u8,
    /// UUIDs of the vehicles `restore_saved_vehicle` brought in from the
    /// player's file: their chunk copies must not spawn a second one. Cleared
    /// with the rest when a world closes.
    restored: HashSet<[i32,
    /// Entities a native mod kept out of the level (`native_entity_join_level`),
    /// counted so `/summon` can fail as vanilla's refused add does.
    // rust: pub(super) joins_canceled: u32,
    /// The highest entity id `native_entity_join_level` has been told of.
    // rust: pub(super) joined_mark: u32,
    /// The entities mods were told of and that have not left since: id (in
    /// increasing order), type, and whether the last leave sweep saw it.
    /// Only filled while a mod is loaded.
    // rust: pub(super) live: Vec<(u32, String, bool)>,
};

/// The key that marks a compound queued with the chunk loads as a fresh add
/// (`PersistentEntitySectionManager.addNewEntity`: `/summon`, a portal
/// arrival), not an entity loaded from disk. Taken off before the compound
/// is kept or saved.
pub const FRESH_ADD: []const u8 = "horizon:fresh_add";

/// Queue `tag` with the chunk loads as a fresh add.
    // rust: pub(super) fn mark_fresh(tag: &mut Tag) {
    // rust: if let Tag::Compound(c) = tag {
    // rust: c.insert(FRESH_ADD.into(), Tag::Byte(1));
}
}

/// The key that marks a compound queued with the chunk loads as an entity
/// moving within its level (an End gateway: `Entity.teleport` takes
/// `teleportSameDimension`, which moves the entity without removing it), so
/// it doesn't join the level again. Taken off like [`FRESH_ADD`].
pub const SAME_LEVEL_MOVE: []const u8 = "horizon:same_level_move";

/// Queue `tag` with the chunk loads as an entity moving within its level.
    // rust: pub(super) fn mark_moved(tag: &mut Tag) {
    // rust: if let Tag::Compound(c) = tag {
    // rust: c.insert(SAME_LEVEL_MOVE.into(), Tag::Byte(1));
}
}

/// Whether `tag` was queued as a move within its level; the mark comes off.
pub fn take_moved(tag: *mut Tag) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match tag {
    // rust: Tag::Compound(c) => c.remove(&SAME_LEVEL_MOVE.into()).is_some(),
    // rust: _ => false,
}
}

/// Whether `tag` was queued as a fresh add; the mark comes off.
pub fn take_fresh(tag: *mut Tag) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match tag {
    // rust: Tag::Compound(c) => c.remove(&FRESH_ADD.into()).is_some(),
    // rust: _ => false,
}
}

pub fn anon_key(kind: []const u8, p: Vec3) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (
    // rust: kind.to_owned(),
    // rust: [p.x.to_bits(), p.y.to_bits(), p.z.to_bits()],
    // rust: )
}
/// The loaded compound underneath the fields Horizon models: what the entity was
/// loaded with, with every key of `modelled` replacing its loaded value.
    // rust: pub(super) fn with_raw(modelled: Tag, raw: Option<&Tag>) -> Tag {
    // rust: let (Some(Tag::Compound(raw)), Tag::Compound(modelled)) = (raw, &modelled) else {
    // rust: return modelled;
}
    // rust: let mut out = raw.clone();
    // rust: for (k, v) in modelled {
        // Defaults Horizon invents for fields it does not simulate give way to the save.
    // rust: let invented = matches!(
    // rust: k.to_string_lossy().as_str(),
    // rust: "Fire" | "Air" | "Invulnerable" | "PortalCooldown" | "HasBeenShot"
    // rust: );
    // rust: if !(invented && out.contains_key(k)) {
    // rust: out.insert(k.clone(), v.clone());
}
}
    // rust: Tag::Compound(out)
}

    // rust: fn read_attachments(
    // rust: tag: &Tag,
    // rust: uuid: [i32; 4],
    // rust: maps: &mut HashMap<[i32; 4], horizon_world::attachments::Attachments>,
    // rust: ) {
    // rust: if let Ok(Some(data)) = attachment_compound(tag.get(ATTACHMENTS_KEY)) {
    // rust: maps.entry(uuid)
    // rust: .or_insert_with(|| horizon_world::attachments::Attachments::from_nbt(data.clone()));
}
}

/// Overlay live attachment maps on entity tags, including passenger trees.
    // rust: pub(super) fn write_attachments(
    // rust: tag: &mut Tag,
    // rust: maps: &HashMap<[i32; 4], horizon_world::attachments::Attachments>,
    // rust: ) {
    // rust: let uuid = entity_nbt::uuid(tag);
    // rust: if let Tag::Compound(root) = tag {
    // rust: if let Some(map) = uuid.and_then(|id| maps.get(&id))
    // rust: && attachment_compound(root.get(&ATTACHMENTS_KEY.into())).is_ok()
    // rust: {
    // rust: let data = map.to_nbt();
    // rust: if data.is_empty() {
    // rust: root.remove(&ATTACHMENTS_KEY.into());
    // rust: } else {
    // rust: root.insert(ATTACHMENTS_KEY.into(), Tag::Compound(data));
}
}
    // rust: if let Some(Tag::List(passengers)) = root.get_mut(&"Passengers".into()) {
    // rust: for passenger in passengers {
    // rust: write_attachments(passenger, maps);
}
}
}
}

pub fn painting_center(p: *horizon_client::entities::Painting) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (lo, hi) = p.bounds();
    // rust: Vec3::new(
    // rust: (lo[0] + hi[0]) / 2.0,
    // rust: (lo[1] + hi[1]) / 2.0,
    // rust: (lo[2] + hi[2]) / 2.0,
    // rust: )
}
pub fn block_entity_pos(tag: *Tag) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: [tag.get("x"), tag.get("y"), tag.get("z")]
    // rust: .map(|v| horizon_client::save::number(v).unwrap_or(0) as i32)
}
pub fn chunk_of(p: Vec3) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: ((p.x.floor() as i32) >> 4, (p.z.floor() as i32) >> 4)
}

    // rust: impl Game<'_> {
    /// Saved ticks and the save time for a chunk about to be written.
    // rust: pub(super) fn attach_save_data(&self, chunk: &mut Chunk) {
    // rust: let pos = ChunkPos::new(chunk.x, chunk.z);
    // rust: let time = self.world.game_time;
    // rust: let mut extras: ChunkExtras = chunk.saved.as_deref().cloned().unwrap_or_default();
    // rust: extras.block_entity_attachments = self
    // rust: .world
    // rust: .block_entities
    // rust: .chunk_attachments(chunk.x, chunk.z);
        // A chunk the scheduler hasn't registered yet (one loaded and
        // unloaded again before the next tick) still holds its saved ticks:
        // `register_chunk_ticks` empties that list once it takes them.
    // rust: if let Some(t) = self.block_ticks.blocks.chunk(pos) {
    // rust: extras.block_ticks = t.pack(time);
}
    // rust: if let Some(t) = self.block_ticks.fluids.chunk(pos) {
    // rust: extras.fluid_ticks = t.pack(time);
}
    // rust: extras.last_update = time;
        // PistonMovingBlockEntity.saveAdditional: a block caught mid-move is
        // saved with its chunk (#3310).
    // rust: for (p, piston) in &self.block_ticks.moving_pistons {
    // rust: if (p.x >> 4, p.z >> 4) != (chunk.x, chunk.z) {
    // rust: continue;
}
    // rust: extras
    // rust: .block_entities
    // rust: .retain(|tag| block_entity_pos(tag) != [p.x, p.y, p.z]);
    // rust: extras
    // rust: .block_entities
    // rust: .push(self.moving_piston_to_nbt(*p, piston));
}
        // TheEndGatewayBlockEntity saves its Age (the server copy's).
    // rust: for tag in &mut extras.block_entities {
    // rust: let pos = [tag.get("x"), tag.get("y"), tag.get("z")]
    // rust: .map(|v| horizon_client::save::number(v).unwrap_or(0) as i32);
    // rust: if let Some(g) = self.be_anims.gateway_servers.get(&pos)
    // rust: && let Some(age) = tag.get_mut("Age")
    // rust: {
    // rust: *age = horizon_world::nbt::Tag::Long(g.age);
}
}
    // rust: if let Some(t) = self.world.inhabited.get(&(chunk.x, chunk.z)) {
    // rust: extras
    // rust: .root
    // rust: .insert("InhabitedTime".into(), horizon_world::nbt::Tag::Long(*t));
}
    // rust: chunk.saved = Some(Arc::new(extras));
}
    /// Register a newly resident chunk with the tick scheduler, with the
    /// block and fluid ticks it was saved with (`LevelChunk.registerTickContainerInLevel`
    /// at FULL). They are unpacked when the chunk starts ticking
    /// (`start_ticking_chunks`).
    // rust: pub(super) fn register_chunk_ticks(&mut self, key: (i32, i32)) {
    // rust: let pos = ChunkPos::new(key.0, key.1);
    // rust: let saved = self.world.chunks.get(&key).and_then(|c| c.saved.clone());
        // ChunkAccess.inhabitedTime as saved.
    // rust: if let Some(Tag::Long(t)) = saved
    // rust: .as_deref()
    // rust: .and_then(|s| s.root.get(&"InhabitedTime".into()))
    // rust: {
    // rust: self.world.inhabited.insert(key, *t);
}
    // rust: let (blocks, fluids) = saved.as_deref().map_or((Vec::new(), Vec::new()), |s| {
    // rust: (s.block_ticks.clone(), s.fluid_ticks.clone())
    // rust: });
    // rust: let loaded = !blocks.is_empty() || !fluids.is_empty();
    // rust: if self
    // rust: .block_ticks
    // rust: .add_chunk(
    // rust: pos,
    // rust: ChunkTicks::from_saved(blocks),
    // rust: ChunkTicks::from_saved(fluids),
    // rust: )
    // rust: .is_ok()
    // rust: && loaded
    // rust: {
    // rust: self.tick_chunks.wait(key);
}
        // The saved list is consumed: later saves take the scheduler's ticks.
    // rust: if loaded && let Some(c) = self.world.chunks.get_mut(&key) {
    // rust: let c = Arc::make_mut(c);
    // rust: if let Some(s) = c.saved.as_mut() {
    // rust: let s = Arc::make_mut(s);
    // rust: s.block_ticks.clear();
    // rust: s.fluid_ticks.clear();
}
}
        // PistonMovingBlockEntity.loadAdditional: blocks saved mid-move carry
        // on moving; later saves take them from the level (#3310).
    // rust: let pistons: Vec<_> = saved.as_deref().map_or_else(Vec::new, |s| {
    // rust: s.block_entities
    // rust: .iter()
    // rust: .filter_map(|tag| self.moving_piston_from_nbt(tag))
    // rust: .collect()
    // rust: });
    // rust: if pistons.is_empty() {
    // rust: return;
}
    // rust: for &(pos, piston) in &pistons {
    // rust: self.block_ticks.load_moving_piston(pos, piston);
}
    // rust: if let Some(c) = self.world.chunks.get_mut(&key) {
    // rust: let c = Arc::make_mut(c);
    // rust: if let Some(s) = c.saved.as_mut() {
    // rust: Arc::make_mut(s).block_entities.retain(|tag| {
    // rust: let at = block_entity_pos(tag);
    // rust: !pistons.iter().any(|(p, _)| [p.x, p.y, p.z] == at)
    // rust: });
}
}
}
    /// `PistonMovingBlockEntity.saveAdditional`.
    // rust: pub(super) fn moving_piston_to_nbt(&self, pos: BlockPos, piston: &MovingPiston) -> Tag {
    // rust: let flag = |b: bool| Tag::Byte(i8::from(b));
    // rust: Tag::compound([
    // rust: ("id", Tag::String("minecraft:piston".into())),
    // rust: ("x", Tag::Int(pos.x)),
    // rust: ("y", Tag::Int(pos.y)),
    // rust: ("z", Tag::Int(pos.z)),
    // rust: ("blockState", self.state_to_nbt(piston.moved_state)),
            // Direction.LEGACY_ID_CODEC: the 3D data value as a byte.
    // rust: ("facing", Tag::Byte(piston.direction as i8)),
    // rust: ("progress", Tag::Float(piston.progress_o.to_bits())),
    // rust: ("extending", flag(piston.extending)),
    // rust: ("source", flag(piston.source)),
    // rust: ])
}
    /// `PistonMovingBlockEntity.loadAdditional`, for a `minecraft:piston`
    /// entity whose block is still a moving piston.
pub fn moving_piston_from_nbt(self: *Self, tag: *Tag) O {
    // Implementation ported from Horizon
    return undefined;
}
//         use horizon_client::save::{float, number, text};
    // rust: if text(tag.get("id")).as_deref() != Some("minecraft:piston") {
    // rust: return None;
}
    // rust: let [x, y, z] = block_entity_pos(tag);
    // rust: let here = self.world.block(x, y, z);
    // rust: if &*self.res.facts().get(here).name != "minecraft:moving_piston" {
    // rust: return None;
}
    // rust: let moved_state = tag
    // rust: .get("blockState")
    // rust: .and_then(|t| self.state_from_nbt(t))
    // rust: .or_else(|| self.pack.assets.registry.default_state("minecraft:air"))?;
    // rust: let direction = usize::try_from(number(tag.get("facing")).unwrap_or(0))
    // rust: .ok()
    // rust: .and_then(|i| Direction::ALL.get(i).copied())
    // rust: .unwrap_or(Direction::Down);
    // rust: let progress = float(tag.get("progress")).unwrap_or(0.0) as f32;
    // rust: let flag = |k: &str| number(tag.get(k)).unwrap_or(0) != 0;
    // rust: Some((
    // rust: BlockPos::new(x, y, z),
    // rust: MovingPiston {
    // rust: moved_state,
    // rust: direction,
    // rust: extending: flag("extending"),
    // rust: source: flag("source"),
    // rust: progress,
    // rust: progress_o: progress,
    // rust: last_ticked: 0,
    // rust: death_ticks: 0,
    // rust: id: 0,
    // rust: },
    // rust: ))
}
    /// Spawn the entities of chunks that finished loading.
    // rust: pub(super) fn spawn_loaded_entities(&mut self) {
    // rust: let loaded = std::mem::take(&mut self.world.loaded_entities);
    // rust: let player_uuid = self.level.player_uuid;
    // rust: for (key, tags) in loaded {
    // rust: let count = tags.len();
    // rust: for mut tag in tags {
                // PersistentEntitySectionManager.addEntity's `loaded`.
    // rust: let from_disk = !take_fresh(&mut tag);
                // An End gateway's traveller never left the level: nothing joins.
    // rust: let moved = take_moved(&mut tag);
                // Whatever was added since the last tick joins before this one.
    // rust: self.native_joins_flush(false, 0);
    // rust: let kind = entity_nbt::kind(&tag).unwrap_or_default();
    // rust: let is_mob = self.res.mob_types().contains_key(kind.as_str());
    // rust: drop_unleashable_leash(&mut tag, &kind, is_mob);
    // rust: let uuid = entity_nbt::uuid(&tag);
    // rust: if uuid.is_some_and(|u| self.restored_vehicle(u).is_some()) {
    // rust: continue;
}
    // rust: if (matches!(
    // rust: kind.as_str(),
    // rust: "minecraft:experience_orb"
    // rust: | "minecraft:arrow"
    // rust: | "minecraft:spectral_arrow"
    // rust: | "minecraft:llama_spit"
    // rust: | "minecraft:shulker_bullet"
    // rust: | "minecraft:experience_bottle"
    // rust: | "minecraft:fireball"
    // rust: | "minecraft:small_fireball"
    // rust: | "minecraft:wind_charge"
    // rust: | "minecraft:breeze_wind_charge"
    // rust: | "minecraft:snowball"
    // rust: | "minecraft:egg"
    // rust: | "minecraft:ender_pearl"
    // rust: | "minecraft:splash_potion"
    // rust: | "minecraft:lingering_potion"
    // rust: | "minecraft:falling_block"
    // rust: | "minecraft:firework_rocket"
    // rust: | "minecraft:trident"
    // rust: | "minecraft:end_crystal"
    // rust: | "minecraft:ender_dragon"
    // rust: ) || horizon_client::projectiles::thrown_type(&kind).is_some())
    // rust: && let Some(at) = entity_nbt::position(&tag)
    // rust: {
    // rust: self.persist
    // rust: .anon
    // rust: .insert(anon_key(&kind, at), (at, tag.clone()));
}
                // Kinds outside `entity_lists!` first, then the listed kinds
                // (`Entity::load_nbt`), then whatever else is a compound.
    // rust: if let Err(tag) = self.load_unlisted(key, &kind, uuid, tag)
    // rust: && let Err(tag) = self.load_listed(&kind, uuid, player_uuid, tag)
    // rust: {
    // rust: if !kind.is_empty() && entity_nbt::position(&tag).is_some() {
    // rust: self.load_other(tag, &kind);
    // rust: } else {
    // rust: self.persist.unknown.entry(key).or_default().push(tag);
}
}
                // PersistentEntitySectionManager.addEntity: every kind that
                // just joined tells the mods; a moved one does not join.
    // rust: if moved {
    // rust: self.native_joins_skip();
    // rust: } else {
    // rust: self.native_joins_flush(from_disk, 0);
}
}
    // rust: self.native_entities_load(self.dim.id(), [key.0, key.1], count);
}
}
    /// The kinds `entity_lists!` does not hold: `Err` hands the compound back
    /// when `kind` is not one of them.
    // rust: fn load_unlisted(
    // rust: &mut self,
    // rust: key: ChunkKey,
    // rust: kind: &str,
    // rust: uuid: Option<[i32; 4]>,
    // rust: tag: Tag,
    // rust: ) -> std::result::Result<(), Tag> {
    // rust: match kind {
    // rust: "minecraft:area_effect_cloud" => {
    // rust: if let Some(id) = self.load_potion_cloud(&tag) {
    // rust: self.remember(id, uuid, tag);
}
}
    // rust: "minecraft:evoker_fangs" => {
    // rust: if let Some(at) = entity_nbt::position(&tag) {
    // rust: self.next_entity += 1;
    // rust: let id = self.next_entity;
    // rust: let delay = horizon_client::save::number(tag.get("Warmup")).unwrap_or(0) as i32;
    // rust: let owner = self.loaded_fangs_owner(&tag);
    // rust: self.insert_fangs(
    // rust: id,
    // rust: [at.x, at.y, at.z],
    // rust: entity_nbt::rotation(&tag)[0],
    // rust: delay,
    // rust: owner,
    // rust: );
    // rust: self.remember(id, uuid, tag);
}
}
    // rust: "minecraft:ominous_item_spawner" => self.load_ominous_item_spawner(tag),
    // rust: "minecraft:ender_dragon" => self.load_dragon(tag, uuid),
    // rust: "minecraft:end_crystal" => self.load_crystal(tag, uuid),
    // rust: "minecraft:item_frame" | "minecraft:glow_item_frame" => self.load_item_frame(tag, uuid),
    // rust: "minecraft:cushion" => self.load_cushion(tag, uuid),
    // rust: "minecraft:painting" => self.load_painting(tag, uuid, key),
    // rust: _ => return Err(tag),
}
    // rust: Ok(())
}
    /// A saved dropped item.
    // rust: pub(super) fn load_item(&mut self, tag: Tag, uuid: Option<[i32; 4]>) {
    // rust: self.next_entity += 1;
    // rust: let bob = self.world.random.next_float() * std::f32::consts::PI * 2.0;
    // rust: if let Some(e) = entity_nbt::item_entity_from_nbt(&tag, self.next_entity, bob) {
    // rust: self.remember(e.id, uuid, tag);
    // rust: self.dropped.push(e);
}
}

    /// A saved experience orb (or the orbs it stands for).
    // rust: pub(super) fn load_orb(&mut self, tag: Tag, uuid: Option<[i32; 4]>) {
    // rust: for (i, mut orb) in entity_nbt::orbs_from_nbt(&tag).into_iter().enumerate() {
    // rust: self.next_entity += 1;
    // rust: orb.id = self.next_entity;
    // rust: let id = orb.id;
            // Horizon splits a saved `count` into orbs: the first is the saved one.
    // rust: if i == 0 {
    // rust: self.remember_uuid(id, uuid, &tag);
}
            // An orb that came through a portal keeps its cooldown.
    // rust: self.restore_portal_cooldown(id, &tag);
    // rust: self.orbs.push(orb);
    // rust: self.remember_tags(id, &tag);
}
}

    /// A saved arrow or spectral arrow.
    // rust: pub(super) fn load_arrow(
    // rust: &mut self,
    // rust: tag: Tag,
    // rust: uuid: Option<[i32; 4]>,
    // rust: player_uuid: Option<[i32; 4]>,
    // rust: ) {
    // rust: if let Some((mut p, in_block)) =
    // rust: entity_nbt::arrow_from_nbt(&tag, player_uuid, super::dispenser::tipped_effect)
    // rust: {
    // rust: if let Some(a) = p.arrow.as_mut() {
    // rust: a.last_state = in_block.and_then(|t| self.state_from_nbt(&t));
}
    // rust: self.claim_owner(&mut p);
            // An arrow that came through a portal keeps its
            // cooldown: it does not go straight back through.
    // rust: self.next_entity += 1;
    // rust: p.id = self.next_entity;
    // rust: self.restore_portal_cooldown(p.id, &tag);
    // rust: self.remember_tags(p.id, &tag);
    // rust: self.remember_uuid(p.id, uuid, &tag);
    // rust: self.add_projectile(p);
}
}

    /// A saved llama spit or shulker bullet.
    // rust: pub(super) fn load_spit_or_bullet(&mut self, tag: Tag, player_uuid: Option<[i32; 4]>) {
    // rust: if let Some(mut p) = entity_nbt::spit_or_bullet_from_nbt(&tag, player_uuid) {
    // rust: self.claim_owner(&mut p);
    // rust: self.next_entity += 1;
    // rust: p.id = self.next_entity;
    // rust: self.restore_portal_cooldown(p.id, &tag);
    // rust: self.add_projectile(p);
    // rust: self.remember_last_projectile_tags(&tag);
}
}
    /// A saved fireball or wind charge.
    // rust: pub(super) fn load_fireball(
    // rust: &mut self,
    // rust: tag: Tag,
    // rust: uuid: Option<[i32; 4]>,
    // rust: player_uuid: Option<[i32; 4]>,
    // rust: ) {
    // rust: if let Some(mut p) = entity_nbt::fireball_from_nbt(&tag, player_uuid) {
    // rust: self.claim_owner(&mut p);
            // A projectile that came through a portal keeps its cooldown.
    // rust: self.next_entity += 1;
    // rust: p.id = self.next_entity;
    // rust: self.restore_portal_cooldown(p.id, &tag);
    // rust: self.remember_uuid(p.id, uuid, &tag);
    // rust: self.add_projectile(p);
    // rust: self.remember_last_projectile_tags(&tag);
}
}

    /// A saved thrown item.
    // rust: pub(super) fn load_throwable(
    // rust: &mut self,
    // rust: tag: Tag,
    // rust: uuid: Option<[i32; 4]>,
    // rust: player_uuid: Option<[i32; 4]>,
    // rust: ) {
    // rust: if let Some(mut p) = entity_nbt::throwable_from_nbt(&tag, player_uuid) {
    // rust: self.claim_owner(&mut p);
            // A projectile that came through a portal keeps its cooldown.
    // rust: self.next_entity += 1;
    // rust: p.id = self.next_entity;
    // rust: self.restore_portal_cooldown(p.id, &tag);
    // rust: self.remember_uuid(p.id, uuid, &tag);
    // rust: self.add_projectile(p);
    // rust: self.remember_last_projectile_tags(&tag);
}
}

    /// A saved falling block.
    // rust: pub(super) fn load_falling(&mut self, tag: Tag, uuid: Option<[i32; 4]>) {
    // rust: if let Some((state, position, velocity, age, fall_distance)) =
    // rust: entity_nbt::falling_block_from_nbt(&tag)
    // rust: && let Some(state) = self.state_from_nbt(&state)
    // rust: {
    // rust: let (no_gravity, drop_item) = entity_nbt::falling_block_flags(&tag);
    // rust: self.next_entity += 1;
            // A summoned one has no UUID yet: `Entity` makes a random one.
    // rust: self.remember_uuid(self.next_entity, uuid, &tag);
    // rust: let uuid = self.uuid_for(self.next_entity);
    // rust: self.falling.push(FallingBlock {
    // rust: rotation: [0.0, 0.0],
    // rust: join: Default::default(),
    // rust: id: self.next_entity,
    // rust: state,
                // DATA_START_POS is not persisted by vanilla.
    // rust: start_pos: horizon_core::position::BlockPos::default(),
    // rust: position,
    // rust: previous: position,
    // rust: velocity,
    // rust: age,
    // rust: no_gravity,
    // rust: portal: horizon_client::nether_portal::PortalState {
    // rust: cooldown: horizon_client::save::number(tag.get("PortalCooldown")).unwrap_or(0)
    // rust: as i32,
    // rust: process: None,
    // rust: },
    // rust: drop_item,
    // rust: fall_distance,
    // rust: stuck: Vec3::ZERO,
    // rust: damage: horizon_client::falling_block::Damage::from_nbt(
    // rust: &tag,
    // rust: self.res.facts().get(state).name.ends_with("anvil"),
    // rust: ),
    // rust: saved: Some(Box::new((uuid, tag.clone()))),
    // rust: });
}
}

    /// A saved thrown trident.
    // rust: pub(super) fn load_trident(&mut self, tag: Tag, uuid: Option<[i32; 4]>) {
    // rust: if let Some(n) = entity_nbt::trident_from_nbt(&tag) {
    // rust: let mut t = super::trident::ThrownTrident::from_nbt(n);
    // rust: t.id = self.take_entity_id();
            // One that came through a portal keeps its cooldown.
    // rust: let id = t.id;
    // rust: self.tridents.push(t);
    // rust: self.remember(id, uuid, tag);
}
}

    /// A saved firework rocket.
    // rust: pub(super) fn load_rocket(
    // rust: &mut self,
    // rust: tag: Tag,
    // rust: uuid: Option<[i32; 4]>,
    // rust: player_uuid: Option<[i32; 4]>,
    // rust: ) {
    // rust: if let Some(r) = entity_nbt::firework_rocket_from_nbt(&tag, player_uuid) {
    // rust: let id = self.take_entity_id();
    // rust: let mut rocket = super::fireworks::Rocket::from_nbt(r);
    // rust: rocket.id = id;
            // One that came through a portal keeps its cooldown.
    // rust: self.restore_portal_cooldown(id, &tag);
    // rust: self.rockets.push(rocket);
    // rust: self.remember(id, uuid, tag);
}
}

    /// A saved primed TNT.
    // PrimedTnt.readAdditionalSaveData: its fuse (80 when absent) and motion.
    // Its Passengers ride it (EntityType.loadEntityRecursive forces them on).
    // rust: pub(super) fn load_tnt(&mut self, tag: Tag, uuid: Option<[i32; 4]>) {
    // rust: let mut tag = tag;
    // rust: let riders = self.take_mob_passengers(&mut tag);
    // rust: if let Some(position) = entity_nbt::position(&tag) {
    // rust: self.next_entity += 1;
    // rust: let id = self.next_entity;
    // rust: let fuse = match tag.get("fuse") {
    // rust: Some(Tag::Short(f)) => i32::from(*f),
    // rust: _ => 80,
}
    // rust: self.tnts.push(super::tnt::PrimedTnt {
    // rust: rotation: [0.0, 0.0],
    // rust: join: Default::default(),
    // rust: no_gravity: entity_nbt::flag(&tag, "NoGravity"),
    // rust: id,
    // rust: position,
    // rust: previous: position,
    // rust: velocity: entity_nbt::motion(&tag),
    // rust: fuse,
    // rust: on_ground: matches!(tag.get("OnGround"), Some(Tag::Byte(1))),
    // rust: owner: None,
    // rust: guest: None,
                // PrimedTnt.readAdditionalSaveData: 4 by default,
                // kept to 0..128.
    // rust: power: entity_nbt::tnt_power(&tag),
    // rust: block_state: tag
    // rust: .get("block_state")
    // rust: .and_then(|v| entity_nbt::state_from_nbt(self.pack.assets.registry, v)),
    // rust: });
            // `Entity.load`: the `PortalCooldown` of one that just came through.
    // rust: self.remember(id, uuid, tag);
    // rust: for rider in riders {
    // rust: self.load_mob(rider, Some(id));
}
}
}

    /// A saved boat.
    // rust: pub(super) fn load_boat(&mut self, tag: Tag, uuid: Option<[i32; 4]>, k: &str) {
    // rust: if let Some((position, velocity, yaw)) = entity_nbt::boat_from_nbt(&tag) {
    // rust: let mut tag = tag;
    // rust: let riders = self.take_mob_passengers(&mut tag);
    // rust: self.next_entity += 1;
    // rust: let id = self.next_entity;
    // rust: let (wood, chest) = super::boats::any_boat_wood(k).unwrap_or(("oak", false));
    // rust: let mut b = super::boats::Boat::new(id, std::sync::Arc::from(wood), position, yaw);
    // rust: b.no_gravity = entity_nbt::flag(&tag, "NoGravity");
    // rust: b.pitch = entity_nbt::rotation(&tag)[1];
    // rust: if chest {
    // rust: b = b.with_chest();
    // rust: b.items =
    // rust: horizon_client::save::decode_items(tag.get("Items"), super::boats::CHEST_SLOTS);
}
    // rust: b.velocity = velocity;
            // AbstractBoat.readAdditionalSaveData: the lead's holder.
    // rust: b.leash_pending = horizon_client::mobs::leash::pending_from_nbt(tag.get("leash"));
    // rust: self.remember(id, uuid, tag);
    // rust: self.boats.push(b);
    // rust: for rider in riders {
    // rust: self.load_mob(rider, Some(id));
}
}
}

    /// A saved minecart.
    // rust: pub(super) fn load_cart(&mut self, tag: Tag, uuid: Option<[i32; 4]>, k: &str) {
    // rust: let kind = super::minecarts::CartKind::from_id(k).unwrap();
    // rust: let mut tag = tag;
    // rust: let riders = self.take_mob_passengers(&mut tag);
    // rust: let id = self.next_entity + 1;
    // rust: if let Some(mut c) = super::minecarts::Minecart::from_nbt(&tag, id, kind) {
    // rust: super::minecarts::forget_unreadable_display(&mut c, |t| {
    // rust: self.state_from_nbt(t).is_some()
    // rust: });
    // rust: self.roll_cart_loot(&mut c, &tag);
    // rust: self.next_entity = id;
    // rust: self.remember(id, uuid, tag);
    // rust: self.carts.push(c);
    // rust: for rider in riders {
    // rust: self.load_mob(rider, Some(id));
}
}
}

    /// A saved armor stand.
    // rust: pub(super) fn load_armor_stand(&mut self, tag: Tag, uuid: Option<[i32; 4]>) {
    // rust: self.next_entity += 1;
    // rust: if let Some(a) = entity_nbt::armor_stand_from_nbt(&tag, self.next_entity) {
    // rust: self.remember(a.id, uuid, tag);
    // rust: self.armor_stands.push(a);
}
}

    /// The saved ender dragon.
    // rust: pub(super) fn load_dragon(&mut self, tag: Tag, uuid: Option<[i32; 4]>) {
    // rust: let seed = self.world.random.next_long();
    // rust: if self.dragon.is_none()
    // rust: && let Some(mut d) = super::dragon::Dragon::from_nbt(&tag, seed)
    // rust: {
            // EnderDragon's constructor takes its id and its
            // parts' from the entity counter.
    // rust: d.id = self.next_entity + 1;
    // rust: self.next_entity += 9;
    // rust: self.remember_tags(d.id, &tag);
    // rust: self.remember_uuid(d.id, uuid, &tag);
    // rust: self.dragon = Some(d);
}
}

    /// A saved end crystal.
    // rust: pub(super) fn load_crystal(&mut self, tag: Tag, uuid: Option<[i32; 4]>) {
    // rust: let time = self.world.random.next_int_bound(100_000).unwrap_or(0);
    // rust: if let Some(mut c) = super::dragon::Crystal::from_nbt(&tag, time) {
            // EndCrystal's constructor takes an id from the
            // entity counter.
    // rust: self.next_entity += 1;
    // rust: c.id = self.next_entity;
    // rust: self.remember_tags(c.id, &tag);
    // rust: self.remember_uuid(c.id, uuid, &tag);
    // rust: self.crystals.push(c);
}
}

    /// A saved item frame.
    // rust: pub(super) fn load_item_frame(&mut self, tag: Tag, uuid: Option<[i32; 4]>) {
    // rust: self.next_entity += 1;
    // rust: if let Some(f) = entity_nbt::item_frame_from_nbt(&tag, self.next_entity) {
    // rust: self.remember(f.id, uuid, tag);
    // rust: self.item_frames.push(f);
}
}

    /// A saved cushion.
    // rust: pub(super) fn load_cushion(&mut self, tag: Tag, uuid: Option<[i32; 4]>) {
    // rust: self.next_entity += 1;
    // rust: if let Some(c) = entity_nbt::cushion_from_nbt(&tag, self.next_entity) {
    // rust: self.remember(c.id, uuid, tag);
    // rust: self.cushions.push(c);
}
}

    /// A saved painting, or its compound when its variant is unknown.
    // rust: pub(super) fn load_painting(&mut self, tag: Tag, uuid: Option<[i32; 4]>, key: ChunkKey) {
    // rust: if let Some((pos, facing, variant)) = entity_nbt::painting_from_nbt(&tag)
    // rust: && let Some(v) = self.painting_variants.get(&variant).cloned()
    // rust: {
    // rust: self.next_entity += 1;
    // rust: let id = self.next_entity;
    // rust: self.remember(id, uuid, tag);
    // rust: self.paintings.push(horizon_client::entities::Painting {
    // rust: id,
    // rust: pos,
    // rust: facing,
    // rust: variant: v.id,
    // rust: width: v.width,
    // rust: height: v.height,
    // rust: check_interval: 0,
    // rust: });
    // rust: } else {
    // rust: self.persist.unknown.entry(key).or_default().push(tag);
}
}
    /// A saved mob and, under `Passengers`, the mobs riding it.
    // rust: pub(super) fn load_mob(&mut self, tag: Tag, mount: Option<u32>) -> Option<u32> {
    // rust: let uuid = entity_nbt::uuid(&tag);
    // rust: if let Some(id) = uuid.and_then(|u| self.restored_vehicle(u)) {
    // rust: return Some(id);
}
    // rust: self.next_entity += 1;
        // Structure mobs that generation left to finish: saves from before
        // they were finalized at placement, or a placement that could not.
    // rust: let mut tag = tag;
    // rust: let mut finalize = false;
    // rust: if let Tag::Compound(c) = &mut tag {
    // rust: finalize = c.remove(&"horizon:finalize".into()).is_some();
}
    // rust: let riders = self.take_mob_passengers(&mut tag);
    // rust: let mut m = entity_nbt::mob_from_nbt(
    // rust: &tag,
    // rust: self.res.mob_types(),
    // rust: self.next_entity,
    // rust: Some(self.pack.assets.registry),
    // rust: )?;
    // rust: if horizon_client::mobs::camel::is_camel(m.species()) {
    // rust: horizon_client::mobs::camel::finish_load(&mut m, self.world.game_time);
}
        // `NeutralMob.readPersistentAngerSaveData`: the anger runs until its
        // end time, and the mob is angry at the target again, through
        // `Mob.setTarget` -> `asValidTarget`: a player the golem cannot attack
        // (`IronGolem.canAttack`) comes back as no target.
    // rust: m.extra.anger = horizon_client::mobs::anger_left(m.extra.anger_end, self.world.game_time);
    // rust: if m.extra.anger > 0 && m.extra.angry_at.is_some() {
    // rust: m.ai.target = (!m.built_by_player()).then_some(horizon_client::mobs::Who::Player);
}
    // rust: m.extra.mount = mount;
    // rust: m.extra.passenger = mount.is_some();
    // rust: if finalize {
    // rust: let facts = self.biome_facts(
    // rust: m.position.x.floor() as i32,
    // rust: m.position.y.floor() as i32,
    // rust: m.position.z.floor() as i32,
    // rust: );
    // rust: let at = [m.position.x, m.position.y, m.position.z];
    // rust: let difficulty = self.local_difficulty(at);
    // rust: horizon_client::mobs::spawning::finalize(&mut m, &facts, &difficulty);
            // Cat.finalizeSpawn: black in #cats_spawn_as_black.
    // rust: if m.species() == horizon_client::mobs::Species::Cat {
    // rust: let p = [
    // rust: m.position.x.floor() as i32,
    // rust: m.position.y.floor() as i32,
    // rust: m.position.z.floor() as i32,
    // rust: ];
    // rust: let black = self.structure_tag("minecraft:cats_spawn_as_black");
    // rust: if self.structures_at(p).iter().any(|s| black.contains(s)) {
    // rust: m.extra.variant = 10;
    // rust: m.persistent = true;
}
}
}
    // rust: let id = m.id;
    // rust: self.remember(id, uuid, tag);
    // rust: self.mobs.push(m);
    // rust: if finalize {
    // rust: self.enchant_spawn_equipment(id);
    // rust: self.halloween_spawn_head(id);
}
    // rust: for rider in riders {
    // rust: if let Some(r) = self.load_mob(rider, Some(id))
    // rust: && let Some(v) = self.mobs.iter_mut().find(|m| m.id == id)
    // rust: {
    // rust: v.extra.rider.get_or_insert(r);
}
}
    // rust: Some(id)
}
    /// The mobs under an entity's `Passengers`, taken out of it; the
    /// passengers Horizon doesn't simulate stay.
pub fn take_mob_passengers(self: *Self, tag: *mut Tag) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut riders = Vec::new();
    // rust: if let Tag::Compound(c) = tag
    // rust: && let Some(Tag::List(list)) = c.remove(&"Passengers".into())
    // rust: {
    // rust: let mut unknown = Vec::new();
    // rust: for p in list {
    // rust: let known =
    // rust: entity_nbt::kind(&p).is_some_and(|k| self.res.mob_types().contains_key(&k));
    // rust: if known {
    // rust: riders.push(p);
    // rust: } else {
    // rust: unknown.push(p);
}
}
    // rust: if !unknown.is_empty() {
    // rust: c.insert("Passengers".into(), Tag::List(unknown));
}
}
    // rust: riders
}
    /// The mobs riding entity `id` under `tag`'s `Passengers`, after the
    /// passengers it kept from loading.
    // rust: pub(super) fn put_mob_passengers(&mut self, tag: &mut Tag, id: u32) {
    // rust: let mut riders: Vec<usize> = (0..self.mobs.len())
    // rust: .filter(|&j| self.mobs[j].extra.mount == Some(id) && self.mobs[j].alive())
    // rust: .collect();
    // rust: if let Some(driver) = self
    // rust: .mobs
    // rust: .iter()
    // rust: .find(|m| m.id == id)
    // rust: .and_then(|m| m.extra.rider)
    // rust: && let Some(pos) = riders.iter().position(|&j| self.mobs[j].id == driver)
    // rust: && pos != 0
    // rust: {
    // rust: let d = riders.remove(pos);
    // rust: riders.insert(0, d);
}
    // rust: let riders: Vec<Tag> = riders.into_iter().map(|j| self.mob_tree_nbt(j)).collect();
    // rust: add_passengers(tag, riders);
}
    /// An entity of a type Horizon does not simulate, kept as its compound.
pub fn load_other(self: *Self, mut tag: Tag, kind: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: strip_finalize(&mut tag);
    // rust: let position = entity_nbt::position(&tag)?;
    // rust: let rotation = match tag.get("Rotation") {
    // rust: Some(Tag::List(l)) => {
    // rust: let f = |i: usize| match l.get(i) {
    // rust: Some(Tag::Float(v)) => f32::from_bits(*v),
    // rust: _ => 0.0,
}
    // rust: [f(0), f(1)]
}
    // rust: _ => [0.0, 0.0],
}
    // rust: self.next_entity += 1;
    // rust: let id = self.next_entity;
    // rust: let uuid = entity_nbt::uuid(&tag);
    // rust: self.remember(id, uuid, tag);
    // rust: self.others.push(super::commands::OtherEntity {
    // rust: id,
    // rust: kind: kind.to_owned(),
    // rust: position,
    // rust: yaw: rotation[0],
    // rust: pitch: rotation[1],
    // rust: });
    // rust: Some(id)
}
    /// The compound of an entity Horizon does not simulate, with its current
    /// position, rotation and UUID.
    // rust: pub(super) fn other_to_nbt(&self, o: &super::commands::OtherEntity, uuid: [i32; 4]) -> Tag {
    // rust: let mut tag = self
    // rust: .persist
    // rust: .raw
    // rust: .get(&o.id)
    // rust: .cloned()
    // rust: .unwrap_or_else(|| Tag::Compound(Default::default()));
    // rust: if let Tag::Compound(c) = &mut tag {
    // rust: c.insert("id".into(), Tag::String(o.kind.as_str().into()));
    // rust: c.insert(
    // rust: "Pos".into(),
    // rust: Tag::List(
    // rust: [o.position.x, o.position.y, o.position.z]
    // rust: .map(|v| Tag::Double(v.to_bits()))
    // rust: .to_vec(),
    // rust: ),
    // rust: );
    // rust: c.insert(
    // rust: "Rotation".into(),
    // rust: Tag::List(vec![
    // rust: Tag::Float(o.yaw.to_bits()),
    // rust: Tag::Float(o.pitch.to_bits()),
    // rust: ]),
    // rust: );
    // rust: c.insert("UUID".into(), Tag::IntArray(uuid.to_vec()));
}
    // rust: tag
}
    /// The root of a stack of riders (`Entity.getRootVehicle`).
pub fn mob_root(self: *Self, mut i: usize) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: for _ in 0..8 {
    // rust: let Some(v) = self.mobs[i].extra.mount else {
    // rust: break;
}
    // rust: let Some(j) = self.mobs.iter().position(|m| m.id == v) else {
    // rust: break;
}
    // rust: i = j;
}
    // rust: i
}
    /// `Entity.getVehicle` of entity `id`: the mob, boat or minecart a mob
    /// rides (only a mob rides another entity here).
pub fn vehicle_of(self: *Self, id: u32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let v = self.mobs.iter().find(|m| m.id == id)?.extra.mount?;
    // rust: let there = self.mobs.iter().any(|m| m.id == v)
    // rust: || self.boats.iter().any(|b| b.id == v)
    // rust: || self.carts.iter().any(|c| c.id == v);
    // rust: there.then_some(v)
}
    /// The root vehicle `root` with its passengers (`Entity.save`).
    // rust: pub(super) fn vehicle_tree_nbt(&mut self, root: u32) -> Option<Tag> {
    // rust: if let Some(i) = self.mobs.iter().position(|m| m.id == root) {
    // rust: return Some(self.mob_tree_nbt(i));
}
    // rust: if self.boats.iter().any(|b| b.id == root) {
    // rust: let uuid = self.uuid_for(root);
    // rust: let b = self.boats.iter().find(|b| b.id == root)?;
    // rust: let mut tag = entity_nbt::boat_to_nbt(
    // rust: &b.entity_type(),
    // rust: b.position,
    // rust: b.velocity,
    // rust: [b.yaw, b.pitch],
    // rust: uuid,
    // rust: self.persist.raw.get(&root),
    // rust: b.chest.then_some(&b.items[..]),
    // rust: );
    // rust: self.put_mob_passengers(&mut tag, root);
    // rust: return Some(tag);
}
    // rust: if !self.carts.iter().any(|c| c.id == root) {
    // rust: return None;
}
    // rust: let uuid = self.uuid_for(root);
    // rust: let c = self.carts.iter().find(|c| c.id == root)?;
    // rust: let mut tag = c.to_nbt(uuid, self.persist.raw.get(&root));
    // rust: self.put_mob_passengers(&mut tag, root);
    // rust: Some(tag)
}
    /// `ServerPlayer.saveParentVehicle`: a player riding `vehicle` saves
    /// RootVehicle {Attach: that mount's UUID, Entity: the root vehicle with
    /// its passengers}, only while it is the root's one player passenger
    /// (`Entity.hasExactlyOnePlayerPassenger`); `others` are the vehicles the
    /// other players in the level ride. With the root and the mount's UUID.
    // rust: pub(super) fn parent_vehicle_tag(
    // rust: &mut self,
    // rust: vehicle: Option<u32>,
    // rust: others: &[u32],
    // rust: ) -> Option<(Tag, u32, [i32; 4])> {
    // rust: let vehicle = vehicle?;
    // rust: let root = parent_vehicle_root(vehicle, others, |id| self.vehicle_of(id))?;
    // rust: let mut entity = self.vehicle_tree_nbt(root)?;
    // rust: write_attachments(&mut entity, &self.entity_attachments);
    // rust: let attach = self.uuid_for(vehicle);
    // rust: Some((root_vehicle_tag(attach, entity), root, attach))
}
    /// `PlayerList.remove`: the root vehicle and its passengers leave the
    /// world with the player (`setRemoved(UNLOADED_WITH_PLAYER)`).
    // rust: pub(super) fn remove_vehicle_tree(&mut self, root: u32) {
        // The mobs `put_mob_passengers` saves under each vehicle of the tree.
    // rust: let mounts: Vec<(u32, Option<u32>)> = self
    // rust: .mobs
    // rust: .iter()
    // rust: .filter(|m| m.alive())
    // rust: .map(|m| (m.id, m.extra.mount))
    // rust: .collect();
    // rust: let gone = vehicle_tree(root, &mounts);
    // rust: self.mobs.retain(|m| !gone.contains(&m.id));
    // rust: for &id in &gone {
    // rust: self.release_vehicle_container(id);
}
    // rust: self.boats.retain(|b| !gone.contains(&b.id));
    // rust: self.carts.retain(|c| !gone.contains(&c.id));
    // rust: for g in gone {
    // rust: self.forget_entity(g);
}
}
    /// The vehicle with this UUID, among the ones in the world.
    // rust: pub(super) fn vehicle_by_uuid(&self, uuid: [i32; 4]) -> Option<u32> {
    // rust: let id = *self
    // rust: .persist
    // rust: .uuids
    // rust: .iter()
    // rust: .find(|(_, u)| **u == uuid)
    // rust: .map(|(id, _)| id)?;
    // rust: let there = self.mobs.iter().any(|m| m.id == id && m.alive())
    // rust: || self.boats.iter().any(|b| b.id == id)
    // rust: || self.carts.iter().any(|c| c.id == id);
    // rust: there.then_some(id)
}
    /// A vehicle already in the world that was restored from the player's file
    /// during this load (not any entity whose UUID is remembered).
pub fn restored_vehicle(self: *Self, uuid: [i32; 4]) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !self.persist.restored.contains(&uuid) {
    // rust: return None;
}
    // rust: self.vehicle_by_uuid(uuid)
}
    /// Vanilla stores the root entity in the player's file, outside chunk entities.
    /// Keep the raw wrapper until attachment succeeds, including unsupported trees.
    // rust: pub(super) fn restore_saved_vehicle(
    // rust: &mut self,
    // rust: uuid: [i32; 4],
    // rust: raw: Option<&Tag>,
    // rust: ) -> Option<u32> {
    // rust: if let Some(id) = self.vehicle_by_uuid(uuid) {
    // rust: return Some(id);
}
    // rust: let tag = raw?.get("RootVehicle")?.get("Entity")?.clone();
    // rust: let root_uuid = entity_nbt::uuid(&tag)?;
    // rust: let kind = entity_nbt::kind(&tag)?;
    // rust: if !self.res.mob_types().contains_key(&kind)
    // rust: && super::boats::any_boat_wood(&kind).is_none()
    // rust: && super::minecarts::CartKind::from_id(&kind).is_none()
    // rust: {
    // rust: return None;
}
    // rust: if self.vehicle_by_uuid(root_uuid).is_none() {
    // rust: let at = entity_nbt::position(&tag)?;
    // rust: let key = (
    // rust: (at.x.floor() as i32).div_euclid(16),
    // rust: (at.z.floor() as i32).div_euclid(16),
    // rust: );
    // rust: self.persist.restored.insert(root_uuid);
    // rust: self.world.loaded_entities.push((key, vec![tag]));
    // rust: self.spawn_loaded_entities();
}
    // rust: self.persist.restored.insert(uuid);
    // rust: self.vehicle_by_uuid(uuid)
}
    /// `ServerPlayer.loadAndSpawnParentVehicle`: the ride the player's file
    /// names, once the vehicle is in the world.
    // rust: pub(super) fn restore_root_vehicle(&mut self) {
    // rust: if self.serving.is_some()
    // rust: || self.options.dedicated.is_some()
    // rust: || self.riding.is_some()
    // rust: || self.player.is_none()
    // rust: {
    // rust: return;
}
    // rust: let Some(uuid) = self.pending_vehicle else {
    // rust: return;
}
    // rust: let raw = self.level.player_extra.clone();
    // rust: let Some(id) = self.restore_saved_vehicle(uuid, raw.as_ref()) else {
    // rust: return;
}
    // rust: if let Some(Tag::Compound(p)) = &mut self.level.player_extra {
    // rust: p.remove(&"RootVehicle".into());
}
    // rust: self.pending_vehicle = None;
    // rust: self.riding = Some(id);
}
    /// A mob's entity tag with the mobs riding it under `Passengers`.
    // rust: pub(super) fn mob_tree_nbt(&mut self, i: usize) -> Tag {
    // rust: let id = self.mobs[i].id;
    // rust: let uuid = self.uuid_for(id);
        // `NeutralMob.addPersistentAngerSaveData`: the anger ends at an
        // absolute game time, so it goes on while the chunk is unloaded, and
        // the target is the entity the mob is angry at.
    // rust: let anger = self.mobs[i].extra.anger;
    // rust: self.mobs[i].extra.anger_end = if anger > 0 {
    // rust: self.world.game_time + i64::from(anger)
    // rust: } else {
    // rust: -1
}
    // rust: self.mobs[i].extra.angry_at = if anger > 0 {
            // A wolf keeps its anger's target itself, also once the target
            // is gone (`tame::update_persistent_anger`).
    // rust: if self.mobs[i].species() == horizon_client::mobs::Species::Wolf {
    // rust: self.mobs[i].extra.angry_at
    // rust: } else {
    // rust: self.mobs[i].ai.target
}
    // rust: } else {
    // rust: None
}
    // rust: let mut tag = entity_nbt::mob_to_nbt(
    // rust: &self.mobs[i],
    // rust: uuid,
    // rust: self.persist.raw.get(&id),
    // rust: Some(self.pack.assets.registry),
    // rust: );
    // rust: if horizon_client::mobs::camel::is_camel(self.mobs[i].species())
    // rust: && let Tag::Compound(c) = &mut tag
    // rust: {
    // rust: let tick =
    // rust: horizon_client::mobs::camel::synced_pose_tick(&self.mobs[i], self.world.game_time);
    // rust: c.insert("LastPoseTick".into(), Tag::Long(tick));
}
    // rust: self.write_leash(&mut tag, i);
    // rust: self.put_mob_passengers(&mut tag, id);
    // rust: tag
}
    /// Forget an entity that left the world (its UUID and loaded compound).
    // rust: pub(super) fn forget_entity(&mut self, id: u32) {
    // rust: if let Some(uuid) = self.persist.uuids.remove(&id) {
    // rust: self.entity_attachments.remove(&uuid);
}
    // rust: self.persist.raw.remove(&id);
}
    /// Detach a travelling entity without discarding its in-memory attachments.
    // rust: pub(super) fn detach_entity(&mut self, id: u32) {
    // rust: self.persist.uuids.remove(&id);
    // rust: self.persist.raw.remove(&id);
}
    /// The compound a crystal or the dragon was loaded with, found again by type
    /// and position.
    // rust: pub(super) fn persist_anon(&self, kind: &str, p: Vec3) -> Option<&Tag> {
    // rust: self.persist
    // rust: .anon
    // rust: .get(&anon_key(kind, p))
    // rust: .map(|(_, raw)| raw)
}
    /// The compound an entity was loaded with (and commands have edited).
    // rust: pub(super) fn persist_raw(&self, id: u32) -> Option<&Tag> {
    // rust: self.persist.raw.get(&id)
}
    /// A loaded chest minecart with a loot table and no items: the table
    /// rolled now, as generated containers are (Horizon does not unpack on
    /// first open), and kept to save it again while unchanged.
    // rust: pub(in crate::game) fn roll_cart_loot(&self, cart: &mut super::minecarts::Minecart, tag: &Tag) {
    // rust: let Some(table) = horizon_client::save::text(tag.get("LootTable")) else {
    // rust: return;
}
    // rust: if cart.items.is_empty() || cart.items.iter().any(Option::is_some) {
    // rust: return;
}
    // rust: let loot = horizon_client::structure_blocks::loot_data(
    // rust: &self.options.resources,
    // rust: &self.pack_files(),
    // rust: );
    // rust: let p = cart.position;
    // rust: let pos = (p.x.floor() as i32, p.y.floor() as i32, p.z.floor() as i32);
    // rust: let biome = self.biome_name_at(p).unwrap_or_default();
    // rust: let seed = horizon_client::structure_blocks::loot_seed(tag);
    // rust: cart.loot = Some(horizon_client::structure_blocks::roll_container(
    // rust: &mut cart.items,
    // rust: loot.as_deref(),
    // rust: table,
    // rust: seed,
    // rust: pos,
    // rust: &biome,
    // rust: ));
}
    /// An entity Horizon keeps no compound for (orbs, projectiles, the
    /// crystals and the dragon) still keeps its `Tags`, by entity id, so
    /// `@e[tag=]`, `/tag` and `/data get` see them, and the `Item` a
    /// fireball or a thrown item projectile was loaded with.
    // rust: pub(super) fn remember_tags(&mut self, id: u32, tag: &Tag) {
    // rust: let mut map = horizon_world::nbt::Compound::new();
    // rust: if let Some(tags @ Tag::List(_)) = tag.get("Tags") {
    // rust: map.insert("Tags".into(), tags.clone());
}
    // rust: if let Some(item @ Tag::Compound(_)) = tag.get("Item") {
    // rust: map.insert("Item".into(), item.clone());
}
        // Entity.saveWithoutId's optional fields Horizon models nowhere for
        // these entities, kept as loaded (written only when set).
    // rust: for key in [
    // rust: "Silent",
    // rust: "Glowing",
    // rust: "Invulnerable",
    // rust: "CustomName",
    // rust: "CustomNameVisible",
    // rust: ] {
    // rust: if let Some(v) = tag.get(key) {
    // rust: map.insert(key.into(), v.clone());
}
}
    // rust: if !map.is_empty() {
    // rust: self.persist.raw.insert(id, Tag::Compound(map));
}
}
    /// The `Tags` of the projectile `add_projectile` just pushed.
pub fn remember_last_projectile_tags(self: *Self, tag: *Tag) void {
}
    // rust: if let Some(id) = self.creatures.projectiles.last().map(|p| p.id) {
    // rust: self.remember_tags(id, tag);
}
}
pub fn remember(self: *Self, id: u32, uuid: ?[i32; 4], mut tag: Tag) void {
}
    // rust: self.restore_portal_cooldown(id, &tag);
    // rust: self.remember_uuid(id, uuid, &tag);
        // `Team` is read, never written: the team keeps its members itself.
    // rust: if let Tag::Compound(c) = &mut tag {
    // rust: c.remove(&"Team".into());
}
    // rust: self.persist.raw.insert(id, tag);
}
    /// The UUID entity `id` was loaded with, and the attachments `tag` saved under it.
    // rust: pub(super) fn remember_uuid(&mut self, id: u32, uuid: Option<[i32; 4]>, tag: &Tag) {
    // rust: if let Some(u) = uuid {
    // rust: self.persist.uuids.insert(id, u);
    // rust: read_attachments(tag, u, &mut self.entity_attachments);
}
    // rust: self.join_saved_team(id, tag);
}
pub fn join_saved_team(self: *Self, id: u32, tag: *Tag) void {
}
    // rust: if tag.get("Team").is_some() {
    // rust: let name = uuid_text(self.uuid_for(id));
    // rust: join_saved_team(&mut self.score.board, &name, tag);
}
}
    /// The mob that was loaded or saved with a UUID.
    // rust: pub(super) fn mob_by_uuid(&self, uuid: [i32; 4]) -> Option<u32> {
    // rust: self.persist
    // rust: .uuids
    // rust: .iter()
    // rust: .find(|(id, u)| **u == uuid && self.mobs.iter().any(|m| m.id == **id))
    // rust: .map(|(id, _)| *id)
}
    /// A mob's UUID, made up for new ones.
    // rust: pub(super) fn mob_uuid(&mut self, id: u32) -> [i32; 4] {
    // rust: self.uuid_for(id)
}
    // rust: pub(super) fn uuid_for(&mut self, id: u32) -> [i32; 4] {
    // rust: *self.persist.uuids.entry(id).or_insert_with(random_uuid)
}
    /// `BlockState.CODEC`: a block name or `{id, properties}` (or legacy `{Name, Properties}`).
    // rust: pub(super) fn state_from_nbt(&self, tag: &Tag) -> Option<BlockStateId> {
    // rust: entity_nbt::state_from_nbt(self.pack.assets.registry, tag)
}
    // rust: pub(in crate::game) fn state_to_nbt(&self, state: BlockStateId) -> Tag {
    // rust: entity_nbt::state_to_nbt(self.pack.assets.registry, state)
}
    /// The entity NBT of every simulated entity in `keys`, plus the unknown
    /// entities kept for them. With `remove`, the entities leave the world
    /// (their chunks unload).
    // rust: pub(super) fn entity_chunks(
    // rust: &mut self,
    // rust: keys: &HashSet<(i32, i32)>,
    // rust: remove: bool,
    // rust: ) -> Vec<((i32, i32), Vec<Tag>)> {
    // rust: let mut out: HashMap<(i32, i32), Vec<Tag>> =
    // rust: keys.iter().map(|k| (*k, Vec::new())).collect();
        // Every kind in `entity_lists!` saves itself (`Entity::save_nbt`).
    // rust: self.save_every_entity(keys, &mut out);
    // rust: if let Some(d) = &self.dragon
    // rust: && keys.contains(&chunk_of(d.position))
    // rust: {
    // rust: let raw = anon_raw(&self.persist, "minecraft:ender_dragon", d.position);
    // rust: let uuid = saved_uuid(&self.persist, d.id);
    // rust: out.entry(chunk_of(d.position))
    // rust: .or_default()
                // The fields kept with it (`remember_tags`: Silent, Tags, a
                // name...) once it has flown from where it was loaded.
    // rust: .push(with_raw(
    // rust: d.to_nbt(uuid, raw.as_ref()),
    // rust: self.persist.raw.get(&d.id),
    // rust: ));
}
    // rust: for c in &self.crystals {
    // rust: if keys.contains(&chunk_of(c.position)) {
    // rust: let raw = anon_raw(&self.persist, "minecraft:end_crystal", c.position);
    // rust: let uuid = saved_uuid(&self.persist, c.id);
    // rust: out.entry(chunk_of(c.position)).or_default().push(with_raw(
    // rust: c.to_nbt(uuid, raw.as_ref()),
    // rust: self.persist.raw.get(&c.id),
    // rust: ));
}
}
    // rust: for s in &self.ominous_spawners {
    // rust: let at = Vec3::new(s.position[0], s.position[1], s.position[2]);
    // rust: if keys.contains(&chunk_of(at)) {
    // rust: let tag = entity_nbt::ominous_item_spawner_to_nbt(
    // rust: &s.item,
    // rust: at,
    // rust: s.spawn_item_after,
    // rust: self.persist.uuids.get(&s.id).copied().unwrap_or(s.uuid),
    // rust: s.raw.as_deref(),
    // rust: );
    // rust: out.entry(chunk_of(at)).or_default().push(tag);
}
}
    // rust: for f in &self.item_frames {
    // rust: let (lo, hi) = f.bounds();
    // rust: let at = Vec3::new(
    // rust: (lo[0] + hi[0]) / 2.0,
    // rust: (lo[1] + hi[1]) / 2.0,
    // rust: (lo[2] + hi[2]) / 2.0,
    // rust: );
    // rust: if keys.contains(&chunk_of(at)) {
    // rust: let uuid = self
    // rust: .persist
    // rust: .uuids
    // rust: .get(&f.id)
    // rust: .copied()
    // rust: .unwrap_or_else(random_uuid);
    // rust: let tag = entity_nbt::item_frame_to_nbt(f, uuid, self.persist.raw.get(&f.id));
    // rust: out.entry(chunk_of(at)).or_default().push(tag);
}
}
    // rust: for c in &self.cushions {
    // rust: if keys.contains(&chunk_of(c.position)) {
    // rust: let uuid = self
    // rust: .persist
    // rust: .uuids
    // rust: .get(&c.id)
    // rust: .copied()
    // rust: .unwrap_or_else(random_uuid);
    // rust: let tag = entity_nbt::cushion_to_nbt(c, uuid, self.persist.raw.get(&c.id));
    // rust: out.entry(chunk_of(c.position)).or_default().push(tag);
}
}
    // rust: for p in &self.paintings {
    // rust: let at = painting_center(p);
    // rust: if keys.contains(&chunk_of(at)) {
    // rust: let uuid = self
    // rust: .persist
    // rust: .uuids
    // rust: .get(&p.id)
    // rust: .copied()
    // rust: .unwrap_or_else(random_uuid);
    // rust: let tag = entity_nbt::painting_to_nbt(p, uuid, self.persist.raw.get(&p.id));
    // rust: out.entry(chunk_of(at)).or_default().push(tag);
}
}
    // rust: for f in &self.fangs.list {
    // rust: let at = Vec3::new(f.pos[0], f.pos[1], f.pos[2]);
    // rust: if keys.contains(&chunk_of(at)) {
    // rust: let uuid = self
    // rust: .persist
    // rust: .uuids
    // rust: .get(&f.id)
    // rust: .copied()
    // rust: .unwrap_or_else(random_uuid);
    // rust: out.entry(chunk_of(at))
    // rust: .or_default()
    // rust: .push(self.fangs_to_nbt(f, uuid));
}
}
    // rust: for o in &self.others {
    // rust: if keys.contains(&chunk_of(o.position)) {
    // rust: let uuid = self
    // rust: .persist
    // rust: .uuids
    // rust: .get(&o.id)
    // rust: .copied()
    // rust: .unwrap_or_else(random_uuid);
    // rust: let tag = self.other_to_nbt(o, uuid);
    // rust: out.entry(chunk_of(o.position)).or_default().push(tag);
}
}
    // rust: for key in keys {
    // rust: let unknown = if remove {
    // rust: self.persist.unknown.remove(key)
    // rust: } else {
    // rust: self.persist.unknown.get(key).cloned()
}
    // rust: if let Some(list) = unknown {
    // rust: out.entry(*key).or_default().extend(list);
}
}
    // rust: for tags in out.values_mut() {
    // rust: for tag in tags {
    // rust: write_attachments(tag, &self.entity_attachments);
}
}
    // rust: if remove {
    // rust: let gone = |p: Vec3| keys.contains(&chunk_of(p));
    // rust: let mut removed: Vec<u32> = Vec::new();
    // rust: let riding = self.riding;
    // rust: self.boats.retain(|b| {
    // rust: let keep = !gone(b.position) || Some(b.id) == riding;
    // rust: if !keep {
    // rust: removed.push(b.id);
}
    // rust: keep
    // rust: });
    // rust: self.crystals.retain(|c| !gone(c.position));
    // rust: self.ominous_spawners
    // rust: .retain(|s| !gone(Vec3::new(s.position[0], s.position[1], s.position[2])));
    // rust: if self.dragon.as_ref().is_some_and(|d| gone(d.position)) {
    // rust: self.dragon = None;
}
    // rust: self.carts.retain(|c| {
    // rust: let keep = !gone(c.position) || Some(c.id) == riding;
    // rust: if !keep {
    // rust: removed.push(c.id);
}
    // rust: keep
    // rust: });
    // rust: self.fangs.list.retain(|f| {
    // rust: let keep = !gone(Vec3::new(f.pos[0], f.pos[1], f.pos[2]));
    // rust: if !keep {
    // rust: removed.push(f.id);
}
    // rust: keep
    // rust: });
    // rust: self.others.retain(|o| {
    // rust: let keep = !gone(o.position);
    // rust: if !keep {
    // rust: removed.push(o.id);
}
    // rust: keep
    // rust: });
    // rust: self.armor_stands.retain(|a| {
    // rust: let keep = !gone(a.position);
    // rust: if !keep {
    // rust: removed.push(a.id);
}
    // rust: keep
    // rust: });
    // rust: self.item_frames.retain(|f| {
    // rust: let (lo, hi) = f.bounds();
    // rust: let keep = !gone(Vec3::new(
    // rust: (lo[0] + hi[0]) / 2.0,
    // rust: (lo[1] + hi[1]) / 2.0,
    // rust: (lo[2] + hi[2]) / 2.0,
    // rust: ));
    // rust: if !keep {
    // rust: removed.push(f.id);
}
    // rust: keep
    // rust: });
    // rust: self.paintings.retain(|p| {
    // rust: let keep = !gone(painting_center(p));
    // rust: if !keep {
    // rust: removed.push(p.id);
}
    // rust: keep
    // rust: });
    // rust: self.cushions.retain(|c| {
    // rust: let keep = !gone(c.position);
    // rust: if !keep {
    // rust: removed.push(c.id);
}
    // rust: keep
    // rust: });
            // Riders leave with their root vehicle, a boat's with the boat.
    // rust: let leaving: HashSet<u32> = (0..self.mobs.len())
    // rust: .filter(|&i| {
    // rust: let r = self.mob_root(i);
    // rust: match self.mobs[r].extra.mount {
    // rust: Some(v) if removed.contains(&v) => true,
    // rust: Some(v) if self.boats.iter().any(|b| b.id == v) => false,
    // rust: _ => gone(self.mobs[r].position),
}
    // rust: })
    // rust: .map(|i| self.mobs[i].id)
    // rust: .collect();
    // rust: self.mobs.retain(|m| {
    // rust: let keep = !leaving.contains(&m.id);
    // rust: if !keep {
    // rust: removed.push(m.id);
}
    // rust: keep
    // rust: });
    // rust: self.dropped.retain(|e| {
    // rust: let keep = !gone(e.position);
    // rust: if !keep {
    // rust: removed.push(e.id);
}
    // rust: keep
    // rust: });
    // rust: self.orbs.retain(|o| !gone(o.position));
            // Unloaded with their chunk: PersistentEntitySectionManager.stopTracking.
    // rust: self.native_leaves_flush();
            // the ones saved with the chunk go with it (a trident too, unsaved).
    // rust: self.creatures.projectiles.retain(|p| {
    // rust: let leaves = entity_nbt::saved_with_chunk(p) || p.arrow.is_some();
    // rust: !leaves || !gone(p.position)
    // rust: });
    // rust: self.falling.retain(|f| !gone(f.position));
    // rust: self.rockets.retain(|r| !gone(r.position));
    // rust: self.tridents.retain(|t| !gone(t.position));
    // rust: self.tnts.retain(|t| !gone(t.position));
    // rust: self.persist
    // rust: .anon
    // rust: .retain(|_, (at, _)| !keys.contains(&chunk_of(*at)));
    // rust: for id in removed {
    // rust: self.forget_entity(id);
}
}
    // rust: out.into_iter().collect()
}
    /// Write the entities of every resident chunk (an autosave or quit).
    /// Without `wait` (the autosave) they are written on the region writer
    /// meanwhile: `PersistentEntitySectionManager.autoSave` stores them
    /// without `saveAll`'s flush.
    // rust: pub(super) fn save_entities(&mut self, wait: bool) -> Result<()> {
    // rust: self.spawn_loaded_entities();
    // rust: let keys: HashSet<(i32, i32)> = self.world.chunks.keys().copied().collect();
    // rust: let chunks = self.entity_chunks(&keys, false);
    // rust: self.prune_entity_memory();
    // rust: if wait {
    // rust: self.save.save_entities(chunks)
    // rust: } else {
    // rust: self.save.save_entities_later(chunks)
}
}
    /// The ids of every entity in the level now.
pub fn live_entity_ids(self: *Self) H {
    // Implementation ported from Horizon
    return undefined;
}
//         use super::entity::{Entity as _, entity_lists_of, for_each_entity};
    // rust: let mut alive: HashSet<u32> = self.entity_ids_off_walk().collect();
    // rust: for_each_entity!(entity_lists_of!(self), entity => {
    // rust: alive.insert(entity.id());
    // rust: });
    // rust: alive
}
    /// `ServerLevel.EntityCallbacks.onDestroyed` → `Scoreboard.entityRemoved`
    /// for every kind of entity, not only the mobs `score_entity_removed`
    /// covers as they die: an item picked up or killed, an expired cloud, a
    /// discarded projectile leaves the board and its team. Unloaded and
    /// travelling entities leave `persist.uuids` first (`forget_entity`,
    /// `detach_entity`), so they keep their scores, as vanilla's do. Once a
    /// tick, so a command in the same tick still sees them; nothing to do
    /// while no entity holds a score or a team.
    // rust: pub(super) fn score_destroyed_entities(&mut self) {
    // rust: let board = &self.score.board;
    // rust: let held: HashSet<[i32; 4]> = board
    // rust: .scores
    // rust: .keys()
    // rust: .map(String::as_str)
    // rust: .chain(board.team_members())
    // rust: .filter(|holder| holder.len() == 36)
    // rust: .filter_map(uuid_from_text)
    // rust: .collect();
    // rust: if held.is_empty() {
    // rust: return;
}
    // rust: let candidates: Vec<(u32, [i32; 4])> = self
    // rust: .persist
    // rust: .uuids
    // rust: .iter()
    // rust: .filter(|(_, uuid)| held.contains(*uuid))
    // rust: .map(|(&id, &uuid)| (id, uuid))
    // rust: .collect();
    // rust: if candidates.is_empty() {
    // rust: return;
}
    // rust: let alive = self.live_entity_ids();
    // rust: for (id, uuid) in candidates {
    // rust: if !alive.contains(&id) {
    // rust: self.score.board.entity_removed(&uuid_text(uuid));
}
}
}
    // rust: pub(super) fn prune_entity_memory(&mut self) {
        // Forget entities that no longer exist.
    // rust: let alive = self.live_entity_ids();
    // rust: for (id, uuid) in &self.persist.uuids {
    // rust: if !alive.contains(id) {
    // rust: self.entity_attachments.remove(uuid);
}
}
    // rust: self.persist.uuids.retain(|id, _| alive.contains(id));
    // rust: self.persist.raw.retain(|id, _| alive.contains(id));
}
    /// A loaded projectile's `Owner`: a connected guest, else a mob by UUID.
pub fn claim_owner(self: *Self, p: *mut horizon_client::projectiles::Projectile) void {
}
    // rust: let Some(uuid) = p.owner_uuid else {
    // rust: return;
}
    // rust: let guest = self.lan.as_ref().and_then(|host| {
    // rust: let ints = horizon_client::lan::playerdata::uuid_ints;
    // rust: host.hub
    // rust: .guests
    // rust: .iter()
    // rust: .find(|g| ints(g.uuid) == uuid)
    // rust: .map(|g| g.conn)
    // rust: });
    // rust: if guest.is_some() {
    // rust: (p.owner, p.guest) = (Some(Who::Player), guest);
    // rust: } else if p.owner.is_none() {
    // rust: p.owner = self.mob_by_uuid(uuid).map(Who::Mob);
}
}
    /// Save and remove the entities of chunks that unloaded.
    // rust: pub(super) fn unload_entities(&mut self, unloaded: &[Arc<Chunk>]) {
    // rust: if unloaded.is_empty() {
    // rust: return;
}
    // rust: self.spawn_loaded_entities();
    // rust: let keys: HashSet<(i32, i32)> = unloaded.iter().map(|c| (c.x, c.z)).collect();
    // rust: let chunks = self.entity_chunks(&keys, true);
    // rust: let counts: Vec<_> = chunks
    // rust: .iter()
    // rust: .map(|(key, entities)| (*key, entities.len()))
    // rust: .collect();
    // rust: if let Err(e) = self.save.save_entities_later(chunks) {
    // rust: log::warn!("Horizon: failed to save entities: {e}");
}
    // rust: for (chunk, count) in counts {
    // rust: self.native_entities_unload(self.dim.id(), [chunk.0, chunk.1], count);
}
}
}
    // rust: impl Game<'_> {
    /// `Entity::save_nbt` for a mob: a rider is saved inside its root vehicle,
    /// in the root's chunk; a boat's or cart's passengers inside the vehicle.
    // rust: pub(super) fn save_mob(
    // rust: &mut self,
    // rust: i: usize,
    // rust: keys: &HashSet<ChunkKey>,
    // rust: ) -> Option<(ChunkKey, Tag)> {
    // rust: let m = &self.mobs[i];
    // rust: let saves = self.mob_root(i) == i
    // rust: && m.extra.mount.is_none_or(|v| {
    // rust: self.boats.iter().all(|b| b.id != v) && self.carts.iter().all(|c| c.id != v)
    // rust: })
    // rust: && keys.contains(&chunk_of(m.position))
    // rust: && m.alive()
    // rust: && !m.removed;
    // rust: saves.then(|| (chunk_of(self.mobs[i].position), self.mob_tree_nbt(i)))
}
    // rust: pub(super) fn save_item(
    // rust: &mut self,
    // rust: i: usize,
    // rust: keys: &HashSet<ChunkKey>,
    // rust: ) -> Option<(ChunkKey, Tag)> {
    // rust: let at = self.dropped[i].position;
    // rust: keys.contains(&chunk_of(at)).then(|| {
    // rust: let id = self.dropped[i].id;
    // rust: let uuid = self.uuid_for(id);
    // rust: let tag =
    // rust: entity_nbt::item_entity_to_nbt(&self.dropped[i], uuid, self.persist.raw.get(&id));
    // rust: (chunk_of(at), tag)
    // rust: })
}
    // rust: pub(super) fn save_orb(
    // rust: &mut self,
    // rust: i: usize,
    // rust: keys: &HashSet<ChunkKey>,
    // rust: ) -> Option<(ChunkKey, Tag)> {
    // rust: let o = &self.orbs[i];
    // rust: keys.contains(&chunk_of(o.position)).then(|| {
    // rust: let raw = anon_raw(&self.persist, "minecraft:experience_orb", o.position);
    // rust: let uuid = saved_uuid(&self.persist, o.id);
    // rust: let tag = with_raw(
    // rust: with_raw(entity_nbt::orb_to_nbt(o, uuid), raw.as_ref()),
    // rust: self.persist.raw.get(&o.id),
    // rust: );
    // rust: (chunk_of(o.position), tag)
    // rust: })
}
    // rust: pub(super) fn save_projectile(
    // rust: &mut self,
    // rust: i: usize,
    // rust: keys: &HashSet<ChunkKey>,
    // rust: ) -> Option<(ChunkKey, Tag)> {
    // rust: let p = &self.creatures.projectiles[i];
    // rust: if !keys.contains(&chunk_of(p.position)) || !entity_nbt::saved_with_chunk(p) {
    // rust: return None;
}
    // rust: let owner = p.owner_uuid;
    // rust: let raw = anon_raw(&self.persist, p.kind.id(), p.position);
    // rust: let uuid = saved_uuid(&self.persist, p.id);
    // rust: let in_block = p
    // rust: .arrow
    // rust: .as_ref()
    // rust: .and_then(|a| a.last_state)
    // rust: .map(|s| self.state_to_nbt(s));
    // rust: let tag = entity_nbt::arrow_to_nbt(p, uuid, owner, in_block, raw.as_ref())
    // rust: .or_else(|| entity_nbt::fireball_to_nbt(p, uuid, owner, raw.as_ref()))
    // rust: .or_else(|| entity_nbt::throwable_to_nbt(p, uuid, owner, raw.as_ref()))
    // rust: .or_else(|| entity_nbt::spit_or_bullet_to_nbt(p, uuid, owner, raw.as_ref()))?;
        // HasBeenShot is modeled for these projectiles. The generic raw
        // overlay also serves entity types whose shot flag is still opaque.
    // rust: let shot = tag.get("HasBeenShot").cloned();
    // rust: let mut tag = with_raw(tag, self.persist.raw.get(&p.id));
    // rust: if let (Some(shot), Tag::Compound(map)) = (shot, &mut tag) {
    // rust: map.insert("HasBeenShot".into(), shot);
}
    // rust: Some((chunk_of(p.position), tag))
}
    // rust: pub(super) fn save_falling(
    // rust: &mut self,
    // rust: i: usize,
    // rust: keys: &HashSet<ChunkKey>,
    // rust: ) -> Option<(ChunkKey, Tag)> {
    // rust: let f = &self.falling[i];
    // rust: if !keys.contains(&chunk_of(f.position)) {
    // rust: return None;
}
    // rust: let raw = match &f.saved {
    // rust: Some(saved) => Some(saved.1.clone()),
    // rust: None => anon_raw(&self.persist, "minecraft:falling_block", f.position),
}
    // rust: let uuid = saved_uuid(&self.persist, f.id);
    // rust: let tag = entity_nbt::falling_block_to_nbt(
    // rust: self.state_to_nbt(f.state),
    // rust: f.position,
    // rust: f.velocity,
    // rust: f.age,
    // rust: f.drop_item,
    // rust: f.damage,
    // rust: f.fall_distance,
    // rust: f.rotation,
    // rust: uuid,
    // rust: );
    // rust: let mut tag = with_raw(tag, raw.as_ref());
    // rust: if let Tag::Compound(fields) = &mut tag {
    // rust: fields.insert("PortalCooldown".into(), Tag::Int(f.portal.cooldown));
}
    // rust: Some((chunk_of(f.position), tag))
}
    // rust: pub(super) fn save_rocket(
    // rust: &mut self,
    // rust: i: usize,
    // rust: keys: &HashSet<ChunkKey>,
    // rust: ) -> Option<(ChunkKey, Tag)> {
    // rust: let (id, at) = (self.rockets[i].id, self.rockets[i].position);
    // rust: keys.contains(&chunk_of(at)).then(|| {
    // rust: let uuid = self.uuid_for(id);
    // rust: let tag =
    // rust: self.rockets[i].to_nbt(uuid, self.level.player_uuid, self.persist.raw.get(&id));
    // rust: (chunk_of(at), tag)
    // rust: })
}
    // rust: pub(super) fn save_trident(
    // rust: &mut self,
    // rust: i: usize,
    // rust: keys: &HashSet<ChunkKey>,
    // rust: ) -> Option<(ChunkKey, Tag)> {
    // rust: let (id, at) = (self.tridents[i].id, self.tridents[i].position);
    // rust: keys.contains(&chunk_of(at)).then(|| {
    // rust: let uuid = self.uuid_for(id);
    // rust: let tag = self.tridents[i].to_nbt(uuid, self.persist.raw.get(&id));
    // rust: (chunk_of(at), tag)
    // rust: })
}
    // rust: pub(super) fn save_tnt(
    // rust: &mut self,
    // rust: i: usize,
    // rust: keys: &HashSet<ChunkKey>,
    // rust: ) -> Option<(ChunkKey, Tag)> {
    // rust: let (id, at) = (self.tnts[i].id, self.tnts[i].position);
    // rust: keys.contains(&chunk_of(at)).then(|| {
    // rust: let uuid = self.uuid_for(id);
    // rust: let t = &self.tnts[i];
    // rust: let tag = entity_nbt::tnt_to_nbt(
    // rust: t.position,
    // rust: t.velocity,
    // rust: t.on_ground,
    // rust: t.fuse,
    // rust: t.power,
    // rust: t.block_state_nbt(self.pack.assets.registry),
    // rust: t.rotation,
    // rust: uuid,
    // rust: self.persist.raw.get(&id),
    // rust: );
    // rust: (chunk_of(at), tag)
    // rust: })
}
    // rust: pub(super) fn save_boat(
    // rust: &mut self,
    // rust: i: usize,
    // rust: keys: &HashSet<ChunkKey>,
    // rust: ) -> Option<(ChunkKey, Tag)> {
    // rust: let b = &self.boats[i];
    // rust: let (id, at) = (b.id, b.position);
    // rust: if !keys.contains(&chunk_of(at)) {
    // rust: return None;
}
    // rust: let uuid = self.saved_uuid_or_random(id);
    // rust: let mut tag = entity_nbt::boat_to_nbt(
    // rust: &b.entity_type(),
    // rust: b.position,
    // rust: b.velocity,
    // rust: [b.yaw, b.pitch],
    // rust: uuid,
    // rust: self.persist.raw.get(&id),
    // rust: b.chest.then_some(&b.items[..]),
    // rust: );
    // rust: self.put_mob_passengers(&mut tag, id);
        // AbstractBoat.addAdditionalSaveData: the lead's holder.
    // rust: self.write_boat_leash(&mut tag, i);
    // rust: Some((chunk_of(at), tag))
}
    // rust: pub(super) fn save_cart(
    // rust: &mut self,
    // rust: i: usize,
    // rust: keys: &HashSet<ChunkKey>,
    // rust: ) -> Option<(ChunkKey, Tag)> {
    // rust: let (id, at) = (self.carts[i].id, self.carts[i].position);
    // rust: if !keys.contains(&chunk_of(at)) {
    // rust: return None;
}
    // rust: let uuid = self.saved_uuid_or_random(id);
    // rust: let mut tag = self.carts[i].to_nbt(uuid, self.persist.raw.get(&id));
    // rust: self.put_mob_passengers(&mut tag, id);
    // rust: Some((chunk_of(at), tag))
}
    // rust: pub(super) fn save_armor_stand(
    // rust: &mut self,
    // rust: i: usize,
    // rust: keys: &HashSet<ChunkKey>,
    // rust: ) -> Option<(ChunkKey, Tag)> {
    // rust: let a = &self.armor_stands[i];
    // rust: keys.contains(&chunk_of(a.position)).then(|| {
    // rust: let uuid = self.saved_uuid_or_random(a.id);
    // rust: let tag = entity_nbt::armor_stand_to_nbt(a, uuid, self.persist.raw.get(&a.id));
    // rust: (chunk_of(a.position), tag)
    // rust: })
}
    /// The UUID kept for `id`, or a new one that is not remembered (what a
    /// saved vehicle or stand gets when it never had one).
pub fn saved_uuid_or_random(self: *Self, id: u32) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.persist
    // rust: .uuids
    // rust: .get(&id)
    // rust: .copied()
    // rust: .unwrap_or_else(random_uuid)
}
}

/// A chunk's key, as `chunk_of` gives it.
    // rust: pub(super) type ChunkKey = (i32, i32);

/// The raw compound kept for an entity loaded at `at`, found by kind and position.
pub fn anon_raw(persist: *EntityMemory, kind: []const u8, at: Vec3) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: persist
    // rust: .anon
    // rust: .get(&anon_key(kind, at))
    // rust: .map(|(_, raw)| raw.clone())
}
/// The UUID entity `id` was loaded with or given, else a new one for this save.
pub fn saved_uuid(persist: *EntityMemory, id: u32) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: persist.uuids.get(&id).copied().unwrap_or_else(random_uuid)
}

/// Only a mob is finalized; another entity drops the request.
pub fn strip_finalize(tag: *mut Tag) void {
}
    // rust: if let Tag::Compound(c) = tag {
    // rust: c.remove(&"horizon:finalize".into());
}
}
/// `riders` under `tag`'s `Passengers`, after the passengers it kept from
/// loading (`Entity.saveWithoutId`).
    // rust: pub(super) fn add_passengers(tag: &mut Tag, riders: Vec<Tag>) {
    // rust: if let Tag::Compound(c) = tag {
    // rust: let mut list = match c.get(&"Passengers".into()) {
    // rust: Some(Tag::List(l)) => l.clone(),
    // rust: _ => Vec::new(),
}
    // rust: list.extend(riders);
    // rust: if list.is_empty() {
    // rust: c.remove(&"Passengers".into());
    // rust: } else {
    // rust: c.insert("Passengers".into(), Tag::List(list));
}
}
}
/// `Entity.getRootVehicle`: up the vehicles `vehicle_of` gives, from `id`.
pub fn root_vehicle(id: u32, vehicle_of: impl Fn(u32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut root = id;
    // A bound against a loop of mounts.
    // rust: for _ in 0..16 {
    // rust: match vehicle_of(root) {
    // rust: Some(v) if v != root => root = v,
    // rust: _ => break,
}
}
    // rust: root
}
/// `ServerPlayer.saveParentVehicle`'s root: that of `vehicle`, while no
/// other player rides its tree (`Entity.hasExactlyOnePlayerPassenger`);
/// `others` are the vehicles the other players ride.
    // rust: fn parent_vehicle_root(
    // rust: vehicle: u32,
    // rust: others: &[u32],
    // rust: vehicle_of: impl Fn(u32) -> Option<u32>,
    // rust: ) -> Option<u32> {
    // rust: let root = root_vehicle(vehicle, &vehicle_of);
    // rust: let shared = others.iter().any(|&o| root_vehicle(o, &vehicle_of) == root);
    // rust: (!shared).then_some(root)
}
/// RootVehicle {Attach: the mount's UUID, Entity: the root's tree}.
pub fn root_vehicle_tag(attach: [i32; 4], entity: Tag) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Tag::compound([
    // rust: ("Attach", Tag::IntArray(attach.to_vec())),
    // rust: ("Entity", entity),
    // rust: ])
}
/// `Entity.getPassengersAndSelf` of `root`, from each rider's mount.
    // rust: pub(super) fn vehicle_tree(root: u32, mounts: &[(u32, Option<u32>)]) -> Vec<u32> {
    // rust: let mut tree = vec![root];
    // rust: let mut k = 0;
    // rust: while k < tree.len() {
    // rust: let v = tree[k];
    // rust: let riders: Vec<u32> = mounts
    // rust: .iter()
    // rust: .filter(|(id, m)| *m == Some(v) && !tree.contains(id))
    // rust: .map(|(id, _)| *id)
    // rust: .collect();
    // rust: tree.extend(riders);
    // rust: k += 1;
}
    // rust: tree
}

/// Only a Mob or an AbstractBoat is Leashable: any other kind never reads
/// `leash`, so a summoned or loaded tag must not be kept and saved.
pub fn drop_unleashable_leash(tag: *mut Tag, kind: []const u8, is_mob: bool) void {
}
    // rust: if !is_mob
    // rust: && super::boats::any_boat_wood(kind).is_none()
    // rust: && let Tag::Compound(c) = tag
    // rust: {
    // rust: c.remove(&"leash".into());
}
}
/// `Entity.load`: a string `Team` adds the entity (`name`, its UUID) to that
/// team when the scoreboard has it; else vanilla only logs a warning.
pub fn join_saved_team(board: *mut Scoreboard, name: []const u8, tag: *Tag) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(team) = text(tag.get("Team")) else {
    // rust: return false;
}
    // rust: if board.team(&team).is_none() {
    // rust: log::warn!("Unable to add mob to team \"{team}\" (that team probably doesn't exist)");
    // rust: return false;
}
    // rust: board.add_to_team(name, &team);
    // rust: true
}

    // rust: mod tests {
//     use super::*;

pub const MOUNT: [i32; 4] = [1, 2, 3, 4];

pub fn a_saved_team_is_joined_only_when_the_scoreboard_has_it() void {
}
    // rust: let mut board = Scoreboard::default();
    // rust: board.add_team("red");
    // rust: let with_team = |team: &str| {
    // rust: let mut t = entity("minecraft:zombie");
    // rust: if let Tag::Compound(c) = &mut t {
    // rust: c.insert("Team".into(), Tag::String(team.into()));
}
    // rust: t
}
    // rust: let name = "00000001-0002-0003-0004-000000000005";
    // rust: assert!(join_saved_team(&mut board, name, &with_team("red")));
    // rust: assert_eq!(
    // rust: board.players_team(name).map(|t| t.name.as_str()),
    // rust: Some("red")
    // rust: );
        // A team the scoreboard doesn't have is ignored, and the entity
        // stays on its team.
    // rust: assert!(!join_saved_team(&mut board, name, &with_team("blue")));
    // rust: assert_eq!(
    // rust: board.players_team(name).map(|t| t.name.as_str()),
    // rust: Some("red")
    // rust: );
    // rust: assert!(!join_saved_team(
    // rust: &mut board,
    // rust: "other",
    // rust: &entity("minecraft:zombie")
    // rust: ));
    // rust: assert!(board.players_team("other").is_none());
}

pub fn only_mobs_and_boats_keep_a_leash_tag() void {
}
    // rust: let with_leash = |kind: &str| {
    // rust: let mut t = entity(kind);
    // rust: if let Tag::Compound(c) = &mut t {
    // rust: c.insert("leash".into(), Tag::IntArray(vec![6, 100, 0]));
}
    // rust: t
}
    // rust: let has = |t: &Tag| t.get("leash").is_some();
    // rust: for kind in [
    // rust: "minecraft:armor_stand",
    // rust: "minecraft:minecart",
    // rust: "minecraft:tnt",
    // rust: "minecraft:item",
    // rust: ] {
    // rust: let mut t = with_leash(kind);
    // rust: drop_unleashable_leash(&mut t, kind, false);
    // rust: assert!(!has(&t), "{kind}");
}
    // rust: let mut cow = with_leash("minecraft:cow");
    // rust: drop_unleashable_leash(&mut cow, "minecraft:cow", true);
    // rust: assert!(has(&cow));
    // rust: let mut boat = with_leash("minecraft:oak_boat");
    // rust: drop_unleashable_leash(&mut boat, "minecraft:oak_boat", false);
    // rust: assert!(has(&boat));
}

pub fn entity(kind: []const u8) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Tag::compound([("id", Tag::String(kind.into()))])
}
pub fn passengers(tag: *Tag) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match tag.get("Passengers") {
    // rust: Some(Tag::List(l)) => l.iter().filter_map(entity_nbt::kind).collect(),
    // rust: _ => Vec::new(),
}
}

pub fn entity_attachment_boundary_includes_passengers() void {
}
//         use horizon_world::attachments::{
    // rust: AttachmentCodec, AttachmentError, AttachmentType, Attachments,
}
    // rust: let key = AttachmentType {
    // rust: namespace: "test",
    // rust: name: "counter",
    // rust: default: || 0,
    // rust: codec: Some(AttachmentCodec {
    // rust: encode: |n: &i32| Ok([("count".into(), Tag::Int(*n))].into()),
    // rust: decode: |c| match c.get(&"count".into()) {
    // rust: Some(Tag::Int(n)) => Ok(*n),
    // rust: _ => Err(AttachmentError::Decode),
    // rust: },
    // rust: }),
    // rust: copy_on_death: false,
    // rust: sync: false,
}
    // rust: let root_id = [1, 2, 3, 4];
    // rust: let child_id = [5, 6, 7, 8];
    // rust: let mut data = Attachments::default();
    // rust: data.set(&key, 29).unwrap();
    // rust: let maps = [(child_id, data)].into();
    // rust: let mut root = Tag::compound([
    // rust: ("UUID", Tag::IntArray(root_id.to_vec())),
    // rust: (
    // rust: "Passengers",
    // rust: Tag::List(vec![Tag::compound([(
    // rust: "UUID",
    // rust: Tag::IntArray(child_id.to_vec()),
    // rust: )])]),
    // rust: ),
    // rust: ]);
    // rust: write_attachments(&mut root, &maps);
    // rust: let Some(Tag::List(children)) = root.get("Passengers") else {
    // rust: panic!("passenger missing");
}
    // rust: let mut loaded = HashMap::new();
    // rust: read_attachments(&children[0], child_id, &mut loaded);
    // rust: assert_eq!(loaded.get_mut(&child_id).unwrap().get(&key), Ok(29));
}

    /// Entities as a save before every entity held attachments wrote them (a vanilla compound
    /// with its `UUID`, and `horizon:attachments` where the mod set one), loaded and saved again:
    /// each comes back on the entity with its UUID, and its attachments with it.
pub fn an_older_save_loads_its_entities_attachments_back_onto_them() void {
}
//         use super::super::{Audio, Game, Options, Progress, Settings, load_resources};
    // rust: let root = std::path::PathBuf::from(std::env::var_os("HORIZON_TEST_RESOURCES").unwrap());
    // rust: let settings = Settings::default();
    // rust: let loaded = load_resources(
    // rust: root.clone(),
    // rust: None,
    // rust: &root,
    // rust: &settings,
    // rust: std::time::Instant::now(),
    // rust: false,
    // rust: true,
    // rust: &Progress::new(),
    // rust: &mut |_, _| unreachable!("no menu handoff"),
    // rust: )
    // rust: .unwrap();
    // rust: let mut options = Options::parse(std::iter::empty()).unwrap().unwrap();
    // rust: options.resources = root.clone();
    // rust: options.execution_role = crate::game::execution_role::ExecutionRole::IntegratedServer;
    // rust: let mut game = Game::new(
    // rust: &loaded.resources,
    // rust: loaded.pack,
    // rust: loaded.gui.unwrap(),
    // rust: options,
    // rust: settings,
    // rust: Audio::silent(&root),
    // rust: None,
    // rust: )
    // rust: .unwrap();
//         use horizon_world::attachments::{AttachmentCodec, AttachmentError, AttachmentType};
    // rust: static MARK: AttachmentType<i32> = AttachmentType {
    // rust: namespace: "holdproof",
    // rust: name: "mark",
    // rust: default: || 0,
    // rust: codec: Some(AttachmentCodec {
    // rust: encode: |n: &i32| Ok([("n".into(), Tag::Int(*n))].into()),
    // rust: decode: |c| match c.get(&"n".into()) {
    // rust: Some(Tag::Int(n)) => Ok(*n),
    // rust: _ => Err(AttachmentError::Decode),
    // rust: },
    // rust: }),
    // rust: copy_on_death: false,
    // rust: sync: false,
}
    // rust: let mark = |n: i32| {
    // rust: Tag::compound([(
    // rust: "holdproof",
    // rust: Tag::compound([(
    // rust: "mark",
    // rust: Tag::compound([("value", Tag::compound([("n", Tag::Int(n))]))]),
    // rust: )]),
    // rust: )])
}
    // rust: let pos = |x: f64| Tag::List([x, 70.0, 3.0].map(|v| Tag::Double(v.to_bits())).to_vec());
    // rust: let kinds = [
    // rust: ("minecraft:zombie", vec![]),
    // rust: ("minecraft:arrow", vec![("NoGravity", Tag::Byte(1))]),
    // rust: ("minecraft:experience_orb", vec![("Value", Tag::Short(7))]),
    // rust: (
    // rust: "minecraft:falling_block",
    // rust: vec![
    // rust: (
    // rust: "BlockState",
    // rust: Tag::compound([("Name", Tag::String("minecraft:sand".into()))]),
    // rust: ),
    // rust: ("NoGravity", Tag::Byte(1)),
    // rust: ("Time", Tag::Int(1)),
    // rust: ],
    // rust: ),
    // rust: ("minecraft:snowball", vec![("NoGravity", Tag::Byte(1))]),
    // rust: ];
    // rust: let mut tags = Vec::new();
    // rust: let mut uuids = Vec::new();
    // rust: for (i, (kind, extra)) in kinds.iter().enumerate() {
    // rust: let n = i as i32 + 1;
    // rust: let uuid = [n, 2 * n, 3 * n, 4 * n];
    // rust: uuids.push((*kind, uuid, 1000 + n));
    // rust: let mut fields: Vec<(&str, Tag)> = vec![
    // rust: ("id", Tag::String((*kind).into())),
    // rust: ("Pos", pos(1.0 + i as f64)),
    // rust: ("UUID", Tag::IntArray(uuid.to_vec())),
    // rust: (ATTACHMENTS_KEY, mark(1000 + n)),
    // rust: ];
    // rust: fields.extend(extra.iter().cloned());
    // rust: tags.push(Tag::compound(fields));
}
        // The level is a server's, whose attachments a mod reaches.
    // rust: game.options.dedicated = Some(Vec::new());
    // rust: game.world.loaded_entities.push(((0, 0), tags));
    // rust: game.spawn_loaded_entities();
    // rust: let saved = game.entity_chunks(&HashSet::from([(0, 0)]), false);
    // rust: let saved: Vec<&Tag> = saved.iter().flat_map(|(_, tags)| tags).collect();
    // rust: for (kind, uuid, n) in uuids {
    // rust: let id = game
    // rust: .persist
    // rust: .uuids
    // rust: .iter()
    // rust: .find(|(_, u)| **u == uuid)
    // rust: .map(|(id, _)| *id);
    // rust: let id = id.unwrap_or_else(|| panic!("{kind}: loaded without its UUID"));
    // rust: let map = game.attachment_map_quiet(horizon_client::mod_api::Holder::Entity(id));
    // rust: let map = map.unwrap_or_else(|e| panic!("{kind}: not a holder: {e:?}"));
    // rust: assert_eq!(map.get(&MARK), Ok(n), "{kind}: attachments not loaded");
    // rust: let tag = saved.iter().find(|t| entity_nbt::uuid(t) == Some(uuid));
    // rust: let tag = tag.unwrap_or_else(|| panic!("{kind}: saved without its UUID"));
    // rust: assert_eq!(
    // rust: tag.get(ATTACHMENTS_KEY),
    // rust: Some(&mark(n)),
    // rust: "{kind}: attachments not saved back"
    // rust: );
    // rust: println!("{kind}: id {id}, UUID kept, attachments loaded and saved back");
}
}

pub fn a_lone_rider_saves_the_horse() void {
}
    // rust: let horse = 7;
    // rust: assert_eq!(parent_vehicle_root(horse, &[], |_| None), Some(horse));
    // rust: let tag = root_vehicle_tag(MOUNT, entity("minecraft:horse"));
    // rust: assert_eq!(tag.get("Attach"), Some(&Tag::IntArray(MOUNT.to_vec())));
    // rust: let saved = tag.get("Entity").and_then(entity_nbt::kind);
    // rust: assert_eq!(saved.as_deref(), Some("minecraft:horse"));
    // rust: assert_eq!(vehicle_tree(horse, &[]), vec![horse]);
}

pub fn two_players_on_one_boat_save_nothing() void {
}
    // rust: let boat = 3;
    // rust: assert_eq!(parent_vehicle_root(boat, &[boat], |_| None), None);
        // A player on a mob in the same boat shares its tree too.
    // rust: let pig = 4;
    // rust: let of = |id| (id == pig).then_some(boat);
    // rust: assert_eq!(parent_vehicle_root(boat, &[pig], of), None);
    // rust: assert_eq!(parent_vehicle_root(boat, &[9], of), Some(boat));
}

pub fn a_mob_in_a_boat_rides_under_the_boat() void {
}
    // rust: let (boat, pig) = (3, 4);
    // rust: let of = |id| (id == pig).then_some(boat);
    // rust: assert_eq!(parent_vehicle_root(pig, &[], of), Some(boat));
    // rust: assert_eq!(vehicle_tree(boat, &[(pig, Some(boat))]), vec![boat, pig]);
    // rust: let mut tag = entity("minecraft:oak_boat");
    // rust: add_passengers(&mut tag, vec![entity("minecraft:pig")]);
    // rust: assert_eq!(passengers(&tag), ["minecraft:pig"]);
}

pub fn a_cart_saves_and_takes_its_mob() void {
}
    // rust: let (cart, zombie, chicken) = (5, 6, 8);
        // A chicken on a zombie in the cart: the cart is the root.
    // rust: let mounts = [(zombie, Some(cart)), (chicken, Some(zombie)), (9, None)];
    // rust: let of = |id| mounts.iter().find(|m| m.0 == id).and_then(|m| m.1);
    // rust: assert_eq!(parent_vehicle_root(chicken, &[], of), Some(cart));
    // rust: assert_eq!(vehicle_tree(cart, &mounts), vec![cart, zombie, chicken]);
    // rust: let mut tag = entity("minecraft:minecart");
    // rust: add_passengers(&mut tag, vec![entity("minecraft:zombie")]);
    // rust: assert_eq!(passengers(&tag), ["minecraft:zombie"]);
        // No rider leaves no empty list.
    // rust: let mut tag = entity("minecraft:minecart");
    // rust: add_passengers(&mut tag, Vec::new());
    // rust: assert!(tag.get("Passengers").is_none());
}

    /// A portal arrival or a `/summon` is told as a fresh add, and the mark
    /// never reaches the entity's kept or saved compound.
pub fn a_fresh_add_is_told_apart_from_a_load_and_unmarked() void {
}
    // rust: let mut loaded = Tag::Compound(Default::default());
    // rust: assert!(!take_fresh(&mut loaded));
    // rust: let mut fresh = Tag::Compound(Default::default());
    // rust: mark_fresh(&mut fresh);
    // rust: assert!(take_fresh(&mut fresh));
    // rust: assert!(!take_fresh(&mut fresh));
    // rust: assert_eq!(fresh, Tag::Compound(Default::default()));
}
}
