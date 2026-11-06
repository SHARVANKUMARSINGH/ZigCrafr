//! Transpiled from Horizon Rust crate
package horizon_world_pillars

import "core:fmt"
import "core:mem"
import "core:math"

// Processors that place blocks outside their template, carried as data from
// mods' Java processors (docs/modpacks.md):
// - `horizon:pillar` and `horizon:bottom_pillar`: Repurposed Structures' and
//   Moog's pillar processors, which run a column of blocks from a trigger
//   block (or the template's bottom layer) down to the ground;
// - `horizon:close_off_fluid_sources`: their fluid fix, which walls off the
//   water and lava sources around a structure's open blocks;
// - `horizon:close_off_air_sources`: Repurposed Structures' opposite fix,
//   which walls off the air and other liquids around a structure's fluids
//   (its ocean mineshafts);
// - `horizon:yung_pillar` and `horizon:stair_pillar`: YUNG's pillar
//   processor (Better Fortresses, Better Jungle Temples) and Better
//   Fortresses' stair supports.
//
// Each runs while the template is processed, before its blocks are placed,
// and writes the world as the mods do (`ChunkAccess.setBlockState` or a
// chunk section). As in the mods, only blocks of the chunk being generated
// write: the placement's bounding box is that chunk.
// use super::{PlaceSettings, ProcessResult, ProcessorList, ProcessorRandom, process_list};
// use crate::{
    // rust: block_properties::{BoundBlockProperty, BoundOcclusionFaces},
    // rust: fluid::{FluidKind, FluidStateTable},
    // rust: registry::BlockStateId,
    // rust: worldgen::{
    // rust: DecodeError,
    // rust: block_feature::FeatureBlockBindings,
    // rust: placement::{PlacementContext, PlacementQueryError},
    // rust: structure::{BlockInfo, StructureResources},
    // rust: },
}
// use horizon_core::geometry::Direction;
// use serde_json::Value;
// use std::{collections::BTreeSet, sync::Arc};

// Blocks whose `defaultDestroyTime` is negative in 26.3 (unbreakable):
// forced pillars go through every block but these.
    // rust: const UNBREAKABLE: [&str; 15] = [
    // rust: "minecraft:barrier",
    // rust: "minecraft:bedrock",
    // rust: "minecraft:chain_command_block",
    // rust: "minecraft:command_block",
    // rust: "minecraft:end_gateway",
    // rust: "minecraft:end_portal",
    // rust: "minecraft:end_portal_frame",
    // rust: "minecraft:jigsaw",
    // rust: "minecraft:light",
    // rust: "minecraft:moving_piston",
    // rust: "minecraft:nether_portal",
    // rust: "minecraft:repeating_command_block",
    // rust: "minecraft:structure_block",
    // rust: "minecraft:test_block",
    // rust: "minecraft:test_instance_block",
    // rust: ];

// What the processors ask of a block state.
Blocks :: struct {
    // Air, cave air and void air (BlockState.isAir).
    air: [BlockStateId,
    fluids: ^FluidStateTable,
    can_occlude: BoundBlockProperty,
    // BlockState.isSolid (legacy solidity), for blocksMotion.
    solid: BoundBlockProperty,
    occlusion: BoundOcclusionFaces,
    replaceable_by_trees: ^BTreeSet<BlockStateId>,
    unbreakable: BTreeSet<BlockStateId>,
    // Cobweb and bamboo sapling, which never block motion.
    no_motion: BTreeSet<BlockStateId>,
    structure_void: BTreeSet<BlockStateId>,
    // Water and lava blocks (LiquidBlock), at every level.
    liquid_blocks: BTreeSet<BlockStateId>,
}
    // rust: impl Blocks {
decode :: proc(bindings: ^FeatureBlockBindings<'_>) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let block_set = |names: &[&str]| -> BTreeSet<BlockStateId> {
    // rust: names
    // rust: .iter()
    // rust: .flat_map(|n| bindings.blocks.get(*n).into_iter().flat_map(|s| s.iter()))
    // rust: .copied()
    // rust: .collect()
}
    // rust: let missing = || DecodeError::Field("pillar processor block properties");
    // rust: Ok(Self {
    // rust: air: bindings.air,
    // rust: fluids: bindings.fluids.table().clone(),
    // rust: can_occlude: bindings.can_occlude.clone().ok_or_else(missing)?,
    // rust: solid: bindings.solid()?,
    // rust: occlusion: bindings.occlusion_faces.clone().ok_or_else(missing)?,
    // rust: replaceable_by_trees: bindings
    // rust: .tags
    // rust: .get("minecraft:replaceable_by_trees")
    // rust: .cloned()
    // rust: .unwrap_or_default(),
    // rust: unbreakable: block_set(&UNBREAKABLE),
    // rust: no_motion: block_set(&["minecraft:cobweb", "minecraft:bamboo_sapling"]),
    // rust: structure_void: block_set(&["minecraft:structure_void"]),
    // rust: liquid_blocks: block_set(&["minecraft:water", "minecraft:lava"]),
    // rust: })
}
air :: proc(self: ^Self, state: BlockStateId) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.air.contains(&state)
}
    // `!getFluidState().isEmpty()`.
