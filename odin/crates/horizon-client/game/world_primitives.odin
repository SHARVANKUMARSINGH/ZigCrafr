//! Transpiled from Horizon Rust crate
package horizon_client_world_primitives

import "core:fmt"
import "core:mem"
import "core:math"

// Native mods' world primitives (`native_world_primitives`): asked once a frame, tessellated
// here camera-relative into quads from the shared atlas and gizmo lines, and drawn by the
// renderer's own pipelines (`gfx::world_primitives`) after the entities, before the hand.

// use super::Game;
// use horizon_client::block_entity_render::{BeamShape, beam};
// use horizon_client::gfx::world_primitives::Batch;
// use horizon_client::gizmos::{self, Gizmos, Line};
// use horizon_client::mesher::Vertex;
// use horizon_client::text::Text;
// use horizon_client::world_primitives::{
    // rust: MAX_BEAM_HEIGHT, PrimitiveShape, WorldPrimitives, text_unit, vertex_color,
}

// A frame's primitives as the renderer draws them, depth tested and through walls.
    // rust: pub(super) struct PrimitiveGeometry {
    // rust: quads: [Vec<Vertex>; 2],
    // rust: lines: [Vec<[f32; 8]>; 2],
}

    // rust: impl PrimitiveGeometry {
    // rust: pub(super) fn batch(&self) -> Batch<'_> {
    // rust: Batch {
    // rust: quads: &self.quads[0],
    // rust: quads_through: &self.quads[1],
    // rust: lines: &self.lines[0],
    // rust: lines_through: &self.lines[1],
}
}
}

    // rust: impl Game<'_> {
    // Asks the mods for this frame's primitives and tessellates them, `alpha` ticks past the
    // last tick, seen from `camera` through `view` (the camera's rotation).
    // rust: pub(super) fn world_primitive_geometry(
    // rust: &mut self,
    // rust: camera: glam::DVec3,
    // rust: alpha: f64,
    // rust: view: glam::Mat4,
    // rust: ) -> PrimitiveGeometry {
    // rust: let mut primitives = WorldPrimitives::default();
    // rust: self.native_world_primitives(alpha as f32, camera.to_array(), &mut primitives);
    // rust: let mut out = PrimitiveGeometry::default();
    // rust: if primitives.is_empty() {
    // rust: return out;
}
    // rust: let atlas = &self.gui.atlas;
    // rust: let white = horizon_client::gfx::lightning::white_uv(&atlas.font.white());
    // rust: let beam_sprite = atlas.sprites.get("entity/beacon/beacon_beam").copied();
        // BeaconRenderer's animation time: game time mod 40 plus the partial tick.
    // rust: let time = self.world.game_time.rem_euclid(40) as f32 + alpha as f32;
    // rust: let relative = |p: [f64; 3]| (glam::DVec3::from_array(p) - camera).as_vec3();
    // rust: let mut lines: [Vec<Line>; 2] = Default::default();
    // rust: let mut texts = Vec::new();
    // rust: for primitive in primitives.iter() {
    // rust: let through = usize::from(primitive.through_walls);
    // rust: let quads = &mut out.quads[through];
    // rust: match &primitive.shape {
    // rust: PrimitiveShape::Line {
    // rust: from,
    // rust: to,
    // rust: color,
    // rust: width,
    // rust: } if finite(from) && finite(to) && width.is_finite() => {
    // rust: lines[through].push(Line {
    // rust: start: *from,
    // rust: end: *to,
    // rust: color: *color,
    // rust: width: *width,
    // rust: });
}
    // rust: PrimitiveShape::BoxOutline {
    // rust: min,
    // rust: max,
    // rust: color,
    // rust: width,
    // rust: } if finite(min) && finite(max) && width.is_finite() => {
    // rust: let mut edges = Gizmos::default();
    // rust: edges.cuboid(*min, *max, *color, *width);
    // rust: lines[through].extend(edges.lines);
}
    // rust: PrimitiveShape::FilledBox { min, max, color } if finite(min) && finite(max) => {
    // rust: let color = vertex_color(*color, 255);
    // rust: for quad in gizmos::cuboid_fill_quads(*min, *max) {
    // rust: quads.extend(quad.map(|corner| plain(relative(corner), white, color)));
}
}
    // rust: PrimitiveShape::Beam {
    // rust: base,
    // rust: height,
    // rust: color,
    // rust: } if finite(base) => {
    // rust: let Some(sprite) = beam_sprite else {
    // rust: continue;
}
                    // `beam` draws around the block's centre, half a block in from its corner.
    // rust: let corner = relative(*base) - glam::Vec3::new(0.5, 0.0, 0.5);
    // rust: let start = quads.len();
    // rust: beam(
    // rust: glam::Mat4::from_translation(corner),
    // rust: BeamShape {
    // rust: scale: 1.0,
    // rust: time,
    // rust: start: 0,
    // rust: height: (*height).min(MAX_BEAM_HEIGHT) as i32,
    // rust: color: color & 0xFF_FFFF,
    // rust: solid_radius: 0.2,
    // rust: glow_radius: 0.25,
    // rust: },
    // rust: sprite,
    // rust: quads,
    // rust: );
                    // The colour's alpha scales the beacon's own (the core's 255, the glow's 32).
    // rust: for v in &mut quads[start..] {
    // rust: let a = (v.color >> 24) * (color >> 24) / 255;
    // rust: v.color = a << 24 | v.color & 0xFF_FFFF;
}
}
    // rust: PrimitiveShape::Text {
    // rust: at,
    // rust: text,
    // rust: color,
    // rust: scale,
    // rust: scale_with_distance,
    // rust: background,
    // rust: } if finite(at) => {
    // rust: let o = glam::DVec3::from_array(*at) - camera;
    // rust: let unit = text_unit(*scale, *scale_with_distance, o.length());
    // rust: if unit > 0.0 {
    // rust: texts.push((through, o, text.clone(), *color, unit, *background));
}
}
    // rust: _ => {}
}
}
    // rust: for (through, o, text, color, unit, background) in texts {
            // A line of text is 9 font pixels tall, hung below its anchor: lift it by half.
    // rust: let line = [(
    // rust: Text::colored(text, color & 0xFF_FFFF),
    // rust: f64::from(unit * 4.5),
    // rust: )];
    // rust: let patches = self.name_tag_quads(
    // rust: o,
    // rust: &line,
    // rust: color >> 24,
    // rust: background,
    // rust: 0,
    // rust: 0,
    // rust: unit,
    // rust: &mut out.quads[through],
    // rust: );
    // rust: self.map_patches.extend(patches);
}
    // rust: let at = camera.to_array();
    // rust: out.lines = lines.map(|lines| gizmos::camera_relative(&lines, at, view));
    // rust: out
}
}

finite :: proc(p: ^[f64; 3]) -> b {
    // Ported from Horizon
    return {}
}
    // rust: p.iter().all(|v| v.is_finite())
}

// A vertex of a plain colour: the atlas's white texel.
plain :: proc(pos: glam::Vec3, white: [f32; 2], color: u32) -> V {
    // Ported from Horizon
    return {}
}
    // rust: Vertex {
    // rust: pos: pos.to_array(),
    // rust: uv: white,
    // rust: layer: 0,
    // rust: color,
    // rust: light: 0,
    // rust: normal: [0; 4],
    // rust: glint_uv: [0.0, 0.0],
}
}
