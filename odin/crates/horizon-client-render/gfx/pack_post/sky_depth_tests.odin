//! Transpiled from Horizon Rust crate
package horizon_client_render_sky_depth_tests

import "core:fmt"
import "core:mem"
import "core:math"

// The sky's programs read their fragments' own depth in `gl_FragCoord.z`, as our probe packs
// read it in Iris 1.11.7: the sky disc at its distance; and
// the sky still shows only where the world left the far plane. Original fixture, no pack files.
// use super::depth_test::{Gpu, SIZE, VERTEX, fixture_frame};
// use super::*;
// use crate::hud::HudBatch;
// use wgpu::TextureFormat as T;

// `program` writes its fragment's `gl_FragCoord.z` into colortex1 (32-bit floats) and red into
// colortex0; final shows colortex1's value as a 24-bit integer on the top half, and the top
// half of colortex0 on the bottom half.
files :: proc(program: string) -> V {
    // Ported from Horizon
    return {}
}
    // rust: vec![
    // rust: (
    // rust: "shaders.properties".into(),
    // rust: format!("blend.{program}=off\n"),
    // rust: ),
    // rust: (
    // rust: format!("{program}.vsh"),
    // rust: "#version 120\nvoid main() { gl_Position = ftransform(); }\n".into(),
    // rust: ),
    // rust: (
    // rust: format!("{program}.fsh"),
    // rust: "#version 120\n/* DRAWBUFFERS:01 */\nvoid main() {\n\
    // rust: \x20   gl_FragData[0] = vec4(1.0, 0.0, 0.0, 1.0);\n\
    // rust: \x20   gl_FragData[1] = vec4(gl_FragCoord.z);\n}\n"
    // rust: .into(),
    // rust: ),
    // rust: ("final.vsh".into(), VERTEX.into()),
    // rust: (
    // rust: "final.fsh".into(),
    // rust: "#version 130\n/*\nconst int colortex1Format = RGBA32F;\n*/\n\
    // rust: uniform sampler2D colortex0;\nuniform sampler2D colortex1;\nvarying vec2 uv;\n\
    // rust: void main() {\n\
    // rust: \x20   uint n = min(uint(texture(colortex1, uv).r * 16777215.0 + 0.5), 16777215u);\n\
    // rust: \x20   vec4 depth = vec4(uvec4(n >> 16u, (n >> 8u) & 255u, n & 255u, 255u)) / 255.0;\n\
    // rust: \x20   gl_FragColor = uv.y > 0.5 ? depth : texture(colortex0, uv + vec2(0.0, 0.5));\n}\n"
    // rust: .into(),
    // rust: ),
    // rust: ]
}

// GL window depth of a point `distance` in front of the camera along its view axis, for the
// fixture's perspective: near 0.05, far `depth_far`.
window_depth :: proc(distance: f64, far: f64) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let near = 0.05;
    // rust: let ndc = (far + near) / (far - near) - 2.0 * far * near / ((far - near) * distance);
    // rust: ndc * 0.5 + 0.5
}

// The pack's picture of a frame of the fixture, whose world drew nothing but left
// `world_depth` (GL window depth) everywhere.
    // rust: fn picture(
    // rust: gpu: &Gpu,
    // rust: program: &str,
    // rust: world_depth: f32,
    // rust: celestial: &[crate::mesher::Vertex],
    // rust: ) -> Vec<[u8; 4]> {
    // rust: let color = gpu.texture(T::Rgba8Unorm);
    // rust: let depth = gpu.texture(T::Depth32Float);
    // The world's depth is reverse-Z.
    // rust: gpu.clear(&color, &depth, 1.0 - world_depth);
    // rust: let sun = gpu.texture(T::Rgba8Unorm);
    // rust: let mut post = gpu.load(
    // rust: files(program),
    // rust: World {
    // rust: atlas: None,
    // rust: material_maps: None,
    // rust: lightmap: color.clone(),
    // rust: terrain: None,
    // rust: block_ids: &[],
    // rust: sprite_rects: &[],
    // rust: celestial: Some(sun),
    // rust: gui_size: SIZE,
    // rust: clouds: None,
    // rust: weather: false,
    // rust: hand: false,
    // rust: },
    // rust: horizon_shaders::GameInputs {
    // rust: sky: Some(super::super::pack_sky::inputs()),
    // rust: celestial: Some(super::super::pack_sky::celestial_inputs()),
    // rust: ..Default::default()
    // rust: },
    // rust: );
    // rust: assert!(post.sky.is_some(), "{:?}", post.notes);
    // rust: let hud = HudBatch::new(SIZE);
    // rust: let mut frame = fixture_frame(&hud);
    // rust: frame.title = false;
    // rust: frame.skybox = true;
    // rust: frame.celestial = celestial;
    // rust: gpu.render(&mut post, &color, &depth, &frame, &mut |_, _, _, _| {})
}

