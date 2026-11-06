//! Transpiled from Horizon Rust crate
package horizon_client_structure_mobs

import "core:fmt"
import "core:mem"
import "core:math"

// `Mob.finalizeSpawn(level, level.getCurrentDifficultyAt(pos), STRUCTURE, null)`
// of the mobs structures place (StructureTemplate.placeEntities with
// finalizeEntities, ocean ruin drowned, mansion illagers, witch huts,
// monuments), run as decoration places them, with the WorldGenRegion's random.
// use crate::{
    // rust: enchant::Enchantments,
    // rust: entity_nbt,
    // rust: items::Items,
    // rust: mobs::{
    // rust: Mob, MobType, MobTypes,
    // rust: finalize::{self, Ctx, FinalizeLevel, Group, Reason, SpawnData, SpawnRegistries},
    // rust: spawning::{LocalDifficulty, MOON_BRIGHTNESS},
    // rust: },
}
// use horizon_core::{
    // rust: geometry::{Aabb, Vec3},
    // rust: random::{LegacyRandom, RandomSource, XoroshiroRandom},
}
// use horizon_world::{
    // rust: nbt::{Compound, Tag},
    // rust: worldgen::{generator::StructureMobs, structure::legacy::PieceRandom},
}
// use std::{
    // rust: collections::{HashMap, HashSet},
    // rust: path::PathBuf,
    // rust: sync::{
    // rust: Arc, OnceLock,
    // rust: atomic::{AtomicI64, AtomicU8, Ordering},
    // rust: },
}

Data :: struct {
    types: HashMap<string,
    biome_tags: HashMap<string,
    registries: SpawnRegistries,
    enchantments: Enchantments,
    items: Items,
    camel_husk: (f32,
}
load :: proc(root: ^std::path::Path) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let types = MobTypes::load(root).ok()?.types;
    // rust: let camel = types.get("minecraft:camel_husk")?;
    // rust: let camel_husk = (camel.width as f32, camel.height as f32);
    // rust: Some(Data {
    // rust: types: types.into_iter().map(|(k, t)| (k, Arc::new(t))).collect(),
    // rust: biome_tags: crate::items::load_tags(
    // rust: root,
    // rust: "worldgen/biome",
    // rust: &horizon_world::loot::PackOverlay::NONE,
    // rust: )
    // rust: .unwrap_or_default(),
    // rust: registries: SpawnRegistries::load(root),
    // rust: enchantments: Enchantments::load(root),
    // rust: items: Items::tags_only(root, &horizon_world::loot::PackOverlay::NONE).ok()?,
    // rust: camel_husk,
    // rust: })
}

StructureMobFinalizer :: struct {
    root: PathBuf,
    dimension: string,
    data: OnceLock<Maybe(Data)>,
    // The level's difficulty (0 peaceful to 3 hard) and overworld clock.
    difficulty: AtomicU8,
    day_time: AtomicI64,
}
    // rust: impl StructureMobFinalizer {
new :: proc(root: PathBuf, dimension: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: root,
    // rust: dimension: dimension.to_owned(),
    // rust: data: OnceLock::new(),
    // rust: difficulty: AtomicU8::new(2),
    // rust: day_time: AtomicI64::new(0),
}
}
set_conditions :: proc(self: ^Self, difficulty: u8, day_time: i64) {
}
    // rust: self.difficulty.store(difficulty, Ordering::Relaxed);
    // rust: self.day_time.store(day_time, Ordering::Relaxed);
}
}

Level :: struct {
    data: ^'a Data,
    biome: ^'a str,
    structures: ^'a [string],
    difficulty: u8,
    day_time: i64,
    next_id: u32,
}
    // rust: impl FinalizeLevel for Level<'_> {
biome :: proc(self: ^Self, _: [i32; 3]) -> S {
    // Ported from Horizon
    return {}
}
    // rust: self.biome.to_owned()
}
biome_tag :: proc(self: ^Self, tag: string, _: [i32; 3]) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.data
    // rust: .biome_tags
    // rust: .get(tag)
    // rust: .is_some_and(|b| b.contains(self.biome))
}
structures_with_piece_at :: proc(self: ^Self, _: [i32; 3]) -> V {
    // Ported from Horizon
    return {}
}
    // rust: self.structures.to_vec()
}
moon_phase :: proc(self: ^Self, _: [i32; 3]) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.day_time.div_euclid(24000).rem_euclid(8) as usize
}
spawning_monsters :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.difficulty != 0
}
    // No block collision: only a husk's camel asks, and no structure places husks.
