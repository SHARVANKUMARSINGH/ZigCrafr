//! Transpiled from Horizon Rust crate
package horizon_world_vegetation

import "core:fmt"
import "core:mem"
import "core:math"

// Vegetation and cave-decoration features: vegetation patches (plain and
// waterlogged), coral trees/claws, huge mushrooms and multiface growth.
// use super::{
    // rust: DecodeError, Object,
    // rust: block_feature::FeatureBlockBindings,
    // rust: block_predicate::BlockPredicate,
    // rust: feature::FeatureWorld,
    // rust: feature_graph::{FeatureExecutionError, PlacedFeatureDefinition},
    // rust: int_range, optional,
    // rust: placement::PlacementContext,
    // rust: required,
    // rust: state_provider::BlockStateProvider,
    // rust: tree::{TreeDecoder, TreeResult, kind, read, sample_state, unit_float, write},
    // rust: tree_blocks::{self as tb, PosSet, TreeBlocks},
    // rust: value_provider::IntProvider,
}
// use crate::registry::BlockStateId;
// use horizon_core::{geometry::Direction, random::RandomSource};
// use std::{collections::BTreeSet, sync::Arc};

// Places a nested placed feature with the caller's run budget.
    // rust: pub(crate) type PlacedPlacer<'a, W, R> = dyn FnMut(
    // rust: &PlacedFeatureDefinition,
    // rust: &mut W,
    // rust: &mut R,
    // rust: [i32; 3],
    // rust: ) -> TreeResult<bool, <W as FeatureWorld>::Error>
    // rust: + 'a;
    // rust: pub(crate) type PlacedDecoder<'a> =
    // rust: dyn Fn(&str, usize, &mut usize) -> Result<PlacedFeatureDefinition, DecodeError> + 'a;

    // rust: fn query<E>(error: super::placement::PlacementQueryError) -> FeatureExecutionError<E> {
    // rust: FeatureExecutionError::Query(error)
}

