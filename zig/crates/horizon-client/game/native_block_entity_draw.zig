//! Transpiled from Horizon Rust crate
//! Module: horizon-client_native_block_entity_draw
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Mod block entities drawn on the client: `native_block_entity_submit`
//! (vanilla's `BlockEntityRenderer.submit`) gets a [`BlockEntityDraw`], whose
//! pose stack (`PoseStack`) places what the helpers here add to the entity
//! batch, as vanilla's block entity renderers draw.

// use super::{Dim, Game};
// use glam::{DVec3, Mat4, Quat, Vec3};
// use horizon_assets::{
    // rust: bake::{bake_flat_face, default_uv},
    // rust: item_model::DisplayContext,
    // rust: model::{Direction, Material},
}
// use horizon_client::{
    // rust: block_entity_render::{TextCall, diffuse, diffuse_lights, text_vertices, vertex_light},
    // rust: containers::{BlockEntity, ModRevision},
    // rust: fast_hash::FxHashMap,
    // rust: gfx::Cull,
    // rust: hud::Rect,
    // rust: items::ItemStack,
    // rust: mesher::Vertex,
    // rust: mobs::model_layers::{self, ModelPart},
    // rust: text::Text,
}
// use horizon_world::registry::BlockStateId;

/// `BlockEntityRenderer.getViewDistance`'s default, in blocks.
pub const VIEW_DISTANCE: f64 = 64.0;
/// A mod block entity's bounds until its mod says otherwise: the block with
/// the block of margin Horizon culls vanilla's block entities with.
pub const DEFAULT_BOUNDS: [f32; 6] = [-1.0, -1.0, -1.0, 2.0, 2.0, 2.0];

/// Whether `bounds` (min then max, in blocks from `origin`, the block's corner
/// relative to the camera) meet the frustum; an infinite bound always does
/// (NeoForge's `INFINITE_EXTENT_AABB`), as does a frame without a frustum.
pub fn in_frustum(frustum: ?*impl Cull, origin: Vec3, bounds: [f32; 6]) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if bounds.iter().any(|b| !b.is_finite()) {
    // rust: return true;
}
    // rust: let min = origin + Vec3::new(bounds[0], bounds[1], bounds[2]);
    // rust: let max = origin + Vec3::new(bounds[3], bounds[4], bounds[5]);
    // rust: frustum.is_none_or(|f| f.intersects(min, max))
}

/// One mod block entity's frame, as `submit` gets it: the render state's
/// partial tick, game time and light, and the pose stack the helpers draw
/// under (`native_draw_quad`, `native_draw_cube`, `native_draw_block`).
// Native mods read and drive it; nothing in Horizon does.
pub const BlockEntityDraw = struct {
    /// The frame's partial tick, 0 to 1 (`BlockEntityRenderState`).
    partial: f32,
    /// The level's game time, for animations.
    game_time: i64,
    /// The light the helpers draw with: the block's own
    /// (`LevelRenderer.getLightCoords`), 16 times sky light in bits 0..8 and
    /// 16 times block light in bits 8..16; set it to light a part otherwise.
    light: u32,
    /// The block drawn, for `native_draw_item`'s owner.
    block: [i32,
    poses: std.ArrayList(Mat4),
    lights: (Vec3,
    vertices: std.ArrayList(Vertex),
    kept: bool,
    /// Where each turning part starts in `vertices` (`spin`), and where the
    /// parts standing still start again (`still`, none).
    spins: Vec<(usize,
};

/// A part of a block entity's frame that turns by itself (`BlockEntityDraw::spin`).
    // rust: pub(super) struct Spin {
    // rust: axis: Vec3,
    // rust: pivot: Vec3,
    // rust: degrees_per_tick: f32,
    // rust: phase: f32,
}

    // rust: impl Spin {
    /// The turn at `game_time` plus `partial`, about the pivot, in the
    /// block's coordinates. Counted in f64: a world's game time has more
    /// ticks than an f32 holds exactly.
pub fn turn(self: *Self, game_time: i64, partial: f32) M {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let t = game_time as f64 + f64::from(partial);
    // rust: let degrees =
    // rust: (t * f64::from(self.degrees_per_tick) + f64::from(self.phase)).rem_euclid(360.0);
    // rust: Mat4::from_translation(self.pivot)
    // rust: * Mat4::from_quat(Quat::from_axis_angle(
    // rust: self.axis,
    // rust: (degrees as f32).to_radians(),
    // rust: ))
    // rust: * Mat4::from_translation(-self.pivot)
}
}

/// `vertices`, drawn relative to the block, moved to the camera by `origin`
/// and each part of `spins` (starts relative to `vertices`) turned as it is
/// at `game_time` plus `partial`, onto `out`.
    // rust: pub(super) fn place_turning(
    // rust: vertices: &[Vertex],
    // rust: spins: &[(usize, Option<Spin>)],
    // rust: game_time: i64,
    // rust: partial: f32,
    // rust: origin: Vec3,
    // rust: out: &mut Vec<Vertex>,
    // rust: ) {
    // rust: let mut turn: Option<Mat4> = None;
    // rust: let mut next = spins.iter().peekable();
    // rust: for (i, v) in vertices.iter().enumerate() {
    // rust: while let Some((start, spin)) = next.next_if(|(start, _)| *start <= i) {
    // rust: let _ = start;
    // rust: turn = spin.map(|s| s.turn(game_time, partial));
}
    // rust: let mut v = *v;
    // rust: if let Some(m) = turn {
    // rust: v.pos = m.transform_point3(Vec3::from_array(v.pos)).to_array();
    // rust: if v.normal[3] != 0 {
    // rust: let n = Vec3::new(
    // rust: f32::from(v.normal[0]),
    // rust: f32::from(v.normal[1]),
    // rust: f32::from(v.normal[2]),
    // rust: );
    // rust: let n = m.transform_vector3(n);
    // rust: v.normal = [
    // rust: n.x.round().clamp(-127.0, 127.0) as i8,
    // rust: n.y.round().clamp(-127.0, 127.0) as i8,
    // rust: n.z.round().clamp(-127.0, 127.0) as i8,
    // rust: v.normal[3],
    // rust: ];
}
}
    // rust: v.pos = (Vec3::from_array(v.pos) + origin).to_array();
    // rust: out.push(v);
}
}

    // rust: impl BlockEntityDraw {
    /// A frame drawn from `pose` (relative to the camera), lit by `light` and
    /// `lights`, adding to `vertices`; `block` is where `native_draw_item`'s
    /// owner stands. A mob's frame (`native_mob_submit`) is made this way.
    // rust: pub(super) fn posed(
    // rust: partial: f32,
    // rust: game_time: i64,
    // rust: light: u32,
    // rust: block: [i32; 3],
    // rust: pose: Mat4,
    // rust: lights: (Vec3, Vec3),
    // rust: vertices: Vec<Vertex>,
    // rust: ) -> Self {
    // rust: Self {
    // rust: partial,
    // rust: game_time,
    // rust: light,
    // rust: block,
    // rust: poses: vec![pose],
    // rust: lights,
    // rust: vertices,
    // rust: kept: false,
    // rust: spins: Vec::new(),
}
}
    /// The vertices drawn, with those it was made with first.
    // rust: pub(super) fn into_vertices(self) -> Vec<Vertex> {
    // rust: self.vertices
}
    /// The vertices drawn and where its turning parts start in them (`spin`).
    // rust: pub(super) fn into_turning(self) -> (Vec<Vertex>, Vec<(usize, Option<Spin>)>) {
    // rust: (self.vertices, self.spins)
}
    /// `PoseStack.pushPose`: `pop` comes back to the pose as it is now.
