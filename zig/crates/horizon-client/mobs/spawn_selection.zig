//! Transpiled from Horizon Rust crate
//! Module: horizon-client_spawn_selection
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! `NaturalSpawner`: which mob spawns where and when. The spawn state
//! (`createState`: category counts, the spawn potential's charges, the
//! per-player local caps), the filtered categories and their global and local
//! caps, `spawnForChunk` and `spawnCategoryForPosition` (the three packs of up
//! to four attempts, the distance and respawn checks, `getRandomSpawnMobAt`
//! over `mobsAt`: the nether fortress bounds, structure spawn overrides by
//! piece or bounding box, then the biome's natural mob spawns), the per-type
//! checks of `isValidSpawnPostitionForType` and `isValidPositionForMob`
//! (each class's `checkSpawnRules` walk target value, `checkSpawnObstruction`,
//! `removeWhenFarAway`, cluster and group sizes), and
//! `spawnMobsForChunkGeneration`. Everything reads the level through
//! [`NaturalLevel`] so the game and the differential test world
//! (tools/test_natural_spawn_parity.py) run the same code; random draws follow
//! vanilla's order.
// use super::Species;
// use super::spawn_rules::{self, Reason, SpawnLevel};
// use crate::biome::SpawnEntry;
// use crate::fast_hash::FxHashMap;
// use horizon_core::{
    // rust: geometry::{Aabb, Vec3},
    // rust: random::RandomSource,
}
// use serde_json::Value;
// use std::{borrow::Cow, collections::HashMap, fs, path::Path};

    // rust: pub use crate::biome::{SpawnCost, parse_costs, parse_entries};

    // rust: thread_local! {
pub const ATTEMPT_COUNTS: std::cell::Cell<[u64; 2]> = const { std::cell::Cell::new([0; 2]) };
}
/// Reset or publish once per natural-spawn tick, not once per chunk.
pub fn attempt_counters(publish: bool) void {
}
    // rust: if !crate::spans::enabled() {
    // rust: return;
}
    // rust: let counts = ATTEMPT_COUNTS.with(|c| c.replace([0; 2]));
    // rust: if publish {
    // rust: crate::spans::counters(&[("sa_attempts", counts[0]), ("sa_spawns", counts[1])]);
}
}
pub fn attempt_count(index: usize) void {
}
    // rust: if crate::spans::enabled() {
    // rust: ATTEMPT_COUNTS.with(|c| {
    // rust: let mut counts = c.get();
    // rust: counts[index] += 1;
    // rust: c.set(counts);
    // rust: });
}
}

/// `MobCategory`.
pub const Category = enum {
    Monster,
    Creature,
    Ambient,
    Axolotls,
    UndergroundWaterCreature,
    WaterCreature,
    WaterAmbient,
    Misc,
};
    // rust: impl Category {
    // rust: pub const ALL: [Self; 8] = [
    // rust: Self::Monster,
    // rust: Self::Creature,
    // rust: Self::Ambient,
    // rust: Self::Axolotls,
    // rust: Self::UndergroundWaterCreature,
    // rust: Self::WaterCreature,
    // rust: Self::WaterAmbient,
    // rust: Self::Misc,
    // rust: ];
    /// `NaturalSpawner.SPAWNING_CATEGORIES`: all but MISC, in enum order.
    // rust: pub const SPAWNING: [Self; 7] = [
    // rust: Self::Monster,
    // rust: Self::Creature,
    // rust: Self::Ambient,
    // rust: Self::Axolotls,
    // rust: Self::UndergroundWaterCreature,
    // rust: Self::WaterCreature,
    // rust: Self::WaterAmbient,
    // rust: ];
pub fn name(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Monster => "monster",
    // rust: Self::Creature => "creature",
    // rust: Self::Ambient => "ambient",
    // rust: Self::Axolotls => "axolotls",
    // rust: Self::UndergroundWaterCreature => "underground_water_creature",
    // rust: Self::WaterCreature => "water_creature",
    // rust: Self::WaterAmbient => "water_ambient",
    // rust: Self::Misc => "misc",
}
}
pub fn from_name(name: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::ALL
    // rust: .into_iter()
    // rust: .find(|c| c.name() == name)
    // rust: .unwrap_or(Self::Misc)
}
pub fn index(self: *Self) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self as usize
}
    /// `getMaxInstancesPerChunk`.
pub fn max(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Monster => 70,
    // rust: Self::Creature => 10,
    // rust: Self::Ambient => 15,
    // rust: Self::Axolotls | Self::UndergroundWaterCreature | Self::WaterCreature => 5,
    // rust: Self::WaterAmbient => 20,
    // rust: Self::Misc => -1,
}
}
pub fn friendly(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self != Self::Monster
}
pub fn persistent(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: matches!(self, Self::Creature | Self::Misc)
}
pub fn despawn_distance(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self == Self::WaterAmbient { 64 } else { 128 }
}
}

