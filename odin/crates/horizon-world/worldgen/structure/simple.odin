//! Transpiled from Horizon Rust crate
package horizon_world_simple

import "core:fmt"
import "core:mem"
import "core:math"

// Small piece-based structures: buried treasure, igloo, swamp hut, shipwreck.
// use super::{
    // rust: BoundingBox, Mirror, Rotation, StructureResources, StructureTemplate,
    // rust: legacy::{
    // rust: LegacyPiece, PieceContext, PieceFrame, Result, TemplateHandler, TemplatePiece,
    // rust: create_chest, make_bounding_box, offset, random_horizontal,
    // rust: },
    // rust: processor::ProcessorList,
}
// use crate::heightmap::HeightmapType;
// use horizon_core::{geometry::Direction, random::RandomSource};
// use std::sync::{Arc, Mutex};

empty_processors :: proc() -> A {
    // Ported from Horizon
    return {}
}
    // rust: Arc::new(ProcessorList::default())
}

BuriedTreasurePiece :: struct {
    position: [i32,
    // Where the chest went: the box vanilla saves once placed.
    found: Mutex<Option<[i32,
}
    // rust: impl LegacyPiece for BuriedTreasurePiece {
bounding_box :: proc(self: ^Self) -> B {
    // Ported from Horizon
    return {}
}
    // rust: BoundingBox::new(self.position, self.position)
}
save :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let at = self.found.lock().unwrap().unwrap_or(self.position);
    // rust: Some(super::legacy::piece_tag(
    // rust: "minecraft:btp",
    // rust: BoundingBox::new(at, at),
    // rust: None,
    // rust: 0,
    // rust: ))
}
type_name :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: "minecraft:btp"
}
post_process :: proc(self: ^Self, c: ^PieceContext<'_>) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let [x, _, z] = self.position;
    // rust: let mut pos = [x, c.world.height(HeightmapType::OceanFloorWg, x, z)?, z];
    // rust: let min = c.world.min_y()?;
    // rust: while pos[1] > min {
    // rust: let current = c.world.block(pos)?;
    // rust: let below = c.world.block(offset(pos, Direction::Down, 1))?;
    // rust: if matches!(
    // rust: c.name(below),
    // rust: "minecraft:sandstone"
    // rust: | "minecraft:stone"
    // rust: | "minecraft:andesite"
    // rust: | "minecraft:granite"
    // rust: | "minecraft:diorite"
    // rust: ) {
    // rust: let soft = if !c.is_air(current) && !c.is_liquid(current) {
    // rust: current
    // rust: } else {
    // rust: c.state("sand")
}
    // rust: for d in Direction::ALL {
    // rust: let relative = offset(pos, d, 1);
    // rust: let state = c.world.block(relative)?;
    // rust: if c.is_air(state) || c.is_liquid(state) {
    // rust: let under = c.world.block(offset(relative, Direction::Down, 1))?;
    // rust: if (c.is_air(under) || c.is_liquid(under)) && d != Direction::Up {
    // rust: c.world.set(relative, below, 3)?;
    // rust: } else {
    // rust: c.world.set(relative, soft, 3)?;
}
}
}
    // rust: *self.found.lock().unwrap() = Some(pos);
    // rust: create_chest(c, pos, "minecraft:chests/buried_treasure", None)?;
    // rust: return Ok(());
}
    // rust: pos[1] -= 1;
}
    // rust: Ok(())
}
}

