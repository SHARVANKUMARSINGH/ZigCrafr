//! Transpiled from Horizon Rust crate
package horizon_client_world_primitives

import "core:fmt"
import "core:mem"
import "core:math"

// What a client mod draws in the world each frame through `native_world_primitives`
// (docs/native-mods.md): lines, box outlines, filled boxes, beacon-style beams and text facing
// the camera, in world coordinates with ARGB colours. The game tessellates them
// (`game/world_primitives.rs`) and the renderer draws them with its own pipelines
// (`gfx::world_primitives`), so a mod never touches wgpu for them.

// The primitives of one frame, in the order the mods added them.
WorldPrimitives :: struct {
    primitives: [dynamic]WorldPrimitive,
}

// One primitive and how it is drawn.
WorldPrimitive :: struct {
    shape: PrimitiveShape,
    // Seen through walls: drawn over everything, without a depth test. Otherwise the world
    // in front of it hides it.
    through_walls: bool,
}

// A primitive's shape, in world coordinates. Colours are ARGB (`0xAARRGGBB`): an alpha below
// 255 blends it over the world.
PrimitiveShape :: enum {
    // A line `width` pixels wide.
    Line {,
    from: [f64; 3],
    to: [f64; 3],
    color: u32,
    width: f32,
    // rust: },
    // The twelve edges of a box, `width` pixels wide.
    BoxOutline {,
    min: [f64; 3],
    max: [f64; 3],
    color: u32,
    width: f32,
    // rust: },
    // The six faces of a box, seen from inside too.
    FilledBox {,
    min: [f64; 3],
    max: [f64; 3],
    color: u32,
    // rust: },
    // A beacon's beam: its rotating core and translucent glow, scrolling as a beacon's does,
    // `height` blocks up from `base` (the centre of its foot). The colour's alpha scales the
    // beacon's own (opaque core, faint glow).
    Beam {,
    base: [f64; 3],
    height: u32,
    color: u32,
    // rust: },
    // Text in the game's font, facing the camera, centred on `at`. `scale` 1 is a name tag's
    // size; with `scale_with_distance` it grows with its distance from the camera, keeping
    // on screen the size it has [`TEXT_REFERENCE_DISTANCE`] blocks away. `background` puts a
    // name tag's translucent black behind it.
    Text {,
    at: [f64; 3],
    text: String,
    color: u32,
    scale: f32,
    scale_with_distance: bool,
    background: bool,
    // rust: },
}

// Where text with `scale_with_distance` has the size it keeps.
TEXT_REFERENCE_DISTANCE :: 8.0

// The tallest beam drawn, as a beacon's last section.
MAX_BEAM_HEIGHT :: 2048

    // rust: impl WorldPrimitives {
    // Adds a primitive, depth tested unless it says otherwise.
push :: proc(self: ^Self, shape: PrimitiveShape) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: self.primitives.push(WorldPrimitive {
    // rust: shape,
    // rust: through_walls: false,
    // rust: });
    // rust: self.primitives.last_mut().expect("just pushed")
}
    // rust: pub fn line(
    // rust: &mut self,
    // rust: from: [f64; 3],
    // rust: to: [f64; 3],
    // rust: color: u32,
    // rust: width: f32,
    // rust: ) -> &mut WorldPrimitive {
    // rust: self.push(PrimitiveShape::Line {
    // rust: from,
    // rust: to,
    // rust: color,
    // rust: width,
    // rust: })
}
    // rust: pub fn box_outline(
    // rust: &mut self,
    // rust: min: [f64; 3],
    // rust: max: [f64; 3],
    // rust: color: u32,
    // rust: width: f32,
    // rust: ) -> &mut WorldPrimitive {
    // rust: self.push(PrimitiveShape::BoxOutline {
    // rust: min,
    // rust: max,
    // rust: color,
    // rust: width,
    // rust: })
}
filled_box :: proc(self: ^Self, min: [f64; 3], max: [f64; 3], color: u32) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: self.push(PrimitiveShape::FilledBox { min, max, color })
}
beam :: proc(self: ^Self, base: [f64; 3], height: u32, color: u32) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: self.push(PrimitiveShape::Beam {
    // rust: base,
    // rust: height,
    // rust: color,
    // rust: })
}
    // Text of a name tag's size times `scale`, without a background.
    // rust: pub fn text(
    // rust: &mut self,
    // rust: at: [f64; 3],
    // rust: text: impl Into<String>,
    // rust: color: u32,
    // rust: scale: f32,
    // rust: ) -> &mut WorldPrimitive {
    // rust: self.push(PrimitiveShape::Text {
    // rust: at,
    // rust: text: text.into(),
    // rust: color,
    // rust: scale,
    // rust: scale_with_distance: false,
    // rust: background: false,
    // rust: })
}
iter :: proc(self: ^Self) -> s {
    // Ported from Horizon
    return {}
}
    // rust: self.primitives.iter()
}
len :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.primitives.len()
}
is_empty :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.primitives.is_empty()
}
}

    // rust: impl WorldPrimitive {
    // Seen through walls ([`Self::through_walls`]).
