//! Transpiled from Horizon Rust crate
//! Module: horizon-client-render_midpoint_test
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Original GPU probes of the production terrain inputs, without a resource or shader pack.

// use super::PackAtlas;
// use crate::mesher::{TerrainVertex, UV_STEPS};
// use wgpu::util::DeviceExt;

pub fn mid_tex_coord_follows_each_quads_mapped_corners() void {
}
    // rust: let instance = crate::gfx::test_gpu::instance();
    // rust: let Ok(adapter) = pollster::block_on(instance.request_adapter(&Default::default())) else {
    // rust: return;
}
    // rust: let (device, queue) = pollster::block_on(adapter.request_device(&Default::default())).unwrap();
    // rust: eprintln!("midpoint probe adapter: {:?}", adapter.get_info());
    // rust: let texture = device.create_texture(&wgpu::TextureDescriptor {
    // rust: label: None,
    // rust: size: wgpu::Extent3d {
    // rust: width: 16,
    // rust: height: 16,
    // rust: depth_or_array_layers: 5,
    // rust: },
    // rust: mip_level_count: 1,
    // rust: sample_count: 1,
    // rust: dimension: wgpu::TextureDimension::D2,
    // rust: format: wgpu::TextureFormat::Rgba8Unorm,
    // rust: usage: wgpu::TextureUsages::TEXTURE_BINDING | wgpu::TextureUsages::COPY_SRC,
    // rust: view_formats: &[],
    // rust: });
    // rust: let mut encoder = device.create_command_encoder(&Default::default());
    // rust: let atlas = PackAtlas::new(&device, &mut encoder, &[texture], 5, 5, 16).unwrap();
    // rust: queue.submit([encoder.finish()]);
    // Each row uses a different atlas cell. Expected atlas coordinates are independent
    // numbers, including the existing clamp of a model UV beyond the sprite's edge.
    // rust: let cases = [
    // rust: (
    // rust: "whole",
    // rust: [[0., 0.], [1., 0.], [1., 1.], [0., 1.]],
    // rust: [1. / 6., 0.25],
    // rust: [1. / 6., 0.25],
    // rust: [[0., 0.], [1. / 3., 0.], [1. / 3., 0.5], [0., 0.5]],
    // rust: ),
    // rust: (
    // rust: "half-height",
    // rust: [[0., 0.], [1., 0.], [1., 0.5], [0., 0.5]],
    // rust: [0.5, 0.125],
    // rust: [0.5, 0.25],
    // rust: [
    // rust: [1. / 3., 0.],
    // rust: [2. / 3., 0.],
    // rust: [2. / 3., 0.25],
    // rust: [1. / 3., 0.25],
    // rust: ],
    // rust: ),
    // rust: (
    // rust: "rotated partial",
    // rust: [[0.25, 0.75], [0.25, 0.25], [0.5, 0.25], [0.5, 0.75]],
    // rust: [19. / 24., 0.25],
    // rust: [5. / 6., 0.25],
    // rust: [
    // rust: [0.75, 0.375],
    // rust: [0.75, 0.125],
    // rust: [5. / 6., 0.125],
    // rust: [5. / 6., 0.375],
    // rust: ],
    // rust: ),
    // rust: (
    // rust: "clamped",
    // rust: [[0., 0.], [1.5, 0.], [1.5, 0.5], [0., 0.5]],
    // rust: [1. / 6., 0.625],
    // rust: [1. / 6., 0.75],
    // rust: [[0., 0.5], [1. / 3., 0.5], [1. / 3., 0.75], [0., 0.75]],
    // rust: ),
    // rust: (
    // rust: "fourth corner",
    // rust: [[0., 0.], [1., 0.], [1., 0.5], [0., 1.]],
    // rust: [0.5, 0.6875],
    // rust: [0.5, 0.75],
    // rust: [
    // rust: [1. / 3., 0.5],
    // rust: [2. / 3., 0.5],
    // rust: [2. / 3., 0.75],
    // rust: [1. / 3., 1.],
    // rust: ],
    // rust: ),
    // rust: ];
    // rust: let positions = [[0., 0., 0.], [1., 0., 0.], [1., 1., 0.], [0., 1., 0.]];
    // rust: let vertices: Vec<_> = cases
    // rust: .iter()
    // rust: .enumerate()
    // rust: .flat_map(|(layer, (_, uv, ..))| {
    // rust: (0..4).map(move |k| {
    // rust: TerrainVertex::new(positions[k], uv[k], layer as u16 | 0x8000, u32::MAX, 0)
    // rust: })
    // rust: })
    // rust: .collect();
    // rust: let mut failures = Vec::new();
    // Positive origins encode fade bits beside the power-of-two scale. Negative origins
    // use the older fractional scale encoding. Both must match the mapped vertex UVs.
    // rust: for origin in [
    // rust: f32::from_bits((1. / UV_STEPS).to_bits() | 0x12345),
    // rust: -3. - 1. / UV_STEPS,
    // rust: ] {
    // rust: for flat in [true, false] {
    // rust: for shadow in [false, true] {
    // rust: let pixels = sample(&device, &queue, &atlas, &vertices, origin, [flat, shadow]);
    // rust: for (quad, (name, _, midpoint, fallback, mapped)) in cases.iter().enumerate() {
    // rust: let centre = if flat { midpoint } else { fallback };
    // rust: for (corner, uv) in mapped.iter().enumerate() {
    // rust: let actual = pixels[4 * quad + corner];
    // rust: let expected = [centre[0], centre[1], uv[0], uv[1]];
    // rust: if actual
    // rust: .iter()
    // rust: .zip(expected)
    // rust: .any(|(a, b)| !a.is_finite() || (a - b).abs() > 1e-6)
    // rust: {
    // rust: failures.push(format!("{name} corner {corner}, flat={flat} shadow={shadow} origin={origin}: {actual:?} != {expected:?}"));
}
}
}
}
}
}
    // rust: assert!(failures.is_empty(), "{}", failures.join("\n"));
}

