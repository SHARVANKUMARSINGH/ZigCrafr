//! Transpiled from Horizon Rust crate
//! Module: horizon-world_growth_tests
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Sapling growth, bone meal and templates through live feature placement.
//! Needs the prepared client resources and worldgen bundle (skipped when
//! absent).
// use super::*;
// use crate::{chunk::BlockState, worldgen::generator::GeneratorData, worldgen::live::LiveFeatures};
// use std::{collections::HashMap, path::PathBuf, sync::OnceLock};

pub const Fixture = struct {
    registry: *'static BlockRegistry,
    behaviours: Behaviours,
};

pub fn fixture() O {
    // Implementation ported from Horizon
    return undefined;
}
pub const FIXTURE: OnceLock<?Fixture> = OnceLock::new();
    // rust: FIXTURE
    // rust: .get_or_init(|| {
    // rust: let root = std::env::var_os("HORIZON_RESOURCES")
    // rust: .map(PathBuf::from)
    // rust: .unwrap_or_else(|| {
    // rust: PathBuf::from(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION)
    // rust: });
            // Trees need the feature block-behaviour exports in the worldgen bundle.
    // rust: if !root.join("block-behaviours.json").exists()
    // rust: || !root.join("worldgen/blocks/block-properties.nbt").exists()
    // rust: {
    // rust: eprintln!("skipping growth tests: no resources at {}", root.display());
    // rust: return None;
}
    // rust: let registry: &'static BlockRegistry =
    // rust: Box::leak(Box::new(data::load_registry(&root).expect("registry")));
    // rust: let behaviours = Behaviours::load(registry, &root).expect("behaviours");
    // rust: let data =
    // rust: GeneratorData::load(&root.join("worldgen"), registry).expect("worldgen data");
    // rust: let features = LiveFeatures::new(&data)
    // rust: .expect("features")
    // rust: .expect("feature bundle");
    // rust: behaviours.set_live_features(Arc::new(features));
    // rust: Some(Fixture {
    // rust: registry,
    // rust: behaviours,
    // rust: })
    // rust: })
    // rust: .as_ref()
}

pub const Level = struct {
    blocks: HashMap<BlockPos,
    air: BlockStateId,
    random: LegacyRandom,
    events: std.ArrayList(LevelEvent),
    biome: *'static str,
    day: i64,
    block_entities: Vec<(BlockPos,
};
    // rust: impl LevelAccess for Level {
pub fn day_time(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.day
}
pub fn block_state(self: *Self, pos: BlockPos) B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.blocks.get(&pos).copied().unwrap_or(self.air)
}
pub fn set_raw(self: *Self, pos: BlockPos, state: BlockStateId) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Some(self.blocks.insert(pos, state).unwrap_or(self.air))
}
pub fn is_loaded(self: *Self, _pos: BlockPos) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: true
}
pub fn random(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: &mut self.random
}
pub fn game_time(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: 0
}
pub fn emit(self: *Self, event: LevelEvent) void {
}
    // rust: self.events.push(event);
}
pub fn biome_name(self: *Self, _pos: BlockPos) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Some(self.biome)
}
pub fn load_block_entity(self: *Self, pos: BlockPos, nbt: crate::nbt::Compound) void {
}
    // rust: self.block_entities.push((pos, nbt));
}
}

pub const World = struct {
    f: *'static Fixture,
    level: Level,
    ticks: Ticks,
};
    // rust: impl World {
