//! Transpiled from Horizon Rust crate
package horizon_client_render_shadow_faces_tests

import "core:fmt"
import "core:mem"
import "core:math"

// The shadow pass draws terrain faces from both sides, as Iris 1.11.7 does (#9033: a probe pack
// of ours writing `gl_FrontFacing` into `shadowcolor0` found back faces in Iris's shadow map and
// none in Horizon's). The programs here are original.
// use super::destination_tests::Fixture;
// use super::*;
// use std::io::{Cursor, Write};
// use wgpu::util::DeviceExt;

FINAL_VSH :: "#version 120\nvarying vec2 uv;\nvoid main() { uv=gl_MultiTexCoord0.xy; gl_Position=ftransform(); }\n"

pack :: proc() -> P {
    // Ported from Horizon
    return {}
}
    // rust: let mut zip = zip::ZipWriter::new(Cursor::new(Vec::new()));
    // rust: let mut add = |name: &str, source: &str| {
    // rust: zip.start_file(
    // rust: format!("shaders/{name}"),
    // rust: zip::write::SimpleFileOptions::default(),
    // rust: )
    // rust: .unwrap();
    // rust: zip.write_all(source.as_bytes()).unwrap();
}
    // The terrain's positions are already in clip space.
    // rust: add(
    // rust: "shadow.vsh",
    // rust: "#version 120\nvoid main() { gl_Position=vec4(gl_Vertex.xy,0.5,1.0); }\n",
    // rust: );
    // Red where a front face was drawn, blue where a back face was.
    // rust: add(
    // rust: "shadow.fsh",
    // rust: "#version 120\nvoid main() {\n\
    // rust: gl_FragData[0]=gl_FrontFacing ? vec4(1.0,0.0,0.0,1.0) : vec4(0.0,0.0,1.0,1.0);\n}\n",
    // rust: );
    // rust: add("final.vsh", FINAL_VSH);
    // rust: add(
    // rust: "final.fsh",
    // rust: "#version 120\nconst int shadowMapResolution=16;\nuniform sampler2D shadowcolor0;\n\
    // rust: varying vec2 uv;\nvoid main() { gl_FragColor=texture2D(shadowcolor0,uv); }\n",
    // rust: );
    // rust: let pack = horizon_shaders::Pack::from_zip_bytes(
    // rust: "original-shadow-faces",
    // rust: zip.finish().unwrap().into_inner(),
    // rust: )
    // rust: .unwrap();
    // rust: let mut macros = horizon_shaders::Macros::standard();
    // rust: let (properties, _) = horizon_shaders::read_properties(&pack, &mut macros);
    // rust: let inputs = horizon_shaders::GameInputs {
    // rust: terrain: Some(horizon_shaders::GbuffersInputs {
    // rust: item_id_declared: false,
    // rust: far_depth: false,
    // rust: declarations: "layout(location=0)in vec3 fixture_position;\n".into(),
    // rust: body: "hz_Vertex=vec4(fixture_position,1.0);hz_Color=vec4(1.0);\
    // rust: hz_MultiTexCoord0=vec4(0.0);hz_MultiTexCoord1=vec4(240.0);\
    // rust: hz_MultiTexCoord2=vec4(240.0);hz_Normal=vec3(0.0,0.0,1.0);\n"
    // rust: .into(),
    // rust: attributes: vec![],
    // rust: after: String::new(),
    // rust: alpha_test: None,
    // rust: }),
    // rust: ..Default::default()
}
    // rust: horizon_shaders::load_post(&pack, "", &properties, &macros, &inputs)
}

shadow_pass_draws_terrain_back_faces :: proc() {
}
    // rust: let Some(gpu) = Fixture::new() else { return };
ATTRS :: wgpu::vertex_attr_array![0=>Float32x3]
    // rust: let layouts = [Some(wgpu::VertexBufferLayout {
    // rust: array_stride: 12,
    // rust: step_mode: wgpu::VertexStepMode::Vertex,
    // rust: attributes: &ATTRS,
    // rust: })];
    // Culled as the game's own terrain is (`Renderer` hands packs `cull: true`).
    // rust: let mut post = gpu.build_with_terrain(
    // rust: pack(),
    // rust: Some(Geometry {
    // rust: material_maps: false,
    // rust: buffers: &layouts,
    // rust: table: None,
    // rust: depth_write: true,
    // rust: atlas: None,
    // rust: ids: None,
    // rust: cull: true,
    // rust: }),
    // rust: );
    // rust: assert!(post.has_shadow(), "{:?}", post.notes);
    // GL clip space: the left half counter-clockwise (a front face), the right half
    // clockwise (a back face).
    // rust: let positions: [[f32; 3]; 12] = [
    // rust: [-1., -1., 0.],
    // rust: [0., -1., 0.],
    // rust: [0., 1., 0.],
    // rust: [-1., -1., 0.],
    // rust: [0., 1., 0.],
    // rust: [-1., 1., 0.],
    // rust: [0., -1., 0.],
    // rust: [1., 1., 0.],
    // rust: [1., -1., 0.],
    // rust: [0., -1., 0.],
    // rust: [0., 1., 0.],
    // rust: [1., 1., 0.],
    // rust: ];
    // rust: let vertices = gpu
    // rust: .device
    // rust: .create_buffer_init(&wgpu::util::BufferInitDescriptor {
    // rust: label: Some("Original shadow faces geometry"),
    // rust: contents: bytemuck::cast_slice(&positions),
    // rust: usage: wgpu::BufferUsages::VERTEX,
    // rust: });
    // rust: let size = [8, 8];
    // rust: let pixels = gpu.render_with_terrain(&mut post, size, &mut |rp, list, _, _| {
    // rust: if list == TerrainList::ShadowSolid {
    // rust: rp.set_vertex_buffer(0, vertices.slice(..));
    // rust: rp.draw(0..12, 0..1);
}
    // rust: });
    // rust: let near = |got: [u8; 4], want: [u8; 4]| got.iter().zip(want).all(|(g, w)| g.abs_diff(w) <= 1);
    // rust: for (i, got) in pixels.iter().enumerate() {
    // rust: let x = i as u32 % size[0];
    // rust: let want = if x < size[0] / 2 {
    // rust: [255, 0, 0, 255]
    // rust: } else {
    // rust: [0, 0, 255, 255]
}
    // rust: assert!(
    // rust: near(*got, want),
    // rust: "pixel ({x}, {}): {got:?}, expected {want:?} (red: front face, blue: back face)",
    // rust: i as u32 / size[0]
    // rust: );
}
}