/// A stitched atlas (the one `stitched_sprites_keep_their_own_size_and_padding` works out: 16 by
/// 8, sprites of 2, 4 and 1 px at (9, 1), (1, 1) and (9, 5)): flat draws map a quad's UVs onto its
/// sprite's own pixels, so a corner is half the sprite's own side from `mc_midTexCoord`.
pub fn flat_draws_map_uvs_onto_a_stitched_sprite() void {
}
    // rust: let instance = crate::gfx::test_gpu::instance();
    // rust: let Ok(adapter) = pollster::block_on(instance.request_adapter(&Default::default())) else {
    // rust: return;
}
    // rust: let (device, queue) = pollster::block_on(adapter.request_device(&Default::default())).unwrap();
    // rust: let array = super::tests::upscaled_array(&device, &queue, &[2, 4, 1]);
    // rust: let mut encoder = device.create_command_encoder(&Default::default());
    // rust: let atlas =
    // rust: PackAtlas::stitched(&device, &mut encoder, &[array], 3, 4, &[2, 4, 1], 0, 0).unwrap();
    // rust: queue.submit([encoder.finish()]);
    // rust: let whole = [[0., 0.], [1., 0.], [1., 1.], [0., 1.]];
    // rust: let positions = [[0., 0., 0.], [1., 0., 0.], [1., 1., 0.], [0., 1., 0.]];
    // rust: let vertices: Vec<_> = (0..3)
    // rust: .flat_map(|layer| {
    // rust: (0..4).map(move |k| {
    // rust: TerrainVertex::new(positions[k], whole[k], layer as u16 | 0x8000, u32::MAX, 0)
    // rust: })
    // rust: })
    // rust: .collect();
    // Corner and side of each layer's sprite, in atlas pixels.
    // rust: let sprites = [([9., 1.], 2.), ([1., 1.], 4.), ([9., 5.], 1.)];
    // rust: let origin = f32::from_bits((1. / UV_STEPS).to_bits());
    // rust: let pixels = sample(&device, &queue, &atlas, &vertices, origin, [true, false]);
    // rust: let mut failures = Vec::new();
    // rust: for (layer, ([x, y], side)) in sprites.into_iter().enumerate() {
    // rust: let mid = [(x + side / 2.) / 16., (y + side / 2.) / 8.];
    // rust: for (corner, [u, v]) in whole.iter().enumerate() {
    // rust: let expected = [mid[0], mid[1], (x + u * side) / 16., (y + v * side) / 8.];
    // rust: let actual = pixels[4 * layer + corner];
    // rust: if actual
    // rust: .iter()
    // rust: .zip(expected)
    // rust: .any(|(a, b)| (a - b).abs() > 1e-6)
    // rust: {
    // rust: failures.push(format!(
    // rust: "layer {layer} corner {corner}: {actual:?} != {expected:?}"
    // rust: ));
}
}
}
    // rust: assert!(failures.is_empty(), "{}", failures.join("\n"));
}

