//! Transpiled from Horizon Rust crate
//! Module: horizon-client_cartography
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The cartography table (`CartographyTableMenu` on the menu engine,
//! `CartographyTableScreen`): zooming a map out with paper, cloning it with
//! an empty map, locking it with a glass pane. The engine reads the level's
//! maps through `LevelMaps`; the scaled and locked copies a take makes
//! (`MapItem.scaleMap`, `lockMap`) are registered after the click. The
//! screen draws the preview with its error and lock sprites.
// use super::{
    // rust: Game,
    // rust: maps::{MapData, map_id, shown_on_frame},
}
// use horizon_client::{hud::HudBatch, items::ItemStack, menu::Maps};
// use std::{
    // rust: cell::{Cell, RefCell},
    // rust: collections::HashMap,
}

/// The level's maps as a menu sees them (`ContainerLevelAccess`): the
/// states of the maps the click can reach, and the copies it makes.
    // rust: pub(super) struct LevelMaps {
    // rust: states: RefCell<HashMap<i32, (bool, u8)>>,
    // rust: next_id: Cell<i32>,
    /// (new id, source id, scaled) for each copy made.
    // rust: made: RefCell<Vec<(i32, i32, bool)>>,
}

    // rust: impl Maps for LevelMaps {
pub fn state(self: *Self, id: i32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.states.borrow().get(&id).copied()
}

pub fn derive(self: *Self, id: i32, scale: bool) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (_, s) = self.state(id)?;
    // rust: let new = self.next_id.get();
    // rust: self.next_id.set(new + 1);
    // rust: let made = if scale {
    // rust: (false, (s + 1).min(4))
    // rust: } else {
    // rust: (true, s)
}
    // rust: self.states.borrow_mut().insert(new, made);
    // rust: self.made.borrow_mut().push((new, id, scale));
    // rust: Some(new)
}
}

    // rust: impl Game<'_> {
    /// The maps of `stacks` (loaded as needed) for a menu over this level.
    // rust: pub(super) fn level_maps<'s>(
    // rust: &mut self,
    // rust: stacks: impl IntoIterator<Item = &'s ItemStack>,
    // rust: ) -> LevelMaps {
    // rust: let ids: Vec<i32> = stacks.into_iter().filter_map(map_id).collect();
    // rust: let mut states = HashMap::new();
    // rust: for id in ids {
    // rust: if let Some(m) = self.map(id) {
    // rust: states.insert(id, (m.locked, m.scale));
}
}
    // rust: LevelMaps {
    // rust: states: RefCell::new(states),
    // rust: next_id: Cell::new(self.peek_map_id()),
    // rust: made: RefCell::new(Vec::new()),
}
}

    /// The scaled and locked copies a menu made (`level.setMapData`).
    // rust: pub(super) fn register_made_maps(&mut self, maps: LevelMaps) {
    // rust: for (id, source, scale) in maps.made.into_inner() {
    // rust: let Some(data) = self
    // rust: .map(source)
    // rust: .map(|m| if scale { m.scaled() } else { m.locked_copy() })
    // rust: else {
    // rust: continue;
}
    // rust: let new = self.new_map_id(data);
    // rust: debug_assert_eq!(new, id, "map ids follow peek_map_id");
}
}
    /// `CartographyTableScreen.extractBackground` after the background.
    // rust: pub(super) fn draw_cartography(&mut self, batch: &mut HudBatch, ox: f32, oy: f32) {
    // rust: let Some((map, extra)) = self
    // rust: .station
    // rust: .as_ref()
    // rust: .map(|s| (s.inputs[0].clone(), s.inputs[1].clone()))
    // rust: else {
    // rust: return;
}
    // rust: let extra = extra.map(|e| e.item.to_string()).unwrap_or_default();
    // rust: let (duplicate, scaling, locking) = (
    // rust: extra == "minecraft:map",
    // rust: extra == "minecraft:paper",
    // rust: extra == "minecraft:glass_pane",
    // rust: );
    // rust: let id = map.as_ref().and_then(map_id);
    // rust: let state = id.and_then(|id| self.map(id).map(|m| (m.locked, m.scale)));
    // rust: let mut locked = false;
    // rust: let error = "gui/sprites/container/cartography_table/error";
    // rust: if let Some((is_locked, scale)) = state {
    // rust: if is_locked {
    // rust: locked = true;
    // rust: if scaling || locking {
    // rust: batch.sprite(&self.gui.atlas, error, ox + 35.0, oy + 31.0);
}
}
    // rust: if scaling && scale >= 4 {
    // rust: locked = true;
    // rust: batch.sprite(&self.gui.atlas, error, ox + 35.0, oy + 31.0);
}
}
    // rust: let sprite = |batch: &mut HudBatch, game: &Self, name: &str, x: f32, y: f32| {
    // rust: batch.sprite(
    // rust: &game.gui.atlas,
    // rust: &format!("gui/sprites/container/cartography_table/{name}"),
    // rust: ox + x,
    // rust: oy + y,
    // rust: );
}
    // rust: let preview = |batch: &mut HudBatch, game: &mut Self, x: f32, y: f32, scale: f32| {
    // rust: if let Some((id, rect)) = id
    // rust: .filter(|_| state.is_some())
    // rust: .and_then(|id| game.map_texture(id).map(|rect| (id, rect)))
    // rust: {
    // rust: let size = 128.0 * scale;
    // rust: batch.rect_uv(ox + x, oy + y, size, size, rect, u32::MAX);
    // rust: game.draw_map_decorations(batch, id, ox + x, oy + y, scale);
}
}
    // rust: if scaling && !locked {
    // rust: sprite(batch, self, "scaled_map", 67.0, 13.0);
    // rust: preview(batch, self, 85.0, 31.0, 0.226);
    // rust: } else if duplicate {
    // rust: sprite(batch, self, "duplicated_map", 83.0, 13.0);
    // rust: preview(batch, self, 86.0, 16.0, 0.34);
    // rust: sprite(batch, self, "duplicated_map", 67.0, 29.0);
    // rust: preview(batch, self, 70.0, 32.0, 0.34);
    // rust: } else if locking {
    // rust: sprite(batch, self, "map", 67.0, 13.0);
    // rust: preview(batch, self, 71.0, 17.0, 0.45);
    // rust: sprite(batch, self, "locked", 118.0, 60.0);
    // rust: } else {
    // rust: sprite(batch, self, "map", 67.0, 13.0);
    // rust: preview(batch, self, 71.0, 17.0, 0.45);
}
}
}
    // rust: impl Game<'_> {
    /// `GuiGraphicsExtractor.map`: map `id`'s decorations over its image at
    /// `(x, y)` drawn `scale` GUI pixels per map pixel. Only those with
    /// `renderOnFrame` (`MapDecorationType.showOnItemFrame`) are drawn: the
    /// screen's `map` skips the player arrows and the two markers.
