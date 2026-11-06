//! Transpiled from Horizon Rust crate
//! Module: horizon-client_debug_renderers
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The debug options screen's renderer entries (26.3 `DebugRenderer`): the
//! water levels, heightmaps, collision boxes, light levels and sturdy faces
//! around the camera. Lines join the debug gizmos; fills and billboard texts
//! go with the entities' translucent geometry, as the test markers do.
//!
//! No-ops, for want of the data: `chunk_section_paths`,
//! `chunk_section_octree` and `chunk_section_visibility` (Horizon culls on
//! the GPU, with no section occlusion graph or octree),
//! `visualize_chunks_on_server` (the server's chunk statuses),
//! `visualize_sky_light_sections` (the light engine's section data) and
//! `visualize_entity_supporting_blocks` (`Entity.mainSupportingBlockPos`).
// use super::Game;
// use horizon_client::{
    // rust: block_entity_render::vertex_light,
    // rust: debug_chart::srgb_lerp,
    // rust: gizmos::{self as g, Gizmos},
    // rust: hud::HudBatch,
    // rust: hud_layout::abgr,
    // rust: mesher::Vertex,
    // rust: text::Text,
}
// use horizon_core::{geometry::Vec3, position::BlockPos};
// use horizon_world::{collision_context::CollisionContext, heightmap::HeightmapType};

/// `WaterDebugRenderer`'s fill: `ARGB.colorFromFloat(0.15F, 0, 1, 0)`.
pub const WATER_FILL: u32 = 0x2600_FF00;
/// `SolidFaceRenderer`'s fill (-2130771968).
pub const SOLID_FACE_FILL: u32 = 0x80FF_0000;
/// `TextGizmo.Style.DEFAULT_SCALE`.
pub const TEXT_SCALE: f32 = 0.32;
/// `HeightMapRenderer.BOX_HEIGHT`.
pub const BOX_HEIGHT: f64 = 0.09375;

/// `HeightMapRenderer.getColor`, for the client chunk's heightmaps.
pub fn heightmap_color(kind: HeightmapType) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match kind {
    // rust: HeightmapType::WorldSurfaceWg => 0xFFFF_FF00,
    // rust: HeightmapType::OceanFloorWg => 0xFFFF_00FF,
    // rust: HeightmapType::WorldSurface => 0xFF00_B200,
    // rust: HeightmapType::OceanFloor => 0xFF00_007F,
    // rust: HeightmapType::MotionBlocking => 0xFF00_4C4C,
    // rust: HeightmapType::MotionBlockingNoLeaves => 0xFF00_7F7F,
}
}