fluid :: proc(self: ^Self, state: BlockStateId) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.fluid_kind(state) != FluidKind::Empty
}
    // `getFluidState().getType()`: flowing and still fluids are two.
fluid_kind :: proc(self: ^Self, state: BlockStateId) -> F {
    // Ported from Horizon
    return {}
}
    // rust: self.fluids
    // rust: .get(state)
    // rust: .map_or(FluidKind::Empty, |f| f.kind())
}
    // What a pillar goes through: blocks that cannot occlude, and when
    // forced every block that can be broken.
passable :: proc(self: ^Self, state: BlockStateId, forced: bool) -> b {
    // Ported from Horizon
    return {}
}
    // rust: (forced && !self.unbreakable.contains(&state)) || !self.can_occlude.contains(state)
}
    // GeneralUtils.isReplaceableByStructures.
replaceable :: proc(self: ^Self, state: BlockStateId) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.air(state) || self.fluid(state) || self.replaceable_by_trees.contains(&state)
}
    // GeneralUtils.isFullCube: the occlusion shape is the full block.
full_cube :: proc(self: ^Self, state: BlockStateId) -> b {
    // Ported from Horizon
    return {}
}
    // rust: Direction::ALL
    // rust: .into_iter()
    // rust: .all(|d| self.occlusion.is_full(state, d).unwrap_or(false))
}
    // BlockState.blocksMotion.
blocks_motion :: proc(self: ^Self, state: BlockStateId) -> b {
    // Ported from Horizon
    return {}
}
    // rust: !self.no_motion.contains(&state) && self.solid.contains(state)
}
}

// The world's block at `pos`; void air outside the build height (a chunk's
// read there).
    // rust: fn read<W: PlacementContext>(
    // rust: world: &mut W,
    // rust: blocks: &Blocks,
    // rust: pos: [i32; 3],
    // rust: ) -> Result<BlockStateId, PlacementQueryError> {
    // rust: Ok(world.section_block(pos)?.unwrap_or(blocks.air[2]))
}

// Whether `pos` is outside the chunk being generated (WorldGenRegion's
// centre): the placement's bounding box, by column.
    // rust: pub(super) fn outside_chunk(settings: &PlaceSettings<'_>, pos: [i32; 3]) -> bool {
    // rust: settings.bounding_box.is_some_and(|b| {
    // rust: pos[0] < b.min[0] || pos[0] > b.max[0] || pos[2] < b.min[2] || pos[2] > b.max[2]
    // rust: })
}

// GeneralUtils.getFirstLandYFromPos: down from `pos` past air, fluids and
// blocks trees replace.
    // rust: fn first_land_y<W: PlacementContext>(
    // rust: world: &mut W,
    // rust: blocks: &Blocks,
    // rust: pos: [i32; 3],
    // rust: ) -> Result<i32, PlacementQueryError> {
    // rust: let min = world.min_y()?;
    // rust: let mut y = pos[1];
    // rust: while y >= min && blocks.replaceable(read(world, blocks, [pos[0], y, pos[2]])?) {
    // rust: y -= 1;
}
    // rust: Ok(y)
}

// Vec3i.closerThan: the squared distance under `length` squared.
closer_than :: proc(a: [i32; 3], b: [i32; 3], length: i32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let d: i64 = (0..3).map(|i| i64::from(a[i] - b[i]).pow(2)).sum();
    // rust: (d as f64) < f64::from(length) * f64::from(length)
}

// Direction's serialized names, in Direction.values() order.
DIRECTION_NAMES :: ["down", "up", "north", "south", "west", "east"]

direction :: proc(name: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let i = DIRECTION_NAMES
    // rust: .iter()
    // rust: .position(|n| *n == name)
    // rust: .ok_or(DecodeError::Field("direction"))?;
    // rust: Ok(Direction::ALL[i])
}

direction_name :: proc(d: Direction) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: DIRECTION_NAMES[Direction::ALL.iter().position(|x| *x == d).unwrap_or(0)]
}

add :: proc(pos: [i32; 3], d: Direction) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: let n = d.normal();
    // rust: [pos[0] + n[0], pos[1] + n[1], pos[2] + n[2]]
}

// The processor list a pillar runs on each of its blocks: a list holder
// (a name or the processors), none when absent or `minecraft:empty`.
    // rust: fn nested(
    // rust: v: Option<&Value>,
    // rust: resources: &StructureResources,
    // rust: bindings: &FeatureBlockBindings<'_>,
    // rust: ) -> Result<Option<ProcessorList>, DecodeError> {
    // rust: match v {
    // rust: None => Ok(None),
    // rust: Some(Value::String(s)) if s == "minecraft:empty" => Ok(None),
    // rust: Some(v) => Ok(Some(ProcessorList::decode(
    // rust: &v.to_string(),
    // rust: resources,
    // rust: bindings,
    // rust: )?)),
}
}

