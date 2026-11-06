//! Transpiled from Horizon Rust crate
//! Module: horizon-client_spawning
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Natural spawning rules: `SpawnPlacements` placement types and each
//! species' spawn predicate (`checkAnimalSpawnRules`, `checkMonsterSpawnRules`,
//! water animals, bats...), and `finalizeSpawn` (variants, colours, babies,
//! equipment).
// use super::{Mob, MobWorld, Species, farm::Climate};
// use horizon_core::random::RandomSource;

/// Biome facts finalizeSpawn and the spawn rules read.
pub const BiomeFacts = struct {
    climate: Climate,
    /// Biome temperature at the position (strays in cold biomes, snow foxes).
    temperature: f32,
    snowy: bool,
    /// `#minecraft:spawns_snow_foxes` (`Fox.Variant.byBiome`: snow, else red).
    snow_fox: bool,
    swamp: bool,
    ocean: bool,
    mushroom: bool,
    desert: bool,
    jungle: bool,
    /// Frog variant from `spawns_warm/cold_variant_frogs` (0 temperate, 1 warm, 2 cold).
    frog: u8,
    /// Wolf variant index (`tame::WOLF_VARIANTS`).
    wolf: u8,
    /// `MoonBrightnessCheck(>= 0.9)`: the full moon.
    full_moon: bool,
    /// `spawns_coral_variant_zombie_nautilus` (the warm ocean).
    coral_nautilus: bool,
};
/// `SpawnPlacements.isSpawnPositionOk` for the species.
pub fn placement_ok(species: Species, w: *MobWorld, x: i32, y: i32, z: i32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: super::spawn_rules::is_spawn_position_ok(species, w, x, y, z)
}
/// Mob.finalizeSpawn for natural, chunk-generation and summoned mobs.
/// `DifficultyInstance`: the local difficulty at a position.
pub const LocalDifficulty = struct {
    /// The world difficulty id, 0 peaceful to 3 hard.
    base: u8,
    effective: f32,
    /// The world difficulty is normal.
    normal: bool,
    /// The world difficulty is hard.
    hard: bool,
    /// `Difficulty.getId`: 0 peaceful to 3 hard.
    id: u8,
};
/// `DimensionType.MOON_BRIGHTNESS_PER_PHASE`.
pub const MOON_BRIGHTNESS: [f32; 8] = [1.0, 0.75, 0.5, 0.25, 0.0, 0.25, 0.5, 0.75];
    // rust: impl LocalDifficulty {
    /// `calculateDifficulty` from the difficulty id (0 peaceful to 3 hard),
    /// the overworld clock, the chunk's inhabited time and the moon.
pub fn new(base: u8, total: i64, inhabited: i64, moon: f32) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let hard = base == 3;
    // rust: let normal = base == 2;
    // rust: if base == 0 {
    // rust: return Self {
    // rust: base,
    // rust: effective: 0.0,
    // rust: normal,
    // rust: hard,
    // rust: id: base,
}
}
    // rust: let global = ((total as f32 - 72000.0) / 1_440_000.0).clamp(0.0, 1.0) * 0.25;
    // rust: let mut local =
    // rust: (inhabited as f32 / 3_600_000.0).clamp(0.0, 1.0) * if hard { 1.0 } else { 0.75 };
    // rust: local += (moon * 0.25).clamp(0.0, global);
    // rust: if base == 1 {
    // rust: local *= 0.5;
}
    // rust: Self {
    // rust: base,
    // rust: effective: f32::from(base) * (0.75 + global + local),
    // rust: normal,
    // rust: hard,
    // rust: id: base,
}
}
    /// `getSpecialMultiplier`.
