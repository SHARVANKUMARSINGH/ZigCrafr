//! Transpiled from Horizon Rust crate
//! Module: horizon-client_frames
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Item frames and glow item frames: `ItemFrameItem` placement on any face,
//! `ItemFrame.survives`, `interact` (put an item in, then rotate it),
//! `hurtServer` (take the item out, then break the frame) and
//! `ItemFrameRenderer` (the frame model and the item at a 45 degree step).
// use super::{Game, Hit, InteractTarget};
// use horizon_assets::{bake::bake_model, model::CuboidModel, resolve::ModelLibrary};
// use horizon_client::{entities::ItemFrame, items::ItemStack, mesher::Vertex};
// use horizon_core::{
    // rust: geometry::{Aabb, Vec3},
    // rust: position::BlockPos,
    // rust: random::RandomSource,
}
/// A baked frame model: (corners in block units, unit UVs, sprite) per quad.
    // rust: pub(super) type FrameModel = Vec<([[f32; 3]; 4], [[f32; 2]; 4], String)>;

/// Bake `block/<name>` (item_frame / glow_item_frame) from the resources.
    // rust: pub(super) fn bake_frame(root: &std::path::Path, name: &str) -> FrameModel {
    // rust: let mut models = std::collections::BTreeMap::new();
    // rust: let mut pending = vec![format!("minecraft:block/{name}")];
    // rust: while let Some(model) = pending.pop() {
    // rust: let Some((ns, path)) = model.split_once(':') else {
    // rust: continue;
}
    // rust: let Ok(text) =
    // rust: std::fs::read_to_string(root.join(format!("assets/{ns}/models/{path}.json")))
    // rust: else {
    // rust: continue;
}
    // rust: let Ok(m) = CuboidModel::from_json(&text) else {
    // rust: continue;
}
    // rust: if let Some(parent) = &m.parent {
    // rust: pending.push(parent.clone());
}
    // rust: models.insert(model, m);
}
    // rust: let Ok(library) = ModelLibrary::new(models) else {
    // rust: return Vec::new();
}
    // rust: let Ok(resolved) = library.resolve(&format!("minecraft:block/{name}")) else {
    // rust: return Vec::new();
}
    // rust: let Ok(quads) = bake_model(&resolved) else {
    // rust: return Vec::new();
}
    // rust: let unit = if quads
    // rust: .iter()
    // rust: .flat_map(|q| q.positions)
    // rust: .any(|p| p.iter().any(|v| *v > 1.5))
    // rust: {
    // rust: 16.0
    // rust: } else {
    // rust: 1.0
}
    // rust: quads
    // rust: .into_iter()
    // rust: .map(|q| {
    // rust: (
    // rust: q.positions.map(|p| p.map(|v| v / unit)),
    // rust: q.uv,
    // rust: q.material
    // rust: .sprite
    // rust: .trim_start_matches("minecraft:")
    // rust: .to_owned(),
    // rust: )
    // rust: })
    // rust: .collect()
}
pub fn facing_of(face: [i32; 3]) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match face {
    // rust: [0, -1, 0] => 0,
    // rust: [0, 1, 0] => 1,
    // rust: [0, 0, -1] => 2,
    // rust: [0, 0, 1] => 3,
    // rust: [-1, 0, 0] => 4,
    // rust: _ => 5,
}
}
pub fn sound(f: *ItemFrame, what: []const u8) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let prefix = if f.glow {
    // rust: "glow_item_frame"
    // rust: } else {
    // rust: "item_frame"
}
    // rust: format!("minecraft:entity.{prefix}.{what}")
}
pub fn center(f: *ItemFrame) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (lo, hi) = f.bounds();
    // rust: std::array::from_fn(|i| (lo[i] + hi[i]) / 2.0)
}
    // rust: impl Game<'_> {
    /// `ItemFrame.survives` (not fixed): no collision, a solid block behind
    /// (or a diode for wall frames), no overlapping hanging entity.
