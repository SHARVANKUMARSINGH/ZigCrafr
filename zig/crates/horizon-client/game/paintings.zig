//! Transpiled from Horizon Rust crate
//! Module: horizon-client_paintings
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Paintings: `HangingEntityItem.useOn` placement with `Painting.create`'s
//! variant choice (or the stack's `painting/variant`), `HangingEntity.survives`
//! checks every 100 ticks, breaking by attack (`dropItem`), saving, and
//! `PaintingRenderer` quads.
// use super::{Game, Hit, entity_culling::default_range};
// use horizon_client::{entities::Painting, items::ItemStack, mesher::Vertex};
// use horizon_core::{
    // rust: geometry::{Aabb, Vec3},
    // rust: random::RandomSource,
}
// use std::sync::Arc;

/// A `painting_variant` and whether `#placeable` lists it (in tag order).
    // rust: pub(super) struct Variant {
    // rust: pub id: Arc<str>,
    // rust: pub asset: String,
    // rust: pub width: i32,
    // rust: pub height: i32,
    /// `PaintingVariant.title` and `author`: text components.
    // rust: pub title: Option<serde_json::Value>,
    // rust: pub author: Option<serde_json::Value>,
}
/// Variants by id plus the `#minecraft:placeable` list.
    // rust: pub(super) struct PaintingVariants {
    // rust: pub all: Vec<Variant>,
    // rust: pub placeable: Vec<Arc<str>>,
}
    // rust: impl PaintingVariants {
pub fn load(root: *std::path::Path) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let data = root.join("data/minecraft");
    // rust: let mut all = Vec::new();
    // rust: if let Ok(folder) = horizon_world::json_folder::read(&data.join("painting_variant")) {
    // rust: for file in &folder.files {
    // rust: let name = file.name.as_str();
    // rust: let Ok(v) =
    // rust: serde_json::from_slice::<serde_json::Value>(file.bytes().unwrap_or_default())
    // rust: else {
    // rust: continue;
}
    // rust: all.push(Variant {
    // rust: id: Arc::from(format!("minecraft:{name}")),
    // rust: asset: v["asset_id"]
    // rust: .as_str()
    // rust: .unwrap_or(name)
    // rust: .trim_start_matches("minecraft:")
    // rust: .to_owned(),
    // rust: width: v["width"].as_i64().unwrap_or(1) as i32,
    // rust: height: v["height"].as_i64().unwrap_or(1) as i32,
    // rust: title: v.get("title").cloned(),
    // rust: author: v.get("author").cloned(),
    // rust: });
}
}
    // rust: let placeable =
    // rust: horizon_core::prepared_files::read(&data.join("tags/painting_variant/placeable.json"))
    // rust: .ok()
    // rust: .and_then(|b| serde_json::from_slice::<serde_json::Value>(&b).ok())
    // rust: .and_then(|v| v["values"].as_array().cloned())
    // rust: .unwrap_or_default()
    // rust: .iter()
    // rust: .filter_map(|v| v.as_str().map(Arc::from))
    // rust: .collect();
    // rust: Self { all, placeable }
}
pub fn get(self: *Self, id: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.all.iter().find(|v| &*v.id == id)
}
    /// The variant a stack's `painting/variant` component names.
pub fn of_stack(self: *Self, stack: *ItemStack) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let id = horizon_client::save::text(stack.data()?.other("minecraft:painting/variant"))?;
    // rust: self.get(&horizon_world::datafix::dynamic::namespaced(&id))
}
}
pub fn overlaps(a: ([f64; 3]) void {
}
    // rust: (0..3).all(|i| a.0[i] < b.1[i] && b.0[i] < a.1[i])
}

