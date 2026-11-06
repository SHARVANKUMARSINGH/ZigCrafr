//! Transpiled from Horizon Rust crate
package horizon_client_gui

import "core:fmt"
import "core:mem"
import "core:math"

// `GuiGraphics.renderItem` drawn into the HUD batch: the item's layers are
// submitted under the GUI item pose (`translate(x + 8, y + 8)`,
// `scale(16, -16, 16)`), lit with `Lighting.Entry.ITEMS_3D` or `ITEMS_FLAT`
// (`minecraft_mix_light` on the transformed normals), back faces culled,
// drawn far to near, and clipped to the item's 16x16 slot unless the model
// is oversized in the GUI (`GuiItemAtlas` draws each item into a scissored
// 16x16 slot; oversized items get a picture-in-picture of their bounds).
// use super::{Foil, Glint, ItemQuad, ItemRenderState, ItemRenderer, SpecialHost};
// use crate::cit::Rule;
// use crate::cit_glint::StackGlint;
// use crate::hud::cit_glint::{GlintTextures, layer_uv, vertex_color};
// use crate::hud::{HudBatch, Rect};
// use glam::{EulerRot, Mat4, Vec2, Vec3};
// use std::{collections::HashMap, f32::consts::PI, sync::Arc};

    // rust: mod depth;

// `Lighting.DIFFUSE_LIGHT_0` and `DIFFUSE_LIGHT_1`.
diffuse_lights :: proc() -> ( {
    // Ported from Horizon
    return {}
}
    // rust: (
    // rust: Vec3::new(0.2, 1.0, -0.7).normalize(),
    // rust: Vec3::new(-0.2, 1.0, 0.7).normalize(),
    // rust: )
}
// `Lighting.Entry.ITEMS_FLAT`: `rotationY(-PI/8).rotateX(3PI/4)`.
items_flat_lights :: proc() -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let m = Mat4::from_rotation_y(-PI / 8.0) * Mat4::from_rotation_x(PI * 3.0 / 4.0);
    // rust: let (a, b) = diffuse_lights();
    // rust: (m.transform_vector3(a), m.transform_vector3(b))
}
// JOML `rotateYXZ(y, x, z)`.
rotate_yxz :: proc(y: f32, x: f32, z: f32) -> M {
    // Ported from Horizon
    return {}
}
    // rust: Mat4::from_euler(EulerRot::YXZ, y, x, z)
}
// `Lighting.Entry.ITEMS_3D`.
items_3d_lights :: proc() -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let m = Mat4::from_scale(Vec3::new(1.0, -1.0, 1.0))
    // rust: * rotate_yxz(1.082_104_1, 3.237_585_8, 0.0)
    // rust: * rotate_yxz(-PI / 8.0, PI * 3.0 / 4.0, 0.0);
    // rust: let (a, b) = diffuse_lights();
    // rust: (m.transform_vector3(a), m.transform_vector3(b))
}

// A GUI-space vertex: position, atlas UV.
Point :: struct {
    p: Vec2,
    uv: [f32,
    glint_uv: [f32,
    cit_uv: [f32,
}
lerp :: proc(a: Point, b: Point, t: f32) -> P {
    // Ported from Horizon
    return {}
}
    // rust: Point {
    // rust: p: a.p + (b.p - a.p) * t,
    // rust: uv: [
    // rust: a.uv[0] + (b.uv[0] - a.uv[0]) * t,
    // rust: a.uv[1] + (b.uv[1] - a.uv[1]) * t,
    // rust: ],
    // rust: cit_uv: std::array::from_fn(|k| a.cit_uv[k] + (b.cit_uv[k] - a.cit_uv[k]) * t),
    // rust: glint_uv: [
    // rust: a.glint_uv[0] + (b.glint_uv[0] - a.glint_uv[0]) * t,
    // rust: a.glint_uv[1] + (b.glint_uv[1] - a.glint_uv[1]) * t,
    // rust: ],
}
}
// Sutherland-Hodgman against one half plane `dot(p, n) <= limit`.
clip_edge :: proc(poly: ^[Point], axis: uint, limit: f32, keep_below: bool) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let inside = |p: &Point| {
    // rust: let v = p.p[axis];
    // rust: if keep_below { v <= limit } else { v >= limit }
}
    // rust: let mut out = Vec::with_capacity(poly.len() + 2);
    // rust: for i in 0..poly.len() {
    // rust: let (a, b) = (poly[i], poly[(i + 1) % poly.len()]);
    // rust: let (ia, ib) = (inside(&a), inside(&b));
    // rust: if ia {
    // rust: out.push(a);
}
    // rust: if ia != ib {
    // rust: let t = (limit - a.p[axis]) / (b.p[axis] - a.p[axis]);
    // rust: out.push(lerp(a, b, t));
}
}
    // rust: out
}
// A triangle clipped to `[x0, x1] x [y0, y1]`, as a fan.
clip_triangle :: proc(tri: [Point; 3], rect: [f32; 4]) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut poly = tri.to_vec();
    // rust: for (axis, limit, below) in [
    // rust: (0, rect[0], false),
    // rust: (0, rect[2], true),
    // rust: (1, rect[1], false),
    // rust: (1, rect[3], true),
    // rust: ] {
    // rust: if poly.is_empty() {
    // rust: break;
}
    // rust: poly = clip_edge(&poly, axis, limit, below);
}
    // rust: poly
}

