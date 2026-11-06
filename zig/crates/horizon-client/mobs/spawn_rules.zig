//! Transpiled from Horizon Rust crate
//! Module: horizon-client_spawn_rules
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! `SpawnPlacements`: each entity type's placement type
//! (`SpawnPlacementTypes.isSpawnPositionOk`) and spawn predicate
//! (`checkSpawnRules`), read through [`SpawnLevel`] so the game's world and a
//! differential test world answer the same questions. Random draws follow
//! vanilla's order.
// use super::{Species, data};
// use crate::blocks::{BlockFacts, Fluid};
// use horizon_core::random::{RandomSource, slime_chunk_random};
// use horizon_world::registry::BlockStateId;

/// `EntitySpawnReason`.
pub const Reason = enum {
    Natural,
    ChunkGeneration,
    Spawner,
    TrialSpawner,
    Reinforcement,
    Patrol,
    Structure,
    Event,
    Command,
    SpawnItemUse,
    MobSummoned,
    Conversion,
    Breeding,
    Triggered,
    Jockey,
    Dispenser,
    Bucket,
    Load,
    DimensionTravel,
};
    // rust: impl Reason {
pub fn is_spawner(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: matches!(self, Self::Spawner | Self::TrialSpawner)
}
pub fn ignores_light(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self == Self::TrialSpawner
}
}
/// The dimension type's monster spawn light rules.
pub const Dimension = enum {
    Overworld,
    Nether,
    End,
};
    // rust: impl Dimension {
    /// `monster_spawn_block_light_limit`.
pub fn block_light_limit(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Nether => 15,
    // rust: _ => 0,
}
}
    /// `monster_spawn_light_level.sample`: uniform 0..=7 in the overworld.
pub fn light_test(self: *Self, random: *mut impl RandomSource) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Overworld => random.next_int_bound(8).unwrap_or(0),
    // rust: Self::Nether => 7,
    // rust: Self::End => 15,
}
}
}

/// What spawn checks read from a level.
    // rust: pub trait SpawnLevel {
pub fn state(self: *Self, x: i32, y: i32, z: i32) B;
pub fn facts(self: *Self) *;
pub fn mob_data(self: *Self) *;
pub fn block_tag(self: *Self, tag: []const u8, block: []const u8) b;
pub fn biome_tag(self: *Self, tag: []const u8, x: i32, y: i32, z: i32) b;
    /// `getBrightness(LightLayer.SKY / BLOCK)`.
pub fn sky_light(self: *Self, x: i32, y: i32, z: i32) i;
pub fn block_light(self: *Self, x: i32, y: i32, z: i32) i;
pub fn sky_darken(self: *Self) i;
pub fn thundering(self: *Self) b;
pub fn sea_level(self: *Self) i;
    /// `getHeight(WORLD_SURFACE, x, z)`: above the highest non-air block.
pub fn world_surface(self: *Self, x: i32, z: i32) i;
pub fn peaceful(self: *Self) b;
pub fn dimension(self: *Self) D;
    /// The `gameplay/surface_slime_spawn_chance` environment attribute.
pub fn surface_slime_chance(self: *Self, x: i32, y: i32, z: i32) f;
pub fn world_seed(self: *Self) i;
    /// `getNearestPlayer(x, y, z, distance, true) != null`: a survival or
    /// adventure player that close.
