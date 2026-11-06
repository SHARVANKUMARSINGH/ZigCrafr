//! Transpiled from Horizon Rust crate
//! Module: horizon-world_end_city
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! End cities: EndCityStructure piece assembly (EndCityPieces section
//! generators) and EndCityPiece data markers.
// use super::{
    // rust: BoundingBox, Mirror, Rotation, StructureResources, StructureTemplate,
    // rust: legacy::{LegacyPiece, PieceContext, Result, TemplateHandler, TemplatePiece, offset},
    // rust: processor::ProcessorList,
}
// use crate::nbt::{Compound, Tag};
// use horizon_core::{geometry::Direction, random::RandomSource};
// use std::sync::Arc;

pub const MAX_GEN_DEPTH: i32 = 8;
    // rust: const TOWER_BRIDGES: [(Rotation, [i32; 3]); 4] = [
    // rust: (Rotation::None, [1, -1, 0]),
    // rust: (Rotation::Clockwise90, [6, -1, 1]),
    // rust: (Rotation::Counterclockwise90, [0, -1, 5]),
    // rust: (Rotation::Clockwise180, [5, -1, 6]),
    // rust: ];
    // rust: const FAT_TOWER_BRIDGES: [(Rotation, [i32; 3]); 4] = [
    // rust: (Rotation::None, [4, -1, 0]),
    // rust: (Rotation::Clockwise90, [12, -1, 4]),
    // rust: (Rotation::Counterclockwise90, [0, -1, 8]),
    // rust: (Rotation::Clockwise180, [8, -1, 12]),
    // rust: ];

/// A piece during assembly: template, position, settings and genDepth.
pub const Draft = struct {
    name: *'static str,
    template: *StructureTemplate,
    position: [i32,
    rotation: Rotation,
    overwrite: bool,
    depth: i32,
    bounding_box: BoundingBox,
};
pub const Section = enum {
    HouseTower,
    Tower,
    TowerBridge,
    FatTower,
};
pub const Assembly = struct {
    resources: *'a StructureResources,
    random: *'a mut R,
    /// TOWER_BRIDGE_GENERATOR.shipCreated.
    ship: bool,
};

    // rust: fn draft(
    // rust: resources: &StructureResources,
    // rust: name: &'static str,
    // rust: position: [i32; 3],
    // rust: rotation: Rotation,
    // rust: overwrite: bool,
    // rust: ) -> Option<Draft> {
    // rust: let template = resources.template(&format!("minecraft:end_city/{name}"))?;
    // rust: Some(Draft {
    // rust: name,
    // rust: bounding_box: template.bounding_box(position, rotation, [0; 3], Mirror::None),
    // rust: template,
    // rust: position,
    // rust: rotation,
    // rust: overwrite,
    // rust: depth: 0,
    // rust: })
}

    // rust: impl<R: RandomSource> Assembly<'_, R> {