// Runs a pillar's processor list on one of its blocks, as the mods do:
// the block's template position is its offset from the trigger plus the
// piece's position, and it stands for the piece's and pivot's too.
    // rust: fn run_nested<W: PlacementContext>(
    // rust: list: Option<&ProcessorList>,
    // rust: world: &mut W,
    // rust: resources: &StructureResources,
    // rust: position: [i32; 3],
    // rust: origin: [i32; 3],
    // rust: at: [i32; 3],
    // rust: state: BlockStateId,
    // rust: settings: &mut PlaceSettings<'_>,
    // rust: ) -> ProcessResult {
    // rust: let info = BlockInfo {
    // rust: pos: at,
    // rust: state,
    // rust: nbt: None,
}
    // rust: let Some(list) = list else {
    // rust: return Ok(Some(info));
}
    // rust: let local = std::array::from_fn(|i| at[i] - origin[i] + position[i]);
    // rust: process_list(list, world, resources, local, at, local, info, settings)
}

// Moog's `pillar_state_randomizer`: the first entry whose share of
// `[0, 1)` holds one `nextFloat` and whose height range holds the block.
HeightRandomizer :: struct {
    entries: Vec<(BlockStateId,
    default: BlockStateId,
}
    // rust: impl HeightRandomizer {
    // rust: fn decode(
    // rust: v: &Value,
    // rust: state: &impl Fn(&Value) -> Result<BlockStateId, DecodeError>,
    // rust: ) -> Result<Self, DecodeError> {
    // rust: let entries = v["entries"]
    // rust: .as_array()
    // rust: .map(Vec::as_slice)
    // rust: .unwrap_or_default()
    // rust: .iter()
    // rust: .map(|e| {
    // rust: let y = |k: &str| e.get(k).and_then(Value::as_i64).map(|y| y as i32);
    // rust: let p = e["probability"]
    // rust: .as_f64()
    // rust: .ok_or(DecodeError::Field("randomizer probability"))?;
    // rust: Ok((state(&e["block"])?, p as f32, y("min_y"), y("max_y")))
    // rust: })
    // rust: .collect::<Result<_, DecodeError>>()?;
    // rust: Ok(Self {
    // rust: entries,
    // rust: default: state(&v["default"])?,
    // rust: })
}
get :: proc(self: ^Self, random: ^dyn ProcessorRandom, y: i32) -> B {
    // Ported from Horizon
    return {}
}
    // rust: let target = random.float();
    // rust: let mut bottom = 0f32;
    // rust: for &(state, p, min, max) in &self.entries {
    // rust: let in_range = min.is_none_or(|m| y >= m) && max.is_none_or(|m| y <= m);
    // rust: if bottom <= target && target < bottom + p && in_range {
    // rust: return state;
}
    // rust: bottom += p;
}
    // rust: self.default
}
}

// `horizon:pillar`: Repurposed Structures' and Moog's PillarProcessor. A
// trigger state becomes `original_replaced_block` (or its replacement;
// structure void removes it) and starts a column of the replacement, or
// of Moog's randomizer's states, in `direction` through blocks that do not
// occlude (with `forced_placement`, through all but unbreakable ones),
// down to the first land, within `pillar_length` of the trigger.
Pillar :: struct {
    triggers: Vec<(BlockStateId,
    list: Maybe(ProcessorList),
    direction: Direction,
    original: Maybe(BlockStateId),
    length: i32,
    forced: bool,
    randomizer: Maybe(HeightRandomizer),
    blocks: Blocks,
}
    // rust: impl Pillar {
    // rust: pub(super) fn decode(
    // rust: v: &Value,
    // rust: resources: &StructureResources,
    // rust: bindings: &FeatureBlockBindings<'_>,
    // rust: state: impl Fn(&Value) -> Result<BlockStateId, DecodeError>,
    // rust: ) -> Result<Self, DecodeError> {
    // rust: let triggers = v["pillar_trigger_and_replacements"]
    // rust: .as_array()
    // rust: .ok_or(DecodeError::Field("pillar_trigger_and_replacements"))?
    // rust: .iter()
    // rust: .map(|p| Ok((state(&p["trigger"])?, state(&p["replacement"])?)))
    // rust: .collect::<Result<_, DecodeError>>()?;
    // rust: Ok(Self {
    // rust: triggers,
    // rust: list: nested(v.get("pillar_processor_list"), resources, bindings)?,
    // rust: direction: direction(v["direction"].as_str().unwrap_or("down"))?,
    // rust: original: v.get("original_replaced_block").map(&state).transpose()?,
    // rust: length: v["pillar_length"].as_i64().unwrap_or(1000) as i32,
    // rust: forced: v["forced_placement"].as_bool().unwrap_or(false),
    // rust: randomizer: v
    // rust: .get("pillar_state_randomizer")
    // rust: .map(|r| HeightRandomizer::decode(r, &state))
    // rust: .transpose()?,
    // rust: blocks: Blocks::decode(bindings)?,
    // rust: })
}
    // rust: pub(super) fn process<W: PlacementContext>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: resources: &StructureResources,
    // rust: position: [i32; 3],
    // rust: info: BlockInfo,
    // rust: settings: &mut PlaceSettings<'_>,
    // rust: ) -> ProcessResult {
    // rust: let Some(&(_, replacement)) = self.triggers.iter().find(|t| t.0 == info.state) else {
    // rust: return Ok(Some(info));
}
    // rust: let origin = info.pos;
    // rust: let kept = self.original.unwrap_or(replacement);
    // rust: let result = (!self.blocks.structure_void.contains(&kept)).then_some(BlockInfo {
    // rust: pos: origin,
    // rust: state: kept,
    // rust: nbt: None,
    // rust: });
    // rust: if outside_chunk(settings, origin) {
    // rust: return Ok(result);
}
    // rust: let mut terrain_y = i32::MIN;
    // rust: if self.direction == Direction::Down && !self.forced {
    // rust: terrain_y = first_land_y(world, &self.blocks, origin)?;
    // rust: let min = world.min_y()?;
    // rust: if terrain_y <= min && self.length + 2 >= origin[1] - min {
    // rust: return Ok(result);
}
}
        // The column starts at the trigger, tested by the block past it.
    // rust: let mut at = origin;
    // rust: let mut block = read(world, &self.blocks, add(origin, self.direction))?;
    // rust: while self.blocks.passable(block, self.forced) {
    // rust: if (!self.forced && at[1] < terrain_y)
    // rust: || world.outside_build_height(at[1])?
    // rust: || !closer_than(at, origin, self.length)
    // rust: {
    // rust: break;
}
    // rust: let fill = match &self.randomizer {
    // rust: Some(r) => settings.with_random(at, |random| r.get(random, at[1])),
    // rust: None => replacement,
}
    // rust: let placed = run_nested(
    // rust: self.list.as_ref(),
    // rust: world,
    // rust: resources,
    // rust: position,
    // rust: origin,
    // rust: at,
    // rust: fill,
    // rust: settings,
    // rust: )?;
    // rust: if let Some(placed) = placed {
    // rust: world.set_chunk_block(at, placed.state)?;
}
    // rust: at = add(at, self.direction);
    // rust: block = read(world, &self.blocks, at)?;
}
    // rust: Ok(result)
}
}