pub fn player_near(self: *Self, x: f64, y: f64, z: f64, distance: f64) b;
}

    // rust: fn name<L: SpawnLevel>(l: &L, x: i32, y: i32, z: i32) -> &str {
    // rust: &l.facts().get(l.state(x, y, z)).name
}
    // rust: fn fluid<L: SpawnLevel>(l: &L, x: i32, y: i32, z: i32) -> Fluid {
    // rust: l.facts().get(l.state(x, y, z)).fluid
}
    // rust: fn flags<L: SpawnLevel>(l: &L, x: i32, y: i32, z: i32) -> u16 {
    // rust: l.mob_data().state(l.state(x, y, z)).flags
}
    // rust: fn tag<L: SpawnLevel>(l: &L, tag: &str, x: i32, y: i32, z: i32) -> bool {
    // rust: l.block_tag(tag, name(l, x, y, z))
}
/// `getRawBrightness(pos, darkening)`.
    // rust: fn raw_brightness<L: SpawnLevel>(l: &L, x: i32, y: i32, z: i32, darkening: i32) -> i32 {
    // rust: l.block_light(x, y, z).max(l.sky_light(x, y, z) - darkening)
}
    // rust: fn can_see_sky<L: SpawnLevel>(l: &L, x: i32, y: i32, z: i32) -> bool {
    // rust: l.sky_light(x, y, z) >= 15
}
/// `LevelReader.canSeeSkyFromBelowWater`.
    // rust: fn can_see_sky_from_below_water<L: SpawnLevel>(l: &L, x: i32, y: i32, z: i32) -> bool {
    // rust: let sea = l.sea_level();
    // rust: if y >= sea {
    // rust: return can_see_sky(l, x, y, z);
}
    // rust: if !can_see_sky(l, x, sea, z) {
    // rust: return false;
}
    // rust: ((y + 1)..sea).all(|yy| {
    // rust: let f = l.facts().get(l.state(x, yy, z));
        // `BlockState.liquid()` is water, lava and the bubble column. Kelp,
        // seagrass and waterlogged blocks hold water and still stop the scan.
    // rust: f.dampening == 0 || liquid_block(&f.name)
    // rust: })
}
/// `BlockState.liquid()`: the three blocks whose property is set.
pub fn liquid_block(name: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: matches!(
    // rust: name,
    // rust: "minecraft:water" | "minecraft:lava" | "minecraft:bubble_column"
    // rust: )
}

/// `EntityType.fireImmune`.
pub fn fire_immune(s: Species) b {
    // Implementation ported from Horizon
    return undefined;
}
//     use Species as S;
    // rust: matches!(
    // rust: s,
    // rust: S::Blaze
    // rust: | S::Ghast
    // rust: | S::MagmaCube
    // rust: | S::Shulker
    // rust: | S::Strider
    // rust: | S::Vex
    // rust: | S::Warden
    // rust: | S::Wither
    // rust: | S::WitherSkeleton
    // rust: | S::Zoglin
    // rust: | S::ZombifiedPiglin
    // rust: )
}
/// `EntityType.isAllowedInPeaceful`.
pub fn allowed_in_peaceful(s: Species) b {
    // Implementation ported from Horizon
    return undefined;
}
//     use Species as S;
    // rust: !matches!(
    // rust: s,
    // rust: S::Blaze
    // rust: | S::Bogged
    // rust: | S::Breeze
    // rust: | S::CaveSpider
    // rust: | S::Creaking
    // rust: | S::Creeper
    // rust: | S::Drowned
    // rust: | S::ElderGuardian
    // rust: | S::Enderman
    // rust: | S::Endermite
    // rust: | S::Evoker
    // rust: | S::Ghast
    // rust: | S::Giant
    // rust: | S::Guardian
    // rust: | S::Hoglin
    // rust: | S::Husk
    // rust: | S::Illusioner
    // rust: | S::MagmaCube
    // rust: | S::Parched
    // rust: | S::Phantom
    // rust: | S::PiglinBrute
    // rust: | S::Pillager
    // rust: | S::Ravager
    // rust: | S::Silverfish
    // rust: | S::Skeleton
    // rust: | S::Slime
    // rust: | S::Spider
    // rust: | S::Stray
    // rust: | S::Vex
    // rust: | S::Vindicator
    // rust: | S::Warden
    // rust: | S::Witch
    // rust: | S::Wither
    // rust: | S::WitherSkeleton
    // rust: | S::Zoglin
    // rust: | S::Zombie
    // rust: | S::ZombieVillager
    // rust: | S::ZombifiedPiglin
    // rust: )
}
/// The block tag an entity type is `immuneTo`.
pub fn immune_tag(s: Species) O {
    // Implementation ported from Horizon
    return undefined;
}
//     use Species as S;
    // rust: match s {
    // rust: S::Fox => Some("minecraft:fox_immune_to"),
    // rust: S::PolarBear => Some("minecraft:polar_bear_immune_to"),
    // rust: S::SnowGolem => Some("minecraft:snow_golem_immune_to"),
    // rust: S::Stray => Some("minecraft:stray_immune_to"),
    // rust: S::Wither => Some("minecraft:wither_immune_to"),
    // rust: S::WitherSkeleton => Some("minecraft:wither_skeleton_immune_to"),
    // rust: _ => None,
}
}
/// `BlockState.isValidSpawn(level, pos, type)` for the block at a position.
    // rust: pub fn is_valid_spawn<L: SpawnLevel>(s: Species, l: &L, x: i32, y: i32, z: i32) -> bool {
    // rust: if name(l, x, y, z) == "minecraft:magma_block" {
    // rust: return fire_immune(s);
}
    // rust: let bit = match s {
    // rust: Species::Ocelot | Species::Parrot => data::VALID_SPAWN_LEAVES,
    // rust: Species::PolarBear => data::VALID_SPAWN_ICE,
    // rust: _ => data::VALID_SPAWN,
}
    // rust: flags(l, x, y, z) & bit != 0
}
/// `NaturalSpawner.isValidEmptySpawnBlock` for an entity type.
    // rust: pub fn is_valid_empty_spawn<L: SpawnLevel>(s: Species, l: &L, x: i32, y: i32, z: i32) -> bool {
    // The exported flag is the zombie's answer; only blocks a zombie finds
    // dangerous can answer differently for another type.
    // rust: if flags(l, x, y, z) & data::VALID_EMPTY_SPAWN != 0 {
    // rust: return true;
}
    // rust: let f = l.facts().get(l.state(x, y, z));
    // rust: let block = &*f.name;
    // rust: let burning = l.block_tag("minecraft:fire", block)
    // rust: || block == "minecraft:lava"
    // rust: || block == "minecraft:magma_block"
    // rust: || (block == "minecraft:campfire" || block == "minecraft:soul_campfire") && f.emission > 0
    // rust: || block == "minecraft:lava_cauldron";
    // rust: let other = matches!(
    // rust: block,
    // rust: "minecraft:wither_rose"
    // rust: | "minecraft:sweet_berry_bush"
    // rust: | "minecraft:cactus"
    // rust: | "minecraft:powder_snow"
    // rust: );
    // rust: if !burning && !other {
    // rust: return false;
}
    // rust: let immune = immune_tag(s).is_some_and(|t| l.block_tag(t, block));
    // rust: let dangerous = !immune && (burning && !fire_immune(s) || other);
    // rust: !dangerous
    // rust: && !f.full_collision
    // rust: && f.fluid == Fluid::None
    // rust: && !l.block_tag("minecraft:prevent_mob_spawning_inside", block)
}
/// `SpawnPlacements.isSpawnPositionOk`.
    // rust: pub fn is_spawn_position_ok<L: SpawnLevel>(s: Species, l: &L, x: i32, y: i32, z: i32) -> bool {
    // rust: match l.mob_data().species_placement(s) {
    // rust: data::Placement::OnGround => {
    // rust: is_valid_spawn(s, l, x, y - 1, z)
    // rust: && is_valid_empty_spawn(s, l, x, y, z)
    // rust: && is_valid_empty_spawn(s, l, x, y + 1, z)
}
    // rust: data::Placement::InWater => {
    // rust: fluid(l, x, y, z) == Fluid::Water
    // rust: && flags(l, x, y + 1, z) & data::REDSTONE_CONDUCTOR == 0
}
    // rust: data::Placement::InLava => fluid(l, x, y, z) == Fluid::Lava,
    // rust: data::Placement::NoRestrictions => true,
}
}
/// `Monster.isDarkEnoughToSpawn`.
    // rust: pub fn is_dark_enough<L: SpawnLevel>(
    // rust: l: &L,
    // rust: random: &mut impl RandomSource,
    // rust: x: i32,
    // rust: y: i32,
    // rust: z: i32,
    // rust: ) -> bool {
    // rust: if l.sky_light(x, y, z) > random.next_int_bound(32).unwrap_or(0) {
    // rust: return false;
}
    // rust: let dim = l.dimension();
    // rust: let limit = dim.block_light_limit();
    // rust: if limit < 15 && l.block_light(x, y, z) > limit {
    // rust: return false;
}
    // rust: let darken = if l.thundering() { 10 } else { l.sky_darken() };
    // rust: let brightness = raw_brightness(l, x, y, z, darken);
    // rust: brightness <= dim.light_test(random)
}
/// `Animal.isBrightEnoughToSpawn`.
    // rust: fn bright<L: SpawnLevel>(l: &L, x: i32, y: i32, z: i32) -> bool {
    // rust: raw_brightness(l, x, y, z, 0) > 8
}
/// `Mob.checkMobSpawnRules`.
    // rust: fn mob_rules<L: SpawnLevel>(s: Species, l: &L, reason: Reason, x: i32, y: i32, z: i32) -> bool {
    // rust: reason.is_spawner() || is_valid_spawn(s, l, x, y - 1, z)
}
/// `Monster.checkMonsterSpawnRules`.
    // rust: fn monster_rules<L: SpawnLevel>(
    // rust: s: Species,
    // rust: l: &L,
    // rust: reason: Reason,
    // rust: random: &mut impl RandomSource,
    // rust: x: i32,
    // rust: y: i32,
    // rust: z: i32,
    // rust: ) -> bool {
    // rust: (reason.ignores_light() || is_dark_enough(l, random, x, y, z))
    // rust: && mob_rules(s, l, reason, x, y, z)
}
/// `Animal.checkAnimalSpawnRules` with the given spawnable-on tag.
    // rust: fn animal_rules<L: SpawnLevel>(l: &L, reason: Reason, on: &str, x: i32, y: i32, z: i32) -> bool {
    // rust: let bright = reason.ignores_light() || bright(l, x, y, z);
    // rust: tag(l, on, x, y - 1, z) && bright
}
/// `WaterAnimal.checkSurfaceWaterAnimalSpawnRules`.
    // rust: fn surface_water<L: SpawnLevel>(l: &L, x: i32, y: i32, z: i32) -> bool {
    // rust: let sea = l.sea_level();
    // rust: y >= sea - 13
    // rust: && y <= sea
    // rust: && fluid(l, x, y - 1, z) == Fluid::Water
    // rust: && name(l, x, y + 1, z) == "minecraft:water"
}

