//! Transpiled from Horizon Rust crate
//! Module: horizon-world_ocean_ruin
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Ocean ruins (OceanRuinPieces).
// use super::{
    // rust: BoundingBox, Mirror, Rotation, StructureResources, StructureTemplate,
    // rust: legacy::{PieceContext, Result, TemplateHandler, TemplatePiece},
    // rust: processor::ProcessorList,
}
// use crate::{
    // rust: fluid::FluidKind,
    // rust: heightmap::HeightmapType,
    // rust: worldgen::{DecodeError, block_feature::FeatureBlockBindings},
}
// use horizon_core::random::RandomSource;
// use std::sync::Arc;

    // rust: const WARM: [&str; 8] = [
    // rust: "warm_1", "warm_2", "warm_3", "warm_4", "warm_5", "warm_6", "warm_7", "warm_8",
    // rust: ];
pub const BIG_WARM: [[]const u8; 4] = ["big_warm_4", "big_warm_5", "big_warm_6", "big_warm_7"];
    // rust: const BRICK: [&str; 8] = [
    // rust: "brick_1", "brick_2", "brick_3", "brick_4", "brick_5", "brick_6", "brick_7", "brick_8",
    // rust: ];
    // rust: const CRACKED: [&str; 8] = [
    // rust: "cracked_1",
    // rust: "cracked_2",
    // rust: "cracked_3",
    // rust: "cracked_4",
    // rust: "cracked_5",
    // rust: "cracked_6",
    // rust: "cracked_7",
    // rust: "cracked_8",
    // rust: ];
    // rust: const MOSSY: [&str; 8] = [
    // rust: "mossy_1", "mossy_2", "mossy_3", "mossy_4", "mossy_5", "mossy_6", "mossy_7", "mossy_8",
    // rust: ];
pub const BIG_BRICK: [[]const u8; 4] = ["big_brick_1", "big_brick_2", "big_brick_3", "big_brick_8"];
    // rust: const BIG_CRACKED: [&str; 4] = [
    // rust: "big_cracked_1",
    // rust: "big_cracked_2",
    // rust: "big_cracked_3",
    // rust: "big_cracked_8",
    // rust: ];
pub const BIG_MOSSY: [[]const u8; 4] = ["big_mossy_1", "big_mossy_2", "big_mossy_3", "big_mossy_8"];

/// Mth.nextInt(random, min, max).
pub fn next_int(random: *mut impl RandomSource, min: i32, max: i32) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if min >= max {
    // rust: min
    // rust: } else {
    // rust: random.next_int_bound(max - min + 1).unwrap_or(0) + min
}
}