// `horizon:bottom_pillar`: Repurposed Structures' BottomPillarProcessor.
// Each block of the template's bottom layer continues down as itself (run
// through `pillar_processor_list`) through blocks that do not occlude, over
// a first gap of one block, within `pillar_length`.
BottomPillar :: struct {
    list: Maybe(ProcessorList),
    length: i32,
    forced: bool,
    blocks: Blocks,
}
    // rust: impl BottomPillar {
    // rust: pub(super) fn decode(
    // rust: v: &Value,
    // rust: resources: &StructureResources,
    // rust: bindings: &FeatureBlockBindings<'_>,
    // rust: ) -> Result<Self, DecodeError> {
    // rust: Ok(Self {
    // rust: list: nested(v.get("pillar_processor_list"), resources, bindings)?,
    // rust: length: v["pillar_length"].as_i64().unwrap_or(1000) as i32,
    // rust: forced: v["forced_placement"].as_bool().unwrap_or(false),
    // rust: blocks: Blocks::decode(bindings)?,
    // rust: })
}
    // `relative` is the block's position in the template.
    // rust: pub(super) fn process<W: PlacementContext>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: resources: &StructureResources,
    // rust: position: [i32; 3],
    // rust: relative: [i32; 3],
    // rust: info: BlockInfo,
    // rust: settings: &mut PlaceSettings<'_>,
    // rust: ) -> ProcessResult {
    // rust: if relative[1] != 0 || outside_chunk(settings, info.pos) {
    // rust: return Ok(Some(info));
}
    // rust: let origin = info.pos;
    // rust: if !self.forced {
    // rust: let terrain_y = first_land_y(world, &self.blocks, origin)?;
    // rust: let min = world.min_y()?;
    // rust: if terrain_y <= min && self.length + 2 >= origin[1] - min {
    // rust: return Ok(Some(info));
}
}
    // rust: let below = |pos: [i32; 3]| [pos[0], pos[1] - 1, pos[2]];
    // rust: let valid = |world: &mut W, at: [i32; 3]| -> Result<bool, PlacementQueryError> {
    // rust: let block = read(world, &self.blocks, at)?;
    // rust: Ok(self.blocks.passable(block, self.forced)
    // rust: && !world.outside_build_height(at[1])?
    // rust: && closer_than(at, origin, self.length))
}
    // rust: let mut at = below(origin);
    // rust: let mut layer = valid(world, at)?;
        // A one-block gap under the bottom layer is filled too.
    // rust: let mut skip_first = valid(world, below(at))?;
    // rust: while skip_first || layer {
    // rust: skip_first = false;
    // rust: let placed = run_nested(
    // rust: self.list.as_ref(),
    // rust: world,
    // rust: resources,
    // rust: position,
    // rust: origin,
    // rust: at,
    // rust: info.state,
    // rust: settings,
    // rust: )?;
    // rust: if let Some(placed) = placed {
    // rust: world.set_chunk_block(at, placed.state)?;
}
    // rust: at = below(at);
    // rust: layer = valid(world, at)?;
}
    // rust: Ok(Some(info))
}
}