/// Read back with a probe pack of ours, Iris 1.11.7's terrain `gl_Vertex` (camera on the block
/// grid) puts a water top, 8/9 - 0.001 of a block up, at 29094/32768, and plants offset by 13/15
/// and 0.1 of a block at 28398/32768 and 3276/32768 (#8464): each 32768th below the position.
/// Whole blocks and sixteenths stay where they are, and so does a place float rounding put a hair
/// below a grid line: Iris reads plants offset by 9/15 exactly on a half block.
pub fn terrain_vertices_go_down_to_the_32768th_below_them() void {
}
    // rust: let instance = crate::gfx::test_gpu::instance();
    // rust: let Ok(adapter) = pollster::block_on(instance.request_adapter(&Default::default())) else {
    // rust: return;
}
    // rust: let (device, queue) = pollster::block_on(adapter.request_device(&Default::default())).unwrap();
    // rust: let texture = device.create_texture(&wgpu::TextureDescriptor {
    // rust: label: None,
    // rust: size: wgpu::Extent3d {
    // rust: width: 16,
    // rust: height: 16,
    // rust: depth_or_array_layers: 1,
    // rust: },
    // rust: mip_level_count: 1,
    // rust: sample_count: 1,
    // rust: dimension: wgpu::TextureDimension::D2,
    // rust: format: wgpu::TextureFormat::Rgba8Unorm,
    // rust: usage: wgpu::TextureUsages::TEXTURE_BINDING | wgpu::TextureUsages::COPY_SRC,
    // rust: view_formats: &[],
    // rust: });
    // rust: let mut encoder = device.create_command_encoder(&Default::default());
    // rust: let atlas = PackAtlas::new(&device, &mut encoder, &[texture], 1, 1, 16).unwrap();
    // rust: queue.submit([encoder.finish()]);
    // rust: let water = 8.0f32 / 9.0 - 0.001;
    // rust: let cases = [
    // rust: ([0.1, water, 13.0 / 15.0], [3276.0, 29094.0, 28398.0]),
    // rust: ([13.0 / 15.0, 0.1, water], [28398.0, 3276.0, 29094.0]),
    // rust: ([1.0, 0.5, 15.9375], [32768.0, 16384.0, 522240.0]),
        // One float step below 1, 0.5 and 9.5.
    // rust: (
    // rust: [
    // rust: 1.0 - f32::EPSILON / 2.0,
    // rust: 0.5 - f32::EPSILON / 4.0,
    // rust: 9.5 - f32::EPSILON * 8.0,
    // rust: ],
    // rust: [32768.0, 16384.0, 311296.0],
    // rust: ),
    // rust: ];
    // rust: let vertices: Vec<_> = cases
    // rust: .iter()
    // rust: .map(|&(pos, _)| TerrainVertex::new(pos, [0.0, 0.0], 0x8000, u32::MAX, 0))
    // rust: .collect();
    // rust: let origin = f32::from_bits((1. / UV_STEPS).to_bits());
    // rust: let mut failures = Vec::new();
    // rust: for flat in [true, false] {
    // rust: for shadow in [false, true] {
    // rust: let read = sample_probe(
    // rust: &device,
    // rust: &queue,
    // rust: &atlas,
    // rust: &vertices,
    // rust: origin,
    // rust: [flat, shadow],
    // rust: "gl_Vertex",
    // rust: );
    // rust: for ((pos, expected), got) in cases.iter().zip(&read) {
    // rust: let got = [got[0], got[1], got[2]].map(|v| v * 32768.0);
    // rust: if got != *expected {
    // rust: failures.push(format!(
    // rust: "{pos:?}, flat={flat} shadow={shadow}: {got:?} != {expected:?}"
    // rust: ));
}
}
}
}
    // rust: assert!(failures.is_empty(), "{}", failures.join("\n"));
}

    // rust: fn sample(
    // rust: device: &wgpu::Device,
    // rust: queue: &wgpu::Queue,
    // rust: atlas: &PackAtlas,
    // rust: vertices: &[TerrainVertex],
    // rust: scale: f32,
    // rust: flags: [bool; 2],
    // rust: ) -> Vec<[f32; 4]> {
    // rust: sample_probe(
    // rust: device,
    // rust: queue,
    // rust: atlas,
    // rust: vertices,
    // rust: scale,
    // rust: flags,
    // rust: "vec4(mc_midTexCoord, gl_MultiTexCoord0.xy)",
    // rust: )
}