pub fn special(self: *Self) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.effective < 2.0 {
    // rust: 0.0
    // rust: } else if self.effective > 4.0 {
    // rust: 1.0
    // rust: } else {
    // rust: (self.effective - 2.0) / 2.0
}
}
}
/// The armour and toughness each vanilla armour piece adds.
pub fn armor_stats(item: []const u8) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(name) = item.strip_prefix("minecraft:") else {
    // rust: return (0.0, 0.0);
}
    // rust: let slot = ["helmet", "chestplate", "leggings", "boots"]
    // rust: .iter()
    // rust: .position(|p| name.ends_with(p));
    // rust: let Some(slot) = slot else { return (0.0, 0.0) };
    // rust: let (points, toughness): ([f32; 4], f32) = match name.split('_').next() {
    // rust: Some("leather") => ([1.0, 3.0, 2.0, 1.0], 0.0),
    // rust: Some("copper") => ([2.0, 4.0, 3.0, 1.0], 0.0),
    // rust: Some("golden") => ([2.0, 5.0, 3.0, 1.0], 0.0),
    // rust: Some("chainmail") => ([2.0, 5.0, 4.0, 1.0], 0.0),
    // rust: Some("iron") => ([2.0, 6.0, 5.0, 2.0], 0.0),
    // rust: Some("turtle") => ([2.0, 0.0, 0.0, 0.0], 0.0),
    // rust: Some("diamond") => ([3.0, 8.0, 6.0, 3.0], 2.0),
    // rust: Some("netherite") => ([3.0, 8.0, 6.0, 3.0], 3.0),
    // rust: _ => return (0.0, 0.0),
}
    // rust: (points[slot], toughness)
}
/// The armour and toughness a horse armor item adds in the body slot
/// (`ArmorMaterial.createAttributes(ArmorType.BODY)`).
pub fn horse_armor_stats(item: []const u8) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match item.strip_prefix("minecraft:") {
    // rust: Some("leather_horse_armor") => (3.0, 0.0),
    // rust: Some("copper_horse_armor") => (4.0, 0.0),
    // rust: Some("iron_horse_armor") => (5.0, 0.0),
    // rust: Some("golden_horse_armor") => (7.0, 0.0),
    // rust: Some("diamond_horse_armor") => (11.0, 2.0),
    // rust: Some("netherite_horse_armor") => (19.0, 3.0),
    // rust: _ => (0.0, 0.0),
}
}
/// `Mob.populateDefaultEquipmentSlots`: sometimes a set of armour, from the
/// head down, of one random material.
pub fn populate_armor(m: *mut Mob, d: *LocalDifficulty) void {
}
    // rust: if m.random.next_float() >= 0.15 * d.special() {
    // rust: return;
}
    // rust: let mut kind = m.random.next_int_bound(3).unwrap_or(0);
    // rust: for _ in 1..=3 {
    // rust: if m.random.next_float() < 0.1087 {
    // rust: kind += 1;
}
}
    // rust: let partial = if d.hard { 0.1 } else { 0.25 };
    // rust: let material = [
    // rust: "leather",
    // rust: "copper",
    // rust: "golden",
    // rust: "chainmail",
    // rust: "iron",
    // rust: "diamond",
    // rust: ][kind as usize];
    // rust: for (i, piece) in ["helmet", "chestplate", "leggings", "boots"]
    // rust: .into_iter()
    // rust: .enumerate()
    // rust: {
    // rust: if i > 0 && m.random.next_float() < partial {
    // rust: break;
}
    // rust: let slot = match i {
    // rust: 0 => &mut m.extra.head,
    // rust: 1 => &mut m.extra.chest,
    // rust: 2 => &mut m.extra.legs,
    // rust: _ => &mut m.extra.feet,
}
    // rust: if slot.is_none() {
    // rust: *slot = Some(format!("minecraft:{material}_{piece}").into());
}
}
}
pub fn finalize(m: *mut Mob, biome: *BiomeFacts, difficulty: *LocalDifficulty) void {
}
//     use Species as S;
    // rust: let climate_index = match biome.climate {
    // rust: Climate::Temperate => 0,
    // rust: Climate::Warm => 1,
    // rust: Climate::Cold => 2,
}
    // `Registry.getRandom` of the `*_sound_variant` registry (pig, cow,
    // chicken, cat and wolf), drawn by their finalizeSpawn.
    // rust: let sounds = super::finalize::sound_variants(m.species()).len();
    // rust: if sounds > 0 {
    // rust: m.extra.sound_variant = Some(m.random.next_int_bound(sounds as i32).unwrap_or(0) as u8);
}
    // Mob.finalizeSpawn, reached through `super` by every mob but the cave
    // spider (CaveSpider.finalizeSpawn returns without calling it).
    // rust: if m.species() != S::CaveSpider {
    // rust: let mut random = m.random.clone();
    // rust: super::finalize::mob_spawn(m, &mut random);
    // rust: m.random = random;
}
    // rust: match m.species() {
        // Warden.finalizeSpawn: a minute before it digs back down.
    // rust: S::Warden => super::warden::finalize(m, false, &mut Vec::new()),
    // rust: S::Pig | S::Cow | S::Chicken => m.extra.variant = climate_index,
    // rust: S::Sheep => m.extra.color = super::farm::sheep_color(biome.climate, &mut m.random),
    // rust: S::Mooshroom => m.extra.variant = 0,
        // Turtle.finalizeSpawn: home is where it spawned.
    // rust: S::Turtle => {
    // rust: m.extra.home = Some([
    // rust: m.position.x.floor() as i32,
    // rust: m.position.y.floor() as i32,
    // rust: m.position.z.floor() as i32,
    // rust: ])
}
    // rust: S::Frog => m.extra.variant = biome.frog,
    // rust: S::Wolf => m.extra.variant = biome.wolf,
    // rust: S::Cat => m.extra.variant = super::tame::cat_variant(m, biome.full_moon),
    // rust: S::Zombie | S::Husk | S::Drowned | S::ZombieVillager => {
            // Zombie.finalizeSpawn: pick up loot 55% of the time (scaled by
            // difficulty), 5% babies (normal difficulty).
    // rust: m.extra.pick_up_loot = m.random.next_float() < 0.55 * difficulty.special();
    // rust: if m.random.next_float() < 0.05 {
    // rust: m.extra.age = i32::MIN / 2;
}
            // setCanBreakDoors(nextFloat() < special * 0.1), before the gear.
    // rust: let can_break_doors = m.random.next_float() < difficulty.special() * 0.1;
    // rust: super::doors::set_can_break_doors(m, can_break_doors);
    // rust: if m.species() != S::Drowned {
    // rust: populate_armor(m, difficulty);
}
    // rust: let weapon = if difficulty.hard { 0.05 } else { 0.01 };
    // rust: if m.species() != S::Drowned && m.random.next_float() < weapon {
    // rust: let r = m.random.next_int_bound(6).unwrap_or(0);
    // rust: m.extra.set_main_hand(Some(
    // rust: match r {
    // rust: 0 => "minecraft:iron_sword",
    // rust: 1 => "minecraft:iron_spear",
    // rust: _ => "minecraft:iron_shovel",
}
    // rust: .into(),
    // rust: ));
}
    // rust: if m.species() == S::Drowned && m.random.next_float() > 0.9 {
    // rust: m.extra.set_main_hand(Some(
    // rust: if m.random.next_int_bound(16).unwrap_or(1) < 10 {
    // rust: "minecraft:trident"
    // rust: } else {
    // rust: "minecraft:fishing_rod"
}
    // rust: .into(),
    // rust: ));
}
    // rust: if m.species() == S::ZombieVillager {
    // rust: m.extra.variant = villager_type(biome);
    // rust: m.extra.variant2 = m.random.next_int_bound(15).unwrap_or(0) as u8;
}
}
        // ZombifiedPiglin.populateDefaultEquipmentSlots: a golden sword, or
        // one time in 20 a golden spear.
    // rust: S::ZombifiedPiglin => {
            // Zombie.finalizeSpawn's setCanBreakDoors.
    // rust: let can_break_doors = m.random.next_float() < difficulty.special() * 0.1;
    // rust: super::doors::set_can_break_doors(m, can_break_doors);
    // rust: let spear = m.random.next_int_bound(20).unwrap_or(1) == 0;
    // rust: m.extra.set_main_hand(Some(
    // rust: if spear {
    // rust: "minecraft:golden_spear"
    // rust: } else {
    // rust: "minecraft:golden_sword"
}
    // rust: .into(),
    // rust: ));
}
        // AbstractSkeleton.populateDefaultEquipmentSlots: armour, then a bow.
    // rust: S::Skeleton | S::Stray | S::Bogged | S::Parched => {
    // rust: populate_armor(m, difficulty);
    // rust: m.extra.set_main_hand(Some("minecraft:bow".into()));
    // rust: m.extra.pick_up_loot = m.random.next_float() < 0.55 * difficulty.special();
}
        // WitherSkeleton.populateDefaultEquipmentSlots: a stone sword only;
        // WitherSkeleton.finalizeSpawn then sets the attack damage base to 4.
    // rust: S::WitherSkeleton => {
    // rust: m.extra.set_main_hand(Some("minecraft:stone_sword".into()));
    // rust: m.extra.pick_up_loot = m.random.next_float() < 0.55 * difficulty.special();
    // rust: super::finalize::set_base(m, super::finalize::Attr::AttackDamage, 4.0);
}
    // rust: S::Pillager => {
    // rust: m.extra.set_main_hand(Some("minecraft:crossbow".into()));
    // rust: m.extra.pick_up_loot = true;
}
    // rust: S::Horse | S::Donkey | S::Mule | S::SkeletonHorse | S::ZombieHorse => {
    // rust: super::equine::finalize(m)
}
    // rust: S::Llama | S::TraderLlama => super::llama::finalize(m),
        // Camel.finalizeSpawn: standing, with fixed attributes.
    // rust: S::Camel | S::CamelHusk => super::camel::stand_up_instantly(m),
    // rust: S::Nautilus | S::ZombieNautilus => super::nautilus::finalize(m, biome.coral_nautilus),
    // rust: S::SulfurCube => super::sulfur_cube::finalize(m),
        // Piglin.createSpawnWeapon: half crossbows, half golden swords, and
        // each piece of golden armour one time in ten.
    // rust: S::Piglin if !m.is_baby() => {
    // rust: m.extra.pick_up_loot = true;
    // rust: for i in 0..4 {
    // rust: if m.random.next_float() < 0.1 {
    // rust: let (slot, piece) = match i {
    // rust: 0 => (&mut m.extra.head, "helmet"),
    // rust: 1 => (&mut m.extra.chest, "chestplate"),
    // rust: 2 => (&mut m.extra.legs, "leggings"),
    // rust: _ => (&mut m.extra.feet, "boots"),
}
    // rust: *slot = Some(format!("minecraft:golden_{piece}").into());
}
}
    // rust: let crossbow = m.random.next_float() < 0.5;
    // rust: m.extra.set_main_hand(Some(
    // rust: if crossbow {
    // rust: "minecraft:crossbow"
    // rust: } else {
    // rust: "minecraft:golden_sword"
}
    // rust: .into(),
    // rust: ));
}
    // rust: S::PiglinBrute => {
    // rust: m.extra.set_main_hand(Some("minecraft:golden_axe".into()));
    // rust: m.extra.pick_up_loot = true;
}
    // rust: S::Illusioner => super::illusioner::finalize(m),
    // rust: S::Vindicator => m.extra.set_main_hand(Some("minecraft:iron_axe".into())),
    // rust: S::Villager => {
    // rust: m.extra.variant = villager_type(biome);
    // rust: m.extra.pick_up_loot = true;
}
        // Fox.finalizeSpawn: the variant by biome, then the mouth's item.
    // rust: S::Fox => {
    // rust: m.extra.variant = u8::from(biome.snow_fox);
    // rust: m.extra.pick_up_loot = true;
    // rust: super::fox::populate_default_equipment(m);
}
    // rust: S::Panda | S::Dolphin => m.extra.pick_up_loot = true,
    // rust: S::Goat => super::finalize::goat_spawn(m),
    // rust: S::TropicalFish => super::aquatic::finalize(m),
        // Salmon.finalizeSpawn: a weighted size (small 30, medium 50, large 15).
    // rust: S::Salmon => {
    // rust: let r = m.random.next_int_bound(95).unwrap_or(0);
    // rust: m.extra.variant = if r < 30 {
    // rust: 0
    // rust: } else if r < 80 {
    // rust: 1
    // rust: } else {
    // rust: 2
}
}
    // rust: S::Slime | S::MagmaCube => super::cube::finalize(m),
    // rust: _ => {}
}
    // Zombie.finalizeSpawn ends with handleAttributes: the reinforcement
    // chance (and a leader's bonus) that `Zombie.hurtServer` reads.
    // rust: if matches!(
    // rust: m.species(),
    // rust: S::Zombie | S::Husk | S::Drowned | S::ZombieVillager | S::ZombifiedPiglin
    // rust: ) {
    // rust: super::finalize::zombie_attributes(
    // rust: m,
    // rust: difficulty.special(),
    // rust: super::finalize::Reason::Natural,
    // rust: );
}
}
/// A baby from `Animal.spawnChildFromBreeding`: `getBreedOffspring` creates
/// it without `finalizeSpawn`, so it never ran `Mob.finalizeSpawn`. Undoes
/// that part of `finalize`: no `random_spawn_bonus`, right-handed.
pub fn bred_offspring(m: *mut Mob) void {
}
//     use super::finalize::{Attr, remove_modifier};
    // rust: remove_modifier(m, Attr::FollowRange, "minecraft:random_spawn_bonus");
    // rust: m.extra.left_handed = false;
}
/// VillagerType.byBiome
pub fn villager_type(b: *BiomeFacts) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if b.desert {
    // rust: 1
    // rust: } else if b.jungle {
    // rust: 2
    // rust: } else if b.snowy {
    // rust: 4
    // rust: } else if b.swamp {
    // rust: 5
    // rust: } else if b.climate == Climate::Warm {
    // rust: 3
    // rust: } else if b.climate == Climate::Cold && b.temperature < 0.4 {
    // rust: 6
    // rust: } else {
    // rust: 0
}
}
    // rust: mod tests {
