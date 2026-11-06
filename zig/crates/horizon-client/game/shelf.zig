//! Transpiled from Horizon Rust crate
//! Module: horizon-client_shelf
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The displayed items of `ShelfBlockEntity`.
// use super::{Game, Hit, machines::dir_from_name};
// use horizon_assets::item_model::DisplayContext;
// use horizon_client::{block_entity_render::vertex_light, containers::BlockEntity, mesher::Vertex};
// use horizon_core::{
    // rust: geometry::{Direction, Vec3},
    // rust: position::BlockPos,
}
// use horizon_world::level::hit_slot;

    // rust: impl Game<'_> {
    /// Slot and facing for a click on a shelf's front face.
    // rust: pub(super) fn shelf_hit(&self, hit: &Hit) -> Option<(usize, Direction, bool)> {
    // rust: let p = hit.pos;
    // rust: if !matches!(
    // rust: self.world.block_entities.get(&(p[0], p[1], p[2])),
    // rust: Some(BlockEntity::Shelf(_))
    // rust: ) {
    // rust: return None;
}
    // rust: let state = self.world.block(p[0], p[1], p[2]);
    // rust: let data = self.pack.assets.registry.state(state)?;
    // rust: let facing = data
    // rust: .properties
    // rust: .get("facing")
    // rust: .and_then(|s| dir_from_name(s))?;
    // rust: let face = Direction::ALL
    // rust: .into_iter()
    // rust: .find(|d| d.normal() == hit.face)?;
    // rust: let slot = hit_slot(
    // rust: facing,
    // rust: face,
    // rust: BlockPos::new(p[0], p[1], p[2]),
    // rust: Vec3::new(hit.point[0], hit.point[1], hit.point[2]),
    // rust: 1,
    // rust: 3,
    // rust: )?;
    // rust: Some((
    // rust: slot,
    // rust: facing,
    // rust: data.properties.get("powered").is_some_and(|s| s == "true"),
    // rust: ))
}

    /// `SideChainPartBlock.getAllBlocksConnectedTo`: left to right, at most three.
pub fn shelf_chain(self: *Self, pos: [i32; 3], facing: Direction) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let left = match facing {
    // rust: Direction::North => Direction::East,
    // rust: Direction::East => Direction::South,
    // rust: Direction::South => Direction::West,
    // rust: Direction::West => Direction::North,
    // rust: _ => return Vec::new(),
}
    // rust: let state = self.world.block(pos[0], pos[1], pos[2]);
    // rust: let behaviours = self.res.behaviours();
    // rust: if !behaviours
    // rust: .tag("minecraft:wooden_shelves")
    // rust: .is_some_and(|tag| tag.contains(behaviours.block(state)))
    // rust: {
    // rust: return Vec::new();
}
    // rust: let mut result = vec![pos];
    // rust: for (dir, end, prepend) in [(left, "left", true), (left.opposite(), "right", false)] {
    // rust: let normal = dir.normal();
    // rust: for step in 1..3 {
    // rust: let p = [pos[0] + normal[0] * step, pos[1], pos[2] + normal[2] * step];
    // rust: let state = self.world.block(p[0], p[1], p[2]);
    // rust: let Some(info) = self.pack.assets.registry.state(state) else {
    // rust: break;
}
    // rust: let behaviours = self.res.behaviours();
    // rust: let connectable = behaviours
    // rust: .tag("minecraft:wooden_shelves")
    // rust: .is_some_and(|tag| tag.contains(behaviours.block(state)))
    // rust: && info.properties.get("powered").is_some_and(|s| s == "true")
    // rust: && info.properties.get("facing").and_then(|s| dir_from_name(s)) == Some(facing);
    // rust: if !connectable {
    // rust: break;
}
    // rust: let part = info
    // rust: .properties
    // rust: .get("side_chain")
    // rust: .map(String::as_str)
    // rust: .unwrap_or("unconnected");
    // rust: if part == "center" || part == end {
    // rust: if prepend {
    // rust: result.insert(0, p);
    // rust: } else {
    // rust: result.push(p);
}
}
    // rust: if part != "center" {
    // rust: break;
}
}
}
    // rust: result
}

    /// `ShelfBlock.useItemOn`: a single swap, or a connected hotbar swap while powered.
    // rust: pub(super) fn use_shelf(&mut self, hit: &Hit) -> Option<bool> {