pub fn int(self: *Self, bound: i32) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.random.next_int_bound(bound).unwrap_or(0)
}
    /// EndCityPieces.addPiece: the child is connected to the parent by
    /// StructureTemplate.calculateConnectedPosition(offset, ZERO).
    // rust: fn add(
    // rust: &self,
    // rust: parent: &Draft,
    // rust: offset: [i32; 3],
    // rust: name: &'static str,
    // rust: rotation: Rotation,
    // rust: overwrite: bool,
    // rust: ) -> Option<Draft> {
    // rust: let mut child = draft(self.resources, name, parent.position, rotation, overwrite)?;
    // rust: let a = StructureTemplate::transform(offset, Mirror::None, parent.rotation, [0; 3]);
    // rust: let b = StructureTemplate::transform([0; 3], Mirror::None, rotation, [0; 3]);
    // rust: let d: [i32; 3] = std::array::from_fn(|i| a[i] - b[i]);
    // rust: child.position = std::array::from_fn(|i| child.position[i] + d[i]);
    // rust: child.bounding_box = child.bounding_box.moved(d);
    // rust: Some(child)
}
    // rust: fn push(
    // rust: &self,
    // rust: pieces: &mut Vec<Draft>,
    // rust: parent: &Draft,
    // rust: offset: [i32; 3],
    // rust: name: &'static str,
    // rust: rotation: Rotation,
    // rust: overwrite: bool,
    // rust: ) -> Option<Draft> {
    // rust: let child = self.add(parent, offset, name, rotation, overwrite)?;
    // rust: pieces.push(child.clone());
    // rust: Some(child)
}
    /// EndCityPieces.recursiveChildren.
    // rust: fn children(
    // rust: &mut self,
    // rust: section: Section,
    // rust: depth: i32,
    // rust: parent: &Draft,
    // rust: offset: [i32; 3],
    // rust: pieces: &mut Vec<Draft>,
    // rust: ) -> Option<bool> {
    // rust: if depth > MAX_GEN_DEPTH {
    // rust: return Some(false);
}
    // rust: let mut children = Vec::new();
    // rust: if self.generate(section, depth, parent, offset, &mut children)? {
    // rust: let tag = self.random.next_int();
    // rust: let mut collision = false;
    // rust: for child in &mut children {
    // rust: child.depth = tag;
    // rust: if let Some(other) = pieces
    // rust: .iter()
    // rust: .find(|p| p.bounding_box.intersects(&child.bounding_box))
    // rust: && other.depth != parent.depth
    // rust: {
    // rust: collision = true;
    // rust: break;
}
}
    // rust: if !collision {
    // rust: pieces.extend(children);
    // rust: return Some(true);
}
}
    // rust: Some(false)
}
    // rust: fn generate(
    // rust: &mut self,
    // rust: section: Section,
    // rust: depth: i32,
    // rust: parent: &Draft,
    // rust: offset: [i32; 3],
    // rust: pieces: &mut Vec<Draft>,
    // rust: ) -> Option<bool> {
    // rust: let rotation = parent.rotation;
    // rust: match section {
    // rust: Section::HouseTower => {
    // rust: if depth > MAX_GEN_DEPTH {
    // rust: return Some(false);
}
    // rust: let mut last = self.push(pieces, parent, offset, "base_floor", rotation, true)?;
    // rust: match self.int(3) {
    // rust: 0 => {
    // rust: self.push(pieces, &last, [-1, 4, -1], "base_roof", rotation, true)?;
}
    // rust: 1 => {
    // rust: last = self.push(
    // rust: pieces,
    // rust: &last,
    // rust: [-1, 0, -1],
    // rust: "second_floor_2",
    // rust: rotation,
    // rust: false,
    // rust: )?;
    // rust: last =
    // rust: self.push(pieces, &last, [-1, 8, -1], "second_roof", rotation, false)?;
    // rust: self.children(Section::Tower, depth + 1, &last, [0; 3], pieces)?;
}
    // rust: _ => {
    // rust: last = self.push(
    // rust: pieces,
    // rust: &last,
    // rust: [-1, 0, -1],
    // rust: "second_floor_2",
    // rust: rotation,
    // rust: false,
    // rust: )?;
    // rust: last = self.push(
    // rust: pieces,
    // rust: &last,
    // rust: [-1, 4, -1],
    // rust: "third_floor_2",
    // rust: rotation,
    // rust: false,
    // rust: )?;
    // rust: last =
    // rust: self.push(pieces, &last, [-1, 8, -1], "third_roof", rotation, true)?;
    // rust: self.children(Section::Tower, depth + 1, &last, [0; 3], pieces)?;
}
}
    // rust: Some(true)
}
    // rust: Section::Tower => {
    // rust: let x = 3 + self.int(2);
    // rust: let z = 3 + self.int(2);
    // rust: let mut last =
    // rust: self.push(pieces, parent, [x, -3, z], "tower_base", rotation, true)?;
    // rust: last = self.push(pieces, &last, [0, 7, 0], "tower_piece", rotation, true)?;
    // rust: let mut bridge = (self.int(3) == 0).then(|| last.clone());
    // rust: let height = 1 + self.int(3);
    // rust: for i in 0..height {
    // rust: last = self.push(pieces, &last, [0, 4, 0], "tower_piece", rotation, true)?;
    // rust: if i < height - 1 && self.random.next_boolean() {
    // rust: bridge = Some(last.clone());
}
}
    // rust: if let Some(bridge) = bridge {
    // rust: for (turn, offset) in TOWER_BRIDGES {
    // rust: if self.random.next_boolean() {
    // rust: let start = self.push(
    // rust: pieces,
    // rust: &bridge,
    // rust: offset,
    // rust: "bridge_end",
    // rust: rotation.get_rotated(turn),
    // rust: true,
    // rust: )?;
    // rust: self.children(Section::TowerBridge, depth + 1, &start, [0; 3], pieces)?;
}
}
    // rust: } else if depth != 7 {
    // rust: return self.children(Section::FatTower, depth + 1, &last, [0; 3], pieces);
}
    // rust: self.push(pieces, &last, [-1, 4, -1], "tower_top", rotation, true)?;
    // rust: Some(true)
}
    // rust: Section::TowerBridge => {
    // rust: let length = self.int(4) + 1;
    // rust: let mut last =
    // rust: self.push(pieces, parent, [0, 0, -4], "bridge_piece", rotation, true)?;
    // rust: if let Some(first) = pieces.last_mut() {
    // rust: first.depth = -1;
}
    // rust: last.depth = -1;
    // rust: let mut next_y = 0;
    // rust: for _ in 0..length {
    // rust: if self.random.next_boolean() {
    // rust: last = self.push(
    // rust: pieces,
    // rust: &last,
    // rust: [0, next_y, -4],
    // rust: "bridge_piece",
    // rust: rotation,
    // rust: true,
    // rust: )?;
    // rust: next_y = 0;
    // rust: } else {
    // rust: last = if self.random.next_boolean() {
    // rust: self.push(
    // rust: pieces,
    // rust: &last,
    // rust: [0, next_y, -4],
    // rust: "bridge_steep_stairs",
    // rust: rotation,
    // rust: true,
    // rust: )?
    // rust: } else {
    // rust: self.push(
    // rust: pieces,
    // rust: &last,
    // rust: [0, next_y, -8],
    // rust: "bridge_gentle_stairs",
    // rust: rotation,
    // rust: true,
    // rust: )?
}
    // rust: next_y = 4;
}
}
    // rust: if !self.ship && self.int(10 - depth) == 0 {
    // rust: let x = -8 + self.int(8);
    // rust: let z = -70 + self.int(10);
    // rust: self.push(pieces, &last, [x, next_y, z], "ship", rotation, true)?;
    // rust: self.ship = true;
    // rust: } else if !self.children(
    // rust: Section::HouseTower,
    // rust: depth + 1,
    // rust: &last,
    // rust: [-3, next_y + 1, -11],
    // rust: pieces,
    // rust: )? {
    // rust: return Some(false);
}
    // rust: self.push(
    // rust: pieces,
    // rust: &last,
    // rust: [4, next_y, 0],
    // rust: "bridge_end",
    // rust: rotation.get_rotated(Rotation::Clockwise180),
    // rust: true,
    // rust: )?;
    // rust: if let Some(end) = pieces.last_mut() {
    // rust: end.depth = -1;
}
    // rust: Some(true)
}
    // rust: Section::FatTower => {
    // rust: let mut last = self.push(
    // rust: pieces,
    // rust: parent,
    // rust: [-3, 4, -3],
    // rust: "fat_tower_base",
    // rust: rotation,
    // rust: true,
    // rust: )?;
    // rust: last = self.push(pieces, &last, [0, 4, 0], "fat_tower_middle", rotation, true)?;
    // rust: let mut i = 0;
    // rust: while i < 2 && self.int(3) != 0 {
    // rust: last =
    // rust: self.push(pieces, &last, [0, 8, 0], "fat_tower_middle", rotation, true)?;
    // rust: for (turn, offset) in FAT_TOWER_BRIDGES {
    // rust: if self.random.next_boolean() {
    // rust: let start = self.push(
    // rust: pieces,
    // rust: &last,
    // rust: offset,
    // rust: "bridge_end",
    // rust: rotation.get_rotated(turn),
    // rust: true,
    // rust: )?;
    // rust: self.children(Section::TowerBridge, depth + 1, &start, [0; 3], pieces)?;
}
}
    // rust: i += 1;
}
    // rust: self.push(pieces, &last, [-2, 8, -2], "fat_tower_top", rotation, true)?;
    // rust: Some(true)
}
}
}
}