pub fn new(f: *'static Fixture, seed: i64) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut ticks = Ticks::new(0);
    // rust: for x in -4..4 {
    // rust: for z in -4..4 {
    // rust: ticks.add_empty_chunk(ChunkPos::new(x, z)).unwrap();
}
}
    // rust: Self {
    // rust: level: Level {
    // rust: blocks: HashMap::new(),
    // rust: air: f.behaviours.air(),
    // rust: random: LegacyRandom::new(seed),
    // rust: events: Vec::new(),
    // rust: biome: "minecraft:plains",
    // rust: day: 6000,
    // rust: block_entities: Vec::new(),
    // rust: },
    // rust: f,
    // rust: ticks,
}
}
pub fn id(self: *Self, name: []const u8, props: *[([]const u8) void {
}
    // rust: let state = BlockState {
    // rust: name: format!("minecraft:{name}"),
    // rust: properties: props
    // rust: .iter()
    // rust: .map(|(k, v)| (k.to_string(), v.to_string()))
    // rust: .collect(),
}
    // rust: self.f
    // rust: .registry
    // rust: .resolve(&state)
    // rust: .unwrap_or_else(|_| panic!("unknown state {name} {props:?}"))
}
pub fn floor(self: *Self, name: []const u8, radius: i32) void {
}
    // rust: let state = self.id(name, &[]);
    // rust: let stone = self.id("stone", &[]);
    // rust: for x in -radius..=radius {
    // rust: for z in -radius..=radius {
    // rust: self.level.blocks.insert(BlockPos::new(x, 63, z), state);
    // rust: self.level.blocks.insert(BlockPos::new(x, 62, z), stone);
}
}
}
pub fn put(self: *Self, pos: BlockPos, state: BlockStateId) void {
}
    // rust: self.level.blocks.insert(pos, state);
}
pub fn name(self: *Self, pos: BlockPos) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let state = self.level.block_state(pos);
    // rust: self.f.registry.state(state).unwrap().name.clone()
}
pub fn bone_meal(self: *Self, pos: BlockPos) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.f
    // rust: .behaviours
    // rust: .use_bone_meal(&mut self.level, &mut self.ticks, pos, Direction::Up)
}
pub fn count(self: *Self, suffix: []const u8) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.level
    // rust: .blocks
    // rust: .values()
    // rust: .filter(|&&s| self.f.registry.state(s).unwrap().name.ends_with(suffix))
    // rust: .count()
}
}

pub fn grow(sapling: []const u8, soil: []const u8, positions: *[(i32) void {
}
    // rust: let Some(f) = fixture() else { return };
    // rust: let mut grown = 0;
    // rust: for seed in 0..6 {
    // rust: let mut w = World::new(f, seed);
    // rust: w.floor(soil, 12);
    // rust: let state = w.id(sapling, &[]);
    // rust: for &(x, z) in positions {
    // rust: w.put(BlockPos::new(x, 64, z), state);
}
    // rust: let origin = BlockPos::new(0, 64, 0);
    // rust: let mut uses = 0;
    // rust: while w.name(origin) == format!("minecraft:{sapling}") && uses < 64 {
    // rust: assert!(w.bone_meal(origin), "{sapling} is a bone meal target");
    // rust: uses += 1;
}
    // rust: if w.count(log) > 0 {
    // rust: grown += 1;
    // rust: assert_eq!(
    // rust: w.name(origin),
    // rust: format!("minecraft:{log}"),
    // rust: "{sapling} trunk at origin"
    // rust: );
}
}
    // rust: assert!(grown >= 5, "{sapling}: grew {grown} of 6 times");
}