/// `BlockPos.betweenClosed` of the cube `radius` around `center`.
pub fn cube(center: [i32; 3], radius: i32) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let r = -radius..=radius;
    // rust: r.clone().flat_map(move |dy| {
    // rust: let r = r.clone();
    // rust: r.clone().flat_map(move |dz| {
    // rust: r.clone()
    // rust: .map(move |dx| [center[0] + dx, center[1] + dy, center[2] + dz])
    // rust: })
    // rust: })
}

    // rust: impl Game<'_> {
    /// `CollisionBoxRenderer`: the block collisions within 6 of the camera
    /// entity's box, white.
    // rust: pub(super) fn debug_renderer_gizmos(&self, g: &mut Gizmos) {
    // rust: if !self.debug_entry("visualize_collision_boxes") {
    // rust: return;
}
    // rust: let Some(p) = &self.player else {
    // rust: return;
}
    // rust: let bounds = p.bounds().inflate(Vec3::new(6.0, 6.0, 6.0));
    // rust: let (lo, hi) = (bounds.min_position(), bounds.max_position());
    // rust: let mut scene = horizon_client::collisions::SceneCollisions {
    // rust: world: &self.world,
    // rust: binding: self.collision,
    // rust: subject: None,
}
    // rust: for y in lo.y.floor() as i32..=hi.y.floor() as i32 {
    // rust: for z in lo.z.floor() as i32..=hi.z.floor() as i32 {
    // rust: for x in lo.x.floor() as i32..=hi.x.floor() as i32 {
    // rust: let Ok(shape) = self.collision.collision_shape_with_context(
    // rust: &mut scene,
    // rust: self.world.block(x, y, z),
    // rust: BlockPos::new(x, y, z),
    // rust: &CollisionContext::empty(false),
    // rust: ) else {
    // rust: continue;
}
    // rust: let at = [f64::from(x), f64::from(y), f64::from(z)];
    // rust: for b in shape.boxes() {
    // rust: let (min, max) = (b.min_position(), b.max_position());
    // rust: g.cuboid(
    // rust: [at[0] + min.x, at[1] + min.y, at[2] + min.z],
    // rust: [at[0] + max.x, at[1] + max.y, at[2] + max.z],
    // rust: g::WHITE,
    // rust: g::STROKE_WIDTH,
    // rust: );
}
}
}
}
}

    /// The fill and text renderers' geometry for this frame.
    // rust: pub(super) fn debug_renderer_geometry(&mut self, camera: glam::DVec3, out: &mut Vec<Vertex>) {
    // rust: let water = self.debug_entry("visualize_water_levels");
    // rust: let heightmap = self.debug_entry("visualize_heightmap");
    // rust: let block_light = self.debug_entry("visualize_block_light_levels");
    // rust: let sky_light = self.debug_entry("visualize_sky_light_levels");
    // rust: let solid = self.debug_entry("visualize_solid_faces");
    // rust: let Some(p) = &self.player else {
    // rust: return;
}
    // rust: if !(water || heightmap || block_light || sky_light || solid) {
    // rust: return;
}
    // rust: let feet = [p.position.x, p.position.y, p.position.z].map(|v| v.floor() as i32);
    // rust: let eye = camera.to_array().map(|v| v.floor() as i32);
    // rust: let mut fills: Vec<([[f64; 3]; 4], u32)> = Vec::new();
    // rust: let mut texts: Vec<([f64; 3], String, u32)> = Vec::new();
    // rust: if water {
    // rust: self.water_level_shapes(feet, &mut fills, &mut texts);
}
    // rust: if heightmap {
    // rust: self.heightmap_shapes(eye, &mut fills);
}
    // rust: if block_light || sky_light {
    // rust: light_level_texts(self, eye, block_light, sky_light, &mut texts);
}
    // rust: if solid {
    // rust: self.solid_face_shapes(eye, &mut fills);
}
    // rust: let start = out.len();
    // rust: self.mark_translucent_entity(start, "");
    // rust: let light = vertex_light(0xFF);
    // rust: let mut white = HudBatch::new([1, 1]);
    // rust: for (quad, color) in fills {
            // A plain colour: the atlas's white pixel at the fill's colour
            // (the batch takes ABGR).
    // rust: white.vertices.clear();
    // rust: white.fill(&self.gui.atlas, 0.0, 0.0, 1.0, 1.0, abgr(color));
    // rust: let Some(v) = white.vertices.first().copied() else {
    // rust: continue;
}
    // rust: for corner in quad {
    // rust: out.push(Vertex {
    // rust: normal: [0; 4],
    // rust: pos: (glam::DVec3::from_array(corner) - camera)
    // rust: .as_vec3()
    // rust: .to_array(),
    // rust: uv: v.uv,
    // rust: layer: 0,
    // rust: color: v.color,
    // rust: light,
    // rust: glint_uv: [0.0, 0.0],
    // rust: });
}
}
        // `Gizmos.billboardText`: centred, without a background.
    // rust: let mut patches = Vec::new();
    // rust: for (at, text, color) in texts {
    // rust: patches.extend(self.name_tag_quads(
    // rust: glam::DVec3::from_array(at) - camera,
    // rust: &[(Text::literal(text).with_color(color & 0xFF_FFFF), 0.0)],
    // rust: color >> 24,
    // rust: false,
    // rust: 2,
    // rust: 0,
    // rust: g::billboard_text_unit(TEXT_SCALE),
    // rust: out,
    // rust: ));
}
    // rust: self.map_patches.extend(patches);
}

    /// `WaterDebugRenderer`: each water block within 10 of the feet filled
    /// to its height, with its amount over it.
    // rust: fn water_level_shapes(
    // rust: &self,
    // rust: feet: [i32; 3],
    // rust: fills: &mut Vec<([[f64; 3]; 4], u32)>,
    // rust: texts: &mut Vec<([f64; 3], String, u32)>,
    // rust: ) {
//         use horizon_client::blocks::Fluid;
    // rust: for pos in cube(feet, 10) {
    // rust: let f = self
    // rust: .res
    // rust: .facts()
    // rust: .get(self.world.block(pos[0], pos[1], pos[2]));
    // rust: if f.fluid != Fluid::Water {
    // rust: continue;
}
    // rust: let Some((height, _)) = self.fluid_height_of(pos[0], pos[1], pos[2], None) else {
    // rust: continue;
}
    // rust: let [x, y, z] = pos.map(f64::from);
    // rust: let top = y + f64::from(height);
    // rust: let (lo, hi) = (f64::from(0.01f32), f64::from(0.99f32));
    // rust: fills.extend(
    // rust: g::cuboid_fill_quads([x + lo, y + lo, z + lo], [x + hi, top, z + hi])
    // rust: .map(|q| (q, WATER_FILL)),
    // rust: );
            // FluidState.getAmount: a source holds 8, a flowing one its level.
    // rust: texts.push((
    // rust: [x + 0.5, top, z + 0.5],
    // rust: f.fluid_level.to_string(),
    // rust: 0xFF00_0000,
    // rust: ));
}
}

    /// `HeightMapRenderer`: the client chunk's heightmaps of the 5x5 chunks
    /// around the camera, a small box per column, stacked by type.