pub fn push(self: *Self) void {
}
    // rust: let pose = self.pose();
    // rust: self.poses.push(pose);
}
    /// `PoseStack.popPose`; the block's own pose is never popped.
pub fn pop(self: *Self) void {
}
    // rust: if self.poses.len() > 1 {
    // rust: self.poses.pop();
}
}
    /// Moves what is drawn next by `by`, in blocks.
pub fn translate(self: *Self, by: [f32; 3]) void {
}
    // rust: self.apply(Mat4::from_translation(Vec3::from_array(by)));
}
    /// Turns what is drawn next by `degrees` about `axis` (counterclockwise
    /// seen from the axis' positive end, as `Axis.rotationDegrees`) through
    /// `pivot`, in blocks from the pose's origin: `[0.5; 3]` is the block's centre.
pub fn rotate_about(self: *Self, axis: [f32; 3], degrees: f32, pivot: [f32; 3]) void {
}
    // rust: let axis = Vec3::from_array(axis).normalize_or(Vec3::Y);
    // rust: let pivot = Vec3::from_array(pivot);
    // rust: self.apply(
    // rust: Mat4::from_translation(pivot)
    // rust: * Mat4::from_quat(Quat::from_axis_angle(axis, degrees.to_radians()))
    // rust: * Mat4::from_translation(-pivot),
    // rust: );
}
    /// Scales what is drawn next by `by` about the pose's origin.
pub fn scale(self: *Self, by: [f32; 3]) void {
}
    // rust: self.apply(Mat4::from_scale(Vec3::from_array(by)));
}
    /// Keeps what this call drew: the block is drawn the same again, with
    /// neither `native_block_entity_submit` nor
    /// `native_block_entity_render_bounding_box` called, until its state,
    /// its block entity (what the server sent), its light or the resource
    /// packs change. Call it only when what you drew reads none of
    /// `partial`, `game_time`, the blocks around it or anything else of
    /// yours, and moves nothing by itself but through `spin`: an idle machine,
    /// or a shaft turning at a steady speed, not one whose speed changes from
    /// frame to frame. Kept geometry stands still: an enchanted item's glint, and an
    /// item drawn with `native_draw_item` whose model reads the time (a clock,
    /// a compass), stop where they were. API 94.
pub fn keep(self: *Self) void {
}
    // rust: self.kept = true;
}
    /// What is drawn next turns by itself: `degrees_per_tick` degrees each
    /// game tick (a shaft at `rpm` turns `rpm * 0.3`, as Create's do), about
    /// `axis` through `pivot`, both in blocks from the block's corner
    /// whatever the pose, counterclockwise seen from the axis' positive end,
    /// `phase` degrees round at game time 0 (to mesh a cog with its
    /// neighbour's). Draw the part at rest; the game turns it each frame from
    /// the game time and the partial tick. With `keep` it goes on turning
    /// with no call of `native_block_entity_submit` until what it was drawn
    /// with changes: send a new speed in the update tag and the block is
    /// drawn again (Flywheel's rotating instances, done on the CPU). The
    /// angle is `game_time * degrees_per_tick + phase`, not a sum of turns:
    /// with a new speed, pass the phase that keeps the part where it was
    /// (`old_angle - game_time * new_speed`), or it jumps. Until
    /// `still` or the next `spin`. A block entity's frame only: a mob's
    /// (`native_mob_submit`) draws it at rest. API @API:spinning_geometry@.
pub fn spin(self: *Self, axis: [f32; 3], pivot: [f32; 3], degrees_per_tick: f32, phase: f32) void {
}
    // rust: let spin = Spin {
    // rust: axis: Vec3::from_array(axis).normalize_or(Vec3::Y),
    // rust: pivot: Vec3::from_array(pivot),
    // rust: degrees_per_tick: if degrees_per_tick.is_finite() {
    // rust: degrees_per_tick
    // rust: } else {
    // rust: 0.0
    // rust: },
    // rust: phase: if phase.is_finite() { phase } else { 0.0 },
}
    // rust: self.spins.push((self.vertices.len(), Some(spin)));
}
    /// What is drawn next stands still again, after `spin`.
    /// API @API:spinning_geometry@.
pub fn still(self: *Self) void {
}
    // rust: self.spins.push((self.vertices.len(), None));
}
pub fn apply(self: *Self, m: Mat4) void {
}
    // rust: if let Some(pose) = self.poses.last_mut() {
    // rust: *pose *= m;
}
}
    // rust: pub(super) fn pose(&self) -> Mat4 {
    // rust: self.poses.last().copied().unwrap_or(Mat4::IDENTITY)
}
    // rust: pub(super) fn vertices_mut(&mut self) -> &mut Vec<Vertex> {
    // rust: &mut self.vertices
}
    /// A quad of `corners` (blocks, under the pose) with unit UVs, shaded as
    /// vanilla's block entity models are (`Lighting`'s two lights).
pub fn quad(self: *Self, corners: [[f32; 3]; 4], uv: [[f32; 2]; 4], sprite: Rect, tint: u32) void {
}
    // rust: let pose = self.pose();
    // rust: let at = corners.map(|c| pose.transform_point3(Vec3::from_array(c)));
    // rust: let normal = (at[1] - at[0]).cross(at[2] - at[0]).normalize_or_zero();
    // rust: let normal = if normal == Vec3::ZERO {
    // rust: (at[2] - at[1]).cross(at[3] - at[1]).normalize_or(Vec3::Y)
    // rust: } else {
    // rust: normal
}
    // rust: let color = shaded(tint, diffuse(normal, self.lights));
    // rust: for (p, uv) in at.into_iter().zip(uv) {
    // rust: self.vertices.push(Vertex {
    // rust: pos: p.to_array(),
    // rust: uv: [
    // rust: sprite.u0 + (sprite.u1 - sprite.u0) * uv[0],
    // rust: sprite.v0 + (sprite.v1 - sprite.v0) * uv[1],
    // rust: ],
    // rust: layer: 0,
    // rust: color,
    // rust: light: self.light,
    // rust: normal: [0; 4],
    // rust: glint_uv: [0.0, 0.0],
    // rust: });
}
}
}

