//! Transpiled from Horizon Rust crate
//! Module: horizon-client_fx
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Companions, trails and auras ([docs/cosmetics.md](../../../../../docs/cosmetics.md)): worn
//! like the other cosmetics but on no bone. A companion floats beside its wearer and follows with
//! a lag (`horizon_cosmetics::follow`), drawn with the wearer; a trail's particles
//! (`horizon_cosmetics::trail`) and an aura blend, so they go after every player in one
//! see-through span (`cosmetics_fx_geometry`). Nothing of them is an entity, collides or is sent
//! to a server.

// use super::{FULL_LIGHT, OWN};
// use crate::game::Game;
// use glam::{DVec3, Mat4, Vec3};
// use horizon_client::mesher::Vertex;
// use horizon_client::mobs::anim::Poses;
// use horizon_client::mobs::{Mob, Part};
// use horizon_cosmetics::follow::{self, Follow};
// use horizon_cosmetics::trail::Emitter;
// use horizon_cosmetics::{Item, Slot};
// use std::sync::Arc;

/// How far from the camera (blocks) a wearer's companion, trail and aura are drawn.
pub const FAR: f32 = 48.0;

/// Who wears it, as drawn this frame.
    // rust: pub(super) struct Wearer<'a> {
    // rust: pub m: &'a Mob,
    /// The player's own model.
    // rust: pub own: bool,
    /// `OWN`, or the entity id.
    // rust: pub key: u32,
    /// The wearer's model matrix (`render::base_transform`), relative to `camera`.
    // rust: pub base: Mat4,
    // rust: pub camera: DVec3,
    // rust: pub alpha: f32,
    // rust: pub light: u32,
}

/// `m`'s head yaw this frame (degrees).
pub fn head_yaw(m: *Mob, alpha: f32) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let turn = horizon_client::mobs::living::wrap(m.head_yaw - m.previous_head_yaw);
    // rust: m.previous_head_yaw + turn * alpha
}

/// Whether `m` lies in a bed.
pub fn asleep(m: *Mob) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: m.extra.avatar_pose == horizon_client::pose::Pose::Sleeping
}

/// Where a companion floats: `at` (relative to the camera) facing `yaw`, at the wearer's scale,
/// in the model space the item's file uses (y down).
pub fn companion_matrix(at: Vec3, yaw: f32, scale: f32) M {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Mat4::from_translation(at)
    // rust: * Mat4::from_rotation_y((180.0 - yaw).to_radians())
    // rust: * Mat4::from_scale(Vec3::new(-scale, -scale, scale))
}

    // rust: impl Game<'_> {
    /// A companion, trail or aura `at` wears: a companion goes where the wearer's other items go
    /// (`gpu` and `out`, `bounds` grown), trails and auras to the frame's see-through vertices.
    /// Other players' trails and auras stay hidden with "Hide other players' trails and auras".
    // rust: pub(super) fn cosmetics_fx(
    // rust: &self,
    // rust: at: &Wearer,
    // rust: item: &Arc<Item>,
    // rust: gpu: bool,
    // rust: bounds: Option<(Vec3, Vec3)>,
    // rust: poses: &mut Poses,
    // rust: out: &mut Vec<Vertex>,
    // rust: ) -> Option<(Vec3, Vec3)> {
    // rust: if !at.own && item.slot.is_effect() && self.settings.extras.cosmetics_hide_fx {
    // rust: return bounds;
}
        // Past `FAR` a companion, trail or aura is a few pixels across for the cost of a model:
        // not drawn, and a trail that isn't drawn doesn't spawn (its particles go back to the
        // budget).
    // rust: if at.base.w_axis.truncate().length_squared() > FAR * FAR {
    // rust: return bounds;
}
    // rust: match item.slot {
    // rust: Slot::Companion => {
    // rust: let Some((model, uv, matrix)) = self.companion_at(at, item, None) else {
    // rust: return bounds;
}
    // rust: self.pose_companion(item, at.m, at.alpha, poses, &model);
    // rust: let glow = item.companion.as_ref().is_some_and(|c| c.glow);
    // rust: let light = if glow { FULL_LIGHT } else { at.light };
    // rust: self.cosmetics_model(&model, matrix, poses, uv, light, gpu, bounds, out)
}
    // rust: Slot::Trail => {
    // rust: self.trail(at, item);
    // rust: bounds
}
    // rust: Slot::Aura => {
    // rust: self.aura(at, item, poses);
    // rust: bounds
}
    // rust: _ => bounds,
}
}

    /// The companion's model, texture and matrix this frame, its follow moved on once a frame.
    /// `first_person`: the camera's forward and left, for the player's own in first person: the
    /// companion keeps out of the middle of the view.
    // rust: fn companion_at(
    // rust: &self,
    // rust: at: &Wearer,
    // rust: item: &Arc<Item>,
    // rust: first_person: Option<(Vec3, Vec3)>,
    // rust: ) -> Option<(Arc<Part>, [f32; 4], Mat4)> {
    // rust: let c = item.companion.as_ref()?;
    // rust: let (models, uv) = self.cosmetics_baked(item)?;
    // rust: let model = models.first()?.1.clone();
    // rust: let scale = at.base.x_axis.truncate().length();
    // rust: let target = at.base.transform_point3(Vec3::from(c.anchor) / 16.0);
    // rust: let head = at
    // rust: .base
    // rust: .transform_point3(Vec3::from(horizon_cosmetics::HEAD) / 16.0);
    // rust: let yaw = head_yaw(at.m, at.alpha);
    // rust: let follow = self.companion_follow(at.key, at.camera + target.as_dvec3(), yaw, c.lag);
    // rust: let clearance = (horizon_cosmetics::HEAD_CLEARANCE + c.reach) / 16.0 * scale;
    // rust: let mut rel = (follow.pos - at.camera).as_vec3();
    // rust: if let Some((forward, left)) = first_person {
    // rust: rel = follow::out_of_view(rel, forward, left);
}
    // rust: rel = follow::clear_of(rel, head, clearance);
    // rust: Some((model, uv, companion_matrix(rel, follow.yaw, scale)))
}

    /// The companion of wearer `key` moved toward `target` (once a frame, however many times it
    /// is drawn).