pub const OceanRuinConfig = struct {
    warm: bool,
    large_probability: f32,
    cluster_probability: f32,
};
    // rust: fn processors(
    // rust: resources: &StructureResources,
    // rust: bindings: &FeatureBlockBindings<'_>,
    // rust: integrity: f32,
    // rust: warm: bool,
    // rust: ) -> std::result::Result<Arc<ProcessorList>, DecodeError> {
    // rust: let (candidate, replacement, table) = if warm {
    // rust: (
    // rust: "minecraft:sand",
    // rust: "minecraft:suspicious_sand",
    // rust: "minecraft:archaeology/ocean_ruin_warm",
    // rust: )
    // rust: } else {
    // rust: (
    // rust: "minecraft:gravel",
    // rust: "minecraft:suspicious_gravel",
    // rust: "minecraft:archaeology/ocean_ruin_cold",
    // rust: )
}
    // rust: let json = serde_json::json!({"processors": [
    // rust: {"processor_type": "minecraft:block_rot", "integrity": integrity},
    // rust: {"processor_type": "minecraft:block_ignore", "blocks": [{"id": "minecraft:structure_block"}, {"id": "minecraft:air"}]},
    // rust: {"processor_type": "minecraft:capped", "limit": 5, "delegate": {"processor_type": "minecraft:rule", "rules": [{
    // rust: "input_predicate": {"predicate_type": "minecraft:block_match", "block": candidate},
    // rust: "location_predicate": {"predicate_type": "minecraft:always_true"},
    // rust: "output_state": {"id": replacement},
    // rust: "block_entity_modifier": {"type": "minecraft:append_loot", "loot_table": table}
    // rust: }]}}
    // rust: ]});
    // rust: Ok(Arc::new(ProcessorList::decode(
    // rust: &json.to_string(),
    // rust: resources,
    // rust: bindings,
    // rust: )?))
}
    // rust: fn piece(
    // rust: resources: &StructureResources,
    // rust: bindings: &FeatureBlockBindings<'_>,
    // rust: name: &str,
    // rust: position: [i32; 3],
    // rust: rotation: Rotation,
    // rust: integrity: f32,
    // rust: warm: bool,
    // rust: large: bool,
    // rust: ) -> Option<TemplatePiece> {
    // rust: let name = format!("minecraft:underwater_ruin/{name}");
    // rust: Some(TemplatePiece::new(
    // rust: "minecraft:orp",
    // rust: &name,
    // rust: resources.template(&name)?,
    // rust: position,
    // rust: rotation,
    // rust: Mirror::None,
    // rust: [0; 3],
    // rust: processors(resources, bindings, integrity, warm).ok()?,
    // rust: true,
    // rust: Vec::new(),
    // rust: TemplateHandler::OceanRuin {
    // rust: warm,
    // rust: large,
    // rust: integrity,
    // rust: },
    // rust: ))
}
    // rust: fn add_piece(
    // rust: out: &mut Vec<TemplatePiece>,
    // rust: resources: &StructureResources,
    // rust: bindings: &FeatureBlockBindings<'_>,
    // rust: position: [i32; 3],
    // rust: rotation: Rotation,
    // rust: random: &mut impl RandomSource,
    // rust: config: &OceanRuinConfig,
    // rust: large: bool,
    // rust: integrity: f32,
    // rust: ) -> Option<()> {
    // rust: if config.warm {
    // rust: let names: &[&str] = if large { &BIG_WARM } else { &WARM };
    // rust: let name = names[random.next_int_bound(names.len() as i32).ok()? as usize];
    // rust: out.push(piece(
    // rust: resources, bindings, name, position, rotation, integrity, true, large,
    // rust: )?);
    // rust: } else {
    // rust: let (bricks, cracked, mossy): (&[&str], &[&str], &[&str]) = if large {
    // rust: (&BIG_BRICK, &BIG_CRACKED, &BIG_MOSSY)
    // rust: } else {
    // rust: (&BRICK, &CRACKED, &MOSSY)
}
    // rust: let idx = random.next_int_bound(bricks.len() as i32).ok()? as usize;
    // rust: out.push(piece(
    // rust: resources,
    // rust: bindings,
    // rust: bricks[idx],
    // rust: position,
    // rust: rotation,
    // rust: integrity,
    // rust: false,
    // rust: large,
    // rust: )?);
    // rust: out.push(piece(
    // rust: resources,
    // rust: bindings,
    // rust: cracked[idx],
    // rust: position,
    // rust: rotation,
    // rust: 0.7,
    // rust: false,
    // rust: large,
    // rust: )?);
    // rust: out.push(piece(
    // rust: resources, bindings, mossy[idx], position, rotation, 0.5, false, large,
    // rust: )?);
}
    // rust: Some(())
}
/// OceanRuinPieces.addPieces.
    // rust: pub fn pieces(
    // rust: resources: &StructureResources,
    // rust: bindings: &FeatureBlockBindings<'_>,
    // rust: position: [i32; 3],
    // rust: rotation: Rotation,
    // rust: random: &mut impl RandomSource,
    // rust: config: &OceanRuinConfig,
    // rust: ) -> Option<Vec<TemplatePiece>> {
    // rust: let mut out = Vec::new();
    // rust: let large = random.next_float() <= config.large_probability;
    // rust: let integrity = if large { 0.9 } else { 0.8 };
    // rust: add_piece(
    // rust: &mut out, resources, bindings, position, rotation, random, config, large, integrity,
    // rust: )?;
    // rust: if large && random.next_float() <= config.cluster_probability {
    // rust: let parent = [position[0], 90, position[2]];
    // rust: let corner = StructureTemplate::transform([15, 0, 15], Mirror::None, rotation, [0; 3]);
    // rust: let corner = [
    // rust: corner[0] + parent[0],
    // rust: corner[1] + parent[1],
    // rust: corner[2] + parent[2],
    // rust: ];
    // rust: let parent_box = BoundingBox::from_corners(parent, corner);
    // rust: let origin = [
    // rust: parent[0].min(corner[0]),
    // rust: parent[1],
    // rust: parent[2].min(corner[2]),
    // rust: ];
    // rust: let mut all = vec![
    // rust: [
    // rust: origin[0] - 16 + next_int(random, 1, 8),
    // rust: origin[1],
    // rust: origin[2] + 16 + next_int(random, 1, 7),
    // rust: ],
    // rust: [
    // rust: origin[0] - 16 + next_int(random, 1, 8),
    // rust: origin[1],
    // rust: origin[2] + next_int(random, 1, 7),
    // rust: ],
    // rust: [
    // rust: origin[0] - 16 + next_int(random, 1, 8),
    // rust: origin[1],
    // rust: origin[2] - 16 + next_int(random, 4, 8),
    // rust: ],
    // rust: [
    // rust: origin[0] + next_int(random, 1, 7),
    // rust: origin[1],
    // rust: origin[2] + 16 + next_int(random, 1, 7),
    // rust: ],
    // rust: [
    // rust: origin[0] + next_int(random, 1, 7),
    // rust: origin[1],
    // rust: origin[2] - 16 + next_int(random, 4, 6),
    // rust: ],
    // rust: [
    // rust: origin[0] + 16 + next_int(random, 1, 7),
    // rust: origin[1],
    // rust: origin[2] + 16 + next_int(random, 3, 8),
    // rust: ],
    // rust: [
    // rust: origin[0] + 16 + next_int(random, 1, 7),
    // rust: origin[1],
    // rust: origin[2] + next_int(random, 1, 7),
    // rust: ],
    // rust: [
    // rust: origin[0] + 16 + next_int(random, 1, 7),
    // rust: origin[1],
    // rust: origin[2] - 16 + next_int(random, 4, 8),
    // rust: ],
    // rust: ];
    // rust: let ruins = next_int(random, 4, 8);
    // rust: for _ in 0..ruins {
    // rust: if all.is_empty() {
    // rust: continue;
}
    // rust: let idx = random.next_int_bound(all.len() as i32).ok()? as usize;
    // rust: let pos = all.remove(idx);
    // rust: let next_rotation = Rotation::random(random);
    // rust: let c = StructureTemplate::transform([5, 0, 6], Mirror::None, next_rotation, [0; 3]);
    // rust: let next_box =
    // rust: BoundingBox::from_corners(pos, [c[0] + pos[0], c[1] + pos[1], c[2] + pos[2]]);
    // rust: if !next_box.intersects(&parent_box) {
    // rust: add_piece(
    // rust: &mut out,
    // rust: resources,
    // rust: bindings,
    // rust: pos,
    // rust: next_rotation,
    // rust: random,
    // rust: config,
    // rust: false,
    // rust: 0.8,
    // rust: )?;
}
}
}
    // rust: Some(out)
}

