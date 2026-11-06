//! Transpiled from Horizon Rust crate
//! Module: horizon-client_spawner
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The monster spawner (`BaseSpawner` as `SpawnerBlockEntity` runs it): its
//! saved state and `SpawnData`, the server tick that spawns its mobs and the
//! client tick that spins the mob inside and puffs flames.
//!
//! Vanilla keeps a server and a client copy of the block entity; Horizon keeps
//! one [`Spawner`] with the client's own delay and spin beside the server's
//! state. The level's random drives the server tick in vanilla's draw order;
//! what the spawner asks of the level goes through [`SpawnerLevel`], so the
//! game and a differential test world answer the same questions.
// use super::{
    // rust: Species,
    // rust: spawn_rules::{self, Reason},
    // rust: spawn_selection::{self, Category, NaturalLevel},
}
// use crate::chunk::block_entity::Next;
    // rust: pub use crate::chunk::block_entity::{CustomSpawnRules, SpawnData, Spawner};
// use horizon_core::{geometry::Aabb, geometry::Vec3, random::RandomSource};
// use horizon_world::nbt::{Compound, JavaString, Tag};

/// `SpawnData`'s codec and rules, over the data in `chunk::block_entity`.
    // rust: pub trait SpawnDataExt: Sized {
    /// The `SpawnData` constructor: an `id` that is a valid identifier is
    /// stored normalised (`zombie` becomes `minecraft:zombie`), any other is
    /// removed.
pub fn new(entity: Compound, rules: ?CustomSpawnRules, equipment: ?Tag) S;
    /// The entity's `id`, if any.
pub fn id(self: *Self) O;
    /// `SpawnData.CODEC`: `entity` (required), `custom_spawn_rules` and
    /// `equipment`.
pub fn decode(tag: *Tag) O;
pub fn encode(self: *Self) T;
    /// The entity compound is only its `id` (`hasNoConfiguration`): the
    /// spawned mob is finalized.
pub fn unconfigured(self: *Self) b;
    /// `CustomSpawnRules.isValidPosition`.
    // rust: fn valid_position<L: SpawnerLevel>(r: CustomSpawnRules, l: &L, x: i32, y: i32, z: i32) -> bool;
}
    // rust: impl SpawnDataExt for SpawnData {
pub fn new(mut entity: Compound, rules: ?CustomSpawnRules, equipment: ?Tag) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let key = JavaString::from("id");
    // rust: let id = match entity.get(&key) {
    // rust: Some(Tag::String(s)) => normalize_id(&s.to_string_lossy()),
    // rust: _ => None,
}
    // rust: match id {
    // rust: Some(id) => {
    // rust: entity.insert(key, Tag::String(id.as_str().into()));
}
    // rust: None => {
    // rust: entity.remove(&key);
}
}
    // rust: Self {
    // rust: entity,
    // rust: custom_spawn_rules: rules,
    // rust: equipment,
}
}
pub fn id(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self.entity.get(&JavaString::from("id")) {
    // rust: Some(Tag::String(s)) => Some(s.to_string_lossy()),
    // rust: _ => None,
}
}
pub fn decode(tag: *Tag) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(Tag::Compound(entity)) = tag.get("entity") else {
    // rust: return None;
}
    // rust: let rules = match tag.get("custom_spawn_rules") {
    // rust: Some(Tag::Compound(_)) => {
    // rust: let rules = tag.get("custom_spawn_rules")?;
    // rust: Some(CustomSpawnRules {
    // rust: block: light_limit(rules.get("block_light_limit"))?,
    // rust: sky: light_limit(rules.get("sky_light_limit"))?,
    // rust: })
}
    // rust: Some(_) => return None,
    // rust: None => None,
}
    // rust: Some(Self::new(
    // rust: entity.clone(),
    // rust: rules,
    // rust: tag.get("equipment").cloned(),
    // rust: ))
}
pub fn encode(self: *Self) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut out = vec![("entity", Tag::Compound(self.entity.clone()))];
    // rust: if let Some(r) = self.custom_spawn_rules {
    // rust: let mut rules = Vec::new();
    // rust: for (name, range) in [("block_light_limit", r.block), ("sky_light_limit", r.sky)] {
                // lenientOptionalFieldOf: the full range is left out.
    // rust: if range != (0, 15) {
    // rust: rules.push((name, encode_range(range)));
}
}
    // rust: out.push(("custom_spawn_rules", Tag::compound(rules)));
}
    // rust: if let Some(e) = &self.equipment {
    // rust: out.push(("equipment", e.clone()));
}
    // rust: Tag::compound(out)
}
pub fn unconfigured(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.entity.len() == 1 && self.id().is_some()
}
    // rust: fn valid_position<L: SpawnerLevel>(r: CustomSpawnRules, l: &L, x: i32, y: i32, z: i32) -> bool {
    // rust: let block = l.block_light(x, y, z);
    // rust: let sky = (l.sky_light(x, y, z) - l.sky_darken()).max(0);
    // rust: (r.block.0..=r.block.1).contains(&block) && (r.sky.0..=r.sky.1).contains(&sky)
}
}

    // rust: pub use horizon_client_core::identifier::normalize_id;