/// `PathfinderMob.checkSpawnRules`: the class's `getWalkTargetValue` at the
/// spawn position must not be negative (plain `Mob`s accept any position).
pub const WalkTarget = enum {
    NotPathfinder,
    Zero,
    Animal,
    Mooshroom,
    Turtle,
    Monster,
    Giant,
    Guardian,
    Silverfish,
    Strider,
    Hoglin,
    Bee,
    HappyGhast,
};
pub fn walk_target(s: Species) W {
    // Implementation ported from Horizon
    return undefined;
}
//     use Species as S;
//     use WalkTarget as W;
    // rust: match s {
    // rust: S::Bat | S::Slime | S::MagmaCube | S::SulfurCube | S::Ghast | S::Phantom => {
    // rust: W::NotPathfinder
}
        // Monster subclasses that override it with 0.
    // rust: S::Enderman | S::Creaking | S::Pillager | S::Warden => W::Zero,
    // rust: S::Giant => W::Giant,
    // rust: S::Guardian | S::ElderGuardian => W::Guardian,
    // rust: S::Silverfish => W::Silverfish,
    // rust: S::Zombie
    // rust: | S::Husk
    // rust: | S::Drowned
    // rust: | S::ZombieVillager
    // rust: | S::ZombifiedPiglin
    // rust: | S::Skeleton
    // rust: | S::Stray
    // rust: | S::Bogged
    // rust: | S::Parched
    // rust: | S::WitherSkeleton
    // rust: | S::Creeper
    // rust: | S::Spider
    // rust: | S::CaveSpider
    // rust: | S::Endermite
    // rust: | S::Witch
    // rust: | S::Vindicator
    // rust: | S::Evoker
    // rust: | S::Illusioner
    // rust: | S::Ravager
    // rust: | S::Piglin
    // rust: | S::PiglinBrute
    // rust: | S::Zoglin
    // rust: | S::Blaze
    // rust: | S::Vex
    // rust: | S::Breeze
    // rust: | S::Wither => W::Monster,
    // rust: S::Mooshroom => W::Mooshroom,
    // rust: S::Turtle => W::Turtle,
    // rust: S::Strider => W::Strider,
    // rust: S::Hoglin => W::Hoglin,
    // rust: S::Bee => W::Bee,
    // rust: S::HappyGhast => W::HappyGhast,
        // Animal subclasses with their own value.
    // rust: S::Axolotl | S::Nautilus | S::ZombieNautilus => W::Zero,
    // rust: S::Pig
    // rust: | S::Cow
    // rust: | S::Sheep
    // rust: | S::Chicken
    // rust: | S::Rabbit
    // rust: | S::Horse
    // rust: | S::Donkey
    // rust: | S::Mule
    // rust: | S::Llama
    // rust: | S::TraderLlama
    // rust: | S::SkeletonHorse
    // rust: | S::ZombieHorse
    // rust: | S::Camel
    // rust: | S::CamelHusk
    // rust: | S::Goat
    // rust: | S::Panda
    // rust: | S::PolarBear
    // rust: | S::Fox
    // rust: | S::Wolf
    // rust: | S::Cat
    // rust: | S::Ocelot
    // rust: | S::Parrot
    // rust: | S::Armadillo
    // rust: | S::Frog
    // rust: | S::Sniffer => W::Animal,
        // Other PathfinderMobs: water animals, golems, villagers, allays...
    // rust: _ => W::Zero,
}
}
/// Each class's `checkSpawnObstruction`.
pub const Obstruction = enum {
    /// `Mob`: no liquid in the box and no entity blocking it.
    NoLiquidUnobstructed,
    Unobstructed,
    Ocelot,
    NoLiquid,
};
pub fn obstruction(s: Species) O {
    // Implementation ported from Horizon
    return undefined;
}
//     use Species as S;
    // rust: match s {
    // rust: S::Squid
    // rust: | S::GlowSquid
    // rust: | S::Dolphin
    // rust: | S::Axolotl
    // rust: | S::Cod
    // rust: | S::Salmon
    // rust: | S::TropicalFish
    // rust: | S::Pufferfish
    // rust: | S::Tadpole
    // rust: | S::Nautilus
    // rust: | S::ZombieNautilus
    // rust: | S::Guardian
    // rust: | S::ElderGuardian
    // rust: | S::Strider
    // rust: | S::Drowned => Obstruction::Unobstructed,
    // rust: S::Ocelot => Obstruction::Ocelot,
    // rust: S::Ravager => Obstruction::NoLiquid,
        // ZombifiedPiglin's override is the Mob default's two tests; iron
        // golems and wardens never spawn naturally.
    // rust: _ => Obstruction::NoLiquidUnobstructed,
}
}
/// `Mob.removeWhenFarAway` of a freshly created mob.
pub fn removed_when_far(s: Species) b {
    // Implementation ported from Horizon
    return undefined;
}
//     use Species as S;
    // rust: match s {
        // Animal, golems, villagers, traders, allays and wardens never;
        // cats and ocelots only past 2400 ticks; chickens as jockeys.
    // rust: S::Axolotl
    // rust: | S::Cod
    // rust: | S::Salmon
    // rust: | S::TropicalFish
    // rust: | S::Pufferfish
    // rust: | S::Tadpole
    // rust: | S::CamelHusk
    // rust: | S::ZombieHorse
    // rust: | S::Hoglin
    // rust: | S::Nautilus
    // rust: | S::ZombieNautilus => true,
    // rust: S::Villager
    // rust: | S::WanderingTrader
    // rust: | S::IronGolem
    // rust: | S::SnowGolem
    // rust: | S::Shulker
    // rust: | S::Allay
    // rust: | S::Warden => false,
    // rust: _ => !is_animal(s),
}
}
pub fn is_animal(s: Species) b {
    // Implementation ported from Horizon
    return undefined;
}
//     use Species as S;
    // rust: matches!(walk_target(s), WalkTarget::Animal)
    // rust: || matches!(
    // rust: s,
    // rust: S::Axolotl
    // rust: | S::Nautilus
    // rust: | S::ZombieNautilus
    // rust: | S::Mooshroom
    // rust: | S::Turtle
    // rust: | S::Strider
    // rust: | S::Hoglin
    // rust: | S::Bee
    // rust: | S::HappyGhast
    // rust: )
}
/// `Mob.getMaxSpawnClusterSize`.
pub fn max_cluster_size(s: Species) u {
    // Implementation ported from Horizon
    return undefined;
}
//     use Species as S;
    // rust: match s {
    // rust: S::Horse
    // rust: | S::Donkey
    // rust: | S::Mule
    // rust: | S::Llama
    // rust: | S::TraderLlama
    // rust: | S::SkeletonHorse
    // rust: | S::ZombieHorse
    // rust: | S::Camel
    // rust: | S::CamelHusk => 6,
    // rust: S::Cod | S::TropicalFish | S::Pufferfish | S::Tadpole | S::Wolf => 8,
    // rust: S::Salmon => 5,
    // rust: S::Ghast | S::HappyGhast | S::Pillager => 1,
    // rust: _ => 4,
}
}
/// `EntityType.canSpawnFarFromPlayer`: creatures, misc, pillagers, shulkers.
pub fn spawns_far_from_player(s: Species, category: Category) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: matches!(category, Category::Creature | Category::Misc)
    // rust: || matches!(s, Species::Pillager | Species::Shulker)
}

/// What natural spawning reads from a level beyond the spawn rules.
/// An entity type's species, width, height and category.
    // rust: pub type MobType = (Species, f32, f32, Category);

    // rust: pub trait NaturalLevel: SpawnLevel {
    /// Whether server mods hear `potential_spawns`.
pub fn spawn_hooks(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: false
}
    /// `LevelEvent.PotentialSpawns`: server mods change the possible spawns
    /// at a position.
    // rust: fn potential_spawns(
    // rust: &self,
    // rust: _category: Category,
    // rust: _pos: [i32; 3],
    // rust: _entries: &mut Vec<SpawnEntry>,
    // rust: ) {
}
pub fn min_y(self: *Self) i;
    /// `getMaxY()`: the highest buildable block.
pub fn max_y(self: *Self) i;
    /// `DimensionType.ambientLight`.
pub fn ambient_light(self: *Self) f;
pub fn has_ceiling(self: *Self) b;
    /// The entity type's species, width, height and category.
pub fn mob_type(self: *Self, entity: []const u8) O;
    /// The `natural_mob_spawns` lists by category at a position.
pub fn biome_spawns(self: *Self, x: i32, y: i32, z: i32) O;
    /// The `natural_mob_spawns` spawn cost of a type at a position.
pub fn spawn_cost(self: *Self, entity: []const u8, x: i32, y: i32, z: i32) O;
    /// The `creature_world_gen_spawn_probability` attribute at a position.
pub fn creature_probability(self: *Self, x: i32, y: i32, z: i32) f;
    /// Every structure whose references reach the position's chunk and
    /// whose id `wanted` takes, in the chunk's reference order.
    // rust: fn structures_at(
    // rust: &self,
    // rust: x: i32,
    // rust: y: i32,
    // rust: z: i32,
    // rust: wanted: &dyn Fn(&str) -> bool,
    // rust: ) -> Vec<StructureAt>;
pub fn structure_spawns(self: *Self) *;
    /// Where the players `getNearestPlayer(x, y, z, -1, false)` measures to
    /// are: every one that is not a spectator.
pub fn nearest_player_positions(self: *Self) *;
    /// The world spawn point, when it is in this dimension.
pub fn respawn(self: *Self) O;
    /// `ServerLevel.canSpawnEntitiesInChunk`.
pub fn can_spawn_in_chunk(self: *Self, cx: i32, cz: i32) b;
    /// `noCollision(null, box)`: blocks under an empty collision context and
    /// entities that can be collided with.
pub fn no_collision(self: *Self, bounds: Aabb) b;
    /// `isUnobstructed(entity)`: no entity blocking building overlaps.
pub fn unobstructed(self: *Self, bounds: Aabb) b;
    /// The `spawn_mobs` game rule.
pub fn spawn_mobs(self: *Self) b;
    /// `getHeight(heightmap, x, z)`.
pub fn heightmap(self: *Self, kind: Heightmap, x: i32, z: i32) i;
    /// `isPathfindable(PathComputationType.LAND)` of the block.
pub fn pathfindable_land(self: *Self, x: i32, y: i32, z: i32) b;
}

/// The heightmap types `SpawnPlacements` registers.
pub const Heightmap = enum {
    WorldSurface,
    OceanFloor,
    MotionBlocking,
    MotionBlockingNoLeaves,
};
    // rust: impl Heightmap {
pub fn from_name(name: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match name {
    // rust: "WORLD_SURFACE" => Self::WorldSurface,
    // rust: "OCEAN_FLOOR" => Self::OceanFloor,
    // rust: "MOTION_BLOCKING" => Self::MotionBlocking,
    // rust: _ => Self::MotionBlockingNoLeaves,
}
}
}