// `horizon:close_off_fluid_sources`: Repurposed Structures' and Moog's
// CloseOffFluidSourcesProcessor. Around each block that is not a full,
// motion-blocking cube, the fluid sources beside it (not below with
// `ignore_down`) become a block drawn by weight; with `if_air_in_world`
// only where the world holds air at the block.
CloseOffFluidSources :: struct {
    replacements: Vec<(BlockStateId,
    ignore_down: bool,
    if_air: bool,
    blocks: Blocks,
}
    // rust: impl CloseOffFluidSources {
    // rust: pub(super) fn decode(
    // rust: v: &Value,
    // rust: resources: &StructureResources,
    // rust: bindings: &FeatureBlockBindings<'_>,
    // rust: ) -> Result<Self, DecodeError> {
    // rust: let replacements = weighted_blocks(v, resources)?;
    // rust: Ok(Self {
    // rust: replacements,
    // rust: ignore_down: v["ignore_down"].as_bool().unwrap_or(false),
    // rust: if_air: v["if_air_in_world"].as_bool().unwrap_or(false),
    // rust: blocks: Blocks::decode(bindings)?,
    // rust: })
}
    // rust: pub(super) fn process<W: PlacementContext>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: info: BlockInfo,
    // rust: settings: &mut PlaceSettings<'_>,
    // rust: ) -> ProcessResult {
    // rust: let state = info.state;
    // rust: if self.blocks.structure_void.contains(&state)
    // rust: || self.blocks.fluid(state)
    // rust: || outside_chunk(settings, info.pos)
    // rust: || (self.blocks.full_cube(state) && self.blocks.blocks_motion(state))
    // rust: {
    // rust: return Ok(Some(info));
}
    // rust: if self.if_air && !self.blocks.air(read(world, &self.blocks, info.pos)?) {
    // rust: return Ok(Some(info));
}
        // Direction.values(): down, up, north, south, west, east.
    // rust: for d in Direction::ALL {
    // rust: if self.ignore_down && d == Direction::Down {
    // rust: continue;
}
    // rust: let at = add(info.pos, d);
    // rust: if world.outside_build_height(at[1])? || !world.fluid_state(at)?.is_source() {
    // rust: continue;
}
    // rust: let block = settings.with_random(info.pos, |random| pick(&self.replacements, random));
    // rust: world.set_section_block(at, block)?;
}
    // rust: Ok(Some(info))
}
}

// `horizon:close_off_air_sources`: Repurposed Structures'
// CloseOffAirSourcesProcessor. Around each template block holding a fluid,
// the world's air beside it, and liquid blocks of another fluid (flowing and
// still count as two), become a block drawn by weight (none drawn for a
// single block), so the water of its ocean mineshafts does not pour into
// caves. Neighbours in other chunks are written too, as the mod writes
// their sections.
CloseOffAirSources :: struct {
    replacements: Vec<(BlockStateId,
    blocks: Blocks,
}
    // rust: impl CloseOffAirSources {
    // rust: pub(super) fn decode(
    // rust: v: &Value,
    // rust: resources: &StructureResources,
    // rust: bindings: &FeatureBlockBindings<'_>,
    // rust: ) -> Result<Self, DecodeError> {
    // rust: Ok(Self {
    // rust: replacements: weighted_blocks(v, resources)?,
    // rust: blocks: Blocks::decode(bindings)?,
    // rust: })
}
    // rust: pub(super) fn process<W: PlacementContext>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: info: BlockInfo,
    // rust: settings: &mut PlaceSettings<'_>,
    // rust: ) -> ProcessResult {
    // rust: let fluid = self.blocks.fluid_kind(info.state);
    // rust: if outside_chunk(settings, info.pos) || fluid == FluidKind::Empty {
    // rust: return Ok(Some(info));
}
        // Direction.values(): down, up, north, south, west, east.
    // rust: for d in Direction::ALL {
    // rust: let at = add(info.pos, d);
    // rust: if world.outside_build_height(at[1])? {
    // rust: continue;
}
    // rust: let Some(beside) = world.section_block(at)? else {
    // rust: continue;
}
    // rust: let other_liquid = self.blocks.liquid_blocks.contains(&beside)
    // rust: && self.blocks.fluid_kind(beside) != fluid;
    // rust: if self.blocks.air(beside) || other_liquid {
                // One block draws nothing: the settings' random is shared.
    // rust: let block = match self.replacements.as_slice() {
    // rust: [(only, _)] => *only,
    // rust: _ => settings.with_random(info.pos, |random| pick(&self.replacements, random)),
}
    // rust: world.set_section_block(at, block)?;
}
}
    // rust: Ok(Some(info))
}
}