pub fn draw_map_decorations(self: *Self, batch: *mut HudBatch, id: i32, x: f32, y: f32, scale: f32) void {
}
    // rust: let Some(map) = self.maps.data.get(&id) else {
    // rust: return;
}
    // rust: for d in map.decorations.iter().filter(|d| shown_on_frame(d.sprite)) {
    // rust: let Some(s) = self.gui.atlas.sprites.get(d.sprite).copied() else {
    // rust: continue;
}
    // rust: batch.quad(
    // rust: decoration_corners(d, x, y, scale),
    // rust: [[s.u0, s.v0], [s.u1, s.v0], [s.u1, s.v1], [s.u0, s.v1]],
    // rust: u32::MAX,
    // rust: );
    // rust: if let Some(name) = &d.name {
    // rust: let text = horizon_client::text::Text::literal(name);
    // rust: let f = self.gui.atlas.font.width_text(&text);
    // rust: if f > 0.0 {
    // rust: let f1 = (25.0 / f).clamp(0.0, 6.0 / 9.0);
    // rust: let mut temp = HudBatch::new([1, 1]);
    // rust: temp.name_tag(&self.gui.atlas, &text, 0.0, 0xFFFF_FFFF, 0x8000_0000);
    // rust: batch.patches.extend(temp.patches);
    // rust: let tm = glam::Mat4::from_translation(glam::Vec3::new(
    // rust: x + (f32::from(d.x) / 2.0 + 64.0) * scale,
    // rust: y + (f32::from(d.y) / 2.0 + 64.0 + 4.0) * scale,
    // rust: 0.0,
    // rust: )) * glam::Mat4::from_scale(glam::Vec3::splat(scale * f1));
    // rust: for quad in temp.vertices.as_chunks::<6>().0 {
    // rust: let corners = [quad[0], quad[1], quad[2], quad[5]].map(|v| {
    // rust: let p = tm.transform_point3(glam::Vec3::new(v.pos[0], v.pos[1], 0.0));
    // rust: [p.x, p.y]
    // rust: });
    // rust: let uvs = [quad[0].uv, quad[1].uv, quad[2].uv, quad[5].uv];
    // rust: batch.quad(corners, uvs, quad[0].color);
}
}
}
}
        // A native mod's own icons (`native_map_decorations`).
    // rust: for d in self.mod_map_decorations(id, true) {
    // rust: let Some(s) = self.gui.atlas.sprites.get(d.sprite.as_str()).copied() else {
    // rust: continue;
}
    // rust: batch.quad(
    // rust: pose_corners(
    // rust: super::maps::decoration_pose_at(d.x, d.y, d.rot, 0.0),
    // rust: x,
    // rust: y,
    // rust: scale,
    // rust: ),
    // rust: [[s.u0, s.v0], [s.u1, s.v0], [s.u1, s.v1], [s.u0, s.v1]],
    // rust: u32::MAX,
    // rust: );
}
}
}