/// How much a slime's or magma cube's box is scaled by the size its data
/// loads (`Slime.readAdditionalSaveData`: Size + 1, kept in 1..=127), which
/// the obstruction test sees before `finalizeSpawn` picks one.
    // rust: pub(crate) fn cube_scale(id: &str, entity: &Compound) -> f32 {
    // rust: if !matches!(id, "minecraft:slime" | "minecraft:magma_cube") {
    // rust: return 1.0;
}
    // rust: number(entity.get(&JavaString::from("Size")))
    // rust: .map_or(1, |size| (size as i32).saturating_add(1).clamp(1, 127)) as f32
}

/// `EquipmentTable.CODEC`: the loot table and the drop chance of each
/// `EquipmentSlot` (`drops::SLOTS` order) the table names, `slot_drop_chances`
/// being one number for every slot or a map by slot name.
pub fn equipment_table(tag: *Tag) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let chance = |t: &Tag| match t {
    // rust: Tag::Float(v) => Some(f32::from_bits(*v)),
    // rust: Tag::Double(v) => Some(f64::from_bits(*v) as f32),
    // rust: Tag::Byte(v) => Some(f32::from(*v)),
    // rust: Tag::Short(v) => Some(f32::from(*v)),
    // rust: Tag::Int(v) => Some(*v as f32),
    // rust: Tag::Long(v) => Some(*v as f32),
    // rust: _ => None,
}
    // rust: let Some(Tag::String(table)) = tag.get("loot_table") else {
    // rust: return None;
}
    // rust: let mut chances = [None; 8];
    // rust: match tag.get("slot_drop_chances") {
    // rust: Some(Tag::Compound(map)) => {
    // rust: for (i, slot) in super::drops::SLOTS.iter().enumerate() {
    // rust: chances[i] = map.get(&JavaString::from(*slot)).and_then(chance);
}
}
    // rust: Some(all) => chances = [Some(chance(all)?); 8],
    // rust: None => {}
}
    // rust: Some((table.to_string_lossy(), chances))
}
/// A whole number from any numeric tag (`NumericTag.intValue`: floats floor).
    // rust: pub(crate) fn number(tag: Option<&Tag>) -> Option<i64> {
    // rust: Some(match tag? {
    // rust: Tag::Byte(v) => i64::from(*v),
    // rust: Tag::Short(v) => i64::from(*v),
    // rust: Tag::Int(v) => i64::from(*v),
    // rust: Tag::Long(v) => *v,
    // rust: Tag::Float(b) => f32::from_bits(*b).floor() as i64,
    // rust: Tag::Double(b) => f64::from_bits(*b).floor() as i64,
    // rust: _ => return None,
    // rust: })
}
/// `InclusiveRange.INT` within 0..=15 (`lenientOptionalFieldOf` with the
/// full range as default): a number, a two-element list or
/// `{min_inclusive, max_inclusive}`. None is a decoding error.
pub fn light_limit(tag: ?*Tag) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let int = |t: &Tag| match t {
    // rust: Tag::Int(v) => Some(*v),
    // rust: Tag::Byte(v) => Some(i32::from(*v)),
    // rust: Tag::Short(v) => Some(i32::from(*v)),
    // rust: _ => None,
}
    // rust: let range = match tag {
    // rust: None => return Some((0, 15)),
    // rust: Some(Tag::IntArray(v)) if v.len() == 2 => Some((v[0], v[1])),
    // rust: Some(Tag::List(v)) if v.len() == 2 => int(&v[0]).zip(int(&v[1])),
    // rust: Some(t @ Tag::Compound(_)) => t
    // rust: .get("min_inclusive")
    // rust: .and_then(int)
    // rust: .zip(t.get("max_inclusive").and_then(int)),
    // rust: Some(t) => int(t).map(|v| (v, v)),
}
    // rust: match range {
        // A malformed value falls back to the default (lenient); an
        // inverted range or one outside 0..=15 fails validation.
    // rust: None => Some((0, 15)),
    // rust: Some((lo, hi)) if lo <= hi && lo >= 0 && hi <= 15 => Some((lo, hi)),
    // rust: Some(_) => None,
}
}
pub fn encode_range() void {
}
    // rust: if lo == hi {
    // rust: Tag::Int(lo)
    // rust: } else {
    // rust: Tag::IntArray(vec![lo, hi])
}
}