/// One face of a `native_draw_cube` box: its sprite (`mymod:entity/cog`,
/// `mymod:block/casing`) and its UVs in texels of 16 per side, as a model
/// face's `uv` (none takes the box's own, as a model's default).
pub const CubeFace = struct {
    sprite: *'a str,
    uv: Option<[f32,
};

/// 0xRRGGBB `tint` times `brightness`, as an opaque vertex colour.
pub fn shaded(tint: u32, brightness: f32) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let c = |shift: u32| (((tint >> shift) & 255) as f32 * brightness) as u32;
    // rust: 0xFF00_0000 | c(0) << 16 | c(8) << 8 | c(16)
}

/// Game ticks kept geometry stays after it was last drawn, as signs' text.
pub const KEPT_FOR: i64 = 100;

/// What kept geometry was drawn with besides its block entity: drawn again
/// when any of it changes.
pub const KeptKey = struct {
    dim: Dim,
    state: u32,
    light: u32,
    /// `Font::epoch` when it was drawn: a cache reset moves glyphs in the
    /// atlas, so text a mod kept (`native_draw_text`) is drawn again, as a
    /// sign's kept text is.
    glyphs: u64,
};

pub const KeptEntry = struct {
    key: KeptKey,
    /// Of the block entity it was drawn from: equal, nothing changed it.
    revision: ModRevision,
    bounds: [f32,
    /// Game time it was last drawn.
    used: i64,
    /// Relative to the block's corner.
    vertices: std.ArrayList(Vertex),
    /// Its turning parts (`BlockEntityDraw::spin`), from the start of `vertices`.
    spins: Vec<(usize,
};

/// Geometry mods kept (`BlockEntityDraw::keep`), by position. As
/// `SignTexts` keeps a sign's text, it is kept relative to the block and
/// moved to the camera each frame.
    // rust: pub(super) struct KeptGeometry {
    // rust: entries: FxHashMap<[i32; 3], KeptEntry>,
    /// Game time of the last sweep of what is out of view.
    // rust: swept: i64,
}

    // rust: impl KeptGeometry {
    /// Drops what was not drawn for `KEPT_FOR` ticks, once every `KEPT_FOR`.
pub fn sweep(self: *Self, now: i64) void {
}
    // rust: if (now - self.swept).abs() >= KEPT_FOR {
    // rust: self.swept = now;
    // rust: self.entries
    // rust: .retain(|_, e| (now - KEPT_FOR..=now).contains(&e.used));
}
}
    /// What is kept at `pos` when it was drawn with `key` and its block
    /// entity at `revision`, marked drawn at `now`.
    // rust: fn get(
    // rust: &mut self,
    // rust: pos: [i32; 3],
    // rust: key: KeptKey,
    // rust: revision: ModRevision,
    // rust: now: i64,
    // rust: ) -> Option<&KeptEntry> {
    // rust: let entry = self
    // rust: .entries
    // rust: .get_mut(&pos)
    // rust: .filter(|e| e.key == key && e.revision == revision)?;
    // rust: entry.used = now;
    // rust: Some(entry)
}
    // rust: fn keep(
    // rust: &mut self,
    // rust: pos: [i32; 3],
    // rust: key: KeptKey,
    // rust: revision: ModRevision,
    // rust: bounds: [f32; 6],
    // rust: vertices: &[Vertex],
    // rust: spins: Vec<(usize, Option<Spin>)>,
    // rust: now: i64,
    // rust: ) {
    // rust: let mut kept = self
    // rust: .entries
    // rust: .remove(&pos)
    // rust: .map_or_else(Vec::new, |e| e.vertices);
    // rust: kept.clear();
    // rust: kept.extend_from_slice(vertices);
    // rust: self.entries.insert(
    // rust: pos,
    // rust: KeptEntry {
    // rust: key,
    // rust: revision,
    // rust: bounds,
    // rust: used: now,
    // rust: vertices: kept,
    // rust: spins,
    // rust: },
    // rust: );
}
pub fn forget(self: *Self, pos: [i32; 3]) void {
}
    // rust: self.entries.remove(&pos);
}
    /// Forgets everything: the atlas's sprites moved.
    // rust: pub(super) fn clear(&mut self) {
    // rust: self.entries.clear();
}
}

    // rust: impl Game<'_> {
    /// The mod block entities within view distance of `camera` whose block's
    /// template has none, which the mesher's block entity lists (made from
    /// the template) leave out: where they are and their block's state, for
    /// `mod_block_entity_geometry`. From the per-chunk list of
    /// `BlockEntities::mods_near`, not a scan of every block entity.
    // rust: pub(super) fn untemplated_mod_block_entities(&self, camera: DVec3) -> Vec<([i32; 3], u32)> {
    // rust: self.world
    // rust: .block_entities
    // rust: .mods_near(camera.x, camera.z, VIEW_DISTANCE)
    // rust: .map(|p| ([p.0, p.1, p.2], self.world.block(p.0, p.1, p.2).0))
    // rust: .filter(|&(_, state)| !self.res.facts().get(BlockStateId(state)).block_entity)
    // rust: .collect()
}
    /// `native_block_entity_submit` for each of `blocks` (in drawn sections,
    /// drawn by no vanilla renderer) whose block entity is a mod's, closer than
    /// `BlockEntityRenderer.getViewDistance` to the camera (`shouldRender`)
    /// and with its bounds (`native_block_entity_render_bounding_box`) in the
    /// frustum. Entity occlusion culling is for ordinary entities; block
    /// entities use these renderer-provided bounds instead.
    // rust: pub(super) fn mod_block_entity_geometry<'a>(
    // rust: &self,
    // rust: blocks: impl Iterator<Item = &'a ([i32; 3], u32)>,
    // rust: camera: DVec3,
    // rust: partial: f32,
    // rust: out: &mut Vec<Vertex>,
    // rust: ) {
    // rust: let mut draw = BlockEntityDraw {
    // rust: partial,
    // rust: game_time: self.world.game_time,
    // rust: light: 0,
    // rust: block: [0; 3],
    // rust: poses: Vec::new(),
    // rust: lights: diffuse_lights(self.dim == Dim::Nether),
    // rust: vertices: std::mem::take(out),
    // rust: kept: false,
    // rust: spins: Vec::new(),
}
    // rust: let now = self.world.game_time;
    // rust: let mut kept = self.kept_block_entities.borrow_mut();
    // rust: kept.sweep(now);
    // rust: for &(pos, state) in blocks {
    // rust: let corner = DVec3::new(f64::from(pos[0]), f64::from(pos[1]), f64::from(pos[2]));
            // Vec3.closerThan: strictly closer.
    // rust: if (corner + 0.5).distance_squared(camera) >= VIEW_DISTANCE * VIEW_DISTANCE {
    // rust: continue;
}
    // rust: let Some(BlockEntity::Mod(entity)) =
    // rust: self.world.block_entities.get(&(pos[0], pos[1], pos[2]))
    // rust: else {
    // rust: continue;
}
    // rust: let origin = (corner - camera).as_vec3();
    // rust: let light = vertex_light(self.world.light(pos[0], pos[1], pos[2]));
    // rust: let key = KeptKey {
    // rust: dim: self.dim,
    // rust: state,
    // rust: light,
    // rust: glyphs: self.gui.atlas.font.epoch(),
}
    // rust: if let Some(entry) = kept.get(pos, key, entity.revision(), now) {
    // rust: if in_frustum(self.view_frustum.as_ref(), origin, entry.bounds) {
    // rust: let start = draw.vertices.len();
    // rust: self.mark_block_entity(start, state);
    // rust: if entry.spins.is_empty() {
    // rust: draw.vertices.extend(entry.vertices.iter().map(|v| Vertex {
    // rust: pos: (Vec3::from_array(v.pos) + origin).to_array(),
    // rust: ..*v
    // rust: }));
    // rust: } else {
    // rust: place_turning(
    // rust: &entry.vertices,
    // rust: &entry.spins,
    // rust: draw.game_time,
    // rust: draw.partial,
    // rust: origin,
    // rust: &mut draw.vertices,
    // rust: );
}
}
    // rust: continue;
}
    // rust: let id = BlockStateId(state);
    // rust: let block = &*self.res.facts().get(id).name;
    // rust: let mut bounds = DEFAULT_BOUNDS;
    // rust: self.native_block_entity_render_bounding_box(pos, block, id, entity, &mut bounds);
    // rust: if !in_frustum(self.view_frustum.as_ref(), origin, bounds) {
    // rust: continue;
}
    // rust: let start = draw.vertices.len();
    // rust: self.mark_block_entity(start, state);
            // Drawn relative to the block, then moved to the camera, so what
            // is kept can be moved again.
    // rust: draw.block = pos;
    // rust: draw.poses.clear();
    // rust: draw.poses.push(Mat4::IDENTITY);
    // rust: draw.light = light;
    // rust: draw.kept = false;
    // rust: draw.spins.clear();
    // rust: self.native_block_entity_submit(pos, block, id, entity, &mut draw);
            // The turning parts, from the start of this block's vertices.
    // rust: let spins: Vec<(usize, Option<Spin>)> = draw
    // rust: .spins
    // rust: .drain(..)
    // rust: .map(|(at, spin)| (at.saturating_sub(start), spin))
    // rust: .collect();
    // rust: if draw.kept {
    // rust: kept.keep(
    // rust: pos,
    // rust: key,
    // rust: entity.revision(),
    // rust: bounds,
    // rust: &draw.vertices[start..],
    // rust: spins.clone(),
    // rust: now,
    // rust: );
    // rust: } else {
    // rust: kept.forget(pos);
}
    // rust: if spins.is_empty() {
    // rust: for v in &mut draw.vertices[start..] {
    // rust: v.pos = (Vec3::from_array(v.pos) + origin).to_array();
}
    // rust: } else {
    // rust: let drawn = draw.vertices.split_off(start);
    // rust: place_turning(
    // rust: &drawn,
    // rust: &spins,
    // rust: draw.game_time,
    // rust: draw.partial,
    // rust: origin,
    // rust: &mut draw.vertices,
    // rust: );
}
}
    // rust: *out = draw.vertices;
}
}