pub fn oak_sapling_grows_with_bone_meal() void {
}
    // rust: grow("oak_sapling", "grass_block", &[(0, 0)], "oak_log");
}
pub fn a_tree_with_bees_fills_its_nest() void {
}
    // rust: let Some(f) = fixture() else { return };
    // rust: let mut w = World::new(f, 3);
    // rust: w.floor("grass_block", 12);
    // rust: let origin = BlockPos::new(0, 64, 0);
    // rust: let placed = f.behaviours.place_feature(
    // rust: &mut w.level,
    // rust: &mut w.ticks,
    // rust: "minecraft:fancy_oak_bees",
    // rust: origin,
    // rust: );
    // rust: assert_eq!(placed, Some(true));
    // rust: assert_eq!(w.count("bee_nest"), 1);
    // rust: let [(at, nbt)] = &w.level.block_entities[..] else {
    // rust: panic!("one block entity: {:?}", w.level.block_entities);
}
    // rust: assert_eq!(w.name(*at), "minecraft:bee_nest");
    // rust: let Some(crate::nbt::Tag::List(bees)) = nbt.get(&"bees".into()) else {
    // rust: panic!("bees: {nbt:?}");
}
    // rust: assert!(
    // rust: (2..=3).contains(&bees.len()),
    // rust: "BeehiveDecorator stores 2 or 3 bees"
    // rust: );
}
pub fn single_saplings_grow() void {
}
    // rust: grow("birch_sapling", "dirt", &[(0, 0)], "birch_log");
    // rust: grow("spruce_sapling", "dirt", &[(0, 0)], "spruce_log");
    // rust: grow("jungle_sapling", "dirt", &[(0, 0)], "jungle_log");
    // rust: grow("acacia_sapling", "dirt", &[(0, 0)], "acacia_log");
    // rust: grow("cherry_sapling", "grass_block", &[(0, 0)], "cherry_log");
    // rust: grow("poplar_sapling", "grass_block", &[(0, 0)], "poplar_log");
}
pub fn two_by_two_saplings_grow() void {
}
    // rust: let square = [(0, 0), (1, 0), (0, 1), (1, 1)];
    // rust: grow("dark_oak_sapling", "grass_block", &square, "dark_oak_log");
    // rust: grow("pale_oak_sapling", "grass_block", &square, "pale_oak_log");
    // rust: grow("spruce_sapling", "podzol", &square, "spruce_log");
    // rust: grow("jungle_sapling", "grass_block", &square, "jungle_log");
}
pub fn lone_dark_oak_sapling_cannot_grow() void {
}
    // rust: let Some(f) = fixture() else { return };
    // rust: let mut w = World::new(f, 1);
    // rust: w.floor("grass_block", 4);
    // rust: let sapling = w.id("dark_oak_sapling", &[]);
    // rust: w.put(BlockPos::new(0, 64, 0), sapling);
    // rust: assert!(!w.bone_meal(BlockPos::new(0, 64, 0)));
}
pub fn bone_meal_on_a_client_succeeds_only_where_its_level_can_tell() void {
}
    // rust: let Some(f) = fixture() else { return };
    // rust: let mut w = World::new(f, 1);
    // rust: w.floor("grass_block", 4);
    // rust: let sapling = w.id("oak_sapling", &[]);
    // rust: w.put(BlockPos::new(0, 64, 0), sapling);
    // rust: w.put(BlockPos::new(1, 64, 0), w.id("wheat", &[("age", "0")]));
    // rust: w.put(BlockPos::new(2, 64, 0), w.id("wheat", &[("age", "7")]));
    // rust: w.put(BlockPos::new(3, 64, 0), w.id("water", &[("level", "0")]));
    // rust: let before = w.level.blocks.clone();
    // rust: let mut client = |pos| {
    // rust: f.behaviours
    // rust: .bone_meal_succeeds_on_client(&mut w.level, pos, Direction::Up)
}
    // SaplingBlock.isValidBonemealTarget needs a ServerLevel: the client passes.
    // rust: assert!(!client(BlockPos::new(0, 64, 0)));
    // CropBlock: below its max age.
    // rust: assert!(client(BlockPos::new(1, 64, 0)));
    // rust: assert!(!client(BlockPos::new(2, 64, 0)));
    // GrassBlock with air above; under water, growWaterPlant above its top face.
    // rust: assert!(client(BlockPos::new(-1, 63, 0)));
    // rust: assert!(client(BlockPos::new(3, 63, 0)));
    // rust: assert!(!client(BlockPos::new(-1, 62, 0)));
    // rust: assert_eq!(w.level.blocks, before, "nothing grows on a client");
    // rust: assert!(w.level.events.is_empty());
    // The server's growCrop takes the sapling.
    // rust: assert!(w.bone_meal(BlockPos::new(0, 64, 0)));
}
/// A mod block answers vanilla's three `BonemealableBlock` questions itself,
/// ahead of the `BonemealableBlock` its template would give it, and the meal
/// is used up with the growth particles and sound as vanilla's are.
pub fn bone_meal_answers_a_mod_blocks_three_questions() void {
}
    /// A level whose bone meal answers are the test's.