/// `Heightmap.Types`' predicates: WORLD_SURFACE (not air), OCEAN_FLOOR
/// (`#blocks_motion_in_heightmap`), MOTION_BLOCKING (that or a fluid) and
/// MOTION_BLOCKING_NO_LEAVES (`#blocks_motion_in_heightmap_no_leaves` or a fluid).
    // rust: pub fn heightmap_blocks<L: SpawnLevel>(l: &L, kind: Heightmap, x: i32, y: i32, z: i32) -> bool {
    // rust: let state = l.state(x, y, z);
    // rust: let f = l.facts().get(state);
    // rust: let fluid = f.fluid != crate::blocks::Fluid::None;
    // rust: match kind {
    // rust: Heightmap::WorldSurface => !l.facts().is_air(state),
    // rust: Heightmap::OceanFloor => l.block_tag("minecraft:blocks_motion_in_heightmap", &f.name),
    // rust: Heightmap::MotionBlocking => {
    // rust: fluid || l.block_tag("minecraft:blocks_motion_in_heightmap", &f.name)
}
    // rust: Heightmap::MotionBlockingNoLeaves => {
    // rust: fluid || l.block_tag("minecraft:blocks_motion_in_heightmap_no_leaves", &f.name)
}
}
}
/// `LevelReader.getLightLevelDependentMagicValue`.
    // rust: fn magic_light<L: NaturalLevel>(l: &L, x: i32, y: i32, z: i32) -> f32 {
    // rust: let raw = l
    // rust: .block_light(x, y, z)
    // rust: .max(l.sky_light(x, y, z) - l.sky_darken());
    // rust: let v = raw as f32 / 15.0;
    // rust: let curved = v / (4.0 - 3.0 * v);
    // rust: curved + l.ambient_light() * (1.0 - curved)
}
    // rust: fn cost_from_light<L: NaturalLevel>(l: &L, x: i32, y: i32, z: i32) -> f32 {
    // rust: magic_light(l, x, y, z) - 0.5
}
    // rust: fn name_at<L: NaturalLevel>(l: &L, x: i32, y: i32, z: i32) -> &str {
    // rust: &l.facts().get(l.state(x, y, z)).name
}
    // rust: fn fluid_at<L: NaturalLevel>(l: &L, x: i32, y: i32, z: i32) -> crate::blocks::Fluid {
    // rust: l.facts().get(l.state(x, y, z)).fluid
}
/// `checkSpawnRules(level, NATURAL)` of a freshly created mob at a block.
    // rust: pub(crate) fn mob_spawn_rules<L: NaturalLevel>(s: Species, l: &L, x: i32, y: i32, z: i32) -> bool {
//     use crate::blocks::Fluid;
    // rust: let value = match walk_target(s) {
    // rust: WalkTarget::NotPathfinder | WalkTarget::Zero => 0.0,
    // rust: WalkTarget::Animal => {
    // rust: if name_at(l, x, y - 1, z) == "minecraft:grass_block" {
    // rust: 10.0
    // rust: } else {
    // rust: cost_from_light(l, x, y, z)
}
}
    // rust: WalkTarget::Mooshroom => {
    // rust: if name_at(l, x, y - 1, z) == "minecraft:mycelium" {
    // rust: 10.0
    // rust: } else {
    // rust: cost_from_light(l, x, y, z)
}
}
    // rust: WalkTarget::Turtle => {
    // rust: if fluid_at(l, x, y, z) == Fluid::Water
    // rust: || l.block_tag("minecraft:sand", name_at(l, x, y - 1, z))
    // rust: {
    // rust: 10.0
    // rust: } else {
    // rust: cost_from_light(l, x, y, z)
}
}
    // rust: WalkTarget::Monster => -cost_from_light(l, x, y, z),
    // rust: WalkTarget::Giant => cost_from_light(l, x, y, z),
    // rust: WalkTarget::Guardian => {
    // rust: if fluid_at(l, x, y, z) == Fluid::Water {
    // rust: 10.0 + cost_from_light(l, x, y, z)
    // rust: } else {
    // rust: -cost_from_light(l, x, y, z)
}
}
    // rust: WalkTarget::Silverfish => {
    // rust: if infested_host(name_at(l, x, y - 1, z)) {
    // rust: 10.0
    // rust: } else {
    // rust: -cost_from_light(l, x, y, z)
}
}
        // A new strider is not in lava yet.
    // rust: WalkTarget::Strider => {
    // rust: if fluid_at(l, x, y, z) == Fluid::Lava {
    // rust: 10.0
    // rust: } else {
    // rust: 0.0
}
}
        // A new hoglin remembers no repellent.
    // rust: WalkTarget::Hoglin => {
    // rust: if name_at(l, x, y - 1, z) == "minecraft:crimson_nylium" {
    // rust: 10.0
    // rust: } else {
    // rust: 0.0
}
}
    // rust: WalkTarget::Bee => {
    // rust: if l.facts().is_air(l.state(x, y, z)) {
    // rust: 10.0
    // rust: } else {
    // rust: 0.0
}
}
    // rust: WalkTarget::HappyGhast => {
    // rust: let air = |dy| l.facts().is_air(l.state(x, y + dy, z));
    // rust: if !air(0) {
    // rust: 0.0
    // rust: } else if air(-1) && !air(-2) {
    // rust: 10.0
    // rust: } else {
    // rust: 5.0
}
}
}
    // rust: value >= 0.0
}
/// `InfestedBlock.isCompatibleHostBlock`.
pub fn infested_host(block: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: matches!(
    // rust: block,
    // rust: "minecraft:stone"
    // rust: | "minecraft:cobblestone"
    // rust: | "minecraft:stone_bricks"
    // rust: | "minecraft:mossy_stone_bricks"
    // rust: | "minecraft:cracked_stone_bricks"
    // rust: | "minecraft:chiseled_stone_bricks"
    // rust: | "minecraft:deepslate"
    // rust: )
}
/// `LevelReader.containsAnyLiquid`: the blocks from the box's minimum corner
/// to the block holding its maximum corner.
    // rust: pub fn contains_any_liquid<L: SpawnLevel>(l: &L, b: Aabb) -> bool {
    // rust: let (lo, hi) = (b.min_position(), b.max_position());
    // rust: let (x0, y0, z0) = (
    // rust: lo.x.floor() as i32,
    // rust: lo.y.floor() as i32,
    // rust: lo.z.floor() as i32,
    // rust: );
    // rust: let (x1, y1, z1) = (
    // rust: hi.x.floor() as i32,
    // rust: hi.y.floor() as i32,
    // rust: hi.z.floor() as i32,
    // rust: );
    // rust: (x0..=x1).any(|x| {
    // rust: (y0..=y1).any(|y| {
    // rust: (z0..=z1).any(|z| l.facts().get(l.state(x, y, z)).fluid != crate::blocks::Fluid::None)
    // rust: })
    // rust: })
}
/// `EntityDimensions.makeBoundingBox`: the half width is a float.
pub fn spawn_box(x: f64, y: f64, z: f64, width: f32, height: f32) A {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let half = f64::from(width / 2.0);
    // rust: Aabb::new(
    // rust: Vec3::new(x - half, y, z - half),
    // rust: Vec3::new(x + half, y + f64::from(height), z + half),
    // rust: )
}
/// `EntityType.spawnDimensionsScale`: cube mobs are checked for room at
/// their largest spawn size.
pub fn spawn_dimensions_scale(s: Species) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match s {
    // rust: Species::Slime | Species::MagmaCube => 4.0,
    // rust: Species::SulfurCube => 2.0,
    // rust: _ => 1.0,
}
}
/// `EntityType.getSpawnAABB`.
pub fn spawn_aabb(s: Species, x: f64, y: f64, z: f64, width: f32, height: f32) A {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let scale = spawn_dimensions_scale(s);
    // rust: let half = f64::from(scale * width / 2.0);
    // rust: Aabb::new(
    // rust: Vec3::new(x - half, y, z - half),
    // rust: Vec3::new(x + half, y + f64::from(scale * height), z + half),
    // rust: )
}
/// `checkSpawnObstruction` of a freshly created mob with the given box, with
/// the mobs already `spawned` in the way; None in a generation region, which
/// has no entities (`WorldGenRegion.getEntities`).
    // rust: pub(crate) fn spawn_obstruction<L: NaturalLevel>(
    // rust: s: Species,
    // rust: l: &L,
    // rust: bounds: Aabb,
    // rust: spawned: Option<&[Aabb]>,
    // rust: x: i32,
    // rust: y: i32,
    // rust: z: i32,
    // rust: ) -> bool {
    // rust: let unobstructed = |l: &L| {
    // rust: spawned.is_none_or(|s| l.unobstructed(bounds) && !s.iter().any(|b| b.intersects(bounds)))
}
    // rust: match obstruction(s) {
    // rust: Obstruction::NoLiquidUnobstructed => !contains_any_liquid(l, bounds) && unobstructed(l),
    // rust: Obstruction::Unobstructed => unobstructed(l),
    // rust: Obstruction::NoLiquid => !contains_any_liquid(l, bounds),
    // rust: Obstruction::Ocelot => {
    // rust: if unobstructed(l) && !contains_any_liquid(l, bounds) {
    // rust: if y < l.sea_level() {
    // rust: return false;
}
    // rust: let below = name_at(l, x, y - 1, z);
    // rust: if below == "minecraft:grass_block" || l.block_tag("minecraft:leaves", below) {
    // rust: return true;
}
}
    // rust: false
}
}
}