/// Helpers for drawing mod block entities, kept as stable as the hook points.
// Native mods use these; nothing in Horizon does.
    // rust: impl Game<'_> {
    /// Draws a quad with `corners` in blocks under `draw`'s pose, in a model
    /// face's order (top left, bottom left, bottom right, top right as seen
    /// from its front), textured with the `uv` rectangle (u0, v0, u1, v1 in
    /// texels of 16 per side) of `sprite` (`mymod:entity/screen`,
    /// `mymod:block/casing`, `block/stone`) times the 0xRRGGBB `tint`
    /// (0xFFFFFF for none). False for an unknown sprite. API 71.
    // rust: pub(super) fn native_draw_quad(
    // rust: &self,
    // rust: draw: &mut BlockEntityDraw,
    // rust: sprite: &str,
    // rust: corners: [[f32; 3]; 4],
    // rust: uv: [f32; 4],
    // rust: tint: u32,
    // rust: ) -> bool {
    // rust: let Some(rect) = self.gui.atlas.sprites.get(sprite).copied() else {
    // rust: return false;
}
    // rust: let [u0, v0, u1, v1] = uv.map(|t| t / 16.0);
    // rust: draw.quad(
    // rust: corners,
    // rust: [[u0, v0], [u0, v1], [u1, v1], [u1, v0]],
    // rust: rect,
    // rust: tint,
    // rust: );
    // rust: true
}

    /// Draws `text` under `draw`'s pose as a sign draws its lines
    /// (`Font.drawInBatch` in a `BlockEntityRenderer`): in the pose's x-y
    /// plane, one unit a font pixel, y down, its left end at `at`, facing
    /// +z. Scale the pose first as a sign does (`draw.scale([1.0 / 64.0,
    /// -1.0 / 64.0, 1.0 / 64.0])` for its letters, 8 pixels high). Each span
    /// is drawn in its own colour, the others in the 0xRRGGBB `color`;
    /// `glowing` text is full bright (a glow ink sac's), the rest lit by
    /// `draw.light`; a nonzero 0xRRGGBB `outline` rings each glyph, as glowing
    /// sign text's. Returns the width drawn, in font pixels: centre a line
    /// by starting it at minus half its width. API @API:draw_text@.
    // rust: pub(super) fn native_draw_text(
    // rust: &self,
    // rust: draw: &mut BlockEntityDraw,
    // rust: text: &Text,
    // rust: at: [f32; 2],
    // rust: color: u32,
    // rust: glowing: bool,
    // rust: outline: u32,
    // rust: ) -> f32 {
    // rust: let glyph = |c: char| self.gui.atlas.glyph_cell(c);
    // rust: let light = if glowing { 240 | 240 << 8 } else { draw.light };
    // rust: let matrix = draw.pose();
    // rust: let mut x = at[0];
    // rust: for span in &text.spans {
    // rust: let shown = horizon_client::bidi::visual_str(&span.text).into_owned();
    // rust: let width: f32 = shown.chars().map(|c| glyph(c).advance).sum();
    // rust: let call = TextCall {
    // rust: matrix,
    // rust: x,
    // rust: y: at[1],
    // rust: text: shown,
    // rust: color: 0xFF00_0000 | (span.style.color.unwrap_or(color) & 0xFF_FFFF),
    // rust: outline: if outline == 0 {
    // rust: 0
    // rust: } else {
    // rust: 0xFF00_0000 | (outline & 0xFF_FFFF)
    // rust: },
    // rust: light,
}
    // rust: text_vertices(&glyph, &call, &mut draw.vertices);
    // rust: x += width;
}
    // rust: x - at[0]
}

    /// Draws a box from `from` to `to` (texels of 16 per block, as a block
    /// model's element) under `draw`'s pose, with the faces given, by
    /// `Direction` (down, up, north, south, west, east), baked as a model
    /// element's are (`FaceBakery`), times the 0xRRGGBB `tint`. A turned box
    /// is drawn under a turned pose (`BlockEntityDraw::rotate_about`). False
    /// when a face's sprite is unknown; that face is left out. API 71.
    // rust: pub(super) fn native_draw_cube(
    // rust: &self,
    // rust: draw: &mut BlockEntityDraw,
    // rust: from: [f32; 3],
    // rust: to: [f32; 3],
    // rust: faces: [Option<CubeFace<'_>>; 6],
    // rust: tint: u32,
    // rust: ) -> bool {
    // rust: let mut all = true;
    // rust: for (direction, face) in Direction::ALL.into_iter().zip(faces) {
    // rust: let Some(face) = face else { continue };
    // rust: let Some(rect) = self.gui.atlas.sprites.get(face.sprite).copied() else {
    // rust: all = false;
    // rust: continue;
}
    // rust: let uv = face.uv.unwrap_or_else(|| default_uv(from, to, direction));
    // rust: let material = Material {
    // rust: sprite: String::new(),
    // rust: force_translucent: false,
}
    // rust: if let Ok(quad) = bake_flat_face(from, to, uv, direction, material, -1) {
    // rust: draw.quad(quad.positions, quad.uv, rect, tint);
}
}
    // rust: all
}

    /// Draws block `block`'s model (`mymod:cog`, any block with a model) in
    /// the state with `properties` (`[("axis", "x")]`, the rest default)
    /// under `draw`'s pose, as vanilla's `submitBlockModel` draws a block in
    /// an entity's place: a block's baked model, with its default tints. A
    /// moving part that is no block is a standalone model
    /// (`native_draw_model`). False for an unknown block or property. API 71.
    // rust: pub(super) fn native_draw_block(
    // rust: &self,
    // rust: draw: &mut BlockEntityDraw,
    // rust: block: &str,
    // rust: properties: &[(&str, &str)],
    // rust: ) -> bool {
    // rust: let registry = &self.pack.assets.registry;
    // rust: let Some(mut state) = registry
    // rust: .default_state(block)
    // rust: .and_then(|id| registry.state(id))
    // rust: .cloned()
    // rust: else {
    // rust: return false;
}
    // rust: for (key, value) in properties {
    // rust: match state.properties.get_mut(*key) {
    // rust: Some(v) => *v = (*value).to_owned(),
    // rust: None => return false,
}
}
    // rust: let Some(id) = registry.id(&state) else {
    // rust: return false;
}
    // rust: let pose = draw.pose();
    // rust: self.block_model_vertices(id, 42, pose, draw.light, true, &mut draw.vertices);
    // rust: true
}

    /// Draws standalone model `model` (`mymod:block/shaft_half`, one a mod
    /// named in `native_standalone_models`) under `draw`'s pose, as
    /// `native_draw_block` draws a block's: unturned, from the block's lower
    /// north-west corner, lit by `draw.light`. Its faces with a tint index
    /// are multiplied by the 0xRRGGBB `tint` (0xFFFFFF for none), the
    /// others drawn as they are. False when the model isn't baked: not
    /// named, missing from the resources, or on a side that draws nothing.
    /// API 151.
    // rust: pub(super) fn native_draw_model(
    // rust: &self,
    // rust: draw: &mut BlockEntityDraw,
    // rust: model: &str,
    // rust: tint: u32,
    // rust: ) -> bool {
    // rust: let Some(baked) = self.pack.render.model_catalog.standalone(model) else {
    // rust: return false;
}
    // rust: let pose = draw.pose();
    // rust: let light = draw.light;
    // rust: let tint = |index: i32| (index >= 0).then_some(tint & 0xFF_FFFF);
    // rust: self.baked_model_vertices([baked], pose, |_| light, true, tint, &mut draw.vertices);
    // rust: true
}

    /// Draws model part `part` and the parts under it under `draw`'s pose, as
    /// vanilla's `ModelPart.render` does: each part moved to its place (in
    /// texels, 16 to a block), turned about z, then y, then x, and scaled,
    /// its faces textured from `sprite` (`mymod:entity/golem`, a content
    /// mod's `assets/mymod/textures/entity/golem.png`, or vanilla's
    /// `entity/zombie/zombie`) times the 0xRRGGBB `tint`. A part that isn't
    /// `visible` draws nothing, one that skips drawing (`skip_draw`) only its
    /// children. A mob's model is built in the model's own frame (+y down,
    /// its front towards -z, its feet 24 texels down): in `native_mob_submit`,
    /// `draw.scale([1.0, -1.0, -1.0])` then `draw.translate([0.0, -1.501,
    /// 0.0])` first, as `LivingEntityRenderer` does. False for an unknown
    /// sprite. API @API:model_layers@.
    // rust: pub(super) fn native_draw_model_part(
    // rust: &self,
    // rust: draw: &mut BlockEntityDraw,
    // rust: part: &ModelPart,
    // rust: sprite: &str,
    // rust: tint: u32,
    // rust: ) -> bool {
    // rust: let Some(rect) = self.gui.atlas.sprites.get(sprite).copied() else {
    // rust: return false;
}
    // rust: draw_model_part(draw, part, rect, tint);
    // rust: true
}

    /// Entity model layer `layer` baked into its `ModelPart` tree, each part
    /// at its pose, as `EntityModelSet.bakeLayer` bakes it: one a native mod
    /// registered (`native_layer_definitions`), or vanilla's, by the name
    /// `entity-models.json` gives it (`minecraft:zombie#main`,
    /// `minecraft:player#main`). The tree is the caller's own copy: bake it
    /// once, as a renderer does, and set its parts' poses each frame. None
    /// for a layer neither has. A vanilla layer no mob has (a player's, a
    /// chest's) is read from the resources each call, so slow. API
    /// @API:model_layers@.
    // rust: pub(super) fn native_bake_layer(&self, layer: &str) -> Option<ModelPart> {
    // rust: if let Some(definition) = model_layers::registered(layer) {
    // rust: return Some(definition.bake_root());
}
    // rust: let key = layer.strip_prefix("minecraft:")?;
    // rust: if let Some(part) = self.res.mob_types().values().find_map(|t| t.layer(key)) {
    // rust: return Some(ModelPart::from_part(part));
}
    // rust: let models = horizon_client::mobs::EntityModelDocument::load(&self.vanilla_root()).ok()?;
    // rust: models.model(layer).map(|part| ModelPart::from_part(&part))
}

    /// Draws `stack` under `draw`'s pose as an item is drawn in the world
    /// (`ItemModelResolver.updateForTopItem` and `ItemStackRenderState.submit`), centred on the
    /// pose's origin, in its model's `display` transform: `Fixed` as a
    /// campfire's or an item frame's, `Ground` as a dropped item's. `seed`
    /// picks among random models (a campfire passes its slot plus its
    /// position's hash). `owner_yaw` makes the block entity the item's
    /// owner (`ItemOwner`), at the block's centre and turned that many
    /// degrees (`getVisualRotationYInDegrees`), as a shelf is: a compass on
    /// it points to its target from there. None draws it with no owner, as
    /// a campfire does. False for an empty stack or one with no model. The
    /// client's copy of a block entity has no item slots (`entity.items` is
    /// empty there): send the stacks you draw in
    /// `native_block_entity_update_tag` and read them from `entity.nbt`.
    /// API 91.
    // rust: pub(super) fn native_draw_item(
    // rust: &self,
    // rust: draw: &mut BlockEntityDraw,
    // rust: stack: &ItemStack,
    // rust: display: DisplayContext,
    // rust: owner_yaw: Option<f32>,
    // rust: seed: i32,
    // rust: ) -> bool {
        // ShelfBlockEntity.position(): Vec3.atCenterOf(getBlockPos()).
    // rust: let owner = owner_yaw
    // rust: .map(|yaw| super::item_draw::owner_at(draw.block.map(|c| f64::from(c) + 0.5), yaw, ""));
    // rust: let item = self.resolve_item(stack, display, owner.as_ref(), seed);
    // rust: if item.is_empty() {
    // rust: return false;
}
    // rust: let pose = draw.pose();
    // rust: self.submit_item_world(&item, pose, draw.light, &mut draw.vertices);
    // rust: true
}

    /// Property `key` of block state `state` (a machine's `facing`, from the
    /// `state` `native_block_entity_submit` gets), if it has one: no lookup in
    /// the world, so cheap each frame. API 91.
    // rust: pub(super) fn native_block_state_property(
    // rust: &self,
    // rust: state: BlockStateId,
    // rust: key: &str,
    // rust: ) -> Option<&str> {
    // rust: self.pack
    // rust: .assets
    // rust: .registry
    // rust: .state(state)?
    // rust: .properties
    // rust: .get(key)
    // rust: .map(String::as_str)
}
    /// The block `state` is a state of: its name, as `GameLevel`'s helper of
    /// the same name gives it for the hooks that get a state in the world.
    // rust: pub(super) fn native_state_block(&self, state: BlockStateId) -> Option<&str> {
    // rust: self.pack.assets.registry.state(state).map(|s| &*s.name)
}
}

