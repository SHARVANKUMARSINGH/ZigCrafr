//! Transpiled from Horizon Rust crate
//! Module: horizon-world_block_survival
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Initial block-survival rules over version-bound definitions and world queries.
//! Unsupported definitions remain explicit; survival is not inferred from shape.
// use crate::{
    // rust: block_collision::{BlockCollisionRegistry, CollisionQueryError, DynamicCollisionWorld},
    // rust: block_properties::{BlockPropertiesRegistry, BlockProperty, BoundBlockProperty},
    // rust: block_support::{BlockSupportRegistry, SupportQueryError, SupportType},
    // rust: compression::invalid,
    // rust: fluid::{FluidKind, FluidState},
    // rust: registry::{BlockRegistry, BlockStateId},
}
// use horizon_core::geometry::Direction;
// use std::{
    // rust: collections::{BTreeMap, BTreeSet},
    // rust: io,
    // rust: sync::Arc,
}
pub const SurvivalRule = enum {
    Fire,
    Cactus,
    Path,
    Mushroom,
    Multiface,
    Vine,
    HangingMoss,
    SnowLayer,
    SeaPickle,
    Bell,
    GrowingPlant,
    MangrovePropagule,
    Speleothem,
    Scaffolding,
    PistonHead,
    ChorusPlant,
    ChorusFlower,
    PitcherCrop,
    SugarCane,
    LilyPad,
    Frogspawn,
    SporeBlossom,
    SmallDripleaf,
    TallSeagrass,
    BigDripleaf,
    BigDripleafStem,
    Farmland,
    Cocoa,
    Crop,
    DoublePlant,
    Door,
    TagBelow(String),
    CactusFlower,
    Seagrass,
    BubbleColumn,
    RedstoneWire,
    Always,
    SolidBelow,
    SolidBehind,
    NonAirBelow,
    MossCarpet,
    CenterBelow,
    Lantern,
    FullAbove,
    FullBehind,
    RigidOrCenterBelow,
    RigidBelow,
    FullBelow,
    CenterAbove,
    FaceAttached,
    SupportsBamboo,
};
/// Version-specific definition inputs, independent of evaluated survival results.
pub const SurvivalDefinitions = struct {
    rules: BTreeMap<[]const u8,
    ignition_odds: BTreeMap<[]const u8,
    fence_gates: BTreeSet<[]const u8>,
};
pub const Rule = enum {
    Fire,
    Cactus,
    Path,
    Mushroom,
    Multiface(u8),
    Vine(u8),
    HangingMoss,
    SnowLayer,
    SeaPickle,
    GrowingPlant {,
    head: BlockStateId,
    body: BlockStateId,
    direction: Direction,
    kelp: bool,
    // rust: },
    MangrovePropagule(bool),
    Speleothem(Direction),
    Scaffolding,
    PistonHead {,
    direction: Direction,
    sticky: bool,
    // rust: },
    ChorusPlant,
    ChorusFlower,
    PitcherCrop(bool),
    SugarCane,
    LilyPad,
    Frogspawn,
    SporeBlossom,
    SmallDripleaf(bool),
    TallSeagrass(bool),
    BigDripleaf,
    BigDripleafStem,
    Farmland,
    Cocoa(Direction),
    Crop,
    DoublePlant(bool),
    Door(bool),
    TagBelow(usize),
    CactusFlower,
    Seagrass,
    BubbleColumn,
    RedstoneWire,
    Always,
    Solid(Direction),
    NonAirBelow,
    MossCarpet(bool),
    Support {,
    face: Direction,
    kind: SupportType,
    center_restriction: bool,
    // rust: },
    RigidOrCenterBelow,
    SupportsBamboo,
};
    // rust: pub trait SurvivalWorld: DynamicCollisionWorld {
pub fn fluid_state(self: *Self, position: [i32; 3]) R;
pub fn raw_brightness(self: *Self, position: [i32; 3], sky_darken: i32) R;
pub fn block_state(self: *Self, position: [i32; 3]) R;
}
pub const SurvivalError = enum {
    World(E),
    Support(SupportQueryError<E>),
    Collision(CollisionQueryError<E>),
    Registry(io::Error),
    Unsupported(BlockStateId),
};
    // rust: impl<E: std::fmt::Display> std::fmt::Display for SurvivalError<E> {
pub fn fmt(self: *Self, f: *mut std::fmt::Formatter<'_>) s {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::World(e) => e.fmt(f),
    // rust: Self::Support(e) => e.fmt(f),
    // rust: Self::Collision(e) => e.fmt(f),
    // rust: Self::Registry(e) => e.fmt(f),
    // rust: Self::Unsupported(id) => write!(f, "unsupported block survival state {}", id.0),
}
}
}
    // rust: impl<E: std::error::Error + 'static> std::error::Error for SurvivalError<E> {}