// `weighted_list_of_replacement_blocks`: blocks by name with their weight,
// at least one.
    // rust: fn weighted_blocks(
    // rust: v: &Value,
    // rust: resources: &StructureResources,
    // rust: ) -> Result<Vec<(BlockStateId, i32)>, DecodeError> {
    // rust: let replacements = v["weighted_list_of_replacement_blocks"]
    // rust: .as_array()
    // rust: .ok_or(DecodeError::Field("weighted_list_of_replacement_blocks"))?
    // rust: .iter()
    // rust: .map(|e| {
    // rust: let name = e["block"].as_str().ok_or(DecodeError::Field("block"))?;
    // rust: let name = crate::worldgen::tags::identifier(name)?;
    // rust: let state = resources
    // rust: .registry
    // rust: .default_state(&name)
    // rust: .ok_or_else(|| DecodeError::Registry(format!("unknown block {name}")))?;
    // rust: let weight = e["weight"].as_i64().ok_or(DecodeError::Field("weight"))?;
    // rust: Ok((state, weight as i32))
    // rust: })
    // rust: .collect::<Result<Vec<_>, DecodeError>>()?;
    // rust: if replacements.is_empty() {
    // rust: return Err(DecodeError::Field("weighted_list_of_replacement_blocks"));
}
    // rust: Ok(replacements)
}

// GeneralUtils.getRandomEntry: `nextFloat() * total` less each weight in
// turn, the last entry when none takes it.
pick :: proc(entries: ^[(BlockStateId) {
}
    // rust: let total: f64 = entries.iter().map(|r| f64::from(r.1)).sum();
    // rust: let mut picked = f64::from(random.float()) * total;
    // rust: let mut index = 0;
    // rust: while index < entries.len() - 1 {
    // rust: picked -= f64::from(entries[index].1);
    // rust: if picked <= 0.0 {
    // rust: break;
}
    // rust: index += 1;
}
    // rust: entries[index].0
}

// YUNG's BlockStateRandomizer: the first entry whose share of `[0, 1)`
// holds one `nextFloat` (and whose altitude condition passes, when asked
// with a height), else the default.
YungRandomizer :: struct {
    entries: Vec<(BlockStateId,
    default: BlockStateId,
}
    // rust: impl YungRandomizer {
    // rust: fn decode(
    // rust: v: &Value,
    // rust: state: &impl Fn(&Value) -> Result<BlockStateId, DecodeError>,
    // rust: ) -> Result<Self, DecodeError> {
    // rust: let entries = v["entries"]
    // rust: .as_array()
    // rust: .ok_or(DecodeError::Field("randomizer entries"))?
    // rust: .iter()
    // rust: .map(|e| {
    // rust: let p = e["probability"]
    // rust: .as_f64()
    // rust: .ok_or(DecodeError::Field("randomizer probability"))?;
                // yungsapi:altitude, the one condition the mods' pillars use.
    // rust: let (bottom, top) = match e.get("condition") {
    // rust: None => (None, None),
    // rust: Some(c) if c["type"] == "yungsapi:altitude" => {
    // rust: (c["bottom_cutoff_y"].as_f64(), c["top_cutoff_y"].as_f64())
}
    // rust: Some(_) => return Err(DecodeError::Field("randomizer condition")),
}
    // rust: Ok((state(&e["blockState"])?, p as f32, bottom, top))
    // rust: })
    // rust: .collect::<Result<_, DecodeError>>()?;
    // rust: Ok(Self {
    // rust: entries,
    // rust: default: state(&v["defaultBlockState"])?,
    // rust: })
}
    // `get(random)` with no height, `get(random, ctx)` with the block's.
get :: proc(self: ^Self, random: ^dyn ProcessorRandom, y: Maybe(i32)) -> B {
    // Ported from Horizon
    return {}
}
    // rust: let target = random.float();
    // rust: let mut bottom = 0f32;
    // rust: for &(state, p, low, high) in &self.entries {
    // rust: let passes = y.is_none_or(|y| {
    // rust: let y = f64::from(y);
    // rust: !low.is_some_and(|l| y < l) && !high.is_some_and(|h| y > h)
    // rust: });
    // rust: if bottom <= target && target < bottom + p && passes {
    // rust: return state;
}
    // rust: bottom += p;
}
    // rust: self.default
}
}