/// `ModelPart.render`: `part`'s faces under its own pose
/// (`translateAndRotate`), then its children under theirs.
pub fn draw_model_part(draw: *mut BlockEntityDraw, part: *ModelPart, sprite: Rect, tint: u32) void {
}
    // rust: if !part.visible || (part.is_empty() && part.children().next().is_none()) {
    // rust: return;
}
    // rust: draw.push();
    // rust: draw.apply(part_transform(part));
    // rust: if !part.skip_draw {
    // rust: for polygon in &part.polygons {
    // rust: let corners = polygon.vertices.map(|v| v.pos.map(|c| c / 16.0));
    // rust: let uv = polygon.vertices.map(|v| [v.u, v.v]);
    // rust: draw.quad(corners, uv, sprite, tint);
}
}
    // rust: for (_, child) in part.children() {
    // rust: draw_model_part(draw, child, sprite, tint);
}
    // rust: draw.pop();
}

/// `ModelPart.translateAndRotate`: to the part's place in blocks, turned
/// about z, then y, then x (`rotationZYX`), then scaled.
pub fn part_transform(part: *ModelPart) M {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut m = Mat4::from_translation(Vec3::new(part.x, part.y, part.z) / 16.0);
    // rust: if part.x_rot != 0.0 || part.y_rot != 0.0 || part.z_rot != 0.0 {
    // rust: m *= Mat4::from_quat(Quat::from_euler(
    // rust: glam::EulerRot::ZYX,
    // rust: part.z_rot,
    // rust: part.y_rot,
    // rust: part.x_rot,
    // rust: ));
}
    // rust: if part.x_scale != 1.0 || part.y_scale != 1.0 || part.z_scale != 1.0 {
    // rust: m *= Mat4::from_scale(Vec3::new(part.x_scale, part.y_scale, part.z_scale));
}
    // rust: m
}

    // rust: mod tests {
