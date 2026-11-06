//! Transpiled from Horizon Rust crate
package horizon_world_sea_level

import "core:fmt"
import "core:mem"
import "core:math"

// Processors for structures built under the sea, carried as data from
// Better Ocean Monuments' Java processors (docs/modpacks.md):
// - `horizon:flood_air`: the template's air below sea level becomes water
//   (its AirProcessor; the monuments' templates are mostly air);
// - `horizon:waterlog`: below sea level, blocks that can be waterlogged
//   are, and the template's water and lava on the edge of the chunk being
//   generated are marked for postprocessing, so they flow across it (its
//   WaterlogProcessor);
// - `horizon:keep_world_block`: blocks of `blocks` take the block the world
//   holds there (its StructureVoidProcessor, which, unlike vanilla's
//   structure void, lets the next processors see that block).
//
// And from Repurposed Structures':
// - `horizon:waterlog_in_world_water`: a block that can be waterlogged is
//   where the world holds water and is dry where it does not (its
//   WaterlogWhenReplacingWaterProcessor);
// - `horizon:mineshaft_sky_view`: its mineshafts are not built above the
//   ocean floor, but keep their rails on solid ground (its
//   MineshaftSkyViewProcessor).
// use super::{PlaceSettings, ProcessResult, pillars::outside_chunk};
// use crate::{
    // rust: fluid::{FluidKind, FluidState},
    // rust: heightmap::HeightmapType,
    // rust: registry::{BlockRegistry, BlockStateId},
    // rust: worldgen::{DecodeError, placement::PlacementContext, structure::BlockInfo},
}
// use serde_json::Value;
// use std::collections::BTreeSet;

known :: proc(registry: ^BlockRegistry, name: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: registry
    // rust: .default_state(name)
    // rust: .ok_or_else(|| DecodeError::Registry(format!("unknown block {name}")))
}

// `horizon:flood_air`: plain air (not cave air) under the sea level
// becomes water, without a block entity.
FloodAir :: struct {
    air: BlockStateId,
    water: BlockStateId,
}
    // rust: impl FloodAir {
    // rust: pub(super) fn decode(registry: &BlockRegistry) -> Result<Self, DecodeError> {
    // rust: Ok(Self {
    // rust: air: known(registry, "minecraft:air")?,
    // rust: water: known(registry, "minecraft:water")?,
    // rust: })
}
    // rust: pub(super) fn process<W: PlacementContext>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: info: BlockInfo,
    // rust: ) -> ProcessResult {
    // rust: if info.state != self.air || info.pos[1] >= world.sea_level()? {
    // rust: return Ok(Some(info));
}
    // rust: Ok(Some(BlockInfo {
    // rust: state: self.water,
    // rust: nbt: None,
    // rust: ..info
    // rust: }))
}
}

// `horizon:waterlog`: WaterlogProcessor.
Waterlog :: struct {
    // rust: impl Waterlog {
    // rust: pub(super) fn process<W: PlacementContext>(
    world: ^W,
    registry: ^BlockRegistry,
    info: BlockInfo,
    settings: ^PlaceSettings<'_>,
    // rust: ) -> ProcessResult {
    // rust: let Some(state) = registry.state(info.state) else {
    // rust: return Ok(Some(info));
}
    // rust: if info.pos[1] >= world.sea_level()? {
    // rust: return Ok(Some(info));
}
        // BlockState.liquid(): a liquid block, not a waterlogged one. Java's
        // `%` keeps the sign, as Rust's does: x = -1 is no edge for it.
    // rust: let liquid = matches!(state.name.as_str(), "minecraft:water" | "minecraft:lava");
    // rust: let [x, _, z] = info.pos;
    // rust: let edge = [x % 16, z % 16].iter().any(|v| *v == 0 || *v == 15);
    // rust: if liquid && edge && !outside_chunk(settings, info.pos) {
    // rust: world.mark_postprocessing(info.pos)?;
}
    // rust: if state.properties.contains_key("waterlogged") {
    // rust: let mut wet = state.clone();
    // rust: wet.properties.insert("waterlogged".into(), "true".into());
    // rust: if let Some(id) = registry.id(&wet) {
    // rust: return Ok(Some(BlockInfo { state: id, ..info }));
}
}
    // rust: Ok(Some(info))
}
}