// `horizon:yung_pillar`: YUNG's PillarProcessor. A block of `target_block`
// becomes a draw of `target_block_output`, and a column of
// `pillar_states` runs down from it through air and fluids, all drawn from
// the placement's random at the block.
YungPillar :: struct {
    target: string,
    output: YungRandomizer,
    pillar: YungRandomizer,
    // The output and the column take the target's properties
    // (Block.withPropertiesOf: Better Witch Huts' fence legs).
    keep_properties: bool,
    blocks: Blocks,
}
    // rust: impl YungPillar {
    // rust: pub(super) fn decode(
    // rust: v: &Value,
    // rust: bindings: &FeatureBlockBindings<'_>,
    // rust: state: impl Fn(&Value) -> Result<BlockStateId, DecodeError>,
    // rust: ) -> Result<Self, DecodeError> {
    // rust: let target = state(&v["target_block"])?;
    // rust: Ok(Self {
    // rust: target: bindings.registry().state(target).unwrap().name.clone(),
    // rust: output: YungRandomizer::decode(&v["target_block_output"], &state)?,
    // rust: pillar: YungRandomizer::decode(&v["pillar_states"], &state)?,
    // rust: keep_properties: v["keep_properties"].as_bool().unwrap_or(false),
    // rust: blocks: Blocks::decode(bindings)?,
    // rust: })
}
    // rust: pub(super) fn process<W: PlacementContext>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: resources: &StructureResources,
    // rust: info: BlockInfo,
    // rust: settings: &mut PlaceSettings<'_>,
    // rust: ) -> ProcessResult {
    // rust: let name = resources
    // rust: .registry
    // rust: .state(info.state)
    // rust: .map(|s| s.name.as_str());
    // rust: if name != Some(self.target.as_str()) || outside_chunk(settings, info.pos) {
    // rust: return Ok(Some(info));
}
    // rust: let (min, max) = (world.min_y()?, world.max_y()?);
    // rust: let origin = info.pos;
    // rust: let registry = &resources.registry;
    // rust: let kept = |state: BlockStateId| match self.keep_properties {
    // rust: true => registry
    // rust: .state(state)
    // rust: .and_then(|s| super::with_properties_of(registry, &s.name, info.state))
    // rust: .unwrap_or(state),
    // rust: false => state,
}
    // rust: settings.with_random(origin, |random| {
    // rust: let state = kept(self.output.get(random, None));
    // rust: let mut at = [origin[0], origin[1] - 1, origin[2]];
    // rust: while at[1] > min && at[1] <= max {
    // rust: let block = read(world, &self.blocks, at)?;
    // rust: if !(self.blocks.air(block) || self.blocks.fluid(block)) {
    // rust: break;
}
    // rust: world.set_chunk_block(at, kept(self.pillar.get(random, Some(at[1]))))?;
    // rust: at[1] -= 1;
}
    // rust: Ok(Some(BlockInfo { state, ..info }))
    // rust: })
}
}

// `horizon:stair_pillar`: Better Fortresses' StairPillarProcessor. A stair
// block in `blocks` becomes its target (facing, half and shape kept when it
// is a stair); the block it faces becomes a `front` stair facing back, with
// a column of `pillar` under it through air and fluids.
StairPillar :: struct {
    blocks_to: Vec<(string,
    front: string,
    pillar: BlockStateId,
    blocks: Blocks,
}
    // rust: impl StairPillar {
    // rust: pub(super) fn decode(
    // rust: v: &Value,
    // rust: resources: &StructureResources,
    // rust: bindings: &FeatureBlockBindings<'_>,
    // rust: ) -> Result<Self, DecodeError> {
    // rust: let id = |v: &Value| -> Result<String, DecodeError> {
    // rust: let name = v.as_str().ok_or(DecodeError::Field("stair_pillar block"))?;
    // rust: Ok(crate::worldgen::tags::identifier(name)?.to_string())
}
    // rust: let blocks_to = v["blocks"]
    // rust: .as_object()
    // rust: .ok_or(DecodeError::Field("stair_pillar blocks"))?
    // rust: .iter()
    // rust: .map(|(from, to)| Ok((id(&Value::String(from.clone()))?, id(to)?)))
    // rust: .collect::<Result<_, DecodeError>>()?;
    // rust: let pillar = id(&v["pillar"])?;
    // rust: Ok(Self {
    // rust: blocks_to,
    // rust: front: id(&v["front"])?,
    // rust: pillar: resources
    // rust: .registry
    // rust: .default_state(&pillar)
    // rust: .ok_or_else(|| DecodeError::Registry(format!("unknown block {pillar}")))?,
    // rust: blocks: Blocks::decode(bindings)?,
    // rust: })
}
    // `block`'s default state with the stair properties of `from` it has.
    // rust: fn stair(
    // rust: resources: &StructureResources,
    // rust: block: &str,
    // rust: from: &crate::chunk::BlockProperties,
    // rust: facing: Option<&str>,
    // rust: ) -> Option<BlockStateId> {
    // rust: let registry = resources.registry;
    // rust: let mut state = registry.state(registry.default_state(block)?)?.clone();
    // rust: for key in ["facing", "half", "shape"] {
    // rust: let value = match (key, facing) {
    // rust: ("facing", Some(f)) => f,
    // rust: _ => from.get(key)?.as_str(),
}
    // rust: if state.properties.contains_key(key) {
    // rust: state.properties.insert(key.to_owned(), value.to_owned());
}
}
    // rust: registry.id(&state)
}
    // rust: pub(super) fn process<W: PlacementContext>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: resources: &StructureResources,
    // rust: info: BlockInfo,
    // rust: settings: &mut PlaceSettings<'_>,
    // rust: ) -> ProcessResult {
    // rust: let Some(old) = resources.registry.state(info.state) else {
    // rust: return Ok(Some(info));
}
    // rust: let Some((_, to)) = self.blocks_to.iter().find(|(from, _)| *from == old.name) else {
    // rust: return Ok(Some(info));
}
    // rust: let props = &old.properties;
    // rust: let Some(facing) = props.get("facing").and_then(|f| direction(f).ok()) else {
    // rust: return Ok(Some(info));
}
    // rust: let Some(output) = Self::stair(resources, to, props, None) else {
    // rust: return Ok(Some(info));
}
    // rust: let info = BlockInfo {
    // rust: state: output,
    // rust: ..info
}
    // rust: let mut at = add(info.pos, facing);
    // rust: if outside_chunk(settings, at) {
    // rust: return Ok(Some(info));
}
    // rust: let back = direction_name(facing.opposite());
    // rust: if let Some(front) = Self::stair(resources, &self.front, props, Some(back)) {
    // rust: world.set_chunk_block(at, front)?;
}
    // rust: let (min, max) = (world.min_y()?, world.max_y()?);
    // rust: at[1] -= 1;
    // rust: while at[1] > min && at[1] <= max {
    // rust: let block = read(world, &self.blocks, at)?;
    // rust: if !(self.blocks.air(block) || self.blocks.fluid(block)) {
    // rust: break;
}
    // rust: world.set_chunk_block(at, self.pillar)?;
    // rust: at[1] -= 1;
}
    // rust: Ok(Some(info))
}
}

    // rust: mod tests {