//     use super::*;
//     use horizon_client::containers::{ModBlockEntity, ModBlockEntityFields};

pub fn draw() B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: BlockEntityDraw {
    // rust: partial: 0.0,
    // rust: game_time: 0,
    // rust: light: 0xF0F0,
    // rust: block: [0; 3],
    // rust: poses: vec![Mat4::from_translation(Vec3::new(10.0, 0.0, 0.0))],
    // rust: lights: diffuse_lights(false),
    // rust: vertices: Vec::new(),
    // rust: kept: false,
    // rust: spins: Vec::new(),
}
}

pub fn sprite() R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Rect {
    // rust: u0: 0.5,
    // rust: v0: 0.25,
    // rust: u1: 0.75,
    // rust: v1: 0.5,
    // rust: w: 16,
    // rust: h: 16,
}
}

pub fn the_pose_stack_turns_about_its_pivot_and_pops_back() void {
}
    // rust: let mut d = draw();
    // rust: d.push();
    // rust: d.rotate_about([0.0, 1.0, 0.0], 90.0, [0.5, 0.5, 0.5]);
        // (1, 0, 0.5) turns a quarter about the block's centre to (0.5, 0, 0).
    // rust: let p = d.pose().transform_point3(Vec3::new(1.0, 0.0, 0.5));
    // rust: assert!(p.abs_diff_eq(Vec3::new(10.5, 0.0, 0.0), 1e-5), "{p}");
    // rust: d.pop();
    // rust: d.pop();
        // Popping past the block's own pose keeps it.
    // rust: let p = d.pose().transform_point3(Vec3::ZERO);
    // rust: assert_eq!(p, Vec3::new(10.0, 0.0, 0.0));
    // rust: d.translate([0.0, 2.0, 0.0]);
    // rust: d.scale([2.0, 2.0, 2.0]);
    // rust: let p = d.pose().transform_point3(Vec3::ONE);
    // rust: assert_eq!(p, Vec3::new(12.0, 4.0, 2.0));
}

    /// An arm a block east of the frame's origin, turned a quarter about z,
    /// with a hand a block below its pivot: `translateAndRotate` turns each
    /// part about its own pivot, then moves it, and a child goes with its
    /// parent. Expected corners are worked out by hand from JOML's
    /// `rotationZYX` (a right-handed quarter turn takes +x to +y).