//     use super::*;
//     use crate::mobs::finalize::{Attr, has_modifier, value};

pub fn types() O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION);
    // rust: if !root.join("items.json").exists() {
    // rust: return None;
}
    // rust: Some(crate::mobs::MobTypes::load(&root).unwrap())
}
pub fn spawn(types: *crate::mobs::MobTypes, kind: []const u8, id: u32) M {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let kind = std::sync::Arc::new(types.types.get(kind).unwrap().clone());
    // rust: let mut m = Mob::new(
    // rust: id,
    // rust: kind,
    // rust: horizon_core::geometry::Vec3::new(0.5, 64.0, 0.5),
    // rust: 0.0,
    // rust: );
    // rust: let difficulty = LocalDifficulty::new(3, 0, 0, 1.0);
    // rust: finalize(&mut m, &BiomeFacts::default(), &difficulty);
    // rust: m
}
    /// #2783: `/summon`, eggs, spawners and natural spawns run
    /// `WitherSkeleton.finalizeSpawn`: attack damage base 4.0, not the
    /// default 2.0.
pub fn runtime_wither_skeletons_hit_for_four() void {
}
    // rust: let Some(types) = types() else { return };
    // rust: let w = spawn(&types, "minecraft:wither_skeleton", 1);
    // rust: assert_eq!(value(&w, Attr::AttackDamage), 4.0);
    // rust: assert_eq!(w.attrs.attack_damage, 4.0);
}
    /// #2783: runtime spawns run `Mob.finalizeSpawn`: the follow range
    /// bonus and 5 percent left-handed mobs.