//     use super::*;
//     use serde_json::json;

    // Scripted floats.
Floats :: struct {
    // rust: impl ProcessorRandom for Floats {
float :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: self.0.remove(0)
}
int :: proc(self: ^Self, _: i32) -> i {
    // Ported from Horizon
    return {}
}
    // rust: unreachable!()
}
long :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: unreachable!()
}
}

id :: proc(v: ^Value) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let v = v.get("Name").unwrap_or(v);
    // rust: Ok(BlockStateId(v.as_str().unwrap().len() as u32))
}

height_randomizer_takes_the_share_in_range :: proc() {
}
    // rust: let r = HeightRandomizer::decode(
    // rust: &json!({"default": "d", "entries": [
    // rust: {"block": "aa", "probability": 0.25, "max_y": 10},
    // rust: {"block": "bbb", "probability": 0.5}]}),
    // rust: &id,
    // rust: )
    // rust: .unwrap();
    // rust: let (a, b, d) = (BlockStateId(2), BlockStateId(3), BlockStateId(1));
    // rust: assert_eq!(r.get(&mut Floats(vec![0.1]), 5), a);
        // Out of its height range, a draw in the first share falls through.
    // rust: assert_eq!(r.get(&mut Floats(vec![0.1]), 11), d);
    // rust: assert_eq!(r.get(&mut Floats(vec![0.25]), 11), b);
    // rust: assert_eq!(r.get(&mut Floats(vec![0.75]), 0), d);
}

yung_randomizer_checks_altitude_only_with_a_height :: proc() {
}
    // rust: let r = YungRandomizer::decode(
    // rust: &json!({"defaultBlockState": "d", "entries": [
    // rust: {"blockState": "aa", "probability": 0.5,
    // rust: "condition": {"type": "yungsapi:altitude", "bottom_cutoff_y": 40}}]}),
    // rust: &id,
    // rust: )
    // rust: .unwrap();
    // rust: let (a, d) = (BlockStateId(2), BlockStateId(1));
    // rust: assert_eq!(r.get(&mut Floats(vec![0.2]), None), a);
    // rust: assert_eq!(r.get(&mut Floats(vec![0.2]), Some(40)), a);
    // rust: assert_eq!(r.get(&mut Floats(vec![0.2]), Some(39)), d);
    // rust: assert_eq!(r.get(&mut Floats(vec![0.5]), None), d);
    // rust: let bad = json!({"defaultBlockState": "d", "entries": [
    // rust: {"blockState": "aa", "probability": 1.0, "condition": {"type": "x:y"}}]});
    // rust: assert!(YungRandomizer::decode(&bad, &id).is_err());
}

fluid_fix_picks_like_get_random_entry :: proc() {
}
    // rust: let fix = |weights: &[i32]| -> Vec<(BlockStateId, i32)> {
    // rust: weights
    // rust: .iter()
    // rust: .enumerate()
    // rust: .map(|(i, w)| (BlockStateId(i as u32), *w))
    // rust: .collect()
}
    // rust: let three = fix(&[1, 2, 1]);
        // nextFloat() * 4 = 0.4, 2.4, 3.0 (the second weight ends at 3), 3.2.
    // rust: for (f, want) in [(0.1, 0), (0.6, 1), (0.75, 1), (0.8, 2)] {
    // rust: assert_eq!(pick(&three, &mut Floats(vec![f])), BlockStateId(want));
}
    // rust: assert_eq!(pick(&fix(&[5]), &mut Floats(vec![0.9])), BlockStateId(0));
}

directions_and_distances :: proc() {
}
    // rust: for name in DIRECTION_NAMES {
    // rust: assert_eq!(direction_name(direction(name).unwrap()), name);
}
    // rust: assert!(direction("sideways").is_err());
    // rust: assert_eq!(add([0, 5, 0], direction("down").unwrap()), [0, 4, 0]);
    // rust: assert_eq!(add([0, 5, 0], direction("east").unwrap()), [1, 5, 0]);
    // rust: assert!(closer_than([0, 0, 0], [3, 0, 0], 4));
    // rust: assert!(!closer_than([0, 0, 0], [3, 0, 4], 5));
    // rust: assert!(closer_than([0, 0, 0], [3, 0, 4], 6));
}
}
