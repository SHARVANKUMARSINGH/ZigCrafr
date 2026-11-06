//! Transpiled from Horizon Rust crate
//! Module: horizon-world_legacy
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Piece-based ("legacy") structure support: the StructurePiece helpers,
//! object-safe world/random access and template pieces.
// use super::{
    // rust: BlockInfo, BoundingBox, Mirror, Rotation, StructureResources, StructureTemplate,
    // rust: processor::{PlaceSettings, Processor, ProcessorList, ProcessorRandom, place_in_world},
}
// use crate::{
    // rust: chunk::BlockState,
    // rust: fluid::FluidState,
    // rust: heightmap::HeightmapType,
    // rust: nbt::{Compound, JavaString, Tag},
    // rust: registry::BlockStateId,
    // rust: worldgen::{
    // rust: biome::BiomeId,
    // rust: feature::FeatureWorld,
    // rust: placement::{PlacementContext, PlacementQueryError},
    // rust: },
}
// use horizon_core::{
    // rust: geometry::Direction,
    // rust: position::{BlockPos, ChunkPos},
    // rust: random::{LegacyRandom, RandomSource, position_seed},
}
// use std::sync::{Arc, Mutex};

    // rust: pub type Result<T> = std::result::Result<T, PlacementQueryError>;
/// Data markers of a placed template: (metadata, absolute position).
    // rust: pub type Markers = Vec<(String, [i32; 3])>;

/// The random draws legacy pieces make.
    // rust: pub trait PieceRandom: ProcessorRandom {
pub fn boolean(self: *Self) b;
pub fn double(self: *Self) f;
    /// The concrete random, for callers that need all of `RandomSource`.
pub fn as_any(self: *Self) *;
}
    // rust: impl<R: RandomSource + 'static> PieceRandom for R {
pub fn boolean(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.next_boolean()
}
pub fn double(self: *Self) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.next_double()
}
pub fn as_any(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self
}
}

/// Object-safe world access for piece post-processing.
    // rust: pub trait PieceWorld {
pub fn block(self: *Self, pos: [i32; 3]) R;
pub fn set(self: *Self, pos: [i32; 3], state: BlockStateId, flags: i32) R;
pub fn fluid(self: *Self, pos: [i32; 3]) R;
pub fn height(self: *Self, kind: HeightmapType, x: i32, z: i32) R;
pub fn min_y(self: *Self) R;
pub fn max_y(self: *Self) R;
pub fn block_entity(self: *Self, pos: [i32; 3], nbt: Compound) R;
    /// `addFreshEntity`: an entity from its NBT (absolute `Pos`).
pub fn entity(self: *Self, nbt: Compound) R;
pub fn post_process(self: *Self, pos: [i32; 3]) R;
    /// `scheduleTick(pos, fluid, delay)`: kept in the proto chunk until it is live.
    // rust: fn fluid_tick(
    // rust: &mut self,
    // rust: pos: [i32; 3],
    // rust: fluid: crate::fluid::FluidKind,
    // rust: delay: i32,
    // rust: ) -> Result<()>;
    /// WorldGenLevel.getSeed.
pub fn seed(self: *Self) R;
    /// Draws from WorldGenLevel.getRandom (the region random).
pub fn level_boolean(self: *Self) R;
pub fn level_float(self: *Self) R;
pub fn level_int(self: *Self, bound: i32) R;
pub fn sea_level(self: *Self) R;
    /// Block.isFaceFull of the block's shape at `pos` on face `direction`.
pub fn face_full(self: *Self, pos: [i32; 3], direction: Direction) R;
pub fn face_sturdy(self: *Self, pos: [i32; 3], face: Direction) R;
pub fn center_sturdy(self: *Self, pos: [i32; 3], face: Direction) R;
    /// WorldGenLevel.getBiome (zoomed).
pub fn biome(self: *Self, pos: [i32; 3]) R;
    // rust: fn place_template(
    // rust: &mut self,
    // rust: resources: &StructureResources,
    // rust: template: &StructureTemplate,
    // rust: position: [i32; 3],
    // rust: reference: [i32; 3],
    // rust: settings: &mut PlaceSettings<'_>,
    // rust: random: &mut dyn ProcessorRandom,
    // rust: flags: i32,
    // rust: ) -> Result<bool>;
}
    // rust: impl<W: FeatureWorld + PlacementContext> PieceWorld for W {
pub fn block(self: *Self, pos: [i32; 3]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.block_state(pos)
}
pub fn set(self: *Self, pos: [i32; 3], state: BlockStateId, flags: i32) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.set_block(pos, state, flags)
    // rust: .map_err(|_| PlacementQueryError::Failed("piece write".into()))
}
pub fn fluid(self: *Self, pos: [i32; 3]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.fluid_state(pos)
}
pub fn height(self: *Self, kind: HeightmapType, x: i32, z: i32) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: PlacementContext::height(self, kind, x, z)
}
pub fn min_y(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: PlacementContext::min_y(self)
}
pub fn max_y(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: PlacementContext::max_y(self)
}
pub fn entity(self: *Self, nbt: Compound) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.add_entity(nbt)
}
pub fn block_entity(self: *Self, pos: [i32; 3], nbt: Compound) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.set_block_entity(pos, nbt)
}
pub fn post_process(self: *Self, pos: [i32; 3]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.mark_postprocessing(pos)
}
    // rust: fn fluid_tick(
    // rust: &mut self,
    // rust: pos: [i32; 3],
    // rust: fluid: crate::fluid::FluidKind,
    // rust: delay: i32,
    // rust: ) -> Result<()> {
    // rust: self.schedule_fluid_tick(pos, fluid, delay)
}
pub fn seed(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.world_seed()
}
pub fn level_boolean(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.next_world_boolean()
}
pub fn level_float(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.next_world_float()
}
pub fn level_int(self: *Self, bound: i32) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.next_world_int(bound)
}
pub fn sea_level(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: PlacementContext::sea_level(self)
}
pub fn face_full(self: *Self, pos: [i32; 3], direction: Direction) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.attachment_at(offset(pos, direction, 1), opposite(direction))
}
pub fn face_sturdy(self: *Self, pos: [i32; 3], face: Direction) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: PlacementContext::face_sturdy(self, pos, face)
}
pub fn center_sturdy(self: *Self, pos: [i32; 3], face: Direction) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: PlacementContext::center_sturdy(self, pos, face)
}
pub fn biome(self: *Self, pos: [i32; 3]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.biome_identity(pos)
}
    // rust: fn place_template(
    // rust: &mut self,
    // rust: resources: &StructureResources,
    // rust: template: &StructureTemplate,
    // rust: position: [i32; 3],
    // rust: reference: [i32; 3],
    // rust: settings: &mut PlaceSettings<'_>,
    // rust: random: &mut dyn ProcessorRandom,
    // rust: flags: i32,
    // rust: ) -> Result<bool> {
    // rust: place_in_world(
    // rust: self,
    // rust: resources,
    // rust: template,
    // rust: position,
    // rust: reference,
    // rust: settings,
    // rust: Some(random),
    // rust: flags,
    // rust: )
}
}