/// What a spawner did that the level shows or sends.
pub const SpawnerEvent = enum {
    /// `setNextSpawnData`: `sendBlockUpdated` with the new update tag.
    BlockUpdated,
    /// `broadcastEvent(1)`: the block event that resets the clients' delay.
    BlockEvent(i32),
    /// `levelEvent(2004)`: the flame and smoke burst at the spawner.
    LevelEvent(i32),
    /// `gameEvent(entity, ENTITY_PLACE, block)`.
    EntityPlace(u32, [i32; 3]),
    /// `mob.spawnAnim()`: entity event 20 (the poof).
    SpawnAnim(u32),
};

/// A mob or entity the spawner wants to add (`EntityType.loadEntityRecursive`
/// then `tryAddFreshEntityWithPassengers`).
pub const SpawnerSpawn = struct {
    entity: *'a Compound,
    id: *'a str,
    position: [f64,
    yaw: f32,
    /// `finalizeSpawn(SPAWNER)` runs (the data is just an id).
    finalize: bool,
    equipment: ?*'a Tag,
    /// A trial spawner's mob (`EntitySpawnReason.TRIAL_SPAWNER`): it is
    /// always persistent.
    trial: bool,
};
/// An entity the level added: its id, box and whether it is a mob.
pub const SpawnerAdded = struct {
    id: u32,
    bounds: Aabb,
    mob: bool,
};

/// What a spawner reads from the level besides the spawn rules.
    // rust: pub trait SpawnerLevel: NaturalLevel {
    /// `hasNearbyAlivePlayer`: a living non-spectator closer than `range`
    /// (any distance when negative).
pub fn alive_player_near(self: *Self, x: f64, y: f64, z: f64, range: f64) b;
    /// The `spawner_blocks_work` game rule.
pub fn spawner_blocks_work(self: *Self) b;
    /// `EntityType.byString`: the entity type exists.
pub fn entity_exists(self: *Self, id: []const u8) b;
    /// Entities of the exact class of `id` whose box meets `bounds`.
pub fn count_entities(self: *Self, id: []const u8, bounds: Aabb) u;
}

/// `BaseSpawner`'s behaviour, over the data in `chunk::block_entity`.
    // rust: pub trait SpawnerExt: Sized {
    /// `BaseSpawner.load` (`SpawnerBlockEntity.loadAdditional`).
pub fn load(tag: *Tag) S;
    /// `BaseSpawner.save`: the fields as shorts, the next data when set and
    /// the potentials.
pub fn save(self: *Self) V;
    /// `SpawnerBlockEntity.getUpdateTag`: the saved fields without the potentials.
pub fn update_tag(self: *Self) T;
pub fn next_data(self: *Self) O;
pub fn next_data_mut(self: *Self) O;
pub fn random_potential(self: *Self, random: *mut impl RandomSource) O;
    /// `getOrCreateNextSpawnData`: a potential at random, or empty data.
pub fn next_or_create(self: *Self, random: *mut impl RandomSource, events: *mut std.ArrayList(SpawnerEvent)) void;
    /// `setEntityId`: the next data's `id` (a spawn egg used on the spawner).
    // rust: fn set_entity_id(
    // rust: &mut self,
    // rust: id: &str,
    // rust: random: &mut impl RandomSource,
    // rust: events: &mut Vec<SpawnerEvent>,
    // rust: );
    /// `setEntityData` (`TypedEntityData.loadInto`): an op's spawn egg with
    /// entity data: the next data's `id`, then `data` merged into it.
    // rust: fn set_entity_data(
    // rust: &mut self,
    // rust: id: &str,
    // rust: data: &Compound,
    // rust: random: &mut impl RandomSource,
    // rust: events: &mut Vec<SpawnerEvent>,
    // rust: );
    /// `isNearPlayer`.
    // rust: fn near_player<L: SpawnerLevel>(&self, l: &L, pos: [i32; 3]) -> bool;
    /// `delay`: the next delay, a new potential (when there are any) and the
    /// block event.