// `horizon:keep_world_block`: StructureVoidProcessor. The block entity
// stays the template's, as the mod's does.
KeepWorldBlock :: struct {
    blocks: BTreeSet<string>,
}
    // rust: impl KeepWorldBlock {
    // rust: pub(super) fn decode(value: &Value) -> Result<Self, DecodeError> {
    // rust: let blocks = value["blocks"]
    // rust: .as_array()
    // rust: .ok_or(DecodeError::Field("keep_world_block blocks"))?
    // rust: .iter()
    // rust: .map(|b| {
    // rust: let b = b
    // rust: .as_str()
    // rust: .ok_or(DecodeError::Field("keep_world_block blocks"))?;
    // rust: Ok(crate::worldgen::tags::identifier(b)?.to_string())
    // rust: })
    // rust: .collect::<Result<_, DecodeError>>()?;
    // rust: Ok(Self { blocks })
}
    // rust: pub(super) fn process<W: PlacementContext>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: registry: &BlockRegistry,
    // rust: info: BlockInfo,
    // rust: settings: &PlaceSettings<'_>,
    // rust: ) -> ProcessResult {
    // rust: let name = registry.state(info.state).map(|s| s.name.as_str());
        // A block outside the chunk is not placed, and the world there may
        // not be readable.
    // rust: if !name.is_some_and(|n| self.blocks.contains(n)) || outside_chunk(settings, info.pos) {
    // rust: return Ok(Some(info));
}
    // rust: let state = world.block_state(info.pos)?;
    // rust: Ok(Some(BlockInfo { state, ..info }))
}
}

// `horizon:waterlog_in_world_water`: WaterlogWhenReplacingWaterProcessor.
// In the chunk being generated, a block that can be waterlogged takes
// `waterlogged` from the world's fluid there (water, still or flowing, or a
// waterlogged block), so a template's wet block placed on land is dry; a
// block placed in water gets a block tick, as the mod schedules one.
WaterlogInWorldWater :: struct {
    // rust: impl WaterlogInWorldWater {
    // rust: pub(super) fn process<W: PlacementContext>(
    world: ^W,
    registry: ^BlockRegistry,
    info: BlockInfo,
    settings: ^PlaceSettings<'_>,
    // rust: ) -> ProcessResult {
    // rust: let Some(state) = registry.state(info.state) else {
    // rust: return Ok(Some(info));
}
    // rust: if !state.properties.contains_key("waterlogged") || outside_chunk(settings, info.pos) {
    // rust: return Ok(Some(info));
}
    // rust: let water = world_water(world, registry, info.pos)?;
        // The mod's height check (min to max build height) holds for every
        // block of the chunk.
    // rust: if water && world.inside_build_height(info.pos)? {
    // rust: world.schedule_block_tick(info.pos, info.state, 0)?;
}
    // rust: let mut set = state.clone();
    // rust: set.properties
    // rust: .insert("waterlogged".into(), water.to_string());
    // rust: Ok(Some(BlockInfo {
    // rust: state: registry.id(&set).unwrap_or(info.state),
    // rust: ..info
    // rust: }))
}
}

// Whether the world's block at `pos` holds water (still or flowing, or a
// waterlogged block): `getFluidState().is(FluidTags.WATER)`.
    // rust: fn world_water<W: PlacementContext>(
    // rust: world: &mut W,
    // rust: registry: &BlockRegistry,
    // rust: pos: [i32; 3],
    // rust: ) -> Result<bool, crate::worldgen::placement::PlacementQueryError> {
    // rust: let here = world.block_state(pos)?;
    // rust: Ok(registry
    // rust: .state(here)
    // rust: .and_then(|s| FluidState::from_block(s).ok())
    // rust: .is_some_and(|f| f.kind().same_family(FluidKind::Water)))
}