// RGBA vertex colour of a lit quad: `minecraft_mix_light` on the tint.
lit_color :: proc(q: ^ItemQuad, lights: (Vec3) {
}
    // rust: let light = crate::block_entity_render::diffuse(q.normal, lights);
    // rust: let [a, r, g, b] = q.color.to_be_bytes();
    // rust: let c = |v: u8| (f32::from(v) * light) as u8;
    // rust: crate::hud::rgba(c(r), c(g), c(b), a)
}
emit :: proc(batch: ^HudBatch, fan: ^[Point], color: impl Fn(Vec2) -> u {
    // Ported from Horizon
    return {}
}
    // rust: for i in 1..fan.len().saturating_sub(1) {
    // rust: let (a, b, c) = (fan[0], fan[i], fan[i + 1]);
    // rust: let corners = [a, b, c, c];
    // rust: if let Some(glint) = glint {
    // rust: let start = batch.vertices.len();
    // rust: batch.quad_glint(
    // rust: corners.map(|v| v.p.to_array()),
    // rust: corners.map(|v| [v.uv[0] + 2.0, v.uv[1]]),
    // rust: corners.map(|v| glint.uv(v.glint_uv)),
    // rust: u32::MAX,
    // rust: );
    // rust: batch.blend_since(start, crate::hud::Blend::Additive);
    // rust: } else {
    // rust: batch.quad(
    // rust: corners.map(|v| v.p.to_array()),
    // rust: corners.map(|v| v.uv),
    // rust: color(a.p),
    // rust: );
}
}
}

// A stack's OptiFine CIT glint layers this frame.
CitDraw :: struct {
    glint: ^'a StackGlint,
    textures: ^'a GlintTextures,
    rules: ^'a [Rule],
    millis: f32,
}

// The CIT glint layers over the item's clipped faces (`fans`, in draw order), bottom first:
// each layer is one run over all of them, blended as its rule says, at its intensity times
// the glint strength option (`HudBatch::glint_alpha`).
emit_cit :: proc(batch: ^HudBatch, fans: ^[[dynamic]Point], cit: CitDraw) {
}
    // rust: let seconds = f64::from(cit.millis) / 1000.0;
    // rust: for (i, layer) in cit.glint.layers.iter().enumerate() {
    // rust: let Some(slot) = cit.textures.slot_of.get(layer.rule).copied().flatten() else {
    // rust: continue;
}
    // rust: let Some(constants) = cit.textures.slots.get(usize::from(slot)) else {
    // rust: continue;
}
    // rust: let intensity = cit.glint.intensity(i, seconds) * batch.glint_alpha;
    // rust: if intensity <= 0.0 {
    // rust: continue;
}
    // rust: let glint = &cit.rules[layer.rule].glint;
    // rust: let color = vertex_color(slot, intensity);
    // rust: let uv = |v: Point| layer_uv(v.cit_uv, cit.millis, glint.speed, glint.rotation, 8.0);
    // rust: let start = batch.vertices.len();
    // rust: for fan in fans {
    // rust: for k in 1..fan.len().saturating_sub(1) {
    // rust: let corners = [fan[0], fan[k], fan[k + 1], fan[k + 1]];
    // rust: batch.quad_glint(
    // rust: corners.map(|v| v.p.to_array()),
    // rust: corners.map(|v| v.uv),
    // rust: corners.map(uv),
    // rust: color,
    // rust: );
}
}
    // rust: batch.blend_since(start, crate::hud::Blend::CitGlint(constants.blend));
}
}