no_collision :: proc(self: ^Self, _: Aabb) -> b {
    // Ported from Horizon
    return {}
}
    // rust: true
}
    // WorldGenRegion holds no entities.
free_chicken :: proc(self: ^Self, _: Aabb) -> O {
    // Ported from Horizon
    return {}
}
    // rust: None
}
ride_chicken :: proc(self: ^Self, _: u32, _: u32) {
}
game_time :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.day_time
}
halloween :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: finalize::is_halloween()
}
create :: proc(self: ^Self, kind: string, _: Reason) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if self.difficulty == 0 && !finalize::allowed_in_peaceful(kind) {
    // rust: return None;
}
    // rust: let t = self.data.types.get(kind)?.clone();
    // rust: self.next_id += 1;
    // rust: Some(Mob::new(self.next_id, t, Vec3::ZERO, 0.0))
}
}

    // rust: fn run<R: RandomSource>(
    // rust: level: &mut Level<'_>,
    // rust: random: &mut R,
    // rust: difficulty: LocalDifficulty,
    // rust: data: &SpawnData<'_>,
    // rust: m: &mut Mob,
    // rust: reason: Reason,
    // rust: group: &mut Option<Group>,
    // rust: ) -> Vec<Mob> {
    // rust: let mut cx = Ctx {
    // rust: level,
    // rust: random,
    // rust: difficulty,
    // rust: data,
    // rust: created: Vec::new(),
    // rust: jockey_rider: None,
}
    // rust: *group = cx.finalize(m, reason, group.take());
    // rust: if let Some(rider) = cx.jockey_rider {
    // rust: debug_assert_eq!(rider.id, m.id);
    // rust: *m = rider;
}
    // rust: cx.created
}

// The saved compound of mob `i` with the mobs riding it under `Passengers`.
tree :: proc(mobs: ^[(Mob) {
}
    // rust: let (m, raw) = &mobs[i];
    // No block registry here: a carried block stays as the template had it.
    // rust: let Tag::Compound(mut c) = entity_nbt::mob_to_nbt(m, [0; 4], raw.as_ref(), None) else {
    // rust: return Compound::new();
}
    // rust: c.remove(&"UUID".into());
    // Keys in vanilla's templates that no entity reads: the chunk keeps the
    // entity as its save writes it (ProtoChunk.addEntity), without them.
    // rust: for key in [
    // rust: "CatType",
    // rust: "OwnerUUID",
    // rust: "Riches",
    // rust: "Willing",
    // rust: "food_level",
    // rust: "lastRestock",
    // rust: ] {
    // rust: c.remove(&key.into());
}
    // rust: entity_nbt::put_brain(&mut c, m, dimension);
    // rust: let riders: Vec<Tag> = (0..mobs.len())
    // rust: .filter(|&j| mobs[j].0.extra.mount == Some(m.id))
    // rust: .map(|j| Tag::Compound(tree(mobs, j, dimension)))
    // rust: .collect();
    // rust: if !riders.is_empty() {
    // rust: c.insert("Passengers".into(), Tag::List(riders));
}
    // rust: c
}

    // rust: impl StructureMobs for StructureMobFinalizer {
    // rust: fn finalize(
    // rust: &self,
    // rust: nbt: &mut Compound,
    // rust: biome: &str,
    // rust: structures: &[String],
    // rust: random: &mut dyn PieceRandom,
    // rust: ) -> bool {
    // rust: let Some(data) = self.data() else {
    // rust: return false;
}
    // rust: let mut raw = Tag::Compound(nbt.clone());
    // rust: if let Tag::Compound(c) = &mut raw {
    // rust: c.remove(&"horizon:finalize".into());
}
    // rust: let Some(m) = entity_nbt::mob_from_nbt(&raw, &data.types, 1, None) else {
            // Not a mob: vanilla finalizes only Mob instances.
    // rust: return true;
}
    // rust: let reason = Reason::Structure;
    // rust: match self.finish(
    // rust: data,
    // rust: m,
    // rust: Some(raw),
    // rust: biome,
    // rust: structures,
    // rust: random,
    // rust: reason,
    // rust: &mut None,
    // rust: ) {
    // rust: Some(saved) => {
    // rust: *nbt = saved;
    // rust: true
}
    // rust: None => false,
}
}
}

    // rust: impl StructureMobFinalizer {