/// Everything a piece needs while post-processing one chunk.
pub const PieceContext = struct {
    world: *'a mut dyn PieceWorld,
    resources: *'a StructureResources,
    /// `BlockState.isSolidRender` of the blocks around the piece.
    blocks: *'a dyn SolidRender,
    random: *'a mut dyn PieceRandom,
    chunk_box: BoundingBox,
    chunk: ChunkPos,
    reference: [i32,
};
/// `BlockState.isSolidRender`: whether a block draws as a solid block. The
/// structure pieces ask it of the blocks around them, the way
/// `StructurePiece.reorient` does.
    // rust: pub trait SolidRender {
pub fn solid_render(self: *Self, state: BlockStateId) b;
}
    // rust: impl SolidRender for crate::worldgen::tree_blocks::TreeBlocks {
pub fn solid_render(self: *Self, state: BlockStateId) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.has(state, crate::worldgen::tree_blocks::SOLID_RENDER)
}
}
    // rust: impl<T: SolidRender + ?Sized> SolidRender for std::sync::Arc<T> {
pub fn solid_render(self: *Self, state: BlockStateId) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (**self).solid_render(state)
}
}
    // rust: impl PieceContext<'_> {
pub fn state(self: *Self, name: []const u8) B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: state(self.resources, name, &[])
}
pub fn state_with(self: *Self, name: []const u8, properties: *[([]const u8) void {
}
    // rust: state(self.resources, name, properties)
}
pub fn name(self: *Self, state: BlockStateId) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.resources
    // rust: .registry
    // rust: .state(state)
    // rust: .map(|s| s.name.as_str())
    // rust: .unwrap_or("")
}
pub fn is_block(self: *Self, pos: [i32; 3], name: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let state = self.world.block(pos)?;
    // rust: Ok(self.name(state) == name)
}
pub fn is_air(self: *Self, state: BlockStateId) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: matches!(
    // rust: self.name(state),
    // rust: "minecraft:air" | "minecraft:cave_air" | "minecraft:void_air"
    // rust: )
}
    /// BlockState.liquid(): water and lava blocks.
pub fn is_liquid(self: *Self, state: BlockStateId) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: matches!(self.name(state), "minecraft:water" | "minecraft:lava")
}
    // rust: pub fn property<'s>(&'s self, state: BlockStateId, key: &str) -> Option<&'s str> {
    // rust: self.resources
    // rust: .registry
    // rust: .state(state)
    // rust: .and_then(|s| s.properties.get(key))
    // rust: .map(String::as_str)
}
pub fn with_property(self: *Self, state: BlockStateId, key: []const u8, value: []const u8) B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(mut descriptor) = self.resources.registry.state(state).cloned() else {
    // rust: return state;
}
    // rust: if let Some(slot) = descriptor.properties.get_mut(key) {
    // rust: *slot = value.to_owned();
}
    // rust: self.resources.registry.id(&descriptor).unwrap_or(state)
}
    /// Store a loot-table container's block entity (RandomizableContainer.setLootTable).
pub fn loot_table(self: *Self, pos: [i32; 3], kind: []const u8, table: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let seed = self.random.long();
    // rust: let mut nbt = Compound::new();
    // rust: nbt.insert("id".into(), Tag::String(kind.into()));
    // rust: nbt.insert("LootTable".into(), Tag::String(table.into()));
    // rust: nbt.insert("LootTableSeed".into(), Tag::Long(seed));
    // rust: self.world.block_entity(pos, nbt)
}
    /// Place a spawner and set its entity (SpawnerBlockEntity.setEntityId).
pub fn spawner(self: *Self, pos: [i32; 3], entity: []const u8) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.world.set(pos, self.state("spawner"), 2)?;
    // rust: let mut id = Compound::new();
    // rust: id.insert("id".into(), Tag::String(entity.into()));
    // rust: let mut data = Compound::new();
    // rust: data.insert("entity".into(), Tag::Compound(id));
    // rust: let mut nbt = Compound::new();
    // rust: nbt.insert("id".into(), Tag::String("minecraft:mob_spawner".into()));
    // rust: nbt.insert("SpawnData".into(), Tag::Compound(data));
        // SpawnerBlockEntity.setEntityId on a fresh spawner: no potentials.
    // rust: nbt.insert("SpawnPotentials".into(), Tag::List(Vec::new()));
    // rust: self.world.block_entity(pos, nbt)
}
}
/// A state by block name and properties (missing properties keep defaults).
    // rust: pub fn state(
    // rust: resources: &StructureResources,
    // rust: name: &str,
    // rust: properties: &[(&str, &str)],
    // rust: ) -> BlockStateId {
    // rust: let registry = resources.registry;
    // rust: let mut descriptor = BlockState {
    // rust: name: if name.contains(':') {
    // rust: name.to_owned()
    // rust: } else {
    // rust: format!("minecraft:{name}")
    // rust: },
    // rust: properties: Default::default(),
}
    // rust: for (k, v) in properties {
    // rust: descriptor
    // rust: .properties
    // rust: .insert((*k).to_owned(), (*v).to_owned());
}
    // rust: registry
    // rust: .resolve(&descriptor)
    // rust: .ok()
    // rust: .or_else(|| registry.default_state(&descriptor.name))
    // rust: .unwrap_or_else(|| registry.default_state("minecraft:air").unwrap())
}

/// A placed structure piece.
    // rust: pub trait LegacyPiece: std::fmt::Debug + Send + Sync {
pub fn bounding_box(self: *Self) B;
    /// The vanilla StructurePieceType id, for diagnostics and comparisons.