// Submit, light, cull, sort and clip one item's quads into `batch` at GUI
// position `(x, y)`.
    // rust: pub fn draw(
    // rust: state: &ItemRenderState,
    // rust: renderer: &ItemRenderer,
    // rust: sprites: &HashMap<String, Rect>,
    // rust: host: &dyn SpecialHost,
    // rust: batch: &mut HudBatch,
    // rust: x: f32,
    // rust: y: f32,
    // rust: time: f32,
    // rust: glint_speed: f32,
    // rust: glint_alpha: f32,
    // rust: ) {
    // rust: if state.is_empty() {
    // rust: return;
}
    // A static item drawn where it was drawn before gives the same vertices:
    // take them instead of submitting, sorting and clipping its quads again.
    // rust: let key = DrawnKey::of(state, renderer, sprites, x, y);
    // rust: if let Some(key) = &key
    // rust: && let Some(drawn) = renderer
    // rust: .gui_drawn
    // rust: .lock()
    // rust: .ok()
    // rust: .and_then(|d| d.get(key).cloned())
    // rust: {
    // rust: batch.vertices.extend_from_slice(&drawn);
    // rust: return;
}
    // rust: let start = batch.vertices.len();
    // rust: draw_now(
    // rust: state,
    // rust: renderer,
    // rust: sprites,
    // rust: host,
    // rust: batch,
    // rust: x,
    // rust: y,
    // rust: time,
    // rust: glint_speed,
    // rust: glint_alpha,
    // rust: None,
    // rust: );
    // rust: if let Some(key) = key
    // rust: && let Ok(mut drawn) = renderer.gui_drawn.lock()
    // rust: {
        // GUI positions and items are few; a long scroll through every tab stays bounded.
    // rust: if drawn.len() >= DRAWN_LIMIT {
    // rust: drawn.clear();
}
    // rust: drawn.insert(key, batch.vertices[start..].into());
}
}

// [`draw`] clipped to `scissor` (`[x0, y0, x1, y1]`) as well as the item's slot:
// a list's scissor cuts the item of a half-visible row exactly. Not cached, the
// scissor is not part of the cache key.
    // rust: pub fn draw_scissored(
    // rust: state: &ItemRenderState,
    // rust: renderer: &ItemRenderer,
    // rust: sprites: &HashMap<String, Rect>,
    // rust: host: &dyn SpecialHost,
    // rust: batch: &mut HudBatch,
    // rust: x: f32,
    // rust: y: f32,
    // rust: scissor: [f32; 4],
    // rust: ) {
    // rust: if state.is_empty() {
    // rust: return;
}
    // rust: draw_now(
    // rust: state,
    // rust: renderer,
    // rust: sprites,
    // rust: host,
    // rust: batch,
    // rust: x,
    // rust: y,
    // rust: 0.0,
    // rust: 0.0,
    // rust: 0.0,
    // rust: Some(scissor),
    // rust: );
}

// Entries of `ItemRenderer::gui_drawn` before it starts over.
DRAWN_LIMIT :: 8192

// What a GUI item's vertices depend on: its layers' baked models (kept for the
// renderer's life, so their addresses name them), tints and transforms, the
// atlas, and the exact position. None for items whose drawing changes with time
// or the host: a glint, or a special model renderer.
    // rust: pub(crate) struct DrawnKey {
    // rust: renderer: usize,
    // rust: sprites: (usize, usize),
    // rust: at: [u32; 2],
    // rust: oversized: bool,
    // rust: layers: Vec<(usize, Vec<i32>, [u32; 16], bool)>,
}
    // rust: impl DrawnKey {
    // rust: fn of(
    // rust: state: &ItemRenderState,
    // rust: renderer: &ItemRenderer,
    // rust: sprites: &HashMap<String, Rect>,
    // rust: x: f32,
    // rust: y: f32,
    // rust: ) -> Option<Self> {
    // rust: if state.animated || state.cit_glint.is_some() {
    // rust: return None;
}
    // rust: let layers = state
    // rust: .layers
    // rust: .iter()
    // rust: .map(|layer| match &layer.geometry {
    // rust: super::LayerGeometry::Quads(baked) if layer.foil == super::FoilType::None => {
    // rust: Some((
    // rust: Arc::as_ptr(baked) as usize,
    // rust: layer.tints.clone(),
    // rust: layer.matrix.to_cols_array().map(f32::to_bits),
    // rust: layer.uses_block_light,
    // rust: ))
}
    // rust: _ => None,
    // rust: })
    // rust: .collect::<Option<Vec<_>>>()?;
    // rust: Some(Self {
    // rust: renderer: std::ptr::from_ref(renderer) as usize,
    // rust: sprites: (std::ptr::from_ref(sprites) as usize, sprites.len()),
    // rust: at: [x.to_bits(), y.to_bits()],
    // rust: oversized: state.oversized_in_gui,
    // rust: layers,
    // rust: })
}
}