pub const ModLevel = struct {
    inner: *'a mut Level,
    valid: ?bool,
    success: bool,
        /// `isBonemealSuccess` was asked, and what it saw.
    rolls: Vec<(BlockPos,
        /// `performBonemeal` ran, and what it saw.
    performed: Vec<(BlockPos,
};
    // rust: impl LevelAccess for ModLevel<'_> {
pub fn day_time(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.inner.day_time()
}
pub fn block_state(self: *Self, pos: BlockPos) B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.inner.block_state(pos)
}
pub fn set_raw(self: *Self, pos: BlockPos, state: BlockStateId) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.inner.set_raw(pos, state)
}
pub fn is_loaded(self: *Self, pos: BlockPos) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.inner.is_loaded(pos)
}
pub fn random(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.inner.random()
}
pub fn game_time(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.inner.game_time()
}
pub fn emit(self: *Self, event: LevelEvent) void {
}
    // rust: self.inner.emit(event);
}
pub fn is_valid_bonemeal_target(self: *Self, _pos: BlockPos, _state: BlockStateId) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.valid
}
pub fn is_bonemeal_success(self: *Self, pos: BlockPos, state: BlockStateId) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.rolls.push((pos, state));
    // rust: self.success
}
pub fn perform_bonemeal(self: *Self, _ticks: *mut Ticks, pos: BlockPos, state: BlockStateId) void {
}
    // rust: self.performed.push((pos, state));
}
}
    // rust: let Some(f) = fixture() else { return };
    // rust: let b = &f.behaviours;
    // rust: let mut w = World::new(f, 1);
    // rust: w.floor("stone", 4);
    // rust: let pos = BlockPos::new(0, 64, 0);
    // rust: let stone = w.id("stone", &[]);
    // rust: let crop = w.id("wheat", &[("age", "0")]);
    // A block nothing in Horizon bonemeals: the level's answers take the meal,
    // the roll grows it, and the caller fires the growth particles and sound.
    // rust: w.put(pos, stone);
    // rust: let mut level = ModLevel {
    // rust: inner: &mut w.level,
    // rust: valid: Some(true),
    // rust: success: true,
    // rust: rolls: Vec::new(),
    // rust: performed: Vec::new(),
}
    // rust: assert!(b.use_bone_meal(&mut level, &mut w.ticks, pos, Direction::Up));
    // rust: assert_eq!(level.rolls, vec![(pos, stone)]);
    // rust: assert_eq!(level.performed, vec![(pos, stone)]);
    // rust: assert!(level.inner.events.iter().any(|e| matches!(
    // rust: e,
    // rust: LevelEvent::LevelEvent { id: 1505, pos: at, data: 15 } if *at == pos
    // rust: )));
    // A roll that fails still uses the meal up, without growing it.
    // rust: let mut level = ModLevel {
    // rust: inner: &mut w.level,
    // rust: valid: Some(true),
    // rust: success: false,
    // rust: rolls: Vec::new(),
    // rust: performed: Vec::new(),
}
    // rust: assert!(b.use_bone_meal(&mut level, &mut w.ticks, pos, Direction::Up));
    // rust: assert!(level.performed.is_empty());
    // Refused: not a target, no roll, no growth, no meal used.
    // rust: let mut level = ModLevel {
    // rust: inner: &mut w.level,
    // rust: valid: Some(false),
    // rust: success: true,
    // rust: rolls: Vec::new(),
    // rust: performed: Vec::new(),
}
    // rust: assert!(!b.use_bone_meal(&mut level, &mut w.ticks, pos, Direction::Up));
    // rust: assert!(level.rolls.is_empty() && level.performed.is_empty());
    // A block whose template bonemeals (a crop) is the mod's instead: the
    // block's own growth doesn't run.
    // rust: w.put(pos, crop);
    // rust: let mut level = ModLevel {
    // rust: inner: &mut w.level,
    // rust: valid: Some(true),
    // rust: success: true,
    // rust: rolls: Vec::new(),
    // rust: performed: Vec::new(),
}
    // rust: assert!(b.grow_crop(&mut level, &mut w.ticks, pos));
    // rust: assert_eq!(level.performed, vec![(pos, crop)]);
    // rust: assert_eq!(level.inner.block_state(pos), crop);
    // Refused by the mod: vanilla's growCrop stops, the crop keeps its meal
    // and doesn't grow.
    // rust: let mut level = ModLevel {
    // rust: inner: &mut w.level,
    // rust: valid: Some(false),
    // rust: success: true,
    // rust: rolls: Vec::new(),
    // rust: performed: Vec::new(),
}
    // rust: assert!(!b.grow_crop(&mut level, &mut w.ticks, pos));
    // rust: assert_eq!(level.inner.block_state(pos), crop);
    // Answered nothing, the crop keeps its own bone meal and grows.
    // rust: let mut level = ModLevel {
    // rust: inner: &mut w.level,
    // rust: valid: None,
    // rust: success: true,
    // rust: rolls: Vec::new(),
    // rust: performed: Vec::new(),
}
    // rust: assert!(b.grow_crop(&mut level, &mut w.ticks, pos));
    // rust: assert!(level.rolls.is_empty() && level.performed.is_empty());
    // rust: assert_ne!(level.inner.block_state(pos), crop, "the crop grew");
    // A client predicts the use with the same answer, where the block itself
    // takes no bone meal on a client.
    // rust: w.put(pos, stone);
    // rust: let mut level = ModLevel {
    // rust: inner: &mut w.level,
    // rust: valid: Some(true),
    // rust: success: true,
    // rust: rolls: Vec::new(),
    // rust: performed: Vec::new(),
}
    // rust: assert!(b.bone_meal_succeeds_on_client(&mut level, pos, Direction::Up));
    // rust: level.valid = Some(false);
    // rust: assert!(!b.bone_meal_succeeds_on_client(&mut level, pos, Direction::Up));
}