// `horizon:mineshaft_sky_view`: MineshaftSkyViewProcessor. A plain rail
// whose world block below can occlude is placed, waterlogged where the
// world holds water; any other block at or above the world's
// `OCEAN_FLOOR_WG` height in its column is not placed, so a mineshaft cut
// by a valley or a ravine is not built in the open.
MineshaftSkyView :: struct {
    // rust: impl MineshaftSkyView {
    // rust: pub(super) fn process<W: PlacementContext>(
    world: ^W,
    registry: ^BlockRegistry,
    info: BlockInfo,
    // rust: ) -> ProcessResult {
    // rust: let [x, y, z] = info.pos;
    // rust: let rail = registry
    // rust: .state(info.state)
    // rust: .filter(|s| s.name == "minecraft:rail");
    // rust: if let Some(rail) = rail {
    // rust: let below = world.block_state([x, y - 1, z])?;
    // rust: if world.can_occlude(below)? {
    // rust: let mut set = rail.clone();
    // rust: let water = world_water(world, registry, info.pos)?;
    // rust: set.properties
    // rust: .insert("waterlogged".into(), water.to_string());
    // rust: return Ok(Some(BlockInfo {
    state: registry.id(^set).unwrap_or(info.state),
    // rust: ..info
    // rust: }));
}
}
    // rust: if y >= world.height(HeightmapType::OceanFloorWg, x, z)? {
    // rust: return Ok(None);
}
    // rust: Ok(Some(info))
}
}

    // rust: mod tests {
//     use super::*;
//     use crate::{
    // rust: heightmap::HeightmapType,
    // rust: worldgen::{
    // rust: anchor::WorldGenerationContext,
    // rust: placement::PlacementQueryError,
    // rust: structure::{BoundingBox, Rotation},
    // rust: },
}
//     use serde_json::json;

    // Sea level 63; every block of the world is `world`; marks recorded.
Sea :: struct {
    world: BlockStateId,
    marked: Vec<[i32,
    ticks: Vec<([i32,
}
    // rust: impl PlacementContext for Sea {
generation :: proc(self: ^Self) -> W {
    // Ported from Horizon
    return {}
}
    // rust: WorldGenerationContext::new(-64, 384, 63)
}
min_y :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(-64)
}
        // The ocean floor is at 64 everywhere.
    // rust: fn height(
    // rust: &mut self,
    // rust: kind: HeightmapType,
    // rust: _: i32,
    // rust: _: i32,
    // rust: ) -> Result<i32, PlacementQueryError> {
    // rust: assert_eq!(kind, HeightmapType::OceanFloorWg);
    // rust: Ok(64)
}
        // Only stone can occlude.
can_occlude :: proc(self: ^Self, state: BlockStateId) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(state == BlockStateId(6))
}
sea_level :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(63)
}
mark_postprocessing :: proc(self: ^Self, pos: [i32; 3]) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.marked.push(pos);
    // rust: Ok(())
}
block_state :: proc(self: ^Self, _: [i32; 3]) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(self.world)
}
max_y :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(319)
}
    // rust: fn schedule_block_tick(
    // rust: &mut self,
    // rust: pos: [i32; 3],
    // rust: block: BlockStateId,
    // rust: delay: i32,
    // rust: ) -> Result<(), PlacementQueryError> {
    // rust: assert_eq!(delay, 0);
    // rust: self.ticks.push((pos, block));
    // rust: Ok(())
}
}

    // 0 air, 1 cave air, 2 water, 3/4 slab dry/wet, 5 purpur slab, 6 stone,
    // 7/8 rail dry/wet.