// [`draw`] without the cache.
    // rust: fn draw_now(
    // rust: state: &ItemRenderState,
    // rust: renderer: &ItemRenderer,
    // rust: sprites: &HashMap<String, Rect>,
    // rust: host: &dyn SpecialHost,
    // rust: batch: &mut HudBatch,
    // rust: x: f32,
    // rust: y: f32,
    // rust: time: f32,
    // rust: glint_speed: f32,
    // rust: glint_alpha: f32,
    // rust: scissor: Option<[f32; 4]>,
    // rust: ) {
    // rust: let pose = Mat4::from_translation(Vec3::new(x + 8.0, y + 8.0, 0.0))
    // rust: * Mat4::from_scale(Vec3::new(16.0, -16.0, 16.0));
    // rust: let mut quads: Vec<ItemQuad> = Vec::new();
    // rust: state.submit(renderer, sprites, host, pose, &mut quads);
    // rust: let lights = if state.uses_block_light() {
    // rust: items_3d_lights()
    // rust: } else {
    // rust: items_flat_lights()
}
    // rust: let rect = if state.oversized_in_gui {
    // rust: [
    // rust: f32::NEG_INFINITY,
    // rust: f32::NEG_INFINITY,
    // rust: f32::INFINITY,
    // rust: f32::INFINITY,
    // rust: ]
    // rust: } else {
    // rust: [x, y, x + 16.0, y + 16.0]
}
    // rust: let rect = match scissor {
    // rust: Some([x0, y0, x1, y1]) => [
    // rust: rect[0].max(x0),
    // rust: rect[1].max(y0),
    // rust: rect[2].min(x1),
    // rust: rect[3].min(y1),
    // rust: ],
    // rust: None => rect,
}
    // rust: let glint = sprites
    // rust: .contains_key("misc/enchanted_glint_item")
    // rust: .then_some(Glint {
    // rust: speed: glint_speed,
    // rust: alpha: glint_alpha,
    // rust: millis: time * 1000.0,
    // rust: scale: 8.0,
    // rust: });
    // rust: batch.glint_alpha = glint_alpha;
    // rust: let cit = state.cit_glint.as_deref().zip(renderer.cit.as_ref());
    // rust: let cit = cit.map(|(glint, models)| CitDraw {
    // rust: glint,
    // rust: textures: &models.glint_textures,
    // rust: rules: &models.rules.rules,
    // rust: millis: time * 1000.0,
    // rust: });
    // rust: draw_quads_with(&quads, lights, batch, rect, glint.as_ref(), cit);
}

// Lights, culls, sorts far to near and clips `quads` (GUI positions) to
// `rect`.
    // rust: fn draw_quads(
    // rust: quads: &[ItemQuad],
    // rust: lights: (Vec3, Vec3),
    // rust: batch: &mut HudBatch,
    // rust: rect: [f32; 4],
    // rust: glint: Option<&Glint>,
    // rust: ) {
    // rust: draw_quads_with(quads, lights, batch, rect, glint, None);
}

// [`draw_quads`], then a stack's CIT glint layers over every face.
    // rust: fn draw_quads_with(
    // rust: quads: &[ItemQuad],
    // rust: lights: (Vec3, Vec3),
    // rust: batch: &mut HudBatch,
    // rust: rect: [f32; 4],
    // rust: glint: Option<&Glint>,
    // rust: cit: Option<CitDraw>,
    // rust: ) {
    // The faces the CIT layers go over once the item is drawn.
    // rust: let mut fans = Vec::new();
    // rust: for face in depth::sort(quads) {
    // rust: let q = &quads[face.quad];
    // rust: let points: Vec<_> = face
    // rust: .corners
    // rust: .iter()
    // rust: .map(|v| Point {
    // rust: p: v.pos.truncate(),
    // rust: uv: v.uv,
    // rust: glint_uv: v.glint_uv,
    // rust: cit_uv: v.cit_uv,
    // rust: })
    // rust: .collect();
    // rust: let color = lit_color(q, lights);
    // rust: for i in 1..points.len().saturating_sub(1) {
    // rust: let tri = [points[0], points[i], points[i + 1]];
    // rust: let fan = clip_triangle(tri, rect);
    // rust: if fan.len() < 3 {
    // rust: continue;
}
    // rust: emit(batch, &fan, |_| color, None);
    // rust: if q.foil != Foil::None {
    // rust: emit(batch, &fan, |_| color, glint);
}
    // rust: if cit.is_some() {
    // rust: fans.push(fan);
}
}
}
    // rust: if let Some(cit) = cit {
    // rust: emit_cit(batch, &fans, cit);
}
}