pub fn a_model_part_draws_turned_about_its_pivot_and_carries_its_children() void {
}
//         use horizon_client::mobs::model_layers::{
    // rust: CubeListBuilder, LayerDefinition, MeshDefinition, PartPose,
}
//         use horizon_core::geometry::Direction as Face;
    // rust: let mut mesh = MeshDefinition::new();
    // rust: let root = mesh.root();
    // rust: let cube = |face| CubeListBuilder::create().add_box_faces([0.0; 3], [16.0; 3], &[face]);
    // rust: let arm = mesh.add_or_replace_child(
    // rust: root,
    // rust: "arm",
    // rust: cube(Face::South),
    // rust: PartPose::offset_and_rotation(16.0, 0.0, 0.0, 0.0, 0.0, std::f32::consts::FRAC_PI_2),
    // rust: );
    // rust: mesh.add_or_replace_child(
    // rust: arm,
    // rust: "hand",
    // rust: cube(Face::North),
    // rust: PartPose::offset(0.0, 16.0, 0.0),
    // rust: );
    // rust: let mut model = LayerDefinition::create(mesh, 64, 64).bake_root();
    // rust: let drawn = |model: &ModelPart| {
    // rust: let mut d = draw();
    // rust: draw_model_part(&mut d, model, sprite(), 0xFF_FFFF);
    // rust: d.into_vertices()
}
    // rust: let near = |v: &Vertex, at: [f32; 3]| {
    // rust: assert!(
    // rust: Vec3::from(v.pos).abs_diff_eq(Vec3::from(at), 1e-5),
    // rust: "{:?} not {at:?}",
    // rust: v.pos
    // rust: );
}

    // rust: let all = drawn(&model);
    // rust: assert_eq!(all.len(), 8);
        // The arm's south face, (0, 0, 1) (1, 0, 1) (1, 1, 1) (0, 1, 1) in
        // its frame, turned and moved a block east, then the frame's 10.
    // rust: for (v, at) in all.iter().zip([
    // rust: [11.0, 0.0, 1.0],
    // rust: [11.0, 1.0, 1.0],
    // rust: [10.0, 1.0, 1.0],
    // rust: [10.0, 0.0, 1.0],
    // rust: ]) {
    // rust: near(v, at);
}
        // Its net's last strip, 48 to 64 across and 16 to 32 down, in the sprite.
    // rust: assert_eq!(all[0].uv, [0.75, 0.3125]);
        // The hand's north face starts at its (1, 0, 0), the arm's (1, 1, 0).
    // rust: near(&all[4], [10.0, 1.0, 0.0]);
    // rust: near(&all[5], [10.0, 0.0, 0.0]);

    // rust: let arm = model.get_child_mut("arm").unwrap();
    // rust: arm.skip_draw = true;
    // rust: let hand_only = drawn(&model);
    // rust: assert_eq!(hand_only.len(), 4);
    // rust: near(&hand_only[0], [10.0, 1.0, 0.0]);
    // rust: model.get_child_mut("arm").unwrap().visible = false;
    // rust: assert!(drawn(&model).is_empty());
}

pub fn a_quad_lands_in_its_sprite_lit_and_shaded() void {
}
    // rust: let mut d = draw();
        // An upward face: full brightness under vanilla's level lights is
        // below 1 (two lights), so the colour is shaded but opaque.
    // rust: d.quad(
    // rust: [
    // rust: [0.0, 1.0, 0.0],
    // rust: [0.0, 1.0, 1.0],
    // rust: [1.0, 1.0, 1.0],
    // rust: [1.0, 1.0, 0.0],
    // rust: ],
    // rust: [[0.0, 0.0], [0.0, 1.0], [1.0, 1.0], [1.0, 0.0]],
    // rust: sprite(),
    // rust: 0xFFFFFF,
    // rust: );
    // rust: assert_eq!(d.vertices.len(), 4);
    // rust: let v = d.vertices[2];
    // rust: assert_eq!(v.pos, [11.0, 1.0, 1.0]);
    // rust: assert_eq!(v.uv, [0.75, 0.5]);
    // rust: assert_eq!(v.light, 0xF0F0);
    // rust: let up = diffuse(Vec3::Y, diffuse_lights(false));
    // rust: assert_eq!(v.color, shaded(0xFFFFFF, up));
    // rust: assert_eq!(v.color >> 24, 0xFF);
}

    /// A frustum that sees nothing.
pub const Blind = struct {};
    // rust: impl Cull for Blind {
pub fn intersects(self: *Self, _: Vec3, _: Vec3) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: false
}
pub fn contains(self: *Self, _: Vec3, _: Vec3) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: false
}
}

pub fn infinite_bounds_and_frames_without_a_frustum_are_never_culled() void {
}
    // rust: let origin = Vec3::new(1.0e6, 0.0, 0.0);
    // rust: let infinite = [f32::NEG_INFINITY, 0.0, 0.0, f32::INFINITY, 1.0, 1.0];
    // rust: assert!(!in_frustum(Some(&Blind), origin, DEFAULT_BOUNDS));
    // rust: assert!(in_frustum(Some(&Blind), origin, infinite));
    // rust: assert!(in_frustum(None::<&Blind>, origin, DEFAULT_BOUNDS));
}

pub fn a_tint_keeps_its_channels_in_vertex_order() void {
}
        // The vertex colour is RGBA8 read little-endian: red in the low byte.
    // rust: assert_eq!(shaded(0x10_20_30, 1.0), 0xFF_30_20_10);
}

pub fn machine() M {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: ModBlockEntity::new(ModBlockEntityFields {
    // rust: id: "mymod:machine".into(),
    // rust: ..Default::default()
    // rust: })
    // rust: .revision()
}

pub fn vertex(x: f32) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Vertex {
    // rust: pos: [x, 0.0, 0.0],
    // rust: ..bytemuck::Zeroable::zeroed()
}
}

    // rust: const KEY: KeptKey = KeptKey {
    // rust: dim: Dim::Overworld,
    // rust: state: 7,
    // rust: light: 0xF0F0,
    // rust: glyphs: 0,
}

    /// A part drawn after `spin` turns about its pivot by the game time and
    /// partial tick (90 degrees a tick about +y takes +x to -z, by the right
    /// hand), its normal with it; what is drawn after `still` and before the
    /// spin stays; all of it is moved by the origin.