/// What the pack's vertex stage sets `probe` to (`expression`), for each of `vertices`.
    // rust: fn sample_probe(
    // rust: device: &wgpu::Device,
    // rust: queue: &wgpu::Queue,
    // rust: atlas: &PackAtlas,
    // rust: vertices: &[TerrainVertex],
    // rust: scale: f32,
    // rust: [flat, shadow]: [bool; 2],
    // rust: expression: &str,
    // rust: ) -> Vec<[f32; 4]> {
    // rust: let pp = |code| horizon_shaders::Preprocessed {
    // rust: code,
    // rust: ..Default::default()
}
    // rust: let vertex = pp(format!(
    // rust: "attribute vec2 mc_midTexCoord;\nvarying vec4 probe;\nvoid main() {{\n\
    // rust: probe = {expression};\n\
    // rust: gl_Position = vec4((float(gl_VertexID) + 0.5) * {} - 1.0, 0.0, 0.0, 1.0);\n}}",
    // rust: 2. / vertices.len() as f32,
    // rust: ));
    // Integer attachments retain the float bits without requiring float-render-target
    // capabilities on the adapter that the test runner picks.
    // rust: let fragment = pp(
    // rust: "varying vec4 probe;\nlayout(location = 0) out uvec4 midpoint_bits;\n\
    // rust: void main() { midpoint_bits = floatBitsToUint(probe); }"
    // rust: .into(),
    // rust: );
    // rust: let inputs = atlas.terrain_inputs(flat);
    // rust: let program = if shadow {
    // rust: horizon_shaders::translate_shadow(&vertex, &fragment, &inputs)
    // rust: } else {
    // rust: horizon_shaders::translate_gbuffers(
    // rust: &vertex,
    // rust: &fragment,
    // rust: horizon_shaders::Target::Buffers,
    // rust: &inputs,
    // rust: )
}
    // rust: .unwrap();
    // rust: let storage = |binding| wgpu::BindGroupLayoutEntry {
    // rust: binding,
    // rust: visibility: wgpu::ShaderStages::VERTEX,
    // rust: ty: wgpu::BindingType::Buffer {
    // rust: ty: wgpu::BufferBindingType::Storage { read_only: true },
    // rust: has_dynamic_offset: false,
    // rust: min_binding_size: None,
    // rust: },
    // rust: count: None,
}
    // rust: let entries = [
    // rust: vec![wgpu::BindGroupLayoutEntry {
    // rust: binding: 0,
    // rust: visibility: wgpu::ShaderStages::VERTEX_FRAGMENT,
    // rust: ty: wgpu::BindingType::Buffer {
    // rust: ty: wgpu::BufferBindingType::Uniform,
    // rust: has_dynamic_offset: false,
    // rust: min_binding_size: None,
    // rust: },
    // rust: count: None,
    // rust: }],
    // rust: vec![storage(0), storage(1)],
    // rust: vec![],
    // rust: vec![storage(0), storage(1), storage(2)],
    // rust: ];
    // rust: let layouts: Vec<_> = entries
    // rust: .iter()
    // rust: .map(|entries| {
    // rust: device.create_bind_group_layout(&wgpu::BindGroupLayoutDescriptor {
    // rust: label: None,
    // rust: entries,
    // rust: })
    // rust: })
    // rust: .collect();
    // rust: let layout = device.create_pipeline_layout(&wgpu::PipelineLayoutDescriptor {
    // rust: label: None,
    // rust: bind_group_layouts: &layouts.iter().map(Some).collect::<Vec<_>>(),
    // rust: ..Default::default()
    // rust: });
    // rust: let module = |module| {
    // rust: device.create_shader_module(wgpu::ShaderModuleDescriptor {
    // rust: label: None,
    // rust: source: wgpu::ShaderSource::Naga(std::borrow::Cow::Owned(module)),
    // rust: })
}
    // rust: let vs = module(program.vertex);
    // rust: let fs = module(program.fragment);
    // rust: let vertex_layouts = [
    // rust: Some(wgpu::VertexBufferLayout {
    // rust: array_stride: std::mem::size_of::<TerrainVertex>() as u64,
    // rust: step_mode: wgpu::VertexStepMode::Vertex,
    // rust: attributes: &crate::gfx::TERRAIN_ATTRIBUTES,
    // rust: }),
    // rust: Some(wgpu::VertexBufferLayout {
    // rust: array_stride: 16,
    // rust: step_mode: wgpu::VertexStepMode::Instance,
    // rust: attributes: &wgpu::vertex_attr_array![5 => Float32x4],
    // rust: }),
    // rust: ];
    // rust: let pipeline = device.create_render_pipeline(&wgpu::RenderPipelineDescriptor {
    // rust: label: None,
    // rust: layout: Some(&layout),
    // rust: vertex: wgpu::VertexState {
    // rust: module: &vs,
    // rust: entry_point: Some("main"),
    // rust: compilation_options: Default::default(),
    // rust: buffers: &vertex_layouts[..if flat { 1 } else { 2 }],
    // rust: },
    // rust: primitive: wgpu::PrimitiveState {
    // rust: topology: wgpu::PrimitiveTopology::PointList,
    // rust: ..Default::default()
    // rust: },
    // rust: depth_stencil: None,
    // rust: multisample: Default::default(),
    // rust: fragment: Some(wgpu::FragmentState {
    // rust: module: &fs,
    // rust: entry_point: Some("main"),
    // rust: compilation_options: Default::default(),
    // rust: targets: &[Some(wgpu::ColorTargetState {
    // rust: format: wgpu::TextureFormat::Rgba32Uint,
    // rust: blend: None,
    // rust: write_mask: wgpu::ColorWrites::ALL,
    // rust: })],
    // rust: }),
    // rust: multiview_mask: None,
    // rust: cache: None,
    // rust: });
    // rust: let buffer = |contents: &[u8], usage| {
    // rust: device.create_buffer_init(&wgpu::util::BufferInitDescriptor {
    // rust: label: None,
    // rust: contents,
    // rust: usage,
    // rust: })
}
    // rust: let uniform = buffer(
    // rust: &vec![0; program.interface.uniform_size.max(16) as usize],
    // rust: wgpu::BufferUsages::UNIFORM,
    // rust: );
    // rust: let slots = buffer(bytemuck::bytes_of(&0u32), wgpu::BufferUsages::STORAGE);
    // rust: let origin = buffer(
    // rust: bytemuck::bytes_of(&[0., 0., 0., scale]),
    // rust: wgpu::BufferUsages::STORAGE | wgpu::BufferUsages::VERTEX,
    // rust: );
    // rust: let ids = buffer(bytemuck::bytes_of(&[0i32; 15]), wgpu::BufferUsages::STORAGE);
    // rust: let data = buffer(
    // rust: bytemuck::cast_slice(vertices),
    // rust: wgpu::BufferUsages::STORAGE | wgpu::BufferUsages::VERTEX,
    // rust: );
    // rust: let rects = buffer(
    // rust: bytemuck::cast_slice(&atlas.rects_table()),
    // rust: wgpu::BufferUsages::STORAGE,
    // rust: );
    // rust: let bindings = [
    // rust: vec![(0, &uniform)],
    // rust: vec![(0, &slots), (1, &origin)],
    // rust: vec![],
    // rust: vec![(0, &ids), (1, &data), (2, &rects)],
    // rust: ];
    // rust: let groups: Vec<_> = bindings
    // rust: .iter()
    // rust: .zip(&layouts)
    // rust: .map(|(buffers, layout)| {
    // rust: device.create_bind_group(&wgpu::BindGroupDescriptor {
    // rust: label: None,
    // rust: layout,
    // rust: entries: &buffers
    // rust: .iter()
    // rust: .map(|&(binding, buffer)| wgpu::BindGroupEntry {
    // rust: binding,
    // rust: resource: buffer.as_entire_binding(),
    // rust: })
    // rust: .collect::<Vec<_>>(),
    // rust: })
    // rust: })
    // rust: .collect();
    // rust: let output = device.create_texture(&wgpu::TextureDescriptor {
    // rust: label: None,
    // rust: size: wgpu::Extent3d {
    // rust: width: vertices.len() as u32,
    // rust: height: 1,
    // rust: depth_or_array_layers: 1,
    // rust: },
    // rust: mip_level_count: 1,
    // rust: sample_count: 1,
    // rust: dimension: wgpu::TextureDimension::D2,
    // rust: format: wgpu::TextureFormat::Rgba32Uint,
    // rust: usage: wgpu::TextureUsages::RENDER_ATTACHMENT | wgpu::TextureUsages::COPY_SRC,
    // rust: view_formats: &[],
    // rust: });
    // rust: let read = device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: None,
    // rust: size: vertices.len() as u64 * 16,
    // rust: usage: wgpu::BufferUsages::MAP_READ | wgpu::BufferUsages::COPY_DST,
    // rust: mapped_at_creation: false,
    // rust: });
    // rust: let mut encoder = device.create_command_encoder(&Default::default());
    // rust: {
    // rust: let view = output.create_view(&Default::default());
    // rust: let mut pass = encoder.begin_render_pass(&wgpu::RenderPassDescriptor {
    // rust: label: None,
    // rust: color_attachments: &[Some(wgpu::RenderPassColorAttachment {
    // rust: view: &view,
    // rust: depth_slice: None,
    // rust: resolve_target: None,
    // rust: ops: wgpu::Operations {
    // rust: load: wgpu::LoadOp::Clear(wgpu::Color::TRANSPARENT),
    // rust: store: wgpu::StoreOp::Store,
    // rust: },
    // rust: })],
    // rust: ..Default::default()
    // rust: });
    // rust: pass.set_pipeline(&pipeline);
    // rust: for (k, group) in groups.iter().enumerate() {
    // rust: pass.set_bind_group(k as u32, group, &[]);
}
    // rust: pass.set_vertex_buffer(0, data.slice(..));
    // rust: if !flat {
    // rust: pass.set_vertex_buffer(1, origin.slice(..));
}
    // rust: pass.draw(0..vertices.len() as u32, 0..1);
}
    // rust: encoder.copy_texture_to_buffer(
    // rust: output.as_image_copy(),
    // rust: wgpu::TexelCopyBufferInfo {
    // rust: buffer: &read,
    // rust: layout: wgpu::TexelCopyBufferLayout::default(),
    // rust: },
    // rust: output.size(),
    // rust: );
    // rust: queue.submit([encoder.finish()]);
    // rust: read.slice(..).map_async(wgpu::MapMode::Read, |_| {});
    // rust: device.poll(wgpu::PollType::wait_indefinitely()).unwrap();
    // rust: let mapped = read.slice(..).get_mapped_range().unwrap();
    // rust: bytemuck::cast_slice::<u8, [f32; 4]>(&mapped).to_vec()
}