// `PictureInPictureRenderer.prepare` for the loom's 20x40 result rectangle
// at `(x0, y0)` (`translate(w / 2, h)`, `scale(16, 16, -16)`, one texel per
// GUI pixel), then `GuiBannerResultRenderer.renderToTexture`'s
// `translate(0, 0.25, 0)`.
banner_result_pose :: proc(x0: f32, y0: f32) -> M {
    // Ported from Horizon
    return {}
}
    // rust: Mat4::from_translation(Vec3::new(x0 + 10.0, y0 + 40.0, 0.0))
    // rust: * Mat4::from_scale(Vec3::new(16.0, 16.0, -16.0))
    // rust: * Mat4::from_translation(Vec3::new(0.0, 0.25, 0.0))
}

// The quads of `GuiGraphicsExtractor.bannerPattern` (the loom's result
// preview) at `(x0, y0)`: base dye and `(texture, dye)` layers.
    // rust: pub fn banner_result_quads(
    // rust: renderer: &ItemRenderer,
    // rust: sprites: &HashMap<String, Rect>,
    // rust: x0: f32,
    // rust: y0: f32,
    // rust: base: &str,
    // rust: layers: &[(String, String)],
    // rust: ) -> Vec<ItemQuad> {
    // rust: let mut quads = Vec::new();
    // rust: super::special::submit_banner_result(
    // rust: renderer,
    // rust: banner_result_pose(x0, y0),
    // rust: base,
    // rust: layers,
    // rust: sprites,
    // rust: &mut quads,
    // rust: );
    // rust: quads
}

// Draws the loom's result preview: the picture in picture is lit with
// `Lighting.Entry.ITEMS_FLAT` and holds only its 20x40 rectangle.
    // rust: pub fn draw_banner_result(
    // rust: renderer: &ItemRenderer,
    // rust: sprites: &HashMap<String, Rect>,
    // rust: batch: &mut HudBatch,
    // rust: x0: f32,
    // rust: y0: f32,
    // rust: base: &str,
    // rust: layers: &[(String, String)],
    // rust: ) {
    // rust: let quads = banner_result_quads(renderer, sprites, x0, y0, base, layers);
    // rust: draw_quads(
    // rust: &quads,
    // rust: items_flat_lights(),
    // rust: batch,
    // rust: [x0, y0, x0 + 20.0, y0 + 40.0],
    // rust: None,
    // rust: );
}

// `Lighting.Entry.ENTITY_IN_UI` (`setupForEntityInInventory`), which the
// enchanting screen's book is lit with.
entity_in_ui_lights :: proc() -> ( {
    // Ported from Horizon
    return {}
}
    // rust: (
    // rust: Vec3::new(0.2, -1.0, -1.0).normalize(),
    // rust: Vec3::new(-0.2, -1.0, 0.0).normalize(),
    // rust: )
}

// `PictureInPictureRenderer.prepare` for the enchanting screen's 38x31 book
// box at `(x0, y0)` (`translate(w / 2, 17)`, `scale(40, 40, -40)`), then
// `GuiBookModelRenderer.renderToTexture`'s turns for `open`.
enchanting_book_pose :: proc(x0: f32, y0: f32, open: f32) -> M {
    // Ported from Horizon
    return {}
}
    // rust: let closed = 1.0 - open;
    // rust: Mat4::from_translation(Vec3::new(x0 + 19.0, y0 + 17.0, 0.0))
    // rust: * Mat4::from_scale(Vec3::new(40.0, 40.0, -40.0))
    // rust: * Mat4::from_rotation_y(PI)
    // rust: * Mat4::from_rotation_x(25f32.to_radians())
    // rust: * Mat4::from_translation(Vec3::new(closed * 0.2, closed * 0.1, closed * 0.25))
    // rust: * Mat4::from_rotation_y((-closed * 90.0 - 90.0).to_radians())
    // rust: * Mat4::from_rotation_x(PI)
}