registry :: proc() -> B {
    // Ported from Horizon
    return {}
}
    // rust: let row = |name: &str, props: Value| json!([name, false, false, "", {"id": name, "properties": props}]);
    // rust: let facts = json!({"defaults": {"minecraft:air": 0, "minecraft:cave_air": 1,
    // rust: "minecraft:water": 2, "minecraft:prismarine_slab": 3, "minecraft:purpur_slab": 5,
    // rust: "minecraft:stone": 6, "minecraft:rail": 7},
    // rust: "states": [
    // rust: ["minecraft:air", false, false, "", "minecraft:air"],
    // rust: ["minecraft:cave_air", false, false, "", "minecraft:cave_air"],
    // rust: row("minecraft:water", json!({"level": "0"})),
    // rust: row("minecraft:prismarine_slab", json!({"waterlogged": "false"})),
    // rust: row("minecraft:prismarine_slab", json!({"waterlogged": "true"})),
    // rust: ["minecraft:purpur_slab", false, false, "", "minecraft:purpur_slab"],
    // rust: ["minecraft:stone", false, false, "", "minecraft:stone"],
    // rust: row("minecraft:rail", json!({"shape": "north_south", "waterlogged": "false"})),
    // rust: row("minecraft:rail", json!({"shape": "north_south", "waterlogged": "true"}))]});
    // rust: BlockRegistry::from_facts_json(facts.to_string().as_bytes()).unwrap()
}

info :: proc(state: u32, pos: [i32; 3]) -> B {
    // Ported from Horizon
    return {}
}
    // rust: BlockInfo {
    // rust: pos,
    // rust: state: BlockStateId(state),
    // rust: nbt: None,
}
}

chunk :: proc(x: i32, z: i32) -> P {
    // Ported from Horizon
    return {}
}
    // rust: let mut settings = PlaceSettings::new(Rotation::None);
    // rust: settings.bounding_box = Some(BoundingBox::new([x, -64, z], [x + 15, 319, z + 15]));
    // rust: settings
}

air_floods_below_the_sea_only :: proc() {
}
    // rust: let registry = registry();
    // rust: let flood = FloodAir::decode(&registry).unwrap();
    // rust: let mut sea = Sea {
    // rust: world: BlockStateId(6),
    // rust: marked: vec![],
    // rust: ticks: vec![],
}
    // rust: let state = |i: BlockInfo, sea: &mut Sea| flood.process(sea, i).unwrap().unwrap().state;
    // rust: assert_eq!(state(info(0, [0, 62, 0]), &mut sea), BlockStateId(2));
    // rust: assert_eq!(state(info(0, [0, 63, 0]), &mut sea), BlockStateId(0));
        // Cave air is not Blocks.AIR.
    // rust: assert_eq!(state(info(1, [0, 10, 0]), &mut sea), BlockStateId(1));
}

waterlog_wets_and_marks_the_chunk_edges :: proc() {
}
    // rust: let registry = registry();
    // rust: let mut sea = Sea {
    // rust: world: BlockStateId(6),
    // rust: marked: vec![],
    // rust: ticks: vec![],
}
    // rust: let settings = chunk(-16, 0);
    // rust: let mut run = |i: BlockInfo| {
    // rust: Waterlog::process(&mut sea, &registry, i, &settings)
    // rust: .unwrap()
    // rust: .unwrap()
    // rust: .state
}
    // rust: assert_eq!(run(info(3, [-10, 40, 5])), BlockStateId(4));
    // rust: assert_eq!(run(info(3, [-10, 63, 5])), BlockStateId(3));
    // rust: assert_eq!(run(info(6, [-10, 40, 5])), BlockStateId(6));
        // Water on x = -16 (x % 16 == 0) and z = 15 is marked; x = -1
        // (x % 16 == -1), the middle and other chunks are not.
    // rust: for pos in [
    // rust: [-16, 40, 5],
    // rust: [-10, 40, 15],
    // rust: [-1, 40, 5],
    // rust: [-8, 40, 8],
    // rust: [0, 40, 0],
    // rust: ] {
    // rust: run(info(2, pos));
}
    // rust: assert_eq!(sea.marked, vec![[-16, 40, 5], [-10, 40, 15]]);
}