VegetationPatchFeature :: struct {
    replaceable: ^BTreeSet<BlockStateId>,
    ground: BlockStateProvider,
    vegetation: ^PlacedFeatureDefinition,
    // CaveSurface direction: DOWN for floor, UP for ceiling.
    inwards: Direction,
    depth: IntProvider,
    extra_bottom: f32,
    vertical_range: i32,
    vegetation_chance: f32,
    xz_radius: IntProvider,
    extra_edge: f32,
    waterlogged: bool,
    blocks: ^TreeBlocks,
}
    // rust: impl VegetationPatchFeature {
    // rust: pub(crate) fn decode(
    // rust: json: &str,
    // rust: bindings: &FeatureBlockBindings<'_>,
    // rust: depth: usize,
    // rust: remaining: &mut usize,
    // rust: nested: &PlacedDecoder<'_>,
    // rust: ) -> Result<Self, DecodeError> {
    // rust: let object: Object = serde_json::from_str(json)?;
    // rust: let waterlogged = match kind(&object)?.as_str() {
    // rust: "minecraft:vegetation_patch" => false,
    // rust: "minecraft:waterlogged_vegetation_patch" => true,
    // rust: _ => return Err(DecodeError::Field("vegetation patch type")),
}
    // rust: let blocks = bindings.tree_blocks()?;
    // rust: let mut decoder = TreeDecoder {
    // rust: bindings,
    // rust: depth,
    // rust: remaining,
}
    // rust: let surface: String = serde_json::from_str(required(&object, "surface")?.get())?;
    // rust: let inwards = match surface.as_str() {
    // rust: "floor" => Direction::Down,
    // rust: "ceiling" => Direction::Up,
    // rust: _ => return Err(DecodeError::Field("cave surface")),
}
    // rust: let vegetation = nested(
    // rust: required(&object, "vegetation_feature")?.get(),
    // rust: depth + 1,
    // rust: decoder.remaining,
    // rust: )?;
    // rust: Ok(Self {
    // rust: replaceable: decoder.block_set(required(&object, "replaceable")?)?,
    // rust: ground: decoder.provider(required(&object, "ground_state")?)?,
    // rust: vegetation: Box::new(vegetation),
    // rust: inwards,
    // rust: depth: decoder.int_provider(required(&object, "depth")?, 1, 128)?,
    // rust: extra_bottom: unit_float(
    // rust: required(&object, "extra_bottom_block_chance")?,
    // rust: "extra_bottom_block_chance",
    // rust: )?,
    // rust: vertical_range: int_range(
    // rust: required(&object, "vertical_range")?,
    // rust: "vertical_range",
    // rust: 1,
    // rust: 256,
    // rust: )?,
    // rust: vegetation_chance: unit_float(
    // rust: required(&object, "vegetation_chance")?,
    // rust: "vegetation_chance",
    // rust: )?,
    // rust: xz_radius: IntProvider::decode(
    // rust: required(&object, "xz_radius")?,
    // rust: depth + 1,
    // rust: decoder.remaining,
    // rust: )?,
    // rust: extra_edge: unit_float(
    // rust: required(&object, "extra_edge_column_chance")?,
    // rust: "extra_edge_column_chance",
    // rust: )?,
    // rust: waterlogged,
    // rust: blocks,
    // rust: })
}
    // rust: pub(crate) fn place<W: FeatureWorld + PlacementContext, R: RandomSource>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: random: &mut R,
    // rust: origin: [i32; 3],
    // rust: nested: &mut PlacedPlacer<'_, W, R>,
    // rust: ) -> TreeResult<bool, W::Error> {
    // rust: let x_radius = self.xz_radius.sample(random)?.wrapping_add(1);
    // rust: let z_radius = self.xz_radius.sample(random)?.wrapping_add(1);
    // rust: let mut surface = self.ground_patch(world, random, origin, x_radius, z_radius)?;
    // rust: if self.waterlogged {
    // rust: let mut water = PosSet::default();
    // rust: for p in surface.to_vec() {
    // rust: let mut exposed = false;
    // rust: for direction in [
    // rust: Direction::North,
    // rust: Direction::East,
    // rust: Direction::South,
    // rust: Direction::West,
    // rust: Direction::Down,
    // rust: ] {
    // rust: let q = tb::relative(p, direction, 1);
    // rust: let state = read(world, q)?;
    // rust: if !world
    // rust: .state_face_sturdy(state, q, direction.opposite())
    // rust: .map_err(query)?
    // rust: {
    // rust: exposed = true;
    // rust: break;
}
}
    // rust: if !exposed {
    // rust: water.insert(p);
}
}
    // rust: let water_state = self
    // rust: .blocks
    // rust: .default_state("minecraft:water")
    // rust: .ok_or(FeatureExecutionError::InvalidState)?;
    // rust: for p in water.to_vec() {
    // rust: write(world, p, water_state, 2)?;
}
    // rust: surface = water;
}
    // rust: let positions = surface.to_vec();
    // rust: for p in &positions {
    // rust: if self.vegetation_chance > 0.0 && random.next_float() < self.vegetation_chance {
    // rust: self.place_vegetation(world, random, *p, nested)?;
}
}
    // rust: Ok(!positions.is_empty())
}
    // rust: fn place_vegetation<W: FeatureWorld + PlacementContext, R: RandomSource>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: random: &mut R,
    // rust: position: [i32; 3],
    // rust: nested: &mut PlacedPlacer<'_, W, R>,
    // rust: ) -> TreeResult<bool, W::Error> {
    // rust: let outwards = self.inwards.opposite();
    // rust: if !self.waterlogged {
    // rust: return nested(
    // rust: &self.vegetation,
    // rust: world,
    // rust: random,
    // rust: tb::relative(position, outwards, 1),
    // rust: );
}
        // WaterloggedVegetationPatchFeature passes placementPos.below() to super.
    // rust: let below = tb::offset(position, 0, -1, 0);
    // rust: if nested(
    // rust: &self.vegetation,
    // rust: world,
    // rust: random,
    // rust: tb::relative(below, outwards, 1),
    // rust: )? {
    // rust: let placed = read(world, position)?;
    // rust: if self.blocks.has(placed, tb::WATERLOGGABLE)
    // rust: && self.blocks.properties.value(placed, "waterlogged") == Some("false")
    // rust: {
    // rust: write(world, position, self.blocks.waterlogged(placed, true), 2)?;
}
    // rust: return Ok(true);
}
    // rust: Ok(false)
}
    // rust: fn ground_patch<W: FeatureWorld + PlacementContext, R: RandomSource>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: random: &mut R,
    // rust: origin: [i32; 3],
    // rust: x_radius: i32,
    // rust: z_radius: i32,
    // rust: ) -> TreeResult<PosSet, W::Error> {
    // rust: let inwards = self.inwards;
    // rust: let outwards = inwards.opposite();
    // rust: let mut surface = PosSet::default();
    // rust: let mut dx = x_radius.wrapping_neg();
    // rust: while dx <= x_radius {
    // rust: let x_edge = dx == x_radius.wrapping_neg() || dx == x_radius;
    // rust: let mut dz = z_radius.wrapping_neg();
    // rust: while dz <= z_radius {
    // rust: let z_edge = dz == z_radius.wrapping_neg() || dz == z_radius;
    // rust: let edge = x_edge || z_edge;
    // rust: let corner = x_edge && z_edge;
    // rust: let edge_not_corner = edge && !corner;
    // rust: if !corner
    // rust: && (!edge_not_corner
    // rust: || (self.extra_edge != 0.0 && random.next_float() <= self.extra_edge))
    // rust: {
    // rust: let mut pos = tb::offset(origin, dx, 0, dz);
    // rust: let mut offset = 0;
    // rust: while self.blocks.is_air(read(world, pos)?) && offset < self.vertical_range {
    // rust: pos = tb::relative(pos, inwards, 1);
    // rust: offset += 1;
}
    // rust: let mut offset = 0;
    // rust: while !self.blocks.is_air(read(world, pos)?) && offset < self.vertical_range {
    // rust: pos = tb::relative(pos, outwards, 1);
    // rust: offset += 1;
}
    // rust: let below = tb::relative(pos, inwards, 1);
    // rust: let below_state = read(world, below)?;
    // rust: if self.blocks.is_air(read(world, pos)?)
    // rust: && world
    // rust: .state_face_sturdy(below_state, below, outwards)
    // rust: .map_err(query)?
    // rust: {
    // rust: let depth = self.depth.sample(random)?.wrapping_add(i32::from(
    // rust: self.extra_bottom > 0.0 && random.next_float() < self.extra_bottom,
    // rust: ));
    // rust: if self.place_ground(world, random, below, depth)? {
    // rust: surface.insert(below);
}
}
}
    // rust: dz += 1;
}
    // rust: dx += 1;
}
    // rust: Ok(surface)
}
    // rust: fn place_ground<W: FeatureWorld + PlacementContext, R: RandomSource>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: random: &mut R,
    // rust: mut below: [i32; 3],
    // rust: depth: i32,
    // rust: ) -> TreeResult<bool, W::Error> {
    // rust: for i in 0..depth {
    // rust: let state = sample_state(&self.ground, world, random, below)?;
    // rust: let existing = read(world, below)?;
    // rust: if !self.blocks.same_block(state, existing) {
    // rust: if !self.replaceable.contains(&existing) {
    // rust: return Ok(i != 0);
}
    // rust: write(world, below, state, 2)?;
    // rust: below = tb::relative(below, self.inwards, 1);
}
}
    // rust: Ok(true)
}
}