// `GuiBookModelRenderer.renderToTexture`'s page flips for `flip`: each
// `clamp(frac(flip + offset) * 1.6 - 0.3, 0, 1)`.
enchanting_book_pages :: proc(flip: f32) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let page = |offset: f32| {
    // rust: let x = flip + offset;
    // rust: ((x - x.floor()) * 1.6 - 0.3).clamp(0.0, 1.0)
}
    // rust: (page(0.25), page(0.75))
}

// `GuiGraphicsExtractor.book` from `EnchantmentScreen.extractBook`: the
// enchanting table's book, `open` (0 to 1) and turning its pages with
// `flip`, in the 38x31 box at `(x0, y0)`.
    // rust: pub fn draw_enchanting_book(
    // rust: renderer: &ItemRenderer,
    // rust: sprites: &HashMap<String, Rect>,
    // rust: batch: &mut HudBatch,
    // rust: x0: f32,
    // rust: y0: f32,
    // rust: open: f32,
    // rust: flip: f32,
    // rust: ) {
    // rust: let (page1, page2) = enchanting_book_pages(flip);
    // rust: let mut quads = Vec::new();
    // rust: super::special::submit_book(
    // rust: renderer,
    // rust: enchanting_book_pose(x0, y0, open),
    // rust: open,
    // rust: page1,
    // rust: page2,
    // rust: sprites,
    // rust: &mut quads,
    // rust: );
    // rust: draw_quads(
    // rust: &quads,
    // rust: entity_in_ui_lights(),
    // rust: batch,
    // rust: [x0, y0, x0 + 38.0, y0 + 31.0],
    // rust: None,
    // rust: );
}

    // rust: mod tests {
//     use super::*;

enchanting_book_pages_turn_with_the_flip :: proc() {
}
    // rust: let close = |flip: f32, want: (f32, f32)| {
    // rust: let (a, b) = enchanting_book_pages(flip);
    // rust: assert!(
    // rust: (a - want.0).abs() < 1e-5 && (b - want.1).abs() < 1e-5,
    // rust: "{flip}: {a} {b}, want {want:?}"
    // rust: );
}
    // rust: close(0.0, (0.1, 0.9));
        // A whole page further, the same pages.
    // rust: close(1.0, (0.1, 0.9));
    // rust: close(0.5, (0.9, 0.1));
        // The pages rest flat at either end of a turn.
    // rust: close(-0.25, (0.0, 0.5));
    // rust: close(0.6875, (1.0, 0.4));
}
a_closed_book_turns_away_and_an_open_one_faces_the_screen :: proc() {
}
        // The box centre maps the model origin; the book's origin moves with
        // `open` (`translate((1 - open) * (0.2, 0.1, 0.25))` before the turn).
    // rust: let open = enchanting_book_pose(0.0, 0.0, 1.0).transform_point3(Vec3::ZERO);
    // rust: assert!(
    // rust: (open - Vec3::new(19.0, 17.0, 0.0)).length() < 1e-4,
    // rust: "{open}"
    // rust: );
    // rust: let closed = enchanting_book_pose(0.0, 0.0, 0.0).transform_point3(Vec3::ZERO);
    // rust: assert!((closed - open).length() > 1.0, "{closed}");
}

face :: proc(y0: f32, y1: f32, z: impl Fn(f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: ItemQuad {
    // rust: pos: [(0.0, y0), (0.0, y1), (8.0, y1), (8.0, y0)].map(|(x, y)| Vec3::new(x, y, z(y))),
    // rust: uv: [[0.0, 0.0], [0.0, 1.0], [1.0, 1.0], [1.0, 0.0]],
    // rust: foil_uv: [[0.0, 0.0], [0.0, 1.0], [1.0, 1.0], [1.0, 0.0]],
    // rust: gui_glint_uv: None,
    // rust: normal: Vec3::Z,
    // rust: color,
    // rust: foil: Foil::None,
    // rust: light_emission: 0,
    // rust: cull_back: false,
    // rust: translucent: false,
    // rust: oit: false,
}
}

    // Sample the emitted triangles in draw order, using opaque test faces.
color_at :: proc(batch: ^HudBatch, p: Vec2) -> O {
    // Ported from Horizon
    return {}
}
    // rust: batch
    // rust: .vertices
    // rust: .as_chunks::<3>()
    // rust: .0
    // rust: .iter()
    // rust: .rev()
    // rust: .find_map(|tri| {
    // rust: let [a, b, c] = std::array::from_fn(|i| Vec2::from(tri[i].pos));
    // rust: let area = (b - a).perp_dot(c - a);
    // rust: if area.abs() < 1e-6 {
    // rust: return None;
}
    // rust: let u = (b - p).perp_dot(c - p) / area;
    // rust: let v = (c - p).perp_dot(a - p) / area;
    // rust: let w = 1.0 - u - v;
    // rust: (u >= 0.0 && v >= 0.0 && w >= 0.0).then_some(tri[0].color)
    // rust: })
}