data :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.data
    // rust: .get_or_init(|| {
    // rust: let data = load(&self.root);
    // rust: if data.is_none() {
    // rust: log::error!("Horizon: no mob data, structure mobs are finalized when loaded");
}
    // rust: data
    // rust: })
    // rust: .as_ref()
}
    // A mob chunk generation spawns (`spawnOriginalMobs`): a new one of
    // `kind` finalized as a structure mob is, as the chunk saves it; `group`
    // carries a pack's group data from one member to the next.
    // rust: pub fn spawn_generated(
    // rust: &self,
    // rust: kind: &str,
    // rust: position: Vec3,
    // rust: yaw: f32,
    // rust: biome: &str,
    // rust: random: &mut dyn PieceRandom,
    // rust: group: &mut Option<Group>,
    // rust: ) -> Option<Compound> {
    // rust: let data = self.data()?;
    // rust: let m = Mob::new(1, data.types.get(kind)?.clone(), position, yaw);
    // rust: let reason = Reason::ChunkGeneration;
    // rust: self.finish(data, m, None, biome, &[], random, reason, group)
}
    // rust: fn finish(
    // rust: &self,
    // rust: data: &Data,
    // rust: mut m: Mob,
    // rust: raw: Option<Tag>,
    // rust: biome: &str,
    // rust: structures: &[String],
    // rust: random: &mut dyn PieceRandom,
    // rust: reason: Reason,
    // rust: group: &mut Option<Group>,
    // rust: ) -> Option<Compound> {
    // rust: let base = self.difficulty.load(Ordering::Relaxed);
    // rust: let day_time = self.day_time.load(Ordering::Relaxed);
    // rust: let mut level = Level {
    // rust: data,
    // rust: biome,
    // rust: structures,
    // rust: difficulty: base,
    // rust: day_time,
    // rust: next_id: 1,
}
    // rust: let moon = MOON_BRIGHTNESS[level.moon_phase([0; 3])];
        // WorldGenRegion.getCurrentDifficultyAt: no inhabited time.
    // rust: let difficulty = LocalDifficulty::new(base, day_time, 0, moon);
    // rust: let spawn = SpawnData {
    // rust: registries: &data.registries,
    // rust: enchantments: &data.enchantments,
    // rust: items: &data.items,
    // rust: camel_husk_size: data.camel_husk,
}
    // rust: let any = random.as_any();
    // rust: let created = if let Some(r) = any.downcast_mut::<LegacyRandom>() {
    // rust: run(&mut level, r, difficulty, &spawn, &mut m, reason, group)
    // rust: } else if let Some(r) = any.downcast_mut::<XoroshiroRandom>() {
    // rust: run(&mut level, r, difficulty, &spawn, &mut m, reason, group)
    // rust: } else {
    // rust: log::error!("Horizon: unknown region random, structure mobs are finalized when loaded");
    // rust: return None;
}
    // rust: let mut mobs = vec![(m, raw)];
    // rust: mobs.extend(created.into_iter().map(|c| (c, None)));
    // rust: let root = mobs
    // rust: .iter()
    // rust: .position(|(m, _)| m.extra.mount.is_none())
    // rust: .unwrap_or(0);
    // rust: Some(tree(&mobs, root, &self.dimension))
}
}

    // rust: mod tests {
//     use super::*;

    // The bastion's crossbow piglin keeps its crossbow (STRUCTURE skips
    // createSpawnWeapon) and saves what Piglin.addAdditionalSaveData writes.