pub fn is_water(c: *mut PieceContext<'_>, pos: [i32; 3]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(matches!(
    // rust: c.world.fluid(pos)?.kind(),
    // rust: FluidKind::Water | FluidKind::FlowingWater
    // rust: ))
}
/// OceanRuinPiece.postProcess.
pub fn post_process(piece: *TemplatePiece, c: *mut PieceContext<'_>) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let TemplateHandler::OceanRuin { large, .. } = piece.handler else {
    // rust: return Ok(());
}
    // rust: let [x, _, z] = piece.position;
    // rust: let mut position = [x, c.world.height(HeightmapType::OceanFloorWg, x, z)?, z];
    // rust: let size = piece.template.size;
    // rust: let r = StructureTemplate::transform(
    // rust: [size[0] - 1, 0, size[2] - 1],
    // rust: Mirror::None,
    // rust: piece.rotation,
    // rust: [0; 3],
    // rust: );
    // rust: let corner = [r[0] + position[0], r[1] + position[1], r[2] + position[2]];
    // getHeight over the footprint.
    // rust: let mut new_y = position[1];
    // rust: let mut min_y = 512;
    // rust: let top_y = new_y - 1;
    // rust: let mut area = 0;
    // rust: let min_world = c.world.min_y()?;
    // rust: for px in position[0].min(corner[0])..=position[0].max(corner[0]) {
    // rust: for pz in position[2].min(corner[2])..=position[2].max(corner[2]) {
    // rust: let mut floor = position[1] - 1;
    // rust: loop {
    // rust: let state = c.world.block([px, floor, pz])?;
    // rust: let ice = c
    // rust: .resources
    // rust: .block_tags
    // rust: .get("minecraft:ice")
    // rust: .is_some_and(|t| t.contains(c.name(state)));
    // rust: let open = c.is_air(state) || is_water(c, [px, floor, pz])? || ice;
    // rust: if !(open && floor > min_world + 1) {
    // rust: break;
}
    // rust: floor -= 1;
}
    // rust: min_y = min_y.min(floor);
    // rust: if floor < top_y - 2 {
    // rust: area += 1;
}
}
}
    // rust: let width = (position[0] - corner[0]).abs();
    // rust: if top_y - min_y > 2 && area > width - 2 {
    // rust: new_y = min_y + 1;
}
    // rust: position[1] = new_y;
    // OceanRuinPiece.postProcess keeps the height in templatePosition.
    // rust: *piece.state.lock().unwrap() = Some(new_y);
    // rust: if let Some(markers) = piece.place_at(c, position, &[])? {
    // rust: for (marker, pos) in markers {
    // rust: if marker == "chest" {
    // rust: let water = if is_water(c, pos)? { "true" } else { "false" };
    // rust: let chest = c.state_with("chest", &[("waterlogged", water)]);
    // rust: c.world.set(pos, chest, 2)?;
    // rust: let table = if large {
    // rust: "minecraft:chests/underwater_ruin_big"
    // rust: } else {
    // rust: "minecraft:chests/underwater_ruin_small"
}
    // rust: c.loot_table(pos, "minecraft:chest", table)?;
    // rust: } else if marker == "drowned" {
    // rust: c.world.entity(super::legacy::spawn_nbt(
    // rust: "minecraft:drowned",
    // rust: pos,
    // rust: true,
    // rust: true,
    // rust: ))?;
    // rust: let sea = c.world.sea_level()?;
    // rust: let state = if pos[1] > sea {
    // rust: c.state("air")
    // rust: } else {
    // rust: c.state("water")
}
    // rust: c.world.set(pos, state, 2)?;
}
}
}
    // rust: Ok(())
}

    // rust: mod tests {