/// Decoration `d`'s corners on screen, for a map drawn at `(x, y)` with
/// `scale` GUI pixels per map pixel: (-1, 1), (1, 1), (1, -1), (-1, -1)
/// under `MapRenderer.render`'s pose.
pub fn decoration_corners(d: *super::maps::Decoration, x: f32, y: f32, scale: f32) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: pose_corners(super::maps::decoration_pose(d, 0.0), x, y, scale)
}
/// The corners of a decoration drawn under `pose` (`decoration_pose`), like
/// [`decoration_corners`].
pub fn pose_corners(pose: glam::Mat4, x: f32, y: f32, scale: f32) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let m = glam::Mat4::from_translation(glam::Vec3::new(x, y, 0.0))
    // rust: * glam::Mat4::from_scale(glam::Vec3::new(scale, scale, 1.0))
    // rust: * pose;
    // rust: [(-1.0, 1.0), (1.0, 1.0), (1.0, -1.0), (-1.0, -1.0)].map(|(cx, cy)| {
    // rust: let p = m.transform_point3(glam::Vec3::new(cx, cy, 0.0));
    // rust: [p.x, p.y]
    // rust: })
}

    // rust: impl MapData {
    /// `MapItemSavedData.scaled`: a fresh map one scale up around the same centre.
    // rust: pub(super) fn scaled(&self) -> MapData {
    // rust: let mut m = MapData::fresh(
    // rust: f64::from(self.center[0]),
    // rust: f64::from(self.center[1]),
    // rust: (self.scale + 1).min(4),
    // rust: &self.dimension,
    // rust: );
    // rust: m.tracking = self.tracking;
    // rust: m.unlimited = self.unlimited;
    // rust: m
}
    /// `MapItemSavedData.locked`: the same pixels, banner markers and
    /// decorations, locked (the frame markers are not copied).
    // rust: pub(super) fn locked_copy(&self) -> MapData {
    // rust: let mut m = MapData::fresh(
    // rust: f64::from(self.center[0]),
    // rust: f64::from(self.center[1]),
    // rust: self.scale,
    // rust: &self.dimension,
    // rust: );
    // rust: m.center = self.center;
    // rust: m.colors = self.colors.clone();
    // rust: m.banners = self.banners.clone();
    // rust: m.decorations = self.decorations.clone();
    // rust: m.tracking = self.tracking;
    // rust: m.unlimited = self.unlimited;
    // rust: m.locked = true;
    // rust: m
}
}

    // rust: mod tests {
//     use super::*;
//     use crate::game::maps::{Decoration, Key};

pub fn close(a: [[f32; 2]; 4], b: [[f32; 2]; 4]) void {
}
    // rust: for (a, b) in a.iter().zip(&b) {
    // rust: assert!(
    // rust: (a[0] - b[0]).abs() < 1e-4 && (a[1] - b[1]).abs() < 1e-4,
    // rust: "{a:?} {b:?}"
    // rust: );
}
}

pub fn the_preview_skips_what_an_item_frame_skips() void {
}
        // GuiGraphicsExtractor.map: `if (decoration.renderOnFrame)`.
    // rust: assert!(!shown_on_frame("map/decorations/player"));
    // rust: assert!(!shown_on_frame("map/decorations/red_marker"));
    // rust: assert!(shown_on_frame("map/decorations/frame"));
    // rust: assert!(shown_on_frame("map/decorations/red_x"));
}

pub fn map_markers_sit_on_the_preview_like_on_a_held_map() void {
}
    // rust: let player = |x, y, rot| Decoration {
    // rust: sprite: "map/decorations/player",
    // rust: x,
    // rust: y,
    // rust: rot,
    // rust: name: None,
    // rust: key: Key::Item,
}
        // The centre, facing north: 8 map pixels wide, nudged by (-0.5, 0.5).
    // rust: close(
    // rust: decoration_corners(&player(0, 0, 0), 0.0, 0.0, 1.0),
    // rust: [[59.5, 68.5], [67.5, 68.5], [67.5, 60.5], [59.5, 60.5]],
    // rust: );
        // A quarter turn (rotation 4 of 16) turns the quad about its marker.
    // rust: close(
    // rust: decoration_corners(&player(0, 0, 4), 0.0, 0.0, 1.0),
    // rust: [[59.5, 59.5], [59.5, 67.5], [67.5, 67.5], [67.5, 59.5]],
    // rust: );
        // The preview's offset and scale apply after: the top-left corner
        // marker on the 0.45 preview at (71, 17).
    // rust: close(
    // rust: decoration_corners(&player(-128, -128, 0), 71.0, 17.0, 0.45),
    // rust: [
    // rust: [71.0 - 4.5 * 0.45, 17.0 + 4.5 * 0.45],
    // rust: [71.0 + 3.5 * 0.45, 17.0 + 4.5 * 0.45],
    // rust: [71.0 + 3.5 * 0.45, 17.0 - 3.5 * 0.45],
    // rust: [71.0 - 4.5 * 0.45, 17.0 - 3.5 * 0.45],
    // rust: ],
    // rust: );
}
}