pub fn runtime_spawns_run_the_mob_finalize_spawn() void {
}
    // rust: let Some(types) = types() else { return };
    // rust: let mut left = 0;
    // rust: for id in 1..=400 {
    // rust: let m = spawn(&types, "minecraft:skeleton", id);
    // rust: assert!(has_modifier(
    // rust: &m,
    // rust: Attr::FollowRange,
    // rust: "minecraft:random_spawn_bonus"
    // rust: ));
    // rust: left += usize::from(m.extra.left_handed);
}
        // 5 percent of 400 is 20.
    // rust: assert!((5..=40).contains(&left), "{left} of 400 left-handed");
        // A bred baby never ran it.
    // rust: let mut cow = spawn(&types, "minecraft:cow", 1);
    // rust: cow.extra.left_handed = true;
    // rust: bred_offspring(&mut cow);
    // rust: assert!(!has_modifier(
    // rust: &cow,
    // rust: Attr::FollowRange,
    // rust: "minecraft:random_spawn_bonus"
    // rust: ));
    // rust: assert!(!cow.extra.left_handed);
    // rust: assert_eq!(cow.attrs.follow_range, value(&cow, Attr::FollowRange));
        // CaveSpider.finalizeSpawn does not call super.
    // rust: let c = spawn(&types, "minecraft:cave_spider", 1);
    // rust: assert!(!has_modifier(
    // rust: &c,
    // rust: Attr::FollowRange,
    // rust: "minecraft:random_spawn_bonus"
    // rust: ));
}
    /// `Zombie` / `AbstractSkeleton` halloween garb: 25% of empty heads, never
    /// on other mobs, and not when it is not Halloween.