pub const BlockSurvivalRegistry = struct {
    registry: *'r BlockRegistry,
    support: *BlockSupportRegistry<'r>,
    collision: *BlockCollisionRegistry<'r>,
    solid: BoundBlockProperty,
    liquid: BoundBlockProperty,
    solid_render: BoundBlockProperty,
    flammable: BTreeSet<BlockStateId>,
    fence_gates: BTreeSet<BlockStateId>,
    cactus_support: BTreeSet<BlockStateId>,
    mushroom_light_override: BTreeSet<BlockStateId>,
    rules: std.ArrayList(?Rule),
    unstable_bottom_center: BTreeSet<BlockStateId>,
    supports_bamboo: BTreeSet<BlockStateId>,
    bound_tags: std.ArrayList(BTreeSet<BlockStateId)>,
    cactus_flower: BTreeSet<BlockStateId>,
    no_seagrass: BTreeSet<BlockStateId>,
    vegetation: BTreeSet<BlockStateId>,
    dripleaf: BTreeSet<BlockStateId>,
    maintains_farmland: BTreeSet<BlockStateId>,
    cocoa: BTreeSet<BlockStateId>,
    crops: BTreeSet<BlockStateId>,
    no_snow: BTreeSet<BlockStateId>,
    snow_override: BTreeSet<BlockStateId>,
    mangrove: BTreeSet<BlockStateId>,
    hanging_mangrove: BTreeSet<BlockStateId>,
    no_kelp: BTreeSet<BlockStateId>,
    chorus_plant: BTreeSet<BlockStateId>,
    chorus_flower: BTreeSet<BlockStateId>,
    lily_pad: BTreeSet<BlockStateId>,
    frogspawn: BTreeSet<BlockStateId>,
    small_dripleaf: BTreeSet<BlockStateId>,
    sugar_cane: BTreeSet<BlockStateId>,
    sugar_cane_adjacent: BTreeSet<BlockStateId>,
    fluid_tags: [u8,
    bubble_up: BTreeSet<BlockStateId>,
    bubble_down: BTreeSet<BlockStateId>,
};
    // rust: impl<'r> BlockSurvivalRegistry<'r> {
    // rust: pub fn new(
    // rust: registry: &'r BlockRegistry,
    // rust: properties: &BlockPropertiesRegistry<'r>,
    // rust: support: Arc<BlockSupportRegistry<'r>>,
    // rust: collision: Arc<BlockCollisionRegistry<'r>>,
    // rust: definitions: &SurvivalDefinitions,
    // rust: tags: &BTreeMap<String, Vec<String>>,
    // rust: fluid_tags: &BTreeMap<String, Vec<String>>,
    // rust: ) -> io::Result<Self> {
    // rust: if !std::ptr::eq(registry, properties.registry())
    // rust: || !std::ptr::eq(registry, support.registry())
    // rust: || !std::ptr::eq(registry, collision.registry())
    // rust: {
    // rust: return Err(invalid("survival inputs use different registries"));
}
    // rust: for name in definitions
    // rust: .rules
    // rust: .keys()
    // rust: .chain(definitions.ignition_odds.keys())
    // rust: .chain(definitions.fence_gates.iter())
    // rust: {
    // rust: if registry.default_state(name).is_none() {
    // rust: return Err(invalid("unknown block survival definition"));
}
}
    // rust: let mut rules = Vec::with_capacity(registry.len());
    // rust: let mut tag_names = Vec::<String>::new();
    // rust: let mut tag_indices = BTreeMap::<String, usize>::new();
    // rust: for id in 0..registry.len() {
    // rust: let state = registry.state(BlockStateId(id as u32)).unwrap();
    // rust: let Some(rule) = definitions.rules.get(&state.name) else {
    // rust: rules.push(None);
    // rust: continue;
}
    // rust: let property = |name: &str| {
    // rust: state
    // rust: .properties
    // rust: .get(name)
    // rust: .map(String::as_str)
    // rust: .ok_or_else(|| invalid("missing survival property"))
}
    // rust: let facing = || -> io::Result<Direction> {
    // rust: match property("facing")? {
    // rust: "down" => Ok(Direction::Down),
    // rust: "up" => Ok(Direction::Up),
    // rust: "north" => Ok(Direction::North),
    // rust: "south" => Ok(Direction::South),
    // rust: "west" => Ok(Direction::West),
    // rust: "east" => Ok(Direction::East),
    // rust: _ => Err(invalid("invalid survival facing")),
}
}
    // rust: let boolean = |name: &str| -> io::Result<bool> {
    // rust: match property(name)? {
    // rust: "true" => Ok(true),
    // rust: "false" => Ok(false),
    // rust: _ => Err(invalid("invalid survival boolean")),
}
}
    // rust: let upper_half = || -> io::Result<bool> {
    // rust: match property("half")? {
    // rust: "upper" => Ok(true),
    // rust: "lower" => Ok(false),
    // rust: _ => Err(invalid("invalid survival half")),
}
}
    // rust: let full = |face| Rule::Support {
    // rust: face,
    // rust: kind: SupportType::Full,
    // rust: center_restriction: false,
}
    // rust: let faces = || -> io::Result<u8> {
    // rust: let mut mask = 0;
    // rust: for direction in Direction::ALL {
    // rust: if state.properties.contains_key(direction_name(direction))
    // rust: && boolean(direction_name(direction))?
    // rust: {
    // rust: mask |= 1 << direction as u8;
}
}
    // rust: Ok(mask)
}
    // rust: rules.push(Some(match rule {
    // rust: SurvivalRule::Fire => Rule::Fire,
    // rust: SurvivalRule::Cactus => Rule::Cactus,
    // rust: SurvivalRule::Path => Rule::Path,
    // rust: SurvivalRule::Mushroom => Rule::Mushroom,
    // rust: SurvivalRule::Multiface => Rule::Multiface(faces()?),
    // rust: SurvivalRule::Vine => Rule::Vine(faces()?),
    // rust: SurvivalRule::HangingMoss => Rule::HangingMoss,
    // rust: SurvivalRule::SnowLayer => Rule::SnowLayer,
    // rust: SurvivalRule::SeaPickle => Rule::SeaPickle,
    // rust: SurvivalRule::Bell => {
    // rust: let (face, kind, center_restriction) = match property("attachment")? {
    // rust: "floor" => (Direction::Up, SupportType::Full, false),
    // rust: "ceiling" => (Direction::Down, SupportType::Center, true),
    // rust: "single_wall" | "double_wall" => {
    // rust: (facing()?.opposite(), SupportType::Full, false)
}
    // rust: _ => return Err(invalid("invalid bell attachment")),
}
    // rust: Rule::Support {
    // rust: face,
    // rust: kind,
    // rust: center_restriction,
}
}
    // rust: SurvivalRule::GrowingPlant => {
    // rust: let (head, body, direction, kelp) = match state.name.as_str() {
    // rust: "minecraft:kelp" | "minecraft:kelp_plant" => (
    // rust: "minecraft:kelp",
    // rust: "minecraft:kelp_plant",
    // rust: Direction::Up,
    // rust: true,
    // rust: ),
    // rust: "minecraft:cave_vines" | "minecraft:cave_vines_plant" => (
    // rust: "minecraft:cave_vines",
    // rust: "minecraft:cave_vines_plant",
    // rust: Direction::Down,
    // rust: false,
    // rust: ),
    // rust: "minecraft:twisting_vines" | "minecraft:twisting_vines_plant" => (
    // rust: "minecraft:twisting_vines",
    // rust: "minecraft:twisting_vines_plant",
    // rust: Direction::Up,
    // rust: false,
    // rust: ),
    // rust: "minecraft:weeping_vines" | "minecraft:weeping_vines_plant" => (
    // rust: "minecraft:weeping_vines",
    // rust: "minecraft:weeping_vines_plant",
    // rust: Direction::Down,
    // rust: false,
    // rust: ),
    // rust: _ => return Err(invalid("unknown growing plant family")),
}
    // rust: Rule::GrowingPlant {
    // rust: head: registry
    // rust: .default_state(head)
    // rust: .ok_or_else(|| invalid("missing growing plant head"))?,
    // rust: body: registry
    // rust: .default_state(body)
    // rust: .ok_or_else(|| invalid("missing growing plant body"))?,
    // rust: direction,
    // rust: kelp,
}
}
    // rust: SurvivalRule::MangrovePropagule => Rule::MangrovePropagule(boolean("hanging")?),
    // rust: SurvivalRule::Speleothem => {
    // rust: Rule::Speleothem(match property("vertical_direction")? {
    // rust: "up" => Direction::Up,
    // rust: "down" => Direction::Down,
    // rust: _ => return Err(invalid("invalid speleothem direction")),
    // rust: })
}
    // rust: SurvivalRule::Scaffolding => Rule::Scaffolding,
    // rust: SurvivalRule::PistonHead => Rule::PistonHead {
    // rust: direction: facing()?,
    // rust: sticky: match property("type")? {
    // rust: "normal" => false,
    // rust: "sticky" => true,
    // rust: _ => return Err(invalid("invalid piston head type")),
    // rust: },
    // rust: },
    // rust: SurvivalRule::ChorusPlant => Rule::ChorusPlant,
    // rust: SurvivalRule::ChorusFlower => Rule::ChorusFlower,
    // rust: SurvivalRule::PitcherCrop => Rule::PitcherCrop(upper_half()?),
    // rust: SurvivalRule::SugarCane => Rule::SugarCane,
    // rust: SurvivalRule::LilyPad => Rule::LilyPad,
    // rust: SurvivalRule::Frogspawn => Rule::Frogspawn,
    // rust: SurvivalRule::SporeBlossom => Rule::SporeBlossom,
    // rust: SurvivalRule::SmallDripleaf => Rule::SmallDripleaf(upper_half()?),
    // rust: SurvivalRule::TallSeagrass => Rule::TallSeagrass(upper_half()?),
    // rust: SurvivalRule::BigDripleaf => Rule::BigDripleaf,
    // rust: SurvivalRule::BigDripleafStem => Rule::BigDripleafStem,
    // rust: SurvivalRule::Farmland => Rule::Farmland,
    // rust: SurvivalRule::Cocoa => Rule::Cocoa(facing()?),
    // rust: SurvivalRule::Crop => Rule::Crop,
    // rust: SurvivalRule::DoublePlant => Rule::DoublePlant(upper_half()?),
    // rust: SurvivalRule::Door => Rule::Door(upper_half()?),
    // rust: SurvivalRule::TagBelow(name) => {
    // rust: Rule::TagBelow(*tag_indices.entry(name.clone()).or_insert_with(|| {
    // rust: let index = tag_names.len();
    // rust: tag_names.push(name.clone());
    // rust: index
    // rust: }))
}
    // rust: SurvivalRule::CactusFlower => Rule::CactusFlower,
    // rust: SurvivalRule::Seagrass => Rule::Seagrass,
    // rust: SurvivalRule::BubbleColumn => Rule::BubbleColumn,
    // rust: SurvivalRule::RedstoneWire => Rule::RedstoneWire,
    // rust: SurvivalRule::Always => Rule::Always,
    // rust: SurvivalRule::SolidBelow => Rule::Solid(Direction::Down),
    // rust: SurvivalRule::SolidBehind => Rule::Solid(facing()?.opposite()),
    // rust: SurvivalRule::NonAirBelow => Rule::NonAirBelow,
    // rust: SurvivalRule::MossCarpet => Rule::MossCarpet(boolean("bottom")?),
    // rust: SurvivalRule::CenterBelow => Rule::Support {
    // rust: face: Direction::Up,
    // rust: kind: SupportType::Center,
    // rust: center_restriction: true,
    // rust: },
    // rust: SurvivalRule::Lantern => Rule::Support {
    // rust: face: if boolean("hanging")? {
    // rust: Direction::Down
    // rust: } else {
    // rust: Direction::Up
    // rust: },
    // rust: kind: SupportType::Center,
    // rust: center_restriction: true,
    // rust: },
    // rust: SurvivalRule::FullAbove => full(Direction::Down),
    // rust: SurvivalRule::FullBehind => full(facing()?),
    // rust: SurvivalRule::RigidOrCenterBelow => Rule::RigidOrCenterBelow,
    // rust: SurvivalRule::RigidBelow => Rule::Support {
    // rust: face: Direction::Up,
    // rust: kind: SupportType::Rigid,
    // rust: center_restriction: false,
    // rust: },
    // rust: SurvivalRule::FullBelow => full(Direction::Up),
    // rust: SurvivalRule::CenterAbove => Rule::Support {
    // rust: face: Direction::Down,
    // rust: kind: SupportType::Center,
    // rust: center_restriction: false,
    // rust: },
    // rust: SurvivalRule::FaceAttached => full(match property("face")? {
    // rust: "floor" => Direction::Up,
    // rust: "ceiling" => Direction::Down,
    // rust: "wall" => facing()?,
    // rust: _ => return Err(invalid("invalid attachment face")),
    // rust: }),
    // rust: SurvivalRule::SupportsBamboo => Rule::SupportsBamboo,
    // rust: }));
}
    // rust: let tag_states = |name: &str| -> io::Result<BTreeSet<BlockStateId>> {
    // rust: let names = tags
    // rust: .get(name)
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .collect::<BTreeSet<_>>();
    // rust: for name in &names {
    // rust: if registry.default_state(name).is_none() {
    // rust: return Err(invalid("unknown survival tag member"));
}
}
    // rust: Ok((0..registry.len())
    // rust: .map(|i| BlockStateId(i as u32))
    // rust: .filter(|id| names.contains(&registry.state(*id).unwrap().name))
    // rust: .collect())
}
    // rust: let fluid_tag = |name: &str| -> io::Result<u8> {
    // rust: fluid_tags
    // rust: .get(name)
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .try_fold(0, |mask, name| {
    // rust: Ok(mask
    // rust: | FluidKind::from_name(name)
    // rust: .ok_or_else(|| invalid("unknown survival fluid tag member"))?
    // rust: .mask())
    // rust: })
}
    // rust: Ok(Self {
    // rust: registry,
    // rust: support,
    // rust: collision,
    // rust: solid: properties.bind(BlockProperty::Solid),
    // rust: liquid: properties.bind(BlockProperty::Liquid),
    // rust: solid_render: properties.bind(BlockProperty::SolidRender),
    // rust: flammable: (0..registry.len())
    // rust: .map(|i| BlockStateId(i as u32))
    // rust: .filter(|id| {
    // rust: let state = registry.state(*id).unwrap();
    // rust: definitions
    // rust: .ignition_odds
    // rust: .get(&state.name)
    // rust: .is_some_and(|value| *value > 0)
    // rust: && state
    // rust: .properties
    // rust: .get("waterlogged")
    // rust: .is_none_or(|value| value != "true")
    // rust: })
    // rust: .collect(),
    // rust: fence_gates: (0..registry.len())
    // rust: .map(|i| BlockStateId(i as u32))
    // rust: .filter(|id| {
    // rust: definitions
    // rust: .fence_gates
    // rust: .contains(&registry.state(*id).unwrap().name)
    // rust: })
    // rust: .collect(),
    // rust: cactus_support: tag_states("minecraft:supports_cactus")?,
    // rust: mushroom_light_override: tag_states("minecraft:overrides_mushroom_light_requirement")?,
    // rust: rules,
    // rust: unstable_bottom_center: tag_states("minecraft:unstable_bottom_center")?,
    // rust: supports_bamboo: tag_states("minecraft:supports_bamboo")?,
    // rust: bound_tags: tag_names
    // rust: .iter()
    // rust: .map(|name| tag_states(name))
    // rust: .collect::<io::Result<_>>()?,
    // rust: cactus_flower: tag_states("minecraft:support_override_cactus_flower")?,
    // rust: no_seagrass: tag_states("minecraft:cannot_support_seagrass")?,
    // rust: vegetation: tag_states("minecraft:supports_vegetation")?,
    // rust: dripleaf: tag_states("minecraft:supports_big_dripleaf")?,
    // rust: maintains_farmland: tag_states("minecraft:maintains_farmland")?,
    // rust: cocoa: tag_states("minecraft:supports_cocoa")?,
    // rust: crops: tag_states("minecraft:supports_crops")?,
    // rust: no_snow: tag_states("minecraft:cannot_support_snow_layer")?,
    // rust: snow_override: tag_states("minecraft:support_override_snow_layer")?,
    // rust: mangrove: tag_states("minecraft:supports_mangrove_propagule")?,
    // rust: hanging_mangrove: tag_states("minecraft:supports_hanging_mangrove_propagule")?,
    // rust: no_kelp: tag_states("minecraft:cannot_support_kelp")?,
    // rust: chorus_plant: tag_states("minecraft:supports_chorus_plant")?,
    // rust: chorus_flower: tag_states("minecraft:supports_chorus_flower")?,
    // rust: lily_pad: tag_states("minecraft:supports_lily_pad")?,
    // rust: frogspawn: tag_states("minecraft:supports_frogspawn")?,
    // rust: small_dripleaf: tag_states("minecraft:supports_small_dripleaf")?,
    // rust: sugar_cane: tag_states("minecraft:supports_sugar_cane")?,
    // rust: sugar_cane_adjacent: tag_states("minecraft:supports_sugar_cane_adjacently")?,
    // rust: fluid_tags: [
    // rust: fluid_tag("minecraft:water")?,
    // rust: fluid_tag("minecraft:supports_lily_pad")?,
    // rust: fluid_tag("minecraft:supports_frogspawn")?,
    // rust: fluid_tag("minecraft:supports_sugar_cane_adjacently")?,
    // rust: fluid_tag("minecraft:lava")?,
    // rust: ],
    // rust: bubble_up: tag_states("minecraft:enables_bubble_column_push_up")?,
    // rust: bubble_down: tag_states("minecraft:enables_bubble_column_drag_down")?,
    // rust: })
}
    // rust: fn read<W: SurvivalWorld>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: position: [i32; 3],
    // rust: ) -> Result<BlockStateId, SurvivalError<W::Error>> {
    // rust: let state = world.block_state(position).map_err(SurvivalError::World)?;
    // rust: if self.registry.state(state).is_none() {
    // rust: return Err(SurvivalError::Registry(invalid(
    // rust: "world survival state outside registry",
    // rust: )));
}
    // rust: Ok(state)
}
    // rust: fn support<W: SurvivalWorld>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: position: [i32; 3],
    // rust: face: Direction,
    // rust: kind: SupportType,
    // rust: center_restriction: bool,
    // rust: ) -> Result<bool, SurvivalError<W::Error>> {
    // rust: let state = self.read(world, position)?;
    // rust: if center_restriction
    // rust: && face == Direction::Down
    // rust: && self.unstable_bottom_center.contains(&state)
    // rust: {
    // rust: return Ok(false);
}
    // rust: self.support
    // rust: .is_face_sturdy(world, state, position, face, kind)
    // rust: .map_err(SurvivalError::Support)
}
pub fn is_air(self: *Self, state: BlockStateId) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: matches!(
    // rust: self.registry.state(state).unwrap().name.as_str(),
    // rust: "minecraft:air" | "minecraft:cave_air" | "minecraft:void_air"
    // rust: )
}
pub fn face_property(self: *Self, state: BlockStateId, direction: Direction) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.registry
    // rust: .state(state)
    // rust: .unwrap()
    // rust: .properties
    // rust: .get(direction_name(direction))
    // rust: .is_some_and(|value| value == "true")
}
    /// Native multiface attachment at a candidate position, testing support
    /// first and then empty-context collision on the neighbor's opposite face.
    // rust: pub fn can_attach_to<W: SurvivalWorld>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: position: [i32; 3],
    // rust: direction: Direction,
    // rust: ) -> Result<bool, SurvivalError<W::Error>> {
    // rust: let step = direction.normal();
    // rust: let at = std::array::from_fn(|i| position[i].wrapping_add(step[i]));
    // rust: let neighbor = self.read(world, at)?;
    // rust: self.can_attach(world, neighbor, at, direction)
}
    // rust: fn can_attach<W: SurvivalWorld>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: neighbor: BlockStateId,
    // rust: at: [i32; 3],
    // rust: direction: Direction,
    // rust: ) -> Result<bool, SurvivalError<W::Error>> {
    // rust: let face = direction.opposite();
    // rust: if self
    // rust: .support
    // rust: .is_face_sturdy(world, neighbor, at, face, SupportType::Full)
    // rust: .map_err(SurvivalError::Support)?
    // rust: {
    // rust: return Ok(true);
}
    // rust: let shape = self
    // rust: .collision
    // rust: .collision_shape(world, neighbor, at)
    // rust: .map_err(SurvivalError::Collision)?;
    // rust: SupportType::Full
    // rust: .is_supporting(&shape, face)
    // rust: .map_err(|error| SurvivalError::Registry(invalid(error.to_string())))
}
pub fn is_named(self: *Self, state: BlockStateId, name: []const u8) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.registry.state(state).unwrap().name == name
}
pub fn same_block(self: *Self, first: BlockStateId, second: BlockStateId) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.registry.state(first).unwrap().name == self.registry.state(second).unwrap().name
}
pub fn scaffold_distance(self: *Self, state: BlockStateId) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !self.is_named(state, "minecraft:scaffolding") {
    // rust: return Ok(None);
}
    // rust: self.registry
    // rust: .state(state)
    // rust: .unwrap()
    // rust: .properties
    // rust: .get("distance")
    // rust: .and_then(|v| v.parse::<i32>().ok())
    // rust: .filter(|v| (0..=7).contains(v))
    // rust: .map(Some)
    // rust: .ok_or_else(|| invalid("invalid scaffolding distance"))
}
pub fn is_lower_half(self: *Self, below: BlockStateId, candidate: BlockStateId) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let neighbor = self.registry.state(below).unwrap();
    // rust: neighbor.name == self.registry.state(candidate).unwrap().name
    // rust: && neighbor
    // rust: .properties
    // rust: .get("half")
    // rust: .is_some_and(|v| v == "lower")
}
pub fn fluid_matches(self: *Self, tag: usize, fluid: FluidState) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.fluid_tags[tag] & fluid.kind().mask() != 0
}
    // rust: pub fn can_survive<W: SurvivalWorld>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: state: BlockStateId,
    // rust: position: [i32; 3],
    // rust: ) -> Result<bool, SurvivalError<W::Error>> {
    // rust: let rule = self
    // rust: .rules
    // rust: .get(state.0 as usize)
    // rust: .ok_or_else(|| SurvivalError::Registry(invalid("survival candidate outside registry")))?
    // rust: .ok_or(SurvivalError::Unsupported(state))?;
    // rust: match rule {
    // rust: Rule::Fire => {
    // rust: let below = relative(position, Direction::Down);
    // rust: let neighbor = self.read(world, below)?;
    // rust: if self
    // rust: .support
    // rust: .is_face_sturdy(world, neighbor, below, Direction::Up, SupportType::Full)
    // rust: .map_err(SurvivalError::Support)?
    // rust: {
    // rust: return Ok(true);
}
    // rust: for direction in Direction::ALL {
    // rust: let neighbor = self.read(world, relative(position, direction))?;
    // rust: if self.flammable.contains(&neighbor) {
    // rust: return Ok(true);
}
}
    // rust: Ok(false)
}
    // rust: Rule::Cactus => {
    // rust: for direction in [
    // rust: Direction::North,
    // rust: Direction::East,
    // rust: Direction::South,
    // rust: Direction::West,
    // rust: ] {
    // rust: let at = relative(position, direction);
    // rust: let neighbor = self.read(world, at)?;
    // rust: if self.solid.contains(neighbor)
    // rust: || self
    // rust: .fluid_matches(4, world.fluid_state(at).map_err(SurvivalError::World)?)
    // rust: {
    // rust: return Ok(false);
}
}
    // rust: let neighbor = self.read(world, relative(position, Direction::Down))?;
    // rust: if !self.same_block(neighbor, state) && !self.cactus_support.contains(&neighbor) {
    // rust: return Ok(false);
}
    // rust: let above = self.read(world, relative(position, Direction::Up))?;
    // rust: Ok(!self.liquid.contains(above))
}
    // rust: Rule::Path => {
    // rust: let above = self.read(world, relative(position, Direction::Up))?;
    // rust: Ok(!self.solid.contains(above) || self.fence_gates.contains(&above))
}
    // rust: Rule::Mushroom => {
    // rust: let below = self.read(world, relative(position, Direction::Down))?;
    // rust: if self.mushroom_light_override.contains(&below) {
    // rust: return Ok(true);
}
    // rust: Ok(world
    // rust: .raw_brightness(position, 0)
    // rust: .map_err(SurvivalError::World)?
    // rust: < 13
    // rust: && self.solid_render.contains(below))
}
    // rust: Rule::Multiface(faces) => {
    // rust: for direction in Direction::ALL {
    // rust: if faces & (1 << direction as u8) != 0 {
    // rust: let at = relative(position, direction);
    // rust: let neighbor = self.read(world, at)?;
    // rust: if !self.can_attach(world, neighbor, at, direction)? {
    // rust: return Ok(false);
}
}
}
    // rust: Ok(faces != 0)
}
    // rust: Rule::HangingMoss => {
    // rust: let at = relative(position, Direction::Up);
    // rust: let neighbor = self.read(world, at)?;
    // rust: Ok(self.can_attach(world, neighbor, at, Direction::Up)?
    // rust: || self.same_block(neighbor, state))
}
    // rust: Rule::Vine(faces) => {
    // rust: let above = relative(position, Direction::Up);
    // rust: let mut any = false;
    // rust: let mut cached_above = None;
    // rust: if faces & (1 << Direction::Up as u8) != 0 {
    // rust: let neighbor = self.read(world, above)?;
                    // getUpdatedState passes DOWN here, unlike canSupportAtFace.
    // rust: any = self.can_attach(world, neighbor, above, Direction::Down)?;
}
    // rust: for direction in [
    // rust: Direction::North,
    // rust: Direction::East,
    // rust: Direction::South,
    // rust: Direction::West,
    // rust: ] {
    // rust: if faces & (1 << direction as u8) == 0 {
    // rust: continue;
}
    // rust: let at = relative(position, direction);
    // rust: let neighbor = self.read(world, at)?;
    // rust: let mut valid = self.can_attach(world, neighbor, at, direction)?;
    // rust: if !valid {
    // rust: let neighbor = self.read(world, above)?;
    // rust: valid = self.same_block(neighbor, state)
    // rust: && self.face_property(neighbor, direction);
}
    // rust: if !valid {
    // rust: let neighbor = match cached_above {
    // rust: Some(neighbor) => neighbor,
    // rust: None => {
    // rust: let neighbor = self.read(world, above)?;
    // rust: cached_above = Some(neighbor);
    // rust: neighbor
}
}
    // rust: valid = self.same_block(neighbor, state)
    // rust: && self.face_property(neighbor, direction);
}
    // rust: any |= valid;
}
    // rust: Ok(any)
}
    // rust: Rule::SnowLayer => {
    // rust: let at = relative(position, Direction::Down);
    // rust: let neighbor = self.read(world, at)?;
    // rust: if self.no_snow.contains(&neighbor) {
    // rust: return Ok(false);
}
    // rust: if self.snow_override.contains(&neighbor) {
    // rust: return Ok(true);
}
    // rust: let shape = self
    // rust: .collision
    // rust: .collision_shape(world, neighbor, at)
    // rust: .map_err(SurvivalError::Collision)?;
    // rust: Ok(SupportType::Full
    // rust: .is_supporting(&shape, Direction::Up)
    // rust: .map_err(|error| SurvivalError::Registry(invalid(error.to_string())))?
    // rust: || (self.same_block(neighbor, state)
    // rust: && self
    // rust: .registry
    // rust: .state(neighbor)
    // rust: .unwrap()
    // rust: .properties
    // rust: .get("layers")
    // rust: .is_some_and(|value| value == "8")))
}
    // rust: Rule::SeaPickle => {
    // rust: let at = relative(position, Direction::Down);
    // rust: let neighbor = self.read(world, at)?;
    // rust: let shape = self
    // rust: .collision
    // rust: .collision_shape(world, neighbor, at)
    // rust: .map_err(SurvivalError::Collision)?;
    // rust: Ok(!shape
    // rust: .face_shape(Direction::Up)
    // rust: .map_err(|error| SurvivalError::Registry(invalid(error.to_string())))?
    // rust: .is_empty()
    // rust: || self
    // rust: .support
    // rust: .is_face_sturdy(world, neighbor, at, Direction::Up, SupportType::Full)
    // rust: .map_err(SurvivalError::Support)?)
}
    // rust: Rule::GrowingPlant {
    // rust: head,
    // rust: body,
    // rust: direction,
    // rust: kelp,
    // rust: } => {
    // rust: let at = relative(position, direction.opposite());
    // rust: let neighbor = self.read(world, at)?;
    // rust: if kelp && self.no_kelp.contains(&neighbor) {
    // rust: return Ok(false);
}
    // rust: Ok(self.same_block(neighbor, head)
    // rust: || self.same_block(neighbor, body)
    // rust: || self
    // rust: .support
    // rust: .is_face_sturdy(world, neighbor, at, direction, SupportType::Full)
    // rust: .map_err(SurvivalError::Support)?)
}
    // rust: Rule::MangrovePropagule(hanging) => {
    // rust: let neighbor = self.read(
    // rust: world,
    // rust: relative(
    // rust: position,
    // rust: if hanging {
    // rust: Direction::Up
    // rust: } else {
    // rust: Direction::Down
    // rust: },
    // rust: ),
    // rust: )?;
    // rust: Ok(if hanging {
    // rust: self.hanging_mangrove.contains(&neighbor)
    // rust: } else {
    // rust: self.mangrove.contains(&neighbor)
    // rust: })
}
    // rust: Rule::Speleothem(direction) => {
    // rust: let at = relative(position, direction.opposite());
    // rust: let neighbor = self.read(world, at)?;
    // rust: Ok(self
    // rust: .support
    // rust: .is_face_sturdy(world, neighbor, at, direction, SupportType::Full)
    // rust: .map_err(SurvivalError::Support)?
    // rust: || (self.same_block(neighbor, state)
    // rust: && self
    // rust: .registry
    // rust: .state(neighbor)
    // rust: .unwrap()
    // rust: .properties
    // rust: .get("vertical_direction")
    // rust: == self
    // rust: .registry
    // rust: .state(state)
    // rust: .unwrap()
    // rust: .properties
    // rust: .get("vertical_direction")))
}
    // rust: Rule::Scaffolding => {
    // rust: let below = relative(position, Direction::Down);
    // rust: let neighbor = self.read(world, below)?;
    // rust: let mut distance = if let Some(distance) = self
    // rust: .scaffold_distance(neighbor)
    // rust: .map_err(SurvivalError::Registry)?
    // rust: {
    // rust: distance
    // rust: } else {
    // rust: if self
    // rust: .support
    // rust: .is_face_sturdy(world, neighbor, below, Direction::Up, SupportType::Full)
    // rust: .map_err(SurvivalError::Support)?
    // rust: {
    // rust: return Ok(true);
}
    // rust: 7
}
    // rust: for direction in [
    // rust: Direction::North,
    // rust: Direction::East,
    // rust: Direction::South,
    // rust: Direction::West,
    // rust: ] {
    // rust: let neighbor = self.read(world, relative(position, direction))?;
    // rust: if let Some(adjacent) = self
    // rust: .scaffold_distance(neighbor)
    // rust: .map_err(SurvivalError::Registry)?
    // rust: {
    // rust: distance = distance.min(adjacent + 1);
    // rust: if distance == 1 {
    // rust: break;
}
}
}
    // rust: Ok(distance < 7)
}
    // rust: Rule::PistonHead { direction, sticky } => {
    // rust: let neighbor = self.read(world, relative(position, direction.opposite()))?;
    // rust: let definition = self.registry.state(neighbor).unwrap();
    // rust: let base = if sticky {
    // rust: "minecraft:sticky_piston"
    // rust: } else {
    // rust: "minecraft:piston"
}
    // rust: Ok(((definition.name == base
    // rust: && definition
    // rust: .properties
    // rust: .get("extended")
    // rust: .is_some_and(|v| v == "true"))
    // rust: || definition.name == "minecraft:moving_piston")
    // rust: && definition.properties.get("facing")
    // rust: == self.registry.state(state).unwrap().properties.get("facing"))
}
    // rust: Rule::ChorusPlant => {
    // rust: let below = self.read(world, relative(position, Direction::Down))?;
    // rust: let above = self.read(world, relative(position, Direction::Up))?;
    // rust: let crowded = !self.is_air(above) && !self.is_air(below);
    // rust: for direction in [
    // rust: Direction::North,
    // rust: Direction::East,
    // rust: Direction::South,
    // rust: Direction::West,
    // rust: ] {
    // rust: let at = relative(position, direction);
    // rust: let neighbor = self.read(world, at)?;
    // rust: if self.same_block(neighbor, state) {
    // rust: if crowded {
    // rust: return Ok(false);
}
    // rust: let support = self.read(world, relative(at, Direction::Down))?;
    // rust: if self.same_block(support, state) || self.chorus_plant.contains(&support) {
    // rust: return Ok(true);
}
}
}
    // rust: Ok(self.same_block(below, state) || self.chorus_plant.contains(&below))
}
    // rust: Rule::ChorusFlower => {
    // rust: let below = self.read(world, relative(position, Direction::Down))?;
    // rust: if self.is_named(below, "minecraft:chorus_plant")
    // rust: || self.chorus_flower.contains(&below)
    // rust: {
    // rust: return Ok(true);
}
    // rust: if !self.is_air(below) {
    // rust: return Ok(false);
}
    // rust: let mut found = false;
    // rust: for direction in [
    // rust: Direction::North,
    // rust: Direction::East,
    // rust: Direction::South,
    // rust: Direction::West,
    // rust: ] {
    // rust: let neighbor = self.read(world, relative(position, direction))?;
    // rust: if self.is_named(neighbor, "minecraft:chorus_plant") {
    // rust: if found {
    // rust: return Ok(false);
}
    // rust: found = true;
    // rust: } else if !self.is_air(neighbor) {
    // rust: return Ok(false);
}
}
    // rust: Ok(found)
}
    // rust: Rule::PitcherCrop(upper) => {
    // rust: if !upper
    // rust: && world
    // rust: .raw_brightness(position, 0)
    // rust: .map_err(SurvivalError::World)?
    // rust: < 8
    // rust: {
    // rust: return Ok(false);
}
    // rust: let below = self.read(world, relative(position, Direction::Down))?;
    // rust: Ok(if upper {
    // rust: self.is_lower_half(below, state)
    // rust: } else {
    // rust: self.crops.contains(&below)
    // rust: })
}
    // rust: Rule::SugarCane => {
    // rust: let below = relative(position, Direction::Down);
    // rust: let neighbor = self.read(world, below)?;
    // rust: if self.registry.state(neighbor).unwrap().name
    // rust: == self.registry.state(state).unwrap().name
    // rust: {
    // rust: return Ok(true);
}
    // rust: if !self.sugar_cane.contains(&neighbor) {
    // rust: return Ok(false);
}
    // rust: for direction in [
    // rust: Direction::North,
    // rust: Direction::East,
    // rust: Direction::South,
    // rust: Direction::West,
    // rust: ] {
    // rust: let at = relative(below, direction);
    // rust: let adjacent = self.read(world, at)?;
    // rust: let fluid = world.fluid_state(at).map_err(SurvivalError::World)?;
    // rust: if self.fluid_matches(3, fluid) || self.sugar_cane_adjacent.contains(&adjacent)
    // rust: {
    // rust: return Ok(true);
}
}
    // rust: Ok(false)
}
    // rust: Rule::LilyPad => {
    // rust: let below = relative(position, Direction::Down);
    // rust: let neighbor = self.read(world, below)?;
    // rust: let fluid_below = world.fluid_state(below).map_err(SurvivalError::World)?;
    // rust: let fluid_here = world.fluid_state(position).map_err(SurvivalError::World)?;
    // rust: Ok(
    // rust: (self.fluid_matches(1, fluid_below) || self.lily_pad.contains(&neighbor))
    // rust: && fluid_here.kind() == FluidKind::Empty,
    // rust: )
}
    // rust: Rule::Frogspawn => {
    // rust: let below = relative(position, Direction::Down);
    // rust: let fluid_below = world.fluid_state(below).map_err(SurvivalError::World)?;
    // rust: let fluid_here = world.fluid_state(position).map_err(SurvivalError::World)?;
    // rust: Ok((self.fluid_matches(2, fluid_below)
    // rust: || self.frogspawn.contains(&self.read(world, below)?))
    // rust: && fluid_here.kind() == FluidKind::Empty)
}
    // rust: Rule::SporeBlossom => Ok(self.support(
    // rust: world,
    // rust: relative(position, Direction::Up),
    // rust: Direction::Down,
    // rust: SupportType::Center,
    // rust: true,
    // rust: )? && !self.fluid_matches(
    // rust: 0,
    // rust: world.fluid_state(position).map_err(SurvivalError::World)?,
    // rust: )),
    // rust: Rule::SmallDripleaf(upper) => {
    // rust: let neighbor = self.read(world, relative(position, Direction::Down))?;
    // rust: if upper {
    // rust: return Ok(self.is_lower_half(neighbor, state));
}
    // rust: Ok(self.small_dripleaf.contains(&neighbor)
    // rust: || (world
    // rust: .fluid_state(position)
    // rust: .map_err(SurvivalError::World)?
    // rust: .kind()
    // rust: == FluidKind::Water
    // rust: && self.vegetation.contains(&neighbor)))
}
    // rust: Rule::TallSeagrass(upper) => {
    // rust: let below = relative(position, Direction::Down);
    // rust: if upper {
    // rust: return Ok(self.is_lower_half(self.read(world, below)?, state));
}
    // rust: let fluid = world.fluid_state(position).map_err(SurvivalError::World)?;
    // rust: let neighbor = self.read(world, below)?;
    // rust: Ok(self
    // rust: .support
    // rust: .is_face_sturdy(world, neighbor, below, Direction::Up, SupportType::Full)
    // rust: .map_err(SurvivalError::Support)?
    // rust: && !self.no_seagrass.contains(&neighbor)
    // rust: && self.fluid_matches(0, fluid)
    // rust: && fluid.is_full())
}
    // rust: Rule::BigDripleaf => {
    // rust: let below = self.read(world, relative(position, Direction::Down))?;
    // rust: Ok(matches!(
    // rust: self.registry.state(below).unwrap().name.as_str(),
    // rust: "minecraft:big_dripleaf" | "minecraft:big_dripleaf_stem"
    // rust: ) || self.dripleaf.contains(&below))
}
    // rust: Rule::BigDripleafStem => {
    // rust: let below = self.read(world, relative(position, Direction::Down))?;
    // rust: let above = self.read(world, relative(position, Direction::Up))?;
    // rust: Ok(
    // rust: (self.registry.state(below).unwrap().name == "minecraft:big_dripleaf_stem"
    // rust: || self.dripleaf.contains(&below))
    // rust: && matches!(
    // rust: self.registry.state(above).unwrap().name.as_str(),
    // rust: "minecraft:big_dripleaf" | "minecraft:big_dripleaf_stem"
    // rust: ),
    // rust: )
}
    // rust: Rule::Farmland => {
    // rust: let above = relative(position, Direction::Up);
    // rust: Ok(!self.solid.contains(self.read(world, above)?)
    // rust: || self.maintains_farmland.contains(&self.read(world, above)?))
}
    // rust: Rule::Cocoa(direction) => Ok(self
    // rust: .cocoa
    // rust: .contains(&self.read(world, relative(position, direction))?)),
    // rust: Rule::Crop => Ok(world
    // rust: .raw_brightness(position, 0)
    // rust: .map_err(SurvivalError::World)?
    // rust: >= 8
    // rust: && self
    // rust: .crops
    // rust: .contains(&self.read(world, relative(position, Direction::Down))?)),
    // rust: Rule::DoublePlant(upper) => {
    // rust: let below = self.read(world, relative(position, Direction::Down))?;
    // rust: if !upper {
    // rust: return Ok(self.vegetation.contains(&below));
}
    // rust: let neighbor = self.registry.state(below).unwrap();
    // rust: Ok(neighbor.name == self.registry.state(state).unwrap().name
    // rust: && neighbor
    // rust: .properties
    // rust: .get("half")
    // rust: .is_some_and(|v| v == "lower"))
}
    // rust: Rule::Door(upper) => {
    // rust: let below = relative(position, Direction::Down);
    // rust: let neighbor = self.read(world, below)?;
    // rust: if upper {
    // rust: return Ok(self.registry.state(neighbor).unwrap().name
    // rust: == self.registry.state(state).unwrap().name);
}
    // rust: self.support
    // rust: .is_face_sturdy(world, neighbor, below, Direction::Up, SupportType::Full)
    // rust: .map_err(SurvivalError::Support)
}
    // rust: Rule::TagBelow(index) => Ok(self.bound_tags[index]
    // rust: .contains(&self.read(world, relative(position, Direction::Down))?)),
    // rust: Rule::CactusFlower => {
    // rust: let below = relative(position, Direction::Down);
    // rust: self.read(world, below)?;
    // rust: let neighbor = self.read(world, below)?;
    // rust: Ok(self.cactus_flower.contains(&neighbor)
    // rust: || self
    // rust: .support
    // rust: .is_face_sturdy(world, neighbor, below, Direction::Up, SupportType::Center)
    // rust: .map_err(SurvivalError::Support)?)
}
    // rust: Rule::Seagrass => {
    // rust: let below = relative(position, Direction::Down);
    // rust: let neighbor = self.read(world, below)?;
    // rust: Ok(self
    // rust: .support
    // rust: .is_face_sturdy(world, neighbor, below, Direction::Up, SupportType::Full)
    // rust: .map_err(SurvivalError::Support)?
    // rust: && !self.no_seagrass.contains(&neighbor))
}
    // rust: Rule::BubbleColumn => {
    // rust: let below = self.read(world, relative(position, Direction::Down))?;
    // rust: Ok(self.registry.state(below).unwrap().name
    // rust: == self.registry.state(state).unwrap().name
    // rust: || self.bubble_up.contains(&below)
    // rust: || self.bubble_down.contains(&below))
}
    // rust: Rule::RedstoneWire => {
    // rust: let below = relative(position, Direction::Down);
    // rust: let neighbor = self.read(world, below)?;
    // rust: Ok(self
    // rust: .support
    // rust: .is_face_sturdy(world, neighbor, below, Direction::Up, SupportType::Full)
    // rust: .map_err(SurvivalError::Support)?
    // rust: || self.registry.state(neighbor).unwrap().name == "minecraft:hopper")
}
    // rust: Rule::Always => Ok(true),
    // rust: Rule::Solid(direction) => Ok(self
    // rust: .solid
    // rust: .contains(self.read(world, relative(position, direction))?)),
    // rust: Rule::NonAirBelow => {
    // rust: Ok(!self.is_air(self.read(world, relative(position, Direction::Down))?))
}
    // rust: Rule::MossCarpet(base) => {
    // rust: let below = self.read(world, relative(position, Direction::Down))?;
    // rust: if base {
    // rust: return Ok(!self.is_air(below));
}
    // rust: let below = self.registry.state(below).unwrap();
    // rust: Ok(below.name == self.registry.state(state).unwrap().name
    // rust: && below.properties.get("bottom").is_some_and(|v| v == "true"))
}
    // rust: Rule::Support {
    // rust: face,
    // rust: kind,
    // rust: center_restriction,
    // rust: } => self.support(
    // rust: world,
    // rust: relative(position, face.opposite()),
    // rust: face,
    // rust: kind,
    // rust: center_restriction,
    // rust: ),
    // rust: Rule::RigidOrCenterBelow => {
    // rust: let below = relative(position, Direction::Down);
    // rust: Ok(
    // rust: self.support(world, below, Direction::Up, SupportType::Rigid, false)?
    // rust: || self.support(world, below, Direction::Up, SupportType::Center, true)?,
    // rust: )
}
    // rust: Rule::SupportsBamboo => Ok(self
    // rust: .supports_bamboo
    // rust: .contains(&self.read(world, relative(position, Direction::Down))?)),
}
}
}
pub fn relative(position: [i32; 3], direction: Direction) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let normal = direction.normal();
    // rust: std::array::from_fn(|i| position[i].wrapping_add(normal[i]))
}

pub fn direction_name(direction: Direction) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match direction {
    // rust: Direction::Down => "down",
    // rust: Direction::Up => "up",
    // rust: Direction::North => "north",
    // rust: Direction::South => "south",
    // rust: Direction::West => "west",
    // rust: Direction::East => "east",
}
}