/// `HangingEntityItem.mayPlace` for a painting: not a floor or ceiling.
/// Direction.get2DDataValue: south 0, west 1, north 2, east 3.
pub fn painting_facing(face: [i32; 3]) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if face[1] != 0 {
    // rust: return None;
}
    // rust: Some(match face {
    // rust: [0, 0, 1] => 0,
    // rust: [-1, 0, 0] => 1,
    // rust: [0, 0, -1] => 2,
    // rust: _ => 3,
    // rust: })
}
/// Whether the camera, at the origin of `corners`' space, is on the side of the quad
/// that `normal` points to.
pub fn faces_camera(corners: *[glam::DVec3; 4], normal: glam::DVec3) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let centre = (corners[0] + corners[1] + corners[2] + corners[3]) / 4.0;
    // rust: normal.dot(-centre) > 0.0
}

    // rust: impl Game<'_> {
    /// `HangingEntity.survives`: no block collision in the box, solid blocks
    /// (or diodes) behind it and no other painting overlapping it.
    // rust: pub(super) fn painting_survives(&self, p: &Painting) -> bool {
    // rust: let (lo, hi) = p.bounds();
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
        // calculateSupportBox: moved half a block into the wall, deflated.
    // rust: let s = p.step().map(f64::from);
    // rust: let (slo, shi) = (
    // rust: std::array::from_fn::<f64, 3, _>(|i| lo[i] - s[i] * 0.5 + 1.0e-7),
    // rust: std::array::from_fn::<f64, 3, _>(|i| hi[i] - s[i] * 0.5 - 1.0e-7),
    // rust: );
    // rust: for x in slo[0].floor() as i32..=shi[0].floor() as i32 {
    // rust: for y in slo[1].floor() as i32..=shi[1].floor() as i32 {
    // rust: for z in slo[2].floor() as i32..=shi[2].floor() as i32 {
    // rust: let f = self.res.facts().get(self.world.block(x, y, z));
    // rust: if !(f.legacy_solid || f.has_class("DiodeBlock")) {
    // rust: return false;
}
}
}
}
    // rust: !self
    // rust: .paintings
    // rust: .iter()
    // rust: .any(|o| o.id != p.id && overlaps(o.bounds(), (lo, hi)))
}
    /// `HangingEntityItem.useOn` on a client level: SUCCESS once
    /// `Painting.create` finds a surviving variant (and the stack's
    /// `painting/variant`, if any, also survives). The random pick and
    /// spawn are the server's.
    // rust: pub(super) fn painting_fits(&self, hit: &Hit, stack: &ItemStack) -> bool {
    // rust: if &*stack.item != "minecraft:painting" {
    // rust: return false;
}
    // rust: let Some(facing) = painting_facing(hit.face) else {
    // rust: return false;
}
    // rust: let pos = [
    // rust: hit.pos[0] + hit.face[0],
    // rust: hit.pos[1],
    // rust: hit.pos[2] + hit.face[2],
    // rust: ];
    // rust: let mut candidate = Painting {
    // rust: id: self.next_entity.wrapping_add(1),
    // rust: pos,
    // rust: facing,
    // rust: variant: Arc::from(""),
    // rust: width: 1,
    // rust: height: 1,
    // rust: check_interval: 0,
}
    // rust: let mut any = false;
    // rust: for id in &self.painting_variants.placeable {
    // rust: let Some(v) = self.painting_variants.get(id) else {
    // rust: continue;
}
    // rust: (candidate.width, candidate.height) = (v.width, v.height);
    // rust: if self.painting_survives(&candidate) {
    // rust: any = true;
    // rust: break;
}
}
    // rust: if !any {
    // rust: return false;
}
    // rust: if let Some(v) = self.painting_variants.of_stack(stack).cloned() {
    // rust: (candidate.variant, candidate.width, candidate.height) = (v.id, v.width, v.height);
    // rust: return self.painting_survives(&candidate);
}
    // rust: true
}
    /// `HangingEntityItem.useOn` for a painting against `hit`'s face.
    // rust: pub(super) fn place_painting(&mut self, hit: &Hit, stack: &ItemStack) -> bool {
    // rust: if &*stack.item != "minecraft:painting" {
    // rust: return false;
}
        // HangingEntityItem.mayPlace: never on a top or bottom face (FAIL).
    // rust: let Some(facing) = painting_facing(hit.face) else {
    // rust: self.use_failed = true;
    // rust: return true;
}
    // rust: let pos = [
    // rust: hit.pos[0] + hit.face[0],
    // rust: hit.pos[1],
    // rust: hit.pos[2] + hit.face[2],
    // rust: ];
    // rust: self.next_entity += 1;
    // rust: let mut candidate = Painting {
    // rust: id: self.next_entity,
    // rust: pos,
    // rust: facing,
    // rust: variant: Arc::from(""),
    // rust: width: 1,
    // rust: height: 1,
    // rust: check_interval: 0,
}
        // Painting.create: the largest placeable variants that survive, one at random.
    // rust: let mut fitting: Vec<Variant> = Vec::new();
    // rust: for id in self.painting_variants.placeable.clone() {
    // rust: let Some(v) = self.painting_variants.get(&id).cloned() else {
    // rust: continue;
}
    // rust: (candidate.width, candidate.height) = (v.width, v.height);
    // rust: if self.painting_survives(&candidate) {
    // rust: fitting.push(v);
}
}
        // Nothing fits: CONSUME, which ItemStack.useOn still counts as a use.
    // rust: let Some(largest) = fitting.iter().map(|v| v.width * v.height).max() else {
    // rust: self.award_stat("used", &stack.item, 1);
    // rust: return true;
}
    // rust: fitting.retain(|v| v.width * v.height >= largest);
        // Util.getRandomSafe(variants, candidate.random): the painting's own random.
    // rust: let pick = super::dispenser::entity_random()
    // rust: .next_int_bound(fitting.len() as i32)
    // rust: .unwrap_or(0) as usize;
    // rust: let v = &fitting[pick];
    // rust: (candidate.variant, candidate.width, candidate.height) = (v.id.clone(), v.width, v.height);
        // EntityType.createDefaultStackConfig -> Painting.applyImplicitComponents:
        // the stack's `painting/variant` replaces the random pick, and that
        // painting has to survive where it goes (else the use is CONSUME).
    // rust: if let Some(v) = self.painting_variants.of_stack(stack).cloned() {
    // rust: (candidate.variant, candidate.width, candidate.height) = (v.id, v.width, v.height);
    // rust: if !self.painting_survives(&candidate) {
    // rust: self.award_stat("used", &stack.item, 1);
    // rust: return true;
}
}
    // rust: if self.hanging_place_cancelled("minecraft:painting", pos) {
    // rust: return true;
}
    // rust: let (lo, hi) = candidate.bounds();
    // rust: let at = [
    // rust: (lo[0] + hi[0]) / 2.0,
    // rust: (lo[1] + hi[1]) / 2.0,
    // rust: (lo[2] + hi[2]) / 2.0,
    // rust: ];
    // rust: self.audio
    // rust: .play("minecraft:entity.painting.place", Some(at), 1.0, 1.0);
        // HangingEntityItem.useOn: ENTITY_PLACE at the painting, by the player, before it is
        // added; ItemStack.useOn then counts the use.
    // rust: let ctx = self.player_context(None);
    // rust: self.post_game_event("minecraft:entity_place", at, ctx);
    // rust: self.paintings.push(candidate);
    // rust: self.world.modified.insert((pos[0] >> 4, pos[2] >> 4));
    // rust: if !self.creative {
    // rust: self.consume_held();
}
    // rust: self.award_stat("used", &stack.item, 1);
        // HangingEntityItem.useOn returns SUCCESS: the hand swings.
    // rust: self.swing_arm();
    // rust: true
}
    /// The painting under the crosshair within reach and its distance.
    // rust: pub(super) fn painting_hit(&self) -> Option<(usize, f64)> {
    // rust: let (eye, dir) = self.aim()?;
    // rust: let reach: f64 = self.entity_reach;
    // rust: let mut best: Option<(usize, f64)> = None;
    // rust: for (i, p) in self.paintings.iter().enumerate() {
    // rust: let (lo, hi) = p.bounds();
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
    /// `Painting.hurtServer` -> kill and `dropItem`. False when a mod kept it
    /// (`native_hanging_break`): it stays at `index`.
    // rust: pub(super) fn break_painting(&mut self, index: usize, by_player: bool) -> bool {
    // rust: let pos = self.paintings[index].pos;
    // rust: if self.hanging_break_cancelled("minecraft:painting", pos, by_player) {
    // rust: return false;
}
    // rust: let p = self.paintings.remove(index);
    // rust: let (lo, hi) = p.bounds();
    // rust: let at = [
    // rust: (lo[0] + hi[0]) / 2.0,
    // rust: (lo[1] + hi[1]) / 2.0,
    // rust: (lo[2] + hi[2]) / 2.0,
    // rust: ];
    // rust: self.world.modified.insert((p.pos[0] >> 4, p.pos[2] >> 4));
    // rust: if !self.ui.rules.bool("entity_drops") {
    // rust: return true;
}
    // rust: self.audio
    // rust: .play("minecraft:entity.painting.break", Some(at), 1.0, 1.0);
    // rust: if by_player && self.creative {
    // rust: return true;
}
        // HangingEntity.spawnAtLocation: 0.15 out from the wall.
    // rust: let s = p.step().map(f64::from);
    // rust: let stack = ItemStack {
    // rust: item: Arc::from("minecraft:painting"),
    // rust: count: 1,
    // rust: damage: 0,
    // rust: extra: None,
}
    // rust: self.spawn_item(
    // rust: stack,
    // rust: [at[0] + s[0] * 0.15, at[1], at[2] + s[2] * 0.15],
    // rust: [0.0; 3],
    // rust: 10,
    // rust: );
    // rust: true
}
    /// BlockAttachedEntity.tick: check survival every 100 ticks.
    // rust: pub(super) fn tick_paintings(&mut self) {
        // ServerLevel.tick: only entities in entity-ticking chunks tick.
    // rust: let ticking = self.entity_ticking_area();
    // rust: let mut i = 0;
    // rust: while i < self.paintings.len() {
    // rust: let (lo, hi) = self.paintings[i].bounds();
    // rust: let centre = [0, 2].map(|k| ((lo[k] + hi[k]) / 2.0).floor() as i32);
    // rust: if !ticking(centre[0], centre[1]) {
    // rust: i += 1;
    // rust: continue;
}
    // rust: self.paintings[i].check_interval += 1;
    // rust: if self.paintings[i].check_interval >= 100 {
    // rust: self.paintings[i].check_interval = 0;
    // rust: let p = self.paintings[i].clone();
    // rust: if !self.painting_survives(&p) && self.break_painting(i, false) {
    // rust: continue;
}
}
    // rust: i += 1;
}
}
    /// PaintingRenderer: the variant on the front, the back texture behind and
    /// on the edges.
    // rust: pub(super) fn painting_geometry(&self, camera: glam::DVec3, out: &mut Vec<Vertex>) {
    // rust: let sprites = &self.gui.atlas.sprites;
    // rust: let Some(back) = sprites.get("painting/back").copied() else {
    // rust: return;
}
    // rust: for p in &self.paintings {
            // EntityRenderer.shouldRender: the default range and its box,
            // measured from the box's centre (HangingEntity's position).
    // rust: let (lo, hi) = p.bounds();
    // rust: let (lo, hi) = (glam::DVec3::from(lo), glam::DVec3::from(hi));
    // rust: let range = default_range(hi - lo, self.view_scale());
    // rust: if !self.entity_in_view(camera, (lo + hi) / 2.0, range, lo, hi) {
    // rust: continue;
}
    // rust: let culling = self.entity_cull_decision(p, 1.0);
    // rust: if culling.hides_entity() {
    // rust: continue;
}
    // rust: let Some(v) = self.painting_variants.get(&p.variant) else {
    // rust: continue;
}
    // rust: let Some(front) = sprites.get(&format!("painting/{}", v.asset)).copied() else {
    // rust: continue;
}
    // rust: let (lo, hi) = p.bounds();
    // rust: let c = glam::DVec3::new(
    // rust: (lo[0] + hi[0]) / 2.0,
    // rust: (lo[1] + hi[1]) / 2.0,
    // rust: (lo[2] + hi[2]) / 2.0,
    // rust: ) - camera;
    // rust: let s = p.step().map(f64::from);
    // rust: let l = p.left().map(f64::from);
    // rust: let out_dir = glam::DVec3::new(s[0], 0.0, s[2]);
            // The viewer's right is the painting's left.
    // rust: let right = glam::DVec3::new(l[0], 0.0, l[2]);
    // rust: let up = glam::DVec3::Y;
    // rust: let (hw, hh, d) = (
    // rust: f64::from(p.width) / 2.0,
    // rust: f64::from(p.height) / 2.0,
    // rust: 1.0 / 32.0,
    // rust: );
    // rust: let entity_start = out.len();
    // rust: let light = self.world.light(p.pos[0], p.pos[1], p.pos[2]);
    // rust: let packed = (u32::from(light >> 4) * 16) | ((u32::from(light & 15) * 16) << 8);
    // rust: let mut quad =
    // rust: |corners: [glam::DVec3; 4], normal: glam::DVec3, uv: [[f32; 2]; 4], shade: f32| {
                    // Back faces are culled, as the entity pipeline culls them: inside the
                    // painting's box nothing of it shows. `corners` are relative to the camera.
    // rust: if !faces_camera(&corners, normal) {
    // rust: return;
}
    // rust: let k = (255.0 * shade) as u32;
    // rust: let color = 0xFF00_0000 | k << 16 | k << 8 | k;
    // rust: for (p, uv) in corners.iter().zip(uv) {
    // rust: out.push(Vertex {
    // rust: normal: [0; 4],
    // rust: pos: p.as_vec3().to_array(),
    // rust: uv,
    // rust: layer: 0,
    // rust: color,
    // rust: light: packed,

    // rust: glint_uv: [0.0, 0.0],
    // rust: });
}
}
    // rust: let full = |r: horizon_client::hud::Rect| {
    // rust: [[r.u0, r.v1], [r.u1, r.v1], [r.u1, r.v0], [r.u0, r.v0]]
}
    // rust: let f = c + out_dir * d;
    // rust: quad(
    // rust: [
    // rust: f - right * hw - up * hh,
    // rust: f + right * hw - up * hh,
    // rust: f + right * hw + up * hh,
    // rust: f - right * hw + up * hh,
    // rust: ],
    // rust: out_dir,
    // rust: full(front),
    // rust: 1.0,
    // rust: );
    // rust: let b = c - out_dir * d;
    // rust: quad(
    // rust: [
    // rust: b + right * hw - up * hh,
    // rust: b - right * hw - up * hh,
    // rust: b - right * hw + up * hh,
    // rust: b + right * hw + up * hh,
    // rust: ],
    // rust: -out_dir,
    // rust: full(back),
    // rust: 0.8,
    // rust: );
            // Edges: a one-pixel strip of the back texture.
    // rust: let strip = [
    // rust: [back.u0, back.v0 + (back.v1 - back.v0) / 16.0],
    // rust: [back.u1, back.v0 + (back.v1 - back.v0) / 16.0],
    // rust: [back.u1, back.v0],
    // rust: [back.u0, back.v0],
    // rust: ];
    // rust: let (t, bt) = (up * hh, -up * hh);
    // rust: quad(
    // rust: [
    // rust: b + t + right * hw,
    // rust: b + t - right * hw,
    // rust: f + t - right * hw,
    // rust: f + t + right * hw,
    // rust: ],
    // rust: up,
    // rust: strip,
    // rust: 1.0,
    // rust: );
    // rust: quad(
    // rust: [
    // rust: f + bt + right * hw,
    // rust: f + bt - right * hw,
    // rust: b + bt - right * hw,
    // rust: b + bt + right * hw,
    // rust: ],
    // rust: -up,
    // rust: strip,
    // rust: 0.5,
    // rust: );
    // rust: quad(
    // rust: [
    // rust: b - right * hw - up * hh,
    // rust: f - right * hw - up * hh,
    // rust: f - right * hw + up * hh,
    // rust: b - right * hw + up * hh,
    // rust: ],
    // rust: -right,
    // rust: strip,
    // rust: 0.6,
    // rust: );
    // rust: quad(
    // rust: [
    // rust: f + right * hw - up * hh,
    // rust: b + right * hw - up * hh,
    // rust: b + right * hw + up * hh,
    // rust: f + right * hw + up * hh,
    // rust: ],
    // rust: right,
    // rust: strip,
    // rust: 0.6,
    // rust: );
    // rust: self.finish_entity_occlusion(culling, p, out, entity_start);
}
}
}

    // rust: mod tests {