pub fn type_name(self: *Self) *;
    /// `StructurePiece.createTag`; None while Horizon cannot save this type,
    /// and then its start is not saved.
pub fn save(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: None
}
pub fn post_process(self: *Self, context: *mut PieceContext<'_>) R;
    /// Structure.afterPlace, run on the first piece once per chunk after all
    /// pieces were placed, with every piece's current box.
pub fn after_place(self: *Self, _context: *mut PieceContext<'_>, _pieces: *[BoundingBox]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(())
}
}

/// `StructurePiece.createTag`'s own fields: the type, `BB`, `O` (the
/// orientation's 2D data value, -1 for none) and `GD` (genDepth).
    // rust: pub fn piece_tag(
    // rust: id: &str,
    // rust: b: BoundingBox,
    // rust: orientation: Option<Direction>,
    // rust: gen_depth: i32,
    // rust: ) -> Compound {
    // rust: let o = orientation.map_or(-1, crate::level::data_2d);
    // rust: [
    // rust: ("id", Tag::String(id.into())),
    // rust: (
    // rust: "BB",
    // rust: Tag::IntArray(vec![
    // rust: b.min[0], b.min[1], b.min[2], b.max[0], b.max[1], b.max[2],
    // rust: ]),
    // rust: ),
    // rust: ("O", Tag::Int(o)),
    // rust: ("GD", Tag::Int(gen_depth)),
    // rust: ]
    // rust: .into_iter()
    // rust: .map(|(k, v)| (JavaString::from(k), v))
    // rust: .collect()
}

/// StructurePiece's orientation transform and block helpers.
pub const PieceFrame = struct {
    bounding_box: BoundingBox,
    orientation: ?Direction,
    mirror: Mirror,
    rotation: Rotation,
    /// Blocks placeBlock must not replace (StructurePiece.canBeReplaced).
    keep: *'static [*'static str],
};
    // rust: pub const HORIZONTAL: [Direction; 4] = [
    // rust: Direction::North,
    // rust: Direction::East,
    // rust: Direction::South,
    // rust: Direction::West,
    // rust: ];
/// Direction.Plane.HORIZONTAL.getRandomDirection.
pub fn random_horizontal(random: *mut impl RandomSource) D {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: HORIZONTAL[random.next_int_bound(4).unwrap_or(0) as usize]
}
    // rust: pub fn make_bounding_box(
    // rust: x: i32,
    // rust: y: i32,
    // rust: z: i32,
    // rust: direction: Direction,
    // rust: width: i32,
    // rust: height: i32,
    // rust: depth: i32,
    // rust: ) -> BoundingBox {
    // rust: if matches!(direction, Direction::North | Direction::South) {
    // rust: BoundingBox::new([x, y, z], [x + width - 1, y + height - 1, z + depth - 1])
    // rust: } else {
    // rust: BoundingBox::new([x, y, z], [x + depth - 1, y + height - 1, z + width - 1])
}
}
    // rust: impl PieceFrame {