IGLOO_TOP :: "minecraft:igloo/top"
IGLOO_MIDDLE :: "minecraft:igloo/middle"
IGLOO_BOTTOM :: "minecraft:igloo/bottom"
igloo_pivot :: proc(name: string) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: match name {
    // rust: IGLOO_TOP => [3, 5, 5],
    // rust: IGLOO_MIDDLE => [1, 3, 1],
    // rust: _ => [3, 6, 7],
}
}
igloo_offset :: proc(name: string) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: match name {
    // rust: IGLOO_TOP => [0, 0, 0],
    // rust: IGLOO_MIDDLE => [2, -3, 4],
    // rust: _ => [0, -3, -2],
}
}
// IglooPieces.addPieces.
    // rust: pub fn igloo_pieces(
    // rust: resources: &StructureResources,
    // rust: position: [i32; 3],
    // rust: rotation: Rotation,
    // rust: random: &mut impl RandomSource,
    // rust: ) -> Option<Vec<TemplatePiece>> {
    // rust: let piece = |name: &str, depth: i32| -> Option<TemplatePiece> {
    // rust: let o = igloo_offset(name);
    // rust: Some(TemplatePiece::new(
    // rust: "minecraft:iglu",
    // rust: name,
    // rust: resources.template(name)?,
    // rust: [
    // rust: position[0] + o[0],
    // rust: position[1] + o[1] - depth,
    // rust: position[2] + o[2],
    // rust: ],
    // rust: rotation,
    // rust: Mirror::None,
    // rust: igloo_pivot(name),
    // rust: empty_processors(),
    // rust: false,
    // rust: vec!["minecraft:structure_block".into()],
    // rust: TemplateHandler::Igloo,
    // rust: ))
}
    // rust: let mut pieces = Vec::new();
    // rust: if random.next_double() < 0.5 {
    // rust: let depth = random.next_int_bound(8).unwrap_or(0) + 4;
    // rust: pieces.push(piece(IGLOO_BOTTOM, depth * 3)?);
    // rust: for i in 0..depth - 1 {
    // rust: pieces.push(piece(IGLOO_MIDDLE, i * 3)?);
}
}
    // rust: pieces.push(piece(IGLOO_TOP, 0)?);
    // rust: Some(pieces)
}

    // rust: const SHIPWRECK_BEACHED: [&str; 11] = [
    // rust: "with_mast",
    // rust: "sideways_full",
    // rust: "sideways_fronthalf",
    // rust: "sideways_backhalf",
    // rust: "rightsideup_full",
    // rust: "rightsideup_fronthalf",
    // rust: "rightsideup_backhalf",
    // rust: "with_mast_degraded",
    // rust: "rightsideup_full_degraded",
    // rust: "rightsideup_fronthalf_degraded",
    // rust: "rightsideup_backhalf_degraded",
    // rust: ];
    // rust: const SHIPWRECK_OCEAN: [&str; 20] = [
    // rust: "with_mast",
    // rust: "upsidedown_full",
    // rust: "upsidedown_fronthalf",
    // rust: "upsidedown_backhalf",
    // rust: "sideways_full",
    // rust: "sideways_fronthalf",
    // rust: "sideways_backhalf",
    // rust: "rightsideup_full",
    // rust: "rightsideup_fronthalf",
    // rust: "rightsideup_backhalf",
    // rust: "with_mast_degraded",
    // rust: "upsidedown_full_degraded",
    // rust: "upsidedown_fronthalf_degraded",
    // rust: "upsidedown_backhalf_degraded",
    // rust: "sideways_full_degraded",
    // rust: "sideways_fronthalf_degraded",
    // rust: "sideways_backhalf_degraded",
    // rust: "rightsideup_full_degraded",
    // rust: "rightsideup_fronthalf_degraded",
    // rust: "rightsideup_backhalf_degraded",
    // rust: ];
// ShipwreckPieces.addRandomPiece.
    // rust: pub fn shipwreck_piece(
    // rust: resources: &StructureResources,
    // rust: position: [i32; 3],
    // rust: rotation: Rotation,
    // rust: random: &mut impl RandomSource,
    // rust: beached: bool,
    // rust: ) -> Option<TemplatePiece> {
    // rust: let names: &[&str] = if beached {
    // rust: &SHIPWRECK_BEACHED
    // rust: } else {
    // rust: &SHIPWRECK_OCEAN
}
    // rust: let name = format!(
    // rust: "minecraft:shipwreck/{}",
    // rust: names[random.next_int_bound(names.len() as i32).ok()? as usize]
    // rust: );
    // rust: Some(TemplatePiece::new(
    // rust: "minecraft:shipwreck",
    // rust: &name,
    // rust: resources.template(&name)?,
    // rust: position,
    // rust: rotation,
    // rust: Mirror::None,
    // rust: [4, 0, 15],
    // rust: empty_processors(),
    // rust: true,
    // rust: vec!["minecraft:structure_block".into(), "minecraft:air".into()],
    // rust: TemplateHandler::Shipwreck { beached },
    // rust: ))
}
shipwreck_too_big :: proc(template: ^StructureTemplate) -> b {
    // Ported from Horizon
    return {}
}
    // rust: template.size[0] > 32 || template.size[1] > 32
}

    // rust: impl TemplatePiece {
    // `TemplateStructurePiece.addAdditionalSaveData` and its subclasses',
    // with the height a shipwreck settled on once placed.
