//! Transpiled from Horizon Rust crate
package horizon_world_data

import "core:fmt"
import "core:mem"
import "core:math"

// Behaviour tables built once from the pinned client resources.
// use super::{
    // rust: Behaviours, GameplayStateSource,
    // rust: classes::{Class, ClassSet, Interface},
    // rust: states::{BlockId, PropKey, StateTable},
}
// use crate::{
    // rust: collision::CachedCollisionRegistry,
    // rust: compression::invalid,
    // rust: fluid::{FluidBlockBindings, FluidKind, FluidState},
    // rust: registry::{BlockRegistry, BlockStateId, BlockTableFile},
    // rust: worldgen::tags::TagDefinitions,
}
// use horizon_core::geometry::{Aabb, Direction, ShapeOp, Vec3, VoxelShape};
// use serde_json::Value;
// use std::{collections::HashMap, fs, io, path::Path, sync::Arc};
    // rust: mod cache;
    // rust: pub(super) use cache::set_dir as set_cache_dir;

// Per-state flags read from vanilla accessors over an empty level.
    // rust: pub mod state_flags {
SOLID :: 1
AIR :: 1 << 1
CONDUCTOR :: 1 << 2
SIGNAL_SOURCE :: 1 << 3
ANALOG_OUTPUT :: 1 << 4
COLLISION_EMPTY :: 1 << 5
SUFFOCATING :: 1 << 6
REPLACEABLE :: 1 << 7
RANDOM_TICKS :: 1 << 8
SOLID_RENDER :: 1 << 9
LIQUID :: 1 << 10
BLOCK_ENTITY :: 1 << 11
IGNITED_BY_LAVA :: 1 << 12
CAN_OCCLUDE :: 1 << 13
FULL_COLLISION :: 1 << 14
SKYLIGHT_DOWN :: 1 << 15
REQUIRES_TOOL :: 1 << 16
SHAPE_OCCLUSION :: 1 << 17
}

PushReaction :: enum {
    PushPull,
    Push,
    Popped,
    Immoveable,
    IgnoreEntity,
}

StateFacts :: struct {
    flags: u32,
    // isFaceSturdy bits: support type (FULL, CENTER, RIGID) * 6 + direction.
    sturdy: u32,
    // getSignal / getDirectSignal over an empty level, 4 bits per direction.
    weak: u32,
    strong: u32,
    fluid: FluidState,
    emission: u8,
    dampening: u8,
    hardness: f32,
    push: PushReaction,
    instrument: u8,
    // Index into `Behaviours::shapes`, or -1 for an uncached (dynamic) shape.
    shape: i32,
}

SetType :: struct {
    name: ^str,
    can_open_by_hand: bool,
    can_open_by_wind_charge: bool,
    arrows: bool,
    // true: MOBS sensitivity (living entities only); false: EVERYTHING.
    mobs_only: bool,
    door_open: ^str,
    door_close: ^str,
    trapdoor_open: ^str,
    trapdoor_close: ^str,
    plate_on: ^str,
    plate_off: ^str,
    button_on: ^str,
    button_off: ^str,
}

Sounds :: struct {
    volume: f32,
    pitch: f32,
    place: ^str,
    break_: ^str,
    fall: ^str,
}

// Precomputed queries over one cached collision shape.
ShapeInfo :: struct {
    // `Block.isFaceFull(shape, direction)` per direction bit.
    full_faces: u8,
    // `!shape.getFaceShape(direction).isEmpty()` per direction bit.
    nonempty_faces: u8,
    // WallBlock `isCovered(shape.getFaceShape(DOWN), test)` for the post (bit 0)
    // and the north/east/south/west wall tests (bits 1..=4).
    wall_cover: u8,
}

    // rust: pub(crate) fn analyse_shape(shape: &VoxelShape) -> io::Result<ShapeInfo> {
    // rust: let err = |e: horizon_core::geometry::ShapeError| invalid(e.to_string());
    // rust: let mut info = ShapeInfo::default();
    // rust: let block = VoxelShape::block();
    // The faces are not kept on the shape: only these facts are.
    // rust: for direction in Direction::ALL {
    // rust: let face = shape.face_shape_transient(direction).map_err(err)?;
    // rust: if !block.join_is_not_empty(&face, ShapeOp::XOR).map_err(err)? {
    // rust: info.full_faces |= 1 << direction as u8;
}
    // rust: if !face.is_empty() {
    // rust: info.nonempty_faces |= 1 << direction as u8;
}
}
    // rust: let above = shape.face_shape_transient(Direction::Down).map_err(err)?;
    // rust: let px = |v: f64| v / 16.0;
    // rust: let tests = [
    // rust: (7.0, 7.0, 9.0, 9.0),
    // rust: (7.0, 0.0, 9.0, 9.0),
    // rust: (7.0, 7.0, 16.0, 9.0),
    // rust: (7.0, 7.0, 9.0, 16.0),
    // rust: (0.0, 7.0, 9.0, 9.0),
    // rust: ];
    // rust: for (bit, (x0, z0, x1, z1)) in tests.into_iter().enumerate() {
    // rust: let test = VoxelShape::from_box(Aabb::new(
    // rust: Vec3::new(px(x0), 0.0, px(z0)),
    // rust: Vec3::new(px(x1), 1.0, px(z1)),
    // rust: ))
    // rust: .map_err(err)?;
    // rust: if !test
    // rust: .join_is_not_empty(&above, ShapeOp::ONLY_FIRST)
    // rust: .map_err(err)?
    // rust: {
    // rust: info.wall_cover |= 1 << bit;
}
}
    // rust: Ok(info)
}

// Fluid tags as masks over `FluidKind::mask`.
FluidTags :: struct {
    water: u8,
    lava: u8,
    supports_frogspawn: u8,
    supports_lily_pad: u8,
    supports_sugar_cane_adjacently: u8,
    bubble_column_can_occupy: u8,
}

// A set of blocks (a resolved block tag).
BlockSet :: struct {
    // rust: impl BlockSet {
with_capacity :: proc(blocks: uint) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self(vec![0; blocks.div_ceil(64)])
}
insert :: proc(self: ^Self, block: BlockId) {
}
    // rust: let i = block.0 as usize;
    // rust: if i / 64 >= self.0.len() {
    // rust: self.0.resize(i / 64 + 1, 0);
}
    // rust: self.0[i / 64] |= 1 << (i % 64);
}
contains :: proc(self: ^Self, block: BlockId) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let i = block.0 as usize;
    // rust: self.0.get(i / 64).is_some_and(|w| w & (1 << (i % 64)) != 0)
}
}