/// A structure's spawn override for one category.
pub const Override = struct {
    /// `bounding_box: piece` (else the whole structure's box).
    piece: bool,
    spawns: std.ArrayList(SpawnEntry),
};
/// Every structure's `spawn_overrides`, by structure id then category.
pub const StructureSpawns = struct {
    /// Fx-hashed: natural spawning asks for every structure reaching every
    /// position it tries.
    overrides: FxHashMap<[]const u8,
};
    // rust: impl StructureSpawns {
    /// The overrides of the resource root first asked for, loaded once.
pub fn shared(root: *Path) * {
    // Implementation ported from Horizon
    return undefined;
}
pub const SHARED: std::sync::OnceLock<StructureSpawns> = std::sync::OnceLock::new();
    // rust: SHARED.get_or_init(|| Self::load(root))
}
pub fn load(root: *Path) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut overrides = FxHashMap::default();
    // rust: let dir = root.join("data/minecraft/worldgen/structure");
    // rust: for entry in fs::read_dir(dir).into_iter().flatten().flatten() {
    // rust: let path = entry.path();
    // rust: let Some(stem) = path.file_stem().and_then(|s| s.to_str()) else {
    // rust: continue;
}
    // rust: let Some(v) = fs::read(&path)
    // rust: .ok()
    // rust: .and_then(|b| serde_json::from_slice::<Value>(&b).ok())
    // rust: else {
    // rust: continue;
}
    // rust: let map: FxHashMap<String, Override> = v["spawn_overrides"]
    // rust: .as_object()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .map(|(category, o)| {
    // rust: (
    // rust: category.clone(),
    // rust: Override {
    // rust: piece: o["bounding_box"].as_str() == Some("piece"),
    // rust: spawns: parse_entries(&o["spawns"]),
    // rust: },
    // rust: )
    // rust: })
    // rust: .collect();
    // rust: if !map.is_empty() {
    // rust: overrides.insert(format!("minecraft:{stem}"), map);
}
}
    // rust: Self { overrides }
}
pub fn get(self: *Self, structure: []const u8, category: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.overrides.get(structure)?.get(category)
}
}

/// A structure whose references reach a position's chunk.
pub const StructureAt = struct {
    id: []const u8,
    /// A piece of one of its starts holds the position.
    in_piece: bool,
    /// One of its starts' bounding boxes holds the position.
    in_bounds: bool,
};

/// `NetherFortressStructure.FORTRESS_ENEMIES`.
pub fn fortress_enemies() * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: static ENEMIES: std::sync::LazyLock<Vec<SpawnEntry>> = std::sync::LazyLock::new(|| {
    // rust: let e = |entity: &str, weight, min, max, constant| SpawnEntry {
    // rust: entity: entity.to_owned(),
    // rust: weight,
    // rust: min,
    // rust: max,
    // rust: constant,
}
    // rust: vec![
    // rust: e("minecraft:blaze", 10, 2, 3, false),
    // rust: e("minecraft:zombified_piglin", 5, 4, 4, true),
    // rust: e("minecraft:wither_skeleton", 8, 5, 5, true),
    // rust: e("minecraft:skeleton", 2, 5, 5, true),
    // rust: e("minecraft:magma_cube", 3, 4, 4, true),
    // rust: ]
    // rust: });
    // rust: &ENEMIES
}

/// `NaturalSpawner.mobsAt`: the fortress bounds on nether bricks, then
/// `ChunkGenerator.getMobsAt` (the first referenced structure whose override
/// for the category holds the position), else the biome's list, as mods
/// change it. Borrowed from the level when no mod hears it: a spawn attempt
/// looks it up up to twice.
    // rust: pub fn mobs_at<L: NaturalLevel>(
    // rust: l: &L,
    // rust: category: Category,
    // rust: x: i32,
    // rust: y: i32,
    // rust: z: i32,
    // rust: ) -> Cow<'_, [SpawnEntry]> {
    // rust: let entries = vanilla_mobs_at(l, category, x, y, z);
    // rust: if !l.spawn_hooks() {
    // rust: return Cow::Borrowed(entries);
}
    // rust: let mut entries = entries.to_vec();
    // rust: l.potential_spawns(category, [x, y, z], &mut entries);
    // rust: Cow::Owned(entries)
}

    // rust: fn vanilla_mobs_at<L: NaturalLevel>(
    // rust: l: &L,
    // rust: category: Category,
    // rust: x: i32,
    // rust: y: i32,
    // rust: z: i32,
    // rust: ) -> &[SpawnEntry] {
    // Only a fortress or a structure overriding this category's spawns can
    // change the list, so only theirs are looked up (the references reaching
    // most chunks are mineshafts, which override nothing).
    // rust: let overrides = l.structure_spawns();
    // rust: let monster = category == Category::Monster;
    // rust: let structures = l.structures_at(x, y, z, &|id| {
    // rust: (monster && id == "minecraft:fortress") || overrides.get(id, category.name()).is_some()
    // rust: });
    // rust: if category == Category::Monster
    // rust: && name_at(l, x, y - 1, z) == "minecraft:nether_bricks"
    // rust: && structures
    // rust: .iter()
    // rust: .any(|s| s.id == "minecraft:fortress" && s.in_bounds)
    // rust: {
    // rust: return fortress_enemies();
}
    // rust: for s in &structures {
    // rust: if let Some(o) = overrides.get(&s.id, category.name())
    // rust: && (if o.piece { s.in_piece } else { s.in_bounds })
    // rust: {
    // rust: return &o.spawns;
}
}
    // rust: l.biome_spawns(x, y, z)
    // rust: .and_then(|b| b.get(category.name()))
    // rust: .map_or(&[], Vec::as_slice)
}

/// `WeightedList.getRandom`.
pub fn weighted_pick(list: *[SpawnEntry], random: *mut impl RandomSource) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let total: i64 = list.iter().map(|e| i64::from(e.weight)).sum();
    // rust: if total <= 0 {
    // rust: return None;
}
    // rust: let mut selection = i64::from(random.next_int_bound(total as i32).ok()?);
    // rust: for e in list {
    // rust: selection -= i64::from(e.weight);
    // rust: if selection < 0 {
    // rust: return Some(e.clone());
}
}
    // rust: None
}

/// `SpawnerData.count().sample(random)`: a constant draws nothing.
pub fn sample_count(entry: *SpawnEntry, random: *mut impl RandomSource) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if entry.constant {
    // rust: entry.min
    // rust: } else {
    // rust: let span = entry.max.saturating_sub(entry.min) as i32 + 1;
    // rust: entry.min + random.next_int_bound(span).unwrap_or(0) as u32
}
}
/// `SpawnerData.equals`: the type and the count provider (the weight is not
/// part of it; a constant and a one-value uniform differ).
pub fn same_spawner(a: *SpawnEntry, b: *SpawnEntry) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: a.entity == b.entity && a.constant == b.constant && a.min == b.min && a.max == b.max
}

