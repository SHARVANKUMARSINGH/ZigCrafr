//! Transpiled from Horizon Rust crate
//! Module: horizon-client-render_pack_material_tests
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Original synthetic material transport oracle; no external shader algorithms or assets.
// use super::*;
// use wgpu::util::DeviceExt;

pub fn terrain_material_samplers_preserve_surface_and_encoded_bytes() void {
}
    // rust: let instance = crate::gfx::test_gpu::instance();
    // rust: let adapter = pollster::block_on(instance.request_adapter(&Default::default())).unwrap();
    // rust: eprintln!("Material transport GPU: {:?}", adapter.get_info());
    // rust: assert_ne!(adapter.get_info().device_type, wgpu::DeviceType::Cpu);
    // rust: let (device, queue) = pollster::block_on(adapter.request_device(&wgpu::DeviceDescriptor {
    // rust: required_limits: adapter.limits(),
    // rust: ..Default::default()
    // rust: }))
    // rust: .unwrap();
    // rust: let root = std::env::temp_dir().join(format!("horizon-material-pack-{}", std::process::id()));
    // rust: std::fs::create_dir_all(root.join("shaders")).unwrap();
    // rust: std::fs::write(
    // rust: root.join("shaders/gbuffers_terrain.vsh"),
    // rust: "#version 120\nvoid main(){gl_Position=gl_Vertex;}",
    // rust: )
    // rust: .unwrap();
    // rust: std::fs::write(
    // rust: root.join("shaders/gbuffers_terrain.fsh"),
    // rust: r#"#version 120
    // rust: uniform sampler2D gtexture;
    // rust: uniform sampler2D normals;
    // rust: uniform sampler2D specular;
    // rust: void main() {
    // rust: int x = int(floor(gl_FragCoord.x));
    // rust: int layer = x - (x / 5) * 5;
    // Source coordinate (1.25,1.25): inside a texel, away from both its centre and boundary.
    // rust: vec2 uv = (vec2(float(layer - (layer / 3) * 3), float(layer / 3)) + 0.3125) / vec2(3.0, 2.0);
    // rust: if (x < 5) gl_FragData[0] = texture2DLod(specular, uv, 12.0);
    // rust: else if (x < 10) gl_FragData[0] = texture2DLod(normals, uv, 12.0);
    // rust: else gl_FragData[0] = texture2DLod(gtexture, uv, 0.0);
}
    // rust: "#,
    // rust: )
    // rust: .unwrap();
    // rust: let (split, layers) = (2u32, 5u32);
    // rust: let mut encoder = device.create_command_encoder(&Default::default());
    // rust: let atlases: Vec<_> = (0..3)
    // rust: .map(|kind| {
    // rust: let side = if kind == 0 { 4 } else { 2 };
    // rust: let levels = if kind == 0 { 3 } else { 1 };
    // rust: let arrays: Vec<_> = (0..layers.div_ceil(split))
    // rust: .map(|array| {
    // rust: let count = (layers - array * split).min(split);
    // rust: let pixels: Vec<u8> = (0..count)
    // rust: .flat_map(|l| {
    // rust: let layer = (array * split + l) as u8;
    // rust: (0..levels).flat_map(move |level| {
    // rust: let edge = side >> level;
    // rust: (0..edge * edge).flat_map(move |pixel| {
    // rust: if level != 0 {
                                        // Sampling unused source mip levels must fail the oracle.
    // rust: [211, 212, 213, 214]
    // rust: } else {
    // rust: match kind {
    // rust: 0 if layer == 3 => crate::sprites::NO_SPECULAR,
    // rust: 0 => [
    // rust: 17 + layer,
    // rust: if pixel % 2 == 0 { 0 } else { 240 },
    // rust: 65,
    // rust: if pixel % 2 == 0 { 0 } else { 255 },
    // rust: ],
    // rust: 1 if layer == 2 => crate::sprites::FLAT_NORMAL,
    // rust: 1 => [128 + layer, 126, 255, 19 + layer],
    // rust: _ => [40 + layer, 50, 60, 255],
}
}
    // rust: })
    // rust: })
    // rust: })
    // rust: .collect();
    // rust: device.create_texture_with_data(
    // rust: &queue,
    // rust: &wgpu::TextureDescriptor {
    // rust: label: Some("Original fixture companion array"),
    // rust: size: wgpu::Extent3d {
    // rust: width: side,
    // rust: height: side,
    // rust: depth_or_array_layers: count,
    // rust: },
    // rust: mip_level_count: levels,
    // rust: sample_count: 1,
    // rust: dimension: wgpu::TextureDimension::D2,
    // rust: format: wgpu::TextureFormat::Rgba8Unorm,
    // rust: usage: wgpu::TextureUsages::TEXTURE_BINDING
    // rust: | wgpu::TextureUsages::COPY_SRC,
    // rust: view_formats: &[],
    // rust: },
    // rust: wgpu::util::TextureDataOrder::LayerMajor,
    // rust: &pixels,
    // rust: )
    // rust: })
    // rust: .collect();
    // rust: super::super::pack_atlas::PackAtlas::material(
    // rust: &device,
    // rust: &mut encoder,
    // rust: &arrays,
    // rust: split,
    // rust: layers,
    // rust: )
    // rust: .unwrap()
    // rust: })
    // rust: .collect();
    // rust: queue.submit([encoder.finish()]);
    // rust: let pack = horizon_shaders::Pack::open(&root).unwrap();
    // rust: let macros = horizon_shaders::Macros::standard();
    // Encoded zero alpha is data here and must remain observable in readback.
    // rust: let properties = horizon_shaders::Properties::parse("alphaTest.gbuffers_terrain=off", &macros);
    // rust: let inputs = horizon_shaders::GameInputs {
    // rust: terrain: Some(horizon_shaders::GbuffersInputs {
    // rust: body: "vec2 p = vec2(float((gl_VertexIndex << 1) & 2), float(gl_VertexIndex & 2)); hz_Vertex=vec4(p*2.0-1.0,0.0,1.0);".into(),
    // rust: ..Default::default()
    // rust: }),
    // rust: ..Default::default()
}
    // rust: let post = horizon_shaders::load_post(&pack, "", &properties, &macros, &inputs);
    // rust: assert!(post.terrain.is_some(), "{:?}", post.notes);
    // rust: let world = World {
    // rust: sprite_rects: &[],
    // rust: atlas: Some((atlases[2].view.clone(), atlases[2].size())),
    // rust: material_maps: Some([atlases[1].view.clone(), atlases[0].view.clone()]),
    // rust: lightmap: atlases[2].view.clone(),
    // rust: terrain: Some(Geometry {
    // rust: buffers: &[],
    // rust: table: None,
    // rust: depth_write: true,
    // rust: atlas: None,
    // rust: material_maps: true,
    // rust: ids: None,
    // rust: cull: false,
    // rust: }),
    // rust: block_ids: &[],
    // rust: celestial: None,
    // rust: gui_size: [1, 1],
    // rust: clouds: None,
    // rust: weather: false,
    // rust: hand: false,
}
    // rust: let mut post = PackPost::new(
    // rust: &device,
    // rust: &queue,
    // rust: &adapter,
    // rust: post,
    // rust: wgpu::TextureFormat::Rgba8Unorm,
    // rust: world,
    // rust: )
    // rust: .expect("the pack runs");
    // rust: let mut pass = post
    // rust: .terrain
    // rust: .take()
    // rust: .unwrap_or_else(|| panic!("terrain pipeline must compile: {:?}", post.notes));
    // Request the existing copy usage for the fixture's colour readback.
    // rust: post.copied |= 1;
    // First draw preserves production Geometry -> Pass scope, so a routing regression fails.
    // rust: for case in 0..3 {
    // rust: if case == 1 {
    // rust: pass.material_maps = false;
}
    // rust: if case == 2 {
    // rust: pass.material_maps = true;
    // rust: post.material_maps = None;
}
    // rust: let maps_expected = case == 0;
    // rust: pass.groups.clear();
    // rust: post.resize(&device, [15, 1]);
    // rust: let read = device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: None,
    // rust: size: 256,
    // rust: usage: wgpu::BufferUsages::COPY_DST | wgpu::BufferUsages::MAP_READ,
    // rust: mapped_at_creation: false,
    // rust: });
    // rust: let mut encoder = device.create_command_encoder(&Default::default());
    // rust: {
    // rust: let _clear = encoder.begin_render_pass(&wgpu::RenderPassDescriptor {
    // rust: label: Some("Initialize fixture depth"),
    // rust: color_attachments: &[],
    // rust: depth_stencil_attachment: Some(wgpu::RenderPassDepthStencilAttachment {
    // rust: view: &post.targets.as_ref().unwrap().depth,
    // rust: depth_ops: Some(wgpu::Operations {
    // rust: load: wgpu::LoadOp::Clear(1.0),
    // rust: store: wgpu::StoreOp::Store,
    // rust: }),
    // rust: stencil_ops: None,
    // rust: }),
    // rust: ..Default::default()
    // rust: });
}
    // rust: let group = post.bind(&device, &queue, &mut encoder, &mut pass, [15, 1]);
    // rust: {
    // rust: let mut render = post.begin(&mut encoder, &pass);
    // rust: render.set_pipeline(pass.render());
    // rust: render.set_bind_group(0, &group, &[]);
    // rust: if pass.draw {
    // rust: post.draws.bind(&mut render, "TERRAIN_SOLID");
}
    // rust: render.draw(0..3, 0..1);
}
    // rust: let output = post.targets.as_ref().unwrap().color[0].as_ref().unwrap()[0].texture();
    // rust: encoder.copy_texture_to_buffer(
    // rust: output.as_image_copy(),
    // rust: wgpu::TexelCopyBufferInfo {
    // rust: buffer: &read,
    // rust: layout: wgpu::TexelCopyBufferLayout {
    // rust: bytes_per_row: Some(256),
    // rust: ..Default::default()
    // rust: },
    // rust: },
    // rust: wgpu::Extent3d {
    // rust: width: 15,
    // rust: height: 1,
    // rust: depth_or_array_layers: 1,
    // rust: },
    // rust: );
    // rust: queue.submit([encoder.finish()]);
    // rust: read.slice(..).map_async(wgpu::MapMode::Read, |_| {});
    // rust: device.poll(wgpu::PollType::wait_indefinitely()).unwrap();
    // rust: let data = read.slice(..).get_mapped_range().unwrap();
    // rust: for i in 0..15usize {
    // rust: let layer = (i % 5) as u8;
    // rust: let expected = if i >= 10 {
    // rust: [40 + layer, 50, 60, 255]
    // rust: } else if i >= 5 && (!maps_expected || layer == 2) {
    // rust: crate::sprites::FLAT_NORMAL
    // rust: } else if i >= 5 {
    // rust: [128 + layer, 126, 255, 19 + layer]
    // rust: } else if !maps_expected || layer == 3 {
    // rust: crate::sprites::NO_SPECULAR
    // rust: } else {
    // rust: [17 + layer, 240, 65, 255]
}
    // rust: assert_eq!(&data[i * 4..i * 4 + 4], &expected, "case={case}, pixel={i}");
}
    // rust: eprintln!("Material oracle case={case}: 15 exact RGBA pixels pass");
}
    // Fault injection: the same production binding must refuse a filtering sampler.
    // If a regression changed both the binding and sampler, the fractional positive
    // probes above would instead mix 0.75*240=180 and 0.75*255=191.25, not 240/255.
    // rust: pass.material_maps = true;
    // rust: post.material_maps = Some([atlases[1].view.clone(), atlases[0].view.clone()]);
    // rust: post.nearest_repeat = sampler(&device, wgpu::FilterMode::Linear, wgpu::AddressMode::Repeat);
    // rust: pass.groups.clear();
    // rust: let validation = device.push_error_scope(wgpu::ErrorFilter::Validation);
    // rust: let mut encoder = device.create_command_encoder(&Default::default());
    // rust: let _invalid_group = post.bind(&device, &queue, &mut encoder, &mut pass, [15, 1]);
    // rust: let error = pollster::block_on(validation.pop())
    // rust: .expect("production material binding must reject a filtering sampler");
    // rust: assert!(
    // rust: error.to_string().to_ascii_lowercase().contains("filtering"),
    // rust: "{error}"
    // rust: );
    // rust: eprintln!("Material oracle negative filtering control: rejected by production binding");
    // rust: std::fs::remove_dir_all(root).unwrap();
}