banner_cloth_occludes_the_support_at_the_top_edge :: proc() {
}
        // The cloth is nearer where it overlaps the bar, although its
        // average depth is farther away because it slopes along its height.
    // rust: let bar = face(0.0, 1.0, |_| 0.0, 0xFF80_4000);
    // rust: let cloth = face(0.0, 8.0, |y| 2.0 - y, 0xFFFF_FFFF);
    // rust: let mut batch = HudBatch::new([320, 240]);
    // rust: draw_quads(
    // rust: &[bar, cloth],
    // rust: (Vec3::Z, Vec3::Z),
    // rust: &mut batch,
    // rust: [0.0, 0.0, 16.0, 16.0],
    // rust: None,
    // rust: );
    // rust: assert_eq!(color_at(&batch, Vec2::new(4.0, 0.5)), Some(u32::MAX));
}

intersecting_faces_change_draw_order_at_their_intersection :: proc() {
}
    // rust: let flat = face(0.0, 8.0, |_| 0.0, 0xFFFF_0000);
    // rust: let tilted = face(0.0, 8.0, |y| y - 4.0, 0xFF00_00FF);
    // rust: for quads in [[flat, tilted], [tilted, flat]] {
    // rust: let mut batch = HudBatch::new([320, 240]);
    // rust: draw_quads(
    // rust: &quads,
    // rust: (Vec3::Z, Vec3::Z),
    // rust: &mut batch,
    // rust: [0.0, 0.0, 16.0, 16.0],
    // rust: None,
    // rust: );
    // rust: assert_eq!(
    // rust: color_at(&batch, Vec2::new(4.0, 2.0)),
    // rust: Some(lit_color(&flat, (Vec3::Z, Vec3::Z)))
    // rust: );
    // rust: assert_eq!(
    // rust: color_at(&batch, Vec2::new(4.0, 6.0)),
    // rust: Some(lit_color(&tilted, (Vec3::Z, Vec3::Z)))
    // rust: );
            // The cut must interpolate the texture along with the position.
    // rust: for v in &batch.vertices {
    // rust: assert!((v.uv[0] - v.pos[0] / 8.0).abs() < 1e-6);
    // rust: assert!((v.uv[1] - v.pos[1] / 8.0).abs() < 1e-6);
}
}
}

coplanar_pattern_layers_keep_submission_order :: proc() {
}
    // rust: let base = face(0.0, 8.0, |y| 2.0 - y, 0xFFFF_FFFF);
    // rust: let pattern = ItemQuad {
    // rust: color: 0xFF00_00FF,
    // rust: ..base
}
    // rust: let quads = [face(0.0, 1.0, |_| 0.0, 0xFF80_4000), base, pattern];
    // rust: let mut batch = HudBatch::new([320, 240]);
    // rust: draw_quads(
    // rust: &quads,
    // rust: (Vec3::Z, Vec3::Z),
    // rust: &mut batch,
    // rust: [0.0, 0.0, 16.0, 16.0],
    // rust: None,
    // rust: );
    // rust: for y in [0.5, 6.0] {
    // rust: assert_eq!(
    // rust: color_at(&batch, Vec2::new(4.0, y)),
    // rust: Some(lit_color(&quads[2], (Vec3::Z, Vec3::Z)))
    // rust: );
}
}