/// EndCityPieces.startHouseTower.
    // rust: pub fn pieces(
    // rust: resources: &StructureResources,
    // rust: origin: [i32; 3],
    // rust: rotation: Rotation,
    // rust: random: &mut impl RandomSource,
    // rust: ) -> Option<Vec<EndCityPiece>> {
    // rust: let mut a = Assembly {
    // rust: resources,
    // rust: random,
    // rust: ship: false,
}
    // rust: let mut pieces = Vec::new();
    // rust: let mut last = draft(resources, "base_floor", origin, rotation, true)?;
    // rust: pieces.push(last.clone());
    // rust: last = a.push(
    // rust: &mut pieces,
    // rust: &last,
    // rust: [-1, 0, -1],
    // rust: "second_floor_1",
    // rust: rotation,
    // rust: false,
    // rust: )?;
    // rust: last = a.push(
    // rust: &mut pieces,
    // rust: &last,
    // rust: [-1, 4, -1],
    // rust: "third_floor_1",
    // rust: rotation,
    // rust: false,
    // rust: )?;
    // rust: last = a.push(
    // rust: &mut pieces,
    // rust: &last,
    // rust: [-1, 8, -1],
    // rust: "third_roof",
    // rust: rotation,
    // rust: true,
    // rust: )?;
    // rust: a.children(Section::Tower, 1, &last, [0; 3], &mut pieces)?;
    // rust: Some(
    // rust: pieces
    // rust: .into_iter()
    // rust: .map(|d| {
    // rust: let ignore = if d.overwrite {
    // rust: vec!["minecraft:structure_block".into()]
    // rust: } else {
    // rust: vec!["minecraft:structure_block".into(), "minecraft:air".into()]
}
    // rust: EndCityPiece(
    // rust: TemplatePiece::new(
    // rust: "minecraft:ecp",
    // rust: &format!("minecraft:end_city/{}", d.name),
    // rust: d.template,
    // rust: d.position,
    // rust: d.rotation,
    // rust: Mirror::None,
    // rust: [0; 3],
    // rust: Arc::new(ProcessorList::default()),
    // rust: true,
    // rust: ignore,
    // rust: TemplateHandler::Plain,
    // rust: ),
    // rust: d.depth,
    // rust: )
    // rust: })
    // rust: .collect(),
    // rust: )
}