pub fn a_spinning_part_turns_with_the_game_time_and_the_rest_stays() void {
}
    // rust: let mut draw = draw();
    // rust: let at = |x: f32, y: f32, z: f32, normal: [i8; 4]| Vertex {
    // rust: pos: [x, y, z],
    // rust: normal,
    // rust: ..bytemuck::Zeroable::zeroed()
}
    // rust: draw.vertices.push(at(1.0, 0.5, 0.5, [0; 4]));
    // rust: draw.spin([0.0, 1.0, 0.0], [0.5, 0.5, 0.5], 90.0, 0.0);
    // rust: draw.vertices.push(at(1.0, 0.5, 0.5, [127, 0, 0, 127]));
    // rust: draw.still();
    // rust: draw.vertices.push(at(0.0, 0.0, 0.0, [0; 4]));
    // rust: let origin = Vec3::new(10.0, 0.0, 0.0);
    // rust: let close = |a: [f32; 3], b: [f32; 3]| a.iter().zip(b).all(|(a, b)| (a - b).abs() < 1e-4);
        // A tick and a half: 135 degrees.
    // rust: let mut out = Vec::new();
    // rust: place_turning(&draw.vertices, &draw.spins, 1, 0.5, origin, &mut out);
    // rust: assert!(close(out[0].pos, [11.0, 0.5, 0.5]), "{:?}", out[0].pos);
    // rust: let h = 0.5 * std::f32::consts::FRAC_1_SQRT_2;
    // rust: assert!(
    // rust: close(out[1].pos, [10.5 - h, 0.5, 0.5 - h]),
    // rust: "{:?}",
    // rust: out[1].pos
    // rust: );
    // rust: assert!(close(out[2].pos, [10.0, 0.0, 0.0]), "{:?}", out[2].pos);
        // One tick: a quarter turn, +x to -z, the normal along.
    // rust: out.clear();
    // rust: place_turning(&draw.vertices, &draw.spins, 1, 0.0, origin, &mut out);
    // rust: assert!(close(out[1].pos, [10.5, 0.5, 0.0]), "{:?}", out[1].pos);
    // rust: assert_eq!(out[1].normal, [0, 0, -127, 127]);
        // Four ticks: all the way round, and a world's late game time is no
        // less exact.
    // rust: out.clear();
    // rust: place_turning(
    // rust: &draw.vertices,
    // rust: &draw.spins,
    // rust: 4_000_000_000,
    // rust: 0.0,
    // rust: origin,
    // rust: &mut out,
    // rust: );
    // rust: assert!(close(out[1].pos, [11.0, 0.5, 0.5]), "{:?}", out[1].pos);
}

pub fn kept_geometry_is_drawn_again_until_what_it_was_drawn_with_changes() void {
}
    // rust: let mut kept = KeptGeometry::default();
    // rust: let pos = [1, 2, 3];
    // rust: let mut entity = ModBlockEntity::new(ModBlockEntityFields {
    // rust: id: "mymod:machine".into(),
    // rust: data: vec![0],
    // rust: ..Default::default()
    // rust: });
    // rust: let drawn = entity.revision();
    // rust: kept.keep(
    // rust: pos,
    // rust: KEY,
    // rust: drawn,
    // rust: DEFAULT_BOUNDS,
    // rust: &[vertex(0.5)],
    // rust: Vec::new(),
    // rust: 0,
    // rust: );
    // rust: let entry = kept.get(pos, KEY, entity.revision(), 1).expect("kept");
    // rust: assert_eq!(entry.vertices.len(), 1);
    // rust: assert_eq!(entry.vertices[0].pos, [0.5, 0.0, 0.0]);
    // rust: assert_eq!(entry.bounds, DEFAULT_BOUNDS);
        // New data from the server, another state, light or dimension, or
        // another position: none of them is the kept geometry.
    // rust: entity.data[0] = 1;
    // rust: assert!(kept.get(pos, KEY, entity.revision(), 1).is_none());
    // rust: for changed in [
    // rust: KeptKey { state: 8, ..KEY },
    // rust: KeptKey {
    // rust: light: 0x00F0,
    // rust: ..KEY
    // rust: },
    // rust: KeptKey {
    // rust: dim: Dim::Nether,
    // rust: ..KEY
    // rust: },
    // rust: KeptKey { glyphs: 1, ..KEY },
    // rust: ] {
    // rust: assert!(kept.get(pos, changed, drawn, 1).is_none());
}
    // rust: assert!(kept.get([1, 2, 4], KEY, drawn, 1).is_none());
        // Another block entity in its place, as the old one was: not it.
    // rust: let replaced = ModBlockEntity::new(ModBlockEntityFields {
    // rust: id: "mymod:machine".into(),
    // rust: data: vec![0],
    // rust: ..Default::default()
    // rust: });
    // rust: assert!(kept.get(pos, KEY, replaced.revision(), 1).is_none());
        // Drawn again and kept with the new data, it replaces the old.
    // rust: kept.keep(
    // rust: pos,
    // rust: KEY,
    // rust: entity.revision(),
    // rust: DEFAULT_BOUNDS,
    // rust: &[vertex(0.25)],
    // rust: Vec::new(),
    // rust: 2,
    // rust: );
    // rust: assert!(kept.get(pos, KEY, drawn, 2).is_none());
    // rust: let entry = kept
    // rust: .get(pos, KEY, entity.revision(), 2)
    // rust: .expect("kept again");
    // rust: assert_eq!(entry.vertices[0].pos, [0.25, 0.0, 0.0]);
        // Drawn without keeping: forgotten.
    // rust: kept.forget(pos);
    // rust: assert!(kept.get(pos, KEY, entity.revision(), 3).is_none());
}

pub fn kept_geometry_out_of_view_for_its_ticks_is_swept() void {
}
    // rust: let mut kept = KeptGeometry::default();
    // rust: let (seen, gone) = ([0, 0, 0], [5, 0, 0]);
    // rust: let m = machine();
    // rust: kept.keep(seen, KEY, m, DEFAULT_BOUNDS, &[vertex(0.0)], Vec::new(), 0);
    // rust: kept.keep(gone, KEY, m, DEFAULT_BOUNDS, &[vertex(0.0)], Vec::new(), 0);
    // rust: kept.get(gone, KEY, m, 50);
        // A sweep at 100 keeps both: each was drawn in the last 100 ticks.
    // rust: kept.sweep(100);
    // rust: assert!(kept.entries.contains_key(&gone));
    // rust: assert!(kept.entries.contains_key(&seen));
    // rust: kept.get(seen, KEY, m, 150);
        // At 199 no sweep is due yet; at 200 the one last drawn at 50 goes.
    // rust: kept.sweep(199);
    // rust: assert!(kept.entries.contains_key(&gone));
    // rust: kept.sweep(200);
    // rust: assert!(!kept.entries.contains_key(&gone));
    // rust: assert!(kept.get(seen, KEY, m, 200).is_some());
}
}
