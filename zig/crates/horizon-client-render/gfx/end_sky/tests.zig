//! Transpiled from Horizon Rust crate
//! Module: horizon-client-render_tests
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

// use super::*;
// use crate::gfx::{Globals, Renderer};
// use bytemuck::Zeroable;
// use glam::Mat4;

pub fn geometry_matches_pre_residency_vertex_snapshots() void {
}
//     use sha2::{Digest, Sha256};
    // Captured from game/end.rs at 34c3c1cf for full, tiled and non-binary UVs.
    // Quantize positions only, avoiding platform sin/cos rounding differences;
    // quad order, UVs, tint, material and light retain their exact byte values.
    // rust: for (uv, expected) in [
    // rust: (
    // rust: [0.0, 0.0, 1.0, 1.0],
    // rust: "82a9be3f3ed1f733017df2c81dc6dff163f67bf739c768e3fd0f90f00c7802f6",
    // rust: ),
    // rust: (
    // rust: [0.125, 0.25, 0.375, 0.5],
    // rust: "05a058bd8e70cff900c8e1c81061892ed27866d86498ebe1e8ae5af4c3b770ef",
    // rust: ),
    // rust: (
    // rust: [0.13, 0.27, 0.41, 0.59],
    // rust: "93064b9fd2e745da46b927b2625edc8a381bb8c6e20b0f0880e816c4c1745ec1",
    // rust: ),
    // rust: ] {
    // rust: let mut mesh = vertices(uv);
    // rust: assert_eq!(mesh.len(), VERTICES as usize);
    // rust: for vertex in &mut mesh {
    // rust: vertex.pos = vertex.pos.map(|x| {
    // rust: let n = (x * 1024.0).round() / 1024.0;
    // rust: if n == 0.0 { 0.0 } else { n }
    // rust: });
}
    // rust: let hash = format!("{:x}", Sha256::digest(bytemuck::cast_slice(&mesh)));
    // rust: assert_eq!(hash, expected);
}
}

pub fn device() O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let instance = crate::gfx::test_gpu::instance();
    // rust: let adapter = pollster::block_on(instance.request_adapter(&Default::default())).ok()?;
    // rust: eprintln!("End sky test adapter: {:?}", adapter.get_info());
    // rust: pollster::block_on(adapter.request_device(&Default::default())).ok()
}

pub fn resident_buffer_survives_frames_and_refreshes_with_the_atlas() void {
}
    // rust: let Some((device, _)) = device() else {
    // rust: eprintln!("no GPU adapter: skipped");
    // rust: return;
}
    // rust: let mut sky = EndSky::default();
    // rust: let uv = [0.125, 0.25, 0.375, 0.5];
    // rust: sky.prepare(&device, Some(uv));
    // rust: let first = sky.mesh.as_ref().unwrap().1.clone();
    // rust: assert_eq!(
    // rust: first.size(),
    // rust: u64::from(VERTICES) * size_of::<Vertex>() as u64
    // rust: );
    // Immutable: steady-state frames cannot upload into this buffer.
    // rust: assert_eq!(first.usage(), wgpu::BufferUsages::VERTEX);
    // rust: for _ in 0..600 {
    // rust: sky.prepare(&device, Some(uv));
    // rust: assert_eq!(sky.mesh.as_ref().unwrap().1, first);
}
    // rust: let moved = [0.5, 0.5, 0.75, 0.75];
    // rust: sky.prepare(&device, Some(moved));
    // rust: assert_ne!(sky.mesh.as_ref().unwrap().1, first);
    // rust: assert_eq!(sky.mesh.as_ref().unwrap().0, moved);
    // rust: sky.prepare(&device, None);
    // rust: assert!(sky.mesh.is_none());
    // rust: sky.prepare(&device, Some(uv));
    // rust: assert_ne!(sky.mesh.as_ref().unwrap().1, first);
    // A resource reload/device recreation starts a new renderer-owned cache,
    // even if the replacement atlas happens to use exactly the same UVs.
    // rust: let mut replacement = EndSky::default();
    // rust: replacement.prepare(&device, Some(uv));
    // rust: assert_ne!(
    // rust: replacement.mesh.as_ref().unwrap().1,
    // rust: sky.mesh.as_ref().unwrap().1
    // rust: );
}