saved :: proc(self: ^Self) -> c {
    // Ported from Horizon
    return {}
}
//         use crate::nbt::Tag;
    // rust: let flag = |b: bool| Tag::Byte(i8::from(b));
    // rust: let adjusted = match self.handler {
    // rust: TemplateHandler::Shipwreck { .. }
    // rust: | TemplateHandler::OceanRuin { .. }
    // rust: | TemplateHandler::Igloo => *self.state.lock().unwrap(),
    // rust: _ => None,
}
    // rust: let dy = adjusted.map_or(0, |y| y - self.position[1]);
    // rust: let template_dy = if matches!(self.handler, TemplateHandler::Igloo) {
    // rust: 0
    // rust: } else {
    // rust: dy
}
    // rust: let mut tag = super::legacy::piece_tag(
    // rust: self.type_name,
    // rust: self.bounding_box.moved([0, dy, 0]),
    // rust: Some(Direction::North),
    // rust: 0,
    // rust: );
        // Mansion and End City pieces keep the name inside their folder.
    // rust: let name = self
    // rust: .template_name
    // rust: .strip_prefix("minecraft:woodland_mansion/")
    // rust: .or_else(|| self.template_name.strip_prefix("minecraft:end_city/"))
    // rust: .unwrap_or(&self.template_name);
    // rust: let rotation = || Tag::String(self.rotation.saved_name().into());
    // rust: let mut entries = vec![
    // rust: ("TPX", Tag::Int(self.position[0])),
    // rust: ("TPY", Tag::Int(self.position[1] + template_dy)),
    // rust: ("TPZ", Tag::Int(self.position[2])),
    // rust: ("Template", Tag::String(name.into())),
    // rust: ];
    // rust: match self.handler {
    // rust: TemplateHandler::Igloo => entries.push(("Rot", rotation())),
    // rust: TemplateHandler::Shipwreck { beached } => entries.extend([
    // rust: ("isBeached", flag(beached)),
    // rust: ("Rot", rotation()),
    // rust: ("height_adjusted", flag(adjusted.is_some())),
    // rust: ]),
    // rust: TemplateHandler::OceanRuin {
    // rust: warm,
    // rust: large,
    // rust: integrity,
    // rust: } => entries.extend([
    // rust: ("Rot", rotation()),
    // rust: ("Integrity", Tag::Float(integrity.to_bits())),
    // rust: (
    // rust: "BiomeType",
    // rust: Tag::String(if warm { "WARM" } else { "COLD" }.into()),
    // rust: ),
    // rust: ("IsLarge", flag(large)),
    // rust: ]),
    // rust: TemplateHandler::RuinedPortal(props) => {
    // rust: entries.push(("Rotation", rotation()));
    // rust: entries.push(("Mirror", Tag::String(self.mirror.saved_name().into())));
    // rust: entries.extend(props.save());
}
    // rust: TemplateHandler::Mansion => entries.extend([
    // rust: ("Rot", rotation()),
    // rust: ("Mi", Tag::String(self.mirror.saved_name().into())),
    // rust: ]),
    // rust: TemplateHandler::Plain => entries.push(("Rot", rotation())),
}
    // rust: for (key, value) in entries {
    // rust: tag.insert(key.into(), value);
}
    // rust: tag
}
}
    // rust: impl LegacyPiece for TemplatePiece {