CoralFeature :: struct {
    claw: bool,
    feature: ^PlacedFeatureDefinition,
}
    // rust: impl CoralFeature {
    // rust: pub(crate) fn decode(
    // rust: json: &str,
    // rust: depth: usize,
    // rust: remaining: &mut usize,
    // rust: nested: &PlacedDecoder<'_>,
    // rust: ) -> Result<Self, DecodeError> {
    // rust: let object: Object = serde_json::from_str(json)?;
    // rust: let claw = match kind(&object)?.as_str() {
    // rust: "minecraft:coral_tree" => false,
    // rust: "minecraft:coral_claw" => true,
    // rust: _ => return Err(DecodeError::Field("coral feature type")),
}
    // rust: Ok(Self {
    // rust: claw,
    // rust: feature: Box::new(nested(
    // rust: required(&object, "feature")?.get(),
    // rust: depth + 1,
    // rust: remaining,
    // rust: )?),
    // rust: })
}
    // rust: pub(crate) fn place<W: FeatureWorld + PlacementContext, R: RandomSource>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: random: &mut R,
    // rust: origin: [i32; 3],
    // rust: nested: &mut PlacedPlacer<'_, W, R>,
    // rust: ) -> TreeResult<bool, W::Error> {
    // rust: let feature = &*self.feature;
    // rust: if !self.claw {
    // rust: let mut pos = origin;
    // rust: let trunk = random.next_int_bound(3)? + 1;
    // rust: for _ in 0..trunk {
    // rust: if !nested(feature, world, random, pos)? {
    // rust: return Ok(true);
}
    // rust: pos = tb::offset(pos, 0, 1, 0);
}
    // rust: let top = pos;
    // rust: let branches = random.next_int_bound(3)? + 2;
    // rust: let mut directions = tb::HORIZONTAL;
    // rust: tb::shuffle(&mut directions, random)?;
    // rust: for &direction in directions.iter().take(branches as usize) {
    // rust: let mut pos = tb::relative(top, direction, 1);
    // rust: let height = random.next_int_bound(5)? + 2;
    // rust: let mut segment = 0;
    // rust: let mut j = 0;
    // rust: while j < height && nested(feature, world, random, pos)? {
    // rust: segment += 1;
    // rust: pos = tb::offset(pos, 0, 1, 0);
    // rust: if j == 0 || (segment >= 2 && random.next_float() < 0.25) {
    // rust: pos = tb::relative(pos, direction, 1);
    // rust: segment = 0;
}
    // rust: j += 1;
}
}
    // rust: return Ok(true);
}
    // rust: if !nested(feature, world, random, origin)? {
    // rust: return Ok(false);
}
    // rust: let claw = tb::HORIZONTAL[random.next_int_bound(4)? as usize];
    // rust: let branches = random.next_int_bound(2)? + 2;
    // rust: let mut possible = [claw, tb::clockwise(claw), counter_clockwise(claw)];
    // rust: tb::shuffle(&mut possible, random)?;
    // rust: for &branch in possible.iter().take(branches as usize) {
    // rust: let mut pos = origin;
    // rust: let sideways = random.next_int_bound(2)? + 1;
    // rust: pos = tb::relative(pos, branch, 1);
    // rust: let (segment, inway) = if branch == claw {
    // rust: (claw, random.next_int_bound(3)? + 2)
    // rust: } else {
    // rust: pos = tb::offset(pos, 0, 1, 0);
    // rust: let options = [branch, Direction::Up];
    // rust: let segment = options[random.next_int_bound(2)? as usize];
    // rust: (segment, random.next_int_bound(3)? + 3)
}
    // rust: let mut i = 0;
    // rust: while i < sideways && nested(feature, world, random, pos)? {
    // rust: pos = tb::relative(pos, segment, 1);
    // rust: i += 1;
}
    // rust: pos = tb::relative(pos, segment.opposite(), 1);
    // rust: pos = tb::offset(pos, 0, 1, 0);
    // rust: for _ in 0..inway {
    // rust: pos = tb::relative(pos, claw, 1);
    // rust: if !nested(feature, world, random, pos)? {
    // rust: break;
}
    // rust: if random.next_float() < 0.25 {
    // rust: pos = tb::offset(pos, 0, 1, 0);
}
}
}
    // rust: Ok(true)
}
}
    // rust: pub(crate) fn counter_clockwise(direction: Direction) -> Direction {
    // rust: match direction {
    // rust: Direction::North => Direction::West,
    // rust: Direction::East => Direction::North,
    // rust: Direction::South => Direction::East,
    // rust: Direction::West => Direction::South,
    // rust: other => other,
}
}