/// `SpawnPlacements.checkSpawnRules`.
    // rust: pub fn check_spawn_rules<L: SpawnLevel>(
    // rust: s: Species,
    // rust: l: &L,
    // rust: reason: Reason,
    // rust: random: &mut impl RandomSource,
    // rust: x: i32,
    // rust: y: i32,
    // rust: z: i32,
    // rust: ) -> bool {
//     use Species as S;
    // rust: if !allowed_in_peaceful(s) && l.peaceful() {
    // rust: return false;
}
    // rust: let below = |l: &L| name(l, x, y - 1, z).to_owned();
    // rust: match s {
    // rust: S::Axolotl => tag(l, "minecraft:axolotls_spawnable_on", x, y - 1, z),
    // rust: S::Cod | S::Pufferfish | S::Salmon | S::Dolphin | S::Squid => surface_water(l, x, y, z),
    // rust: S::Drowned => {
    // rust: if fluid(l, x, y - 1, z) != Fluid::Water && !reason.is_spawner() {
    // rust: return false;
}
    // rust: let frequent = l.biome_tag("minecraft:more_frequent_drowned_spawns", x, y, z);
    // rust: let can_spawn = !l.peaceful()
    // rust: && (reason.ignores_light() || is_dark_enough(l, random, x, y, z))
    // rust: && (reason.is_spawner() || fluid(l, x, y, z) == Fluid::Water);
    // rust: if !can_spawn || !reason.is_spawner() && reason != Reason::Reinforcement {
    // rust: if frequent {
    // rust: random.next_int_bound(15).unwrap_or(1) == 0 && can_spawn
    // rust: } else {
    // rust: random.next_int_bound(40).unwrap_or(1) == 0
    // rust: && y < l.sea_level() - 5
    // rust: && can_spawn
}
    // rust: } else {
    // rust: true
}
}
    // rust: S::Guardian | S::ElderGuardian => {
    // rust: (random.next_int_bound(20).unwrap_or(1) == 0
    // rust: || !can_see_sky_from_below_water(l, x, y, z))
    // rust: && !l.peaceful()
    // rust: && (reason.is_spawner() || fluid(l, x, y, z) == Fluid::Water)
    // rust: && fluid(l, x, y - 1, z) == Fluid::Water
}
    // rust: S::TropicalFish => {
    // rust: fluid(l, x, y - 1, z) == Fluid::Water
    // rust: && name(l, x, y + 1, z) == "minecraft:water"
    // rust: && (l.biome_tag(
    // rust: "minecraft:allows_tropical_fish_spawns_at_any_height",
    // rust: x,
    // rust: y,
    // rust: z,
    // rust: ) || surface_water(l, x, y, z))
}
    // rust: S::Armadillo => {
    // rust: tag(l, "minecraft:armadillo_spawnable_on", x, y - 1, z) && bright(l, x, y, z)
}
    // rust: S::Bat => {
    // rust: if y >= l.world_surface(x, z) || random.next_boolean() {
    // rust: return false;
}
    // rust: if raw_brightness(l, x, y, z, l.sky_darken()) > random.next_int_bound(4).unwrap_or(0) {
    // rust: return false;
}
    // rust: tag(l, "minecraft:bats_spawnable_on", x, y - 1, z) && mob_rules(s, l, reason, x, y, z)
}
    // rust: S::Blaze | S::Breeze | S::Zoglin => mob_rules(s, l, reason, x, y, z),
    // rust: S::Camel => tag(l, "minecraft:camels_spawnable_on", x, y - 1, z) && bright(l, x, y, z),
    // rust: S::CamelHusk | S::Husk | S::Parched => {
    // rust: monster_rules(s, l, reason, random, x, y, z)
    // rust: && (reason.is_spawner() || can_see_sky(l, x, y, z))
}
    // rust: S::Chicken
    // rust: | S::Cow
    // rust: | S::Donkey
    // rust: | S::HappyGhast
    // rust: | S::Horse
    // rust: | S::Llama
    // rust: | S::Mule
    // rust: | S::Pig
    // rust: | S::Sheep
    // rust: | S::Cat
    // rust: | S::Panda
    // rust: | S::TraderLlama => animal_rules(l, reason, "minecraft:animals_spawnable_on", x, y, z),
    // rust: S::Endermite | S::Silverfish => {
    // rust: if !mob_rules(s, l, reason, x, y, z) {
    // rust: return false;
}
    // rust: reason.is_spawner()
    // rust: || !l.player_near(
    // rust: f64::from(x) + 0.5,
    // rust: f64::from(y) + 0.5,
    // rust: f64::from(z) + 0.5,
    // rust: 5.0,
    // rust: )
}
    // rust: S::IronGolem
    // rust: | S::SnowGolem
    // rust: | S::Villager
    // rust: | S::Phantom
    // rust: | S::Shulker
    // rust: | S::WanderingTrader => mob_rules(s, l, reason, x, y, z),
    // rust: S::Frog => tag(l, "minecraft:frogs_spawnable_on", x, y - 1, z) && bright(l, x, y, z),
    // rust: S::Ghast => {
    // rust: !l.peaceful()
    // rust: && random.next_int_bound(20).unwrap_or(1) == 0
    // rust: && mob_rules(s, l, reason, x, y, z)
}
    // rust: S::GlowSquid => {
    // rust: y <= l.sea_level() - 33
    // rust: && raw_brightness(l, x, y, z, 0) == 0
    // rust: && name(l, x, y, z) == "minecraft:water"
}
    // rust: S::Goat => tag(l, "minecraft:goats_spawnable_on", x, y - 1, z) && bright(l, x, y, z),
    // rust: S::MagmaCube => !l.peaceful(),
    // rust: S::SulfurCube => true,
    // rust: S::Mooshroom => {
    // rust: tag(l, "minecraft:mooshrooms_spawnable_on", x, y - 1, z) && bright(l, x, y, z)
}
    // rust: S::Nautilus => {
    // rust: let sea = l.sea_level();
    // rust: y >= sea - 25
    // rust: && y <= sea - 5
    // rust: && fluid(l, x, y - 1, z) == Fluid::Water
    // rust: && name(l, x, y + 1, z) == "minecraft:water"
}
    // rust: S::Ocelot => random.next_int_bound(3).unwrap_or(0) != 0,
    // rust: S::Parrot => tag(l, "minecraft:parrots_spawnable_on", x, y - 1, z) && bright(l, x, y, z),
    // rust: S::Hoglin | S::Piglin => below(l) != "minecraft:nether_wart_block",
    // rust: S::Pillager => l.block_light(x, y, z) <= 8 && mob_rules(s, l, reason, x, y, z),
    // rust: S::PolarBear => {
    // rust: if l.biome_tag("minecraft:polar_bears_spawn_on_alternate_blocks", x, y, z) {
    // rust: bright(l, x, y, z)
    // rust: && tag(
    // rust: l,
    // rust: "minecraft:polar_bears_spawnable_on_alternate",
    // rust: x,
    // rust: y - 1,
    // rust: z,
    // rust: )
    // rust: } else {
    // rust: animal_rules(l, reason, "minecraft:animals_spawnable_on", x, y, z)
}
}
    // rust: S::Rabbit => tag(l, "minecraft:rabbits_spawnable_on", x, y - 1, z) && bright(l, x, y, z),
    // rust: S::SkeletonHorse => {
    // rust: if reason.is_spawner() {
    // rust: reason.ignores_light() || bright(l, x, y, z)
    // rust: } else {
    // rust: animal_rules(l, reason, "minecraft:animals_spawnable_on", x, y, z)
}
}
    // rust: S::Slime => slime_rules(s, l, reason, random, x, y, z),
    // rust: S::Stray => {
    // rust: let mut sky = y + 1;
    // rust: while name(l, x, sky, z) == "minecraft:powder_snow" {
    // rust: sky += 1;
}
    // rust: monster_rules(s, l, reason, random, x, y, z)
    // rust: && (reason.is_spawner() || can_see_sky(l, x, sky - 1, z))
}
    // rust: S::Strider => {
    // rust: let mut up = y + 1;
    // rust: while fluid(l, x, up, z) == Fluid::Lava {
    // rust: up += 1;
}
    // rust: l.facts().is_air(l.state(x, up, z))
}
    // rust: S::Turtle => {
    // rust: y < l.sea_level() + 4 && tag(l, "minecraft:sand", x, y - 1, z) && bright(l, x, y, z)
}
    // rust: S::Wolf => tag(l, "minecraft:wolves_spawnable_on", x, y - 1, z) && bright(l, x, y, z),
    // rust: S::ZombifiedPiglin => !l.peaceful() && below(l) != "minecraft:nether_wart_block",
    // rust: S::Fox => tag(l, "minecraft:foxes_spawnable_on", x, y - 1, z) && bright(l, x, y, z),
    // rust: S::Bogged
    // rust: | S::CaveSpider
    // rust: | S::Creeper
    // rust: | S::Enderman
    // rust: | S::Giant
    // rust: | S::Skeleton
    // rust: | S::Spider
    // rust: | S::Witch
    // rust: | S::Wither
    // rust: | S::WitherSkeleton
    // rust: | S::Creaking
    // rust: | S::Zombie
    // rust: | S::ZombieHorse
    // rust: | S::ZombieVillager
    // rust: | S::Evoker
    // rust: | S::Illusioner
    // rust: | S::Ravager
    // rust: | S::Vex
    // rust: | S::Vindicator
    // rust: | S::Warden => monster_rules(s, l, reason, random, x, y, z),
        // Types without a SpawnPlacements registration.
    // rust: _ => true,
}
}
/// `Slime.checkSlimeSpawnRules`.
    // rust: fn slime_rules<L: SpawnLevel>(
    // rust: s: Species,
    // rust: l: &L,
    // rust: reason: Reason,
    // rust: random: &mut impl RandomSource,
    // rust: x: i32,
    // rust: y: i32,
    // rust: z: i32,
    // rust: ) -> bool {
    // rust: if l.peaceful() {
    // rust: return false;
}
    // rust: if reason.is_spawner() {
    // rust: return mob_rules(s, l, reason, x, y, z);
}
    // rust: if l.biome_tag("minecraft:allows_surface_slime_spawns", x, y, z) && y > 50 && y < 70 {
    // rust: let chance = l.surface_slime_chance(x, y, z);
    // rust: if random.next_float() < chance
    // rust: && raw_brightness(l, x, y, z, l.sky_darken()) <= random.next_int_bound(8).unwrap_or(0)
    // rust: {
    // rust: return mob_rules(s, l, reason, x, y, z);
}
}
    // rust: let slime_chunk = slime_chunk_random(x >> 4, z >> 4, l.world_seed(), 987_234_911)
    // rust: .next_int_bound(10)
    // rust: .unwrap_or(1)
    // rust: == 0;
    // rust: if random.next_int_bound(10).unwrap_or(1) == 0 && slime_chunk && y < 40 {
    // rust: return mob_rules(s, l, reason, x, y, z);
}
    // rust: false
}

    // rust: impl SpawnLevel for super::MobWorld<'_> {