pub fn companion_follow(self: *Self, key: u32, target: DVec3, yaw: f32, lag: f32) F {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let frame = self.cosmetics.frame.get();
    // rust: let mut fx = self.cosmetics.fx.borrow_mut();
    // rust: let dt = fx.dt;
    // rust: let (f, mark) = fx
    // rust: .companions
    // rust: .entry(key)
    // rust: .or_insert((Follow::at(target, yaw), frame));
    // rust: if *mark != frame {
    // rust: f.step(target, yaw, lag, dt);
    // rust: *mark = frame;
}
    // rust: *f
}

    /// The companion's animations, and its `look` part turned with the wearer's pitch.
pub fn pose_companion(self: *Self, item: *Item, m: *Mob, alpha: f32, poses: *mut Poses, model: *Part) void {
}
    // rust: poses.reset(model);
    // rust: item.animate(m.age as f32 + alpha, |name, pose| *poses.get(name) = pose);
    // rust: if let Some(look) = item.companion.as_ref().and_then(|c| c.look.as_deref()) {
    // rust: let pitch = m.previous_head_pitch + (m.head_pitch - m.previous_head_pitch) * alpha;
    // rust: poses.get(look)[3] += (pitch * 0.6).clamp(-30.0, 30.0).to_radians();
}
}

    /// The trail's particles: spawned once a frame by the distance walked (not while sneaking or
    /// asleep), facing the camera.
pub fn trail(self: *Self, at: *Wearer, item: **Item) void {
}
    // rust: let Some(t) = &item.trail else {
    // rust: return;
}
    // rust: let Some((_, uv)) = self.cosmetics_baked(item) else {
    // rust: return;
}
    // rust: let m = at.m;
    // rust: let a = f64::from(at.alpha);
    // rust: let feet = DVec3::new(
    // rust: m.previous.x + (m.position.x - m.previous.x) * a,
    // rust: m.previous.y + (m.position.y - m.previous.y) * a,
    // rust: m.previous.z + (m.position.z - m.previous.z) * a,
    // rust: );
    // rust: let moves = !m.extra.crouching && !asleep(m);
    // rust: let q = self.camera_orientation();
    // rust: let (right, up) = (q * Vec3::X, q * Vec3::Y);
    // rust: let light = if t.glow { FULL_LIGHT } else { at.light };
    // rust: let frame = self.cosmetics.frame.get();
    // rust: let mut fx = self.cosmetics.fx.borrow_mut();
    // rust: let super::Fx {
    // rust: trails,
    // rust: budget,
    // rust: now,
    // rust: clear,
    // rust: ..
    // rust: } = &mut *fx;
    // rust: let (e, mark) = trails
    // rust: .entry(at.key)
    // rust: .or_insert_with(|| (Emitter::default(), frame.wrapping_sub(1)));
    // rust: if *mark != frame {
    // rust: e.step(t, feet, moves, *now, budget);
    // rust: *mark = frame;
}
    // rust: for quad in e.quads(t, *now, at.camera, right, up) {
    // rust: let color = ((quad.alpha.clamp(0.0, 1.0) * 255.0) as u32) << 24 | 0x00FF_FFFF;
    // rust: for (corner, [u, v]) in quad.corners.iter().zip(quad.uv) {
    // rust: clear.push(Vertex {
    // rust: pos: corner.to_array(),
    // rust: uv: [uv[0] + (uv[2] - uv[0]) * u, uv[1] + (uv[3] - uv[1]) * v],
    // rust: layer: 0,
    // rust: color,
    // rust: light,
                    // Unlit: a particle keeps its colour whichever way it faces.
    // rust: normal: [0, 0, 0, 0],
    // rust: glint_uv: [0.0, 0.0],
    // rust: });
}
}
}

    /// The aura at the wearer's feet, see-through. None while they fly, swim or sleep: it would
    /// tip over with the body.