//         use horizon_client::first_person::Hand;
    // rust: if self.hand != Hand::Main {
    // rust: return None;
}
    // rust: let (slot, facing, powered) = self.shelf_hit(hit)?;
    // rust: let pos = hit.pos;
    // rust: let state = self.world.block(pos[0], pos[1], pos[2]);
    // rust: if powered {
    // rust: let chain = self.shelf_chain(pos, facing);
    // rust: let mut swapped = false;
    // rust: let count = chain.len();
    // rust: for (i, p) in chain.into_iter().enumerate() {
    // rust: let key = (p[0], p[1], p[2]);
    // rust: let Some(BlockEntity::Shelf(shelf)) = self.world.block_entities.get_mut(&key)
    // rust: else {
    // rust: continue;
}
    // rust: for n in 0..3 {
    // rust: let index = 9_i32 - (count as i32 - i as i32) * 3 + n as i32;
    // rust: if !(0..9).contains(&index) {
    // rust: continue;
}
    // rust: let index = index as usize;
    // rust: swapped |= self.inventory[index].is_some() || shelf.items[n].is_some();
    // rust: std::mem::swap(&mut self.inventory[index], &mut shelf.items[n]);
}
    // rust: self.container_changed(key);
    // rust: let s = self.world.block(p[0], p[1], p[2]);
    // rust: self.post_block_game_event("minecraft:entity_interact", p, None, Some(s));
}
    // rust: if !swapped {
    // rust: return Some(false);
}
    // rust: self.audio.play(
    // rust: "minecraft:block.shelf.multi_swap",
    // rust: Some(pos.map(|n| f64::from(n) + 0.5)),
    // rust: 1.0,
    // rust: 1.0,
    // rust: );
    // rust: Some(true)
    // rust: } else {
    // rust: let held = self.inventory[self.selected].clone();
    // rust: let key = (pos[0], pos[1], pos[2]);
    // rust: let Some(BlockEntity::Shelf(shelf)) = self.world.block_entities.get_mut(&key) else {
    // rust: return None;
}
    // rust: let removed = std::mem::replace(&mut shelf.items[slot], held.clone());
    // rust: self.inventory[self.selected] = if self.creative && removed.is_none() {
    // rust: held.clone()
    // rust: } else {
    // rust: removed.clone()
}
    // rust: self.container_changed(key);
    // rust: let vibrations = self.inventory[self.selected].as_ref().is_none_or(|stack| {
    // rust: let default = self
    // rust: .res
    // rust: .items()
    // rust: .get(&stack.item)
    // rust: .is_none_or(|item| item.interact_vibrations);
    // rust: let Some(data) = stack.data() else {
    // rust: return default;
}
    // rust: if data
    // rust: .other
    // rust: .iter()
    // rust: .any(|(key, _)| key == "!minecraft:use_effects")
    // rust: {
    // rust: return true;
}
    // rust: data.other
    // rust: .iter()
    // rust: .find(|(key, _)| key == "minecraft:use_effects")
    // rust: .map_or(default, |(_, tag)| {
    // rust: horizon_client::save::number(tag.get("interact_vibrations")).unwrap_or(1)
    // rust: != 0
    // rust: })
    // rust: });
    // rust: if vibrations {
    // rust: self.post_block_game_event(
    // rust: "minecraft:item_interact_finish",
    // rust: pos,
    // rust: None,
    // rust: Some(state),
    // rust: );
}
    // rust: let sound = match (held.is_some(), removed.is_some()) {
    // rust: (false, false) => return None,
    // rust: (true, false) => "minecraft:block.shelf.place_item",
    // rust: (false, true) => "minecraft:block.shelf.take_item",
    // rust: (true, true) => "minecraft:block.shelf.single_swap",
}
    // rust: self.audio
    // rust: .play(sound, Some(pos.map(|n| f64::from(n) + 0.5)), 1.0, 1.0);
    // rust: Some(true)
}
}

    /// `ShelfRenderer`: three items face out, aligned to the bottom or centre.
    // rust: pub(super) fn shelf_geometry(&self, camera: glam::DVec3, out: &mut Vec<Vertex>) {
    // rust: for (key, entity) in &self.world.block_entities {
    // rust: let BlockEntity::Shelf(shelf) = entity else {
    // rust: continue;
}
    // rust: let at = glam::DVec3::new(f64::from(key.0), f64::from(key.1), f64::from(key.2));
    // rust: if at.distance_squared(camera) >= 64.0 * 64.0 {
    // rust: continue;
}
    // rust: let block = self.world.block(key.0, key.1, key.2);
    // rust: let facing = self
    // rust: .pack
    // rust: .assets
    // rust: .registry
    // rust: .state(block)
    // rust: .and_then(|s| s.properties.get("facing"))
    // rust: .map(String::as_str)
    // rust: .unwrap_or("north");
    // rust: let yaw: f32 = match facing {
    // rust: "south" => 0.0,
    // rust: "west" => -90.0,
    // rust: "north" => -180.0,
    // rust: "east" => -270.0,
    // rust: _ => 180.0,
}
    // rust: let packed = BlockPos::new(key.0, key.1, key.2).pack() as u64;
    // rust: let seed = (packed ^ (packed >> 32)) as i32;
    // rust: let light = vertex_light(self.world.light(key.0, key.1, key.2));
    // rust: for (slot, stack) in shelf.items.iter().enumerate() {
    // rust: let Some(stack) = stack else { continue };
    // rust: let item = self.resolve_item(
    // rust: stack,
    // rust: DisplayContext::OnShelf,
    // rust: None,
    // rust: seed.wrapping_add(slot as i32),
    // rust: );
    // rust: if item.is_empty() {
    // rust: continue;
}
    // rust: let (lo, hi) = item.bounding_box();
    // rust: let offset_y = -lo.y
    // rust: - if shelf.align_to_bottom {
    // rust: 0.0
    // rust: } else {
    // rust: (hi.y - lo.y) / 2.0
}
    // rust: let pose =
    // rust: glam::Mat4::from_translation((at - camera).as_vec3() + glam::Vec3::splat(0.5))
    // rust: * glam::Mat4::from_rotation_y(yaw.to_radians())
    // rust: * glam::Mat4::from_translation(glam::Vec3::new(
    // rust: (slot as f32 - 1.0) * 0.3125,
    // rust: if shelf.align_to_bottom { -0.25 } else { 0.0 },
    // rust: -0.25,
    // rust: ))
    // rust: * glam::Mat4::from_scale(glam::Vec3::splat(0.25))
    // rust: * glam::Mat4::from_translation(glam::Vec3::new(0.0, offset_y, 0.0));
    // rust: self.submit_item_world(&item, pose, light, out);
}
}
}
}
