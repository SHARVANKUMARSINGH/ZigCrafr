//! Transpiled from Horizon Rust crate
//! Module: horizon-client-render_terrain_parts_tests
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Solid and cutout terrain through `gbuffers_terrain_solid` and `gbuffers_terrain_cutout`
//! (#9137). The expected programs are what Iris 1.11.7 drew with our probe packs (the PR has
//! the numbers): with either program the pack draws solid terrain (quads over opaque texels, and
//! lava) through `gbuffers_terrain_solid` and cutout terrain through `gbuffers_terrain_cutout`,
//! the missing one falling back to `gbuffers_terrain`; solid terrain keeps a fragment written
//! with alpha 0.05, cutout terrain loses it. Each quad draws whole with one of them, whatever
//! its vertices' alphas (with `separateAo`, their own ambient occlusion). The programs here are
//! the probes', cut down.
// use super::depth_test::{Gpu, SIZE, VERTEX, fixture_frame};
// use super::*;
// use crate::hud::HudBatch;
// use wgpu::{TextureFormat as T, util::DeviceExt};

pub const RED: [u8; 3] = [255, 0, 0];
pub const GREEN: [u8; 3] = [0, 255, 0];
pub const BLUE: [u8; 3] = [0, 0, 255];

/// A program writing `rgb` with `alpha` into colortex0.
pub fn program(name: []const u8, rgb: [u8; 3], alpha: f32) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let [r, g, b] = rgb.map(|c| f32::from(c) / 255.0);
    // rust: [
    // rust: (
    // rust: format!("{name}.vsh"),
    // rust: "#version 120\nvoid main(){gl_Position=vec4(gl_Vertex.xy,0.0,1.0);}".into(),
    // rust: ),
    // rust: (
    // rust: format!("{name}.fsh"),
    // rust: format!(
    // rust: "#version 120\n/* DRAWBUFFERS:0 */\nvoid main(){{gl_FragData[0]=vec4({r:?},{g:?},{b:?},{alpha:?});}}"
    // rust: ),
    // rust: ),
    // rust: ]
}

/// Lava's sprite layer in the fixture.
pub const LAVA: u16 = 5;

/// The pack (`final` shows colortex0, cleared to black) drawn over three strips of terrain, left
/// to right: a quad over opaque texels, a cutout quad, a lava quad, all with opaque vertex
/// colours. Each strip's colour, `None` where nothing drew; `None` overall without a GPU.
pub fn strips(programs: *[([]const u8) void {
}
    // rust: strips_with_alphas(programs, [255; 4])
}

/// `strips` with the quads' corners' vertex alphas (bottom left, bottom right, top right, top
/// left). Fails unless each strip is one colour.
    // rust: fn strips_with_alphas(
    // rust: programs: &[(&str, [u8; 3], f32)],
    // rust: alphas: [u8; 4],
    // rust: ) -> Option<[Option<[u8; 3]>; 3]> {
    // rust: let files = programs
    // rust: .iter()
    // rust: .flat_map(|&(name, rgb, alpha)| program(name, rgb, alpha))
    // rust: .collect();
    // rust: let (strips, _) = strips_of(files, alphas)?;
    // rust: Some(strips)
}