/// An entity counted by `NaturalSpawner.createState`.
pub const Counted = struct {
    entity: *'a str,
    category: Category,
    /// `blockPosition()`.
    block: [i32,
    is_mob: bool,
    /// `isPersistenceRequired() || requiresCustomPersistence()`.
    persistent: bool,
};
/// The players by the eight-chunk square their chunk is in: a chunk finds the
/// players within 8 chunks of it (the natural spawn chunk tracker's range,
/// and more than the 128 blocks spawning asks for) without a look at every
/// player. With players spread over the map, each spawning chunk and each
/// counted mob looked at all of them.
pub const PlayerCells = struct {
    cells: FxHashMap<(i32,
};
    // rust: impl PlayerCells {
    /// From each player's block x and z, in the players' order.
pub fn new(positions: impl IntoIterator<Item = (f64) void {
}
    // rust: let mut cells: FxHashMap<(i32, i32), Vec<(u32, i32, i32)>> = FxHashMap::default();
    // rust: for (i, (x, z)) in positions.into_iter().enumerate() {
    // rust: let (cx, cz) = ((x.floor() as i32) >> 4, (z.floor() as i32) >> 4);
    // rust: cells
    // rust: .entry((cx >> 3, cz >> 3))
    // rust: .or_default()
    // rust: .push((i as u32, cx, cz));
}
    // rust: Self { cells }
}
    /// The players whose chunk is within 8 chunks of (cx, cz) on both axes,
    /// in the players' order.
pub fn within_8(self: *Self, cx: i32, cz: i32, out: *mut std.ArrayList(usize)) void {
}
    // rust: out.clear();
    // rust: for kx in cx.saturating_sub(8) >> 3..=cx.saturating_add(8) >> 3 {
    // rust: for kz in cz.saturating_sub(8) >> 3..=cz.saturating_add(8) >> 3 {
    // rust: let Some(players) = self.cells.get(&(kx, kz)) else {
    // rust: continue;
}
    // rust: out.extend(
    // rust: players
    // rust: .iter()
    // rust: .filter(|&&(_, px, pz)| (px - cx).abs().max((pz - cz).abs()) <= 8)
    // rust: .map(|&(i, _, _)| i as usize),
    // rust: );
}
}
    // rust: out.sort_unstable();
}
}

/// A player as the spawn caps see it.
pub const SpawnPlayer = struct {
    position: [f64,
    spectator: bool,
};

/// `NaturalSpawner.SpawnState` with its `PotentialCalculator` and
/// `LocalMobCapCalculator`.
pub const SpawnState = struct {
    spawnable_chunks: i32,
    counts: [i32,
    charges: Vec<([i32,
    players: std.ArrayList(SpawnPlayer),
    cells: PlayerCells,
    /// Each chunk asked about: its players' run in `near_list`.
    players_near: FxHashMap<(i32,
    near_list: std.ArrayList(usize),
    /// The mobs counted near each player (`playerMobCounts`), by category.
    player_counts: Vec<[i32,
    last_checked: Option<([i32,
};
    // rust: impl SpawnState {
    /// `getSpawnableChunkCount` and `getMobCategoryCounts` (by
    /// [`Category::ALL`]), for the debug overlay's spawn counts.
pub fn counts(self: *Self) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (self.spawnable_chunks, self.counts)
}
    /// `NaturalSpawner.createState`: every non-persistent entity of a
    /// spawning category in a loaded chunk adds its biome's spawn charge, its
    /// category count and (for mobs) the local caps of the players near it.
    // rust: pub fn new<L: NaturalLevel>(
    // rust: l: &L,
    // rust: spawnable_chunks: i32,
    // rust: players: Vec<SpawnPlayer>,
    // rust: entities: &[Counted],
    // rust: chunk_loaded: impl Fn(i32, i32) -> bool,
    // rust: ) -> Self {
    // rust: let mut state = Self {
    // rust: spawnable_chunks,
    // rust: counts: [0; 8],
    // rust: charges: Vec::new(),
    // rust: player_counts: vec![[0; 8]; players.len()],
    // rust: cells: PlayerCells::new(players.iter().map(|p| (p.position[0], p.position[2]))),
    // rust: players,
    // rust: players_near: FxHashMap::default(),
    // rust: near_list: Vec::new(),
    // rust: last_checked: None,
}
    // rust: for e in entities {
    // rust: if e.is_mob && e.persistent || e.category == Category::Misc {
    // rust: continue;
}
    // rust: let [x, y, z] = e.block;
    // rust: if !chunk_loaded(x >> 4, z >> 4) {
    // rust: continue;
}
    // rust: if let Some(cost) = l.spawn_cost(e.entity, x, y, z) {
    // rust: state.add_charge(e.block, cost.charge);
}
    // rust: if e.is_mob {
    // rust: state.add_local(x >> 4, z >> 4, e.category);
}
    // rust: state.counts[e.category.index()] += 1;
}
    // rust: state
}
pub fn add_charge(self: *Self, pos: [i32; 3], charge: f64) void {
}
    // rust: if charge != 0.0 {
    // rust: self.charges.push((pos, charge));
}
}
    /// `ChunkMap.getPlayersCloseForSpawning`: none past the natural spawn
    /// chunk tracker's range of 8 chunks from every player, else the
    /// non-spectators within 128 blocks of the chunk's centre.
pub fn players_near(self: *Self, cx: i32, cz: i32) s {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (list, players, cells) = (&mut self.near_list, &self.players, &self.cells);
    // rust: let (start, len) = *self.players_near.entry((cx, cz)).or_insert_with(|| {
    // rust: let start = list.len() as u32;
            // Every player within 128 blocks of the chunk's centre stands in
            // a chunk within 8 of it: those 8 chunks hold every answer.
    // rust: let mut tracked = Vec::new();
    // rust: cells.within_8(cx, cz, &mut tracked);
    // rust: if !tracked.is_empty() {
    // rust: let (x, z) = (f64::from(cx * 16 + 8), f64::from(cz * 16 + 8));
    // rust: list.extend(tracked.into_iter().filter(|&i| {
    // rust: let p = &players[i];
    // rust: let (dx, dz) = (x - p.position[0], z - p.position[2]);
    // rust: !p.spectator && dx * dx + dz * dz < 16384.0
    // rust: }));
}
    // rust: (start, list.len() as u32 - start)
    // rust: });
    // rust: start as usize..(start + len) as usize
}
pub fn add_local(self: *Self, cx: i32, cz: i32, category: Category) void {
}
    // rust: for i in self.players_near(cx, cz) {
    // rust: self.player_counts[self.near_list[i]][category.index()] += 1;
}
}
    /// `canSpawnForCategoryGlobal`.
pub fn can_spawn_global(self: *Self, category: Category) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let max = category.max() * self.spawnable_chunks / 289;
    // rust: self.counts[category.index()] < max
}
    /// `canSpawnForCategoryLocal` (`LocalMobCapCalculator.canSpawn`).
pub fn can_spawn_local(self: *Self, category: Category, cx: i32, cz: i32) b {
    // Implementation ported from Horizon
    return undefined;
}
        // A player with nothing counted yet can spawn: zero is under every
        // spawning category's cap.
    // rust: let near = self.players_near(cx, cz);
    // rust: self.near_list[near]
    // rust: .iter()
    // rust: .any(|&p| self.player_counts[p][category.index()] < category.max())
}
    /// `getFilteredSpawningCategories`.
    // rust: pub fn filtered_categories(
    // rust: &self,
    // rust: spawn_enemies: bool,
    // rust: spawn_persistent: bool,
    // rust: ) -> Vec<Category> {
    // rust: Category::SPAWNING
    // rust: .into_iter()
    // rust: .filter(|&c| {
    // rust: (spawn_enemies || c.friendly())
    // rust: && (spawn_persistent || !c.persistent())
    // rust: && self.can_spawn_global(c)
    // rust: })
    // rust: .collect()
}
    /// `SpawnState.canSpawn`: the spawn potential's energy change must stay
    /// within the type's budget where it has a spawn cost.
    // rust: fn can_spawn<L: NaturalLevel>(&mut self, l: &L, entity: &str, pos: [i32; 3]) -> bool {
    // rust: match l.spawn_cost(entity, pos[0], pos[1], pos[2]) {
    // rust: None => {
    // rust: self.last_checked = Some((pos, entity.to_owned(), 0.0));
    // rust: true
}
    // rust: Some(cost) => {
    // rust: self.last_checked = Some((pos, entity.to_owned(), cost.charge));
    // rust: self.energy_change(pos, cost.charge) <= cost.energy_budget
}
}
}
    /// `PotentialCalculator.getPotentialEnergyChange`.