bastion_crossbow_piglin_finalizes_as_structure :: proc() {
}
    // rust: let Some(root) = std::env::var_os("HORIZON_TEST_RESOURCES").map(PathBuf::from) else {
    // rust: return;
}
    // rust: let file = root.join("worldgen/structure/minecraft/bastion/mobs/crossbow_piglin.nbt");
    // rust: let mut bytes = Vec::new();
    // rust: std::io::Read::read_to_end(
    // rust: &mut flate2::read::GzDecoder::new(std::fs::File::open(file).unwrap()),
    // rust: &mut bytes,
    // rust: )
    // rust: .unwrap();
    // rust: let limits = horizon_world::nbt::Limits::templates();
    // rust: let template = horizon_world::nbt::read_named(&bytes, limits)
    // rust: .unwrap()
    // rust: .0
    // rust: .tag;
    // rust: let Some(Tag::List(entities)) = template.get("entities") else {
    // rust: panic!("no entities");
}
    // rust: let Some(Tag::Compound(mut nbt)) = entities[0].get("nbt").cloned() else {
    // rust: panic!("no nbt");
}
    // rust: nbt.remove(&"UUID".into());
    // rust: let hook = StructureMobFinalizer::new(root, "minecraft:the_nether");
    // rust: let mut random = LegacyRandom::new(12345);
    // rust: hook.finalize(&mut nbt, "minecraft:nether_wastes", &[], &mut random);
    // rust: let keys: Vec<String> = {
    // rust: let mut k: Vec<String> = nbt.keys().map(|k| k.to_string_lossy()).collect();
    // rust: k.sort();
    // rust: k
}
    // rust: assert_eq!(
    // rust: keys,
    // rust: [
    // rust: "AbsorptionAmount",
    // rust: "Air",
    // rust: "Brain",
    // rust: "CanPickUpLoot",
    // rust: "CannotHunt",
    // rust: "DeathTime",
    // rust: "FallFlying",
    // rust: "Fire",
    // rust: "Health",
    // rust: "HurtTime",
    // rust: "Inventory",
    // rust: "Invulnerable",
    // rust: "IsBaby",
    // rust: "IsImmuneToZombification",
    // rust: "LeftHanded",
    // rust: "Motion",
    // rust: "OnGround",
    // rust: "PersistenceRequired",
    // rust: "PortalCooldown",
    // rust: "Pos",
    // rust: "Rotation",
    // rust: "TimeInOverworld",
    // rust: "attributes",
    // rust: "current_impulse_context_reset_grace_time",
    // rust: "equipment",
    // rust: "fall_distance",
    // rust: "id",
    // rust: ]
    // rust: );
    // rust: let tag = Tag::Compound(nbt);
    // rust: let held = tag.get("equipment").and_then(|e| e.get("mainhand"));
    // rust: assert!(
    // rust: matches!(held.and_then(|h| h.get("id")), Some(Tag::String(s)) if s.to_string_lossy() == "minecraft:crossbow")
    // rust: );
    // rust: let hunted = tag
    // rust: .get("Brain")
    // rust: .and_then(|b| b.get("memories"))
    // rust: .and_then(|m| m.get("minecraft:hunted_recently"));
    // rust: assert!(matches!(
    // rust: hunted.and_then(|h| h.get("ttl")),
    // rust: Some(Tag::Long(600..=2400))
    // rust: ));
    // rust: let Some(Tag::List(attributes)) = tag.get("attributes") else {
    // rust: panic!("no attributes");
}
    // rust: assert!(attributes.iter().any(|a| {
    // rust: matches!(a.get("id"), Some(Tag::String(s)) if s.to_string_lossy() == "minecraft:follow_range")
    // rust: && matches!(a.get("modifiers"), Some(Tag::List(m)) if m.len() == 1)
    // rust: }));
}

id :: proc(t: Maybe(^Tag)) -> S {
    // Ported from Horizon
    return {}
}
    // rust: match t.and_then(|t| t.get("id")) {
    // rust: Some(Tag::String(s)) => s.to_string_lossy().trim_start_matches("minecraft:").into(),
    // rust: _ => "-".into(),
}
}
    // What a vanilla world saves of a structure mob that finalizeSpawn decides.
describe :: proc(mob: ^Tag) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let eq = mob.get("equipment");
    // rust: let gear: Vec<String> = ["mainhand", "head", "chest", "legs", "feet"]
    // rust: .iter()
    // rust: .map(|slot| id(eq.and_then(|e| e.get(slot))))
    // rust: .collect();
    // rust: let ttl = match mob
    // rust: .get("Brain")
    // rust: .and_then(|b| b.get("memories"))
    // rust: .and_then(|m| m.get("minecraft:hunted_recently"))
    // rust: .and_then(|h| h.get("ttl"))
    // rust: {
    // rust: Some(Tag::Long(t)) => t.to_string(),
    // rust: _ => "-".into(),
}
    // rust: let bonus = crate::entity_nbt::spawn_bonus(mob).unwrap_or(f64::NAN);
    // rust: let flag = |k: &str| matches!(mob.get(k), Some(Tag::Byte(1)));
    // rust: let riders = match mob.get("Passengers") {
    // rust: Some(Tag::List(p)) => format!(
    // rust: " [{}]",
    // rust: p.iter().map(describe).collect::<Vec<_>>().join("; ")
    // rust: ),
    // rust: _ => String::new(),
}
    // rust: format!(
    // rust: "{} {} ttl={ttl} bonus={bonus:.6} left={} baby={}{riders}",
    // rust: id(Some(mob)),
    // rust: gear.join(","),
    // rust: flag("LeftHanded"),
    // rust: flag("IsBaby") || matches!(mob.get("Age"), Some(Tag::Int(a)) if *a < 0),
    // rust: )
}
    // The described entities of chunk (x, z) after decorating the 3x3 around it.
    // rust: fn chunk_mobs(
    // rust: root: &std::path::Path,
    // rust: seed: i64,
    // rust: dimension: &str,
    // rust: x: i32,
    // rust: z: i32,
    // rust: ) -> Vec<String> {