/// `strips_with_alphas` with the pack's terrain programs' `files`, and the built pack's notes
/// when it draws no terrain itself (`None` when it does).
    // rust: fn strips_of(
    // rust: programs: Vec<(String, String)>,
    // rust: alphas: [u8; 4],
    // rust: ) -> Option<([Option<[u8; 3]>; 3], Option<Vec<String>>)> {
    // rust: let Some(gpu) = Gpu::new() else {
    // rust: eprintln!("TERRAIN_PARTS_NO_ADAPTER");
    // rust: return None;
}
    // rust: let mut files = vec![
    // rust: ("final.vsh".to_owned(), VERTEX.to_owned()),
    // rust: (
    // rust: "final.fsh".to_owned(),
    // rust: "#version 120\nuniform sampler2D colortex0;varying vec2 uv;\
    // rust: const vec4 colortex0ClearColor = vec4(0.0, 0.0, 0.0, 1.0);\
    // rust: void main(){gl_FragColor=vec4(texture2D(colortex0,uv).rgb,1.0);}"
    // rust: .to_owned(),
    // rust: ),
    // rust: ];
    // rust: files.extend(programs);
    // The game's terrain inputs as far as the parts read them: the sprite layer and the colour.
    // rust: let terrain = horizon_shaders::GbuffersInputs {
    // rust: declarations: "layout(location=0)in vec3 fixture_position;\n\
    // rust: layout(location=2)in uint hz_v_layer;\n\
    // rust: layout(location=3)in vec4 hz_v_color;\n"
    // rust: .into(),
    // rust: body: "hz_Vertex=vec4(fixture_position,1.0);hz_Color=vec4(1.0);hz_MultiTexCoord0=vec4(0.0);\
    // rust: hz_MultiTexCoord1=vec4(240.0);hz_MultiTexCoord2=vec4(240.0);hz_Normal=vec3(0.0,0.0,1.0);\n"
    // rust: .into(),
    // rust: ..Default::default()
}
    // rust: let inputs = horizon_shaders::GameInputs {
    // rust: terrain_parts: Some(super::super::pack_atlas::terrain_parts(
    // rust: &terrain,
    // rust: &[LAVA, LAVA + 1],
    // rust: )),
    // rust: terrain: Some(terrain),
    // rust: ..Default::default()
}
    // rust: const ATTRS: [wgpu::VertexAttribute; 3] =
    // rust: wgpu::vertex_attr_array![0=>Float32x3,2=>Uint32,3=>Unorm8x4];
    // rust: let layouts = [Some(wgpu::VertexBufferLayout {
    // rust: array_stride: 20,
    // rust: step_mode: wgpu::VertexStepMode::Vertex,
    // rust: attributes: &ATTRS,
    // rust: })];
    // rust: let color = gpu.texture(T::Rgba8Unorm);
    // rust: let depth = gpu.texture(T::Depth32Float);
    // rust: let mut post = gpu.load(
    // rust: files,
    // rust: World {
    // rust: atlas: None,
    // rust: material_maps: None,
    // rust: lightmap: color.clone(),
    // rust: terrain: Some(Geometry {
    // rust: buffers: &layouts,
    // rust: table: None,
    // rust: depth_write: true,
    // rust: atlas: None,
    // rust: material_maps: false,
    // rust: ids: None,
    // rust: cull: false,
    // rust: }),
    // rust: block_ids: &[],
    // rust: sprite_rects: &[],
    // rust: celestial: None,
    // rust: gui_size: SIZE,
    // rust: clouds: None,
    // rust: weather: false,
    // rust: hand: false,
    // rust: },
    // rust: inputs,
    // rust: );
    // rust: let opaque = u32::from(crate::mesher::OPAQUE_LAYER);
    // rust: let mut vertices: Vec<u32> = Vec::new();
    // rust: for (i, layer) in [opaque | 1, 2, u32::from(LAVA)].into_iter().enumerate() {
    // rust: let (x0, x1) = (
    // rust: -1.0 + i as f32 * 2.0 / 3.0,
    // rust: -1.0 + (i + 1) as f32 * 2.0 / 3.0,
    // rust: );
    // rust: let corners = [[x0, -1.0], [x1, -1.0], [x1, 1.0], [x0, 1.0]];
    // rust: for corner in [0, 1, 2, 0, 2, 3] {
    // rust: let [x, y] = corners[corner];
    // rust: let color = u32::from(alphas[corner]) << 24 | 0x00FF_FFFF;
    // rust: vertices.extend([x.to_bits(), f32::to_bits(y), 0f32.to_bits(), layer, color]);
}
}
    // rust: let buffer = gpu
    // rust: .device
    // rust: .create_buffer_init(&wgpu::util::BufferInitDescriptor {
    // rust: label: Some("Terrain parts fixture"),
    // rust: contents: bytemuck::cast_slice(&vertices),
    // rust: usage: wgpu::BufferUsages::VERTEX,
    // rust: });
    // rust: let undrawn = (!post.has_terrain()).then(|| post.notes.clone());
    // rust: let hud = HudBatch::new(SIZE);
    // rust: let frame = fixture_frame(&hud);
    // rust: let pixels = gpu.render(&mut post, &color, &depth, &frame, &mut |rp, list, _, _| {
    // rust: if list == TerrainList::Solid {
    // rust: rp.set_vertex_buffer(0, buffer.slice(..));
    // rust: rp.draw(0..18, 0..1);
}
    // rust: });
    // Every pixel of each strip (columns 0-4, 6-9 and 11-15; 5 and 10 straddle two strips).
    // rust: let colour = |x: usize, y: usize| {
    // rust: let [r, g, b, _] = pixels[y * SIZE[0] as usize + x];
    // rust: Some([r, g, b]).filter(|&c| c != [0, 0, 0])
}
    // rust: let strips = [0..5, 6..10, 11..16].map(|columns| {
    // rust: let first = colour(columns.start, 0);
    // rust: for x in columns.clone() {
    // rust: for y in 0..SIZE[1] as usize {
    // rust: assert_eq!(colour(x, y), first, "strip {columns:?} at ({x}, {y})");
}
}
    // rust: first
    // rust: });
    // rust: Some((strips, undrawn))
}

