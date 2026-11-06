//! Transpiled from Horizon Rust crate
//! Module: horizon-client-render_unknown_sampler_terrain_tests
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! In gbuffers programs a sampler the game gives no texture reads texture unit 0, the atlas
//! (OptiFine's shaders.txt: `gtexture` is unit 0 there), and so do `colortex0` to `colortex3`,
//! which aren't gbuffers samplers in that table. Our probe packs (#9307) read the block atlas
//! through a sampler name of their own, and through each of `colortex0` to `colortex3` and
//! `gnormal`, in gbuffers_terrain in Iris 1.11.7.
// use super::depth_test::{Gpu, SIZE, VERTEX, fixture_frame};
// use super::*;
// use crate::hud::HudBatch;
// use wgpu::{TextureFormat as T, util::DeviceExt};

pub const ATLAS: [u8; 4] = [10, 200, 30, 255];

pub fn unknown_samplers_and_colortex0_to_3_in_gbuffers_terrain_read_the_atlas() void {
}
    // rust: let Some(gpu) = Gpu::new() else { return };
    // rust: let files = vec![
    // rust: ("final.vsh".to_owned(), VERTEX.to_owned()),
    // rust: (
    // rust: "final.fsh".to_owned(),
    // rust: "#version 120\nuniform sampler2D colortex0;varying vec2 uv;\
    // rust: void main(){gl_FragColor=vec4(texture2D(colortex0,uv).rgb,1.0);}"
    // rust: .to_owned(),
    // rust: ),
    // rust: (
    // rust: "gbuffers_terrain.vsh".to_owned(),
    // rust: "#version 120\nvoid main(){gl_Position=vec4(gl_Vertex.xy,0.0,1.0);}".to_owned(),
    // rust: ),
    // rust: (
    // rust: "gbuffers_terrain.fsh".to_owned(),
    // rust: "#version 120\nuniform sampler2D probeOwnName;\nuniform sampler2D colortex0;\n\
    // rust: uniform sampler2D gdepth;\n/* DRAWBUFFERS:0 */\nvoid main(){\n\
    // rust: \x20   float x = gl_FragCoord.x;\n\
    // rust: \x20   gl_FragData[0] = x < 6.0 ? texture2D(probeOwnName, vec2(0.5))\n\
    // rust: \x20       : x < 11.0 ? texture2D(colortex0, vec2(0.5)) : texture2D(gdepth, vec2(0.5));\n}"
    // rust: .to_owned(),
    // rust: ),
    // rust: ];
    // rust: let terrain = horizon_shaders::GbuffersInputs {
    // rust: declarations: "layout(location=0)in vec3 fixture_position;\n".into(),
    // rust: body: "hz_Vertex=vec4(fixture_position,1.0);hz_Color=vec4(1.0);hz_MultiTexCoord0=vec4(0.0);\
    // rust: hz_MultiTexCoord1=vec4(240.0);hz_MultiTexCoord2=vec4(240.0);hz_Normal=vec3(0.0,0.0,1.0);\n"
    // rust: .into(),
    // rust: ..Default::default()
}
    // rust: let inputs = horizon_shaders::GameInputs {
    // rust: terrain: Some(terrain),
    // rust: ..Default::default()
}
pub const ATTRS: [wgpu::VertexAttribute; 1] = wgpu::vertex_attr_array![0=>Float32x3];
    // rust: let layouts = [Some(wgpu::VertexBufferLayout {
    // rust: array_stride: 12,
    // rust: step_mode: wgpu::VertexStepMode::Vertex,
    // rust: attributes: &ATTRS,
    // rust: })];
    // rust: let atlas = gpu
    // rust: .device
    // rust: .create_texture_with_data(
    // rust: &gpu.queue,
    // rust: &wgpu::TextureDescriptor {
    // rust: label: Some("Original one-colour atlas"),
    // rust: size: wgpu::Extent3d {
    // rust: width: 2,
    // rust: height: 2,
    // rust: depth_or_array_layers: 1,
    // rust: },
    // rust: mip_level_count: 1,
    // rust: sample_count: 1,
    // rust: dimension: wgpu::TextureDimension::D2,
    // rust: format: T::Rgba8Unorm,
    // rust: usage: wgpu::TextureUsages::TEXTURE_BINDING,
    // rust: view_formats: &[],
    // rust: },
    // rust: wgpu::util::TextureDataOrder::LayerMajor,
    // rust: &ATLAS.repeat(4),
    // rust: )
    // rust: .create_view(&Default::default());
    // rust: let color = gpu.texture(T::Rgba8Unorm);
    // rust: let depth = gpu.texture(T::Depth32Float);
    // rust: let mut post = gpu.load(
    // rust: files,
    // rust: World {
    // rust: atlas: Some((atlas, [2, 2])),
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
    // rust: assert!(post.has_terrain(), "{:?}", post.notes);
    // rust: let corners = [[-1.0f32, -1.0], [1.0, -1.0], [1.0, 1.0], [-1.0, 1.0]];
    // rust: let vertices: Vec<f32> = [0, 1, 2, 0, 2, 3]
    // rust: .into_iter()
    // rust: .flat_map(|c| [corners[c][0], corners[c][1], 0.0])
    // rust: .collect();
    // rust: let buffer = gpu
    // rust: .device
    // rust: .create_buffer_init(&wgpu::util::BufferInitDescriptor {
    // rust: label: Some("Original full-screen quad"),
    // rust: contents: bytemuck::cast_slice(&vertices),
    // rust: usage: wgpu::BufferUsages::VERTEX,
    // rust: });
    // rust: let hud = HudBatch::new(SIZE);
    // rust: let frame = fixture_frame(&hud);
    // rust: let pixels = gpu.render(&mut post, &color, &depth, &frame, &mut |rp, list, _, _| {
    // rust: if list == TerrainList::Solid {
    // rust: rp.set_vertex_buffer(0, buffer.slice(..));
    // rust: rp.draw(0..6, 0..1);
}
    // rust: });
    // Columns 0-5 read the pack's own name, 6-10 colortex0 (which the program also writes),
    // 11-15 gdepth (colortex1).
    // rust: for (i, p) in pixels.iter().enumerate() {
    // rust: assert_eq!(*p, ATLAS, "column {}", i % SIZE[0] as usize);
}
}