pub fn azalea_and_mangrove_grow() void {
}
    // rust: let Some(f) = fixture() else { return };
    // rust: for (block, soil, log) in [
    // rust: ("azalea", "grass_block", "oak_log"),
    // rust: ("mangrove_propagule", "mud", "mangrove_log"),
    // rust: ] {
    // rust: let mut grew = false;
    // rust: for seed in 0..6 {
    // rust: let mut w = World::new(f, seed);
    // rust: w.floor(soil, 12);
    // rust: let state = w.id(block, &[]);
    // rust: w.put(BlockPos::new(0, 64, 0), state);
    // rust: for _ in 0..64 {
    // rust: if w.count(log) > 0 {
    // rust: break;
}
    // rust: w.bone_meal(BlockPos::new(0, 64, 0));
}
    // rust: grew |= w.count(log) > 0;
}
    // rust: assert!(grew, "{block} grows into a tree");
}
}
pub fn random_ticks_advance_sapling_stage_then_grow() void {
}
    // rust: let Some(f) = fixture() else { return };
    // rust: let mut w = World::new(f, 3);
    // rust: w.floor("grass_block", 8);
    // rust: let sapling = w.id("oak_sapling", &[]);
    // rust: let pos = BlockPos::new(0, 64, 0);
    // rust: w.put(pos, sapling);
    // rust: for _ in 0..2000 {
    // rust: let state = w.level.block_state(pos);
    // rust: if !f.behaviours.is_randomly_ticking(state) {
    // rust: break;
}
    // rust: f.behaviours.random_tick(&mut w.level, &mut w.ticks, pos);
}
    // rust: assert_eq!(w.name(pos), "minecraft:oak_log");
}
pub fn grass_bone_meal_places_grass_and_flowers() void {
}
    // rust: let Some(f) = fixture() else { return };
    // rust: let mut w = World::new(f, 7);
    // rust: w.floor("grass_block", 8);
    // rust: assert!(w.bone_meal(BlockPos::new(0, 63, 0)));
    // rust: let plants = w.count("short_grass") + w.count("tall_grass");
    // rust: let flowers = w.count("dandelion")
    // rust: + w.count("poppy")
    // rust: + w.count("cornflower")
    // rust: + w.count("oxeye_daisy")
    // rust: + w.count("azure_bluet")
    // rust: + w.count("_tulip");
    // rust: assert!(plants > 10, "grass placed: {plants}");
    // rust: assert!(plants + flowers > 15);
    // rust: assert!(
    // rust: w.level
    // rust: .events
    // rust: .iter()
    // rust: .any(|e| matches!(e, LevelEvent::LevelEvent { id: 1505, .. }))
    // rust: );
}
pub fn huge_mushroom_and_fungus_grow() void {
}
    // rust: let Some(f) = fixture() else { return };
    // rust: let mut grew = (false, false);
    // rust: for seed in 0..8 {
    // rust: let mut w = World::new(f, seed);
    // rust: w.floor("mycelium", 8);
    // rust: let mushroom = w.id("red_mushroom", &[]);
    // rust: w.put(BlockPos::new(0, 64, 0), mushroom);
    // rust: for _ in 0..16 {
    // rust: w.bone_meal(BlockPos::new(0, 64, 0));
}
    // rust: grew.0 |= w.count("red_mushroom_block") > 0 && w.count("mushroom_stem") > 0;
    // rust: let mut w = World::new(f, seed);
    // rust: w.floor("crimson_nylium", 8);
    // rust: let fungus = w.id("crimson_fungus", &[]);
    // rust: w.put(BlockPos::new(0, 64, 0), fungus);
    // rust: for _ in 0..16 {
    // rust: if w.count("crimson_stem") > 0 {
    // rust: break;
}
    // rust: w.bone_meal(BlockPos::new(0, 64, 0));
}
    // rust: grew.1 |= w.count("crimson_stem") > 0 && w.count("nether_wart_block") > 0;
}
    // rust: assert!(grew.0, "huge red mushroom");
    // rust: assert!(grew.1, "huge crimson fungus");
}
pub fn crops_age_with_bone_meal() void {
}
    // rust: let Some(f) = fixture() else { return };
    // rust: let mut w = World::new(f, 11);
    // rust: let farmland = w.id("farmland", &[]);
    // rust: let pos = BlockPos::new(0, 64, 0);
    // rust: w.put(BlockPos::new(0, 63, 0), farmland);
    // rust: w.put(pos, w.id("wheat", &[]));
    // rust: let mut uses = 0;
    // rust: while w.bone_meal(pos) {
    // rust: uses += 1;
}
    // rust: assert!((2..=4).contains(&uses), "wheat matured after {uses} uses");
    // rust: assert_eq!(w.level.block_state(pos), w.id("wheat", &[("age", "7")]));
    // rust: w.put(pos, w.id("torchflower_crop", &[]));
    // rust: assert!(w.bone_meal(pos));
    // rust: assert!(w.bone_meal(pos));
    // rust: assert_eq!(w.name(pos), "minecraft:torchflower");
    // rust: assert!(!w.bone_meal(pos), "torchflowers are not bonemealable");
}
pub fn tall_flowers_and_seagrass() void {
}
    // rust: let Some(f) = fixture() else { return };
    // rust: let mut w = World::new(f, 5);
    // rust: w.floor("dirt", 2);
    // rust: let fern = w.id("fern", &[]);
    // rust: w.put(BlockPos::new(0, 64, 0), fern);
    // rust: assert!(w.bone_meal(BlockPos::new(0, 64, 0)));
    // rust: assert_eq!(w.name(BlockPos::new(0, 64, 0)), "minecraft:large_fern");
    // rust: assert_eq!(w.name(BlockPos::new(0, 65, 0)), "minecraft:large_fern");
    // rust: let lilac = w.id("lilac", &[("half", "lower")]);
    // rust: w.put(BlockPos::new(1, 64, 0), lilac);
    // rust: assert!(w.bone_meal(BlockPos::new(1, 64, 0)));
    // rust: assert!(w.level.events.iter().any(|e| matches!(
    // rust: e,
    // rust: LevelEvent::BlockEvent {
    // rust: kind: "pop_block_item",
    // rust: ..
}
    // rust: )));
}