pub fn new(bounding_box: BoundingBox, orientation: ?Direction) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (mirror, rotation) = match orientation {
    // rust: Some(Direction::South) => (Mirror::LeftRight, Rotation::None),
    // rust: Some(Direction::West) => (Mirror::LeftRight, Rotation::Clockwise90),
    // rust: Some(Direction::East) => (Mirror::None, Rotation::Clockwise90),
    // rust: _ => (Mirror::None, Rotation::None),
}
    // rust: Self {
    // rust: bounding_box,
    // rust: orientation,
    // rust: mirror,
    // rust: rotation,
    // rust: keep: &[],
}
}
pub fn world_x(self: *Self, x: i32, z: i32) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self.orientation {
    // rust: Some(Direction::North | Direction::South) => self.bounding_box.min[0] + x,
    // rust: Some(Direction::West) => self.bounding_box.max[0] - z,
    // rust: Some(Direction::East) => self.bounding_box.min[0] + z,
    // rust: _ => x,
}
}
pub fn world_y(self: *Self, y: i32) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if self.orientation.is_none() {
    // rust: y
    // rust: } else {
    // rust: y + self.bounding_box.min[1]
}
}
pub fn world_z(self: *Self, x: i32, z: i32) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self.orientation {
    // rust: Some(Direction::North) => self.bounding_box.max[2] - z,
    // rust: Some(Direction::South) => self.bounding_box.min[2] + z,
    // rust: Some(Direction::West | Direction::East) => self.bounding_box.min[2] + x,
    // rust: _ => z,
}
}
pub fn world_pos(self: *Self, x: i32, y: i32, z: i32) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: [self.world_x(x, z), self.world_y(y), self.world_z(x, z)]
}
    /// StructurePiece.placeBlock (canBeReplaced is always true here).
    // rust: pub fn place(
    // rust: &self,
    // rust: c: &mut PieceContext<'_>,
    // rust: state: BlockStateId,
    // rust: x: i32,
    // rust: y: i32,
    // rust: z: i32,
    // rust: ) -> Result<()> {
    // rust: self.place_block(c, state, x, y, z).map(|_| ())
}
    /// `StructurePiece.placeBlock`, answering whether the block was written: the
    /// piece's box or one of the blocks it keeps declines a placement, and then no
    /// block entity is created at that position either.
    // rust: pub fn place_block(
    // rust: &self,
    // rust: c: &mut PieceContext<'_>,
    // rust: state: BlockStateId,
    // rust: x: i32,
    // rust: y: i32,
    // rust: z: i32,
    // rust: ) -> Result<bool> {
    // rust: let pos = self.world_pos(x, y, z);
    // rust: if !c.chunk_box.is_inside(pos) {
    // rust: return Ok(false);
}
    // rust: if !self.keep.is_empty() {
    // rust: let current = c.world.block(pos)?;
    // rust: if self.keep.contains(&c.name(current)) {
    // rust: return Ok(false);
}
}
    // rust: let mut state = state;
    // rust: if self.mirror != Mirror::None {
    // rust: state = c.resources.transforms.mirror(state, self.mirror);
}
    // rust: if self.rotation != Rotation::None {
    // rust: state = c.resources.transforms.rotate(state, self.rotation);
}
    // rust: c.world.set(pos, state, 2)?;
    // rust: let fluid = c.world.fluid(pos)?;
    // rust: if fluid.kind() != crate::fluid::FluidKind::Empty {
    // rust: c.world.fluid_tick(pos, fluid.kind(), 0)?;
}
    // rust: if matches!(
    // rust: c.name(state),
    // rust: "minecraft:nether_brick_fence"
    // rust: | "minecraft:torch"
    // rust: | "minecraft:wall_torch"
    // rust: | "minecraft:oak_fence"
    // rust: | "minecraft:spruce_fence"
    // rust: | "minecraft:dark_oak_fence"
    // rust: | "minecraft:pale_oak_fence"
    // rust: | "minecraft:acacia_fence"
    // rust: | "minecraft:birch_fence"
    // rust: | "minecraft:jungle_fence"
    // rust: | "minecraft:ladder"
    // rust: | "minecraft:iron_bars"
    // rust: ) {
    // rust: c.world.post_process(pos)?;
}
    // rust: Ok(true)
}
pub fn get(self: *Self, c: *mut PieceContext<'_>, x: i32, y: i32, z: i32) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let pos = self.world_pos(x, y, z);
    // rust: if c.chunk_box.is_inside(pos) {
    // rust: c.world.block(pos)
    // rust: } else {
    // rust: Ok(c.state("air"))
}
}
pub fn is_interior(self: *Self, c: *mut PieceContext<'_>, x: i32, y: i32, z: i32) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let pos = self.world_pos(x, y + 1, z);
    // rust: if !c.chunk_box.is_inside(pos) {
    // rust: return Ok(false);
}
    // rust: Ok(pos[1]
    // rust: < c.world
    // rust: .height(HeightmapType::OceanFloorWg, pos[0], pos[2])?)
}
    // rust: pub fn generate_box(
    // rust: &self,
    // rust: c: &mut PieceContext<'_>,
    // rust: [x0, y0, z0]: [i32; 3],
    // rust: [x1, y1, z1]: [i32; 3],
    // rust: edge: BlockStateId,
    // rust: fill: BlockStateId,
    // rust: skip_air: bool,
    // rust: ) -> Result<()> {
    // rust: for y in y0..=y1 {
    // rust: for x in x0..=x1 {
    // rust: for z in z0..=z1 {
    // rust: if skip_air {
    // rust: let s = self.get(c, x, y, z)?;
    // rust: if c.is_air(s) {
    // rust: continue;
}
}
    // rust: let interior = y != y0 && y != y1 && x != x0 && x != x1 && z != z0 && z != z1;
    // rust: self.place(c, if interior { fill } else { edge }, x, y, z)?;
}
}
}
    // rust: Ok(())
}
    /// generateBox with a block selector called as (random, x, y, z, edge).
    // rust: pub fn generate_box_selector(
    // rust: &self,
    // rust: c: &mut PieceContext<'_>,
    // rust: [x0, y0, z0]: [i32; 3],
    // rust: [x1, y1, z1]: [i32; 3],
    // rust: skip_air: bool,
    // rust: selector: &mut dyn FnMut(&mut PieceContext<'_>, i32, i32, i32, bool) -> BlockStateId,
    // rust: ) -> Result<()> {
    // rust: for y in y0..=y1 {
    // rust: for x in x0..=x1 {
    // rust: for z in z0..=z1 {
    // rust: if skip_air {
    // rust: let s = self.get(c, x, y, z)?;
    // rust: if c.is_air(s) {
    // rust: continue;
}
}
    // rust: let edge = y == y0 || y == y1 || x == x0 || x == x1 || z == z0 || z == z1;
    // rust: let state = selector(c, x, y, z, edge);
    // rust: self.place(c, state, x, y, z)?;
}
}
}
    // rust: Ok(())
}
    // rust: pub fn generate_maybe_box(
    // rust: &self,
    // rust: c: &mut PieceContext<'_>,
    // rust: probability: f32,
    // rust: [x0, y0, z0]: [i32; 3],
    // rust: [x1, y1, z1]: [i32; 3],
    // rust: edge: BlockStateId,
    // rust: fill: BlockStateId,
    // rust: skip_air: bool,
    // rust: inside: bool,
    // rust: ) -> Result<()> {
    // rust: for y in y0..=y1 {
    // rust: for x in x0..=x1 {
    // rust: for z in z0..=z1 {
    // rust: if c.random.float() > probability {
    // rust: continue;
}
    // rust: if skip_air {
    // rust: let s = self.get(c, x, y, z)?;
    // rust: if c.is_air(s) {
    // rust: continue;
}
}
    // rust: if inside && !self.is_interior(c, x, y, z)? {
    // rust: continue;
}
    // rust: let interior = y != y0 && y != y1 && x != x0 && x != x1 && z != z0 && z != z1;
    // rust: self.place(c, if interior { fill } else { edge }, x, y, z)?;
}
}
}
    // rust: Ok(())
}
    // rust: pub fn maybe_block(
    // rust: &self,
    // rust: c: &mut PieceContext<'_>,
    // rust: probability: f32,
    // rust: x: i32,
    // rust: y: i32,
    // rust: z: i32,
    // rust: state: BlockStateId,
    // rust: ) -> Result<()> {
    // rust: if c.random.float() < probability {
    // rust: self.place(c, state, x, y, z)?;
}
    // rust: Ok(())
}
    // rust: pub fn upper_half_sphere(
    // rust: &self,
    // rust: c: &mut PieceContext<'_>,
    // rust: [x0, y0, z0]: [i32; 3],
    // rust: [x1, y1, z1]: [i32; 3],
    // rust: fill: BlockStateId,
    // rust: skip_air: bool,
    // rust: ) -> Result<()> {
    // rust: let dx = (x1 - x0 + 1) as f32;
    // rust: let dy = (y1 - y0 + 1) as f32;
    // rust: let dz = (z1 - z0 + 1) as f32;
    // rust: let cx = x0 as f32 + dx / 2.;
    // rust: let cz = z0 as f32 + dz / 2.;
    // rust: for y in y0..=y1 {
    // rust: let ny = (y - y0) as f32 / dy;
    // rust: for x in x0..=x1 {
    // rust: let nx = (x as f32 - cx) / (dx * 0.5);
    // rust: for z in z0..=z1 {
    // rust: let nz = (z as f32 - cz) / (dz * 0.5);
    // rust: if skip_air {
    // rust: let s = self.get(c, x, y, z)?;
    // rust: if c.is_air(s) {
    // rust: continue;
}
}
    // rust: if nx * nx + ny * ny + nz * nz <= 1.05 {
    // rust: self.place(c, fill, x, y, z)?;
}
}
}
}
    // rust: Ok(())
}
    // rust: pub fn fill_column_down(
    // rust: &self,
    // rust: c: &mut PieceContext<'_>,
    // rust: state: BlockStateId,
    // rust: x: i32,
    // rust: y: i32,
    // rust: z: i32,
    // rust: ) -> Result<()> {
    // rust: let mut pos = self.world_pos(x, y, z);
    // rust: if !c.chunk_box.is_inside(pos) {
    // rust: return Ok(());
}
    // rust: let min = c.world.min_y()?;
    // rust: loop {
    // rust: let current = c.world.block(pos)?;
    // rust: let replaceable = c.is_air(current)
    // rust: || c.is_liquid(current)
    // rust: || matches!(
    // rust: c.name(current),
    // rust: "minecraft:glow_lichen" | "minecraft:seagrass" | "minecraft:tall_seagrass"
    // rust: );
    // rust: if !replaceable || pos[1] <= min + 1 {
    // rust: break;
}
    // rust: c.world.set(pos, state, 2)?;
    // rust: pos[1] -= 1;
}
    // rust: Ok(())
}
    /// StructurePiece.createChest at piece coordinates.
    // rust: pub fn create_chest(
    // rust: &self,
    // rust: c: &mut PieceContext<'_>,
    // rust: x: i32,
    // rust: y: i32,
    // rust: z: i32,
    // rust: table: &str,
    // rust: ) -> Result<bool> {
    // rust: let pos = self.world_pos(x, y, z);
    // rust: create_chest(c, pos, table, None)
}
    // rust: pub fn create_dispenser(
    // rust: &self,
    // rust: c: &mut PieceContext<'_>,
    // rust: x: i32,
    // rust: y: i32,
    // rust: z: i32,
    // rust: facing: Direction,
    // rust: table: &str,
    // rust: ) -> Result<bool> {
    // rust: let pos = self.world_pos(x, y, z);
    // rust: if !c.chunk_box.is_inside(pos) || c.is_block(pos, "minecraft:dispenser")? {
    // rust: return Ok(false);
}
    // rust: let state = c.state_with("dispenser", &[("facing", direction_name(facing))]);
        // `level.getBlockEntity(pos) instanceof DispenserBlockEntity` after
        // `placeBlock`: a placement the piece declines leaves no block entity, and
        // then no loot table is set and no seed is drawn.
    // rust: if self.place_block(c, state, x, y, z)? {
    // rust: c.loot_table(pos, "minecraft:dispenser", table)?;
}
    // rust: Ok(true)
}
}
pub fn direction_name(d: Direction) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match d {
    // rust: Direction::Down => "down",
    // rust: Direction::Up => "up",
    // rust: Direction::North => "north",
    // rust: Direction::South => "south",
    // rust: Direction::West => "west",
    // rust: Direction::East => "east",
}
}
pub fn offset(pos: [i32; 3], d: Direction, n: i32) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let s = d.normal();
    // rust: [pos[0] + s[0] * n, pos[1] + s[1] * n, pos[2] + s[2] * n]
}
/// `BlockState.isSolidRender` of a state: whether it draws as a solid block.
pub fn solid_render(c: *PieceContext<'_>, state: BlockStateId) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: c.blocks.solid_render(state)
}
/// StructurePiece.createChest with an absolute position.
    // rust: pub fn create_chest(
    // rust: c: &mut PieceContext<'_>,
    // rust: pos: [i32; 3],
    // rust: table: &str,
    // rust: state: Option<BlockStateId>,
    // rust: ) -> Result<bool> {
    // rust: if !c.chunk_box.is_inside(pos) || c.is_block(pos, "minecraft:chest")? {
    // rust: return Ok(false);
}
    // rust: let state = match state {
    // rust: Some(s) => s,
    // rust: None => reorient(c, pos, c.state("chest"))?,
}
    // rust: c.world.set(pos, state, 2)?;
    // rust: c.loot_table(pos, "minecraft:chest", table)?;
    // rust: Ok(true)
}
/// `StructurePiece.reorient` for chests: the facing a chest takes from the
/// blocks around it.
pub fn reorient(c: *mut PieceContext<'_>, pos: [i32; 3], state: BlockStateId) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut states = [BlockStateId(0); 4];
    // rust: for (index, d) in HORIZONTAL.iter().enumerate() {
    // rust: states[index] = c.world.block(offset(pos, *d, 1))?;
}
    // rust: let facing = match c.property(state, "facing") {
    // rust: Some("south") => Direction::South,
    // rust: Some("east") => Direction::East,
    // rust: Some("west") => Direction::West,
    // rust: _ => Direction::North,
}
    // rust: let blocks = c.blocks;
    // rust: let is_chest = |s: BlockStateId| c.name(s) == "minecraft:chest";
    // rust: let Some(facing) = reorient_facing(facing, states, &is_chest, blocks) else {
    // rust: return Ok(state);
}
    // rust: Ok(c.with_property(state, "facing", direction_name(facing)))
}
/// `StructurePiece.reorient`: the facing of a chest, from the blocks around
/// it. `states` are the four horizontal neighbours (north, east, south, west).
/// `is_chest` tells whether a state is a chest, and `blocks` whether it draws
/// as solid (`BlockState.isSolidRender`). None: a chest is next to it, and
/// the state is kept.
    // rust: fn reorient_facing(
    // rust: facing: Direction,
    // rust: states: [BlockStateId; 4],
    // rust: is_chest: &dyn Fn(BlockStateId) -> bool,
    // rust: blocks: &dyn SolidRender,
    // rust: ) -> Option<Direction> {
    // rust: let index = |d: Direction| match d {
    // rust: Direction::North => 0,
    // rust: Direction::East => 1,
    // rust: Direction::South => 2,
    // rust: Direction::West => 3,
    // rust: _ => 0,
}
    // rust: let mut solid_neighbour: Option<Direction> = None;
    // rust: for (i, d) in HORIZONTAL.iter().enumerate() {
    // rust: if is_chest(states[i]) {
    // rust: return None;
}
    // rust: if blocks.solid_render(states[i]) {
    // rust: if solid_neighbour.is_some() {
    // rust: solid_neighbour = None;
    // rust: break;
}
    // rust: solid_neighbour = Some(*d);
}
}
    // rust: if let Some(d) = solid_neighbour {
    // rust: return Some(opposite(d));
}
    // rust: let mut lock = facing;
    // rust: if blocks.solid_render(states[index(lock)]) {
    // rust: lock = opposite(lock);
}
    // rust: if blocks.solid_render(states[index(lock)]) {
    // rust: lock = clockwise(lock);
}
    // rust: if blocks.solid_render(states[index(lock)]) {
    // rust: lock = opposite(lock);
}
    // rust: Some(lock)
}
pub fn opposite(d: Direction) D {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match d {
    // rust: Direction::Down => Direction::Up,
    // rust: Direction::Up => Direction::Down,
    // rust: Direction::North => Direction::South,
    // rust: Direction::South => Direction::North,
    // rust: Direction::West => Direction::East,
    // rust: Direction::East => Direction::West,
}
}
pub fn clockwise(d: Direction) D {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match d {
    // rust: Direction::North => Direction::East,
    // rust: Direction::East => Direction::South,
    // rust: Direction::South => Direction::West,
    // rust: Direction::West => Direction::North,
    // rust: other => other,
}
}
pub fn counter_clockwise(d: Direction) D {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match d {
    // rust: Direction::North => Direction::West,
    // rust: Direction::West => Direction::South,
    // rust: Direction::South => Direction::East,
    // rust: Direction::East => Direction::North,
    // rust: other => other,
}
}

