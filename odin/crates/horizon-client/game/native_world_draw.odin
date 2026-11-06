//! Transpiled from Horizon Rust crate
package horizon_client_native_world_draw

import "core:fmt"
import "core:mem"
import "core:math"

// A native mod's world-space text and atlas quads, through the normal renderer.
// use super::{Game, native_block_entity_draw::BlockEntityDraw};
// use glam::{DVec3, Mat4, Vec3};
// use horizon_client::{
    // rust: font::Patch,
    // rust: gfx::{WORLD_TEXT_OVERLAY, WORLD_TEXT_POLYGON_OFFSET_OVERLAY},
    // rust: hud::{HudBatch, Rect, rgba},
    // rust: mesher::Vertex,
    // rust: text::Text,
}
// use std::ops::{Deref, DerefMut};

// One world frame, independently of block entities or source blocks. Its pose
// starts camera-relative and shares `BlockEntityDraw`'s push/pop, translate,
// rotate and scale operations, partial tick, game time and packed light.
// `keep` does not cache a world canvas. API @API:world_canvas@.
NativeWorldDraw :: struct {
    camera: [f64,
    draw: BlockEntityDraw,
    patches: [dynamic]Patch,
    profiles: [dynamic]serde_json::Value,
}
    // rust: impl Deref for NativeWorldDraw {
    // rust: type Target = BlockEntityDraw;
deref :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &self.draw
}
}
    // rust: impl DerefMut for NativeWorldDraw {
deref_mut :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &mut self.draw
}
}
    // rust: impl NativeWorldDraw {
new :: proc(camera: [f64; 3], partial: f32, time: i64) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: camera,
    // rust: draw: BlockEntityDraw::posed(
    // rust: partial,
    // rust: time,
    // rust: 240 | 240 << 8,
    // rust: [0; 3],
    // rust: Mat4::IDENTITY,
    // rust: (Vec3::Y, Vec3::Y),
    // rust: Vec::new(),
    // rust: ),
    // rust: patches: Vec::new(),
    // rust: profiles: Vec::new(),
}
}
    // Translate to a world position, subtracting the camera in f64 first.
    // Returns false without changing the pose for a non-finite offset.
translate_world :: proc(self: ^Self, position: [f64; 3]) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let offset = (DVec3::from_array(position) - DVec3::from_array(self.camera)).as_vec3();
    // rust: if !offset.is_finite() {
    // rust: return false;
}
    // rust: self.draw.translate(offset.to_array());
    // rust: true
}
quad :: proc(self: ^Self, sprite: Rect, corners: [[f32; 3]; 4], uv: [f32; 4], color: [u8; 4]) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let pose = self.draw.pose();
    // rust: if !pose.is_finite()
    // rust: || !corners.iter().flatten().all(|v| v.is_finite())
    // rust: || !uv.iter().all(|v| v.is_finite())
    // rust: {
    // rust: return false;
}
    // rust: let [u0, v0, u1, v1] = uv.map(|v| v / 16.0);
    // rust: let points = corners.map(|point| pose.transform_point3(Vec3::from_array(point)));
    // rust: if points.iter().any(|point| !point.is_finite()) {
    // rust: return false;
}
    // rust: let light = self.draw.light;
    // rust: for (point, [u, v]) in points
    // rust: .into_iter()
    // rust: .zip([[u0, v0], [u0, v1], [u1, v1], [u1, v0]])
    // rust: {
    // rust: self.draw.vertices_mut().push(Vertex {
    // rust: pos: point.to_array(),
    // rust: uv: [
    // rust: sprite.u0 + (sprite.u1 - sprite.u0) * u,
    // rust: sprite.v0 + (sprite.v1 - sprite.v0) * v,
    // rust: ],
    // rust: layer: WORLD_TEXT_OVERLAY,
    // rust: color: u32::from_le_bytes(color),
    // rust: light,
    // rust: normal: [0; 4],
    // rust: glint_uv: [0.0; 2],
    // rust: });
}
    // rust: true
}
text :: proc(self: ^Self, batch: HudBatch, front: Maybe(uint)) {
}
    // rust: let pose = self.draw.pose();
    // rust: let light = self.draw.light;
    // rust: if pose.is_finite() {
    // rust: for (index, quad) in batch.vertices.as_chunks::<6>().0.iter().enumerate() {
    // rust: for i in horizon_client::text_display::CORNERS {
    // rust: let vertex = quad[i];
    // rust: self.draw.vertices_mut().push(Vertex {
    // rust: pos: pose
    // rust: .transform_point3(Vec3::new(vertex.pos[0], vertex.pos[1], vertex.depth))
    // rust: .to_array(),
    // rust: uv: vertex.uv,
    // rust: color: vertex.color,
    // rust: light,
    // rust: layer: if front.is_some_and(|start| index * 6 >= start) {
    // rust: WORLD_TEXT_POLYGON_OFFSET_OVERLAY
    // rust: } else {
    // rust: WORLD_TEXT_OVERLAY
    // rust: },
    // rust: normal: [0; 4],
    // rust: glint_uv: [0.0; 2],
    // rust: });
}
}
}
    // rust: self.patches.extend(batch.patches);
    // rust: self.profiles.extend(batch.inline_profiles);
}
}
    // rust: impl Game<'_> {
    // rust: pub(super) fn native_world_geometry(
    // rust: &mut self,
    // rust: camera: DVec3,
    // rust: partial: f32,
    // rust: out: &mut Vec<Vertex>,
    // rust: ) {
    // rust: if !horizon_client::gfx::native_render::world_drawn_hooked()
    // rust: && crate::mod_api::mods().is_empty()
    // rust: {
    // rust: return;
}
    // rust: let mut draw = NativeWorldDraw::new(camera.to_array(), partial, self.world.game_time);
        // NONE keeps these quads out of shader-pack entity programs.
    // rust: self.mark_stage(out.len(), "NONE");
    // rust: self.native_world_submit(&mut draw);
    // rust: self.resolve_inline_profiles(&draw.profiles);
    // rust: self.map_patches.extend(draw.patches);
    // rust: out.extend(draw.draw.into_vertices());
}
    // Normal, depth-tested atlas quad under the current pose. UVs use 16
    // texels per sprite side; color is [red, green, blue, alpha]. No model
    // diffuse lighting is applied; `draw.light` still selects lightmap light.
    // False for an unknown sprite or non-finite geometry. API @API:world_canvas@.
    // rust: pub(super) fn native_world_quad(
    // rust: &self,
    // rust: draw: &mut NativeWorldDraw,
    // rust: sprite: &str,
    // rust: corners: [[f32; 3]; 4],
    // rust: uv: [f32; 4],
    // rust: color: [u8; 4],
    // rust: ) -> bool {
    // rust: self.gui
    // rust: .atlas
    // rust: .sprites
    // rust: .get(sprite)
    // rust: .copied()
    // rust: .is_some_and(|sprite| draw.quad(sprite, corners, uv, color))
}
    // Actual styled world font at (0,0), with ARGB default color and optional
    // eight-offset ARGB outline. Returns the text advance in font pixels.
    // The front of outlined text uses POLYGON_OFFSET. API @API:world_canvas@.
    // rust: pub(super) fn native_world_text(
    // rust: &self,
    // rust: draw: &mut NativeWorldDraw,
    // rust: text: &Text,
    // rust: color: u32,
    // rust: outline: Option<u32>,
    // rust: ) -> f32 {
    // rust: let packed = |c: u32| rgba((c >> 16) as u8, (c >> 8) as u8, c as u8, (c >> 24) as u8);
    // rust: let mut batch = HudBatch::new([1, 1]);
    // rust: let (advance, front) = if let Some(outline) = outline {
    // rust: let (advance, front) = batch.text_styled_outline_world(
    // rust: &self.gui.atlas,
    // rust: text,
    // rust: 0.0,
    // rust: 0.0,
    // rust: packed(color),
    // rust: packed(outline),
    // rust: );
    // rust: (advance, Some(front))
    // rust: } else {
    // rust: (
    // rust: batch.text_styled_world(&self.gui.atlas, text, 0.0, 0.0, packed(color), false),
    // rust: None,
    // rust: )
}
    // rust: draw.text(batch, front);
    // rust: advance
}
}

    // rust: mod tests {