pub fn snowy_biomes_freeze_and_snow() void {
}
    // rust: let Some(f) = fixture() else { return };
    // rust: let mut w = World::new(f, 1);
    // rust: w.level.biome = "minecraft:snowy_plains";
    // rust: w.floor("grass_block", 2);
    // rust: let water = w.id("water", &[]);
    // rust: w.put(BlockPos::new(1, 63, 0), water);
    // rust: let b = &f.behaviours;
    // rust: let grass = b
    // rust: .precipitation_info(&w.level, BlockPos::new(0, 70, 0))
    // rust: .unwrap();
    // rust: assert_eq!(grass.top, BlockPos::new(0, 64, 0));
    // rust: assert!(grass.snows_at_top && !grass.freezes_below);
    // rust: assert_eq!(grass.kind, PrecipitationKind::Snow);
    // rust: let pond = b
    // rust: .precipitation_info(&w.level, BlockPos::new(1, 70, 0))
    // rust: .unwrap();
    // rust: assert!(pond.freezes_below, "a water source at the edge freezes");
    // rust: w.level.biome = "minecraft:plains";
    // rust: let rain = b
    // rust: .precipitation_info(&w.level, BlockPos::new(0, 70, 0))
    // rust: .unwrap();
    // rust: assert!(!rain.snows_at_top && !rain.freezes_below);
    // rust: assert_eq!(rain.kind, PrecipitationKind::Rain);
}

