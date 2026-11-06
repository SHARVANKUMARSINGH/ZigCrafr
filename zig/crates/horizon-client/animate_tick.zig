//! Transpiled from Horizon Rust crate
//! Module: horizon-client_animate_tick
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Client-side ambient block effects: `ClientLevel.animateTick` (667 random
//! blocks within 16 and 32 blocks per tick calling `Block.animateTick` and
//! `FluidState.animateTick`, fluid drips and biome ambient particles) and the
//! campfire block-entity particle tick. Particle positions, odds and sounds
//! follow the vanilla block classes.
// use crate::{
    // rust: biome::Biomes,
    // rust: blocks::{BlockFacts, Fluid},
    // rust: command::args::GameMode,
    // rust: items::ItemStack,
    // rust: particles::{ParticleEngine, ParticleOptions, ParticleType as T, along_axis},
    // rust: world::World,
}
// use horizon_core::{
    // rust: geometry::Axis,
    // rust: random::{LegacyRandom, RandomSource},
}
// use horizon_world::{
    // rust: block_collision::BlockCollisionRegistry,
    // rust: registry::{BlockRegistry, BlockStateId},
    // rust: worldgen::tags::TagDefinitions,
}
// use std::{collections::BTreeMap, path::Path};

pub const Animate = enum {
    None,
    Torch(T),
    WallTorch(T, [i32; 3]),
    RedstoneTorch,
    RedstoneWallTorch([i32; 3]),
    Furnace([i32; 3]),
    BlastFurnace([i32; 3]),
    Smoker,
    Campfire {,
    spawn_particles: bool,
    // rust: },
    /// Leaves: optional falling-leaf particle and chance; a tinted leaf takes
    /// the biome foliage colour unless a fixed colour is given (azalea); and
    /// whether they have the poplar ambient sound (`AmbientLeavesBlockSoundPlayer`).
    Leaves(Option<(T, f32)>, Option<u32>, bool),
    NetherPortal,
    EnchantingTable,
    EndRod([i32; 3]),
    SporeBlossom,
    CryingObsidian,
    Mycelium,
    Candles(u8),
    CandleCake,
    BrewingStand,
    EnderChest,
    /// FallingBlock with its dust colour; sand also has the ambient desert sound
    /// (`SandBlock.animateTick`).
    Falling(u32, bool),
    /// A beehive or bee nest full of honey (`BeehiveBlock.animateTick`).
    Beehive,
    RedstoneOre,
    RedstoneWire {,
    power: u8,
    sides: [u8; 4],
    // rust: },
    RespawnAnchor,
    BubbleColumn {,
    drag: bool,
    // rust: },
    /// `BaseFireBlock` (`SoulFireBlock.canBurn` is always true).
    Fire {,
    soul: bool,
    // rust: },
    /// An active sculk sensor.
    SculkSensor,
    /// Potent sulfur that is not dry.
    PotentSulfur,
    DriedGhast {,
    waterlogged: bool,
    // rust: },
    EndPortal,
    /// A powered lever: its facing and the direction it is attached toward.
    Lever {,
    facing: [i32; 3],
    connected: [i32; 3],
    // rust: },
    /// A powered repeater.
    Repeater {,
    facing: [i32; 3],
    delay: i32,
    // rust: },
    /// A free-hanging stalactite tip that is not waterlogged.
    PointedDripstone,
    WitherRose,
    EndGateway,
    /// A lightning rod, by the axis it points along (0, 1, 2 for X, Y, Z).
    LightningRod(usize),
    /// `WetSpongeBlock.animateTick`.
    WetSponge,
    FireflyBush,
    /// An open eyeblossom (`Type.OPEN.emitSounds()`).
    OpenEyeblossom,
    PaleHangingMoss,
    /// `DryVegetationBlock`: a dead bush.
    DeadBush,
    /// `ShortDryGrassBlock` and `TallDryGrassBlock`.
    DryGrass,
    /// A creaking heart that is not uprooted (`CreakingHeartBlock.animateTick`).
    CreakingHeart,
};
pub fn step(facing: []const u8) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match facing {
    // rust: "north" => [0, 0, -1],
    // rust: "south" => [0, 0, 1],
    // rust: "west" => [-1, 0, 0],
    // rust: "east" => [1, 0, 0],
    // rust: "up" => [0, 1, 0],
    // rust: _ => [0, -1, 0],
}
}
pub fn classify(name: []const u8, prop: *dyn Fn([]const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let name = name.strip_prefix("minecraft:").unwrap_or(name);
    // rust: let lit = prop("lit").as_deref() == Some("true");
    // rust: let powered = prop("powered").as_deref() == Some("true");
    // rust: let facing = || step(&prop("facing").unwrap_or_default());
    // rust: match name {
    // rust: "torch" => Animate::Torch(T::Flame),
    // rust: "soul_torch" => Animate::Torch(T::SoulFireFlame),
    // rust: "copper_torch" => Animate::Torch(T::CopperFireFlame),
    // rust: "wall_torch" => Animate::WallTorch(T::Flame, facing()),
    // rust: "soul_wall_torch" => Animate::WallTorch(T::SoulFireFlame, facing()),
    // rust: "copper_wall_torch" => Animate::WallTorch(T::CopperFireFlame, facing()),
    // rust: "redstone_torch" if lit => Animate::RedstoneTorch,
    // rust: "redstone_wall_torch" if lit => Animate::RedstoneWallTorch(facing()),
    // rust: "furnace" if lit => Animate::Furnace(facing()),
    // rust: "blast_furnace" if lit => Animate::BlastFurnace(facing()),
    // rust: "smoker" if lit => Animate::Smoker,
    // rust: "campfire" if lit => Animate::Campfire {
    // rust: spawn_particles: true,
    // rust: },
    // rust: "soul_campfire" if lit => Animate::Campfire {
    // rust: spawn_particles: false,
    // rust: },
    // rust: "oak_leaves" | "birch_leaves" | "jungle_leaves" | "acacia_leaves" | "dark_oak_leaves"
    // rust: | "mangrove_leaves" => Animate::Leaves(Some((T::TintedLeaves, 0.01)), None, false),
    // rust: "cherry_leaves" => Animate::Leaves(Some((T::CherryLeaves, 0.1)), None, false),
    // rust: "pale_oak_leaves" => Animate::Leaves(Some((T::PaleOakLeaves, 0.02)), None, false),
    // rust: "red_poplar_leaves" => Animate::Leaves(Some((T::RedPoplarLeaves, 0.01)), None, true),
    // rust: "orange_poplar_leaves" => Animate::Leaves(Some((T::OrangePoplarLeaves, 0.01)), None, true),
    // rust: "yellow_poplar_leaves" => Animate::Leaves(Some((T::YellowPoplarLeaves, 0.01)), None, true),
        // The azalea blocks drop tinted leaves of the fixed colour -9399763.
    // rust: "azalea_leaves" | "flowering_azalea_leaves" => {
    // rust: Animate::Leaves(Some((T::TintedLeaves, 0.01)), Some(0x0070_922D), false)
}
    // rust: "spruce_leaves" => Animate::Leaves(None, None, false),
    // rust: "nether_portal" => Animate::NetherPortal,
    // rust: "enchanting_table" => Animate::EnchantingTable,
    // rust: "end_rod" => Animate::EndRod(facing()),
    // rust: "spore_blossom" => Animate::SporeBlossom,
    // rust: "crying_obsidian" => Animate::CryingObsidian,
    // rust: "mycelium" => Animate::Mycelium,
    // rust: "brewing_stand" => Animate::BrewingStand,
    // rust: "ender_chest" => Animate::EnderChest,
    // rust: "sand" => Animate::Falling(0xDBD3A0, true),
    // rust: "red_sand" => Animate::Falling(0xA95821, true),
    // rust: "gravel" => Animate::Falling(0x807C7B, false),
        // AnvilBlock/ConcretePowderBlock.getDustColor is the map colour;
        // DragonEggBlock's is black.
    // rust: "anvil" | "chipped_anvil" | "damaged_anvil" => Animate::Falling(0xA7A7A7, false),
    // rust: "dragon_egg" => Animate::Falling(0x000000, false),
    // rust: _ if name.ends_with("_concrete_powder") => Animate::Falling(
    // rust: concrete_powder_color(name.trim_end_matches("_concrete_powder")),
    // rust: false,
    // rust: ),
    // rust: "beehive" | "bee_nest" if prop("honey_level").as_deref() == Some("5") => Animate::Beehive,
    // rust: "redstone_ore" | "deepslate_redstone_ore" if lit => Animate::RedstoneOre,
    // rust: "redstone_wire" => {
    // rust: let power = prop("power").and_then(|p| p.parse().ok()).unwrap_or(0);
    // rust: let side = |d: &str| match prop(d).as_deref() {
    // rust: Some("up") => 2,
    // rust: Some("side") => 1,
    // rust: _ => 0,
}
    // rust: if power == 0 {
    // rust: Animate::None
    // rust: } else {
    // rust: Animate::RedstoneWire {
    // rust: power,
    // rust: sides: [side("north"), side("east"), side("south"), side("west")],
}
}
}
    // rust: "respawn_anchor" if prop("charges").is_some_and(|c| c != "0") => Animate::RespawnAnchor,
    // rust: "potent_sulfur" if prop("potent_sulfur_state").is_some_and(|s| s != "dry") => {
    // rust: Animate::PotentSulfur
}
    // rust: "bubble_column" => Animate::BubbleColumn {
    // rust: drag: prop("drag").as_deref() == Some("true"),
    // rust: },
    // rust: "fire" => Animate::Fire { soul: false },
    // rust: "soul_fire" => Animate::Fire { soul: true },
    // rust: "dried_ghast" => Animate::DriedGhast {
    // rust: waterlogged: prop("waterlogged").as_deref() == Some("true"),
    // rust: },
    // rust: "end_portal" => Animate::EndPortal,
    // rust: "lever" if powered => Animate::Lever {
    // rust: facing: facing(),
            // FaceAttachedHorizontalDirectionalBlock.getConnectedDirection.
    // rust: connected: match prop("face").as_deref() {
    // rust: Some("ceiling") => [0, -1, 0],
    // rust: Some("floor") => [0, 1, 0],
    // rust: _ => facing(),
    // rust: },
    // rust: },
    // rust: "repeater" if powered => Animate::Repeater {
    // rust: facing: facing(),
    // rust: delay: prop("delay").and_then(|d| d.parse().ok()).unwrap_or(1),
    // rust: },
    // rust: "pointed_dripstone"
    // rust: if prop("vertical_direction").as_deref() == Some("down")
    // rust: && prop("thickness").as_deref() == Some("tip")
    // rust: && prop("waterlogged").as_deref() != Some("true") =>
    // rust: {
    // rust: Animate::PointedDripstone
}
    // rust: "wither_rose" => Animate::WitherRose,
    // rust: "end_gateway" => Animate::EndGateway,
    // rust: _ if name == "lightning_rod" || name.ends_with("_lightning_rod") => {
    // rust: let [dx, dy, _] = facing();
    // rust: Animate::LightningRod(if dx != 0 {
    // rust: 0
    // rust: } else if dy != 0 {
    // rust: 1
    // rust: } else {
    // rust: 2
    // rust: })
}
    // rust: "wet_sponge" => Animate::WetSponge,
        // BrushableBlock has no dust colour of its own, so the dust is the map colour.
    // rust: "suspicious_sand" => Animate::Falling(0xF7E9A3, false),
    // rust: "suspicious_gravel" => Animate::Falling(0x707070, false),
    // rust: "firefly_bush" => Animate::FireflyBush,
    // rust: "open_eyeblossom" => Animate::OpenEyeblossom,
    // rust: "pale_hanging_moss" => Animate::PaleHangingMoss,
    // rust: "creaking_heart" if prop("creaking_heart_state").as_deref() != Some("uprooted") => {
    // rust: Animate::CreakingHeart
}
    // rust: "dead_bush" => Animate::DeadBush,
    // rust: "short_dry_grass" | "tall_dry_grass" => Animate::DryGrass,
    // rust: "sculk_sensor" | "calibrated_sculk_sensor"
    // rust: if prop("sculk_sensor_phase").as_deref() == Some("active") =>
    // rust: {
    // rust: Animate::SculkSensor
}
    // rust: _ if name.ends_with("candle_cake") && lit => Animate::CandleCake,
    // rust: _ if (name == "candle" || name.ends_with("_candle")) && lit => {
    // rust: Animate::Candles(prop("candles").and_then(|c| c.parse().ok()).unwrap_or(1))
}
    // rust: _ => Animate::None,
}
}
/// `DyeColor.getMapColor` of a concrete powder colour.
pub fn concrete_powder_color(dye: []const u8) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match dye {
    // rust: "white" => 0xFFFFFF,
    // rust: "orange" => 0xD87F33,
    // rust: "magenta" => 0xB24CD8,
    // rust: "light_blue" => 0x6699D8,
    // rust: "yellow" => 0xE5E533,
    // rust: "lime" => 0x7FCC19,
    // rust: "pink" => 0xF27FA5,
    // rust: "gray" => 0x4C4C4C,
    // rust: "light_gray" => 0x999999,
    // rust: "cyan" => 0x4C7F99,
    // rust: "purple" => 0x7F3FB2,
    // rust: "blue" => 0x334CB2,
    // rust: "brown" => 0x664C33,
    // rust: "green" => 0x667F33,
    // rust: "red" => 0x993333,
    // rust: _ => 0x191919,
}
}
/// `RedstoneWireBlock.COLORS`.
pub fn redstone_color(power: u8) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let f = f32::from(power) / 15.0;
    // rust: let r = f * 0.6 + if f > 0.0 { 0.4 } else { 0.3 };
    // rust: let g = (f * f * 0.7 - 0.5).clamp(0.0, 1.0);
    // rust: let b = (f * f * 0.6 - 0.7).clamp(0.0, 1.0);
    // DustParticleOptions stores the packed int colour.
    // rust: let q = |c: f32| ((c * 255.0) as u8) as f32 / 255.0;
    // rust: [q(r), q(g), q(b)]
}
/// `CandleBlock.PARTICLE_OFFSETS` by candle count (pixels).
pub fn candle_offsets(count: u8) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match count {
    // rust: 1 => &[[8.0, 8.0, 8.0]],
    // rust: 2 => &[[6.0, 7.0, 8.0], [10.0, 8.0, 7.0]],
    // rust: 3 => &[[8.0, 5.0, 10.0], [6.0, 7.0, 8.0], [9.0, 8.0, 7.0]],
    // rust: _ => &[
    // rust: [7.0, 5.0, 9.0],
    // rust: [10.0, 7.0, 9.0],
    // rust: [6.0, 7.0, 6.0],
    // rust: [9.0, 8.0, 6.0],
    // rust: ],
}
}