pub fn delay(self: *Self, random: *mut impl RandomSource, events: *mut std.ArrayList(SpawnerEvent)) void;
    /// `serverTick`. `spawn` adds an entity the spawner accepted and returns
    /// it, or None when the level would not take it.
    // rust: fn server_tick<L: SpawnerLevel, R: RandomSource>(
    // rust: &mut self,
    // rust: l: &L,
    // rust: random: &mut R,
    // rust: pos: [i32; 3],
    // rust: spawn: &mut dyn FnMut(&L, &SpawnerSpawn) -> Option<SpawnerAdded>,
    // rust: events: &mut Vec<SpawnerEvent>,
    // rust: );
    /// `clientTick`: with a player near and a mob to show, a smoke and flame
    /// particle at a random point of the block (returned) and the spin.
    // rust: fn client_tick(
    // rust: &mut self,
    // rust: near_player: bool,
    // rust: has_display: bool,
    // rust: random: &mut impl RandomSource,
    // rust: pos: [i32; 3],
    // rust: ) -> Option<[f64; 3]>;
    /// `onEventTriggered` on the client: event 1 resets the delay.
pub fn client_event(self: *Self, id: i32) b;
    /// The client copy received an update tag (`load`): its delay follows.
pub fn client_loaded(self: *Self) void;
    /// The display mob's spin in degrees and scale ([`display_pose`]).
pub fn display_pose(self: *Self, alpha: f32, width: f32, height: f32) (;
}
    // rust: impl SpawnerExt for Spawner {