pub fn state(self: *Self, x: i32, y: i32, z: i32) B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.world.block(x, y, z)
}
pub fn facts(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.facts
}
pub fn mob_data(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.data
}
pub fn block_tag(self: *Self, tag: []const u8, block: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.has_tag(tag, block)
}
pub fn biome_tag(self: *Self, tag: []const u8, x: i32, y: i32, z: i32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(chunk) = self.world.chunks.get(&(x >> 4, z >> 4)) else {
    // rust: return false;
}
    // rust: let biome = &self.biomes.get(chunk.biome(x, y, z)).name;
    // rust: self.data
    // rust: .biome_tags
    // rust: .get(tag.trim_start_matches('#'))
    // rust: .is_some_and(|members| members.contains(biome))
}
pub fn sky_light(self: *Self, x: i32, y: i32, z: i32) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.nether || self.end {
    // rust: return 0;
}
    // rust: i32::from(self.world.light(x, y, z) >> 4)
}
pub fn block_light(self: *Self, x: i32, y: i32, z: i32) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: i32::from(self.world.light(x, y, z) & 15)
}
pub fn sky_darken(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: super::MobWorld::sky_darken(self)
}
pub fn thundering(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.thundering
}
pub fn sea_level(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.sea_level
}
pub fn world_surface(self: *Self, x: i32, z: i32) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.world.world_surface(x, z, |id| self.facts.is_air(id))
}
pub fn peaceful(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.difficulty.effective == 0.0
}
pub fn dimension(self: *Self) D {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.nether {
    // rust: Dimension::Nether
    // rust: } else if self.end {
    // rust: Dimension::End
    // rust: } else {
    // rust: Dimension::Overworld
}
}
pub fn surface_slime_chance(self: *Self, _: i32, _: i32, _: i32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let phase = self.day_time.div_euclid(24000).rem_euclid(8) as usize;
    // rust: 0.5 * super::spawning::MOON_BRIGHTNESS[phase]
}
pub fn world_seed(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.world_seed
}
pub fn player_near(self: *Self, x: f64, y: f64, z: f64, distance: f64) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.player.as_ref().is_some_and(|p| {
    // rust: let d = (p.position.x - x).powi(2)
    // rust: + (p.position.y - y).powi(2)
    // rust: + (p.position.z - z).powi(2);
    // rust: p.alive && !p.creative && !p.spectator && d < distance * distance
    // rust: })
}
}

    // rust: mod underwater_sky_tests {