/// Per-state animate behaviour and the block tags it needs. Empty by default
/// (a dedicated server): every lookup finds nothing to animate.
pub const AnimateTables = struct {
    kinds: std.ArrayList(Animate),
    impermeable: std.ArrayList(bool),
    power_provider: std.ArrayList(bool),
    power_transmitter: std.ArrayList(bool),
    /// `#triggers_ambient_dried_ghast_block_sounds` (soul sand, soul soil).
    dried_ghast_sounds: std.ArrayList(bool),
    /// `#triggers_ambient_desert_sand_block_sounds` (sand, red sand).
    desert_sand_sounds: std.ArrayList(bool),
    /// `#required_for_poplar_leaf_ambience` (overworld natural logs).
    poplar_leaf_logs: std.ArrayList(bool),
    /// `#triggers_ambient_desert_dry_vegetation_block_sounds`.
    desert_dry_vegetation_sounds: std.ArrayList(bool),
    terracotta: std.ArrayList(bool),
    pale_oak_logs: std.ArrayList(bool),
    /// `FireBlock.canBurn`: states with ignite odds above zero (none waterlogged).
    burnable: std.ArrayList(bool),
    /// Biome id -> ambient particles and probabilities (`minecraft:visual/ambient_particles`).
    ambient: Vec<Vec<(T,
    /// Per state: 1 for a pointed dripstone, 2 for one whose tip points down.
    dripstone: std.ArrayList(u8),
};
    // rust: impl AnimateTables {
pub fn load(root: *Path, registry: *BlockRegistry, biomes: *Biomes) c {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let kinds = (0..registry.len() as u32)
    // rust: .map(|id| {
    // rust: registry.state(BlockStateId(id)).map_or(Animate::None, |s| {
    // rust: classify(&s.name, &|k| s.properties.get(k).cloned())
    // rust: })
    // rust: })
    // rust: .collect();
    // rust: let bundle: BTreeMap<String, String> =
    // rust: serde_json::from_slice(&std::fs::read(root.join("block-tags.json"))?)?;
    // rust: let mut definitions = TagDefinitions::default();
    // rust: for (name, text) in bundle {
    // rust: definitions.apply_json(&name, "vanilla", &text)?;
}
    // rust: let built =
    // rust: definitions.build(|name, _| registry.default_state(name).map(|_| name.to_owned()))?;
    // rust: let by_state = |tag: &str| -> Vec<bool> {
    // rust: let names = built.tags.get(tag);
    // rust: (0..registry.len() as u32)
    // rust: .map(|id| {
    // rust: registry
    // rust: .state(BlockStateId(id))
    // rust: .is_some_and(|s| names.is_some_and(|n| n.contains(&s.name)))
    // rust: })
    // rust: .collect()
}
    // rust: let behaviour: serde_json::Value =
    // rust: serde_json::from_slice(&std::fs::read(root.join("block-behaviours.json"))?)?;
    // rust: let ignite_odds = behaviour["fire"]["igniteOdds"].as_object();
    // rust: let burnable = (0..registry.len() as u32)
    // rust: .map(|id| {
                // FireBlock.getIgniteOdds: a waterlogged state never burns.
    // rust: registry.state(BlockStateId(id)).is_some_and(|s| {
    // rust: s.properties.get("waterlogged").map(String::as_str) != Some("true")
    // rust: && ignite_odds
    // rust: .and_then(|m| m.get(s.name.as_str()))
    // rust: .and_then(serde_json::Value::as_i64)
    // rust: .is_some_and(|odds| odds > 0)
    // rust: })
    // rust: })
    // rust: .collect();
    // rust: let mut ambient = vec![Vec::new(); biomes.list.len()];
    // rust: for (name, &id) in &biomes.index {
    // rust: let path = root.join(format!(
    // rust: "data/minecraft/worldgen/biome/{}.json",
    // rust: name.trim_start_matches("minecraft:")
    // rust: ));
    // rust: let Ok(bytes) = std::fs::read(path) else {
    // rust: continue;
}
    // rust: let Ok(json) = serde_json::from_slice::<serde_json::Value>(&bytes) else {
    // rust: continue;
}
    // rust: let list = &json["attributes"]["minecraft:visual/ambient_particles"];
    // rust: let entries = list["argument"].as_array().or_else(|| list.as_array());
    // rust: for entry in entries.into_iter().flatten() {
    // rust: let ty = entry["particle"]["type"].as_str().and_then(T::from_name);
    // rust: let probability = entry["probability"].as_f64().unwrap_or(0.0) as f32;
    // rust: if let (Some(ty), Some(slot)) = (ty, ambient.get_mut(id as usize)) {
    // rust: slot.push((ty, probability));
}
}
}
    // rust: let dripstone = (0..registry.len() as u32)
    // rust: .map(|id| {
    // rust: registry.state(BlockStateId(id)).map_or(0, |s| {
    // rust: let name = s.name.strip_prefix("minecraft:").unwrap_or(&s.name);
    // rust: if name != "pointed_dripstone" {
    // rust: 0
    // rust: } else if s.properties.get("vertical_direction").map(String::as_str)
    // rust: == Some("down")
    // rust: {
    // rust: 2
    // rust: } else {
    // rust: 1
}
    // rust: })
    // rust: })
    // rust: .collect();
    // rust: Ok(Self {
    // rust: kinds,
    // rust: dripstone,
    // rust: impermeable: by_state("minecraft:impermeable"),
    // rust: power_provider: by_state("minecraft:enchantment_power_provider"),
    // rust: power_transmitter: by_state("minecraft:enchantment_power_transmitter"),
    // rust: dried_ghast_sounds: by_state("minecraft:triggers_ambient_dried_ghast_block_sounds"),
    // rust: desert_sand_sounds: by_state("minecraft:triggers_ambient_desert_sand_block_sounds"),
    // rust: poplar_leaf_logs: by_state("minecraft:required_for_poplar_leaf_ambience"),
    // rust: desert_dry_vegetation_sounds: by_state(
    // rust: "minecraft:triggers_ambient_desert_dry_vegetation_block_sounds",
    // rust: ),
    // rust: terracotta: by_state("minecraft:terracotta"),
    // rust: pale_oak_logs: by_state("minecraft:pale_oak_logs"),
    // rust: burnable,
    // rust: ambient,
    // rust: })
}
pub fn kind(self: *Self, state: BlockStateId) A {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.kinds
    // rust: .get(state.0 as usize)
    // rust: .copied()
    // rust: .unwrap_or(Animate::None)
}
    /// Whether a state ticks campfire particles (`CampfireBlockEntity.particleTick`).
pub fn is_lit_campfire(self: *Self, state: u32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: matches!(self.kind(BlockStateId(state)), Animate::Campfire { .. })
}
}

/// World access for ambient effects.
pub const AnimateContext = struct {
    world: *'a World,
    facts: *'a BlockFacts,
    collision: *'a BlockCollisionRegistry<'a>,
    biomes: *'a Biomes,
    registry: *'a BlockRegistry,
    /// `Level.isRainingAt`.
    raining_at: *'a dyn Fn([i32,
    /// `getHeight(MOTION_BLOCKING_NO_LEAVES, x, z)` at a position's column.
    height_no_leaves: *'a dyn Fn([i32,
    /// `EnvironmentAttributes.FIREFLY_BUSH_SOUNDS` (overworld day timeline).
    firefly_bush_sounds: bool,
    /// `EnvironmentAttributes.CREAKING_ACTIVE` (overworld day timeline).
    creaking_active: bool,
    /// `Level.getSkyDarken`, for `getMaxLocalRawBrightness`.
    sky_darken: i32,
    /// Creative main-hand marker block and a resolver for each placed state's sprite.
    marker: Option<(*'a str,
    /// `BlockState.getOffset` of a state at (x, z), for blocks with a random model offset.
    model_offset: *'a dyn Fn(BlockStateId,
    /// `TheEndGatewayBlockEntity.getParticleAmount` of the gateway state at a position.
    gateway_particles: *'a dyn Fn(BlockStateId,
    /// `Level.isThundering`.
    thundering: bool,
    /// The dimension has `water_evaporates` and drips lava from dripstone (the Nether).
    ultrawarm: bool,
};

/// `ClientLevel.getMarkerParticleTarget`: only the selected main-hand item counts.
    // rust: pub fn marker_particle_target(
    // rust: mode: GameMode,
    // rust: main_hand: Option<&ItemStack>,
    // rust: ) -> Option<&'static str> {
    // rust: if mode != GameMode::Creative {
    // rust: return None;
}
    // rust: let stack = main_hand.filter(|stack| stack.count > 0)?;
    // rust: match stack.item.as_ref() {
    // rust: "minecraft:barrier" => Some("minecraft:barrier"),
    // rust: "minecraft:light" => Some("minecraft:light"),
    // rust: _ => None,
}
}
    // rust: impl AnimateContext<'_> {