pub fn load(tag: *Tag) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut s = Self {
    // rust: spawn_delay: number(tag.get("Delay")).map_or(20, |v| i32::from(v as i16)),
    // rust: ..Self::default()
}
    // rust: s.next = tag
    // rust: .get("SpawnData")
    // rust: .and_then(SpawnData::decode)
    // rust: .map(Next::Own);
    // rust: s.potentials = match tag.get("SpawnPotentials") {
    // rust: Some(Tag::List(list)) => list
    // rust: .iter()
    // rust: .filter_map(|e| {
    // rust: let weight = match e.get("weight") {
    // rust: Some(Tag::Int(w)) if *w >= 0 => *w,
    // rust: _ => return None,
}
    // rust: Some((SpawnData::decode(e.get("data")?)?, weight))
    // rust: })
    // rust: .collect(),
            // WeightedList.of(nextSpawnData), the same object, when the
            // potentials are missing or not a list.
    // rust: _ => {
    // rust: let data = match s.next.take() {
    // rust: Some(Next::Own(d)) => d,
    // rust: _ => SpawnData::default(),
}
    // rust: let had = tag.get("SpawnData").and_then(SpawnData::decode).is_some();
    // rust: if had {
    // rust: s.next = Some(Next::Potential(0));
}
    // rust: vec![(data, 1)]
}
}
    // rust: let int = |k: &str, d: i32| number(tag.get(k)).map_or(d, |v| v as i32);
    // rust: s.min_spawn_delay = int("MinSpawnDelay", 200);
    // rust: s.max_spawn_delay = int("MaxSpawnDelay", 800);
    // rust: s.spawn_count = int("SpawnCount", 4);
    // rust: s.max_nearby_entities = int("MaxNearbyEntities", 6);
    // rust: s.required_player_range = int("RequiredPlayerRange", 16);
    // rust: s.spawn_range = int("SpawnRange", 4);
    // rust: s.client_delay = s.spawn_delay;
    // rust: s
}
pub fn save(self: *Self) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let short = |v: i32| Tag::Short(v as i16);
    // rust: let mut out = vec![
    // rust: ("Delay", short(self.spawn_delay)),
    // rust: ("MinSpawnDelay", short(self.min_spawn_delay)),
    // rust: ("MaxSpawnDelay", short(self.max_spawn_delay)),
    // rust: ("SpawnCount", short(self.spawn_count)),
    // rust: ("MaxNearbyEntities", short(self.max_nearby_entities)),
    // rust: ("RequiredPlayerRange", short(self.required_player_range)),
    // rust: ("SpawnRange", short(self.spawn_range)),
    // rust: ];
    // rust: if let Some(next) = self.next_data() {
    // rust: out.push(("SpawnData", next.encode()));
}
    // rust: out.push((
    // rust: "SpawnPotentials",
    // rust: Tag::List(
    // rust: self.potentials
    // rust: .iter()
    // rust: .map(|(d, w)| Tag::compound([("data", d.encode()), ("weight", Tag::Int(*w))]))
    // rust: .collect(),
    // rust: ),
    // rust: ));
    // rust: out
}
pub fn update_tag(self: *Self) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Tag::compound(
    // rust: self.save()
    // rust: .into_iter()
    // rust: .filter(|(k, _)| *k != "SpawnPotentials"),
    // rust: )
}
pub fn next_data(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self.next.as_ref()? {
    // rust: Next::Own(d) => Some(d),
    // rust: Next::Potential(i) => self.potentials.get(*i).map(|(d, _)| d),
}
}
pub fn next_data_mut(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self.next.as_mut()? {
    // rust: Next::Own(d) => Some(d),
    // rust: Next::Potential(i) => self.potentials.get_mut(*i).map(|(d, _)| d),
}
}
pub fn random_potential(self: *Self, random: *mut impl RandomSource) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: weighted_index(self.potentials.iter().map(|(_, w)| *w), random)
}
pub fn next_or_create(self: *Self, random: *mut impl RandomSource, events: *mut std.ArrayList(SpawnerEvent)) void {
}
    // rust: if self.next.is_some() {
    // rust: return;
}
    // rust: self.next = Some(match self.random_potential(random) {
    // rust: Some(i) => Next::Potential(i),
    // rust: None => Next::Own(SpawnData::default()),
    // rust: });
    // rust: events.push(SpawnerEvent::BlockUpdated);
}
    // rust: fn set_entity_id(
    // rust: &mut self,
    // rust: id: &str,
    // rust: random: &mut impl RandomSource,
    // rust: events: &mut Vec<SpawnerEvent>,
    // rust: ) {
    // rust: self.next_or_create(random, events);
    // rust: if let Some(d) = self.next_data_mut() {
    // rust: d.entity.insert("id".into(), Tag::String(id.into()));
}
}
    // rust: fn set_entity_data(
    // rust: &mut self,
    // rust: id: &str,
    // rust: data: &Compound,
    // rust: random: &mut impl RandomSource,
    // rust: events: &mut Vec<SpawnerEvent>,
    // rust: ) {
    // rust: self.set_entity_id(id, random, events);
    // rust: if let Some(d) = self.next_data_mut() {
    // rust: crate::data_cmd::merge_compound(&mut d.entity, data);
}
}
    // rust: fn near_player<L: SpawnerLevel>(&self, l: &L, pos: [i32; 3]) -> bool {
    // rust: l.alive_player_near(
    // rust: f64::from(pos[0]) + 0.5,
    // rust: f64::from(pos[1]) + 0.5,
    // rust: f64::from(pos[2]) + 0.5,
    // rust: f64::from(self.required_player_range),
    // rust: )
}
pub fn delay(self: *Self, random: *mut impl RandomSource, events: *mut std.ArrayList(SpawnerEvent)) void {
}
    // rust: self.spawn_delay = if self.max_spawn_delay <= self.min_spawn_delay {
    // rust: self.min_spawn_delay
    // rust: } else {
    // rust: self.min_spawn_delay
    // rust: + random
    // rust: .next_int_bound(self.max_spawn_delay - self.min_spawn_delay)
    // rust: .unwrap_or(0)
}
    // rust: if let Some(i) = self.random_potential(random) {
    // rust: self.next = Some(Next::Potential(i));
    // rust: events.push(SpawnerEvent::BlockUpdated);
}
    // rust: events.push(SpawnerEvent::BlockEvent(1));
}
    // rust: fn server_tick<L: SpawnerLevel, R: RandomSource>(
    // rust: &mut self,
    // rust: l: &L,
    // rust: random: &mut R,
    // rust: pos: [i32; 3],
    // rust: spawn: &mut dyn FnMut(&L, &SpawnerSpawn) -> Option<SpawnerAdded>,
    // rust: events: &mut Vec<SpawnerEvent>,
    // rust: ) {
    // rust: if !self.near_player(l, pos) || !l.spawner_blocks_work() {
    // rust: return;
}
    // rust: if self.spawn_delay == -1 {
    // rust: self.delay(random, events);
}
    // rust: if self.spawn_delay > 0 {
    // rust: self.spawn_delay -= 1;
    // rust: return;
}
    // rust: let mut delay = false;
    // rust: self.next_or_create(random, events);
    // rust: let Some(data) = self.next_data().cloned() else {
    // rust: return;
}
        // Boxes of what this tick added, for the obstruction test.
    // rust: let mut added: Vec<Aabb> = Vec::new();
    // rust: for _ in 0..self.spawn_count {
            // EntityType.by: an unknown type delays.
    // rust: let Some(id) = data.id().filter(|id| l.entity_exists(id)) else {
    // rust: self.delay(random, events);
    // rust: return;
}
    // rust: let at = match read_pos(data.entity.get(&JavaString::from("Pos"))) {
    // rust: Some(p) => p,
    // rust: None => {
    // rust: let range = f64::from(self.spawn_range);
    // rust: let x = f64::from(pos[0])
    // rust: + (random.next_double() - random.next_double()) * range
    // rust: + 0.5;
    // rust: let y = f64::from(pos[1] + random.next_int_bound(3).unwrap_or(0) - 1);
    // rust: let z = f64::from(pos[2])
    // rust: + (random.next_double() - random.next_double()) * range
    // rust: + 0.5;
    // rust: [x, y, z]
}
}
    // rust: let kind = l.mob_type(&id);
    // rust: let (species, width, height, category) = match kind {
    // rust: Some((s, w, h, c)) => (Some(s), w, h, c),
                // Entity types Horizon cannot create: a unit box, misc.
    // rust: None => (None, 1.0, 1.0, Category::Misc),
}
    // rust: let spawn_box = match species {
    // rust: Some(s) => spawn_selection::spawn_aabb(s, at[0], at[1], at[2], width, height),
    // rust: None => spawn_selection::spawn_box(at[0], at[1], at[2], width, height),
}
    // rust: if !l.no_collision(spawn_box) {
    // rust: continue;
}
    // rust: let block = [
    // rust: at[0].floor() as i32,
    // rust: at[1].floor() as i32,
    // rust: at[2].floor() as i32,
    // rust: ];
    // rust: if let Some(rules) = data.custom_spawn_rules {
    // rust: if !category.friendly() && l.peaceful() {
    // rust: continue;
}
    // rust: if !SpawnData::valid_position(rules, l, block[0], block[1], block[2]) {
    // rust: continue;
}
    // rust: } else if let Some(s) = species
    // rust: && !spawn_rules::check_spawn_rules(
    // rust: s,
    // rust: l,
    // rust: Reason::Spawner,
    // rust: random,
    // rust: block[0],
    // rust: block[1],
    // rust: block[2],
    // rust: )
    // rust: {
    // rust: continue;
}
            // loadEntityRecursive: a type the game cannot create delays.
    // rust: let Some(s) = species else {
    // rust: self.delay(random, events);
    // rust: return;
}
    // rust: let around = Aabb::new(
    // rust: Vec3::new(f64::from(pos[0]), f64::from(pos[1]), f64::from(pos[2])),
    // rust: Vec3::new(
    // rust: f64::from(pos[0] + 1),
    // rust: f64::from(pos[1] + 1),
    // rust: f64::from(pos[2] + 1),
    // rust: ),
    // rust: )
    // rust: .inflate(Vec3::new(
    // rust: f64::from(self.spawn_range),
    // rust: f64::from(self.spawn_range),
    // rust: f64::from(self.spawn_range),
    // rust: ));
    // rust: if l.count_entities(&id, around) as i64 >= i64::from(self.max_nearby_entities) {
    // rust: self.delay(random, events);
    // rust: return;
}
    // rust: let yaw = random.next_float() * 360.0;
            // The entity's own position (Entity.setPos, which a shulker snaps
            // to its block) for its box and its block.
    // rust: let placed = entity_position(s, at);
    // rust: let own = [
    // rust: placed[0].floor() as i32,
    // rust: placed[1].floor() as i32,
    // rust: placed[2].floor() as i32,
    // rust: ];
    // rust: let scale = cube_scale(&id, &data.entity);
    // rust: let bounds = spawn_selection::spawn_box(
    // rust: placed[0],
    // rust: placed[1],
    // rust: placed[2],
    // rust: width * scale,
    // rust: height * scale,
    // rust: );
    // rust: let rules_ok = data.custom_spawn_rules.is_some()
    // rust: || spawn_selection::mob_spawn_rules(s, l, own[0], own[1], own[2]);
    // rust: if !rules_ok
    // rust: || !spawn_selection::spawn_obstruction(
    // rust: s,
    // rust: l,
    // rust: bounds,
    // rust: Some(&added),
    // rust: own[0],
    // rust: own[1],
    // rust: own[2],
    // rust: )
    // rust: {
    // rust: continue;
}
    // rust: let request = SpawnerSpawn {
    // rust: entity: &data.entity,
    // rust: id: &id,
    // rust: position: placed,
    // rust: yaw,
    // rust: finalize: data.unconfigured(),
    // rust: equipment: data.equipment.as_ref(),
    // rust: trial: false,
}
    // rust: let Some(result) = spawn(l, &request) else {
    // rust: self.delay(random, events);
    // rust: return;
}
    // rust: added.push(result.bounds);
    // rust: events.push(SpawnerEvent::LevelEvent(2004));
    // rust: events.push(SpawnerEvent::EntityPlace(result.id, block));
    // rust: if result.mob {
    // rust: events.push(SpawnerEvent::SpawnAnim(result.id));
}
    // rust: delay = true;
}
    // rust: if delay {
    // rust: self.delay(random, events);
}
}
    // rust: fn client_tick(
    // rust: &mut self,
    // rust: near_player: bool,
    // rust: has_display: bool,
    // rust: random: &mut impl RandomSource,
    // rust: pos: [i32; 3],
    // rust: ) -> Option<[f64; 3]> {
    // rust: if !near_player {
    // rust: self.o_spin = self.spin;
    // rust: return None;
}
    // rust: if !has_display {
    // rust: return None;
}
    // rust: let p = [
    // rust: f64::from(pos[0]) + random.next_double(),
    // rust: f64::from(pos[1]) + random.next_double(),
    // rust: f64::from(pos[2]) + random.next_double(),
    // rust: ];
    // rust: if self.client_delay > 0 {
    // rust: self.client_delay -= 1;
}
    // rust: self.o_spin = self.spin;
    // rust: self.spin =
    // rust: (self.spin + f64::from(1000.0_f32 / (self.client_delay as f32 + 200.0))) % 360.0;
    // rust: Some(p)
}
pub fn client_event(self: *Self, id: i32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if id == 1 {
    // rust: self.client_delay = self.min_spawn_delay;
    // rust: true
    // rust: } else {
    // rust: false
}
}
pub fn client_loaded(self: *Self) void {
}
    // rust: self.client_delay = self.spawn_delay;
}
pub fn display_pose(self: *Self, alpha: f32, width: f32, height: f32) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: display_pose(self.o_spin, self.spin, alpha, width, height)
}
}