pub fn heightmap_shapes(self: *Self, eye: [i32; 3], fills: *mut Vec<([[f64; 3]; 4]) void {
}
    // rust: let (cx, cz) = (eye[0] >> 4, eye[2] >> 4);
    // rust: for chunk_x in cx - 2..=cx + 2 {
    // rust: for chunk_z in cz - 2..=cz + 2 {
    // rust: if !self.world.chunks.contains_key(&(chunk_x, chunk_z)) {
    // rust: continue;
}
    // rust: for kind in HeightmapType::ALL
    // rust: .into_iter()
    // rust: .filter(|k| k.send_to_client())
    // rust: {
    // rust: let color = heightmap_color(kind);
    // rust: for x in chunk_x * 16..chunk_x * 16 + 16 {
    // rust: for z in chunk_z * 16..chunk_z * 16 + 16 {
    // rust: let height = f64::from(self.column_height(kind, x, z))
    // rust: + f64::from(kind as u8) * BOX_HEIGHT;
    // rust: let (x, z) = (f64::from(x), f64::from(z));
    // rust: fills.extend(
    // rust: g::cuboid_fill_quads(
    // rust: [x + 0.25, height, z + 0.25],
    // rust: [x + 0.75, height + BOX_HEIGHT, z + 0.75],
    // rust: )
    // rust: .map(|q| (q, color)),
    // rust: );
}
}
}
}
}
}

    /// `SolidFaceRenderer`: each outline box of the blocks within 6 of the
    /// camera, grown by 0.002, with its sides that are sturdy filled.
pub fn solid_face_shapes(self: *Self, eye: [i32; 3], fills: *mut Vec<([[f64; 3]; 4]) void {
}
        // In SolidFaceRenderer's order (WEST, SOUTH, EAST, NORTH, DOWN, UP):
        // the Direction ordinal and the side's quad in `cuboid_fill_quads`.
pub const SIDES: [(u8, usize); 6] = [(4, 1), (3, 3), (5, 0), (2, 2), (0, 5), (1, 4)];
    // rust: for pos in cube(eye, 6) {
    // rust: let state = self.world.block(pos[0], pos[1], pos[2]);
    // rust: let f = self.res.facts().get(state);
    // rust: if &*f.name == "minecraft:air" || f.sturdy_full == 0 {
    // rust: continue;
}
    // rust: let at = pos.map(f64::from);
    // rust: for b in f.outline.iter() {
    // rust: let min = [at[0] + b[0], at[1] + b[1], at[2] + b[2]].map(|v| v - 0.002);
    // rust: let max = [at[0] + b[3], at[1] + b[4], at[2] + b[5]].map(|v| v + 0.002);
    // rust: let quads = g::cuboid_fill_quads(min, max);
    // rust: for (direction, side) in SIDES {
    // rust: if f.sturdy_full & (1 << direction) != 0 {
    // rust: fills.push((quads[side], SOLID_FACE_FILL));
}
}
}
}
}
}

/// `LightDebugRenderer`: within 10 of the camera, the sky light where it
/// isn't full and the block light where there is some (the light engine's
/// section data, drawn with them in vanilla, Horizon doesn't keep).
    // rust: fn light_level_texts(
    // rust: game: &Game<'_>,
    // rust: eye: [i32; 3],
    // rust: block: bool,
    // rust: sky: bool,
    // rust: texts: &mut Vec<([f64; 3], String, u32)>,
    // rust: ) {
    // rust: for pos in cube(eye, 10) {
    // rust: let light = game.world.light(pos[0], pos[1], pos[2]);
    // rust: let (sky_light, block_light) = (light >> 4, light & 15);
    // rust: let [x, y, z] = pos.map(f64::from);
    // rust: if sky_light != 15 && sky {
    // rust: let color = srgb_lerp(f32::from(sky_light) / 15.0, 0xFF00_00FF, 0xFF00_FFFF);
    // rust: texts.push(([x + 0.5, y + 0.25, z + 0.5], sky_light.to_string(), color));
}
    // rust: if block && block_light != 0 {
    // rust: let color = srgb_lerp(f32::from(block_light) / 15.0, 0xFFAA_0000, 0xFFFF_FF00);
    // rust: texts.push(([x + 0.5, y + 0.5, z + 0.5], block_light.to_string(), color));
}
}
}