pub fn aura(self: *Self, at: *Wearer, item: **Item, poses: *mut Poses) void {
}
    // rust: let (m, Some(a)) = (at.m, &item.aura) else {
    // rust: return;
}
    // rust: if m.extra.fall_flying || asleep(m) || m.extra.swim.amount(at.alpha) > 0.0 {
    // rust: return;
}
    // rust: let Some((models, uv)) = self.cosmetics_baked(item) else {
    // rust: return;
}
    // rust: let Some((_, model)) = models.first() else {
    // rust: return;
}
        // The model's origin is the middle of the feet: 24 pixels under the neck.
    // rust: let matrix = at.base * Mat4::from_translation(Vec3::new(0.0, 24.0 / 16.0, 0.0));
    // rust: poses.reset(model);
    // rust: item.animate(m.age as f32 + at.alpha, |name, pose| {
    // rust: *poses.get(name) = pose
    // rust: });
    // rust: let light = if a.glow { FULL_LIGHT } else { at.light };
    // rust: let mut fx = self.cosmetics.fx.borrow_mut();
    // rust: let start = fx.clear.len();
    // rust: horizon_client::mobs::render_model(
    // rust: model,
    // rust: matrix,
    // rust: &|p: &Part| poses.pose(p),
    // rust: uv,
    // rust: light,
    // rust: 0,
    // rust: &mut fx.clear,
    // rust: );
    // rust: let color = ((a.alpha * 255.0) as u32) << 24 | 0x00FF_FFFF;
    // rust: for v in &mut fx.clear[start..] {
    // rust: v.color = color;
            // Seen through, a face turned away would add to the near one (and a card's two
            // faces would double it): `entity.wgsl` drops back faces, so it is `alpha` at most.
    // rust: v.normal[3] = horizon_client::mesher::SHADED_CULL_W;
}
}

    /// After every player: the player's own companion in first person (out of the middle of the
    /// view, after the first-person model went to the shadow pass only), then the frame's trails
    /// and auras in one see-through span.
    // rust: pub(in crate::game) fn cosmetics_fx_geometry(
    // rust: &self,
    // rust: camera: DVec3,
    // rust: alpha: f64,
    // rust: out: &mut Vec<Vertex>,
    // rust: ) {
    // rust: if !horizon_cosmetics::enabled() {
    // rust: return;
}
    // rust: if !self.own_body_in_view()
    // rust: && let Some(m) = self.player_model.as_ref()
    // rust: {
    // rust: self.mark_entity(out.len(), "minecraft:player");
    // rust: self.own_companion_first_person(m, camera, alpha as f32, out);
}
    // rust: let fx = self.cosmetics.fx.borrow();
    // rust: if !fx.clear.is_empty() {
    // rust: self.mark_translucent_entity(out.len(), "minecraft:player");
    // rust: out.extend_from_slice(&fx.clear);
}
}

    // rust: fn own_companion_first_person(
    // rust: &self,
    // rust: m: &Mob,
    // rust: camera: DVec3,
    // rust: alpha: f32,
    // rust: out: &mut Vec<Vertex>,
    // rust: ) {
    // rust: if horizon_client::mobs::trader::is_invisible(m) || self.own_invisible() {
    // rust: return;
}
    // rust: let Some(worn) = self.worn(m, true) else {
    // rust: return;
}
    // rust: let Some(item) = worn.iter().find(|i| i.slot == Slot::Companion) else {
    // rust: return;
}
    // rust: let at = Wearer {
    // rust: m,
    // rust: own: true,
    // rust: key: OWN,
    // rust: base: horizon_client::mobs::render::base_transform(m, alpha, camera),
    // rust: camera,
    // rust: alpha,
    // rust: light: FULL_LIGHT,
}
    // rust: let (yaw, pitch) = (self.yaw.to_radians(), self.pitch.to_radians());
    // rust: let forward = Vec3::new(
    // rust: -yaw.sin() * pitch.cos(),
    // rust: -pitch.sin(),
    // rust: yaw.cos() * pitch.cos(),
    // rust: );
    // rust: let left = Vec3::new(yaw.cos(), 0.0, yaw.sin());
    // rust: let Some((model, uv, matrix)) = self.companion_at(&at, item, Some((forward, left))) else {
    // rust: return;
}
        // Lit where it floats.
    // rust: let p = (camera + matrix.w_axis.truncate().as_dvec3()).floor();
    // rust: let light = self.world.light(p.x as i32, p.y as i32, p.z as i32);
    // rust: let mut light = (u32::from(light >> 4) * 16) | ((u32::from(light & 15) * 16) << 8);
    // rust: if item.companion.as_ref().is_some_and(|c| c.glow) {
    // rust: light = FULL_LIGHT;
}
    // rust: let mut poses = self.cosmetics.poses.borrow_mut();
    // rust: let poses = &mut poses.1;
    // rust: self.pose_companion(item, m, alpha, poses, &model);
    // rust: self.cosmetics_model(&model, matrix, poses, uv, light, false, None, out);
}
}