BlockData :: struct {
    class: Class,
    // Recognised classes of the Java class chain, most derived first; ported
    // overrides dispatch along it so `super` calls reach the next override.
    chain: [dynamic]Class,
    classes: ClassSet,
    interfaces: u16,
    set_type: Maybe(^SetType),
    gate_open: Maybe(^str),
    gate_close: Maybe(^str),
    open_sound: Maybe(^str),
    close_sound: Maybe(^str),
    ticks_to_stay_pressed: i32,
    max_weight: i32,
    // Block-valued configuration: concrete (powder), fruit (stems), potted
    // content, dead coral, stair base, candle (candle cakes), required nylium.
    link: Maybe(BlockId),
    // Second block link: attached stem (stems) or stem (attached stems).
    link2: Maybe(BlockId),
    // Support blocks (stems, plants); a content mod's connecting block's
    // `connects_to` (a `PipeBlock` alone in its chain).
    support_tag: Maybe(^BlockSet),
    support_tag2: Maybe(^BlockSet),
    feature: Maybe(^str),
    grow_probability: f64,
    growth_direction: Direction,
    schedule_fluid_ticks: bool,
    weather: u8,
    ignite_odds: i32,
    burn_odds: i32,
    sounds: ^Sounds,
    item: ^str,
    dynamic_shape: bool,
}
    // rust: impl BlockData {
is :: proc(self: ^Self, class: Class) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.class == class || self.classes.contains(class)
}
implements :: proc(self: ^Self, interface: Interface) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.interfaces & interface.mask() != 0
}
}

// Item-to-block placement bindings (BlockItem and its subclasses).
ItemBinding :: struct {
    block: BlockId,
    wall_block: Maybe(BlockId),
    // StandingAndWallBlockItem.attachmentDirection (DOWN for torches/signs, UP for hanging signs).
    attachment: Maybe(Direction),
    kind: ItemKind,
    // GameMasterBlockItem (command/structure/jigsaw blocks): only placeable
    // by players that can use game master blocks.
    game_master: bool,
}
ItemKind :: enum {
    Block,
    DoubleHigh,
    StandingAndWall,
    Scaffolding,
    PlaceOnWater,
    HangingSign,
    SolidBucket,
    Other,
}

    // rust: macro_rules! named_blocks {
    // rust: ($($field:ident = $name:literal,)*) => {
        // Blocks referenced by identity in vanilla code (`Blocks.X`).
Named :: struct {
    // rust: impl Named {
    // rust: pub(super) fn resolve(table: &StateTable) -> io::Result<Self> {
    // rust: Ok(Self { $($field: table.block_by_name(concat!("minecraft:", $name)).ok_or_else(|| invalid(concat!("missing block ", $name)))?,)* })
}
}
}
}
    // rust: named_blocks! {
    // rust: air = "air",
    // rust: cave_air = "cave_air",
    // rust: void_air = "void_air",
    // rust: water = "water",
    // rust: lava = "lava",
    // rust: stone = "stone",
    // rust: cobblestone = "cobblestone",
    // rust: obsidian = "obsidian",
    // rust: basalt = "basalt",
    // rust: soul_soil = "soul_soil",
    // rust: blue_ice = "blue_ice",
    // rust: ice = "ice",
    // rust: frosted_ice = "frosted_ice",
    // rust: snow = "snow",
    // rust: snow_block = "snow_block",
    // rust: powder_snow = "powder_snow",
    // rust: dirt = "dirt",
    // rust: grass_block = "grass_block",
    // rust: mycelium = "mycelium",
    // rust: podzol = "podzol",
    // rust: farmland = "farmland",
    // rust: dirt_path = "dirt_path",
    // rust: mud = "mud",
    // rust: clay = "clay",
    // rust: sponge = "sponge",
    // rust: wet_sponge = "wet_sponge",
    // rust: fire = "fire",
    // rust: soul_fire = "soul_fire",
    // rust: redstone_wire = "redstone_wire",
    // rust: comparator = "comparator",
    // rust: repeater = "repeater",
    // rust: redstone_torch = "redstone_torch",
    // rust: redstone_wall_torch = "redstone_wall_torch",
    // rust: redstone_block = "redstone_block",
    // rust: redstone_lamp = "redstone_lamp",
    // rust: observer = "observer",
    // rust: piston = "piston",
    // rust: sticky_piston = "sticky_piston",
    // rust: piston_head = "piston_head",
    // rust: moving_piston = "moving_piston",
    // rust: tnt = "tnt",
    // rust: magma_block = "magma_block",
    // rust: soul_sand = "soul_sand",
    // rust: bubble_column = "bubble_column",
    // rust: kelp = "kelp",
    // rust: kelp_plant = "kelp_plant",
    // rust: seagrass = "seagrass",
    // rust: tall_seagrass = "tall_seagrass",
    // rust: cactus = "cactus",
    // rust: cactus_flower = "cactus_flower",
    // rust: sugar_cane = "sugar_cane",
    // rust: bamboo = "bamboo",
    // rust: bamboo_sapling = "bamboo_sapling",
    // rust: scaffolding = "scaffolding",
    // rust: melon = "melon",
    // rust: pumpkin = "pumpkin",
    // rust: carved_pumpkin = "carved_pumpkin",
    // rust: jack_o_lantern = "jack_o_lantern",
    // rust: barrier = "barrier",
    // rust: cake = "cake",
    // rust: flower_pot = "flower_pot",
    // rust: cauldron = "cauldron",
    // rust: water_cauldron = "water_cauldron",
    // rust: lava_cauldron = "lava_cauldron",
    // rust: powder_snow_cauldron = "powder_snow_cauldron",
    // rust: dragon_egg = "dragon_egg",
    // rust: tripwire = "tripwire",
    // rust: tripwire_hook = "tripwire_hook",
    // rust: slime_block = "slime_block",
    // rust: honey_block = "honey_block",
    // rust: hopper = "hopper",
    // rust: note_block = "note_block",
    // rust: chorus_plant = "chorus_plant",
    // rust: chorus_flower = "chorus_flower",
    // rust: end_stone = "end_stone",
    // rust: vine = "vine",
    // rust: lily_pad = "lily_pad",
    // rust: small_dripleaf = "small_dripleaf",
    // rust: big_dripleaf = "big_dripleaf",
    // rust: big_dripleaf_stem = "big_dripleaf_stem",
    // rust: pointed_dripstone = "pointed_dripstone",
    // rust: ladder = "ladder",
    // rust: sweet_berry_bush = "sweet_berry_bush",
    // rust: torchflower = "torchflower",
    // rust: pitcher_plant = "pitcher_plant",
    // rust: pitcher_crop = "pitcher_crop",
    // rust: moss_block = "moss_block",
    // rust: short_grass = "short_grass",
    // rust: tall_grass = "tall_grass",
    // rust: fern = "fern",
    // rust: large_fern = "large_fern",
    // rust: dead_bush = "dead_bush",
    // rust: netherrack = "netherrack",
    // rust: soul_campfire = "soul_campfire",
    // rust: campfire = "campfire",
    // rust: light = "light",
    // rust: sculk_sensor = "sculk_sensor",
    // rust: calibrated_sculk_sensor = "calibrated_sculk_sensor",
    // rust: sculk_shrieker = "sculk_shrieker",
    // rust: sculk_catalyst = "sculk_catalyst",
    // rust: sculk = "sculk",
    // rust: sculk_vein = "sculk_vein",
    // rust: lectern = "lectern",
    // rust: target = "target",
    // rust: daylight_detector = "daylight_detector",
    // rust: lever = "lever",
    // rust: beehive = "beehive",
    // rust: bee_nest = "bee_nest",
    // rust: composter = "composter",
    // rust: respawn_anchor = "respawn_anchor",
    // rust: end_portal_frame = "end_portal_frame",
    // rust: crafter = "crafter",
    // rust: copper_bulb = "copper_bulb",
    // rust: glow_lichen = "glow_lichen",
    // rust: hanging_roots = "hanging_roots",
    // rust: mangrove_roots = "mangrove_roots",
    // rust: big_dripleaf_fallback = "big_dripleaf",
    // rust: nether_portal = "nether_portal",
    // rust: chain_command_block = "chain_command_block",
    // rust: frogspawn = "frogspawn",
    // rust: turtle_egg = "turtle_egg",
    // rust: sniffer_egg = "sniffer_egg",
    // rust: sea_pickle = "sea_pickle",
    // rust: coarse_dirt = "coarse_dirt",
    // rust: rooted_dirt = "rooted_dirt",
    // rust: crimson_nylium = "crimson_nylium",
    // rust: warped_nylium = "warped_nylium",
}

    // rust: macro_rules! tags {
    // rust: ($($field:ident = $name:literal,)*) => {
        // Block tags consulted by ported behaviour.