cit_layers_draw_once_over_the_whole_item :: proc() {
}
//         use crate::cit_glint::Global;
//         use crate::hud::Blend;
//         use crate::hud::cit_glint::Slot;
//         use horizon_optifine::Properties;
    // rust: let rule = |name: &str, text: &str| {
    // rust: let path = format!("assets/minecraft/optifine/cit/{name}.properties");
    // rust: let text = format!("type=enchantment\ntexture=glint\n{text}");
    // rust: Rule::parse(&path, &Properties::parse_equals_first(&text), |_| true).unwrap()
}
    // rust: let rules = [
    // rust: rule("shown", ""),
    // rust: rule("fire", "layer=1\nenchantments=fire_aspect"),
    // rust: ];
        // Shared by level, and the stack has no Fire Aspect: that layer is at intensity 0.
    // rust: let global = Global::parse(&Properties::parse_equals_first("method=average"));
    // rust: let glint = StackGlint::new(&rules, &[0, 1], &[("minecraft:sharpness", 3)], &global);
    // rust: assert_eq!(glint.layers.len(), 2);
    // rust: let slot = |blend| Slot {
    // rust: rgba: [1.0; 4],
    // rust: blur: false,
    // rust: blend,
}
    // rust: let textures = GlintTextures {
    // rust: width: 1,
    // rust: height: 1,
    // rust: slot_of: vec![Some(1), Some(0)],
    // rust: slots: vec![slot(0), slot(1)],
    // rust: ..GlintTextures::default()
}
    // rust: let cit = CitDraw {
    // rust: glint: &glint,
    // rust: textures: &textures,
    // rust: rules: &rules,
    // rust: millis: 0.0,
}
    // rust: let mut batch = HudBatch::new([320, 240]);
    // rust: batch.glint_alpha = 0.5;
    // rust: let mut quad = face(0.0, 8.0, |_| 0.0, 0xFFFF_FFFF);
    // rust: quad.gui_glint_uv = Some([[42.0, 42.0]; 4]);
    // rust: draw_quads_with(
    // rust: &[quad],
    // rust: (Vec3::Z, Vec3::Z),
    // rust: &mut batch,
    // rust: [0.0, 0.0, 16.0, 16.0],
    // rust: None,
    // rust: Some(cit),
    // rust: );
        // The square's two triangles, then the one layer over both: six vertices a triangle.
    // rust: assert_eq!(batch.vertices.len(), 24);
    // rust: assert_eq!(
    // rust: batch.runs(),
    // rust: [(0..12, Blend::Alpha), (12..24, Blend::CitGlint(1))]
    // rust: );
    // rust: for v in &batch.vertices[12..] {
            // Slot 1 in red; full intensity at half the glint strength in alpha.
    // rust: assert_eq!(v.color.to_le_bytes(), [1, 0, 0, 128]);
    // rust: assert_eq!(v.glint_uv, v.pos, "CIT retains the sprite-local UVs");
}
}

flat_lights_match_joml :: proc() {
}
        // new Matrix4f().rotationY(-PI/8).rotateX(3PI/4).transformDirection(L0).
    // rust: let (l0, _) = items_flat_lights();
    // rust: let l = Vec3::new(0.2, 1.0, -0.7).normalize();
    // rust: let (s, c) = ((3.0 * PI / 4.0).sin(), (3.0 * PI / 4.0).cos());
    // rust: let rx = Vec3::new(l.x, c * l.y - s * l.z, s * l.y + c * l.z);
    // rust: let (s, c) = ((-PI / 8.0).sin(), (-PI / 8.0).cos());
    // rust: let ry = Vec3::new(c * rx.x + s * rx.z, rx.y, -s * rx.x + c * rx.z);
    // rust: assert!((l0 - ry).length() < 1e-6);
}
triangles_clip_to_the_slot :: proc() {
}
    // rust: let p = |x: f32, y: f32| Point {
    // rust: p: Vec2::new(x, y),
    // rust: uv: [x, y],
    // rust: glint_uv: [0.0, 0.0],
    // rust: cit_uv: [0.0, 0.0],
}
    // rust: let fan = clip_triangle(
    // rust: [p(-4.0, 0.0), p(8.0, 0.0), p(8.0, 8.0)],
    // rust: [0.0, 0.0, 16.0, 16.0],
    // rust: );
    // rust: assert!(fan.iter().all(|v| v.p.x >= 0.0));
        // UVs follow the cut affinely.
    // rust: assert!(fan.iter().all(|v| (v.uv[0] - v.p.x).abs() < 1e-6));
    // rust: assert!(
    // rust: clip_triangle(
    // rust: [p(20.0, 0.0), p(30.0, 0.0), p(30.0, 5.0)],
    // rust: [0.0, 0.0, 16.0, 16.0]
    // rust: )
    // rust: .is_empty()
    // rust: );
}
}