kept_blocks_take_the_worlds :: proc() {
}
    // rust: let registry = registry();
    // rust: let keep = KeepWorldBlock::decode(&json!({"blocks": ["purpur_slab"]})).unwrap();
    // rust: let mut sea = Sea {
    // rust: world: BlockStateId(1),
    // rust: marked: vec![],
    // rust: ticks: vec![],
}
    // rust: let settings = chunk(0, 0);
    // rust: let mut run = |i: BlockInfo| {
    // rust: keep.process(&mut sea, &registry, i, &settings)
    // rust: .unwrap()
    // rust: .unwrap()
    // rust: .state
}
    // rust: assert_eq!(run(info(5, [3, 40, 3])), BlockStateId(1));
    // rust: assert_eq!(run(info(6, [3, 40, 3])), BlockStateId(6));
    // rust: assert_eq!(run(info(5, [16, 40, 3])), BlockStateId(5));
    // rust: assert!(KeepWorldBlock::decode(&json!({})).is_err());
}

blocks_take_waterlogged_from_the_worlds_water :: proc() {
}
    // rust: let registry = registry();
    // rust: let settings = chunk(0, 0);
    // rust: let mut sea = Sea {
    // rust: world: BlockStateId(2),
    // rust: marked: vec![],
    // rust: ticks: vec![],
}
    // rust: let run = |sea: &mut Sea, i: BlockInfo| {
    // rust: WaterlogInWorldWater::process(sea, &registry, i, &settings)
    // rust: .unwrap()
    // rust: .unwrap()
    // rust: .state
}
        // In water: wet, with a block tick (any height: the world decides).
    // rust: assert_eq!(run(&mut sea, info(3, [3, 80, 3])), BlockStateId(4));
    // rust: assert_eq!(sea.ticks, vec![([3, 80, 3], BlockStateId(3))]);
        // A waterlogged block in the world counts as water.
    // rust: sea.world = BlockStateId(4);
    // rust: assert_eq!(run(&mut sea, info(3, [3, 40, 3])), BlockStateId(4));
        // On land: a wet template block is dry, and no tick.
    // rust: sea.world = BlockStateId(6);
    // rust: assert_eq!(run(&mut sea, info(4, [3, 40, 3])), BlockStateId(3));
    // rust: assert_eq!(sea.ticks.len(), 2);
        // Blocks that cannot be waterlogged, and other chunks, are left.
    // rust: assert_eq!(run(&mut sea, info(6, [3, 40, 3])), BlockStateId(6));
    // rust: assert_eq!(run(&mut sea, info(4, [16, 40, 3])), BlockStateId(4));
}

mineshafts_stop_at_the_ocean_floor_but_keep_grounded_rails :: proc() {
}
    // rust: let registry = registry();
    // rust: let mut sea = Sea {
    // rust: world: BlockStateId(6),
    // rust: marked: vec![],
    // rust: ticks: vec![],
}
    // rust: let run = |sea: &mut Sea, i: BlockInfo| {
    // rust: MineshaftSkyView::process(sea, &registry, i)
    // rust: .unwrap()
    // rust: .map(|i| i.state)
}
        // Over stone a rail stays, above the floor too, dry as the world is.
    // rust: assert_eq!(run(&mut sea, info(8, [3, 80, 3])), Some(BlockStateId(7)));
        // Anything else stops at the floor (64).
    // rust: assert_eq!(run(&mut sea, info(6, [3, 63, 3])), Some(BlockStateId(6)));
    // rust: assert_eq!(run(&mut sea, info(6, [3, 64, 3])), None);
    // rust: assert_eq!(run(&mut sea, info(0, [3, 90, 3])), None);
        // Over water a rail is like any block.
    // rust: sea.world = BlockStateId(2);
    // rust: assert_eq!(run(&mut sea, info(7, [3, 70, 3])), None);
    // rust: assert_eq!(run(&mut sea, info(8, [3, 40, 3])), Some(BlockStateId(8)));
}
}