pub fn solid_and_cutout_programs_draw_their_own_terrain() void {
}
    // rust: let programs = [
    // rust: ("gbuffers_terrain", RED, 1.0),
    // rust: ("gbuffers_terrain_solid", GREEN, 1.0),
    // rust: ("gbuffers_terrain_cutout", BLUE, 1.0),
    // rust: ];
    // rust: let Some(got) = strips(&programs) else { return };
    // rust: assert_eq!(got, [Some(GREEN), Some(BLUE), Some(GREEN)]);
}

pub fn without_a_cutout_program_cutout_terrain_falls_back_to_gbuffers_terrain() void {
}
    // rust: let programs = [
    // rust: ("gbuffers_terrain", RED, 1.0),
    // rust: ("gbuffers_terrain_solid", GREEN, 1.0),
    // rust: ];
    // rust: let Some(got) = strips(&programs) else { return };
    // rust: assert_eq!(got, [Some(GREEN), Some(RED), Some(GREEN)]);
}

pub fn without_a_solid_program_solid_terrain_falls_back_to_gbuffers_terrain() void {
}
    // rust: let programs = [
    // rust: ("gbuffers_terrain", RED, 1.0),
    // rust: ("gbuffers_terrain_cutout", BLUE, 1.0),
    // rust: ];
    // rust: let Some(got) = strips(&programs) else { return };
    // rust: assert_eq!(got, [Some(RED), Some(BLUE), Some(RED)]);
}

pub fn solid_terrain_keeps_alpha_0_05_and_cutout_loses_it() void {
}
    // rust: let programs = [
    // rust: ("gbuffers_terrain", RED, 1.0),
    // rust: ("gbuffers_terrain_solid", GREEN, 0.05),
    // rust: ("gbuffers_terrain_cutout", BLUE, 0.05),
    // rust: ];
    // rust: let Some(got) = strips(&programs) else { return };
    // rust: assert_eq!(got, [Some(GREEN), None, Some(GREEN)]);
    // The solid part through its fallback, as the probe's `gbuffers_terrain` writing 0.05.
    // rust: let programs = [
    // rust: ("gbuffers_terrain", RED, 0.05),
    // rust: ("gbuffers_terrain_cutout", BLUE, 1.0),
    // rust: ];
    // rust: let Some(got) = strips(&programs) else { return };
    // rust: assert_eq!(got, [Some(RED), Some(BLUE), Some(RED)]);
}

/// With `separateAo` a vertex's alpha is its own ambient occlusion, so the corners of one quad
/// differ; the quad still draws whole, with its part's program.
pub fn a_quad_draws_whole_whatever_its_vertex_alphas() void {
}
    // rust: let programs = [
    // rust: ("gbuffers_terrain", RED, 1.0),
    // rust: ("gbuffers_terrain_solid", GREEN, 1.0),
    // rust: ("gbuffers_terrain_cutout", BLUE, 1.0),
    // rust: ];
    // rust: for alphas in [[255, 160, 255, 160], [128, 255, 200, 64], [160; 4]] {
    // rust: let Some(got) = strips_with_alphas(&programs, alphas) else {
    // rust: return;
}
    // rust: assert_eq!(got, [Some(GREEN), Some(BLUE), Some(GREEN)], "{alphas:?}");
}
}

pub fn a_pack_with_neither_draws_all_terrain_with_gbuffers_terrain() void {
}
    // rust: let Some(got) = strips(&[("gbuffers_terrain", RED, 1.0)]) else {
    // rust: return;
}
    // rust: assert_eq!(got, [Some(RED); 3]);
}

/// A pack whose only terrain program is `gbuffers_terrain_solid` (or `_cutout`) draws that part,
/// and nothing draws the other: Iris 1.11.7 left it undrawn with our probes `tsc-solidonly` and
/// `tsc-cutoutonly`.
pub fn a_lone_split_program_draws_only_its_own_terrain() void {
}
    // rust: let solid = strips(&[("gbuffers_terrain_solid", GREEN, 1.0)]);
    // rust: let Some(solid) = solid else { return };
    // rust: assert_eq!(solid, [Some(GREEN), None, Some(GREEN)]);
    // rust: let cutout = strips(&[("gbuffers_terrain_cutout", BLUE, 1.0)]);
    // rust: assert_eq!(cutout, Some([None, Some(BLUE), None]));
}