/// The actual entity shader and celestial blend, comparing the old combined
/// vertex stream with a resident sky draw followed by a separate flash draw.
pub fn separate_draws_match_combined_celestial_pixels() void {
}
    // rust: let Some((device, queue)) = device() else {
    // rust: eprintln!("no GPU adapter: skipped");
    // rust: return;
}
    // rust: let shader = device.create_shader_module(wgpu::ShaderModuleDescriptor {
    // rust: label: Some("End sky differential shader"),
    // rust: source: wgpu::ShaderSource::Wgsl(crate::gfx::entity_shader().into()),
    // rust: });
    // rust: let attributes = wgpu::vertex_attr_array![0=>Float32x3,1=>Float32x2,2=>Uint32,3=>Unorm8x4,4=>Uint8x4,5=>Snorm8x4,6=>Float32x2];
    // rust: let pipeline = device.create_render_pipeline(&wgpu::RenderPipelineDescriptor {
    // rust: label: Some("End sky differential pipeline"),
    // rust: layout: None,
    // rust: vertex: wgpu::VertexState {
    // rust: module: &shader,
    // rust: entry_point: Some("vs_entity"),
    // rust: compilation_options: Default::default(),
    // rust: buffers: &[Some(wgpu::VertexBufferLayout {
    // rust: array_stride: size_of::<Vertex>() as u64,
    // rust: step_mode: wgpu::VertexStepMode::Vertex,
    // rust: attributes: &attributes,
    // rust: })],
    // rust: },
    // rust: primitive: wgpu::PrimitiveState {
    // rust: cull_mode: None,
    // rust: ..Default::default()
    // rust: },
    // rust: depth_stencil: None,
    // rust: multisample: Default::default(),
    // rust: fragment: Some(wgpu::FragmentState {
    // rust: module: &shader,
    // rust: entry_point: Some("fs_celestial"),
    // rust: compilation_options: Default::default(),
    // rust: targets: &[Some(wgpu::ColorTargetState {
    // rust: format: wgpu::TextureFormat::Rgba8Unorm,
    // rust: blend: Some(wgpu::BlendState {
    // rust: color: wgpu::BlendComponent {
    // rust: src_factor: wgpu::BlendFactor::SrcAlpha,
    // rust: dst_factor: wgpu::BlendFactor::One,
    // rust: operation: wgpu::BlendOperation::Add,
    // rust: },
    // rust: alpha: wgpu::BlendComponent::OVER,
    // rust: }),
    // rust: write_mask: wgpu::ColorWrites::ALL,
    // rust: })],
    // rust: }),
    // rust: multiview_mask: None,
    // rust: cache: None,
    // rust: });
    // rust: let texture = |pixels: &[u8], width, height| {
    // rust: device.create_texture_with_data(
    // rust: &queue,
    // rust: &wgpu::TextureDescriptor {
    // rust: label: None,
    // rust: size: wgpu::Extent3d {
    // rust: width,
    // rust: height,
    // rust: depth_or_array_layers: 1,
    // rust: },
    // rust: mip_level_count: 1,
    // rust: sample_count: 1,
    // rust: dimension: wgpu::TextureDimension::D2,
    // rust: format: wgpu::TextureFormat::Rgba8Unorm,
    // rust: usage: wgpu::TextureUsages::TEXTURE_BINDING,
    // rust: view_formats: &[],
    // rust: },
    // rust: wgpu::util::TextureDataOrder::LayerMajor,
    // rust: pixels,
    // rust: )
}
    // Asymmetric, translucent texels expose UV/winding and blend-order errors.
    // rust: let pixels: Vec<u8> = (0..16 * 16)
    // rust: .flat_map(|i| {
    // rust: [
    // rust: (i * 17) as u8,
    // rust: (i * 31) as u8,
    // rust: (i * 7) as u8,
    // rust: (80 + i % 176) as u8,
    // rust: ]
    // rust: })
    // rust: .collect();
    // rust: let atlas = texture(&pixels, 16, 16).create_view(&Default::default());
    // rust: let lightmap = texture(&[255; 4], 1, 1).create_view(&Default::default());
    // rust: let sampler = device.create_sampler(&Default::default());
    // rust: let uniform = device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: None,
    // rust: size: size_of::<Globals>() as u64,
    // rust: usage: wgpu::BufferUsages::UNIFORM | wgpu::BufferUsages::COPY_DST,
    // rust: mapped_at_creation: false,
    // rust: });
    // rust: let group = device.create_bind_group(&wgpu::BindGroupDescriptor {
    // rust: label: None,
    // rust: layout: &pipeline.get_bind_group_layout(0),
    // rust: entries: &[
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 0,
    // rust: resource: uniform.as_entire_binding(),
    // rust: },
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 1,
    // rust: resource: wgpu::BindingResource::TextureView(&atlas),
    // rust: },
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 2,
    // rust: resource: wgpu::BindingResource::Sampler(&sampler),
    // rust: },
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 3,
    // rust: resource: wgpu::BindingResource::TextureView(&lightmap),
    // rust: },
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 4,
    // rust: resource: wgpu::BindingResource::Sampler(&sampler),
    // rust: },
    // rust: ],
    // rust: });
    // rust: let indices = Renderer::quad_indices(&device, VERTICES / 4 + 1);
    // rust: let mut resident = EndSky::default();
    // rust: let uv = [0.125, 0.25, 0.375, 0.5];
    // rust: resident.prepare(&device, Some(uv));
    // rust: let first = resident.mesh.as_ref().unwrap().1.clone();
    // rust: let render = |sky: &EndSky, flash: &[Vertex], combined: bool| {
    // rust: let target = device.create_texture(&wgpu::TextureDescriptor {
    // rust: label: None,
    // rust: size: wgpu::Extent3d {
    // rust: width: 64,
    // rust: height: 64,
    // rust: depth_or_array_layers: 1,
    // rust: },
    // rust: mip_level_count: 1,
    // rust: sample_count: 1,
    // rust: dimension: wgpu::TextureDimension::D2,
    // rust: format: wgpu::TextureFormat::Rgba8Unorm,
    // rust: usage: wgpu::TextureUsages::RENDER_ATTACHMENT | wgpu::TextureUsages::COPY_SRC,
    // rust: view_formats: &[],
    // rust: });
    // rust: let view = target.create_view(&Default::default());
    // rust: let mut vertices = if combined { vertices(uv) } else { Vec::new() };
    // rust: vertices.extend_from_slice(flash);
    // rust: let buffer = device.create_buffer_init(&wgpu::util::BufferInitDescriptor {
    // rust: label: None,
    // rust: contents: bytemuck::cast_slice(&vertices),
    // rust: usage: wgpu::BufferUsages::VERTEX,
    // rust: });
    // rust: let readback = device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: None,
    // rust: size: 64 * 64 * 4,
    // rust: usage: wgpu::BufferUsages::COPY_DST | wgpu::BufferUsages::MAP_READ,
    // rust: mapped_at_creation: false,
    // rust: });
    // rust: let mut encoder = device.create_command_encoder(&Default::default());
    // rust: {
    // rust: let mut pass = encoder.begin_render_pass(&wgpu::RenderPassDescriptor {
    // rust: color_attachments: &[Some(wgpu::RenderPassColorAttachment {
    // rust: view: &view,
    // rust: depth_slice: None,
    // rust: resolve_target: None,
    // rust: ops: wgpu::Operations {
    // rust: load: wgpu::LoadOp::Clear(wgpu::Color::BLACK),
    // rust: store: wgpu::StoreOp::Store,
    // rust: },
    // rust: })],
    // rust: ..Default::default()
    // rust: });
    // rust: pass.set_pipeline(&pipeline);
    // rust: pass.set_bind_group(0, &group, &[]);
    // rust: pass.set_index_buffer(indices.slice(..), wgpu::IndexFormat::Uint32);
    // rust: if !combined {
    // rust: sky.draw(&mut pass);
}
    // rust: if !vertices.is_empty() {
    // rust: pass.set_vertex_buffer(0, buffer.slice(..));
    // rust: pass.draw_indexed(0..vertices.len() as u32 / 4 * 6, 0, 0..1);
}
}
    // rust: encoder.copy_texture_to_buffer(
    // rust: target.as_image_copy(),
    // rust: wgpu::TexelCopyBufferInfo {
    // rust: buffer: &readback,
    // rust: layout: wgpu::TexelCopyBufferLayout {
    // rust: offset: 0,
    // rust: bytes_per_row: Some(256),
    // rust: rows_per_image: Some(64),
    // rust: },
    // rust: },
    // rust: target.size(),
    // rust: );
    // rust: queue.submit([encoder.finish()]);
    // rust: readback
    // rust: .slice(..)
    // rust: .map_async(wgpu::MapMode::Read, |r| r.unwrap());
    // rust: device.poll(wgpu::PollType::wait_indefinitely()).unwrap();
    // rust: readback.slice(..).get_mapped_range().unwrap().to_vec()
}
    // rust: let mut cases = 0;
    // rust: let mut visible_flash_cases = 0;
    // rust: for yaw in [0.0_f32, 45.0, 90.0, 180.0, 270.0] {
    // rust: for pitch in [-85.0_f32, -30.0, 0.0, 45.0, 85.0] {
    // rust: let mut globals = Globals::zeroed();
    // rust: globals.view_proj = (Mat4::perspective_rh(90_f32.to_radians(), 1.0, 0.05, 1024.0)
    // rust: * Mat4::from_rotation_x(pitch.to_radians())
    // rust: * Mat4::from_rotation_y(yaw.to_radians()))
    // rust: .to_cols_array_2d();
    // rust: queue.write_buffer(&uniform, 0, bytemuck::bytes_of(&globals));
    // rust: let no_flash = render(&resident, &[], true);
    // rust: for level in [0_u32, 1, 127, 255] {
    // rust: let flash: Vec<_> = if level == 0 {
    // rust: Vec::new()
    // rust: } else {
                    // Same flash size/height, with an arbitrary EndFlashState pose.
    // rust: let pose = Mat4::from_rotation_y(1.3) * Mat4::from_rotation_x(-1.6);
    // rust: [(-60.0, -60.0), (60.0, -60.0), (60.0, 60.0), (-60.0, 60.0)]
    // rust: .map(|(x, z)| Vertex {
    // rust: pos: pose.transform_point3(glam::vec3(x, 100.0, z)).to_array(),
    // rust: uv: [0.75 + x / 480.0, 0.75 + z / 480.0],
    // rust: layer: 2,
    // rust: color: level * 0x01010101,
    // rust: light: 0,
    // rust: normal: [0; 4],

    // rust: glint_uv: [0.0, 0.0],
    // rust: })
    // rust: .to_vec()
}
    // rust: resident.prepare(&device, Some(uv));
    // rust: let expected = render(&resident, &flash, true);
    // rust: let actual = render(&resident, &flash, false);
    // rust: visible_flash_cases += usize::from(expected != no_flash);
    // rust: assert_eq!(actual, expected, "yaw={yaw} pitch={pitch} flash={level}");
    // rust: assert!(
    // rust: actual.as_chunks::<4>().0.iter().any(|p| p[..3] != [0; 3]),
    // rust: "empty frame"
    // rust: );
    // rust: assert_eq!(resident.mesh.as_ref().unwrap().1, first);
    // rust: cases += 1;
}
}
}
    // rust: assert!(
    // rust: visible_flash_cases > 0,
    // rust: "the flash must affect the comparison"
    // rust: );
    // rust: eprintln!("{cases} combined/resident framebuffer cases matched exactly");
}