bounding_box :: proc(self: ^Self) -> B {
    // Ported from Horizon
    return {}
}
    // rust: self.bounding_box
}
save :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: Some(self.saved())
}
after_place :: proc(self: ^Self, c: ^PieceContext<'_>, pieces: ^[BoundingBox]) -> R {
    // Ported from Horizon
    return {}
}
    // rust: match self.handler {
    // rust: TemplateHandler::Mansion => super::mansion::after_place(c, pieces),
    // rust: _ => Ok(()),
}
}
type_name :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: self.type_name
}
post_process :: proc(self: ^Self, c: ^PieceContext<'_>) -> R {
    // Ported from Horizon
    return {}
}
    // rust: match self.handler {
    // rust: TemplateHandler::Plain => {
    // rust: self.place_at(c, self.position, &[])?;
}
    // rust: TemplateHandler::Igloo => {
    // rust: let o = igloo_offset(&self.template_name);
    // rust: let entrance_relative = StructureTemplate::transform(
    // rust: [3 - o[0], 0, -o[2]],
    // rust: Mirror::None,
    // rust: self.rotation,
    // rust: self.pivot,
    // rust: );
    // rust: let entrance = [
    // rust: self.position[0] + entrance_relative[0],
    // rust: 0,
    // rust: self.position[2] + entrance_relative[2],
    // rust: ];
    // rust: let height =
    // rust: c.world
    // rust: .height(HeightmapType::WorldSurfaceWg, entrance[0], entrance[2])?;
    // rust: let position = [
    // rust: self.position[0],
    // rust: self.position[1] + height - 90 - 1,
    // rust: self.position[2],
    // rust: ];
                // The box stays moved; templatePosition goes back after placing.
    // rust: *self.state.lock().unwrap() = Some(position[1]);
    // rust: if let Some(markers) = self.place_at(c, position, &[])? {
    // rust: for (marker, pos) in markers {
    // rust: if marker == "chest" {
    // rust: c.world.set(pos, c.state("air"), 3)?;
    // rust: let below = offset(pos, Direction::Down, 1);
    // rust: if c.is_block(below, "minecraft:chest")? {
    // rust: c.loot_table(
    // rust: below,
    // rust: "minecraft:chest",
    // rust: "minecraft:chests/igloo_chest",
    // rust: )?;
}
}
}
}
    // rust: if self.template_name == IGLOO_TOP {
    // rust: let r = StructureTemplate::transform(
    // rust: [3, 0, 5],
    // rust: Mirror::None,
    // rust: self.rotation,
    // rust: self.pivot,
    // rust: );
    // rust: let trapdoor = [position[0] + r[0], position[1] + r[1], position[2] + r[2]];
    // rust: let below = c.world.block(offset(trapdoor, Direction::Down, 1))?;
    // rust: if !c.is_air(below) && c.name(below) != "minecraft:ladder" {
    // rust: c.world.set(trapdoor, c.state("snow_block"), 3)?;
}
}
}
    // rust: TemplateHandler::Shipwreck { beached } => {
    // rust: let adjusted = *self.state.lock().unwrap();
    // rust: let y = match adjusted {
    // rust: Some(y) => y,
    // rust: None if shipwreck_too_big(&self.template) => self.position[1],
    // rust: None => {
    // rust: let kind = if beached {
    // rust: HeightmapType::WorldSurfaceWg
    // rust: } else {
    // rust: HeightmapType::OceanFloorWg
}
    // rust: let size = self.template.size;
    // rust: let mut min = c.world.max_y()? + 1;
    // rust: let mut mean = 0;
    // rust: let base = size[0] * size[2];
    // rust: if base == 0 {
    // rust: mean = c.world.height(kind, self.position[0], self.position[2])?;
    // rust: } else {
    // rust: for x in self.position[0]..self.position[0] + size[0] {
    // rust: for z in self.position[2]..self.position[2] + size[2] {
    // rust: let h = c.world.height(kind, x, z)?;
    // rust: mean += h;
    // rust: min = min.min(h);
}
}
    // rust: mean /= base;
}
    // rust: let y = if beached {
    // rust: min - size[1] / 2 - c.random.int(3)
    // rust: } else {
    // rust: mean
}
    // rust: *self.state.lock().unwrap() = Some(y);
    // rust: y
}
}
    // rust: let position = [self.position[0], y, self.position[2]];
    // rust: if let Some(markers) = self.place_at(c, position, &[])? {
    // rust: for (marker, pos) in markers {
    // rust: let table = match marker.as_str() {
    // rust: "map_chest" => "minecraft:chests/shipwreck_map",
    // rust: "treasure_chest" => "minecraft:chests/shipwreck_treasure",
    // rust: "supply_chest" => "minecraft:chests/shipwreck_supply",
    // rust: _ => continue,
}
    // rust: let below = offset(pos, Direction::Down, 1);
    // rust: let state = c.world.block(below)?;
    // rust: if c.resources.transforms.loot_container(state) {
    // rust: let kind = c.name(state).to_owned();
    // rust: c.loot_table(below, &kind, table)?;
}
}
}
}
    // rust: TemplateHandler::OceanRuin { .. } => {
    // rust: super::ocean_ruin::post_process(self, c)?;
}
    // rust: TemplateHandler::RuinedPortal(_) => {
    // rust: super::ruined_portal::post_process(self, c)?;
}
    // rust: TemplateHandler::Mansion => {
    // rust: super::mansion::post_process(self, c)?;
}
}
    // rust: Ok(())
}
}