pub fn state(self: *Self, p: [i32; 3]) B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.world.block(p[0], p[1], p[2])
}
pub fn is_air(self: *Self, p: [i32; 3]) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.facts.is_air(self.state(p))
}
    /// `isFaceSturdy` approximated by a full collision cube.
pub fn sturdy(self: *Self, p: [i32; 3]) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.facts.get(self.state(p)).full_collision
}
pub fn shape_y(self: *Self, p: [i32; 3]) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let shape = self
    // rust: .collision
    // rust: .cached_shapes()
    // rust: .cached_shape(self.state(p))
    // rust: .ok()??;
    // rust: if shape.is_empty() {
    // rust: return Some((0.0, 0.0, [0.0; 4]));
}
    // rust: Some((
    // rust: shape.min(Axis::Y),
    // rust: shape.max(Axis::Y),
    // rust: [
    // rust: shape.min(Axis::X),
    // rust: shape.max(Axis::X),
    // rust: shape.min(Axis::Z),
    // rust: shape.max(Axis::Z),
    // rust: ],
    // rust: ))
}
    /// The centre, in the horizontal plane, of the pick shape's bounds before
    /// the model offset - a flower's own box, where its collision shape is
    /// empty. `WitherRoseBlock.animateTick` reads it off `getShape`.
pub fn outline_center(self: *Self, state: BlockStateId) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let outline = &self.facts.get(state).outline;
    // rust: if outline.is_empty() {
    // rust: return [0.5; 2];
}
    // rust: let seed = [
    // rust: f64::INFINITY,
    // rust: f64::INFINITY,
    // rust: f64::NEG_INFINITY,
    // rust: f64::NEG_INFINITY,
    // rust: ];
    // rust: let [x1, z1, x2, z2] = outline.iter().fold(seed, |b, box_| {
    // rust: [
    // rust: b[0].min(box_[0]),
    // rust: b[1].min(box_[2]),
    // rust: b[2].max(box_[3]),
    // rust: b[3].max(box_[5]),
    // rust: ]
    // rust: });
    // rust: [(x1 + x2) / 2.0, (z1 + z2) / 2.0]
}
    /// `Level.getMaxLocalRawBrightness`: the brighter of block light and
    /// sky light less the sky darkening.
pub fn max_local_raw_brightness(self: *Self, p: [i32; 3]) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let light = self.world.light(p[0], p[1], p[2]);
    // rust: i32::from(light & 15).max(i32::from(light >> 4) - self.sky_darken)
}
pub fn offset_of(self: *Self, state: BlockStateId, p: [i32; 3]) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (self.model_offset)(state, p[0], p[2]).unwrap_or([0.0; 3])
}
pub fn foliage(self: *Self, p: [i32; 3]) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let biome = self
    // rust: .world
    // rust: .chunks
    // rust: .get(&(p[0] >> 4, p[2] >> 4))
    // rust: .map_or(0, |c| c.biome(p[0], p[1], p[2]));
    // rust: self.biomes.get(biome).foliage
}
}

pub fn add(engine: *mut ParticleEngine, ty: T, p: [f64; 3], v: [f64; 3]) void {
}
    // rust: engine.add(&ParticleOptions::simple(ty), p, v);
}
/// `Level.addAlwaysVisibleParticle`: still shown under the Minimal option now and then.
pub fn add_visible(engine: *mut ParticleEngine, ty: T, p: [f64; 3], v: [f64; 3]) void {
}
    // rust: engine.add_with(&ParticleOptions::simple(ty), p, v, false, true);
}
pub fn sound(engine: *mut ParticleEngine, name: *'static str, p: [f64; 3], volume: f32, pitch: f32) void {
}
    // rust: engine.sounds.push((name, p, volume, pitch, false));
}
pub fn redstone(engine: *mut ParticleEngine, p: [f64; 3]) void {
}
    // rust: engine.add(&ParticleOptions::dust([1.0, 0.0, 0.0], 1.0), p, [0.0; 3]);
}