pub fn halloween_pumpkins_only_undead_on_halloween() void {
}
    // rust: let Some(types) = types() else { return };
    // rust: let mut pumpkins = 0;
    // rust: let mut lanterns = 0;
    // rust: for id in 1..=400 {
    // rust: let mut m = spawn(&types, "minecraft:skeleton", id);
    // rust: m.extra.head = None;
    // rust: let mut random = m.random.clone();
    // rust: crate::mobs::finalize::halloween_head(&mut m, &mut random, true);
    // rust: match m.extra.head.as_deref() {
    // rust: Some("minecraft:jack_o_lantern") => {
    // rust: pumpkins += 1;
    // rust: lanterns += 1;
    // rust: assert_eq!(crate::mobs::finalize::stored_drop_chance(&m, 5), 0.0);
}
    // rust: Some("minecraft:carved_pumpkin") => {
    // rust: pumpkins += 1;
    // rust: assert_eq!(crate::mobs::finalize::stored_drop_chance(&m, 5), 0.0);
}
    // rust: Some(other) => panic!("unexpected head {other}"),
    // rust: None => {}
}
}
    // rust: assert!(
    // rust: (70..=130).contains(&pumpkins),
    // rust: "{pumpkins} of 400 skeletons"
    // rust: );
    // rust: assert!(lanterns < pumpkins / 2, "{lanterns} lanterns of {pumpkins}");
    // rust: let mut m = spawn(&types, "minecraft:skeleton", 1);
    // rust: m.extra.head = None;
    // rust: let mut random = m.random.clone();
    // rust: crate::mobs::finalize::halloween_head(&mut m, &mut random, false);
    // rust: assert!(m.extra.head.is_none());
    // rust: let mut cow = spawn(&types, "minecraft:cow", 1);
    // rust: cow.extra.head = None;
    // rust: let mut random = cow.random.clone();
    // rust: crate::mobs::finalize::halloween_head(&mut cow, &mut random, true);
    // rust: assert!(cow.extra.head.is_none());
}
}