pub fn energy_change(self: *Self, pos: [i32; 3], charge: f64) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if charge == 0.0 {
    // rust: return 0.0;
}
    // rust: let mut change = 0.0;
    // rust: for (p, c) in &self.charges {
    // rust: let d = [
    // rust: f64::from(p[0] - pos[0]),
    // rust: f64::from(p[1] - pos[1]),
    // rust: f64::from(p[2] - pos[2]),
    // rust: ];
    // rust: let dist = d[0] * d[0] + d[1] * d[1] + d[2] * d[2];
    // rust: change += if dist == 0.0 {
    // rust: f64::INFINITY
    // rust: } else {
    // rust: c / dist.sqrt()
}
}
    // rust: change * charge
}
    /// `SpawnState.afterSpawn`.
    // rust: fn after_spawn<L: NaturalLevel>(
    // rust: &mut self,
    // rust: l: &L,
    // rust: entity: &str,
    // rust: category: Category,
    // rust: pos: [i32; 3],
    // rust: ) {
    // rust: let charge = match &self.last_checked {
    // rust: Some((p, t, c)) if *p == pos && t == entity => *c,
    // rust: _ => l
    // rust: .spawn_cost(entity, pos[0], pos[1], pos[2])
    // rust: .map_or(0.0, |c| c.charge),
}
    // rust: self.add_charge(pos, charge);
    // rust: self.counts[category.index()] += 1;
    // rust: self.add_local(pos[0] >> 4, pos[2] >> 4, category);
}
}

/// What a spawn pass did, in vanilla's order (for differential tests).
pub const Event = enum {
    /// `getFilteredSpawningCategories`.
    Categories(Vec<Category>),
    /// `canSpawnForCategoryLocal` for the chunk.
    Local(Category, bool),
    /// `getRandomPosWithin`'s start.
    Start(Category, [i32; 3]),
    /// An attempt at a position (the nearest player lookup).
    Try(i32, i32),
    /// The type passed `isValidSpawnPostitionForType`; the spawn state's
    /// potential test answered.
    Test(String, [i32; 3], bool),
    /// A mob spawned.
    Spawn(String, [f64; 3], f32),
};
/// A mob the spawner is about to add: the level runs `finalizeSpawn` and
/// adds it, returning its finalized box and whether a tropical fish schools.
pub const SpawnRequest = struct {
    entity: *'a str,
    species: Species,
    position: [f64,
    yaw: f32,
    /// Mobs of this group spawned before (the `SpawnGroupData`'s size).
    group_index: u32,
    reason: Reason,
};
pub const Spawned = struct {
    bounds: Aabb,
    /// `TropicalFish.isSchool`.
    school: bool,
};

/// `NaturalSpawner.spawnForChunk` for the categories already filtered.
    // rust: pub fn spawn_for_chunk<L: NaturalLevel, R: RandomSource>(
    // rust: l: &L,
    // rust: random: &mut R,
    // rust: state: &mut SpawnState,
    // rust: categories: &[Category],
    // rust: chunk: (i32, i32),
    // rust: spawn: &mut dyn FnMut(&L, &SpawnRequest) -> Option<Spawned>,
    // rust: trace: &mut dyn FnMut(Event),
    // rust: ) {
    // rust: for &category in categories {
    // rust: let local = state.can_spawn_local(category, chunk.0, chunk.1);
    // rust: trace(Event::Local(category, local));
    // rust: if local {
    // rust: spawn_category_for_chunk(l, random, state, category, chunk, spawn, trace);
}
}
}
/// `NaturalSpawner.spawnCategoryForChunk`: `getRandomPosWithin` (a column of
/// the chunk, a height up to one above the world surface).
    // rust: pub fn spawn_category_for_chunk<L: NaturalLevel, R: RandomSource>(
    // rust: l: &L,
    // rust: random: &mut R,
    // rust: state: &mut SpawnState,
    // rust: category: Category,
    // rust: chunk: (i32, i32),
    // rust: spawn: &mut dyn FnMut(&L, &SpawnRequest) -> Option<Spawned>,
    // rust: trace: &mut dyn FnMut(Event),
    // rust: ) {
    // rust: let x = chunk.0 * 16 + random.next_int_bound(16).unwrap_or(0);
    // rust: let z = chunk.1 * 16 + random.next_int_bound(16).unwrap_or(0);
    // rust: let min = l.min_y();
    // rust: let y = random_start_y(random, min, l.heightmap(Heightmap::WorldSurface, x, z));
    // rust: trace(Event::Start(category, [x, y, z]));
    // rust: if y > min {
    // rust: spawn_category_for_position(l, random, state, category, chunk, [x, y, z], spawn, trace);
}
}
// NaturalSpawner.getRandomPosWithin adds one to ChunkAccess.getHeight's
// highest occupied Y. NaturalLevel.heightmap already returns the first empty Y.
pub fn random_start_y(random: *mut impl RandomSource, min: i32, first_empty: i32) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: min + random.next_int_bound(first_empty - min + 1).unwrap_or(0)
}