/// TemplateStructurePiece: one template with fixed settings; data markers
/// are handed to the owning structure.
/// NBT for an entity a structure piece spawns at the block centre of `pos`
/// (y at the block's floor): `finalize` asks the game for `finalizeSpawn`
/// (STRUCTURE), `persistent` sets `PersistenceRequired`.
pub fn spawn_nbt(id: []const u8, pos: [i32; 3], finalize: bool, persistent: bool) C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut nbt = Compound::new();
    // rust: nbt.insert("id".into(), Tag::String(id.into()));
    // rust: let p = [
    // rust: f64::from(pos[0]) + 0.5,
    // rust: f64::from(pos[1]),
    // rust: f64::from(pos[2]) + 0.5,
    // rust: ];
    // rust: nbt.insert(
    // rust: "Pos".into(),
    // rust: Tag::List(p.iter().map(|v| Tag::Double(v.to_bits())).collect()),
    // rust: );
    // rust: nbt.insert(
    // rust: "Rotation".into(),
    // rust: Tag::List(vec![Tag::Float(0f32.to_bits()), Tag::Float(0f32.to_bits())]),
    // rust: );
    // rust: if persistent {
    // rust: nbt.insert("PersistenceRequired".into(), Tag::Byte(1));
}
    // rust: if finalize {
    // rust: nbt.insert("horizon:finalize".into(), Tag::Byte(1));
}
    // rust: nbt
}
pub const TemplatePiece = struct {
    type_name: *'static str,
    template_name: []const u8,
    template: *StructureTemplate,
    position: [i32,
    rotation: Rotation,
    mirror: Mirror,
    pivot: [i32,
    processors: *ProcessorList,
    waterlogging: bool,
    /// Ignore structure blocks (and air, for ocean ruins) before processors.
    ignore: std.ArrayList([]const u8),
    bounding_box: BoundingBox,
    handler: TemplateHandler,
    /// Per-piece state mutated by vanilla post-processing (e.g. ruined
    /// portals record nothing; shipwrecks/igloos re-place at a height).
    state: Mutex<?i32>,
};
pub const TemplateHandler = enum {
    Igloo,
    Shipwreck {,
    beached: bool,
    // rust: },
    OceanRuin {,
    warm: bool,
    large: bool,
    integrity: f32,
    // rust: },
    RuinedPortal(super::ruined_portal::PortalProps),
    Mansion,
    Plain,
};
    // rust: impl TemplatePiece {
    // rust: pub fn new(
    // rust: type_name: &'static str,
    // rust: template_name: &str,
    // rust: template: Arc<StructureTemplate>,
    // rust: position: [i32; 3],
    // rust: rotation: Rotation,
    // rust: mirror: Mirror,
    // rust: pivot: [i32; 3],
    // rust: processors: Arc<ProcessorList>,
    // rust: waterlogging: bool,
    // rust: ignore: Vec<String>,
    // rust: handler: TemplateHandler,
    // rust: ) -> Self {
    // rust: Self {
    // rust: bounding_box: template.bounding_box(position, rotation, pivot, mirror),
    // rust: type_name,
    // rust: template_name: template_name.to_owned(),
    // rust: template,
    // rust: position,
    // rust: rotation,
    // rust: mirror,
    // rust: pivot,
    // rust: processors,
    // rust: waterlogging,
    // rust: ignore,
    // rust: handler,
    // rust: state: Mutex::new(None),
}
}
pub fn settings(self: *Self) P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut s = PlaceSettings::new(self.rotation);
    // rust: s.mirror = self.mirror;
    // rust: s.pivot = self.pivot;
    // rust: s.waterlogging = self.waterlogging;
        // Mansions and end cities spawn their mobs from data markers.
    // rust: s.ignore_entities = self.template_name.contains("woodland_mansion/")
    // rust: || self.template_name.contains("end_city/");
    // rust: s
}
    /// TemplateStructurePiece.postProcess at a (possibly shifted) position;
    /// returns the data markers (metadata, absolute position) on success.
    // rust: pub fn place_at(
    // rust: &self,
    // rust: c: &mut PieceContext<'_>,
    // rust: position: [i32; 3],
    // rust: extra: &[Processor],
    // rust: ) -> Result<Option<Markers>> {
    // rust: let ignore = Processor::BlockIgnore(self.ignore.iter().cloned().collect());
    // rust: let mut settings = self.settings();
    // rust: settings.bounding_box = Some(c.chunk_box);
    // rust: settings.processors.push(&ignore);
    // rust: settings.processors.extend(extra.iter());
    // rust: settings.processors.extend(self.processors.0.iter());
    // rust: let resources = c.resources;
    // rust: let reference = c.reference;
    // rust: if !c.world.place_template(
    // rust: resources,
    // rust: &self.template,
    // rust: position,
    // rust: reference,
    // rust: &mut settings,
    // rust: &mut *c.random,
    // rust: 2,
    // rust: )? {
    // rust: return Ok(None);
}
    // rust: let mut markers = Vec::new();
    // rust: let mut jigsaws = Vec::new();
    // rust: for info in filter_blocks(resources, &self.template, position, &settings) {
    // rust: let name = c.name(info.state).to_owned();
    // rust: let Some(nbt) = &info.nbt else { continue };
    // rust: let text = |key: &str| match nbt.get(&JavaString::from(key)) {
    // rust: Some(Tag::String(s)) => s.to_string_lossy(),
    // rust: _ => String::new(),
}
    // rust: if name == "minecraft:structure_block" && text("mode").eq_ignore_ascii_case("data") {
    // rust: markers.push((text("metadata"), info.pos));
    // rust: } else if name == "minecraft:jigsaw" {
    // rust: let final_state = nbt
    // rust: .get(&JavaString::from("final_state"))
    // rust: .map(|_| text("final_state"))
    // rust: .unwrap_or_else(|| "minecraft:air".into());
    // rust: jigsaws.push((info.pos, final_state));
}
}
    // rust: for (pos, final_state) in jigsaws {
    // rust: let state = super::template::parse_state_string(resources.registry, &final_state)
    // rust: .unwrap_or_else(|| c.state("air"));
    // rust: c.world.set(pos, state, 3)?;
}
    // rust: Ok(Some(markers))
}
}
/// StructureTemplate.filterBlocks for structure and jigsaw blocks (palette
/// chosen by settings' random or a position seed), within the settings box.
    // rust: fn filter_blocks(
    // rust: resources: &StructureResources,
    // rust: template: &StructureTemplate,
    // rust: position: [i32; 3],
    // rust: settings: &PlaceSettings<'_>,
    // rust: ) -> Vec<BlockInfo> {
    // rust: if template.palettes().is_empty() {
    // rust: return Vec::new();
}
    // rust: let palette = LegacyRandom::new(position_seed(BlockPos::new(
    // rust: position[0],
    // rust: position[1],
    // rust: position[2],
    // rust: )))
    // rust: .next_int_bound(template.palettes().len() as i32)
    // rust: .unwrap_or(0) as usize;
    // rust: template.palettes()[palette]
    // rust: .blocks()
    // rust: .iter()
    // rust: .filter(|b| {
    // rust: let name = resources
    // rust: .registry
    // rust: .state(b.state)
    // rust: .map(|s| s.name.as_str())
    // rust: .unwrap_or("");
    // rust: name == "minecraft:structure_block" || name == "minecraft:jigsaw"
    // rust: })
    // rust: .filter_map(|b| {
    // rust: let relative = StructureTemplate::transform(
    // rust: b.pos,
    // rust: settings.mirror,
    // rust: settings.rotation,
    // rust: settings.pivot,
    // rust: );
    // rust: let pos: [i32; 3] = std::array::from_fn(|i| relative[i] + position[i]);
    // rust: settings
    // rust: .bounding_box
    // rust: .is_none_or(|bb| bb.is_inside(pos))
    // rust: .then(|| BlockInfo {
    // rust: pos,
    // rust: state: resources.transforms.rotate(b.state, settings.rotation),
    // rust: nbt: b.nbt.clone(),
    // rust: })
    // rust: })
    // rust: .collect()
}

    // rust: mod tests {