/// `TrialSpawnerRenderer.extractSpawnerData`: the spin in degrees and the
/// scale of a display mob of the given size, between the last two spins.
pub fn display_pose(o_spin: f64, spin: f64, alpha: f32, width: f32, height: f32) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let spin = (o_spin + f64::from(alpha) * (spin - o_spin)) as f32 * 10.0;
    // rust: let longest = width.max(height);
    // rust: let scale = if longest > 1.0 {
    // rust: 0.53125 / longest
    // rust: } else {
    // rust: 0.53125
}
    // rust: (spin, scale)
}

/// `WeightedList.getRandom`: one draw over the total weight, none when the
/// list weighs nothing.
    // rust: pub fn weighted_index(
    // rust: weights: impl Iterator<Item = i32> + Clone,
    // rust: random: &mut impl RandomSource,
    // rust: ) -> Option<usize> {
    // rust: let total: i64 = weights.clone().map(i64::from).sum();
    // rust: if total == 0 {
    // rust: return None;
}
    // rust: let mut pick = i64::from(
    // rust: random
    // rust: .next_int_bound(total.min(i64::from(i32::MAX)) as i32)
    // rust: .unwrap_or(0),
    // rust: );
    // rust: for (i, w) in weights.enumerate() {
    // rust: pick -= i64::from(w);
    // rust: if pick < 0 {
    // rust: return Some(i);
}
}
    // rust: None
}