/// `NaturalSpawner.spawnCategoryForPosition` with the spawn state's
/// `canSpawn` and `afterSpawn`.
    // rust: pub fn spawn_category_for_position<L: NaturalLevel, R: RandomSource>(
    // rust: l: &L,
    // rust: random: &mut R,
    // rust: state: &mut SpawnState,
    // rust: category: Category,
    // rust: chunk: (i32, i32),
    // rust: start: [i32; 3],
    // rust: spawn: &mut dyn FnMut(&L, &SpawnRequest) -> Option<Spawned>,
    // rust: trace: &mut dyn FnMut(Event),
    // rust: ) {
    // rust: let [x0, y, z0] = start;
    // rust: if l.mob_data().state(l.state(x0, y, z0)).flags & super::data::REDSTONE_CONDUCTOR != 0 {
    // rust: return;
}
    // rust: let mut spawned: Vec<Aabb> = Vec::new();
    // rust: let mut cluster = 0u32;
    // rust: let mut nearest = Nearest::new(start);
    // rust: for _ in 0..3 {
    // rust: let (mut x, mut z) = (x0, z0);
        // The group's entry, its type and where it was picked.
    // rust: let mut current: Option<(SpawnEntry, Option<MobType>, [i32; 3])> = None;
    // rust: let mut group_index = 0u32;
    // rust: let mut max = (random.next_float() * 4.0).ceil() as i32;
    // rust: let mut ll = 0;
    // rust: while ll < max {
    // rust: ll += 1;
    // rust: x += random.next_int_bound(6).unwrap_or(0) - random.next_int_bound(6).unwrap_or(0);
    // rust: z += random.next_int_bound(6).unwrap_or(0) - random.next_int_bound(6).unwrap_or(0);
    // rust: let (xx, zz) = (f64::from(x) + 0.5, f64::from(z) + 0.5);
    // rust: trace(Event::Try(x, z));
    // rust: attempt_count(0);
    // rust: let Some(distance) = nearest.distance_sqr(l, xx, f64::from(y), zz) else {
    // rust: continue;
}
    // rust: if !right_distance(l, chunk, [x, y, z], distance) {
    // rust: continue;
}
    // rust: if current.is_none() {
    // rust: let list = if category == Category::WaterAmbient
    // rust: && l.biome_tag("minecraft:reduce_water_ambient_spawns", x, y, z)
    // rust: && random.next_float() < 0.98
    // rust: {
    // rust: None
    // rust: } else {
    // rust: weighted_pick(&mobs_at(l, category, x, y, z), random)
}
    // rust: let Some(entry) = list else {
    // rust: break;
}
    // rust: max = sample_count(&entry, random) as i32;
    // rust: let kind = l.mob_type(&entry.entity);
    // rust: current = Some((entry, kind, [x, y, z]));
}
    // rust: let (entry, kind, picked_at) = current.as_ref().unwrap_or_else(|| unreachable!());
            // The list the entry was picked from holds it where it was picked.
    // rust: let listed = *picked_at == [x, y, z];
    // rust: let valid = valid_position_for_type(
    // rust: l,
    // rust: random,
    // rust: category,
    // rust: entry,
    // rust: *kind,
    // rust: listed,
    // rust: [x, y, z],
    // rust: distance,
    // rust: );
    // rust: let Some((species, width, height, type_category)) = (*kind).filter(|_| valid) else {
    // rust: continue;
}
    // rust: let passed = state.can_spawn(l, &entry.entity, [x, y, z]);
    // rust: trace(Event::Test(entry.entity.clone(), [x, y, z], passed));
    // rust: if !passed {
    // rust: continue;
}
            // getMobForSpawn (a type the game cannot create, which would end
            // the pass, never passes isValidSpawnPostitionForType).
    // rust: let yaw = random.next_float() * 360.0;
    // rust: let bounds = spawn_box(xx, f64::from(y), zz, width, height);
    // rust: let despawn = f64::from(type_category.despawn_distance().pow(2));
    // rust: let far = distance > despawn && removed_when_far(species);
    // rust: if far
    // rust: || !mob_spawn_rules(species, l, x, y, z)
    // rust: || !spawn_obstruction(species, l, bounds, Some(&spawned), x, y, z)
    // rust: {
    // rust: continue;
}
    // rust: let request = SpawnRequest {
    // rust: entity: &entry.entity,
    // rust: species,
    // rust: position: [xx, f64::from(y), zz],
    // rust: yaw,
    // rust: group_index,
    // rust: reason: Reason::Natural,
}
    // rust: let Some(result) = spawn(l, &request) else {
    // rust: continue;
}
    // rust: attempt_count(1);
    // rust: group_index += 1;
    // rust: spawned.push(result.bounds);
    // rust: cluster += 1;
    // rust: state.after_spawn(l, &entry.entity, type_category, [x, y, z]);
    // rust: trace(Event::Spawn(
    // rust: entry.entity.clone(),
    // rust: [xx, f64::from(y), zz],
    // rust: yaw,
    // rust: ));
    // rust: if cluster >= max_cluster_size(species) {
    // rust: return;
}
            // TropicalFish.isMaxGroupSizeReached.
    // rust: if species == Species::TropicalFish && !result.school {
    // rust: break;
}
}
}
}
/// `getNearestPlayer(x, y, z, -1, false)`'s squared distance for the
/// attempts of one start. The spawn checks only compare it with 24² and the
/// despawn distances (128² at most), so it is measured only to the players
/// that can be within 128 blocks of an attempt near the start: when none is,
/// the nearest reads as infinitely far, which every check answers as it
/// answers the real distance. An attempt that wanders farther than
/// `MARGIN` from the start measures every player.
pub const Nearest = struct {
    /// The players that can be within 128 blocks, once an attempt asked.
    nearby: Option<Vec<[f64,
    start: (f64,
};
    // rust: impl Nearest {
pub const REACH: f64 = 128.0;
pub const MARGIN: f64 = 64.0;
pub fn new(start: [i32; 3]) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: nearby: None,
    // rust: start: (f64::from(start[0]) + 0.5, f64::from(start[2]) + 0.5),
}
}
    // rust: fn distance_sqr<L: NaturalLevel>(&mut self, l: &L, x: f64, y: f64, z: f64) -> Option<f64> {
    // rust: let all = l.nearest_player_positions();
    // rust: if all.is_empty() {
    // rust: return None;
}
    // rust: let distance = |p: &[f64; 3]| (p[0] - x).powi(2) + (p[1] - y).powi(2) + (p[2] - z).powi(2);
    // rust: let (sx, sz) = self.start;
    // rust: if (x - sx).abs() > Self::MARGIN || (z - sz).abs() > Self::MARGIN {
    // rust: return all.iter().map(distance).reduce(f64::min);
}
        // The others are farther than REACH, across, from every point within
        // MARGIN of the start.
    // rust: let nearby = self.nearby.get_or_insert_with(|| {
    // rust: all.iter()
    // rust: .filter(|p| {
    // rust: let dx = ((p[0] - sx).abs() - Self::MARGIN).max(0.0);
    // rust: let dz = ((p[2] - sz).abs() - Self::MARGIN).max(0.0);
    // rust: dx * dx + dz * dz <= Self::REACH * Self::REACH
    // rust: })
    // rust: .copied()
    // rust: .collect()
    // rust: });
    // rust: Some(nearby.iter().map(distance).fold(f64::INFINITY, f64::min))
}
}
/// `isRightDistanceToPlayerAndSpawnPoint`.
    // rust: fn right_distance<L: NaturalLevel>(l: &L, chunk: (i32, i32), pos: [i32; 3], distance: f64) -> bool {
    // rust: if distance <= 576.0 {
    // rust: return false;
}
    // rust: if let Some(r) = l.respawn() {
    // rust: let d = [
    // rust: f64::from(r[0]) + 0.5 - (f64::from(pos[0]) + 0.5),
    // rust: f64::from(r[1]) + 0.5 - f64::from(pos[1]),
    // rust: f64::from(r[2]) + 0.5 - (f64::from(pos[2]) + 0.5),
    // rust: ];
    // rust: if d[0] * d[0] + d[1] * d[1] + d[2] * d[2] < 24.0 * 24.0 {
    // rust: return false;
}
}
    // rust: let (cx, cz) = (pos[0] >> 4, pos[2] >> 4);
    // rust: (cx, cz) == chunk || l.can_spawn_in_chunk(cx, cz)
}
/// `isValidSpawnPostitionForType`, for the entry's type (`mob_type`).
/// `listed`: the position is where the entry was picked from `mobsAt`.
    // rust: fn valid_position_for_type<L: NaturalLevel, R: RandomSource>(
    // rust: l: &L,
    // rust: random: &mut R,
    // rust: category: Category,
    // rust: entry: &SpawnEntry,
    // rust: kind: Option<MobType>,
    // rust: listed: bool,
    // rust: pos: [i32; 3],
    // rust: distance: f64,
    // rust: ) -> bool {
    // rust: let Some((species, width, height, type_category)) = kind else {
    // rust: return false;
}
    // rust: if type_category == Category::Misc {
    // rust: return false;
}
    // rust: let despawn = f64::from(type_category.despawn_distance().pow(2));
    // rust: if !spawns_far_from_player(species, type_category) && distance > despawn {
    // rust: return false;
}
    // rust: let [x, y, z] = pos;
    // rust: let hooked = l.spawn_hooks();
    // rust: let in_list = || {
    // rust: mobs_at(l, category, x, y, z)
    // rust: .iter()
    // rust: .any(|e| same_spawner(e, entry))
}
    // `canSpawnMobAt` comes first in vanilla, and mods hear each of its
    // lookups. Without them it and `isSpawnPositionOk` only read the level,
    // so their order cannot change the answer: the few block reads of the
    // placement turn most positions away before the spawn list (structures,
    // biome) is looked up again.
    // rust: if hooked && !in_list() {
    // rust: return false;
}
    // rust: if !spawn_rules::is_spawn_position_ok(species, l, x, y, z) {
    // rust: return false;
}
    // rust: if !hooked && !listed && !in_list() {
    // rust: return false;
}
    // rust: if !spawn_rules::check_spawn_rules(species, l, Reason::Natural, random, x, y, z) {
    // rust: return false;
}
    // rust: l.no_collision(spawn_aabb(
    // rust: species,
    // rust: f64::from(x) + 0.5,
    // rust: f64::from(y),
    // rust: f64::from(z) + 0.5,
    // rust: width,
    // rust: height,
    // rust: ))
}