// ScatteredFeaturePiece: an oriented box whose height is fixed on first use.
Scattered :: struct {
    frame: Mutex<PieceFrame>,
    width: i32,
    height: i32,
    depth: i32,
    height_position: Mutex<i32>,
}
    // rust: impl Scattered {
    // rust: pub fn new(
    // rust: west: i32,
    // rust: floor: i32,
    // rust: north: i32,
    // rust: width: i32,
    // rust: height: i32,
    // rust: depth: i32,
    // rust: direction: Direction,
    // rust: ) -> Self {
    // rust: Self {
    // rust: frame: Mutex::new(PieceFrame::new(
    // rust: make_bounding_box(west, floor, north, direction, width, height, depth),
    // rust: Some(direction),
    // rust: )),
    // rust: width,
    // rust: height,
    // rust: depth,
    // rust: height_position: Mutex::new(-1),
}
}
frame :: proc(self: ^Self) -> P {
    // Ported from Horizon
    return {}
}
    // rust: *self.frame.lock().unwrap()
}
    // `ScatteredFeaturePiece`'s tag: the box and the height it settled on.
saved :: proc(self: ^Self, id: string) -> c {
    // Ported from Horizon
    return {}
}
//         use crate::nbt::Tag;
    // rust: let f = self.frame();
    // rust: let mut tag = super::legacy::piece_tag(id, f.bounding_box, f.orientation, 0);
    // rust: for (key, value) in [
    // rust: ("Width", self.width),
    // rust: ("Height", self.height),
    // rust: ("Depth", self.depth),
    // rust: ("HPos", *self.height_position.lock().unwrap()),
    // rust: ] {
    // rust: tag.insert(key.into(), Tag::Int(value));
}
    // rust: tag
}
    // updateAverageGroundHeight over the part of the box inside the chunk.
average_ground :: proc(self: ^Self, c: ^PieceContext<'_>, offset: i32) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if *self.height_position.lock().unwrap() >= 0 {
    // rust: return Ok(true);
}
    // rust: let b = self.frame().bounding_box;
    // rust: let (mut total, mut count) = (0, 0);
    // rust: for z in b.min[2]..=b.max[2] {
    // rust: for x in b.min[0]..=b.max[0] {
    // rust: if c.chunk_box.is_inside([x, 64, z]) {
    // rust: total += c
    // rust: .world
    // rust: .height(HeightmapType::MotionBlockingNoLeaves, x, z)?;
    // rust: count += 1;
}
}
}
    // rust: if count == 0 {
    // rust: return Ok(false);
}
    // rust: let h = total / count;
    // rust: *self.height_position.lock().unwrap() = h;
    // rust: let mut frame = self.frame.lock().unwrap();
    // rust: frame.bounding_box =
    // rust: frame
    // rust: .bounding_box
    // rust: .moved([0, h - frame.bounding_box.min[1] + offset, 0]);
    // rust: Ok(true)
}
    // updateHeightPositionToLowestGroundHeight over the whole box.
lowest_ground :: proc(self: ^Self, c: ^PieceContext<'_>, offset: i32) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if *self.height_position.lock().unwrap() >= 0 {
    // rust: return Ok(true);
}
    // rust: let b = self.frame().bounding_box;
    // rust: let mut lowest = c.world.max_y()? + 1;
    // rust: for z in b.min[2]..=b.max[2] {
    // rust: for x in b.min[0]..=b.max[0] {
    // rust: lowest = lowest.min(
    // rust: c.world
    // rust: .height(HeightmapType::MotionBlockingNoLeaves, x, z)?,
    // rust: );
}
}
    // rust: *self.height_position.lock().unwrap() = lowest;
    // rust: let mut frame = self.frame.lock().unwrap();
    // rust: frame.bounding_box =
    // rust: frame
    // rust: .bounding_box
    // rust: .moved([0, lowest - frame.bounding_box.min[1] + offset, 0]);
    // rust: Ok(true)
}
}

SwampHutPiece :: struct {
    base: Scattered,
    // spawnedWitch and spawnedCat: both spawn in the same chunk.
    spawned: Mutex<bool>,
}
    // rust: impl SwampHutPiece {
new :: proc(random: ^impl RandomSource, west: i32, north: i32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let direction = random_horizontal(random);
    // rust: Self {
    // rust: base: Scattered::new(west, 64, north, 7, 7, 9, direction),
    // rust: spawned: Mutex::new(false),
}
}
}
    // rust: impl LegacyPiece for SwampHutPiece {