/// When one part's pipeline can't be built (here a cutout program writing no buffer, which
/// Horizon skips), the other part doesn't draw alone either: the game draws all terrain.
pub fn a_part_that_fails_to_build_takes_the_other_with_it() void {
}
    // rust: let mut files: Vec<(String, String)> = [
    // rust: program("gbuffers_terrain", RED, 1.0),
    // rust: program("gbuffers_terrain_solid", GREEN, 1.0),
    // rust: ]
    // rust: .concat();
    // rust: files.push((
    // rust: "gbuffers_terrain_cutout.vsh".into(),
    // rust: "#version 120\nvoid main(){gl_Position=vec4(gl_Vertex.xy,0.0,1.0);}".into(),
    // rust: ));
    // rust: files.push((
    // rust: "gbuffers_terrain_cutout.fsh".into(),
    // rust: "#version 120\nvoid main(){}".into(),
    // rust: ));
    // rust: let Some((got, undrawn)) = strips_of(files, [255; 4]) else {
    // rust: return;
}
    // rust: assert_eq!(got, [None; 3]);
    // rust: let notes = undrawn.expect("the game draws terrain");
    // rust: for note in [
    // rust: "gbuffers_terrain_cutout: writes no buffer; skipped",
    // rust: "gbuffers_terrain_solid: the other part of terrain can't draw",
    // rust: ] {
    // rust: assert!(notes.iter().any(|n| n.starts_with(note)), "{notes:?}");
}
}

/// Iris 1.11.7 with our probe packs pe4u (only `gbuffers_terrain`) and pe4s (only
/// `gbuffers_terrain_solid` and `gbuffers_terrain_cutout`), each writing one alpha per screen
/// strip (#9307): solid terrain kept every fragment, alpha 0.0 included, and cutout terrain
/// kept those above 0.5 (0.51 kept; 0.5, 0.49 and lower discarded), whichever program drew it.
pub fn cutout_terrain_keeps_alphas_above_0_5_and_solid_terrain_keeps_all() void {
}
    // rust: for (alpha, cutout) in [(0.0, false), (0.49, false), (0.5, false), (0.51, true)] {
    // rust: let Some(got) = strips(&[("gbuffers_terrain", RED, alpha)]) else {
    // rust: return;
}
    // rust: let want = [Some(RED), cutout.then_some(RED), Some(RED)];
    // rust: assert_eq!(got, want, "gbuffers_terrain writing alpha {alpha}");
    // rust: let programs = [
    // rust: ("gbuffers_terrain_solid", GREEN, alpha),
    // rust: ("gbuffers_terrain_cutout", BLUE, alpha),
    // rust: ];
    // rust: let Some(got) = strips(&programs) else { return };
    // rust: let want = [Some(GREEN), cutout.then_some(BLUE), Some(GREEN)];
    // rust: assert_eq!(got, want, "split programs writing alpha {alpha}");
}
}

/// `alphaTestRef` in the same probes: 0 for solid terrain and 0.5 for cutout terrain, through
/// `gbuffers_terrain` alone or through the split programs.
pub fn alpha_test_ref_is_0_for_solid_terrain_and_0_5_for_cutout() void {
}
    // rust: let program = |name: &str| {
    // rust: [
    // rust: (
    // rust: format!("{name}.vsh"),
    // rust: "#version 120\nvoid main(){gl_Position=vec4(gl_Vertex.xy,0.0,1.0);}".to_owned(),
    // rust: ),
    // rust: (
    // rust: format!("{name}.fsh"),
    // rust: "#version 120\nuniform float alphaTestRef;\n/* DRAWBUFFERS:0 */\n\
    // rust: void main(){gl_FragData[0]=vec4(1.0,alphaTestRef*2.0,0.0,1.0);}"
    // rust: .to_owned(),
    // rust: ),
    // rust: ]
}
pub const YELLOW: [u8; 3] = [255, 255, 0];
    // rust: for names in [
    // rust: &["gbuffers_terrain"][..],
    // rust: &["gbuffers_terrain_solid", "gbuffers_terrain_cutout"],
    // rust: ] {
    // rust: let files = names.iter().flat_map(|n| program(n)).collect();
    // rust: let Some((got, _)) = strips_of(files, [255; 4]) else {
    // rust: return;
}
    // rust: assert_eq!(got, [Some(RED), Some(YELLOW), Some(RED)], "{names:?}");
}
}