//     use super::*;
//     use crate::{
    // rust: fluid::FluidState,
    // rust: nbt::{Compound, parse_snbt},
    // rust: registry::{BlockRegistry, BlockStateId},
    // rust: worldgen::{
    // rust: placement::PlacementQueryError,
    // rust: structure::{
    // rust: BoundingBox, StateTransforms,
    // rust: legacy::{PieceWorld, SolidRender, TemplatePiece},
    // rust: processor::ProcessorList,
    // rust: },
    // rust: },
}
//     use horizon_core::{position::ChunkPos, random::LegacyRandom};
//     use std::{collections::BTreeMap, path::Path, sync::Mutex};

    /// Air, the water and the floor the piece is placed in, and the structure
    /// block that carries the piece's markers.
pub fn registry() * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let rows: Vec<serde_json::Value> = [
    // rust: "minecraft:air",
    // rust: "minecraft:cave_air",
    // rust: "minecraft:void_air",
    // rust: "minecraft:water",
    // rust: "minecraft:sandstone",
    // rust: "minecraft:structure_block",
    // rust: ]
    // rust: .into_iter()
    // rust: .map(|name| {
    // rust: serde_json::json!([name, name.ends_with("air"), false, "",
    // rust: {"id": name, "properties": {}}])
    // rust: })
    // rust: .collect();
    // rust: let defaults: serde_json::Map<String, serde_json::Value> = [
    // rust: "minecraft:air",
    // rust: "minecraft:cave_air",
    // rust: "minecraft:void_air",
    // rust: "minecraft:water",
    // rust: "minecraft:sandstone",
    // rust: "minecraft:structure_block",
    // rust: ]
    // rust: .iter()
    // rust: .enumerate()
    // rust: .map(|(i, name)| ((*name).to_owned(), serde_json::json!(i)))
    // rust: .collect();
    // rust: let facts = serde_json::json!({"states": rows, "defaults": defaults});
    // rust: let registry = BlockRegistry::from_facts_json(facts.to_string().as_bytes()).unwrap();
    // rust: Box::leak(Box::new(registry))
}

    /// The piece world: a solid seabed at `height` everywhere, a sea level, and
    /// every `set` recorded in call order.
pub const World = struct {
    registry: *'static BlockRegistry,
    floor: BlockStateId,
    height: i32,
    sea: i32,
    sets: Vec<([i32,
};
    // rust: impl World {
pub fn new(registry: *'static BlockRegistry, sea: i32) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self {
    // rust: registry,
    // rust: floor: registry.default_state("minecraft:sandstone").unwrap(),
    // rust: height: 77,
    // rust: sea,
    // rust: sets: Vec::new(),
}
}
pub fn name_of(self: *Self, state: BlockStateId) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.registry.state(state).map(|s| s.name.as_str()).unwrap()
}
}
    // rust: impl PieceWorld for World {