Tags :: struct {
    // rust: impl Tags {
    // rust: pub(super) fn resolve(all: &HashMap<String, Arc<BlockSet>>) -> Self {
    // rust: Self { $($field: all.get(concat!("minecraft:", $name)).cloned().unwrap_or_default(),)* }
}
}
}
}
    // rust: tags! {
    // rust: leaves = "leaves",
    // rust: logs = "logs",
    // rust: prevents_nearby_leaf_decay = "prevents_nearby_leaf_decay",
    // rust: walls = "walls",
    // rust: fences = "fences",
    // rust: wooden_fences = "wooden_fences",
    // rust: fence_gates = "fence_gates",
    // rust: stairs = "stairs",
    // rust: slabs = "slabs",
    // rust: doors = "doors",
    // rust: trapdoors = "trapdoors",
    // rust: rails = "rails",
    // rust: beds = "beds",
    // rust: wall_post_override = "wall_post_override",
    // rust: replaceable = "replaceable",
    // rust: dirt = "dirt",
    // rust: sand = "sand",
    // rust: ice = "ice",
    // rust: snow = "snow",
    // rust: infiniburn_overworld = "infiniburn_overworld",
    // rust: infiniburn_nether = "infiniburn_nether",
    // rust: infiniburn_end = "infiniburn_end",
    // rust: soul_fire_base_blocks = "soul_fire_base_blocks",
    // rust: washed_away_by_fluids = "washed_away_by_fluids",
    // rust: blocks_fluid_flow = "blocks_fluid_flow",
    // rust: blocks_motion = "blocks_motion",
    // rust: unstable_bottom_center = "unstable_bottom_center",
    // rust: cannot_support_snow_layer = "cannot_support_snow_layer",
    // rust: support_override_snow_layer = "support_override_snow_layer",
    // rust: maintains_farmland = "maintains_farmland",
    // rust: supports_vegetation = "supports_vegetation",
    // rust: supports_crops = "supports_crops",
    // rust: supports_cactus = "supports_cactus",
    // rust: supports_sugar_cane = "supports_sugar_cane",
    // rust: supports_sugar_cane_adjacently = "supports_sugar_cane_adjacently",
    // rust: supports_bamboo = "supports_bamboo",
    // rust: supports_cocoa = "supports_cocoa",
    // rust: supports_azalea = "supports_azalea",
    // rust: supports_dry_vegetation = "supports_dry_vegetation",
    // rust: supports_nether_sprouts = "supports_nether_sprouts",
    // rust: supports_nether_wart = "supports_nether_wart",
    // rust: supports_wither_rose = "supports_wither_rose",
    // rust: supports_lily_pad = "supports_lily_pad",
    // rust: supports_frogspawn = "supports_frogspawn",
    // rust: supports_big_dripleaf = "supports_big_dripleaf",
    // rust: supports_small_dripleaf = "supports_small_dripleaf",
    // rust: supports_mangrove_propagule = "supports_mangrove_propagule",
    // rust: supports_hanging_mangrove_propagule = "supports_hanging_mangrove_propagule",
    // rust: supports_chorus_plant = "supports_chorus_plant",
    // rust: supports_chorus_flower = "supports_chorus_flower",
    // rust: support_override_cactus_flower = "support_override_cactus_flower",
    // rust: cannot_support_seagrass = "cannot_support_seagrass",
    // rust: cannot_support_kelp = "cannot_support_kelp",
    // rust: overrides_mushroom_light_requirement = "overrides_mushroom_light_requirement",
    // rust: enables_bubble_column_push_up = "enables_bubble_column_push_up",
    // rust: enables_bubble_column_drag_down = "enables_bubble_column_drag_down",
    // rust: shulker_boxes = "shulker_boxes",
    // rust: pale_oak_logs = "pale_oak_logs",
    // rust: convertible_to_mud = "convertible_to_mud",
    // rust: grows_crops = "grows_crops",
    // rust: candles = "candles",
    // rust: candle_cakes = "candle_cakes",
    // rust: campfires = "campfires",
    // rust: buttons = "buttons",
    // rust: pressure_plates = "pressure_plates",
    // rust: wool = "wool",
    // rust: crops = "crops",
    // rust: small_flowers = "small_flowers",
    // rust: flowers = "flowers",
    // rust: saplings = "saplings",
    // rust: anvil = "anvil",
    // rust: lanterns = "lanterns",
    // rust: climbable = "climbable",
    // rust: nylium = "nylium",
    // rust: mushroom_grow_block = "mushroom_grow_block",
    // rust: guarded_by_piglins = "guarded_by_piglins",
    // rust: copper = "copper",
    // rust: copper_chests = "copper_chests",
    // rust: copper_golem_statues = "copper_golem_statues",
}