bounding_box :: proc(self: ^Self) -> B {
    // Ported from Horizon
    return {}
}
    // rust: self.base.frame().bounding_box
}
save :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let mut tag = self.base.saved("minecraft:tesh");
    // rust: let spawned = crate::nbt::Tag::Byte(i8::from(*self.spawned.lock().unwrap()));
    // rust: tag.insert("Witch".into(), spawned.clone());
    // rust: tag.insert("Cat".into(), spawned);
    // rust: Some(tag)
}
type_name :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: "minecraft:tesh"
}
post_process :: proc(self: ^Self, c: ^PieceContext<'_>) -> R {
    // Ported from Horizon
    return {}
}
    // rust: if !self.base.average_ground(c, 0)? {
    // rust: return Ok(());
}
    // rust: let f = self.base.frame();
    // rust: let planks = c.state("spruce_planks");
    // rust: let log = c.state("oak_log");
    // rust: for (a, b) in [
    // rust: ([1, 1, 1], [5, 1, 7]),
    // rust: ([1, 4, 2], [5, 4, 7]),
    // rust: ([2, 1, 0], [4, 1, 0]),
    // rust: ([2, 2, 2], [3, 3, 2]),
    // rust: ([1, 2, 3], [1, 3, 6]),
    // rust: ([5, 2, 3], [5, 3, 6]),
    // rust: ([2, 2, 7], [4, 3, 7]),
    // rust: ] {
    // rust: f.generate_box(c, a, b, planks, planks, false)?;
}
    // rust: for (a, b) in [
    // rust: ([1, 0, 2], [1, 3, 2]),
    // rust: ([5, 0, 2], [5, 3, 2]),
    // rust: ([1, 0, 7], [1, 3, 7]),
    // rust: ([5, 0, 7], [5, 3, 7]),
    // rust: ] {
    // rust: f.generate_box(c, a, b, log, log, false)?;
}
    // rust: let fence = c.state("oak_fence");
    // rust: let air = c.state("air");
    // rust: f.place(c, fence, 2, 3, 2)?;
    // rust: f.place(c, fence, 3, 3, 7)?;
    // rust: f.place(c, air, 1, 3, 4)?;
    // rust: f.place(c, air, 5, 3, 4)?;
    // rust: f.place(c, air, 5, 3, 5)?;
    // rust: f.place(c, c.state("potted_red_mushroom"), 1, 3, 5)?;
    // rust: f.place(c, c.state("crafting_table"), 3, 2, 6)?;
    // rust: f.place(c, c.state("cauldron"), 4, 2, 6)?;
    // rust: f.place(c, fence, 1, 2, 1)?;
    // rust: f.place(c, fence, 5, 2, 1)?;
    // rust: let stairs = |c: &PieceContext<'_>, facing: &str, shape: &str| {
    // rust: c.state_with("spruce_stairs", &[("facing", facing), ("shape", shape)])
}
    // rust: let north = stairs(c, "north", "straight");
    // rust: let east = stairs(c, "east", "straight");
    // rust: let west = stairs(c, "west", "straight");
    // rust: let south = stairs(c, "south", "straight");
    // rust: f.generate_box(c, [0, 4, 1], [6, 4, 1], north, north, false)?;
    // rust: f.generate_box(c, [0, 4, 2], [0, 4, 7], east, east, false)?;
    // rust: f.generate_box(c, [6, 4, 2], [6, 4, 7], west, west, false)?;
    // rust: f.generate_box(c, [0, 4, 8], [6, 4, 8], south, south, false)?;
    // rust: f.place(c, stairs(c, "north", "outer_right"), 0, 4, 1)?;
    // rust: f.place(c, stairs(c, "north", "outer_left"), 6, 4, 1)?;
    // rust: f.place(c, stairs(c, "south", "outer_left"), 0, 4, 8)?;
    // rust: f.place(c, stairs(c, "south", "outer_right"), 6, 4, 8)?;
    // rust: for z in [2, 7] {
    // rust: for x in [1, 5] {
    // rust: f.fill_column_down(c, log, x, -1, z)?;
}
}
        // The witch, then spawnCat, both at (2, 2, 5).
    // rust: let pos = f.world_pos(2, 2, 5);
    // rust: if c.chunk_box.is_inside(pos) {
    // rust: for id in ["minecraft:witch", "minecraft:cat"] {
    // rust: c.world
    // rust: .entity(super::legacy::spawn_nbt(id, pos, true, true))?;
}
    // rust: *self.spawned.lock().unwrap() = true;
}
    // rust: Ok(())
}
}