/// What chunk generation spawning did (for differential tests).
pub const GenEvent = enum {
    /// An attempt at a column (the heightmap lookup).
    Column(i32, i32),
    Spawn(String, [f64; 3], f32),
};
/// `NaturalSpawner.spawnMobsForChunkGeneration`: creature packs placed on
/// the chunk's surface. `rules` is the region's random, which the spawn
/// predicates and `spawn` (finalizeSpawn) draw from.
    // rust: pub fn spawn_mobs_for_chunk_generation<L: NaturalLevel, R: RandomSource, Q: RandomSource>(
    // rust: l: &L,
    // rust: source: [i32; 3],
    // rust: chunk: (i32, i32),
    // rust: random: &mut R,
    // rust: rules: &mut Q,
    // rust: spawn: &mut dyn FnMut(&L, &SpawnRequest, &mut Q) -> bool,
    // rust: trace: &mut dyn FnMut(GenEvent),
    // rust: ) {
    // rust: if !l.spawn_mobs() {
    // rust: return;
}
    // rust: let [sx, sy, sz] = source;
    // rust: let mobs = l
    // rust: .biome_spawns(sx, sy, sz)
    // rust: .and_then(|b| b.get("creature"))
    // rust: .cloned()
    // rust: .unwrap_or_default();
    // rust: if mobs.iter().map(|e| e.weight).sum::<u32>() == 0 {
    // rust: return;
}
    // rust: let probability = l.creature_probability(sx, sy, sz);
    // rust: let (xo, zo) = (chunk.0 * 16, chunk.1 * 16);
    // rust: while random.next_float() < probability {
    // rust: let Some(entry) = weighted_pick(&mobs, random) else {
    // rust: continue;
}
    // rust: let count = sample_count(&entry, random);
    // rust: let mut group_index = 0u32;
    // rust: let mut x = xo + random.next_int_bound(16).unwrap_or(0);
    // rust: let mut z = zo + random.next_int_bound(16).unwrap_or(0);
    // rust: let (start_x, start_z) = (x, z);
    // rust: let kind = l.mob_type(&entry.entity);
    // rust: for _ in 0..count {
    // rust: let mut success = false;
    // rust: let mut attempts = 0;
    // rust: while !success && attempts < 4 {
    // rust: attempts += 1;
    // rust: let Some((species, width, height, _)) = kind else {
    // rust: break;
}
    // rust: let pos = top_non_colliding(l, &entry.entity, x, z);
    // rust: trace(GenEvent::Column(x, z));
    // rust: if spawn_rules::is_spawn_position_ok(species, l, pos[0], pos[1], pos[2]) {
    // rust: let fx = f64::from(x).clamp(
    // rust: f64::from(xo) + f64::from(width),
    // rust: f64::from(xo) + 16.0 - f64::from(width),
    // rust: );
    // rust: let fz = f64::from(z).clamp(
    // rust: f64::from(zo) + f64::from(width),
    // rust: f64::from(zo) + 16.0 - f64::from(width),
    // rust: );
    // rust: let fy = f64::from(pos[1]);
    // rust: let (bx, bz) = (fx.floor() as i32, fz.floor() as i32);
    // rust: if !l.no_collision(spawn_aabb(species, fx, fy, fz, width, height))
    // rust: || !spawn_rules::check_spawn_rules(
    // rust: species,
    // rust: l,
    // rust: Reason::ChunkGeneration,
    // rust: rules,
    // rust: bx,
    // rust: pos[1],
    // rust: bz,
    // rust: )
    // rust: {
    // rust: continue;
}
    // rust: let yaw = random.next_float() * 360.0;
    // rust: let bounds = spawn_box(fx, fy, fz, width, height);
    // rust: if mob_spawn_rules(species, l, bx, pos[1], bz)
    // rust: && spawn_obstruction(species, l, bounds, None, bx, pos[1], bz)
    // rust: {
    // rust: let request = SpawnRequest {
    // rust: entity: &entry.entity,
    // rust: species,
    // rust: position: [fx, fy, fz],
    // rust: yaw,
    // rust: group_index,
    // rust: reason: Reason::ChunkGeneration,
}
    // rust: if spawn(l, &request, rules) {
    // rust: group_index += 1;
    // rust: trace(GenEvent::Spawn(entry.entity.clone(), [fx, fy, fz], yaw));
    // rust: success = true;
}
}
}
    // rust: x += random.next_int_bound(5).unwrap_or(0) - random.next_int_bound(5).unwrap_or(0);
    // rust: z += random.next_int_bound(5).unwrap_or(0) - random.next_int_bound(5).unwrap_or(0);
    // rust: while x < xo || x >= xo + 16 || z < zo || z >= zo + 16 {
    // rust: x = start_x + random.next_int_bound(5).unwrap_or(0)
    // rust: - random.next_int_bound(5).unwrap_or(0);
    // rust: z = start_z + random.next_int_bound(5).unwrap_or(0)
    // rust: - random.next_int_bound(5).unwrap_or(0);
}
}
}
}
}
/// `getTopNonCollidingPos`: the type's heightmap, under the ceiling in
/// dimensions that have one, then the placement type's adjustment.
    // rust: fn top_non_colliding<L: NaturalLevel>(l: &L, entity: &str, x: i32, z: i32) -> [i32; 3] {
    // rust: let heightmap = Heightmap::from_name(l.mob_data().heightmap(entity));
    // rust: let mut y = l.heightmap(heightmap, x, z);
    // rust: if l.has_ceiling() {
    // rust: loop {
    // rust: y -= 1;
    // rust: if l.facts().is_air(l.state(x, y, z)) {
    // rust: break;
}
}
    // rust: loop {
    // rust: y -= 1;
    // rust: if !(l.facts().is_air(l.state(x, y, z)) && y > l.min_y()) {
    // rust: break;
}
}
}
    // rust: if l.mob_data().placement(entity) == super::data::Placement::OnGround
    // rust: && l.pathfindable_land(x, y - 1, z)
    // rust: {
    // rust: y -= 1;
}
    // rust: [x, y, z]
}

    // rust: mod tests {
//     use super::*;

pub fn random_start_uses_first_empty_y_as_inclusive_ceiling() void {
}
//         use horizon_core::random::LegacyRandom;

        // Vanilla getRandomPosWithin: a solid column through Y=63 has
        // topEmptyY=64, so [-64, 64] contains 129 possible starts, not 130.
    // rust: for seed in 0..1024 {
    // rust: let mut actual = LegacyRandom::new(seed);
    // rust: let mut vanilla = LegacyRandom::new(seed);
    // rust: let expected = -64 + vanilla.next_int_bound(129).unwrap();
    // rust: assert_eq!(random_start_y(&mut actual, -64, 64), expected);
    // rust: assert_eq!(actual.next_long(), vanilla.next_long());
}
        // An empty column must still consume nextInt(1), then fail the
        // spawnCategoryForChunk minimum-height gate without any group draws.
    // rust: let mut actual = LegacyRandom::new(42);
    // rust: let mut vanilla = LegacyRandom::new(42);
    // rust: vanilla.next_int_bound(1).unwrap();
    // rust: assert_eq!(random_start_y(&mut actual, -64, -64), -64);
    // rust: assert_eq!(actual.next_long(), vanilla.next_long());
}

    /// The grid finds the players whose chunk is within 8 of a chunk on both
    /// axes, in their order, as a look at every player does.
pub fn player_cells_find_what_a_scan_finds() void {
}
    // rust: let mut seed = 0x2545_F491_4F6C_DD1Du64;
    // rust: let mut next = |m: f64| {
    // rust: seed ^= seed << 13;
    // rust: seed ^= seed >> 7;
    // rust: seed ^= seed << 17;
    // rust: (seed % 1_000_000) as f64 / 1_000_000.0 * 2.0 * m - m
}
        // Spread over 20 000 blocks, with clusters and players on chunk and cell edges.
    // rust: let mut players: Vec<(f64, f64)> =
    // rust: (0..300).map(|_| (next(10_000.0), next(10_000.0))).collect();
    // rust: players.extend([
    // rust: (0.0, 0.0),
    // rust: (-0.5, 127.9),
    // rust: (128.0, -128.0),
    // rust: (-1.0e-9, 16.0),
    // rust: (2047.99, -2048.0),
    // rust: ]);
    // rust: let cells = PlayerCells::new(players.iter().copied());
    // rust: let chunk = |(x, z): (f64, f64)| ((x.floor() as i32) >> 4, (z.floor() as i32) >> 4);
    // rust: let mut found = Vec::new();
    // rust: for &(x, z) in players.iter().step_by(7) {
    // rust: let (pcx, pcz) = chunk((x, z));
    // rust: for (cx, cz) in [
    // rust: (pcx, pcz),
    // rust: (pcx + 8, pcz - 8),
    // rust: (pcx + 9, pcz),
    // rust: (pcx - 3, pcz + 12),
    // rust: (0, 0),
    // rust: ] {
    // rust: cells.within_8(cx, cz, &mut found);
    // rust: let scan: Vec<usize> = (0..players.len())
    // rust: .filter(|&i| {
    // rust: let (px, pz) = chunk(players[i]);
    // rust: (px - cx).abs().max((pz - cz).abs()) <= 8
    // rust: })
    // rust: .collect();
    // rust: assert_eq!(found, scan, "chunk ({cx}, {cz})");
}
}
}
}