// Property keys interned at load.
    // rust: macro_rules! props {
    // rust: ($($field:ident = $name:literal,)*) => {
Props :: struct {
    // rust: impl Props {
    // rust: pub(super) fn resolve(table: &mut StateTable) -> Self {
    // rust: Self { $($field: table.key($name),)* }
}
}
}
}
    // rust: props! {
    // rust: waterlogged = "waterlogged",
    // rust: facing = "facing",
    // rust: half = "half",
    // rust: shape = "shape",
    // rust: open = "open",
    // rust: powered = "powered",
    // rust: hinge = "hinge",
    // rust: in_wall = "in_wall",
    // rust: axis = "axis",
    // rust: age = "age",
    // rust: level = "level",
    // rust: layers = "layers",
    // rust: snowy = "snowy",
    // rust: north = "north",
    // rust: south = "south",
    // rust: east = "east",
    // rust: west = "west",
    // rust: up = "up",
    // rust: down = "down",
    // rust: distance = "distance",
    // rust: persistent = "persistent",
    // rust: moisture = "moisture",
    // rust: face = "face",
    // rust: lit = "lit",
    // rust: power = "power",
    // rust: delay = "delay",
    // rust: locked = "locked",
    // rust: mode = "mode",
    // rust: triggered = "triggered",
    // rust: extended = "extended",
    // rust: kind = "type",
    // rust: part = "part",
    // rust: occupied = "occupied",
    // rust: hanging = "hanging",
    // rust: attached = "attached",
    // rust: candles = "candles",
    // rust: pickles = "pickles",
    // rust: eggs = "eggs",
    // rust: hatch = "hatch",
    // rust: note = "note",
    // rust: instrument = "instrument",
    // rust: bites = "bites",
    // rust: rotation = "rotation",
    // rust: stage = "stage",
    // rust: leaves = "leaves",
    // rust: bottom = "bottom",
    // rust: falling = "falling",
    // rust: drag = "drag",
    // rust: tilt = "tilt",
    // rust: attachment = "attachment",
    // rust: vertical_direction = "vertical_direction",
    // rust: thickness = "thickness",
    // rust: berries = "berries",
    // rust: flower_amount = "flower_amount",
    // rust: segment_amount = "segment_amount",
    // rust: charges = "charges",
    // rust: eye = "eye",
    // rust: has_bottle_0 = "has_bottle_0",
    // rust: disarmed = "disarmed",
    // rust: inverted = "inverted",
    // rust: enabled = "enabled",
    // rust: conditional = "conditional",
    // rust: short = "short",
    // rust: unstable = "unstable",
    // rust: tip = "tip",
    // rust: honey_level = "honey_level",
    // rust: bloom = "bloom",
    // rust: natural = "natural",
    // rust: creaking_heart_state = "creaking_heart_state",
    // rust: cracked = "cracked",
    // rust: has_book = "has_book",
    // rust: has_record = "has_record",
    // rust: signal_fire = "signal_fire",
    // rust: orientation = "orientation",
    // rust: crafting = "crafting",
    // rust: side_chain = "side_chain",
    // rust: slot_0_occupied = "slot_0_occupied",
    // rust: slot_1_occupied = "slot_1_occupied",
    // rust: slot_2_occupied = "slot_2_occupied",
    // rust: slot_3_occupied = "slot_3_occupied",
    // rust: slot_4_occupied = "slot_4_occupied",
    // rust: slot_5_occupied = "slot_5_occupied",
    // rust: copper_golem_pose = "copper_golem_pose",
    // rust: sculk_sensor_phase = "sculk_sensor_phase",
    // rust: shrieking = "shrieking",
    // rust: can_summon = "can_summon",
    // rust: potent_sulfur_state = "potent_sulfur_state",
}

fail :: proc(message: string) -> i {
    // Ported from Horizon
    return {}
}
    // rust: invalid(message)
}

// From the file's bytes in memory: several times faster than through a
// reader on gameplay-facts.json (55 MB), which a first start parses.
read_json :: proc(path: ^Path) -> i {
    // Ported from Horizon
    return {}
}
    // rust: serde_json::from_slice(&fs::read(path)?).map_err(|e| invalid(e.to_string()))
}

interned :: proc(cache: ^HashMap<string, text: string) -> A {
    // Ported from Horizon
    return {}
}
    // rust: cache
    // rust: .entry(text.to_owned())
    // rust: .or_insert_with(|| Arc::from(text))
    // rust: .clone()
}

set_type :: proc(value: ^Value, cache: ^HashMap<string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let text = |key: &str| value.get(key).and_then(Value::as_str).unwrap_or("");
    // rust: Some(SetType {
    // rust: name: value.get("name")?.as_str()?.into(),
    // rust: can_open_by_hand: value.get("canOpenByHand")?.as_bool()?,
    // rust: can_open_by_wind_charge: value.get("canOpenByWindCharge")?.as_bool()?,
    // rust: arrows: value.get("canButtonBeActivatedByArrows")?.as_bool()?,
    // rust: mobs_only: value.get("pressurePlateSensitivity")?.as_str()? == "MOBS",
    // rust: door_open: interned(cache, text("doorOpen")),
    // rust: door_close: interned(cache, text("doorClose")),
    // rust: trapdoor_open: interned(cache, text("trapdoorOpen")),
    // rust: trapdoor_close: interned(cache, text("trapdoorClose")),
    // rust: plate_on: interned(cache, text("pressurePlateClickOn")),
    // rust: plate_off: interned(cache, text("pressurePlateClickOff")),
    // rust: button_on: interned(cache, text("buttonClickOn")),
    // rust: button_off: interned(cache, text("buttonClickOff")),
    // rust: })
}