pub fn frame_survives(self: *Self, f: *ItemFrame) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if f.fixed {
    // rust: return true;
}
    // rust: let (lo, hi) = f.bounds();
    // rust: let bounds = Aabb::new(
    // rust: Vec3::new(lo[0], lo[1], lo[2]),
    // rust: Vec3::new(hi[0], hi[1], hi[2]),
    // rust: );
    // rust: let mut scene = horizon_client::collisions::SceneCollisions {
    // rust: world: &self.world,
    // rust: binding: self.collision,
    // rust: subject: None,
}
    // rust: if !scene.unobstructed(bounds).unwrap_or(false) {
    // rust: return false;
}
    // rust: let s = f.step();
    // rust: let behind = self.res.facts().get(self.world.block(
    // rust: f.pos[0] - s[0],
    // rust: f.pos[1] - s[1],
    // rust: f.pos[2] - s[2],
    // rust: ));
    // rust: let supported = behind.legacy_solid || (s[1] == 0 && behind.has_class("DiodeBlock"));
        // canCoexist(true): only hanging entities facing the same way block it.
    // rust: let overlaps = |o: ([f64; 3], [f64; 3])| (0..3).all(|i| o.0[i] < hi[i] && lo[i] < o.1[i]);
    // rust: supported
    // rust: && !self
    // rust: .item_frames
    // rust: .iter()
    // rust: .any(|o| o.id != f.id && o.facing == f.facing && overlaps(o.bounds()))
}
    /// Asks the mods whether the acting guest may place a hanging entity
    /// of type `kind` at `pos` (`native_hanging_place`): true when one
    /// cancelled it. A game's own player is not asked.
    // rust: pub(super) fn hanging_place_cancelled(&mut self, kind: &str, pos: [i32; 3]) -> bool {
    // rust: let (Some(uuid), Some(name)) = (self.lan_acting_uuid, self.lan_acting_name.clone()) else {
    // rust: return false;
}
    // rust: let mut cancel = false;
    // rust: self.native_hanging_place(uuid, &name, kind, pos, &mut cancel);
    // rust: cancel
}
    /// Asks the mods whether a hanging entity of type `kind` at `pos` may
    /// break (`native_hanging_break`): true when one cancelled it. A break by
    /// a player is asked only for the acting guest, with them as the player;
    /// a break by anything else is asked with none.
    // rust: pub(super) fn hanging_break_cancelled(
    // rust: &mut self,
    // rust: kind: &str,
    // rust: pos: [i32; 3],
    // rust: by_player: bool,
    // rust: ) -> bool {
    // rust: let player = if by_player {
    // rust: let Some(uuid) = self.lan_acting_uuid else {
    // rust: return false;
}
    // rust: Some(uuid)
    // rust: } else {
    // rust: None
}
    // rust: let mut cancel = false;
    // rust: self.native_hanging_break(player, kind, pos, &mut cancel);
    // rust: cancel
}
    /// `ItemFrameItem.useOn`.
    // rust: pub(super) fn place_item_frame(&mut self, hit: &Hit, stack: &ItemStack) -> bool {
    // rust: let glow = match &*stack.item {
    // rust: "minecraft:item_frame" => false,
    // rust: "minecraft:glow_item_frame" => true,
    // rust: _ => return false,
}
    // rust: let entity_data = stack.extra.as_ref().and_then(|extra| {
    // rust: extra.other.iter().find_map(|(k, v)| {
    // rust: (k == "minecraft:entity_data" || k == "entity_data").then_some(v)
    // rust: })
    // rust: });
    // rust: let invisible = entity_data
    // rust: .and_then(|v| horizon_client::save::number(v.get("Invisible")))
    // rust: .unwrap_or(0)
    // rust: != 0;
        // `applyComponentsFromItemStack` sets `CUSTOM_NAME`, then `entity_data`
        // loads (`updateCustomEntityTag`): a missing `CustomName` clears it.
    // rust: let custom_name = match entity_data {
    // rust: Some(data) => data.get("CustomName").cloned(),
    // rust: None => stack.data().and_then(|d| d.custom_name.clone()),
}
    // rust: let pos: [i32; 3] = std::array::from_fn(|i| hit.pos[i] + hit.face[i]);
        // `ItemFrameItem.mayPlace`: `Level.isInsideBuildHeight(blockPos)`, so a frame is not
        // placed on the top face of the highest block or under the lowest one.
    // rust: if !(horizon_client::chunk::MIN_Y
    // rust: ..horizon_client::chunk::MIN_Y + horizon_client::chunk::HEIGHT)
    // rust: .contains(&pos[1])
    // rust: {
            // ItemFrameItem.mayPlace's FAIL.
    // rust: self.use_failed = true;
    // rust: return true;
}
    // rust: let frame = ItemFrame {
    // rust: id: self.next_entity + 1,
    // rust: pos,
    // rust: facing: facing_of(hit.face),
    // rust: glow,
    // rust: item: None,
    // rust: rotation: 0,
    // rust: drop_chance: 1.0,
    // rust: fixed: false,
    // rust: invisible,
    // rust: check_interval: 0,
    // rust: custom_name,
}
        // HangingEntity.survives false: CONSUME, which ItemStack.useOn still counts as a use.
    // rust: if !self.frame_survives(&frame) {
    // rust: self.award_stat("used", &stack.item, 1);
    // rust: return true;
}
    // rust: let kind = if glow {
    // rust: "minecraft:glow_item_frame"
    // rust: } else {
    // rust: "minecraft:item_frame"
}
    // rust: if self.hanging_place_cancelled(kind, pos) {
    // rust: return true;
}
    // rust: self.next_entity += 1;
    // rust: self.audio
    // rust: .play(&sound(&frame, "place"), Some(center(&frame)), 1.0, 1.0);
        // HangingEntityItem.useOn: ENTITY_PLACE at the frame, by the player, before it is
        // added; ItemStack.useOn then counts the use.
    // rust: let ctx = self.player_context(None);
    // rust: self.post_game_event("minecraft:entity_place", center(&frame), ctx);
    // rust: self.world.modified.insert((pos[0] >> 4, pos[2] >> 4));
    // rust: self.item_frames.push(frame);
    // rust: if !self.creative {
    // rust: self.consume_held();
}
    // rust: self.award_stat("used", &stack.item, 1);
    // rust: true
}
    /// The frame under the crosshair within reach and its distance.
    // rust: pub(super) fn frame_hit(&self) -> Option<(usize, f64)> {
    // rust: let (eye, dir) = self.aim()?;
    // rust: let reach: f64 = self.entity_reach;
    // rust: let mut best: Option<(usize, f64)> = None;
    // rust: for (i, f) in self.item_frames.iter().enumerate() {
    // rust: let (lo, hi) = f.bounds();
    // rust: let (mut t0, mut t1) = (0.0f64, reach);
    // rust: let mut hit = true;
    // rust: for a in 0..3 {
    // rust: if dir[a].abs() < 1e-9 {
    // rust: hit &= eye[a] >= lo[a] && eye[a] <= hi[a];
    // rust: continue;
}
    // rust: let (mut ta, mut tb) = ((lo[a] - eye[a]) / dir[a], (hi[a] - eye[a]) / dir[a]);
    // rust: if ta > tb {
    // rust: std::mem::swap(&mut ta, &mut tb);
}
    // rust: t0 = t0.max(ta);
    // rust: t1 = t1.min(tb);
}
    // rust: if hit && t0 <= t1 && best.is_none_or(|b| t0 < b.1) {
    // rust: best = Some((i, t0));
}
}
    // rust: best
}
    /// Nearer than the targeted block?
    // rust: pub(super) fn before_block(&self, distance: f64) -> bool {
    // rust: self.pick_unfiltered().is_none_or(|h| {
    // rust: let eye = self.aim().map(|(eye, _)| eye).unwrap_or_default();
    // rust: (0..3)
    // rust: .map(|a| (h.point[a] - eye[a]).powi(2))
    // rust: .sum::<f64>()
    // rust: .sqrt()
    // rust: > distance
    // rust: })
}
    /// `ItemFrame.interact` for the frame under the crosshair, or the one a
    /// guest's interact packet named.
    // rust: pub(super) fn interact_frame(&mut self, target: Option<InteractTarget>) -> bool {
    // rust: let Some((i, d)) = (match target {
    // rust: Some(t) => Self::named_entity(&self.item_frames, t.id, |f| f.id).map(|i| (i, 0.0)),
    // rust: None => self.frame_hit(),
    // rust: }) else {
    // rust: return false;
}
        // Only a client's own pick is stopped by a block: the range check passed.
    // rust: if (target.is_none() && !self.before_block(d)) || self.item_frames[i].fixed {
    // rust: return false;
}
    // rust: let at = center(&self.item_frames[i]);
    // rust: let entity_id = self.item_frames[i].id;
    // rust: let action;
    // rust: if self.item_frames[i].item.is_none() {
    // rust: let Some(held) = self.held().cloned() else {
    // rust: return false;
}
    // rust: self.item_frames[i].item = Some(ItemStack { count: 1, ..held });
    // rust: action = "put";
    // rust: self.audio
    // rust: .play(&sound(&self.item_frames[i], "add_item"), Some(at), 1.0, 1.0);
    // rust: if !self.creative {
    // rust: self.consume_held();
}
    // rust: } else {
    // rust: let f = &mut self.item_frames[i];
    // rust: f.rotation = (f.rotation + 1) % 8;
    // rust: action = "rotate";
    // rust: let s = sound(f, "rotate_item");
    // rust: self.audio.play(&s, Some(at), 1.0, 1.0);
}
    // rust: let p = self.item_frames[i].pos;
    // rust: self.world.modified.insert((p[0] >> 4, p[2] >> 4));
    // rust: self.frame_output_changed(p);
    // rust: if let (Some(player), Some(name)) = (self.lan_acting_uuid, self.lan_acting_name.clone()) {
    // rust: let frame = self.item_frames.iter().find(|f| f.id == entity_id);
    // rust: let item = frame
    // rust: .and_then(|f| f.item.as_ref())
    // rust: .map_or_else(String::new, |s| s.item.to_string());
    // rust: let rotation = frame.map_or(0, |f| f.rotation);
    // rust: self.native_player_item_frame_change(player, &name, entity_id, action, &item, rotation);
}
    // rust: self.swing_arm();
    // rust: true
}
    /// `ItemFrame.hurtServer` from the player: the item comes out first.
    // rust: pub(super) fn attack_frame(&mut self) -> bool {
    // rust: let Some((i, d)) = self.frame_hit() else {
    // rust: return false;
}
    // rust: if !self.before_block(d) || self.mob_hit().is_some_and(|m| m.1 < d) {
    // rust: return false;
}
    // rust: if self.item_frames[i].fixed {
            // A fixed frame refuses the hit of a player who isn't in creative
            // (canHurtWhenFixed), so skipAttackInteraction is false and
            // Player.attack goes on to onAttack.
    // rust: if !self.creative {
    // rust: self.attack_ticks = 0;
}
    // rust: return true;
}
    // rust: let with_frame = self.item_frames[i].item.is_none();
    // rust: let entity_id = self.item_frames[i].id;
    // rust: if with_frame {
    // rust: let (kind, pos) = (self.item_frames[i].kind(), self.item_frames[i].pos);
    // rust: if self.hanging_break_cancelled(kind, pos, true) {
    // rust: return true;
}
}
    // rust: let old_item = self.item_frames[i]
    // rust: .item
    // rust: .as_ref()
    // rust: .map_or("", |s| &*s.item)
    // rust: .to_owned();
    // rust: let rotation = self.item_frames[i].rotation;
    // rust: let at = center(&self.item_frames[i]);
    // rust: let f = if with_frame {
    // rust: self.item_frames.remove(i)
    // rust: } else {
    // rust: self.item_frames[i].clone()
}
    // rust: self.audio.play(
    // rust: &sound(&f, if with_frame { "break" } else { "remove_item" }),
    // rust: Some(at),
    // rust: 1.0,
    // rust: 1.0,
    // rust: );
    // rust: if !with_frame {
    // rust: self.item_frames[i].item = None;
}
    // rust: self.drop_frame_items(&f, with_frame, true);
    // rust: self.world.modified.insert((f.pos[0] >> 4, f.pos[2] >> 4));
    // rust: if f.item.is_some() {
    // rust: self.frame_output_changed(f.pos);
}
    // rust: if let (Some(player), Some(name)) = (self.lan_acting_uuid, self.lan_acting_name.clone()) {
    // rust: self.native_player_item_frame_change(
    // rust: player,
    // rust: &name,
    // rust: entity_id,
    // rust: if with_frame { "break" } else { "remove_item" },
    // rust: if with_frame { "" } else { &old_item },
    // rust: rotation,
    // rust: );
}
    // rust: true
}
    /// `ItemFrame.setItem` / `setRotation`: `updateNeighbourForOutputSignal`, so
    /// the comparators reading the frame take its new signal.