//     use super::*;

    /// `HangingEntityItem.useOn` returns SUCCESS (the hand swings) when a
    /// painting is created on a wall. Floor, ceiling, or a failed create is
    /// CONSUME: no swing.
pub fn painting_use_on_swings(face: [i32; 3], created: bool) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: painting_facing(face).is_some() && created
}

pub fn placing_a_painting_on_a_wall_swings() void {
}
    // rust: assert!(painting_use_on_swings([0, 0, 1], true));
    // rust: assert!(painting_use_on_swings([-1, 0, 0], true));
    // rust: assert!(painting_use_on_swings([0, 0, -1], true));
    // rust: assert!(painting_use_on_swings([1, 0, 0], true));
    // rust: assert!(!painting_use_on_swings([0, 1, 0], true));
    // rust: assert!(!painting_use_on_swings([0, -1, 0], true));
    // rust: assert!(!painting_use_on_swings([0, 0, 1], false));
}
}

    // rust: mod face_tests {
//     use super::faces_camera;
//     use glam::DVec3;

    /// A quad at z = 2 facing -z (towards a camera at the origin) shows; seen from behind
    /// (the camera on the other side, the quad now at z = -2) it does not.
pub fn a_quad_shows_only_to_the_side_it_faces() void {
}
    // rust: let at = |z: f64| {
    // rust: [
    // rust: DVec3::new(-1.0, -1.0, z),
    // rust: DVec3::new(1.0, -1.0, z),
    // rust: DVec3::new(1.0, 1.0, z),
    // rust: DVec3::new(-1.0, 1.0, z),
    // rust: ]
}
    // rust: let normal = DVec3::new(0.0, 0.0, -1.0);
    // rust: assert!(faces_camera(&at(2.0), normal));
    // rust: assert!(!faces_camera(&at(-2.0), normal));
        // Edge on: nothing to draw.
    // rust: assert!(!faces_camera(&at(0.0), normal));
}
}