/// EndCityPieces.EndCityPiece.
/// The template piece and its genDepth (the collision tag of its batch).
pub const EndCityPiece = struct {};
    // rust: impl LegacyPiece for EndCityPiece {
pub fn bounding_box(self: *Self) B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.0.bounding_box
}
    /// `EndCityPiece`: the template piece's tag, `OW` for the pieces that
    /// overwrite air (only structure blocks ignored).
pub fn save(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut tag = self.0.saved();
    // rust: tag.insert("GD".into(), crate::nbt::Tag::Int(self.1));
    // rust: let overwrite = self.0.ignore.len() == 1;
    // rust: tag.insert("OW".into(), crate::nbt::Tag::Byte(i8::from(overwrite)));
    // rust: Some(tag)
}
pub fn type_name(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: "minecraft:ecp"
}
pub fn post_process(self: *Self, c: *mut PieceContext<'_>) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(markers) = self.0.place_at(c, self.0.position, &[])? else {
    // rust: return Ok(());
}
    // rust: for (marker, pos) in markers {
    // rust: if marker.starts_with("Sentry") {
    // rust: c.world.entity(super::legacy::spawn_nbt(
    // rust: "minecraft:shulker",
    // rust: pos,
    // rust: false,
    // rust: false,
    // rust: ))?;
    // rust: } else if marker.starts_with("Elytra") {
                // An item frame on the marker, facing the rotated south.
    // rust: let facing = self.0.rotation.rotate_direction(Direction::South);
    // rust: let mut nbt = super::legacy::spawn_nbt("minecraft:item_frame", pos, false, false);
    // rust: nbt.insert("block_pos".into(), Tag::IntArray(pos.to_vec()));
    // rust: let data = match facing {
    // rust: Direction::North => 2,
    // rust: Direction::South => 3,
    // rust: Direction::West => 4,
    // rust: _ => 5,
}
    // rust: nbt.insert("Facing".into(), Tag::Byte(data));
    // rust: let mut item = Compound::new();
    // rust: item.insert("id".into(), Tag::String("minecraft:elytra".into()));
    // rust: item.insert("count".into(), Tag::Int(1));
    // rust: nbt.insert("Item".into(), Tag::Compound(item));
    // rust: c.world.entity(nbt)?;
    // rust: } else if marker.starts_with("Chest") {
    // rust: let chest = offset(pos, Direction::Down, 1);
    // rust: if c.chunk_box.is_inside(chest) {
    // rust: c.loot_table(
    // rust: chest,
    // rust: "minecraft:chest",
    // rust: "minecraft:chests/end_city_treasure",
    // rust: )?;
}
}
}
    // rust: Ok(())
}
}