pub fn a_template_with_entities_and_no_blocks_places_them() void {
}
//     use crate::{
    // rust: nbt::{Compound, JavaString, Tag},
    // rust: worldgen::structure::{EntityInfo, Mirror, Rotation, StructureTemplate, save_nbt},
}
    // rust: let Some(f) = fixture() else { return };
    // rust: let resources = f
    // rust: .behaviours
    // rust: .live_features()
    // rust: .and_then(|features| features.structure_resources())
    // rust: .expect("structure resources");
    // rust: let mut pig = Compound::new();
    // rust: pig.insert("id".into(), Tag::String("minecraft:pig".into()));
    // rust: let pig = EntityInfo {
    // rust: pos: [0.5, 0.0, 0.5],
    // rust: block_pos: [0, 0, 0],
    // rust: nbt: pig,
}
    // StructureTemplate.placeInWorld places when there are blocks, or entities
    // it does not ignore.
    // rust: for (entities, ignore_entities, expected) in [
    // rust: (vec![pig.clone()], false, true),
    // rust: (vec![pig], true, false),
    // rust: (vec![], false, false),
    // rust: ] {
    // rust: let mut w = World::new(f, 0);
    // rust: let tag = save_nbt(
    // rust: f.registry,
    // rust: &resources.transforms,
    // rust: [1, 1, 1],
    // rust: Vec::new(),
    // rust: &entities,
    // rust: horizon_core::version::DATA_VERSION,
    // rust: );
    // rust: let template = StructureTemplate::from_nbt(&tag, f.registry, &resources.transforms);
    // rust: let settings = TemplateSettings {
    // rust: mirror: Mirror::None,
    // rust: rotation: Rotation::None,
    // rust: ignore_entities,
    // rust: known_shape: false,
    // rust: integrity: 1.0,
    // rust: seed: 0,
    // rust: flags: flags::UPDATE_CLIENTS,
}
    // rust: let (placed, spawned) = f
    // rust: .behaviours
    // rust: .place_template(
    // rust: &mut w.level,
    // rust: &mut w.ticks,
    // rust: &template,
    // rust: BlockPos::new(3, 64, -2),
    // rust: settings,
    // rust: )
    // rust: .expect("structure resources");
    // rust: let what = format!("{} entities, ignored {ignore_entities}", entities.len());
    // rust: assert_eq!(placed, expected, "{what}");
    // rust: assert_eq!(spawned.len(), usize::from(expected), "{what}");
    // rust: if let Some(nbt) = spawned.first() {
    // rust: assert_eq!(
    // rust: nbt.get(&JavaString::from("id")),
    // rust: Some(&Tag::String("minecraft:pig".into()))
    // rust: );
    // rust: let pos = [3.5, 64.0, -1.5].map(|v: f64| Tag::Double(v.to_bits()));
    // rust: assert_eq!(
    // rust: nbt.get(&JavaString::from("Pos")),
    // rust: Some(&Tag::List(pos.to_vec()))
    // rust: );
}
}
}
pub fn eyeblossoms_open_at_night_and_wake_neighbours() void {
}
    // rust: let Some(f) = fixture() else { return };
    // rust: let mut w = World::new(f, 2);
    // rust: w.floor("grass_block", 4);
    // rust: let closed = w.id("closed_eyeblossom", &[]);
    // rust: w.put(BlockPos::new(0, 64, 0), closed);
    // rust: w.put(BlockPos::new(2, 64, 1), closed);
    // rust: f.behaviours
    // rust: .random_tick(&mut w.level, &mut w.ticks, BlockPos::new(0, 64, 0));
    // rust: assert_eq!(
    // rust: w.name(BlockPos::new(0, 64, 0)),
    // rust: "minecraft:closed_eyeblossom",
    // rust: "closed by day"
    // rust: );
    // rust: w.level.day = 13000;
    // rust: f.behaviours
    // rust: .random_tick(&mut w.level, &mut w.ticks, BlockPos::new(0, 64, 0));
    // rust: assert_eq!(w.name(BlockPos::new(0, 64, 0)), "minecraft:open_eyeblossom");
    // rust: let block = f.behaviours.block(closed);
    // rust: assert!(
    // rust: w.ticks.has_block_tick(BlockPos::new(2, 64, 1), block),
    // rust: "neighbour scheduled"
    // rust: );
    // rust: assert!(w.level.events.iter().any(|e| matches!(e, LevelEvent::Sound { sound, .. } if &**sound == "minecraft:block.eyeblossom.open_long")));
}
pub fn turtle_eggs_crack_at_dawn_on_sand() void {
}
    // rust: let Some(f) = fixture() else { return };
    // rust: let mut w = World::new(f, 3);
    // rust: w.floor("sand", 1);
    // rust: let egg = w.id("turtle_egg", &[]);
    // rust: let pos = BlockPos::new(0, 64, 0);
    // rust: w.put(pos, egg);
    // rust: w.level.day = 21500;
    // rust: f.behaviours.random_tick(&mut w.level, &mut w.ticks, pos);
    // rust: assert_eq!(
    // rust: w.level.block_state(pos),
    // rust: w.id("turtle_egg", &[("hatch", "1")])
    // rust: );
    // rust: f.behaviours.random_tick(&mut w.level, &mut w.ticks, pos);
    // rust: f.behaviours.random_tick(&mut w.level, &mut w.ticks, pos);
    // rust: assert_eq!(w.name(pos), "minecraft:air", "hatched");
}
pub fn sniffer_eggs_crack_twice_then_hatch_a_snifflet() void {
}
    // rust: let Some(f) = fixture() else { return };
    // rust: let mut w = World::new(f, 5);
    // rust: w.floor("moss_block", 1);
    // rust: let egg = w.id("sniffer_egg", &[]);
    // rust: let pos = BlockPos::new(0, 64, 0);
    // rust: f.behaviours
    // rust: .set_block(&mut w.level, &mut w.ticks, pos, egg, flags::UPDATE_ALL);
    // rust: let block = f.behaviours.block(egg);
    // rust: assert!(
    // rust: w.ticks.has_block_tick(pos, block),
    // rust: "placing schedules the first stage"
    // rust: );
    // rust: for stage in 1..=2 {
    // rust: f.behaviours
    // rust: .scheduled_block_tick(&mut w.level, &mut w.ticks, pos);
    // rust: assert_eq!(
    // rust: w.level.block_state(pos),
    // rust: w.id("sniffer_egg", &[("hatch", &stage.to_string())])
    // rust: );
}
    // rust: f.behaviours
    // rust: .scheduled_block_tick(&mut w.level, &mut w.ticks, pos);
    // rust: assert_eq!(w.name(pos), "minecraft:air", "hatched");
    // rust: assert!(w.level.events.iter().any(|e| matches!(
    // rust: e,
    // rust: LevelEvent::BlockEvent {
    // rust: kind: "hatch_sniffer",
    // rust: ..
}
    // rust: )));
}
pub fn a_non_strict_template_updates_its_shapes_and_neighbours() void {
}
//     use crate::worldgen::structure::{BlockInfo, Mirror, Rotation, StructureTemplate, save_nbt};
    // rust: let Some(f) = fixture() else { return };
    // rust: let resources = f
    // rust: .behaviours
    // rust: .live_features()
    // rust: .and_then(|features| features.structure_resources())
    // rust: .expect("structure resources");
    // rust: for strict in [false, true] {
    // rust: let mut w = World::new(f, 0);
    // rust: let fence = w.id("oak_fence", &[]);
    // rust: let power = w.id("redstone_block", &[]);
    // rust: let block = |pos: [i32; 3], state: BlockStateId| BlockInfo {
    // rust: pos,
    // rust: state,
    // rust: nbt: None,
}
    // rust: let blocks = vec![
    // rust: block([0, 0, 0], fence),
    // rust: block([1, 0, 0], fence),
    // rust: block([2, 0, 0], power),
    // rust: ];
    // rust: let tag = save_nbt(
    // rust: f.registry,
    // rust: &resources.transforms,
    // rust: [3, 1, 1],
    // rust: blocks,
    // rust: &[],
    // rust: horizon_core::version::DATA_VERSION,
    // rust: );
    // rust: let template = StructureTemplate::from_nbt(&tag, f.registry, &resources.transforms);
    // rust: let lamp = w.id("redstone_lamp", &[("lit", "false")]);
    // rust: w.put(BlockPos::new(3, 64, 0), lamp);
    // rust: let settings = TemplateSettings {
    // rust: mirror: Mirror::None,
    // rust: rotation: Rotation::None,
    // rust: ignore_entities: true,
    // rust: known_shape: strict,
    // rust: integrity: 1.0,
    // rust: seed: 0,
            // StructureBlockEntity.placeStructure's `2 | (strict ? 816 : 0)`.
    // rust: flags: flags::UPDATE_CLIENTS | if strict { 816 } else { 0 },
}
    // rust: let (placed, _) = f
    // rust: .behaviours
    // rust: .place_template(
    // rust: &mut w.level,
    // rust: &mut w.ticks,
    // rust: &template,
    // rust: BlockPos::new(0, 64, 0),
    // rust: settings,
    // rust: )
    // rust: .expect("structure resources");
    // rust: assert!(placed);
        // The middle fence: placing the redstone block connects its east side,
        // only the shape pass connects its west side to the fence placed before
        // it.
    // rust: let connected = w.id("oak_fence", &[("east", "true"), ("west", "true")]);
    // rust: let lit = w.id("redstone_lamp", &[("lit", "true")]);
    // rust: assert_eq!(
    // rust: w.level.block_state(BlockPos::new(1, 64, 0)) == connected,
    // rust: !strict,
    // rust: "strict {strict}: the middle fence connects to the fence placed before it"
    // rust: );
    // rust: assert_eq!(
    // rust: w.level.block_state(BlockPos::new(3, 64, 0)) == lit,
    // rust: !strict,
    // rust: "strict {strict}: the lamp next to the template lights"
    // rust: );
}
}