//     use super::*;
//     use crate::worldgen::structure::{BlockRegistry, StateTransforms};

pub const AIR: BlockStateId = BlockStateId(0);
pub const GLASS: BlockStateId = BlockStateId(1);
pub const STONE: BlockStateId = BlockStateId(2);
pub const CHEST: BlockStateId = BlockStateId(3);

    /// `BlockState.isSolidRender`: only the stone draws as a solid block;
    /// glass, leaves, ice, a spawner and a barrier do not.
pub const Blocks = struct {};
    // rust: impl SolidRender for Blocks {
pub fn solid_render(self: *Self, state: BlockStateId) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: state == STONE
}
}

    /// `StructurePiece.reorient`: the chest's facing from the blocks around
    /// it, as vanilla has it. The solidity is `BlockState.isSolidRender`:
    /// glass is not solid to render, stone is.
pub fn a_chest_next_to_glass_faces_away_from_the_stone() void {
}
        // North: glass, east: stone.
    // rust: assert_eq!(
    // rust: reorient_facing(
    // rust: Direction::North,
    // rust: [GLASS, STONE, AIR, AIR],
    // rust: &|s| s == CHEST,
    // rust: &Blocks
    // rust: ),
    // rust: Some(Direction::West)
    // rust: );
}

    /// Two solid neighbours: the chest keeps its own facing, turned away from
    /// the one it faced.