// Build the block-state registry from the resources' `facts.json` (the
// same source the native client uses): the cache folder's snapshot when it
// matches the file and this build, the streamed JSON otherwise.
load_registry :: proc(root: ^Path) -> i {
    // Ported from Horizon
    return {}
}
    // rust: Ok(load_registry_with_flags(root)?.0)
}

// [`load_registry`] with each state's `(air, fluid)` columns.
load_registry_with_flags :: proc(root: ^Path) -> i {
    // Ported from Horizon
    return {}
}
    // rust: if let Some(cached) = cache::load_registry(root) {
    // rust: return Ok(cached);
}
    // Read whole, then parsed from the slice: see `BlockRegistry::from_facts_json_bytes`.
    // rust: let loaded = BlockRegistry::from_facts_json_bytes(&fs::read(root.join("facts.json"))?)?;
    // rust: cache::store_registry(root, &loaded.0, &loaded.1);
    // rust: Ok(loaded)
}

    // rust: pub(super) fn load(registry: &BlockRegistry, root: &Path) -> io::Result<Behaviours> {
    // rust: cached(registry, root, || load_uncached(registry, root))
}

// [`load`] with `block-behaviours.json` already parsed by the caller.
    // rust: pub(super) fn load_with_behaviour_json(
    // rust: registry: &BlockRegistry,
    // rust: root: &Path,
    // rust: behaviour: &Value,
    // rust: ) -> io::Result<Behaviours> {
    // rust: cached(registry, root, || {
    // rust: build_with_behaviour_json(registry, root, behaviour)
    // rust: })
}

// [`load`] with the client's typed gameplay projection. The snapshot is
// still tried first: on a hit the projection is not needed.
    // rust: pub(super) fn load_with_gameplay<G: GameplayStateSource>(
    // rust: registry: &BlockRegistry,
    // rust: root: &Path,
    // rust: behaviour: &Value,
    // rust: gameplay_states: &[G],
    // rust: ) -> io::Result<Behaviours> {
    // rust: cached(registry, root, || {
    // rust: build_with_gameplay(registry, root, behaviour, gameplay_states)
    // rust: })
}

// The snapshot when it matches, else `build` and refresh the snapshot.
    // rust: fn cached(
    // rust: registry: &BlockRegistry,
    // rust: root: &Path,
    // rust: build: impl FnOnce() -> io::Result<Behaviours>,
    // rust: ) -> io::Result<Behaviours> {
    // rust: if let Some(behaviours) = cache::load(registry, root) {
    // rust: return Ok(behaviours);
}
    // rust: let behaviours = build()?;
    // rust: cache::store(registry, root, &behaviours);
    // rust: Ok(behaviours)
}