/// `ClientLevel.animateTick` around the player's block position.
    // rust: pub fn animate_tick(
    // rust: tables: &AnimateTables,
    // rust: engine: &mut ParticleEngine,
    // rust: ctx: &AnimateContext,
    // rust: player: [i32; 3],
    // rust: ) {
    // rust: for _ in 0..667 {
    // rust: do_animate_tick(tables, engine, ctx, player, 16);
    // rust: do_animate_tick(tables, engine, ctx, player, 32);
}
}
pub fn next_int(r: *mut LegacyRandom, bound: i32) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: r.next_int_bound(bound).unwrap_or(0)
}
    // rust: fn do_animate_tick(
    // rust: tables: &AnimateTables,
    // rust: engine: &mut ParticleEngine,
    // rust: ctx: &AnimateContext,
    // rust: center: [i32; 3],
    // rust: r: i32,
    // rust: ) {
    // rust: let random = engine.random();
    // rust: let x = center[0] + next_int(random, r) - next_int(random, r);
    // rust: let y = center[1] + next_int(random, r) - next_int(random, r);
    // rust: let z = center[2] + next_int(random, r) - next_int(random, r);
    // rust: let pos = [x, y, z];
    // rust: if !ctx.world.loaded(x, z) {
    // rust: return;
}
    // rust: let state = ctx.state(pos);
    // rust: block_animate_tick(tables, engine, ctx, state, pos, center);
    // rust: let facts = ctx.facts.get(state);
    // rust: if facts.fluid != Fluid::None {
    // rust: fluid_animate_tick(
    // rust: engine,
    // rust: ctx,
    // rust: pos,
    // rust: facts.fluid,
    // rust: facts.fluid_level,
    // rust: facts.fluid_falling,
    // rust: );
    // rust: if next_int(engine.random(), 10) == 0 {
    // rust: let drip = if facts.fluid == Fluid::Water {
    // rust: T::DrippingWater
    // rust: } else {
    // rust: T::DrippingLava
}
    // rust: let top_solid = ctx.sturdy(pos);
    // rust: try_spawn_drip(tables, engine, ctx, [x, y - 1, z], drip, top_solid);
}
}
    // rust: if let Some((block, options)) = ctx.marker
    // rust: && ctx.registry.state(state).is_some_and(|s| s.name == block)
    // rust: && let Some(options) = options(state)
    // rust: {
    // rust: engine.add(&options, pos.map(|v| f64::from(v) + 0.5), [0.0; 3]);
}
    // rust: if !facts.full_collision {
    // rust: let biome = ctx
    // rust: .world
    // rust: .chunks
    // rust: .get(&(x >> 4, z >> 4))
    // rust: .map_or(0, |c| c.biome(x, y, z));
    // rust: for &(ty, probability) in tables.ambient.get(biome as usize).into_iter().flatten() {
            // AmbientParticle.canSpawn: random.nextFloat() <= probability.
    // rust: let random = engine.random();
    // rust: if random.next_float() <= probability {
    // rust: let p = [
    // rust: f64::from(x) + random.next_double(),
    // rust: f64::from(y) + random.next_double(),
    // rust: f64::from(z) + random.next_double(),
    // rust: ];
    // rust: add(engine, ty, p, [0.0; 3]);
}
}
}
}
/// `ClientLevel.trySpawnDripParticles`.
    // rust: fn try_spawn_drip(
    // rust: tables: &AnimateTables,
    // rust: engine: &mut ParticleEngine,
    // rust: ctx: &AnimateContext,
    // rust: pos: [i32; 3],
    // rust: drip: T,
    // rust: top_solid: bool,
    // rust: ) {
    // rust: let state = ctx.state(pos);
    // rust: if ctx.facts.get(state).fluid != Fluid::None {
    // rust: return;
}
    // rust: let Some((bottom, top, bounds)) = ctx.shape_y(pos) else {
    // rust: return;
}
    // rust: let spawn = |engine: &mut ParticleEngine, x1: f64, x2: f64, z1: f64, z2: f64, y: f64| {
    // rust: let r = engine.random();
    // rust: let (a, b) = (r.next_double(), r.next_double());
    // rust: add(
    // rust: engine,
    // rust: drip,
    // rust: [x1 + (x2 - x1) * a, y, z1 + (z2 - z1) * b],
    // rust: [0.0; 3],
    // rust: );
}
    // rust: let (fx, fy, fz) = (f64::from(pos[0]), f64::from(pos[1]), f64::from(pos[2]));
    // rust: if top < 1.0 {
    // rust: if top_solid {
    // rust: spawn(engine, fx, fx + 1.0, fz, fz + 1.0, fy + 1.0 - 0.05);
}
    // rust: } else if !tables
    // rust: .impermeable
    // rust: .get(state.0 as usize)
    // rust: .copied()
    // rust: .unwrap_or(false)
    // rust: {
    // rust: if bottom > 0.0 {
    // rust: spawn(
    // rust: engine,
    // rust: fx + bounds[0],
    // rust: fx + bounds[1],
    // rust: fz + bounds[2],
    // rust: fz + bounds[3],
    // rust: fy + bottom - 0.05,
    // rust: );
    // rust: } else {
    // rust: let below = [pos[0], pos[1] - 1, pos[2]];
    // rust: let below_top = ctx.shape_y(below).map_or(1.0, |s| s.1);
    // rust: if below_top < 1.0 && ctx.facts.get(ctx.state(below)).fluid == Fluid::None {
    // rust: spawn(
    // rust: engine,
    // rust: fx + bounds[0],
    // rust: fx + bounds[1],
    // rust: fz + bounds[2],
    // rust: fz + bounds[3],
    // rust: fy - 0.05,
    // rust: );
}
}
}
}
/// `BeehiveBlock.trySpawnDripParticles`.
    // rust: fn beehive_drip(
    // rust: tables: &AnimateTables,
    // rust: engine: &mut ParticleEngine,
    // rust: ctx: &AnimateContext,
    // rust: state: BlockStateId,
    // rust: pos: [i32; 3],
    // rust: ) {
    // rust: if ctx.facts.get(state).fluid != Fluid::None || engine.random().next_float() < 0.3 {
    // rust: return;
}
    // rust: let Some((bottom, top, bounds)) = ctx.shape_y(pos) else {
    // rust: return;
}
    // rust: if top < 1.0
    // rust: || tables
    // rust: .impermeable
    // rust: .get(state.0 as usize)
    // rust: .copied()
    // rust: .unwrap_or(false)
    // rust: {
    // rust: return;
}
    // rust: let y = if bottom > 0.0 {
    // rust: f64::from(pos[1]) + bottom - 0.05
    // rust: } else {
    // rust: let below = [pos[0], pos[1] - 1, pos[2]];
    // rust: let below_top = ctx.shape_y(below).map_or(1.0, |s| s.1);
        // `belowTop < 1 || !isCollisionShapeFullBlock` and no fluid below.
    // rust: if (below_top < 1.0 || !ctx.sturdy(below))
    // rust: && ctx.facts.get(ctx.state(below)).fluid == Fluid::None
    // rust: {
    // rust: f64::from(pos[1]) - 0.05
    // rust: } else {
    // rust: return;
}
}
    // rust: let r = engine.random();
    // rust: let (a, b) = (r.next_double(), r.next_double());
    // rust: let (fx, fz) = (f64::from(pos[0]), f64::from(pos[2]));
    // rust: let p = [
    // rust: fx + bounds[0] + (bounds[1] - bounds[0]) * a,
    // rust: y,
    // rust: fz + bounds[2] + (bounds[3] - bounds[2]) * b,
    // rust: ];
    // rust: add(engine, T::DrippingHoney, p, [0.0; 3]);
}
/// `AmbientDesertBlockSoundsPlayer.shouldPlayDesertDryVegetationBlockSounds`:
/// sand or terracotta two blocks deep.
    // rust: fn desert_dry_vegetation_sounds(
    // rust: tables: &AnimateTables,
    // rust: ctx: &AnimateContext,
    // rust: below: [i32; 3],
    // rust: ) -> bool {
    // rust: let triggers = |p: [i32; 3]| {
    // rust: tables
    // rust: .desert_dry_vegetation_sounds
    // rust: .get(ctx.state(p).0 as usize)
    // rust: .copied()
    // rust: .unwrap_or(false)
}
    // rust: triggers(below) && triggers([below[0], below[1] - 1, below[2]])
}
/// `WaterFluid.animateTick` / `LavaFluid.animateTick`.
    // rust: fn fluid_animate_tick(
    // rust: engine: &mut ParticleEngine,
    // rust: ctx: &AnimateContext,
    // rust: pos: [i32; 3],
    // rust: fluid: Fluid,
    // rust: level: u8,
    // rust: falling: bool,
    // rust: ) {
    // rust: let (fx, fy, fz) = (f64::from(pos[0]), f64::from(pos[1]), f64::from(pos[2]));
    // rust: if fluid == Fluid::Water {
    // rust: let source = level >= 8 && !falling;
    // rust: let random = engine.random();
    // rust: if !source && !falling {
    // rust: if next_int(random, 64) == 0 {
    // rust: let volume = random.next_float() * 0.25 + 0.75;
    // rust: let pitch = random.next_float() + 0.5;
    // rust: sound(
    // rust: engine,
    // rust: "minecraft:block.water.ambient",
    // rust: [fx + 0.5, fy + 0.5, fz + 0.5],
    // rust: volume,
    // rust: pitch,
    // rust: );
}
    // rust: } else if next_int(random, 10) == 0 {
    // rust: let p = [
    // rust: fx + random.next_double(),
    // rust: fy + random.next_double(),
    // rust: fz + random.next_double(),
    // rust: ];
    // rust: add(engine, T::Underwater, p, [0.0; 3]);
}
    // rust: return;
}
    // rust: let above = [pos[0], pos[1] + 1, pos[2]];
    // rust: if ctx.is_air(above) {
    // rust: let random = engine.random();
    // rust: if next_int(random, 100) == 0 {
    // rust: let p = [
    // rust: fx + random.next_double(),
    // rust: fy + 1.0,
    // rust: fz + random.next_double(),
    // rust: ];
    // rust: add(engine, T::Lava, p, [0.0; 3]);
    // rust: let random = engine.random();
    // rust: let (volume, pitch) = (
    // rust: 0.2 + random.next_float() * 0.2,
    // rust: 0.9 + random.next_float() * 0.15,
    // rust: );
    // rust: sound(engine, "minecraft:block.lava.pop", p, volume, pitch);
}
    // rust: let random = engine.random();
    // rust: if next_int(random, 200) == 0 {
    // rust: let (volume, pitch) = (
    // rust: 0.2 + random.next_float() * 0.2,
    // rust: 0.9 + random.next_float() * 0.15,
    // rust: );
    // rust: sound(
    // rust: engine,
    // rust: "minecraft:block.lava.ambient",
    // rust: [fx, fy, fz],
    // rust: volume,
    // rust: pitch,
    // rust: );
}
}
}
    // rust: fn block_animate_tick(
    // rust: tables: &AnimateTables,
    // rust: engine: &mut ParticleEngine,
    // rust: ctx: &AnimateContext,
    // rust: state: BlockStateId,
    // rust: pos: [i32; 3],
    // rust: player: [i32; 3],
    // rust: ) {
    // rust: let (fx, fy, fz) = (f64::from(pos[0]), f64::from(pos[1]), f64::from(pos[2]));
    // rust: match tables.kind(state) {
    // rust: Animate::None => {}
    // rust: Animate::Torch(flame) => {
    // rust: let p = [fx + 0.5, fy + 0.7, fz + 0.5];
    // rust: add(engine, T::Smoke, p, [0.0; 3]);
    // rust: add(engine, flame, p, [0.0; 3]);
}
    // rust: Animate::WallTorch(flame, facing) => {
    // rust: let p = [
    // rust: fx + 0.5 - 0.27 * f64::from(facing[0]),
    // rust: fy + 0.7 + 0.22,
    // rust: fz + 0.5 - 0.27 * f64::from(facing[2]),
    // rust: ];
    // rust: add(engine, T::Smoke, p, [0.0; 3]);
    // rust: add(engine, flame, p, [0.0; 3]);
}
    // rust: Animate::RedstoneTorch => {
    // rust: let r = engine.random();
    // rust: let p = [
    // rust: fx + 0.5 + (r.next_double() - 0.5) * 0.2,
    // rust: fy + 0.7 + (r.next_double() - 0.5) * 0.2,
    // rust: fz + 0.5 + (r.next_double() - 0.5) * 0.2,
    // rust: ];
    // rust: redstone(engine, p);
}
    // rust: Animate::RedstoneWallTorch(facing) => {
    // rust: let r = engine.random();
    // rust: let p = [
    // rust: fx + 0.5 + (r.next_double() - 0.5) * 0.2 - 0.27 * f64::from(facing[0]),
    // rust: fy + 0.7 + (r.next_double() - 0.5) * 0.2 + 0.22,
    // rust: fz + 0.5 + (r.next_double() - 0.5) * 0.2 - 0.27 * f64::from(facing[2]),
    // rust: ];
    // rust: redstone(engine, p);
}
    // rust: Animate::Furnace(facing) | Animate::BlastFurnace(facing) => {
    // rust: let blast = matches!(tables.kind(state), Animate::BlastFurnace(_));
    // rust: let (x, y, z) = (fx + 0.5, fy, fz + 0.5);
    // rust: let r = engine.random();
    // rust: if r.next_double() < 0.1 {
    // rust: let name = if blast {
    // rust: "minecraft:block.blastfurnace.fire_crackle"
    // rust: } else {
    // rust: "minecraft:block.furnace.fire_crackle"
}
    // rust: sound(engine, name, [x, y, z], 1.0, 1.0);
}
    // rust: let r = engine.random();
    // rust: let ss = r.next_double() * 0.6 - 0.3;
    // rust: let dx = if facing[0] != 0 {
    // rust: f64::from(facing[0]) * 0.52
    // rust: } else {
    // rust: ss
}
    // rust: let dy = r.next_double() * if blast { 9.0 } else { 6.0 } / 16.0;
    // rust: let dz = if facing[2] != 0 {
    // rust: f64::from(facing[2]) * 0.52
    // rust: } else {
    // rust: ss
}
    // rust: let p = [x + dx, y + dy, z + dz];
    // rust: add(engine, T::Smoke, p, [0.0; 3]);
    // rust: if !blast {
    // rust: add(engine, T::Flame, p, [0.0; 3]);
}
}
    // rust: Animate::Smoker => {
    // rust: let r = engine.random();
    // rust: if r.next_double() < 0.1 {
    // rust: sound(
    // rust: engine,
    // rust: "minecraft:block.smoker.smoke",
    // rust: [fx + 0.5, fy, fz + 0.5],
    // rust: 1.0,
    // rust: 1.0,
    // rust: );
}
    // rust: add(engine, T::Smoke, [fx + 0.5, fy + 1.1, fz + 0.5], [0.0; 3]);
}
    // rust: Animate::Campfire { spawn_particles } => {
    // rust: let r = engine.random();
    // rust: if next_int(r, 10) == 0 {
    // rust: let (volume, pitch) = (0.5 + r.next_float(), r.next_float() * 0.7 + 0.6);
    // rust: sound(
    // rust: engine,
    // rust: "minecraft:block.campfire.crackle",
    // rust: [fx + 0.5, fy + 0.5, fz + 0.5],
    // rust: volume,
    // rust: pitch,
    // rust: );
}
    // rust: let r = engine.random();
    // rust: if spawn_particles && next_int(r, 5) == 0 {
                // Vanilla's `for (int i = 0; i < random.nextInt(1) + 1; i++)`
                // asks the bound again on every pass, so the check after the
                // body is a second draw.
    // rust: let mut i = 0;
    // rust: while i < next_int(engine.random(), 1) + 1 {
    // rust: let r = engine.random();
    // rust: let v = [
    // rust: f64::from(r.next_float() / 2.0),
    // rust: 5.0e-5,
    // rust: f64::from(r.next_float() / 2.0),
    // rust: ];
    // rust: add(engine, T::Lava, [fx + 0.5, fy + 0.5, fz + 0.5], v);
    // rust: i += 1;
}
}
}
    // rust: Animate::Leaves(falling, fixed_tint, poplar) => {
    // rust: let below = [pos[0], pos[1] - 1, pos[2]];
            // LeavesBlock.makeDrippingWaterParticles.
    // rust: if (ctx.raining_at)([pos[0], pos[1] + 1, pos[2]]) && next_int(engine.random(), 15) == 1
    // rust: {
    // rust: let below_facts = ctx.facts.get(ctx.state(below));
    // rust: if !below_facts.can_occlude || !ctx.sturdy(below) {
    // rust: let r = engine.random();
    // rust: let p = [fx + r.next_double(), fy - 0.05, fz + r.next_double()];
    // rust: add(engine, T::DrippingWater, p, [0.0; 3]);
}
}
    // rust: if poplar {
    // rust: leaves_ambient_sound(tables, engine, ctx, state, pos);
}
            // FallingParticlesLeavesBlock.makeFallingLeavesParticles.
    // rust: if let Some((ty, chance)) = falling
    // rust: && engine.random().next_float() < chance
    // rust: && !ctx.sturdy(below)
    // rust: {
    // rust: let r = engine.random();
    // rust: let p = [fx + r.next_double(), fy - 0.05, fz + r.next_double()];
    // rust: let options = if ty == T::TintedLeaves {
    // rust: let c = fixed_tint.unwrap_or_else(|| ctx.foliage(pos));
    // rust: let f = |s: u32| ((c >> s) & 255) as f32 / 255.0;
    // rust: ParticleOptions::colored(ty, [f(16), f(8), f(0), 1.0])
    // rust: } else {
    // rust: ParticleOptions::simple(ty)
}
    // rust: engine.add(&options, p, [0.0; 3]);
}
}
    // rust: Animate::NetherPortal => {
    // rust: let r = engine.random();
    // rust: if next_int(r, 100) == 0 {
    // rust: let pitch = r.next_float() * 0.4 + 0.8;
    // rust: sound(
    // rust: engine,
    // rust: "minecraft:block.portal.ambient",
    // rust: [fx + 0.5, fy + 0.5, fz + 0.5],
    // rust: 0.5,
    // rust: pitch,
    // rust: );
}
    // rust: let along_z = ctx.state([pos[0] - 1, pos[1], pos[2]]) == state
    // rust: || ctx.state([pos[0] + 1, pos[1], pos[2]]) == state;
    // rust: for _ in 0..4 {
    // rust: let r = engine.random();
    // rust: let mut p = [
    // rust: fx + r.next_double(),
    // rust: fy + r.next_double(),
    // rust: fz + r.next_double(),
    // rust: ];
    // rust: let mut v = [
    // rust: f64::from(r.next_float() - 0.5) * 0.5,
    // rust: f64::from(r.next_float() - 0.5) * 0.5,
    // rust: f64::from(r.next_float() - 0.5) * 0.5,
    // rust: ];
    // rust: let flip = f64::from(next_int(r, 2) * 2 - 1);
    // rust: if along_z {
    // rust: p[2] = fz + 0.5 + 0.25 * flip;
    // rust: v[2] = f64::from(r.next_float() * 2.0) * flip;
    // rust: } else {
    // rust: p[0] = fx + 0.5 + 0.25 * flip;
    // rust: v[0] = f64::from(r.next_float() * 2.0) * flip;
}
    // rust: add(engine, T::Portal, p, v);
}
}
    // rust: Animate::EnchantingTable => {
    // rust: for ox in -2i32..=2 {
    // rust: for oy in 0..=1 {
    // rust: for oz in -2i32..=2 {
    // rust: if ox.abs() != 2 && oz.abs() != 2 {
    // rust: continue;
}
    // rust: if next_int(engine.random(), 16) != 0 {
    // rust: continue;
}
    // rust: let provider = ctx.state([pos[0] + ox, pos[1] + oy, pos[2] + oz]);
    // rust: let between = ctx.state([pos[0] + ox / 2, pos[1] + oy, pos[2] + oz / 2]);
    // rust: if tables
    // rust: .power_provider
    // rust: .get(provider.0 as usize)
    // rust: .copied()
    // rust: .unwrap_or(false)
    // rust: && tables
    // rust: .power_transmitter
    // rust: .get(between.0 as usize)
    // rust: .copied()
    // rust: .unwrap_or(false)
    // rust: {
    // rust: let r = engine.random();
    // rust: let v = [
    // rust: f64::from(ox as f32 + r.next_float() - 0.5),
    // rust: f64::from(oy as f32 - r.next_float() - 1.0),
    // rust: f64::from(oz as f32 + r.next_float() - 0.5),
    // rust: ];
    // rust: add(engine, T::Enchant, [fx + 0.5, fy + 2.0, fz + 0.5], v);
}
}
}
}
}
    // rust: Animate::EndRod(facing) => {
    // rust: let r = engine.random();
    // rust: let x = fx + 0.55 - f64::from(r.next_float() * 0.1);
    // rust: let y = fy + 0.55 - f64::from(r.next_float() * 0.1);
    // rust: let z = fz + 0.55 - f64::from(r.next_float() * 0.1);
    // rust: let d = f64::from(0.4 - (r.next_float() + r.next_float()) * 0.4);
    // rust: if next_int(r, 5) == 0 {
    // rust: let v = [
    // rust: r.next_gaussian() * 0.005,
    // rust: r.next_gaussian() * 0.005,
    // rust: r.next_gaussian() * 0.005,
    // rust: ];
    // rust: let p = [
    // rust: x + f64::from(facing[0]) * d,
    // rust: y + f64::from(facing[1]) * d,
    // rust: z + f64::from(facing[2]) * d,
    // rust: ];
    // rust: add(engine, T::EndRod, p, v);
}
}
    // rust: Animate::SporeBlossom => {
    // rust: let r = engine.random();
    // rust: let p = [fx + r.next_double(), fy + 0.7, fz + r.next_double()];
    // rust: add(engine, T::FallingSporeBlossom, p, [0.0; 3]);
    // rust: for _ in 0..14 {
    // rust: let r = engine.random();
    // rust: let a = [
    // rust: pos[0] + next_int(r, 21) - 10,
    // rust: pos[1] - next_int(r, 10),
    // rust: pos[2] + next_int(r, 21) - 10,
    // rust: ];
    // rust: if !ctx.facts.get(ctx.state(a)).full_collision {
    // rust: let r = engine.random();
    // rust: let p = [
    // rust: f64::from(a[0]) + r.next_double(),
    // rust: f64::from(a[1]) + r.next_double(),
    // rust: f64::from(a[2]) + r.next_double(),
    // rust: ];
    // rust: add(engine, T::SporeBlossomAir, p, [0.0; 3]);
}
}
}
    // rust: Animate::CryingObsidian => {
    // rust: let r = engine.random();
    // rust: if next_int(r, 5) == 0 {
                // Direction.getRandom: down, up, north, south, west, east.
    // rust: let d = [
    // rust: [0, -1, 0],
    // rust: [0, 1, 0],
    // rust: [0, 0, -1],
    // rust: [0, 0, 1],
    // rust: [-1, 0, 0],
    // rust: [1, 0, 0],
    // rust: ][next_int(r, 6) as usize];
    // rust: if d != [0, 1, 0] {
    // rust: let relative = [pos[0] + d[0], pos[1] + d[1], pos[2] + d[2]];
    // rust: if !ctx.sturdy(relative) {
    // rust: let r = engine.random();
    // rust: let off = |s: i32, r: &mut LegacyRandom| {
    // rust: if s == 0 {
    // rust: r.next_double()
    // rust: } else {
    // rust: 0.5 + f64::from(s) * 0.6
}
}
    // rust: let p = [fx + off(d[0], r), fy + off(d[1], r), fz + off(d[2], r)];
    // rust: add(engine, T::DrippingObsidianTear, p, [0.0; 3]);
}
}
}
}
    // rust: Animate::PotentSulfur => {
            // PotentSulfurBlock.animateTick: under a water source, two
            // bubbles and, one time in ten, the noxious gas.
    // rust: let above = ctx.facts.get(ctx.state([pos[0], pos[1] + 1, pos[2]]));
    // rust: if above.fluid == Fluid::Water && above.fluid_level == 8 && !above.fluid_falling {
    // rust: for _ in 0..2 {
    // rust: let r = engine.random();
    // rust: let p = [
    // rust: fx + f64::from(r.next_float()),
    // rust: fy + 1.0 + f64::from(r.next_float()),
    // rust: fz + f64::from(r.next_float()),
    // rust: ];
    // rust: add_visible(engine, T::SulfurBubbles, p, [0.0; 3]);
}
    // rust: if next_int(engine.random(), 10) == 0 {
    // rust: let name = "minecraft:block.potent_sulfur.noxious_gas";
    // rust: sound(engine, name, [fx, fy, fz], 1.0, 1.0);
}
}
}
    // rust: Animate::WetSponge => {
            // Direction.getRandom: DOWN, UP, NORTH, SOUTH, WEST, EAST.
    // rust: const DIRECTIONS: [[i32; 3]; 6] = [
    // rust: [0, -1, 0],
    // rust: [0, 1, 0],
    // rust: [0, 0, -1],
    // rust: [0, 0, 1],
    // rust: [-1, 0, 0],
    // rust: [1, 0, 0],
    // rust: ];
    // rust: let d = DIRECTIONS[next_int(engine.random(), 6) as usize];
            // The sponge occludes, so only a sturdy neighbour face hides the drip.
    // rust: if d != [0, 1, 0] && !ctx.sturdy([pos[0] + d[0], pos[1] + d[1], pos[2] + d[2]]) {
    // rust: let r = engine.random();
    // rust: let p = match d {
    // rust: [0, -1, 0] => [fx + r.next_double(), fy - 0.05, fz + r.next_double()],
    // rust: [dx, _, 0] => {
    // rust: let y = fy + r.next_double() * 0.8;
    // rust: let z = fz + r.next_double();
    // rust: [fx + if dx > 0 { 1.1 } else { 0.05 }, y, z]
}
    // rust: [_, _, dz] => {
    // rust: let y = fy + r.next_double() * 0.8;
    // rust: let x = fx + r.next_double();
    // rust: [x, y, fz + if dz > 0 { 1.1 } else { 0.05 }]
}
}
    // rust: add(engine, T::DrippingWater, p, [0.0; 3]);
}
}
    // rust: Animate::Mycelium => {
    // rust: let r = engine.random();
    // rust: if next_int(r, 10) == 0 {
    // rust: let p = [fx + r.next_double(), fy + 1.1, fz + r.next_double()];
    // rust: add(engine, T::Mycelium, p, [0.0; 3]);
}
}
    // rust: Animate::Candles(count) => {
    // rust: for o in candle_offsets(count) {
    // rust: candle(
    // rust: engine,
    // rust: [fx + o[0] / 16.0, fy + o[1] / 16.0, fz + o[2] / 16.0],
    // rust: );
}
}
    // rust: Animate::CandleCake => candle(engine, [fx + 0.5, fy + 1.0, fz + 0.5]),
    // rust: Animate::BrewingStand => {
    // rust: let r = engine.random();
            // `random.nextFloat() * 0.2` and `* 0.3` are double products; only
            // the draw itself is single precision.
    // rust: let p = [
    // rust: fx + 0.4 + f64::from(r.next_float()) * 0.2,
    // rust: fy + 0.7 + f64::from(r.next_float()) * 0.3,
    // rust: fz + 0.4 + f64::from(r.next_float()) * 0.2,
    // rust: ];
    // rust: add(engine, T::Smoke, p, [0.0; 3]);
}
    // rust: Animate::DriedGhast { waterlogged } => {
            // DriedGhastBlock.animateTick.
    // rust: let c = [fx + 0.5, fy + 0.5, fz + 0.5];
    // rust: if waterlogged {
    // rust: if next_int(engine.random(), 40) == 0 {
    // rust: let name = "minecraft:block.dried_ghast.ambient_water";
    // rust: sound(engine, name, c, 1.0, 1.0);
}
    // rust: let r = engine.random();
    // rust: if next_int(r, 6) == 0 {
    // rust: let x = c[0] + f64::from((r.next_float() * 2.0 - 1.0) / 3.0);
    // rust: let y = c[1] + 0.4;
    // rust: let z = c[2] + f64::from((r.next_float() * 2.0 - 1.0) / 3.0);
    // rust: let v = [0.0, f64::from(r.next_float()), 0.0];
    // rust: add(engine, T::HappyVillager, [x, y, z], v);
}
    // rust: } else {
    // rust: let below = ctx.state([pos[0], pos[1] - 1, pos[2]]);
    // rust: let triggers = || {
    // rust: tables
    // rust: .dried_ghast_sounds
    // rust: .get(below.0 as usize)
    // rust: .copied()
    // rust: .unwrap_or(false)
}
    // rust: if next_int(engine.random(), 40) == 0 && triggers() {
    // rust: sound(engine, "minecraft:block.dried_ghast.ambient", c, 1.0, 1.0);
}
    // rust: if next_int(engine.random(), 6) == 0 {
    // rust: add(engine, T::WhiteSmoke, c, [0.0, 0.02, 0.0]);
}
}
}
    // rust: Animate::FireflyBush => {
            // FireflyBushBlock.animateTick: the idle sound on a quiet night
            // under open sky, and fireflies in the dark within 5 blocks.
    // rust: if next_int(engine.random(), 30) == 0
    // rust: && ctx.firefly_bush_sounds
    // rust: && (ctx.height_no_leaves)(pos) <= pos[1]
    // rust: {
    // rust: let name = "minecraft:block.firefly_bush.idle";
    // rust: sound(engine, name, [fx, fy, fz], 1.0, 1.0);
}
    // rust: if ctx.max_local_raw_brightness(pos) <= 13 {
    // rust: let r = engine.random();
    // rust: if r.next_double() <= 0.7 {
    // rust: let p = [
    // rust: fx + r.next_double() * 10.0 - 5.0,
    // rust: fy + r.next_double() * 5.0,
    // rust: fz + r.next_double() * 10.0 - 5.0,
    // rust: ];
    // rust: add(engine, T::Firefly, p, [0.0; 3]);
}
}
}
    // rust: Animate::OpenEyeblossom => {
            // EyeblossomBlock.animateTick: pale moss below.
    // rust: if next_int(engine.random(), 700) == 0 {
    // rust: let below = ctx.state([pos[0], pos[1] - 1, pos[2]]);
    // rust: if ctx
    // rust: .registry
    // rust: .state(below)
    // rust: .is_some_and(|s| s.name == "minecraft:pale_moss_block")
    // rust: {
    // rust: let name = "minecraft:block.eyeblossom.idle";
    // rust: sound(engine, name, [fx, fy, fz], 1.0, 1.0);
}
}
}
    // rust: Animate::PaleHangingMoss => {
            // HangingMossBlock.animateTick: under pale oak logs or leaves.
    // rust: if next_int(engine.random(), 500) == 0 {
    // rust: let above = ctx.state([pos[0], pos[1] + 1, pos[2]]);
    // rust: let pale_leaves = ctx
    // rust: .registry
    // rust: .state(above)
    // rust: .is_some_and(|s| s.name == "minecraft:pale_oak_leaves");
    // rust: if pale_leaves
    // rust: || tables
    // rust: .pale_oak_logs
    // rust: .get(above.0 as usize)
    // rust: .copied()
    // rust: .unwrap_or(false)
    // rust: {
    // rust: let name = "minecraft:block.pale_hanging_moss.idle";
    // rust: sound(engine, name, [fx, fy, fz], 1.0, 1.0);
}
}
}
    // rust: Animate::CreakingHeart => {
            // CreakingHeartBlock.animateTick: the idle creak is drawn only while
            // the attribute is on, then needs pale oak logs on all six sides
            // (`CreakingHeartBlock.isSurroundedByLogs`).
    // rust: if ctx.creaking_active
    // rust: && next_int(engine.random(), 16) == 0
    // rust: && [
    // rust: [-1, 0, 0],
    // rust: [1, 0, 0],
    // rust: [0, -1, 0],
    // rust: [0, 1, 0],
    // rust: [0, 0, -1],
    // rust: [0, 0, 1],
    // rust: ]
    // rust: .iter()
    // rust: .all(|d| {
    // rust: let p = [pos[0] + d[0], pos[1] + d[1], pos[2] + d[2]];
    // rust: tables
    // rust: .pale_oak_logs
    // rust: .get(ctx.state(p).0 as usize)
    // rust: .copied()
    // rust: .unwrap_or(false)
    // rust: })
    // rust: {
    // rust: sound(
    // rust: engine,
    // rust: "minecraft:block.creaking_heart.idle",
    // rust: [fx, fy, fz],
    // rust: 1.0,
    // rust: 1.0,
    // rust: );
}
}
    // rust: Animate::DeadBush => {
            // AmbientDesertBlockSoundsPlayer.playAmbientDeadBushSounds.
    // rust: if next_int(engine.random(), 130) == 0 {
    // rust: let below = [pos[0], pos[1] - 1, pos[2]];
    // rust: let state = ctx.state(below);
    // rust: let red_sand = ctx
    // rust: .registry
    // rust: .state(state)
    // rust: .is_some_and(|s| s.name == "minecraft:red_sand");
    // rust: let terracotta = tables
    // rust: .terracotta
    // rust: .get(state.0 as usize)
    // rust: .copied()
    // rust: .unwrap_or(false);
    // rust: if (red_sand || terracotta) && next_int(engine.random(), 3) != 0 {
    // rust: return;
}
    // rust: if desert_dry_vegetation_sounds(tables, ctx, below) {
    // rust: let name = "minecraft:block.deadbush.idle";
    // rust: sound(engine, name, [fx, fy, fz], 1.0, 1.0);
}
}
}
    // rust: Animate::DryGrass => {
            // AmbientDesertBlockSoundsPlayer.playAmbientDryGrassSounds:
            // played at the player.
    // rust: if next_int(engine.random(), 200) == 0
    // rust: && desert_dry_vegetation_sounds(tables, ctx, [pos[0], pos[1] - 1, pos[2]])
    // rust: {
    // rust: let at = [
    // rust: f64::from(player[0]) + 0.5,
    // rust: f64::from(player[1]),
    // rust: f64::from(player[2]) + 0.5,
    // rust: ];
    // rust: sound(engine, "minecraft:block.dry_grass.ambient", at, 1.0, 1.0);
}
}
    // rust: Animate::EndPortal => {
            // EndPortalBlock.animateTick: one smoke particle above the surface.
    // rust: let r = engine.random();
    // rust: let p = [fx + r.next_double(), fy + 0.8, fz + r.next_double()];
    // rust: add(engine, T::Smoke, p, [0.0; 3]);
}
    // rust: Animate::Lever { facing, connected } => {
            // LeverBlock.animateTick: a powered lever puffs red dust a quarter of the time.
    // rust: if engine.random().next_float() < 0.25 {
                // LeverBlock.makeParticle with scale 0.5.
    // rust: let at = |base: f64, i: usize| {
    // rust: base + 0.5 + 0.1 * f64::from(-facing[i]) + 0.2 * f64::from(-connected[i])
}
    // rust: let p = [at(fx, 0), at(fy, 1), at(fz, 2)];
    // rust: engine.add(&ParticleOptions::dust([1.0, 0.0, 0.0], 0.5), p, [0.0; 3]);
}
}
    // rust: Animate::Repeater { facing, delay } => {
            // RepeaterBlock.animateTick: dust at one of the torches.
    // rust: let r = engine.random();
    // rust: let x = fx + 0.5 + (r.next_double() - 0.5) * 0.2;
    // rust: let y = fy + 0.4 + (r.next_double() - 0.5) * 0.2;
    // rust: let z = fz + 0.5 + (r.next_double() - 0.5) * 0.2;
    // rust: let mut offset = -5.0f32;
    // rust: if r.next_boolean() {
    // rust: offset = (delay * 2 - 1) as f32;
}
    // rust: offset /= 16.0;
    // rust: let xo = f64::from(offset * facing[0] as f32);
    // rust: let zo = f64::from(offset * facing[2] as f32);
    // rust: redstone(engine, [x + xo, y, z + zo]);
}
    // rust: Animate::PointedDripstone => dripstone_drip(tables, engine, ctx, state, pos),
    // rust: Animate::WitherRose => {
            // WitherRoseBlock.animateTick: smoke puffs at the centre of
            // `getShape`, the pick shape a flower's `getOffset` moves per column,
            // which is not the (empty) collision shape.
    // rust: let center = ctx.outline_center(state);
    // rust: let offset = ctx.offset_of(state, pos);
    // rust: let x = fx + center[0] + offset[0];
    // rust: let z = fz + center[1] + offset[2];
    // rust: for _ in 0..3 {
    // rust: let r = engine.random();
    // rust: if r.next_boolean() {
    // rust: let p = [
    // rust: x + r.next_double() / 5.0,
    // rust: fy + (0.5 - r.next_double()),
    // rust: z + r.next_double() / 5.0,
    // rust: ];
    // rust: add(engine, T::Smoke, p, [0.0; 3]);
}
}
}
    // rust: Animate::EndGateway => {
            // EndGatewayBlock.animateTick: portal particles, one for each visible face.
    // rust: for _ in 0..(ctx.gateway_particles)(state, pos) {
    // rust: let r = engine.random();
    // rust: let mut p = [
    // rust: fx + r.next_double(),
    // rust: fy + r.next_double(),
    // rust: fz + r.next_double(),
    // rust: ];
    // rust: let mut v = [
    // rust: (r.next_double() - 0.5) * 0.5,
    // rust: (r.next_double() - 0.5) * 0.5,
    // rust: (r.next_double() - 0.5) * 0.5,
    // rust: ];
    // rust: let flip = next_int(r, 2) * 2 - 1;
    // rust: if r.next_boolean() {
    // rust: p[2] = fz + 0.5 + 0.25 * f64::from(flip);
    // rust: v[2] = f64::from(r.next_float() * 2.0 * flip as f32);
    // rust: } else {
    // rust: p[0] = fx + 0.5 + 0.25 * f64::from(flip);
    // rust: v[0] = f64::from(r.next_float() * 2.0 * flip as f32);
}
    // rust: add(engine, T::Portal, p, v);
}
}
    // rust: Animate::LightningRod(axis) => {
            // LightningRodBlock.animateTick: in a thunderstorm, sparks along the
            // topmost rod, more often as the game time within 200 ticks grows.
    // rust: if ctx.thundering
    // rust: && i64::from(next_int(engine.level_random(), 200)) <= ctx.world.game_time % 200
    // rust: && pos[1]
    // rust: == ctx
    // rust: .world
    // rust: .world_surface(pos[0], pos[2], |id| ctx.facts.is_air(id))
    // rust: - 1
    // rust: {
    // rust: let mut sparks = Vec::new();
    // rust: along_axis(engine.level_random(), axis, pos, (1, 2), |p, v| {
    // rust: sparks.push((p, v));
    // rust: });
    // rust: let options = ParticleOptions::simple(T::ElectricSpark);
    // rust: for (p, v) in sparks {
    // rust: engine.add(&options, p, v);
}
}
}
    // rust: Animate::EnderChest => {
    // rust: for _ in 0..3 {
    // rust: let r = engine.random();
    // rust: let flip_x = f64::from(next_int(r, 2) * 2 - 1);
    // rust: let flip_z = f64::from(next_int(r, 2) * 2 - 1);
    // rust: let p = [
    // rust: fx + 0.5 + 0.25 * flip_x,
                    // `pos.getY() + random.nextFloat()` adds an int to a float:
                    // the sum rounds to single precision before it widens.
    // rust: f64::from(pos[1] as f32 + r.next_float()),
    // rust: fz + 0.5 + 0.25 * flip_z,
    // rust: ];
    // rust: let v = [
    // rust: f64::from(r.next_float()) * flip_x,
    // rust: f64::from(r.next_float() - 0.5) * 0.125,
    // rust: f64::from(r.next_float()) * flip_z,
    // rust: ];
    // rust: add(engine, T::Portal, p, v);
}
}
    // rust: Animate::Falling(color, sand) => {
    // rust: if next_int(engine.random(), 16) == 0 {
    // rust: let below = ctx.facts.get(ctx.state([pos[0], pos[1] - 1, pos[2]]));
                // FallingBlock.isFree: air, fire, liquids or replaceable.
    // rust: if below.replaceable
    // rust: || below.fluid != Fluid::None
    // rust: || ctx.is_air([pos[0], pos[1] - 1, pos[2]])
    // rust: {
    // rust: let r = engine.random();
    // rust: let p = [fx + r.next_double(), fy - 0.05, fz + r.next_double()];
    // rust: engine.add(
    // rust: &ParticleOptions::block(T::FallingDust, String::new(), color),
    // rust: p,
    // rust: [0.0; 3],
    // rust: );
}
}
            // AmbientDesertBlockSoundsPlayer.playAmbientSandSounds: only for the air block.
    // rust: if sand
    // rust: && ctx.state([pos[0], pos[1] + 1, pos[2]]) == ctx.world.air
    // rust: && next_int(engine.random(), 2100) == 0
    // rust: && sand_sound_nearby(tables, ctx, pos)
    // rust: {
    // rust: sound(engine, "minecraft:block.sand.idle", [fx, fy, fz], 1.0, 1.0);
}
}
    // rust: Animate::Beehive => {
            // BeehiveBlock.animateTick: `for (i = 0; i < random.nextInt(1) + 1; i++)`
            // re-reads its bound on every trip, so the level random is asked
            // once before the attempt and once more to end the loop.
    // rust: let mut attempt = 0;
    // rust: while attempt < next_int(engine.random(), 1) + 1 {
    // rust: beehive_drip(tables, engine, ctx, state, pos);
    // rust: attempt += 1;
}
}
    // rust: Animate::RedstoneOre => {
    // rust: for d in [
    // rust: [0, -1, 0],
    // rust: [0, 1, 0],
    // rust: [0, 0, -1],
    // rust: [0, 0, 1],
    // rust: [-1, 0, 0],
    // rust: [1, 0, 0],
    // rust: ] {
    // rust: let relative = [pos[0] + d[0], pos[1] + d[1], pos[2] + d[2]];
    // rust: if ctx.facts.get(ctx.state(relative)).solid_render {
    // rust: continue;
}
    // rust: let r = engine.random();
    // rust: let mut c = |s: i32| {
    // rust: if s != 0 {
    // rust: 0.5 + 0.5625 * f64::from(s)
    // rust: } else {
    // rust: f64::from(r.next_float())
}
}
    // rust: let p = [fx + c(d[0]), fy + c(d[1]), fz + c(d[2])];
    // rust: redstone(engine, p);
}
}
    // rust: Animate::RedstoneWire { power, sides } => {
    // rust: let color = redstone_color(power);
    // rust: let horizontals = [[0, 0, -1], [1, 0, 0], [0, 0, 1], [-1, 0, 0]];
    // rust: let line = |engine: &mut ParticleEngine,
    // rust: side: [i32; 3],
    // rust: along: [i32; 3],
    // rust: from: f32,
    // rust: to: f32| {
    // rust: let span = to - from;
    // rust: let r = engine.random();
    // rust: if r.next_float() < 0.2 * span {
    // rust: let on = from + span * r.next_float();
    // rust: let c = |i: usize| {
    // rust: 0.5 + 0.4375 * f64::from(side[i]) + f64::from(on) * f64::from(along[i])
}
    // rust: engine.add(
    // rust: &ParticleOptions::dust(color, 1.0),
    // rust: [fx + c(0), fy + c(1), fz + c(2)],
    // rust: [0.0; 3],
    // rust: );
}
}
    // rust: for (i, h) in horizontals.into_iter().enumerate() {
    // rust: match sides[i] {
    // rust: 2 => {
    // rust: line(engine, h, [0, 1, 0], -0.5, 0.5);
    // rust: line(engine, [0, -1, 0], h, 0.0, 0.5);
}
    // rust: 1 => line(engine, [0, -1, 0], h, 0.0, 0.5),
    // rust: _ => line(engine, [0, -1, 0], h, 0.0, 0.3),
}
}
}
    // rust: Animate::SculkSensor => {
            // SculkSensorBlock.animateTick.
    // rust: let r = engine.random();
    // rust: let direction = r.next_int_bound(6).unwrap_or(0);
            // Direction.values(): down, up, north, south, west, east.
    // rust: if direction >= 2 {
    // rust: let step = [[0, 0, -1], [0, 0, 1], [-1, 0, 0], [1, 0, 0]][direction as usize - 2];
    // rust: let x = fx
    // rust: + 0.5
    // rust: + if step[0] == 0 {
    // rust: 0.5 - r.next_double()
    // rust: } else {
    // rust: f64::from(step[0]) * 0.6
}
    // rust: let z = fz
    // rust: + 0.5
    // rust: + if step[2] == 0 {
    // rust: 0.5 - r.next_double()
    // rust: } else {
    // rust: f64::from(step[2]) * 0.6
}
                // `random.nextFloat() * 0.04`: the double literal keeps the
                // product in double precision.
    // rust: let ya = f64::from(r.next_float()) * 0.04;
    // rust: engine.add(
    // rust: &crate::particles::ParticleOptions::sculk_to_redstone(),
    // rust: [x, fy + 0.25, z],
    // rust: [0.0, ya, 0.0],
    // rust: );
}
}
    // rust: Animate::RespawnAnchor => {
    // rust: let r = engine.random();
    // rust: if next_int(r, 100) == 0 {
    // rust: sound(
    // rust: engine,
    // rust: "minecraft:block.respawn_anchor.ambient",
    // rust: [fx + 0.5, fy + 0.5, fz + 0.5],
    // rust: 1.0,
    // rust: 1.0,
    // rust: );
}
    // rust: let r = engine.random();
    // rust: let p = [
    // rust: fx + 0.5 + (0.5 - r.next_double()),
    // rust: fy + 1.0,
    // rust: fz + 0.5 + (0.5 - r.next_double()),
    // rust: ];
            // `random.nextFloat() * 0.04`: the double literal keeps the product
            // in double precision.
    // rust: let ya = f64::from(r.next_float()) * 0.04;
    // rust: add(engine, T::ReversePortal, p, [0.0, ya, 0.0]);
}
    // rust: Animate::BubbleColumn { drag } => {
    // rust: if drag {
    // rust: add_visible(engine, T::CurrentDown, [fx + 0.5, fy + 0.8, fz], [0.0; 3]);
    // rust: let r = engine.random();
    // rust: if next_int(r, 200) == 0 {
    // rust: let (volume, pitch) = (0.2 + r.next_float() * 0.2, 0.9 + r.next_float() * 0.15);
    // rust: sound(
    // rust: engine,
    // rust: "minecraft:block.bubble_column.whirlpool_ambient",
    // rust: [fx, fy, fz],
    // rust: volume,
    // rust: pitch,
    // rust: );
}
    // rust: } else {
    // rust: add_visible(
    // rust: engine,
    // rust: T::BubbleColumnUp,
    // rust: [fx + 0.5, fy, fz + 0.5],
    // rust: [0.0, 0.04, 0.0],
    // rust: );
    // rust: let r = engine.random();
    // rust: let p = [
    // rust: fx + f64::from(r.next_float()),
    // rust: fy + f64::from(r.next_float()),
    // rust: fz + f64::from(r.next_float()),
    // rust: ];
    // rust: add_visible(engine, T::BubbleColumnUp, p, [0.0, 0.04, 0.0]);
    // rust: let r = engine.random();
    // rust: if next_int(r, 200) == 0 {
    // rust: let (volume, pitch) = (0.2 + r.next_float() * 0.2, 0.9 + r.next_float() * 0.15);
    // rust: sound(
    // rust: engine,
    // rust: "minecraft:block.bubble_column.upwards_ambient",
    // rust: [fx, fy, fz],
    // rust: volume,
    // rust: pitch,
    // rust: );
}
}
}
    // rust: Animate::Fire { soul } => {
    // rust: let r = engine.random();
    // rust: if next_int(r, 24) == 0 {
    // rust: let (volume, pitch) = (1.0 + r.next_float(), r.next_float() * 0.7 + 0.3);
    // rust: sound(
    // rust: engine,
    // rust: "minecraft:block.fire.ambient",
    // rust: [fx + 0.5, fy + 0.5, fz + 0.5],
    // rust: volume,
    // rust: pitch,
    // rust: );
}
            // BaseFireBlock.animateTick: three large smoke above the fire, or
            // two at each burnable neighbour's face when nothing burnable or
            // sturdy supports it (SoulFireBlock.canBurn is always true).
    // rust: let can_burn = |p: [i32; 3]| {
    // rust: soul || tables
    // rust: .burnable
    // rust: .get(ctx.state(p).0 as usize)
    // rust: .copied()
    // rust: .unwrap_or(false)
}
    // rust: let below = [pos[0], pos[1] - 1, pos[2]];
    // rust: let sturdy = ctx.facts.get(ctx.state(below)).sturdy_full & (1 << 1) != 0;
    // rust: if !can_burn(below) && !sturdy {
                // (neighbour, coordinate axis, face at the axis' high end): the
                // west, east, north, south and above faces, in vanilla order.
    // rust: for (at, axis, high) in [
    // rust: ([pos[0] - 1, pos[1], pos[2]], 0usize, false),
    // rust: ([pos[0] + 1, pos[1], pos[2]], 0, true),
    // rust: ([pos[0], pos[1], pos[2] - 1], 2, false),
    // rust: ([pos[0], pos[1], pos[2] + 1], 2, true),
    // rust: ([pos[0], pos[1] + 1, pos[2]], 1, true),
    // rust: ] {
    // rust: if !can_burn(at) {
    // rust: continue;
}
    // rust: for _ in 0..2 {
    // rust: let r = engine.random();
    // rust: let d = [r.next_double(), r.next_double(), r.next_double()];
    // rust: let mut p = [fx + d[0], fy + d[1], fz + d[2]];
                        // The face coordinate hugs the edge: `* 0.1F` (float).
    // rust: p[axis] = if high {
    // rust: f64::from(pos[axis]) + 1.0 - d[axis] * f64::from(0.1f32)
    // rust: } else {
    // rust: f64::from(pos[axis]) + d[axis] * f64::from(0.1f32)
}
    // rust: add(engine, T::LargeSmoke, p, [0.0; 3]);
}
}
    // rust: } else {
    // rust: for _ in 0..3 {
    // rust: let r = engine.random();
    // rust: let p = [
    // rust: fx + r.next_double(),
    // rust: fy + r.next_double() * 0.5 + 0.5,
    // rust: fz + r.next_double(),
    // rust: ];
    // rust: add(engine, T::LargeSmoke, p, [0.0; 3]);
}
}
}
}
}
/// `AmbientLeavesBlockSoundPlayer.playAmbientLeavesSounds` for the poplar leaves:
/// one log and three leaves of the same kind around the block.
    // rust: fn leaves_ambient_sound(
    // rust: tables: &AnimateTables,
    // rust: engine: &mut ParticleEngine,
    // rust: ctx: &AnimateContext,
    // rust: state: BlockStateId,
    // rust: pos: [i32; 3],
    // rust: ) {
    // rust: if next_int(engine.random(), 300) != 0 {
    // rust: return;
}
    // rust: let Some(name) = ctx.registry.state(state).map(|s| &s.name) else {
    // rust: return;
}
    // rust: let (mut logs, mut leaves) = (0, 0);
    // rust: for d in [[0, -1], [1, 0], [0, 1], [-1, 0]] {
    // rust: let neighbor = ctx.state([pos[0] + d[0], pos[1], pos[2] + d[1]]);
    // rust: if tables
    // rust: .poplar_leaf_logs
    // rust: .get(neighbor.0 as usize)
    // rust: .copied()
    // rust: .unwrap_or(false)
    // rust: {
    // rust: logs += 1;
}
    // rust: if ctx
    // rust: .registry
    // rust: .state(neighbor)
    // rust: .is_some_and(|s| &s.name == name)
    // rust: {
    // rust: leaves += 1;
}
    // rust: if logs == 1 && leaves == 3 {
    // rust: let p = pos.map(f64::from);
    // rust: sound(engine, "minecraft:block.poplar_leaves.ambient", p, 1.0, 1.0);
    // rust: return;
}
}
}
/// `PointedDripstoneBlock.animateTick`: a free-hanging stalactite tip drips the
/// fluid above the root of its stalactite.
    // rust: fn dripstone_drip(
    // rust: tables: &AnimateTables,
    // rust: engine: &mut ParticleEngine,
    // rust: ctx: &AnimateContext,
    // rust: state: BlockStateId,
    // rust: pos: [i32; 3],
    // rust: ) {
    // rust: let roll = engine.random().next_float();
    // rust: if roll > 0.12 {
    // rust: return;
}
    // getFluidAboveStalactite: findRootBlock climbs at most ten blocks of
    // stalactite and stops at the first block that is not pointed dripstone.
    // rust: let mut root = None;
    // rust: for step in 1..11 {
    // rust: let p = [pos[0], pos[1] + step, pos[2]];
    // rust: match tables
    // rust: .dripstone
    // rust: .get(ctx.state(p).0 as usize)
    // rust: .copied()
    // rust: .unwrap_or(0)
    // rust: {
    // rust: 0 => {
    // rust: root = Some(p);
    // rust: break;
}
    // rust: 2 => {}
    // rust: _ => return,
}
}
    // rust: let Some(root) = root else {
    // rust: return;
}
    // rust: let above = ctx.facts.get(ctx.state([root[0], root[1] + 1, root[2]]));
    // Mud above the root counts as a water source unless water evaporates here.
    // rust: let (fluid, source) = if &*above.name == "minecraft:mud" && !ctx.ultrawarm {
    // rust: (Fluid::Water, true)
    // rust: } else {
    // rust: (above.fluid, above.fluid_level >= 8 && !above.fluid_falling)
}
    // canFillCauldron: only a water or lava source passes below a 2% roll.
    // rust: if roll >= 0.02 && !(fluid != Fluid::None && source) {
    // rust: return;
}
    // getDripParticle: no fluid drips what the dimension's default says.
    // rust: let lava = fluid == Fluid::Lava || (fluid == Fluid::None && ctx.ultrawarm);
    // rust: let ty = if lava {
    // rust: T::DrippingDripstoneLava
    // rust: } else {
    // rust: T::DrippingDripstoneWater
}
    // rust: let offset = ctx.offset_of(state, pos);
    // STALACTITE_DRIP_START_PIXEL is the tip's lowest point, 5/16.
    // rust: let p = [
    // rust: f64::from(pos[0]) + 0.5 + offset[0],
    // rust: f64::from(pos[1]) + 0.3125 - 0.0625,
    // rust: f64::from(pos[2]) + 0.5 + offset[2],
    // rust: ];
    // rust: add(engine, ty, p, [0.0; 3]);
}
/// `AmbientDesertBlockSoundsPlayer.shouldPlayAmbientSandSound`: sand in the
/// surface column eight blocks away on all four sides.
pub fn sand_sound_nearby(tables: *AnimateTables, ctx: *AnimateContext, pos: [i32; 3]) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let is_sand = |p: [i32; 3]| {
    // rust: tables
    // rust: .desert_sand_sounds
    // rust: .get(ctx.state(p).0 as usize)
    // rust: .copied()
    // rust: .unwrap_or(false)
}
    // rust: let (mut found, mut checked) = (0, 0);
    // rust: for d in [[0, -8], [8, 0], [0, 8], [-8, 0]] {
    // rust: let (x, z) = (pos[0] + d[0], pos[2] + d[1]);
        // columnContainsTriggeringBlock.
    // rust: let surface = ctx.world.world_surface(x, z, |s| ctx.facts.is_air(s)) - 1;
    // rust: let matches = if (surface - pos[1]).abs() > 5 {
    // rust: let mut y = pos[1] + 6;
    // rust: let mut above_air = ctx.is_air([x, y, z]);
    // rust: y -= 1;
    // rust: let mut hit = false;
    // rust: for _ in 0..10 {
    // rust: if above_air && is_sand([x, y, z]) {
    // rust: hit = true;
    // rust: break;
}
    // rust: above_air = ctx.is_air([x, y, z]);
    // rust: y -= 1;
}
    // rust: hit
    // rust: } else {
    // rust: ctx.is_air([x, surface + 1, z]) && is_sand([x, surface, z])
}
    // rust: if matches {
    // rust: found += 1;
    // rust: if found > 3 {
    // rust: return true;
}
}
    // rust: checked += 1;
    // rust: if 4 - checked + found < 3 {
    // rust: return false;
}
}
    // rust: false
}
/// `AbstractCandleBlock.addParticlesAndSound`.
pub fn candle(engine: *mut ParticleEngine, p: [f64; 3]) void {
}
    // rust: let r = engine.random();
    // rust: let chance = r.next_float();
    // rust: if chance < 0.3 {
    // rust: add(engine, T::Smoke, p, [0.0; 3]);
    // rust: if chance < 0.17 {
    // rust: let r = engine.random();
    // rust: let (volume, pitch) = (1.0 + r.next_float(), r.next_float() * 0.7 + 0.3);
    // rust: sound(
    // rust: engine,
    // rust: "minecraft:block.candle.ambient",
    // rust: [p[0] + 0.5, p[1] + 0.5, p[2] + 0.5],
    // rust: volume,
    // rust: pitch,
    // rust: );
}
}
    // rust: add(engine, T::SmallFlame, p, [0.0; 3]);
}
/// `CampfireBlockEntity.particleTick` for every lit campfire; `cooking` says
/// which of a campfire's four slots hold an item.
    // rust: pub fn campfire_particles<'a>(
    // rust: tables: &AnimateTables,
    // rust: engine: &mut ParticleEngine,
    // rust: ctx: &AnimateContext,
    // rust: blocks: impl Iterator<Item = &'a ([i32; 3], u32)>,
    // rust: cooking: &dyn Fn([i32; 3]) -> [bool; 4],
    // rust: ) {
    // rust: for &(pos, state) in blocks {
    // rust: if !tables.is_lit_campfire(state) {
    // rust: continue;
}
    // rust: let properties = ctx
    // rust: .registry
    // rust: .state(BlockStateId(state))
    // rust: .map(|s| &s.properties);
    // rust: let prop = |k: &str| properties.and_then(|p| p.get(k)).map(String::as_str);
    // rust: let signal = prop("signal_fire") == Some("true");
        // Direction.get2DDataValue: south, west, north, east.
    // rust: let rotation = match prop("facing") {
    // rust: Some("west") => 1,
    // rust: Some("north") => 2,
    // rust: Some("east") => 3,
    // rust: _ => 0,
}
    // rust: let r = engine.random();
    // rust: if r.next_float() < 0.11 {
            // `for (int i = 0; i < random.nextInt(2) + 2; i++)`: the iteration
            // bound is drawn again on every pass, so the loop keeps asking the
            // random whether to make one more puff.
    // rust: let mut made = 0;
    // rust: loop {
    // rust: let count = next_int(engine.random(), 2) + 2;
    // rust: if made >= count {
    // rust: break;
}
    // rust: make_campfire_smoke(engine, pos, signal, false);
    // rust: made += 1;
}
}
        // The smoke over each cooking item, at the slot's corner of the fire.
    // rust: let occupied = cooking(pos);
    // rust: for (slot, _) in occupied.iter().enumerate().filter(|(_, held)| **held) {
    // rust: if engine.random().next_float() >= 0.2 {
    // rust: continue;
}
            // Direction.from2DDataValue((slot + rotation) % 4) and its clockwise side.
    // rust: let (step, clockwise) = match (slot + rotation) % 4 {
    // rust: 0 => ([0.0, 1.0], [-1.0, 0.0]),
    // rust: 1 => ([-1.0, 0.0], [0.0, -1.0]),
    // rust: 2 => ([0.0, -1.0], [1.0, 0.0]),
    // rust: _ => ([1.0, 0.0], [0.0, 1.0]),
}
    // rust: let at = [
    // rust: f64::from(pos[0]) + 0.5 - step[0] * 0.3125 + clockwise[0] * 0.3125,
    // rust: f64::from(pos[1]) + 0.5,
    // rust: f64::from(pos[2]) + 0.5 - step[1] * 0.3125 + clockwise[1] * 0.3125,
    // rust: ];
    // rust: for _ in 0..4 {
    // rust: add(engine, T::Smoke, at, [0.0, 5.0e-4, 0.0]);
}
}
}
}
/// `CampfireBlock.makeParticles` (always visible, overriding the limiter);
/// `smoking` adds the plain smoke puff at the logs.
    // rust: pub fn make_campfire_smoke(
    // rust: engine: &mut ParticleEngine,
    // rust: pos: [i32; 3],
    // rust: signal: bool,
    // rust: smoking: bool,
    // rust: ) {
    // rust: let r = engine.random();
    // rust: let sign = |r: &mut LegacyRandom| if r.next_boolean() { 1.0 } else { -1.0 };
    // rust: let dx = r.next_double() / 3.0;
    // rust: let x = f64::from(pos[0]) + 0.5 + dx * sign(r);
    // rust: let y = f64::from(pos[1]) + r.next_double() + r.next_double();
    // rust: let dz = r.next_double() / 3.0;
    // rust: let z = f64::from(pos[2]) + 0.5 + dz * sign(r);
    // rust: let ty = if signal {
    // rust: T::CampfireSignalSmoke
    // rust: } else {
    // rust: T::CampfireCosySmoke
}
    // rust: engine.create(&ParticleOptions::simple(ty), [x, y, z], [0.0, 0.07, 0.0]);
    // rust: if smoking {
    // rust: let r = engine.random();
    // rust: let dx = r.next_double() / 4.0 * sign(r);
    // rust: let dz = r.next_double() / 4.0 * sign(r);
    // rust: let at = [
    // rust: f64::from(pos[0]) + 0.5 + dx,
    // rust: f64::from(pos[1]) + 0.4,
    // rust: f64::from(pos[2]) + 0.5 + dz,
    // rust: ];
    // rust: engine.create(&ParticleOptions::simple(T::Smoke), at, [0.0, 0.005, 0.0]);
}
}

    // rust: mod tests {