/// `Entity.setPos` of a fresh mob: a shulker sits at the centre of its block.
pub fn entity_position(s: Species, at: [f64; 3]) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if s == Species::Shulker {
    // rust: [
    // rust: at[0].floor() + 0.5,
    // rust: (at[1] + 0.5).floor(),
    // rust: at[2].floor() + 0.5,
    // rust: ]
    // rust: } else {
    // rust: at
}
}

/// `Vec3.CODEC`: a list of three doubles.
    // rust: pub(crate) fn read_pos(tag: Option<&Tag>) -> Option<[f64; 3]> {
    // rust: let Tag::List(v) = tag? else {
    // rust: return None;
}
    // rust: if v.len() != 3 {
    // rust: return None;
}
    // rust: let mut out = [0.0; 3];
    // rust: for (o, t) in out.iter_mut().zip(v) {
    // rust: *o = match t {
    // rust: Tag::Double(b) => f64::from_bits(*b),
    // rust: Tag::Float(b) => f64::from(f32::from_bits(*b)),
    // rust: _ => return None,
}
}
    // rust: Some(out)
}

    // rust: mod tests {
//     use super::*;
//     use horizon_core::random::LegacyRandom;

pub fn tag(snbt: []const u8) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: horizon_world::nbt::parse_snbt(snbt).expect("snbt").0
}