pub fn two_solid_neighbours_turn_the_chest_away_from_one_of_them() void {
}
        // North and east are solid.
    // rust: assert_eq!(
    // rust: reorient_facing(
    // rust: Direction::North,
    // rust: [STONE, STONE, AIR, AIR],
    // rust: &|s| s == CHEST,
    // rust: &Blocks
    // rust: ),
    // rust: Some(Direction::South)
    // rust: );
}

    /// A chest next to it: the state is kept.
pub fn a_chest_next_to_a_chest_keeps_its_facing() void {
}
    // rust: assert_eq!(
    // rust: reorient_facing(
    // rust: Direction::North,
    // rust: [CHEST, AIR, AIR, AIR],
    // rust: &|s| s == CHEST,
    // rust: &Blocks
    // rust: ),
    // rust: None
    // rust: );
}

    /// Air, sandstone, the six dispenser facings and the water a piece may tick.
pub fn registry() * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let facings = ["north", "east", "south", "west", "up", "down"];
    // rust: let mut rows = Vec::new();
    // rust: let mut defaults = std::collections::BTreeMap::new();
    // rust: let plain = [
    // rust: "minecraft:air",
    // rust: "minecraft:cave_air",
    // rust: "minecraft:void_air",
    // rust: "minecraft:sandstone",
    // rust: "minecraft:water",
    // rust: ];
    // rust: for name in plain {
    // rust: defaults.insert(name.to_owned(), rows.len() as i64);
    // rust: rows.push(serde_json::json!([name, name.ends_with("air"), false, "",
    // rust: {"id": name, "properties": {}}]));
}
    // rust: defaults.insert("minecraft:dispenser".into(), rows.len() as i64);
    // rust: for facing in facings {
    // rust: rows.push(serde_json::json!(["minecraft:dispenser", false, false, "",
    // rust: {"id": "minecraft:dispenser", "properties": {"facing": facing}}]));
}
    // rust: let facts = serde_json::json!({"states": rows, "defaults": defaults});
    // rust: let registry = BlockRegistry::from_facts_json(facts.to_string().as_bytes()).unwrap();
    // rust: Box::leak(Box::new(registry))
}

    /// The piece's world: one block everywhere, recording what the piece writes.