//     use super::*;
//     use crate::mobs::world::with_built_test_world;
//     use horizon_core::random::LegacyRandom;
//     use horizon_world::{block_state_properties::BlockProperties, chunk::BlockState};

    // rust: fn with_props(
    // rust: registry: &horizon_world::registry::BlockRegistry,
    // rust: name: &str,
    // rust: props: &[(&str, &str)],
    // rust: ) -> horizon_world::registry::BlockStateId {
    // rust: let mut properties = BlockProperties::new();
    // rust: for (key, value) in props {
    // rust: properties.insert((*key).to_owned(), (*value).to_owned());
}
    // rust: registry
    // rust: .resolve(&BlockState {
    // rust: name: format!("minecraft:{name}"),
    // rust: properties,
    // rust: })
    // rust: .unwrap()
}

    /// `Guardian.checkGuardianSpawnRules`: below sea level the 1-in-20 roll is
    /// skipped when `canSeeSkyFromBelowWater` is false. Kelp (dampening 1, not
    /// `liquid()`) makes it false. A bubble column is `liquid()`, so the scan
    /// continues and the roll is still required.
pub fn kelp_hides_the_sky_from_a_guardian_and_a_bubble_column_does_not() void {
}
    // rust: let ran = with_built_test_world(
    // rust: &[],
    // rust: |world, registry| {
    // rust: world.chunks.insert(
    // rust: (0, 0),
    // rust: std::sync::Arc::new(crate::chunk::Chunk::empty(0, 0)),
    // rust: );
    // rust: let water = registry.default_state("minecraft:water").unwrap();
    // rust: let kelp = with_props(registry, "kelp", &[("age", "0")]);
    // rust: let column = with_props(registry, "bubble_column", &[("drag", "true")]);
    // rust: for x in [0, 1] {
    // rust: world.set(x, 49, 0, water).unwrap();
    // rust: world.set(x, 50, 0, water).unwrap();
}
    // rust: world.set(0, 55, 0, kelp).unwrap();
    // rust: world.set(1, 55, 0, column).unwrap();
    // rust: },
    // rust: |w, _| {
                // Sea level in this world is 63, so y=55 sits in the scan.
    // rust: assert_eq!(w.sea_level(), 63);
    // rust: let mut probe = LegacyRandom::new(1);
    // rust: assert_ne!(
    // rust: probe.next_int_bound(20).unwrap(),
    // rust: 0,
    // rust: "seed 1 must miss the 1-in-20"
    // rust: );
    // rust: let mut random = LegacyRandom::new(1);
    // rust: assert!(
    // rust: check_spawn_rules(Species::Guardian, w, Reason::Natural, &mut random, 0, 50, 0),
    // rust: "kelp between the guardian and the sea hides the sky"
    // rust: );
    // rust: let mut random = LegacyRandom::new(1);
    // rust: assert!(
    // rust: !check_spawn_rules(
    // rust: Species::Guardian,
    // rust: w,
    // rust: Reason::Natural,
    // rust: &mut random,
    // rust: 1,
    // rust: 50,
    // rust: 0
    // rust: ),
    // rust: "a bubble column is liquid(), so the sky still shows"
    // rust: );
    // rust: },
    // rust: );
        // Without the vanilla data under .local/horizon-client the world
        // cannot be built: the test has nothing to check.
    // rust: let _ = ran;
}
}