pub fn load_without_potentials_shares_the_next_data() void {
}
    // rust: let mut s = Spawner::load(&tag("{SpawnData:{entity:{id:\"zombie\"}}}"));
    // rust: assert_eq!(s.potentials.len(), 1);
    // rust: assert_eq!(
    // rust: s.next_data().and_then(SpawnData::id).as_deref(),
    // rust: Some("minecraft:zombie")
    // rust: );
    // rust: let mut events = Vec::new();
    // rust: s.set_entity_id("minecraft:skeleton", &mut LegacyRandom::new(0), &mut events);
    // rust: assert!(events.is_empty());
    // rust: assert_eq!(
    // rust: s.potentials[0].0.id().as_deref(),
    // rust: Some("minecraft:skeleton")
    // rust: );
}

pub fn entity_data_sets_the_id_and_merges_into_the_next_entity() void {
}
    // rust: let mut s = Spawner::load(&tag(
    // rust: "{SpawnData:{entity:{id:\"zombie\",Health:5.0f,equipment:{head:{id:\"minecraft:iron_helmet\"}}}}}",
    // rust: ));
    // rust: let Tag::Compound(data) = tag(
    // rust: "{id:\"minecraft:skeleton\",CustomName:\"Guard\",equipment:{mainhand:{id:\"minecraft:bow\"}}}",
    // rust: ) else {
    // rust: panic!("compound");
}
    // rust: let mut events = Vec::new();
    // rust: s.set_entity_data(
    // rust: "minecraft:skeleton",
    // rust: &data,
    // rust: &mut LegacyRandom::new(0),
    // rust: &mut events,
    // rust: );
    // rust: let entity = &s.next_data().unwrap().entity;
    // rust: let get = |k: &str| entity.get(&JavaString::from(k)).cloned();
        // CompoundTag.merge: the egg's keys over the old ones, nested
        // compounds merged, the rest kept.
    // rust: assert_eq!(get("id"), Some(Tag::String("minecraft:skeleton".into())));
    // rust: assert_eq!(get("CustomName"), Some(Tag::String("Guard".into())));
    // rust: assert_eq!(get("Health"), Some(tag("5.0f")));
    // rust: let Some(Tag::Compound(equipment)) = get("equipment") else {
    // rust: panic!("equipment");
}
    // rust: assert!(equipment.contains_key(&JavaString::from("head")));
    // rust: assert!(equipment.contains_key(&JavaString::from("mainhand")));
}

pub fn generated_spawner_keeps_no_potentials() void {
}
    // rust: let s = Spawner::load(&tag(
    // rust: "{SpawnData:{entity:{id:\"minecraft:cave_spider\"}},SpawnPotentials:[]}",
    // rust: ));
    // rust: assert!(s.potentials.is_empty());
    // rust: let saved = Tag::compound(s.save());
    // rust: assert_eq!(saved.get("SpawnPotentials"), Some(&Tag::List(Vec::new())));
    // rust: assert_eq!(saved.get("Delay"), Some(&Tag::Short(20)));
}

pub fn invalid_ids_are_removed() void {
}
    // rust: let d = SpawnData::new(
    // rust: match tag("{id:\"Zombie\"}") {
    // rust: Tag::Compound(c) => c,
    // rust: _ => unreachable!(),
    // rust: },
    // rust: None,
    // rust: None,
    // rust: );
    // rust: assert!(d.id().is_none());
    // rust: assert_eq!(normalize_id(":pig").as_deref(), Some("minecraft:pig"));
}

pub fn light_limits_decode_and_encode() void {
}
    // rust: assert_eq!(light_limit(Some(&tag("7"))), Some((7, 7)));
    // rust: assert_eq!(light_limit(Some(&tag("[I;0,7]"))), Some((0, 7)));
    // rust: assert_eq!(
    // rust: light_limit(Some(&tag("{min_inclusive:2,max_inclusive:9}"))),
    // rust: Some((2, 9))
    // rust: );
    // rust: assert_eq!(light_limit(Some(&tag("[I;9,2]"))), None);
    // rust: assert_eq!(encode_range((3, 3)), Tag::Int(3));
}

pub fn spawner_defaults_empty() void {
}
    // rust: let s = Spawner::default();
    // rust: assert_eq!(s.next_data(), None);
    // rust: assert!(s.potentials.is_empty());
}
}