load_uncached :: proc(registry: ^BlockRegistry, root: ^Path) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let behaviour = read_json(&root.join("block-behaviours.json"))?;
    // rust: build_with_behaviour_json(registry, root, &behaviour)
}

    // rust: fn build_with_behaviour_json(
    // rust: registry: &BlockRegistry,
    // rust: root: &Path,
    // rust: behaviour: &Value,
    // rust: ) -> io::Result<Behaviours> {
    // rust: let gameplay = read_json(&root.join("gameplay-facts.json"))?;
    // rust: let gameplay_states = gameplay["states"]
    // rust: .as_array()
    // rust: .ok_or_else(|| fail("missing gameplay states"))?;
    // rust: build_with_gameplay(registry, root, behaviour, gameplay_states)
}

    // rust: fn build_with_gameplay<G: GameplayStateSource>(
    // rust: registry: &BlockRegistry,
    // rust: root: &Path,
    // rust: behaviour: &Value,
    // rust: gameplay_states: &[G],
    // rust: ) -> io::Result<Behaviours> {
    // rust: let mut table = StateTable::new(registry)?;
    // rust: let props = Props::resolve(&mut table);
    // rust: let named = Named::resolve(&table)?;
    // rust: let blocks_json = behaviour["blocks"]
    // rust: .as_array()
    // rust: .ok_or_else(|| fail("missing behaviour blocks"))?;
    // rust: let states_json = behaviour["states"]
    // rust: .as_array()
    // rust: .ok_or_else(|| fail("missing behaviour states"))?;
    // rust: if blocks_json.len() != table.block_count()
    // rust: || states_json.len() != table.state_count()
    // rust: || gameplay_states.len() != table.state_count()
    // rust: {
    // rust: return Err(fail("behaviour exports do not match the block registry"));
}
    // Fluid registry order fixes the fluid tick type IDs.
    // rust: let fluids: Vec<&str> = behaviour["fluids"]
    // rust: .as_array()
    // rust: .ok_or_else(|| fail("missing fluid registry"))?
    // rust: .iter()
    // rust: .filter_map(Value::as_str)
    // rust: .collect();
    // rust: if fluids
    // rust: .iter()
    // rust: .copied()
    // rust: .ne(FluidKind::ALL.iter().map(|k| k.name()))
    // rust: {
    // rust: return Err(fail("fluid registry order differs from Horizon's"));
}

    // Tags.
    // rust: let bundle = read_json(&root.join("block-tags.json"))?;
    // rust: let mut definitions = TagDefinitions::default();
    // rust: for (name, text) in bundle
    // rust: .as_object()
    // rust: .ok_or_else(|| fail("invalid block tag bundle"))?
    // rust: {
    // rust: definitions
    // rust: .apply_json(
    // rust: name,
    // rust: "vanilla",
    // rust: text.as_str()
    // rust: .ok_or_else(|| fail("invalid block tag text"))?,
    // rust: )
    // rust: .map_err(|e| invalid(e.to_string()))?;
}
    // rust: let built = definitions
    // rust: .build(|name, _| table.block_by_name(name).map(|_| name.to_owned()))
    // rust: .map_err(|e| invalid(e.to_string()))?;
    // rust: let mut all_tags = HashMap::new();
    // rust: for (name, members) in &built.tags {
    // rust: let mut set = BlockSet::with_capacity(table.block_count());
    // rust: for member in members {
    // rust: if let Some(block) = table.block_by_name(member) {
    // rust: set.insert(block);
}
}
    // rust: all_tags.insert(name.clone(), Arc::new(set));
}
    // rust: let tags = Tags::resolve(&all_tags);
    // rust: let tag = |name: &str| -> Option<Arc<BlockSet>> {
    // rust: all_tags
    // rust: .get(name.strip_prefix('#').unwrap_or(name))
    // rust: .cloned()
}

    // Collision shapes.
    // rust: let collision_file = BlockTableFile::open(&root.join("cached-collision.nbt"), registry)?;
    // rust: let cached = CachedCollisionRegistry::from_table(collision_file.table("collision")?)?;
    // rust: let mut shapes: Vec<VoxelShape> = Vec::new();
    // rust: let mut shape_ids = Vec::with_capacity(table.state_count());
    // rust: for id in 0..table.state_count() {
    // rust: let Some(shape) = cached.cached_shape(BlockStateId(id as u32))? else {
    // rust: shape_ids.push(-1);
    // rust: continue;
}
    // rust: let index = match shapes.iter().position(|s| s.same_identity(shape)) {
    // rust: Some(index) => index,
    // rust: None => {
    // rust: shapes.push(shape.clone());
    // rust: shapes.len() - 1
}
}
    // rust: shape_ids.push(index as i32);
}

    // rust: let shape_info = shapes
    // rust: .iter()
    // rust: .map(analyse_shape)
    // rust: .collect::<io::Result<Vec<_>>>()?;

    // Fluid tags.
    // rust: let mut fluid_definitions = TagDefinitions::default();
    // rust: let fluid_dir = root.join("data/minecraft/tags/fluid");
    // rust: for entry in fs::read_dir(&fluid_dir)? {
    // rust: let path = entry?.path();
    // rust: let Some(stem) = path.file_stem().and_then(|s| s.to_str()) else {
    // rust: continue;
}
    // rust: fluid_definitions
    // rust: .apply_json(
    // rust: &format!("minecraft:{stem}"),
    // rust: "vanilla",
    // rust: &fs::read_to_string(&path)?,
    // rust: )
    // rust: .map_err(|e| invalid(e.to_string()))?;
}
    // rust: let fluid_built = fluid_definitions
    // rust: .build(|name, _| FluidKind::from_name(name).map(|kind| kind as u8))
    // rust: .map_err(|e| invalid(e.to_string()))?;
    // rust: let fluid_mask = |name: &str| -> u8 {
    // rust: fluid_built
    // rust: .tags
    // rust: .get(name)
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .fold(0, |mask, kind| mask | 1 << kind)
}
    // rust: let fluid_tags = FluidTags {
    // rust: water: fluid_mask("minecraft:water"),
    // rust: lava: fluid_mask("minecraft:lava"),
    // rust: supports_frogspawn: fluid_mask("minecraft:supports_frogspawn"),
    // rust: supports_lily_pad: fluid_mask("minecraft:supports_lily_pad"),
    // rust: supports_sugar_cane_adjacently: fluid_mask("minecraft:supports_sugar_cane_adjacently"),
    // rust: bubble_column_can_occupy: fluid_mask("minecraft:bubble_column_can_occupy"),
}

    // Per-state facts.
    // rust: let mut facts = Vec::with_capacity(table.state_count());
    // rust: for (id, (exported, game)) in states_json.iter().zip(gameplay_states).enumerate() {
    // rust: let row = exported
    // rust: .as_array()
    // rust: .ok_or_else(|| fail("invalid behaviour state row"))?;
    // rust: let int = |i: usize| row.get(i).and_then(Value::as_i64).unwrap_or(0);
    // rust: let gb = |key: &str| game.flag(key);
    // rust: let mut flags = int(1) as u32 & 0x7f;
    // rust: for (key, bit) in [
    // rust: ("replaceable", state_flags::REPLACEABLE),
    // rust: ("random_ticks", state_flags::RANDOM_TICKS),
    // rust: ("solid_render", state_flags::SOLID_RENDER),
    // rust: ("liquid", state_flags::LIQUID),
    // rust: ("block_entity", state_flags::BLOCK_ENTITY),
    // rust: ("ignited_by_lava", state_flags::IGNITED_BY_LAVA),
    // rust: ("can_occlude", state_flags::CAN_OCCLUDE),
    // rust: ("full_collision", state_flags::FULL_COLLISION),
    // rust: ("skylight_down", state_flags::SKYLIGHT_DOWN),
    // rust: ("requires_tool", state_flags::REQUIRES_TOOL),
    // rust: ("shape_occlusion", state_flags::SHAPE_OCCLUSION),
    // rust: ] {
    // rust: if gb(key) {
    // rust: flags |= bit;
}
}
    // rust: let fluid_kind = FluidKind::ALL
    // rust: .get(int(2) as usize)
    // rust: .copied()
    // rust: .ok_or_else(|| fail("invalid exported fluid"))?;
    // rust: let fluid = FluidState::new(
    // rust: fluid_kind,
    // rust: int(3) as u8,
    // rust: row.get(4).and_then(Value::as_bool).unwrap_or(false),
    // rust: );
    // rust: facts.push(StateFacts {
    // rust: flags,
    // rust: sturdy: int(0) as u32,
    // rust: weak: int(5) as u32,
    // rust: strong: int(6) as u32,
    // rust: fluid,
    // rust: emission: game.unsigned("emission") as u8,
    // rust: dampening: game.unsigned("dampening") as u8,
    // rust: hardness: game.number("hardness") as f32,
    // rust: push: match game.text("push") {
    // rust: "PUSH" => PushReaction::Push,
    // rust: "POPPED" => PushReaction::Popped,
    // rust: "IMMOVEABLE" => PushReaction::Immoveable,
    // rust: "IGNORE_ENTITY" => PushReaction::IgnoreEntity,
    // rust: _ => PushReaction::PushPull,
    // rust: },
    // rust: instrument: instrument_index(row.get(8).and_then(Value::as_str).unwrap_or("HARP")),
    // rust: shape: shape_ids[id],
    // rust: });
}

    // Per-block data.
    // rust: let fire = &behaviour["fire"];
    // rust: let odds = |key: &str, name: &str| -> i32 {
    // rust: fire.get(key)
    // rust: .and_then(|m| m.get(name))
    // rust: .and_then(Value::as_i64)
    // rust: .unwrap_or(0) as i32
}
    // rust: let mut strings = HashMap::new();
    // rust: let mut blocks = Vec::with_capacity(table.block_count());
    // rust: for (index, json) in blocks_json.iter().enumerate() {
    // rust: let block = BlockId(index as u16);
    // rust: let name = json["name"]
    // rust: .as_str()
    // rust: .ok_or_else(|| fail("block without name"))?;
    // rust: if name != &*table.info(block).name {
    // rust: return Err(fail("behaviour block order differs from registry"));
}
    // rust: let mut classes = ClassSet::default();
    // rust: let mut chain = Vec::new();
    // rust: for java in json["class"]
    // rust: .as_array()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .filter_map(Value::as_str)
    // rust: {
    // rust: if let Some(c) = Class::from_java(java) {
    // rust: classes.insert(c);
    // rust: chain.push(c);
}
}
    // rust: let class = chain.first().copied().unwrap_or(Class::Block);
    // rust: let mut interfaces = 0;
    // rust: for java in json["interfaces"]
    // rust: .as_array()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .filter_map(Value::as_str)
    // rust: {
    // rust: if let Some(i) = Interface::from_java(java) {
    // rust: interfaces |= i.mask();
}
}
    // rust: let fields = &json["fields"];
    // rust: let field = |key: &str| fields.get(key);
    // rust: let block_field = |key: &str| {
    // rust: field(key)
    // rust: .and_then(Value::as_str)
    // rust: .and_then(|n| table.block_by_name(n))
}
    // rust: let wood = field("type").filter(|t| t.get("setType").is_some());
    // rust: let set_type = match wood {
    // rust: Some(wood) => set_type(&wood["setType"], &mut strings),
    // rust: None => field("type").and_then(|t| set_type(t, &mut strings)),
}
    // rust: .map(Arc::new);
    // rust: let text = |value: Option<&Value>, strings: &mut HashMap<String, Arc<str>>| {
    // rust: value.and_then(Value::as_str).map(|s| interned(strings, s))
}
    // rust: let gate_open = text(wood.and_then(|w| w.get("fenceGateOpen")), &mut strings);
    // rust: let gate_close = text(wood.and_then(|w| w.get("fenceGateClose")), &mut strings);
    // rust: let open_sound = text(field("openSound"), &mut strings);
    // rust: let close_sound = text(field("closeSound"), &mut strings);
    // rust: let link = [
    // rust: "concrete",
    // rust: "fruit",
    // rust: "potted",
    // rust: "deadBlock",
    // rust: "base",
    // rust: "candleBlock",
    // rust: "requiredBlock",
    // rust: "baseBlock",
    // rust: ]
    // rust: .into_iter()
    // rust: .find_map(block_field)
    // rust: .or_else(|| {
    // rust: let state = field("blockToGrowOn")?.get("state")?.as_u64()?;
    // rust: (state < table.state_count() as u64).then(|| table.block(BlockStateId(state as u32)))
    // rust: });
    // rust: let link2 = ["attachedStem", "stem"].into_iter().find_map(block_field);
    // rust: let support_tag = ["stemSupportBlocks", "supportBlocks", "connectsTo"]
    // rust: .into_iter()
    // rust: .find_map(|k| field(k).and_then(Value::as_str))
    // rust: .and_then(tag);
    // rust: let support_tag2 = field("fruitSupportBlocks")
    // rust: .and_then(Value::as_str)
    // rust: .and_then(tag);
    // rust: let feature = field("feature")
    // rust: .and_then(Value::as_str)
    // rust: .or_else(|| {
    // rust: field("treeGrower")
    // rust: .and_then(|g| g.get("name"))
    // rust: .and_then(Value::as_str)
    // rust: })
    // rust: .map(|s| interned(&mut strings, s));
    // rust: let growth_direction = match field("growthDirection").and_then(Value::as_str) {
    // rust: Some("DOWN") => Direction::Down,
    // rust: _ => Direction::Up,
}
    // rust: let default = table.default_state(block);
    // rust: let sound = &gameplay_states[default.0 as usize];
    // rust: let sounds = Arc::new(Sounds {
    // rust: volume: sound.sound_number("volume") as f32,
    // rust: pitch: sound.sound_number("pitch") as f32,
    // rust: place: interned(&mut strings, sound.sound_id("place")),
    // rust: break_: interned(&mut strings, sound.sound_id("break")),
    // rust: fall: interned(&mut strings, sound.sound_id("fall")),
    // rust: });
    // rust: blocks.push(BlockData {
    // rust: class,
    // rust: chain,
    // rust: classes,
    // rust: interfaces,
    // rust: set_type,
    // rust: gate_open,
    // rust: gate_close,
    // rust: open_sound,
    // rust: close_sound,
    // rust: ticks_to_stay_pressed: field("ticksToStayPressed")
    // rust: .and_then(Value::as_i64)
    // rust: .unwrap_or(0) as i32,
    // rust: max_weight: field("maxWeight").and_then(Value::as_i64).unwrap_or(0) as i32,
    // rust: link,
    // rust: link2,
    // rust: support_tag,
    // rust: support_tag2,
    // rust: feature,
    // rust: grow_probability: field("growPerTickProbability")
    // rust: .and_then(Value::as_f64)
    // rust: .unwrap_or(0.0),
    // rust: growth_direction,
    // rust: schedule_fluid_ticks: field("scheduleFluidTicks")
    // rust: .and_then(Value::as_bool)
    // rust: .unwrap_or(false),
            // `WeatheringCopper.getAge`: copper golem statues name the field
            // `weatheringState`.
    // rust: weather: match field("weatherState")
    // rust: .or_else(|| field("weatheringState"))
    // rust: .and_then(Value::as_str)
    // rust: {
    // rust: Some("EXPOSED") => 1,
    // rust: Some("WEATHERED") => 2,
    // rust: Some("OXIDIZED") => 3,
    // rust: _ => 0,
    // rust: },
    // rust: ignite_odds: odds("igniteOdds", name),
    // rust: burn_odds: odds("burnOdds", name),
    // rust: sounds,
    // rust: item: interned(
    // rust: &mut strings,
    // rust: json["item"].as_str().unwrap_or("minecraft:air"),
    // rust: ),
    // rust: dynamic_shape: json["dynamic_shape"].as_bool().unwrap_or(false),
    // rust: });
}

    // Item bindings.
    // rust: let mut items = HashMap::new();
    // rust: for (item, binding) in behaviour["items"]
    // rust: .as_object()
    // rust: .ok_or_else(|| fail("missing item bindings"))?
    // rust: {
    // rust: let fields = &binding["fields"];
    // rust: let Some(block) = fields
    // rust: .get("block")
    // rust: .and_then(Value::as_str)
    // rust: .and_then(|n| table.block_by_name(n))
    // rust: else {
    // rust: continue;
}
    // rust: let classes: Vec<&str> = binding["class"]
    // rust: .as_array()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .filter_map(Value::as_str)
    // rust: .collect();
    // rust: let has = |name: &str| classes.contains(&name);
    // rust: let kind = if has("HangingSignItem") {
    // rust: ItemKind::HangingSign
    // rust: } else if has("StandingAndWallBlockItem") {
    // rust: ItemKind::StandingAndWall
    // rust: } else if has("DoubleHighBlockItem") {
    // rust: ItemKind::DoubleHigh
    // rust: } else if has("ScaffoldingBlockItem") {
    // rust: ItemKind::Scaffolding
    // rust: } else if has("PlaceOnWaterBlockItem") {
    // rust: ItemKind::PlaceOnWater
    // rust: } else if has("SolidBucketItem") {
    // rust: ItemKind::SolidBucket
    // rust: } else if has("BlockItem") {
    // rust: ItemKind::Block
    // rust: } else {
    // rust: ItemKind::Other
}
    // rust: items.insert(
    // rust: item.clone(),
    // rust: ItemBinding {
    // rust: block,
    // rust: wall_block: fields
    // rust: .get("wallBlock")
    // rust: .and_then(Value::as_str)
    // rust: .and_then(|n| table.block_by_name(n)),
    // rust: attachment: match fields.get("attachmentDirection").and_then(Value::as_str) {
    // rust: Some("UP") => Some(Direction::Up),
    // rust: Some("DOWN") => Some(Direction::Down),
    // rust: _ => None,
    // rust: },
    // rust: kind,
    // rust: game_master: has("GameMasterBlockItem"),
    // rust: },
    // rust: );
}

    // rust: let potted_by_content = potted_by_content(&blocks, &table);
    // rust: let liquid_blocks = FluidBlockBindings::new(registry)?;
    // rust: let mut dynamic = HashMap::new();
    // rust: for (id, fact) in facts.iter().enumerate() {
    // rust: if fact.shape < 0 {
    // rust: let state = BlockStateId(id as u32);
    // rust: if let Some(support) =
    // rust: crate::dynamic_support::DynamicSupport::from_state(registry.state(state).unwrap())?
    // rust: {
    // rust: dynamic.insert(state, support);
}
}
}
    // rust: Ok(Behaviours {
    // rust: table,
    // rust: props,
    // rust: named,
    // rust: tags,
    // rust: all_tags,
    // rust: facts,
    // rust: shapes,
    // rust: shape_info,
    // rust: fluid_tags,
    // rust: blocks,
    // rust: items,
    // rust: potted_by_content,
    // rust: liquid_blocks,
    // rust: dynamic,
    // rust: occlusion_cache: Default::default(),
    // rust: growth: Default::default(),
    // rust: })
}

    // rust: pub(super) fn potted_by_content(
    // rust: blocks: &[BlockData],
    // rust: table: &StateTable,
    // rust: ) -> HashMap<BlockId, BlockId> {
    // rust: let air = table.block_by_name("minecraft:air");
    // rust: let mut map = HashMap::new();
    // rust: for (index, block) in blocks.iter().enumerate() {
    // rust: if block.is(Class::FlowerPot)
    // rust: && let Some(potted) = block.link
    // rust: && Some(potted) != air
    // rust: {
    // rust: map.insert(potted, BlockId(index as u16));
}
}
    // rust: map
}