pub const DispenserWorld = struct {
    registry: *'static BlockRegistry,
    block: BlockStateId,
    sets: Vec<([i32,
    entities: Vec<([i32,
};
    // rust: impl PieceWorld for DispenserWorld {
pub fn block(self: *Self, _: [i32; 3]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.block)
}
pub fn set(self: *Self, pos: [i32; 3], state: BlockStateId, _: i32) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.sets.push((pos, state));
    // rust: Ok(true)
}
pub fn fluid(self: *Self, _: [i32; 3]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(FluidState::EMPTY)
}
pub fn height(self: *Self, _: HeightmapType, _: i32, _: i32) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Err(PlacementQueryError::Unavailable)
}
pub fn min_y(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(-64)
}
pub fn max_y(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(384)
}
pub fn block_entity(self: *Self, pos: [i32; 3], nbt: Compound) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.entities.push((pos, nbt));
    // rust: Ok(())
}
pub fn entity(self: *Self, _: Compound) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(())
}
pub fn post_process(self: *Self, _: [i32; 3]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(())
}
pub fn fluid_tick(self: *Self, _: [i32; 3], _: crate::fluid::FluidKind, _: i32) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(())
}
pub fn seed(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(0)
}
pub fn level_boolean(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(false)
}
pub fn level_float(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(0.0)
}
pub fn level_int(self: *Self, _: i32) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(0)
}
pub fn sea_level(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(63)
}
pub fn face_full(self: *Self, _: [i32; 3], _: Direction) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(false)
}
pub fn face_sturdy(self: *Self, _: [i32; 3], _: Direction) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(false)
}
pub fn center_sturdy(self: *Self, _: [i32; 3], _: Direction) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(false)
}
pub fn biome(self: *Self, _: [i32; 3]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Err(PlacementQueryError::Unavailable)
}
    // rust: fn place_template(
    // rust: &mut self,
    // rust: _: &StructureResources,
    // rust: _: &StructureTemplate,
    // rust: _: [i32; 3],
    // rust: _: [i32; 3],
    // rust: _: &mut PlaceSettings<'_>,
    // rust: _: &mut dyn ProcessorRandom,
    // rust: _: i32,
    // rust: ) -> Result<bool> {
    // rust: Ok(false)
}
}
    // rust: impl DispenserWorld {
pub fn name_of(self: *Self, state: BlockStateId) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.registry.state(state).map(|s| s.name.as_str()).unwrap()
}
}

    /// `StructurePiece.createDispenser` at local (3, 5, 1) of an unoriented piece,
    /// in a world of `block`, for a piece that keeps `keep`.
pub fn dispense(block: []const u8, keep: *'static [*'static str]) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let registry = registry();
    // rust: let resources = StructureResources::new(
    // rust: registry,
    // rust: StateTransforms::default(),
    // rust: std::path::Path::new("/nonexistent"),
    // rust: std::collections::BTreeMap::new(),
    // rust: &std::collections::BTreeMap::new(),
    // rust: );
    // rust: let frame = PieceFrame {
    // rust: bounding_box: BoundingBox::new([0, 0, 0], [16, 16, 16]),
    // rust: orientation: None,
    // rust: mirror: Mirror::None,
    // rust: rotation: Rotation::None,
    // rust: keep,
}
    // rust: let mut world = DispenserWorld {
    // rust: registry,
    // rust: block: registry.default_state(block).unwrap(),
    // rust: sets: Vec::new(),
    // rust: entities: Vec::new(),
}
    // rust: let mut blocks = Blocks;
    // rust: let mut random = LegacyRandom::new(7);
    // rust: let placed = {
    // rust: let mut c = PieceContext {
    // rust: world: &mut world,
    // rust: resources: &resources,
    // rust: blocks: &mut blocks,
    // rust: random: &mut random,
    // rust: chunk_box: BoundingBox::new([0, 0, 0], [16, 16, 16]),
    // rust: chunk: ChunkPos::new(0, 0),
    // rust: reference: [0, 0, 0],
}
    // rust: frame
    // rust: .create_dispenser(
    // rust: &mut c,
    // rust: 3,
    // rust: 5,
    // rust: 1,
    // rust: Direction::North,
    // rust: "minecraft:chests/simple_dungeon",
    // rust: )
    // rust: .unwrap()
}
    // rust: (placed, world)
}

    /// The dispenser block entity takes the loot table once the dispenser is in
    /// the world.
pub fn a_placed_dispenser_takes_the_loot_table() void {
}
    // rust: let (placed, world) = dispense("minecraft:air", &[]);
    // rust: assert!(placed);
    // rust: assert_eq!(world.sets, vec![([3, 5, 1], world.sets[0].1)]);
    // rust: assert_eq!(world.name_of(world.sets[0].1), "minecraft:dispenser");
    // rust: assert_eq!(world.entities.len(), 1);
    // rust: let (pos, nbt) = &world.entities[0];
    // rust: assert_eq!(*pos, [3, 5, 1]);
    // rust: assert_eq!(
    // rust: nbt.get(&JavaString::from("id")),
    // rust: Some(&crate::nbt::Tag::String("minecraft:dispenser".into()))
    // rust: );
    // rust: assert_eq!(
    // rust: nbt.get(&JavaString::from("LootTable")),
    // rust: Some(&crate::nbt::Tag::String(
    // rust: "minecraft:chests/simple_dungeon".into()
    // rust: ))
    // rust: );
    // rust: assert!(nbt.get(&JavaString::from("LootTableSeed")).is_some());
}

    /// A block the piece keeps declines the placement, so there is no dispenser
    /// block entity to take a loot table: vanilla sets none and keeps its seed.
pub fn a_declined_dispenser_takes_no_loot_table() void {
}
    // rust: let (placed, world) = dispense("minecraft:sandstone", &["minecraft:sandstone"]);
    // rust: assert!(placed);
    // rust: assert!(world.sets.is_empty());
    // rust: assert!(world.entities.is_empty());
}
}