pub fn frame_output_changed(self: *Self, pos: [i32; 3]) void {
}
    // rust: let at = BlockPos::new(pos[0], pos[1], pos[2]);
    // rust: self.with_level(|b, level, ticks| b.update_neighbour_for_output_signal(level, ticks, at));
}
    /// `ItemFrame.dropItem`: the frame (when breaking) and the held item.
pub fn drop_frame_items(self: *Self, f: *ItemFrame, with_frame: bool, by_player: bool) void {
}
        // The framed map forgets the frame, except when the drops are off and
        // something caused the break (`removeFramedMap` runs only for a null
        // `causedBy` then).
    // rust: if self.ui.rules.bool("entity_drops") || !by_player {
    // rust: self.remove_framed_map(f);
}
    // rust: if !self.ui.rules.bool("entity_drops") || (by_player && self.creative) {
    // rust: return;
}
    // rust: let s = f.step().map(f64::from);
    // rust: let c = center(f);
    // rust: let at = [c[0] + s[0] * 0.15, c[1], c[2] + s[2] * 0.15];
    // rust: let mut drops = Vec::new();
    // rust: if with_frame {
            // `ItemFrame.getFrameItemStackWithData` (glow frames share it).
    // rust: drops.push(f.item_stack_with_data());
}
    // rust: if let Some(item) = f.item.clone()
    // rust: && self.world.random.next_float() < f.drop_chance
    // rust: {
    // rust: drops.push(item);
}
    // rust: if by_player && !drops.is_empty() {
    // rust: let tool = self.held().cloned();
    // rust: self.native_use_drops(
    // rust: "",
    // rust: c,
    // rust: None,
    // rust: Some((f.id, f.kind())),
    // rust: tool.as_ref(),
    // rust: &mut drops,
    // rust: );
}
    // rust: for stack in drops {
    // rust: self.spawn_item(stack, at, [0.0; 3], 10);
}
}
    /// `ServerExplosion.hurtEntities` for item frames: a frame within the blast
    /// is killed and dropped with its item (`BlockAttachedEntity.hurtServer`).
    /// A fixed frame is not hurt by an explosion, and `blast_spares_decorations`
    /// keeps every frame without `mobGriefing`.
    // rust: pub(super) fn explosion_breaks_frames(
    // rust: &mut self,
    // rust: blast: [f64; 3],
    // rust: diameter: f64,
    // rust: interaction: super::explosion::BlockInteraction,
    // rust: ) {
    // rust: if self.blast_spares_decorations(interaction) {
    // rust: return;
}
    // rust: let mut i = 0;
    // rust: while i < self.item_frames.len() {
    // rust: let c = center(&self.item_frames[i]);
    // rust: let dist =
    // rust: ((c[0] - blast[0]).powi(2) + (c[1] - blast[1]).powi(2) + (c[2] - blast[2]).powi(2))
    // rust: .sqrt()
    // rust: / diameter;
    // rust: let (kind, pos) = (self.item_frames[i].kind(), self.item_frames[i].pos);
    // rust: if dist > 1.0
    // rust: || self.item_frames[i].fixed
    // rust: || self.hanging_break_cancelled(kind, pos, false)
    // rust: {
    // rust: i += 1;
    // rust: continue;
}
    // rust: let f = self.item_frames.remove(i);
    // rust: self.audio
    // rust: .play(&sound(&f, "break"), Some(center(&f)), 1.0, 1.0);
    // rust: self.drop_frame_items(&f, true, false);
    // rust: self.world.modified.insert((f.pos[0] >> 4, f.pos[2] >> 4));
    // rust: if f.item.is_some() {
    // rust: self.frame_output_changed(f.pos);
}
}
}
    /// BlockAttachedEntity.tick for frames.
    // rust: pub(super) fn tick_item_frames(&mut self) {
        // ServerLevel.tick: only entities in entity-ticking chunks tick.
    // rust: let ticking = self.entity_ticking_area();
    // rust: let mut i = 0;
    // rust: while i < self.item_frames.len() {
    // rust: let at = center(&self.item_frames[i]);
    // rust: if !ticking(at[0].floor() as i32, at[2].floor() as i32) {
    // rust: i += 1;
    // rust: continue;
}
    // rust: self.item_frames[i].check_interval += 1;
    // rust: if self.item_frames[i].check_interval >= 100 {
    // rust: self.item_frames[i].check_interval = 0;
    // rust: let f = self.item_frames[i].clone();
    // rust: if !self.frame_survives(&f) && !self.hanging_break_cancelled(f.kind(), f.pos, false)
    // rust: {
    // rust: self.item_frames.remove(i);
    // rust: self.audio
    // rust: .play(&sound(&f, "break"), Some(center(&f)), 1.0, 1.0);
    // rust: self.drop_frame_items(&f, true, false);
    // rust: if f.item.is_some() {
    // rust: self.frame_output_changed(f.pos);
}
    // rust: continue;
}
}
    // rust: i += 1;
}
}
    /// ItemFrameRenderer: the frame model, then the item half size on its face.
    // rust: pub(super) fn frame_geometry(&mut self, camera: glam::DVec3, out: &mut Vec<Vertex>) {
    // rust: let sprites = &self.gui.atlas.sprites;
        // Each with its frame's type: a pack tells a glow frame and what it holds apart by its
        // `entityId` (`glow_item_frame` in entity.properties), the item drawn within its frame.
    // rust: let mut maps: Vec<(i32, glam::Mat4, u32, bool, &'static str)> = Vec::new();
    // rust: let mut items: Vec<(ItemStack, u32, glam::Mat4, u8, bool, &'static str)> = Vec::new();
        // ItemFrame.shouldRenderAtSqrDistance: 1024 blocks at a view scale
        // of 1.
    // rust: let range = 16.0 * 64.0 * self.view_scale();
    // rust: for f in &self.item_frames {
    // rust: let entity_start = out.len();
    // rust: self.mark_entity(entity_start, f.kind());
    // rust: let map = f.item.as_ref().and_then(super::maps::map_id);
            // EntityRenderer.shouldRender: its box (a block wide with a map),
            // measured from the box's centre.
    // rust: let (lo, hi) = f.bounds();
    // rust: let (mut lo, mut hi) = (glam::DVec3::from(lo), glam::DVec3::from(hi));
    // rust: if map.is_some() {
    // rust: let s = f.step();
    // rust: for i in 0..3 {
    // rust: if s[i] == 0 {
    // rust: let c = (lo[i] + hi[i]) / 2.0;
    // rust: (lo[i], hi[i]) = (c - 0.5, c + 0.5);
}
}
}
    // rust: if !self.entity_in_view(camera, (lo + hi) / 2.0, range, lo, hi) {
    // rust: continue;
}
    // rust: let culling = self.entity_cull_decision(f, 1.0);
    // rust: if culling.hides_entity() {
    // rust: continue;
}
    // rust: let entity_start = out.len();
    // rust: let s = f.step();
            // Pose: to the block centre, then X/Y rotation by facing.
    // rust: let (x_rot, y_rot) = if s[1] == 0 {
    // rust: let to_y = match f.facing {
    // rust: 3 => 0.0,
    // rust: 4 => 90.0,
    // rust: 2 => 180.0,
    // rust: _ => 270.0,
}
    // rust: (0.0f64, 180.0f64 - to_y)
    // rust: } else {
    // rust: (-90.0 * f64::from(s[1]), 180.0)
}
    // rust: let pose = glam::DMat4::from_translation(
    // rust: glam::DVec3::new(
    // rust: f64::from(f.pos[0]) + 0.5,
    // rust: f64::from(f.pos[1]) + 0.5,
    // rust: f64::from(f.pos[2]) + 0.5,
    // rust: ) - camera,
    // rust: ) * glam::DMat4::from_rotation_x(x_rot.to_radians())
    // rust: * glam::DMat4::from_rotation_y(y_rot.to_radians());
    // rust: let light = self.world.light(f.pos[0], f.pos[1], f.pos[2]);
    // rust: let packed = (u32::from(light >> 4) * 16) | ((u32::from(light & 15) * 16) << 8);
            // ItemFrameRenderer.getBlockLightLevel: a glow frame's model is at least 5 bright.
    // rust: let frame_light = if f.glow {
    // rust: (light & 0xF0) | (light & 15).max(5)
    // rust: } else {
    // rust: light
}
    // rust: let frame_packed =
    // rust: (u32::from(frame_light >> 4) * 16) | ((u32::from(frame_light & 15) * 16) << 8);
    // rust: let frame_start = out.len();
    // rust: let mut quad =
    // rust: |m: &glam::DMat4, corners: [[f64; 3]; 4], uv: [[f32; 2]; 4], light: u32| {
                    // The frame model is drawn with the entity shader, lit by its face normal.
    // rust: let at = corners.map(|c| m.transform_point3(glam::DVec3::from_array(c)));
    // rust: let n = (at[1] - at[0]).cross(at[2] - at[0]).normalize_or_zero();
    // rust: let normal = [0, 1, 2].map(|k| (n[k].clamp(-1.0, 1.0) * 127.0) as i8);
    // rust: for (p, uv) in at.into_iter().zip(uv) {
    // rust: out.push(Vertex {
    // rust: normal: [normal[0], normal[1], normal[2], -127],
    // rust: pos: p.as_vec3().to_array(),
    // rust: uv,
    // rust: layer: 0,
    // rust: color: 0xFFFF_FFFF,
    // rust: light,

    // rust: glint_uv: [0.0, 0.0],
    // rust: });
}
}
    // rust: let map_uv = |r: &horizon_client::hud::Rect, uv: [[f32; 2]; 4]| {
    // rust: uv.map(|[u, v]| [r.u0 + u * (r.u1 - r.u0), r.v0 + v * (r.v1 - r.v0)])
}
    // rust: if !f.invisible {
    // rust: let model = match (f.glow, map.is_some()) {
    // rust: (true, true) => &self.glow_map_frame_model,
    // rust: (false, true) => &self.map_frame_model,
    // rust: (true, false) => &self.glow_frame_model,
    // rust: (false, false) => &self.frame_model,
}
    // rust: for (corners, uv, sprite) in model {
    // rust: let Some(r) = sprites.get(sprite) else {
    // rust: continue;
}
    // rust: quad(
    // rust: &pose,
    // rust: corners.map(|c| {
    // rust: [
    // rust: f64::from(c[0]) - 0.5,
    // rust: f64::from(c[1]) - 0.5,
    // rust: f64::from(c[2]) - 0.5,
    // rust: ]
    // rust: }),
    // rust: map_uv(r, *uv),
    // rust: frame_packed,
    // rust: );
}
}
            // HDR output: a glow frame shines softly (entity.wgsl fs_hdr_mark); the item in it
            // is only lit, as vanilla draws it.
    // rust: if f.glow {
    // rust: for v in &mut out[frame_start..] {
    // rust: v.layer |= u32::from(horizon_client::mesher::INCANDESCENT) << 16;
}
}
    // rust: self.finish_entity_occlusion(culling, f, out, entity_start);
    // rust: let cull_contents = culling.checks_vertices();
    // rust: if let Some(stack) = &f.item {
    // rust: let mut canceled = false;
    // rust: self.native_render_item_in_frame(f.id, f.pos, stack, &mut canceled);
    // rust: if canceled {
    // rust: continue;
}
}
    // rust: if let Some(id) = map {
                // ItemFrameRenderer: the map fills the face, in 90-degree steps.
    // rust: let depth = if f.invisible { 0.5 } else { 0.4375 };
                // A glow frame's map is 15728850 = 0xF000D2 (sky coordinate 240,
                // block coordinate 210), not full bright.
    // rust: let item_light = if f.glow { 240 | 210 << 8 } else { packed };
    // rust: let m = pose
    // rust: * glam::DMat4::from_translation(glam::DVec3::new(0.0, 0.0, depth))
    // rust: * glam::DMat4::from_rotation_z(
    // rust: (f64::from(f.rotation % 4 * 2) * 45.0).to_radians(),
    // rust: )
    // rust: * glam::DMat4::from_rotation_z(std::f64::consts::PI)
    // rust: * glam::DMat4::from_scale(glam::DVec3::splat(0.0078125))
    // rust: * glam::DMat4::from_translation(glam::DVec3::new(-64.0, -64.0, -1.0));
    // rust: maps.push((id, m.as_mat4(), item_light, cull_contents, f.kind()));
    // rust: continue;
}
    // rust: let Some(stack) = f.item.clone() else {
    // rust: continue;
}
            // `GlowItemFrame` items render full bright (15728880).
    // rust: let item_light = if f.glow { 0xFF } else { light };
    // rust: let depth = if f.invisible { 0.5 } else { 0.4375 };
    // rust: let m = pose
    // rust: * glam::DMat4::from_translation(glam::DVec3::new(0.0, 0.0, depth))
    // rust: * glam::DMat4::from_rotation_z((f64::from(f.rotation) * 45.0).to_radians())
    // rust: * glam::DMat4::from_scale(glam::DVec3::splat(0.5));
    // rust: items.push((
    // rust: stack,
    // rust: f.id,
    // rust: m.as_mat4(),
    // rust: item_light,
    // rust: cull_contents,
    // rust: f.kind(),
    // rust: ));
}
        // `extractRenderState`: FIXED, seeded by the frame entity.
    // rust: let skinning = self.skinning();
    // rust: let lights =
    // rust: horizon_client::block_entity_render::diffuse_lights(self.dim == super::Dim::Nether);
    // rust: for (stack, id, m, light, cull, kind) in items {
    // rust: let entity_start = out.len();
    // rust: self.mark_entity(entity_start, kind);
    // rust: let owner = super::item_draw::owner_at([0.0; 3], 0.0, "minecraft:item_frame");
    // rust: let state = self.resolve_item(
    // rust: &stack,
    // rust: horizon_assets::item_model::DisplayContext::Fixed,
    // rust: Some(&owner),
    // rust: id as i32,
    // rust: );
    // rust: let light = horizon_client::block_entity_render::vertex_light(light);
            // Posed on the GPU when every layer can be.
    // rust: let skinned = skinning
    // rust: .then(|| self.submit_item_skinned(&state, &[m], light, lights))
    // rust: .flatten();
    // rust: if skinned.is_none() {
    // rust: self.submit_item_world(&state, m, light, out);
}
    // rust: if cull {
    // rust: self.cull_skinned(out, entity_start, skinned);
}
}
    // rust: for (id, m, light, cull, kind) in maps {
    // rust: let entity_start = out.len();
    // rust: self.mark_entity(entity_start, kind);
    // rust: self.map_vertices(id, true, m, light, out);
    // rust: if cull {
    // rust: self.cull_entity_vertices(out, entity_start);
}
}
}
}