//         use crate::streaming::{ChunkGenerator, Proto};
    // rust: let assets = crate::assets::Assets::load(root).unwrap();
    // rust: let biomes = crate::biome::Biomes::load(root).unwrap();
    // rust: let terrain = super::super::VanillaTerrain::for_dimension(
    // rust: &root.join("worldgen"),
    // rust: assets.registry,
    // rust: &biomes,
    // rust: seed,
    // rust: dimension,
    // rust: )
    // rust: .unwrap();
    // rust: let mut worker = terrain.worker();
    // rust: let mut region: [Proto; 9] = std::array::from_fn(|i| {
    // rust: terrain.proto(&mut worker, x + i as i32 % 3 - 1, z + i as i32 / 3 - 1)
    // rust: });
    // rust: terrain.decorate(&mut worker, &mut region);
    // rust: let center = std::mem::replace(&mut region[4], Box::new(()));
    // rust: let mut got: Vec<String> = terrain
    // rust: .finish(center)
    // rust: .entities
    // rust: .iter()
    // rust: .map(describe)
    // rust: .collect();
    // rust: got.sort();
    // rust: got
}
    // Seed 12345's bastion at chunk (-21, 8): the mobs of chunk (-23, 8) as two
    // vanilla 26.3 runs saved them (weapons and armour, hunting memory, follow
    // range bonus, handedness), from the region random of that chunk. The
    // memories are as placed: vanilla saved them 13 brain ticks later.
bastion_chunk_mobs_match_vanilla :: proc() {
}
    // rust: let Some(root) = std::env::var_os("HORIZON_TEST_RESOURCES").map(PathBuf::from) else {
    // rust: return;
}
    // rust: let got = chunk_mobs(&root, 12345, "minecraft:the_nether", -23, 8);
    // rust: let mut expected = [
    // rust: "piglin golden_sword,-,golden_chestplate,-,- ttl=1760 bonus=0.013784",
    // rust: "piglin crossbow,-,-,-,- ttl=806 bonus=-0.011458",
    // rust: "piglin golden_sword,-,-,-,- ttl=1315 bonus=-0.084585",
    // rust: "piglin golden_sword,-,-,-,- ttl=1489 bonus=-0.038292",
    // rust: "piglin_brute golden_axe,-,-,-,- ttl=- bonus=-0.020574",
    // rust: "piglin crossbow,-,-,-,- ttl=1620 bonus=-0.079135",
    // rust: "hoglin -,-,-,-,- ttl=- bonus=-0.012052",
    // rust: "piglin golden_sword,-,-,-,- ttl=783 bonus=-0.077071",
    // rust: "piglin crossbow,-,-,golden_leggings,- ttl=1431 bonus=0.007058",
    // rust: ]
    // rust: .map(|e| format!("{e} left=false baby=false"));
    // rust: expected.sort();
    // rust: assert_eq!(got, expected);
}

    // Seed 12345's ocean ruin at (53, 39, 424): Drowned.finalizeSpawn mounts the
    // trident drowned on a zombie nautilus, as vanilla saved chunk (3, 26).
ocean_ruin_drowned_match_vanilla :: proc() {
}
    // rust: let Some(root) = std::env::var_os("HORIZON_TEST_RESOURCES").map(PathBuf::from) else {
    // rust: return;
}
    // rust: let got = chunk_mobs(&root, 12345, "minecraft:overworld", 3, 26);
    // rust: let d = |gear: &str, bonus: &str| {
    // rust: format!("drowned {gear},-,-,-,- ttl=- bonus={bonus} left=false baby=false")
}
    // rust: let mut expected = vec![
    // rust: d("-", "0.001996"),
    // rust: format!(
    // rust: "zombie_nautilus -,-,-,-,- ttl=- bonus=-0.044983 left=false baby=false [{}]",
    // rust: d("trident", "-0.045604")
    // rust: ),
    // rust: d("fishing_rod", "-0.059079"),
    // rust: d("-", "0.021658"),
    // rust: ];
    // rust: expected.sort();
    // rust: assert_eq!(got, expected);
}
}