HugeMushroomFeature :: struct {
    red: bool,
    cap: BlockStateProvider,
    stem: BlockStateProvider,
    foliage_radius: i32,
    can_place_on: BlockPredicate,
    blocks: ^TreeBlocks,
}
    // rust: impl HugeMushroomFeature {
    // rust: pub(crate) fn decode(
    // rust: json: &str,
    // rust: bindings: &FeatureBlockBindings<'_>,
    // rust: depth: usize,
    // rust: remaining: &mut usize,
    // rust: ) -> Result<Self, DecodeError> {
    // rust: let object: Object = serde_json::from_str(json)?;
    // rust: let red = match kind(&object)?.as_str() {
    // rust: "minecraft:huge_red_mushroom" => true,
    // rust: "minecraft:huge_brown_mushroom" => false,
    // rust: _ => return Err(DecodeError::Field("huge mushroom type")),
}
    // rust: let blocks = bindings.tree_blocks()?;
    // rust: let mut decoder = TreeDecoder {
    // rust: bindings,
    // rust: depth,
    // rust: remaining,
}
    // rust: let cap = decoder.provider(required(&object, "cap_provider")?)?;
    // rust: let stem = decoder.provider(required(&object, "stem_provider")?)?;
    // rust: let foliage_radius = optional(&object, "foliage_radius")
    // rust: .map(super::integer)
    // rust: .transpose()?
    // rust: .unwrap_or(2);
    // rust: let can_place_on = BlockPredicate::decode_with_blocks(
    // rust: required(&object, "can_place_on")?.get(),
    // rust: depth + 1,
    // rust: decoder.remaining,
    // rust: Some(bindings),
    // rust: )?;
    // rust: Ok(Self {
    // rust: red,
    // rust: cap,
    // rust: stem,
    // rust: foliage_radius,
    // rust: can_place_on,
    // rust: blocks,
    // rust: })
}
radius_for_height :: proc(self: ^Self, tree_height: i32, leaf_radius: i32, yo: i32) -> i {
    // Ported from Horizon
    return {}
}
    // rust: if self.red {
    // rust: if (yo < tree_height && yo >= tree_height - 3) || yo == tree_height {
    // rust: leaf_radius
    // rust: } else {
    // rust: 0
}
    // rust: } else if yo <= 3 {
    // rust: 0
    // rust: } else {
    // rust: leaf_radius
}
}
    // rust: fn place_block<W: FeatureWorld>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: p: [i32; 3],
    // rust: state: BlockStateId,
    // rust: ) -> TreeResult<(), W::Error> {
    // rust: let current = read(world, p)?;
    // rust: if self.blocks.has(current, tb::AIR | tb::MUSHROOM_REPLACEABLE) {
    // rust: write(world, p, state, 3)?;
}
    // rust: Ok(())
}
faces :: proc(self: ^Self, state: BlockStateId, faces: ^[(string) {
}
    // rust: if faces
    // rust: .iter()
    // rust: .all(|(name, _)| self.blocks.properties.value(state, name).is_some())
    // rust: {
    // rust: faces.iter().fold(state, |state, (name, value)| {
    // rust: self.blocks
    // rust: .with(state, name, if *value { "true" } else { "false" })
    // rust: .unwrap_or(state)
    // rust: })
    // rust: } else {
    // rust: state
}
}
    // rust: pub(crate) fn place<W: FeatureWorld + PlacementContext, R: RandomSource>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: random: &mut R,
    // rust: origin: [i32; 3],
    // rust: ) -> TreeResult<bool, W::Error> {
    // rust: let mut height = random.next_int_bound(3)? + 4;
    // rust: if random.next_int_bound(12)? == 0 {
    // rust: height *= 2;
}
    // rust: let y = origin[1];
    // rust: let min = world.min_y().map_err(query)?;
    // rust: let max = world.max_y().map_err(query)?;
    // rust: if y < min.wrapping_add(1) || y.wrapping_add(height).wrapping_add(1) > max {
    // rust: return Ok(false);
}
    // rust: if !self
    // rust: .can_place_on
    // rust: .test(world, tb::offset(origin, 0, -1, 0))
    // rust: .map_err(query)?
    // rust: {
    // rust: return Ok(false);
}
    // rust: for dy in 0..=height {
    // rust: let radius = self.radius_for_height(-1, self.foliage_radius, dy);
    // rust: for dx in -radius..=radius {
    // rust: for dz in -radius..=radius {
    // rust: let state = read(world, tb::offset(origin, dx, dy, dz))?;
    // rust: if !self.blocks.has(state, tb::AIR | tb::LEAVES) {
    // rust: return Ok(false);
}
}
}
}
    // rust: let r = self.foliage_radius;
    // rust: if self.red {
    // rust: for dy in height - 3..=height {
    // rust: let radius = if dy < height { r } else { r - 1 };
    // rust: let center = r - 2;
    // rust: for dx in -radius..=radius {
    // rust: for dz in -radius..=radius {
    // rust: let x_edge = dx == -radius || dx == radius;
    // rust: let z_edge = dz == -radius || dz == radius;
    // rust: if dy >= height || x_edge != z_edge {
    // rust: let p = tb::offset(origin, dx, dy, dz);
    // rust: let state = sample_state(&self.cap, world, random, origin)?;
    // rust: let state = self.faces(
    // rust: state,
    // rust: &[
    // rust: ("west", dx < -center),
    // rust: ("east", dx > center),
    // rust: ("north", dz < -center),
    // rust: ("south", dz > center),
    // rust: ("up", dy >= height - 1),
    // rust: ],
    // rust: );
    // rust: self.place_block(world, p, state)?;
}
}
}
}
    // rust: } else {
    // rust: for dx in -r..=r {
    // rust: for dz in -r..=r {
    // rust: let (min_x, max_x, min_z, max_z) = (dx == -r, dx == r, dz == -r, dz == r);
    // rust: let x_edge = min_x || max_x;
    // rust: let z_edge = min_z || max_z;
    // rust: if !x_edge || !z_edge {
    // rust: let p = tb::offset(origin, dx, height, dz);
    // rust: let west = min_x || (z_edge && dx == 1 - r);
    // rust: let east = max_x || (z_edge && dx == r - 1);
    // rust: let north = min_z || (x_edge && dz == 1 - r);
    // rust: let south = max_z || (x_edge && dz == r - 1);
    // rust: let state = sample_state(&self.cap, world, random, origin)?;
    // rust: let state = self.faces(
    // rust: state,
    // rust: &[
    // rust: ("west", west),
    // rust: ("east", east),
    // rust: ("north", north),
    // rust: ("south", south),
    // rust: ],
    // rust: );
    // rust: self.place_block(world, p, state)?;
}
}
}
}
    // rust: for dy in 0..height {
    // rust: let state = sample_state(&self.stem, world, random, origin)?;
    // rust: self.place_block(world, tb::offset(origin, 0, dy, 0), state)?;
}
    // rust: Ok(true)
}
}