//     use super::*;
pub fn classifies_animated_blocks() void {
}
    // rust: let none = |_: &str| None;
    // rust: assert_eq!(classify("minecraft:torch", &none), Animate::Torch(T::Flame));
    // rust: let lit = |k: &str| (k == "lit").then(|| "true".to_owned());
    // rust: assert_eq!(
    // rust: classify("minecraft:furnace", &lit),
    // rust: Animate::Furnace([0, -1, 0])
    // rust: );
    // rust: assert_eq!(classify("minecraft:furnace", &none), Animate::None);
    // rust: let wall = |k: &str| (k == "facing").then(|| "north".to_owned());
    // rust: assert_eq!(
    // rust: classify("minecraft:soul_wall_torch", &wall),
    // rust: Animate::WallTorch(T::SoulFireFlame, [0, 0, -1])
    // rust: );
    // rust: let candles = |k: &str| match k {
    // rust: "lit" => Some("true".to_owned()),
    // rust: "candles" => Some("3".to_owned()),
    // rust: _ => None,
}
    // rust: assert_eq!(
    // rust: classify("minecraft:red_candle", &candles),
    // rust: Animate::Candles(3)
    // rust: );
    // rust: assert_eq!(
    // rust: classify("minecraft:red_candle_cake", &lit),
    // rust: Animate::CandleCake
    // rust: );
}
pub fn redstone_colours_match_wire_table() void {
}
        // RedstoneWireBlock.COLORS[15] = (1.0, 0.2, 0.1) before int packing.
    // rust: let c = redstone_color(15);
    // rust: assert!((c[0] - 1.0).abs() < 1e-6);
    // rust: assert!((c[1] - (51.0 / 255.0)).abs() < 0.01);
}
}