through_walls :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: self.through_walls = true;
    // rust: self
}
    // Text keeps its size on screen as it moves away; nothing for other shapes.
scale_with_distance :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: if let PrimitiveShape::Text {
    // rust: scale_with_distance,
    // rust: ..
    // rust: } = &mut self.shape
    // rust: {
    // rust: *scale_with_distance = true;
}
    // rust: self
}
    // Text on a name tag's background; nothing for other shapes.
background :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: if let PrimitiveShape::Text { background, .. } = &mut self.shape {
    // rust: *background = true;
}
    // rust: self
}
}

// The world size of one font pixel of text at `scale`, `distance` blocks from the camera: a
// name tag's 0.025 times `scale`, times the distance over [`TEXT_REFERENCE_DISTANCE`] when it
// scales with distance. Non-finite or negative scales draw nothing (0).
text_unit :: proc(scale: f32, scale_with_distance: bool, distance: f64) -> f {
    // Ported from Horizon
    return {}
}
    // rust: if !scale.is_finite() || scale <= 0.0 {
    // rust: return 0.0;
}
    // rust: let unit = 0.025 * scale;
    // rust: if scale_with_distance {
    // rust: unit * (distance / TEXT_REFERENCE_DISTANCE) as f32
    // rust: } else {
    // rust: unit
}
}

// ARGB as the world's vertex colour (RGBA bytes in memory), its alpha times `alpha` / 255.
vertex_color :: proc(argb: u32, alpha: u32) -> u {
    // Ported from Horizon
    return {}
}
    // rust: let a = (argb >> 24) * alpha / 255;
    // rust: let [r, g, b] = [argb >> 16 & 255, argb >> 8 & 255, argb & 255];
    // rust: a << 24 | b << 16 | g << 8 | r
}

    // rust: mod tests {
//     use super::*;

text_keeps_its_screen_size_only_when_it_scales_with_distance :: proc() {
}
        // A name tag's font pixel is 0.025 blocks.
    // rust: assert_eq!(text_unit(1.0, false, 50.0), 0.025);
    // rust: assert_eq!(text_unit(2.0, false, 1.0), 0.05);
        // Twice as far, twice as big: the same angle, so the same size on screen.
    // rust: assert_eq!(text_unit(1.0, true, 8.0), 0.025);
    // rust: assert_eq!(text_unit(1.0, true, 16.0), 0.05);
    // rust: assert_eq!(text_unit(f32::NAN, false, 1.0), 0.0);
    // rust: assert_eq!(text_unit(-1.0, true, 1.0), 0.0);
}

argb_becomes_rgba_bytes :: proc() {
}
    // rust: assert_eq!(
    // rust: vertex_color(0x80FF_2010, 255).to_le_bytes(),
    // rust: [0xFF, 0x20, 0x10, 0x80]
    // rust: );
    // rust: assert_eq!(vertex_color(0xFFFF_FFFF, 32).to_le_bytes()[3], 32);
}
}