MultifaceGrowthFeature :: struct {
    block: BlockStateId,
    sculk: bool,
    search_range: i32,
    directions: [dynamic]Direction,
    chance_of_spreading: f32,
    can_be_placed_on: ^BTreeSet<BlockStateId>,
    blocks: ^TreeBlocks,
}
Spread :: enum {
    SamePosition,
    SamePlane,
    WrapAround,
}
    // rust: impl MultifaceGrowthFeature {
    // rust: pub(crate) fn decode(
    // rust: json: &str,
    // rust: bindings: &FeatureBlockBindings<'_>,
    // rust: ) -> Result<Self, DecodeError> {
    // rust: let object: Object = serde_json::from_str(json)?;
    // rust: if kind(&object)? != "minecraft:multiface_growth" {
    // rust: return Err(DecodeError::Field("multiface growth type"));
}
    // rust: let blocks = bindings.tree_blocks()?;
    // rust: let name = super::density::identifier(&serde_json::from_str::<String>(
    // rust: required(&object, "block")?.get(),
    // rust: )?)?;
        // The 26.3 MultifaceSpreadeableBlock subclasses.
    // rust: let sculk = match name.as_str() {
    // rust: "minecraft:glow_lichen" => false,
    // rust: "minecraft:sculk_vein" => true,
    // rust: _ => return Err(DecodeError::Field("multiface spreadeable block")),
}
    // rust: let block = blocks
    // rust: .default_state(&name)
    // rust: .ok_or(DecodeError::Field("multiface block"))?;
    // rust: let flag = |key: &str| -> Result<bool, DecodeError> {
    // rust: Ok(optional(&object, key)
    // rust: .map(|raw| serde_json::from_str::<bool>(raw.get()))
    // rust: .transpose()?
    // rust: .unwrap_or(false))
}
    // rust: let mut directions = Vec::new();
    // rust: if flag("can_place_on_ceiling")? {
    // rust: directions.push(Direction::Up);
}
    // rust: if flag("can_place_on_floor")? {
    // rust: directions.push(Direction::Down);
}
    // rust: if flag("can_place_on_wall")? {
    // rust: directions.extend(tb::HORIZONTAL);
}
    // rust: Ok(Self {
    // rust: block,
    // rust: sculk,
    // rust: search_range: optional(&object, "search_range")
    // rust: .map(|raw| int_range(raw, "search_range", 1, 64))
    // rust: .transpose()?
    // rust: .unwrap_or(10),
    // rust: directions,
    // rust: chance_of_spreading: optional(&object, "chance_of_spreading")
    // rust: .map(|raw| unit_float(raw, "chance_of_spreading"))
    // rust: .transpose()?
    // rust: .unwrap_or(0.5),
    // rust: can_be_placed_on: super::block_predicate::PredicateBlockResolver::predicate_block_set(
    // rust: bindings,
    // rust: required(&object, "can_be_placed_on")?.get(),
    // rust: )?,
    // rust: blocks,
    // rust: })
}
air_or_water :: proc(self: ^Self, state: BlockStateId) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.blocks.has(state, tb::AIR | tb::WATER_BLOCK)
}
is_block :: proc(self: ^Self, state: BlockStateId) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.blocks.same_block(state, self.block)
}
has_face :: proc(self: ^Self, state: BlockStateId, face: Direction) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.blocks
    // rust: .properties
    // rust: .value(state, tb::direction_name(face))
    // rust: == Some("true")
}
    // rust: pub(crate) fn place<W: FeatureWorld + PlacementContext, R: RandomSource>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: random: &mut R,
    // rust: origin: [i32; 3],
    // rust: ) -> TreeResult<bool, W::Error> {
    // rust: let here = read(world, origin)?;
    // rust: if !self.air_or_water(here) {
    // rust: return Ok(false);
}
    // rust: let mut directions = self.directions.clone();
    // rust: tb::shuffle(&mut directions, random)?;
    // rust: let here = read(world, origin)?;
    // rust: if self.place_growth(world, random, origin, here, &directions)? {
    // rust: return Ok(true);
}
    // rust: for &search in &directions {
    // rust: let mut placement: Vec<Direction> = self
    // rust: .directions
    // rust: .iter()
    // rust: .copied()
    // rust: .filter(|d| *d != search.opposite())
    // rust: .collect();
    // rust: tb::shuffle(&mut placement, random)?;
    // rust: for _ in 0..self.search_range {
                // Native setWithOffset(origin, ...) revisits the first neighbor.
    // rust: let pos = tb::relative(origin, search, 1);
    // rust: let state = read(world, pos)?;
    // rust: if !self.air_or_water(state) && !self.is_block(state) {
    // rust: break;
}
    // rust: if self.place_growth(world, random, pos, state, &placement)? {
    // rust: return Ok(true);
}
}
}
    // rust: Ok(false)
}
    // rust: fn place_growth<W: FeatureWorld + PlacementContext, R: RandomSource>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: random: &mut R,
    // rust: pos: [i32; 3],
    // rust: old: BlockStateId,
    // rust: directions: &[Direction],
    // rust: ) -> TreeResult<bool, W::Error> {
    // rust: for &direction in directions {
    // rust: let neighbor = read(world, tb::relative(pos, direction, 1))?;
    // rust: if self.can_be_placed_on.contains(&neighbor) {
    // rust: let Some(state) = self.state_for_placement(world, old, pos, direction)? else {
    // rust: return Ok(false);
}
    // rust: write(world, pos, state, 3)?;
    // rust: world.mark_postprocessing(pos).map_err(query)?;
    // rust: if random.next_float() < self.chance_of_spreading {
    // rust: let mut all = Direction::ALL;
    // rust: tb::shuffle(&mut all, random)?;
    // rust: for spread in all {
    // rust: if self.spread(world, state, pos, direction, spread)? {
    // rust: break;
}
}
}
    // rust: return Ok(true);
}
}
    // rust: Ok(false)
}
    // rust: fn valid_for_placement<W: FeatureWorld + PlacementContext>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: old: BlockStateId,
    // rust: pos: [i32; 3],
    // rust: direction: Direction,
    // rust: ) -> TreeResult<bool, W::Error> {
    // rust: if self.is_block(old) && self.has_face(old, direction) {
    // rust: return Ok(false);
}
    // rust: world.attachment_at(pos, direction).map_err(query)
}
    // rust: fn state_for_placement<W: FeatureWorld + PlacementContext>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: old: BlockStateId,
    // rust: pos: [i32; 3],
    // rust: direction: Direction,
    // rust: ) -> TreeResult<Option<BlockStateId>, W::Error> {
    // rust: if !self.valid_for_placement(world, old, pos, direction)? {
    // rust: return Ok(None);
}
    // rust: let state = if self.is_block(old) {
    // rust: old
    // rust: } else if self.blocks.has(old, tb::WATER_SOURCE) {
    // rust: self.blocks.waterlogged(self.block, true)
    // rust: } else {
    // rust: self.block
}
    // rust: Ok(Some(
    // rust: self.blocks
    // rust: .with(state, tb::direction_name(direction), "true")
    // rust: .ok_or(FeatureExecutionError::InvalidState)?,
    // rust: ))
}
spread_types :: proc(self: ^Self) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: [Spread::SamePosition, Spread::SamePlane, Spread::WrapAround]
}
    // spreadFromFaceTowardDirection with postProcess = true.
    // rust: fn spread<W: FeatureWorld + PlacementContext>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: state: BlockStateId,
    // rust: pos: [i32; 3],
    // rust: from: Direction,
    // rust: direction: Direction,
    // rust: ) -> TreeResult<bool, W::Error> {
    // rust: if tb::Axis::of(direction) == tb::Axis::of(from) {
    // rust: return Ok(false);
}
    // rust: let other_source = self.sculk && !self.blocks.has(state, tb::SCULK_VEIN);
    // rust: if !(other_source || (self.has_face(state, from) && !self.has_face(state, direction))) {
    // rust: return Ok(false);
}
    // rust: for kind in self.spread_types() {
    // rust: let (target, face) = match kind {
    // rust: Spread::SamePosition => (pos, direction),
    // rust: Spread::SamePlane => (tb::relative(pos, direction, 1), from),
    // rust: Spread::WrapAround => (
    // rust: tb::relative(tb::relative(pos, direction, 1), from, 1),
    // rust: direction.opposite(),
    // rust: ),
}
    // rust: if self.can_spread_into(world, pos, target, face)? {
    // rust: let old = read(world, target)?;
    // rust: let Some(new) = self.state_for_placement(world, old, target, face)? else {
    // rust: return Ok(false);
}
    // rust: world.mark_postprocessing(target).map_err(query)?;
    // rust: return write(world, target, new, 2);
}
}
    // rust: Ok(false)
}
    // rust: fn can_spread_into<W: FeatureWorld + PlacementContext>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: source: [i32; 3],
    // rust: target: [i32; 3],
    // rust: face: Direction,
    // rust: ) -> TreeResult<bool, W::Error> {
    // rust: let existing = read(world, target)?;
    // rust: let replaceable = if self.sculk {
    // rust: let against = read(world, tb::relative(target, face, 1))?;
    // rust: if self.blocks.has(against, tb::SCULK_BLOCKER) {
    // rust: false
    // rust: } else {
    // rust: let mut blocked = false;
    // rust: if tb::dist_manhattan(source, target) == 2 {
    // rust: let neighbor = tb::relative(source, face.opposite(), 1);
    // rust: let state = read(world, neighbor)?;
    // rust: blocked = world
    // rust: .state_face_sturdy(state, neighbor, face)
    // rust: .map_err(query)?;
}
    // rust: if blocked
    // rust: || (self.blocks.has(existing, tb::ANY_FLUID)
    // rust: && !self.blocks.has(existing, tb::WATER_SOURCE))
    // rust: || self.blocks.has(existing, tb::FIRE)
    // rust: {
    // rust: false
    // rust: } else {
    // rust: self.blocks.has(existing, tb::REPLACEABLE) || self.default_replaceable(existing)
}
}
    // rust: } else {
    // rust: self.default_replaceable(existing)
}
    // rust: Ok(replaceable && self.valid_for_placement(world, existing, target, face)?)
}
default_replaceable :: proc(self: ^Self, existing: BlockStateId) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.blocks.is_air(existing)
    // rust: || self.is_block(existing)
    // rust: || (self.blocks.has(existing, tb::WATER_BLOCK)
    // rust: && self.blocks.has(existing, tb::WATER_SOURCE))
}
}