// `NoteBlockInstrument` serialized names in declaration order.
    // rust: pub const INSTRUMENTS: [&str; 27] = [
    // rust: "harp",
    // rust: "basedrum",
    // rust: "snare",
    // rust: "hat",
    // rust: "bass",
    // rust: "flute",
    // rust: "bell",
    // rust: "guitar",
    // rust: "chime",
    // rust: "xylophone",
    // rust: "iron_xylophone",
    // rust: "cow_bell",
    // rust: "didgeridoo",
    // rust: "bit",
    // rust: "banjo",
    // rust: "pling",
    // rust: "trumpet",
    // rust: "trumpet_exposed",
    // rust: "trumpet_oxidized",
    // rust: "trumpet_weathered",
    // rust: "zombie",
    // rust: "skeleton",
    // rust: "creeper",
    // rust: "dragon",
    // rust: "wither_skeleton",
    // rust: "piglin",
    // rust: "custom_head",
    // rust: ];
// `NoteBlockInstrument.worksAboveNoteBlock` (mob heads and custom heads).
instrument_works_above :: proc(index: u8) -> b {
    // Ported from Horizon
    return {}
}
    // rust: index >= 20
}
instrument_index :: proc(name: string) -> u {
    // Ported from Horizon
    return {}
}
    // rust: INSTRUMENTS
    // rust: .iter()
    // rust: .position(|n| n.eq_ignore_ascii_case(name))
    // rust: .map_or(0, |i| i as u8)
}

    // rust: impl GameplayStateSource for Value {
flag :: proc(self: ^Self, name: string) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.get(name).and_then(Value::as_bool).unwrap_or(false)
}
unsigned :: proc(self: ^Self, name: string) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.get(name).and_then(Value::as_u64).unwrap_or(0)
}
number :: proc(self: ^Self, name: string) -> f {
    // Ported from Horizon
    return {}
}
    // rust: self.get(name).and_then(Value::as_f64).unwrap_or(0.0)
}
text :: proc(self: ^Self, name: string) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: self.get(name).and_then(Value::as_str).unwrap_or("")
}
sound_number :: proc(self: ^Self, name: string) -> f {
    // Ported from Horizon
    return {}
}
    // rust: self.get("sound")
    // rust: .and_then(|s| s.get(name))
    // rust: .and_then(Value::as_f64)
    // rust: .unwrap_or(1.0)
}
sound_id :: proc(self: ^Self, name: string) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: self.get("sound")
    // rust: .and_then(|s| s.get(name))
    // rust: .and_then(|s| s.get("id"))
    // rust: .and_then(Value::as_str)
    // rust: .unwrap_or("")
}
}