decode :: proc(p: [u8; 4]) -> f {
    // Ported from Horizon
    return {}
}
    // rust: f64::from(u32::from(p[0]) << 16 | u32::from(p[1]) << 8 | u32::from(p[2])) / 16_777_215.0
}

// The sky disc lies 16 blocks above the eye: the fixture looks level with a 90° field of view,
// so a pixel `row` rows below the top of the 16-pixel picture sees it along the view axis at
// 16 / tan(elevation) = 16 / (1 - (row + 0.5) / 8) blocks.
the_sky_disc_reads_its_own_depth :: proc() {
}
    // rust: let Some(gpu) = Gpu::new() else { return };
    // rust: let pixels = picture(&gpu, "gbuffers_skybasic", 1.0, &[]);
    // rust: for row in 0..4 {
    // rust: let along = 16.0 / (1.0 - (row as f64 + 0.5) / 8.0);
    // rust: let expected = window_depth(along, 1000.0);
    // rust: for x in 0..SIZE[0] as usize {
    // rust: let got = decode(pixels[row * SIZE[0] as usize + x]);
    // rust: assert!(
    // rust: (got - expected).abs() < 2e-5,
    // rust: "row {row}, column {x}: gl_FragCoord.z {got}, expected {expected}"
    // rust: );
}
}
}

// The sun's quad (and the moon's behind the camera), 100 blocks away across the view axis:
// one depth everywhere.
the_sun_reads_its_own_depth :: proc() {
}
    // rust: let Some(gpu) = Gpu::new() else { return };
    // rust: let quad = |z: f32| {
    // rust: [
    // rust: [-400.0, -400.0],
    // rust: [400.0, -400.0],
    // rust: [400.0, 400.0],
    // rust: [-400.0, 400.0],
    // rust: ]
    // rust: .map(|[x, y]| crate::mesher::Vertex {
    // rust: pos: [x, y, z],
    // rust: uv: [0.0; 2],
    // rust: layer: 0,
    // rust: color: u32::MAX,
    // rust: light: 0,
    // rust: normal: [0; 4],
    // rust: glint_uv: [0.0; 2],
    // rust: })
}
    // rust: let quads: Vec<_> = quad(100.0).into_iter().chain(quad(-100.0)).collect();
    // rust: let pixels = picture(&gpu, "gbuffers_skytextured", 1.0, &quads);
    // rust: let expected = window_depth(100.0, 1000.0);
    // rust: for (i, &p) in pixels[..pixels.len() / 2].iter().enumerate() {
    // rust: let got = decode(p);
    // rust: assert!(
    // rust: (got - expected).abs() < 2e-5,
    // rust: "pixel {i}: gl_FragCoord.z {got}, expected {expected}"
    // rust: );
}
}

// Where the world left a depth nearer than the far plane, even one farther away than the sky
// disc, the world shows (the fixture's grey), not the sky's red.
the_sky_shows_only_where_the_world_left_the_far_plane :: proc() {
}
    // rust: let Some(gpu) = Gpu::new() else { return };
    // rust: let half = SIZE[0] as usize * SIZE[1] as usize / 2;
    // rust: let far = picture(&gpu, "gbuffers_skybasic", 1.0, &[]);
    // rust: let near = picture(&gpu, "gbuffers_skybasic", 0.9999, &[]);
    // The sky disc covers the upper half of the view (row 7 sees it 256 blocks away, at a
    // window depth of 0.9998).
    // rust: for (i, (f, n)) in far[half..].iter().zip(&near[half..]).enumerate() {
    // rust: assert_eq!(*f, [255, 0, 0, 255], "far plane, pixel {i}");
    // rust: assert_eq!(*n, [16, 16, 16, 255], "depth 0.9999, pixel {i}");
}
}