pub fn block(self: *Self, _: [i32; 3]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.floor)
}
pub fn set(self: *Self, pos: [i32; 3], state: BlockStateId, flags: i32) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.sets.push((pos, state, flags));
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
    // rust: Ok(self.height)
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
pub fn block_entity(self: *Self, _: [i32; 3], _: Compound) R {
    // Implementation ported from Horizon
    return undefined;
}
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
    // rust: Ok(self.sea)
}
pub fn face_full(self: *Self, _: [i32; 3], _: horizon_core::geometry::Direction) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(false)
}
    // rust: fn face_sturdy(
    // rust: &mut self,
    // rust: _: [i32; 3],
    // rust: _: horizon_core::geometry::Direction,
    // rust: ) -> Result<bool> {
    // rust: Ok(false)
}
    // rust: fn center_sturdy(
    // rust: &mut self,
    // rust: _: [i32; 3],
    // rust: _: horizon_core::geometry::Direction,
    // rust: ) -> Result<bool> {
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
    // rust: _: &mut super::super::processor::PlaceSettings<'_>,
    // rust: _: &mut dyn super::super::processor::ProcessorRandom,
    // rust: _: i32,
    // rust: ) -> Result<bool> {
    // rust: Ok(true)
}
}
    /// No block draws as a solid block here.
pub const Blocks = struct {};
    // rust: impl SolidRender for Blocks {
pub fn solid_render(self: *Self, _: BlockStateId) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: false
}
}

    /// One ocean ruin piece whose template holds a `drowned` data marker at
    /// its own origin.
pub fn piece(registry: *BlockRegistry) T {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (tag, _) = parse_snbt(
    // rust: r#"{size:[1,1,1],palette:[{Name:"minecraft:structure_block"}],
    // rust: blocks:[{pos:[0,0,0],state:0,nbt:{mode:"data",metadata:"drowned"}}]}"#,
    // rust: )
    // rust: .unwrap();
    // rust: let template = StructureTemplate::from_nbt(&tag, registry, &StateTransforms::default());
    // rust: TemplatePiece {
    // rust: type_name: "minecraft:ocean_ruin",
    // rust: template_name: "ocean_ruin/cold/brick_1".into(),
    // rust: template: Arc::new(template),
    // rust: position: [8, 0, 8],
    // rust: rotation: Rotation::None,
    // rust: mirror: Mirror::None,
    // rust: pivot: [0; 3],
    // rust: processors: Arc::new(ProcessorList(Vec::new())),
    // rust: waterlogging: true,
    // rust: ignore: Vec::new(),
    // rust: bounding_box: BoundingBox::new([8, 0, 8], [8, 384, 8]),
    // rust: handler: TemplateHandler::OceanRuin {
    // rust: warm: false,
    // rust: large: false,
    // rust: integrity: 1.0,
    // rust: },
    // rust: state: Mutex::new(None),
}
}

    /// The drowned marker's block, with the piece's world at sea level `sea`.
pub fn drowned_block(sea: i32) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let registry = registry();
    // rust: let resources = StructureResources::new(
    // rust: registry,
    // rust: StateTransforms::default(),
    // rust: Path::new("/nonexistent"),
    // rust: BTreeMap::new(),
    // rust: &BTreeMap::new(),
    // rust: );
    // rust: let piece = piece(registry);
    // rust: let mut world = World::new(registry, sea);
    // rust: let mut blocks = Blocks;
    // rust: let mut random = LegacyRandom::new(0);
    // rust: {
    // rust: let mut c = PieceContext {
    // rust: world: &mut world,
    // rust: resources: &resources,
    // rust: blocks: &mut blocks,
    // rust: random: &mut random,
    // rust: chunk_box: BoundingBox::new([0, -64, 0], [16, 384, 16]),
    // rust: chunk: ChunkPos::new(0, 0),
    // rust: reference: [8, 0, 8],
}
    // rust: post_process(&piece, &mut c).unwrap();
}
        // The drowned marker sits at the piece's own height, 77: above the old
        // hardcoded sea level and below this world's.
    // rust: let (_, state, flags) = world
    // rust: .sets
    // rust: .iter()
    // rust: .find(|(pos, state, _)| {
    // rust: *pos == [8, 77, 8] && world.name_of(*state) != "minecraft:structure_block"
    // rust: })
    // rust: .map(|(pos, state, flags)| (*pos, *state, *flags))
    // rust: .expect("the drowned marker's block");
    // rust: assert_eq!(flags, 2);
    // rust: world.name_of(state).to_owned()
}

    /// `OceanRuinPieces.OceanRuinPiece.postProcess` floods the drowned marker's
    /// block when it is at or below `level.getSeaLevel()`, and leaves air above.
pub fn a_drowned_marker_is_water_at_or_below_the_sea_level() void {
}
    // rust: assert_eq!(drowned_block(90), "minecraft:water");
    // rust: assert_eq!(drowned_block(77), "minecraft:water");
    // rust: assert_eq!(drowned_block(76), "minecraft:air");
}
}