//     use super::*;
world_quad_preserves_sub_block_precision_rgba_uv_and_pose :: proc() {
}
    // rust: let mut frame = NativeWorldDraw::new([30_000_000.125, 64.0, -30_000_000.5], 0.5, 123);
    // rust: assert!(frame.translate_world([30_000_000.625, 65.0, -30_000_000.25]));
    // rust: frame.scale([2.0, 3.0, 4.0]);
    // rust: frame.light = 0x12_34;
    // rust: assert!(frame.quad(
    // rust: Rect {
    // rust: w: 16,
    // rust: h: 16,
    // rust: u0: 0.25,
    // rust: v0: 0.5,
    // rust: u1: 0.75,
    // rust: v1: 1.0
    // rust: },
    // rust: [
    // rust: [0.0, 0.0, 0.0],
    // rust: [0.0, 1.0, 0.0],
    // rust: [1.0, 1.0, 0.0],
    // rust: [1.0, 0.0, 0.0]
    // rust: ],
    // rust: [4.0, 0.0, 12.0, 8.0],
    // rust: [12, 34, 56, 78]
    // rust: ));
    // rust: let vertices = frame.draw.into_vertices();
    // rust: assert_eq!(
    // rust: vertices.iter().map(|v| v.pos).collect::<Vec<_>>(),
    // rust: [
    // rust: [0.5, 1.0, 0.25],
    // rust: [0.5, 4.0, 0.25],
    // rust: [2.5, 4.0, 0.25],
    // rust: [2.5, 1.0, 0.25]
    // rust: ]
    // rust: );
    // rust: assert_eq!(
    // rust: vertices.iter().map(|v| v.uv).collect::<Vec<_>>(),
    // rust: [[0.375, 0.5], [0.375, 0.75], [0.625, 0.75], [0.625, 0.5]]
    // rust: );
    // rust: assert!(
    // rust: vertices
    // rust: .iter()
    // rust: .all(|v| v.color.to_le_bytes() == [12, 34, 56, 78]
    // rust: && v.light == 0x12_34
    // rust: && v.normal == [0; 4])
    // rust: );
}
invalid_world_offsets_leave_the_pose_usable :: proc() {
}
    // rust: let mut frame = NativeWorldDraw::new([0.0; 3], 0.0, 0);
    // rust: assert!(!frame.translate_world([f64::NAN, 0.0, 0.0]));
    // rust: assert!(!frame.translate_world([f64::MAX, 0.0, 0.0]));
    // rust: assert!(frame.translate_world([1.0, 2.0, 3.0]));
    // rust: assert_eq!(
    // rust: frame.draw.pose().transform_point3(Vec3::ZERO),
    // rust: Vec3::new(1.0, 2.0, 3.0)
    // rust: );
}
}
