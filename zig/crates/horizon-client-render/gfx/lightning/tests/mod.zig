//! Transpiled from Horizon Rust crate
//! Module: horizon-client-render_mod
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

// use super::*;
// use std::cell::Cell;

// Frozen pre-cache generator: compare every Vertex byte, including primitive
// order and the original camera-relative rounding, without game resources.
pub fn reference(seed: i64, at: [f64; 3], camera: DVec3, uv: [f32; 2]) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut out = Vec::new();
    // ARGB 0.45, 0.45, 0.5 at 0.3 alpha, packed RGBA.
    // rust: let color = (76u32 << 24) | (127 << 16) | (114 << 8) | 114;
    // rust: let b = Bolt { seed, at };
    // rust: {
    // rust: let o = (glam::DVec3::from_array(b.at) - camera).as_vec3();
    // rust: let mut random = LegacyRandom::new(b.seed);
    // rust: let (mut xs, mut zs) = ([0f32; 8], [0f32; 8]);
    // rust: let (mut x_off, mut z_off) = (0f32, 0f32);
    // rust: for i in (0..8).rev() {
    // rust: xs[i] = x_off;
    // rust: zs[i] = z_off;
    // rust: x_off += (random.next_int_bound(11).unwrap_or(5) - 5) as f32;
    // rust: z_off += (random.next_int_bound(11).unwrap_or(5) - 5) as f32;
}
    // rust: for layer in 0..4 {
    // rust: let mut random = LegacyRandom::new(b.seed);
    // rust: for branch in 0..3 {
    // rust: let trunk = branch == 0;
    // rust: let start = 7 - branch;
    // rust: let end = if trunk { 0 } else { start - 3 + 1 };
    // rust: let mut sx = xs[start] - x_off;
    // rust: let mut sz = zs[start] - z_off;
    // rust: for segment in (end..=start).rev() {
    // rust: let (ex, ez) = (sx, sz);
    // rust: let spread = if trunk { 11 } else { 31 };
    // rust: sx += (random.next_int_bound(spread).unwrap_or(0) - spread / 2) as f32;
    // rust: sz += (random.next_int_bound(spread).unwrap_or(0) - spread / 2) as f32;
    // rust: let mut top = 0.1 + layer as f32 * 0.2;
    // rust: let mut bottom = top;
    // rust: if trunk {
    // rust: top *= segment as f32 * 0.1 + 1.0;
    // rust: bottom *= (segment as f32 - 1.0) * 0.1 + 1.0;
}
    // rust: for (rx, rz, lx, lz) in [
    // rust: (false, false, true, false),
    // rust: (true, false, true, true),
    // rust: (true, true, false, true),
    // rust: (false, true, false, false),
    // rust: ] {
    // rust: let s = |p: bool, r: f32| if p { r } else { -r };
    // rust: let y0 = segment as f32 * 16.0;
    // rust: let corners = [
    // rust: [sx + s(rx, bottom), y0, sz + s(rz, bottom)],
    // rust: [ex + s(rx, top), y0 + 16.0, ez + s(rz, top)],
    // rust: [ex + s(lx, top), y0 + 16.0, ez + s(lz, top)],
    // rust: [sx + s(lx, bottom), y0, sz + s(lz, bottom)],
    // rust: ];
    // rust: for c in corners {
    // rust: out.push(Vertex {
    // rust: normal: [0; 4],
    // rust: pos: (o + glam::Vec3::from_array(c)).to_array(),
    // rust: uv,
                                // The HDR tier lightning.rs adds; the geometry is vanilla's.
    // rust: layer: 2 | u32::from(crate::mesher::VERY_BRIGHT) << 16,
    // rust: color,
    // rust: light: 240 | 240 << 8,

    // rust: glint_uv: [0.0, 0.0],
    // rust: });
}
}
}
}
}
}
    // rust: out
}

pub fn seeds() V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut seeds = vec![0, 1, -1, i64::MIN, i64::MAX, 0x123456789abcdef];
    // rust: let mut random = LegacyRandom::new(42);
    // rust: seeds.extend((0..256).map(|_| random.next_long()));
    // rust: seeds
}

/// Pinned 26.3 LightningBoltRenderer.lambda$submit$0, captured with an
/// identity PoseStack and a VertexConsumer recording big-endian xyz floats.
pub fn geometry_matches_pinned_vanilla_vertex_digest() void {
}
//     use sha2::{Digest, Sha256};
    // rust: let mut digest = Sha256::new();
    // rust: for seed in seeds() {
    // rust: for vertex in geometry(seed, [0.0; 2]) {
    // rust: for value in vertex.pos {
    // rust: digest.update(value.to_be_bytes());
}
}
}
    // rust: assert_eq!(
    // rust: format!("{:x}", digest.finalize()),
    // rust: "a9ed25caa50b9aa340faa4bb417b3d533b061f0dce66514e4bb212931444dee6"
    // rust: );
}

pub fn retained_geometry_matches_original_generator() void {
}
    // rust: let uv = [0.8125, 0.03125];
    // rust: for seed in seeds() {
    // rust: let local = geometry(seed, uv);
    // rust: assert_eq!(local.len(), QUADS as usize * 4);
    // rust: for (at, camera) in [
    // rust: ([0.0; 3], DVec3::ZERO),
    // rust: ([12.5, 64.0, -12.5], DVec3::new(-4.25, 71.125, 32.5)),
    // rust: (
    // rust: [29_999_999.5, -64.0, -29_999_999.5],
    // rust: DVec3::new(29_999_987.125, 67.75, -29_999_983.875),
    // rust: ),
    // rust: ] {
    // rust: let offset = offset(&Bolt { seed, at }, camera);
    // rust: let translated: Vec<_> = local
    // rust: .iter()
    // rust: .map(|v| Vertex {
    // rust: pos: (glam::Vec3::from_array(offset) + glam::Vec3::from_array(v.pos))
    // rust: .to_array(),
    // rust: ..*v
    // rust: })
    // rust: .collect();
    // rust: let expected = reference(seed, at, camera, uv);
    // rust: assert_eq!(
    // rust: bytemuck::cast_slice::<_, u8>(&translated),
    // rust: bytemuck::cast_slice::<_, u8>(&expected),
    // rust: "seed {seed}"
    // rust: );
}
}
}

pub fn cache_tracks_seed_lifecycle_movement_and_atlas_reload() void {
}
    // rust: let mut cache = Cache::new();
    // rust: let builds = Cell::new(0);
    // rust: let build = |seed, uv| {
    // rust: builds.set(builds.get() + 1);
    // rust: geometry(seed, uv)
}
    // rust: let mut bolts = [
    // rust: Bolt {
    // rust: seed: 123,
    // rust: at: [0.0; 3],
    // rust: },
    // rust: Bolt {
    // rust: seed: 456,
    // rust: at: [1.0; 3],
    // rust: },
    // rust: ];
pub fn input(bolts: *[Bolt]) I {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Input {
    // rust: bolts,
    // rust: uv: [0.25, 0.5],
}
}
    // rust: cache.prepare(&input(&bolts), build);
    // rust: assert_eq!(builds.get(), 2);
    // rust: assert_eq!(cache.meshes.len(), 2);
    // Any number of rendered frames or multiplayer position updates reuse meshes.
    // rust: for i in 0..100 {
    // rust: bolts[0].at = [i as f64; 3];
    // rust: cache.prepare(&input(&bolts), build);
}
    // rust: assert_eq!(builds.get(), 2);
    // A flash changes the seed; retire its previous mesh immediately.
    // rust: bolts[0].seed = 789;
    // rust: cache.prepare(&input(&bolts), build);
    // rust: assert_eq!(builds.get(), 3);
    // rust: assert!(!cache.meshes.contains_key(&123));
    // Removal retains other bolts, and repeated seeds still share geometry.
    // rust: bolts[0].seed = 456;
    // rust: cache.prepare(&input(&bolts), build);
    // rust: assert_eq!(builds.get(), 3);
    // rust: assert_eq!(cache.meshes.len(), 1);
    // Atlas replacement must update white texel UVs without changing the seed.
    // rust: cache.prepare(
    // rust: &Input {
    // rust: bolts: &bolts,
    // rust: uv: [0.75, 0.25],
    // rust: },
    // rust: build,
    // rust: );
    // rust: assert_eq!(builds.get(), 4);
    // rust: assert_eq!(cache.meshes[&456].mesh[0].uv, [0.75, 0.25]);
    // Disconnect/dimension switch/expiry drops every retained resource.
    // rust: cache.prepare(&Input::default(), build);
    // rust: assert!(cache.meshes.is_empty());
    // rust: assert_eq!(cache.meshes.capacity(), 0);
    // rust: cache.prepare(&input(&bolts), build);
    // rust: assert_eq!(builds.get(), 5);
}

pub fn long_flash_sequence_keeps_only_active_seeds() void {
}
    // rust: let mut cache = Cache::new();
    // rust: for seed in 0..10_000 {
    // rust: cache.prepare(
    // rust: &Input {
    // rust: bolts: &[Bolt { seed, at: [0.0; 3] }],
    // rust: uv: [0.0; 2],
    // rust: },
    // rust: |seed, _| seed,
    // rust: );
    // rust: assert_eq!(cache.meshes.len(), 1);
    // rust: assert_eq!(cache.meshes[&seed].mesh, seed);
    // rust: assert!(cache.meshes.capacity() < 16);
}
}

/// Exercise the actual entity shader and retained draw path offscreen. Run
/// explicitly, separately from other headless device tests (some GPU drivers
/// fail during concurrent device teardown). Machines without an adapter skip it.
pub fn retained_gpu_draw_matches_transient_additive_draw() void {
}
//     use bytemuck::Zeroable;
    // rust: let instance = crate::gfx::test_gpu::instance();
    // rust: let Ok(adapter) = pollster::block_on(instance.request_adapter(&Default::default())) else {
    // rust: eprintln!("no GPU adapter: skipped");
    // rust: return;
}
    // rust: eprintln!("lightning differential GPU: {}", adapter.get_info().name);
    // rust: let (device, queue) = pollster::block_on(adapter.request_device(&Default::default())).unwrap();
    // rust: let shader = device.create_shader_module(wgpu::ShaderModuleDescriptor {
    // rust: label: Some("Lightning differential shader"),
    // rust: source: wgpu::ShaderSource::Wgsl(crate::gfx::entity_shader().into()),
    // rust: });
    // rust: let attributes = wgpu::vertex_attr_array![0=>Float32x3,1=>Float32x2,2=>Uint32,3=>Unorm8x4,4=>Uint8x4,5=>Snorm8x4,6=>Float32x2];
    // Attribute 7: 6 is the entity vertex buffer's glint UV.
    // rust: let offsets = wgpu::vertex_attr_array![7=>Float32x3];
    // rust: let vertices = [Some(wgpu::VertexBufferLayout {
    // rust: array_stride: std::mem::size_of::<Vertex>() as u64,
    // rust: step_mode: wgpu::VertexStepMode::Vertex,
    // rust: attributes: &attributes,
    // rust: })];
    // rust: let retained_vertices = [
    // rust: vertices[0].clone(),
    // rust: Some(wgpu::VertexBufferLayout {
    // rust: array_stride: 12,
    // rust: step_mode: wgpu::VertexStepMode::Instance,
    // rust: attributes: &offsets,
    // rust: }),
    // rust: ];
    // rust: let pipelines: Vec<_> = [false, true]
    // rust: .into_iter()
    // rust: .map(|retained| {
    // rust: device.create_render_pipeline(&wgpu::RenderPipelineDescriptor {
    // rust: label: Some("Lightning differential pipeline"),
    // rust: layout: None,
    // rust: vertex: wgpu::VertexState {
    // rust: module: &shader,
    // rust: entry_point: Some(if retained {
    // rust: "vs_lightning"
    // rust: } else {
    // rust: "vs_entity"
    // rust: }),
    // rust: compilation_options: Default::default(),
    // rust: buffers: if retained {
    // rust: &retained_vertices
    // rust: } else {
    // rust: &vertices
    // rust: },
    // rust: },
    // rust: primitive: wgpu::PrimitiveState {
    // rust: cull_mode: None,
    // rust: ..Default::default()
    // rust: },
    // rust: depth_stencil: Some(wgpu::DepthStencilState {
    // rust: format: wgpu::TextureFormat::Depth32Float,
    // rust: depth_write_enabled: Some(false),
    // rust: depth_compare: Some(wgpu::CompareFunction::GreaterEqual),
    // rust: stencil: Default::default(),
    // rust: bias: Default::default(),
    // rust: }),
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
    // rust: alpha: wgpu::BlendComponent {
    // rust: src_factor: wgpu::BlendFactor::SrcAlpha,
    // rust: dst_factor: wgpu::BlendFactor::One,
    // rust: operation: wgpu::BlendOperation::Add,
    // rust: },
    // rust: }),
    // rust: write_mask: wgpu::ColorWrites::ALL,
    // rust: })],
    // rust: }),
    // rust: multiview_mask: None,
    // rust: cache: None,
    // rust: })
    // rust: })
    // rust: .collect();
    // rust: let globals = crate::gfx::Globals {
    // rust: view_proj: (glam::Mat4::orthographic_rh(-100.0, 100.0, -10.0, 150.0, 0.1, 400.0)
    // rust: * glam::Mat4::look_at_rh(
    // rust: glam::Vec3::new(80.0, 30.0, 160.0),
    // rust: glam::Vec3::new(0.0, 60.0, 0.0),
    // rust: glam::Vec3::Y,
    // rust: ))
    // rust: .to_cols_array_2d(),
    // rust: ..crate::gfx::Globals::zeroed()
}
    // rust: let globals = device.create_buffer_init(&wgpu::util::BufferInitDescriptor {
    // rust: label: None,
    // rust: contents: bytemuck::bytes_of(&globals),
    // rust: usage: wgpu::BufferUsages::UNIFORM,
    // rust: });
    // rust: let size = wgpu::Extent3d {
    // rust: width: 256,
    // rust: height: 256,
    // rust: depth_or_array_layers: 1,
}
    // rust: let texture = |format, usage| {
    // rust: device.create_texture(&wgpu::TextureDescriptor {
    // rust: label: None,
    // rust: size,
    // rust: mip_level_count: 1,
    // rust: sample_count: 1,
    // rust: dimension: wgpu::TextureDimension::D2,
    // rust: format,
    // rust: usage,
    // rust: view_formats: &[],
    // rust: })
}
    // rust: let white = device
    // rust: .create_texture_with_data(
    // rust: &queue,
    // rust: &wgpu::TextureDescriptor {
    // rust: label: None,
    // rust: size: wgpu::Extent3d {
    // rust: width: 1,
    // rust: height: 1,
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
    // rust: &[255; 4],
    // rust: )
    // rust: .create_view(&Default::default());
    // rust: let sampler = device.create_sampler(&Default::default());
    // rust: let groups: Vec<_> = pipelines
    // rust: .iter()
    // rust: .map(|pipeline| {
    // rust: device.create_bind_group(&wgpu::BindGroupDescriptor {
    // rust: label: None,
    // rust: layout: &pipeline.get_bind_group_layout(0),
    // rust: entries: &[
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 0,
    // rust: resource: globals.as_entire_binding(),
    // rust: },
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 1,
    // rust: resource: wgpu::BindingResource::TextureView(&white),
    // rust: },
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 2,
    // rust: resource: wgpu::BindingResource::Sampler(&sampler),
    // rust: },
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 3,
    // rust: resource: wgpu::BindingResource::TextureView(&white),
    // rust: },
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 4,
    // rust: resource: wgpu::BindingResource::Sampler(&sampler),
    // rust: },
    // rust: ],
    // rust: })
    // rust: })
    // rust: .collect();
    // rust: let mut renderer = Renderer::new();
    // rust: let mut uploads = Uploads::new(&device);
    // rust: let mut bolts = [Bolt {
    // rust: seed: 123,
    // rust: at: [29_999_999.5, 64.0, -29_999_999.5],
    // rust: }; 3];
    // rust: bolts[1].seed = -456;
    // rust: bolts[1].at[0] -= 32.0;
    // rust: bolts[2].at[2] += 20.0;
    // rust: let indices = crate::gfx::Renderer::quad_indices(&device, QUADS * 3);
    // rust: for frame in 0..4 {
    // rust: let camera = DVec3::new(29_999_997.125 + frame as f64, 62.75, -29_999_998.875);
    // rust: if frame == 2 {
    // rust: bolts[0].seed = 789;
}
    // rust: let input = Input {
    // rust: bolts: &bolts[..if frame == 3 { 1 } else { 3 }],
    // rust: uv: if frame == 3 { [0.75; 2] } else { [0.5; 2] },
}
    // rust: let expected: Vec<_> = input
    // rust: .bolts
    // rust: .iter()
    // rust: .flat_map(|bolt| reference(bolt.seed, bolt.at, camera, input.uv))
    // rust: .collect();
    // rust: let transient = device.create_buffer_init(&wgpu::util::BufferInitDescriptor {
    // rust: label: None,
    // rust: contents: bytemuck::cast_slice(&expected),
    // rust: usage: wgpu::BufferUsages::VERTEX,
    // rust: });
    // rust: let mut encoder = device.create_command_encoder(&Default::default());
    // rust: renderer.prepare(&device, &mut uploads, &mut encoder, &input, camera);
    // rust: let mut readbacks = Vec::new();
    // rust: for mode in 0..2 {
    // rust: let color = texture(
    // rust: wgpu::TextureFormat::Rgba8Unorm,
    // rust: wgpu::TextureUsages::RENDER_ATTACHMENT | wgpu::TextureUsages::COPY_SRC,
    // rust: );
    // rust: let view = color.create_view(&Default::default());
    // rust: let depth = texture(
    // rust: wgpu::TextureFormat::Depth32Float,
    // rust: wgpu::TextureUsages::RENDER_ATTACHMENT,
    // rust: )
    // rust: .create_view(&Default::default());
    // rust: {
    // rust: let mut pass = encoder.begin_render_pass(&wgpu::RenderPassDescriptor {
    // rust: label: None,
    // rust: color_attachments: &[Some(wgpu::RenderPassColorAttachment {
    // rust: view: &view,
    // rust: resolve_target: None,
    // rust: depth_slice: None,
    // rust: ops: wgpu::Operations {
    // rust: load: wgpu::LoadOp::Clear(wgpu::Color::TRANSPARENT),
    // rust: store: wgpu::StoreOp::Store,
    // rust: },
    // rust: })],
    // rust: depth_stencil_attachment: Some(wgpu::RenderPassDepthStencilAttachment {
    // rust: view: &depth,
    // rust: depth_ops: Some(wgpu::Operations {
    // rust: load: wgpu::LoadOp::Clear(0.0),
    // rust: store: wgpu::StoreOp::Discard,
    // rust: }),
    // rust: stencil_ops: None,
    // rust: }),
    // rust: ..Default::default()
    // rust: });
    // rust: pass.set_pipeline(&pipelines[mode]);
    // rust: pass.set_bind_group(0, &groups[mode], &[]);
    // rust: pass.set_index_buffer(indices.slice(..), wgpu::IndexFormat::Uint32);
    // rust: if mode == 0 {
    // rust: pass.set_vertex_buffer(0, transient.slice(..));
    // rust: pass.draw_indexed(0..expected.len() as u32 / 4 * 6, 0, 0..1);
    // rust: } else {
    // rust: renderer.draw(&mut pass, &input);
}
}
    // rust: let read = device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: None,
    // rust: size: 256 * 256 * 4,
    // rust: usage: wgpu::BufferUsages::COPY_DST | wgpu::BufferUsages::MAP_READ,
    // rust: mapped_at_creation: false,
    // rust: });
    // rust: encoder.copy_texture_to_buffer(
    // rust: color.as_image_copy(),
    // rust: wgpu::TexelCopyBufferInfo {
    // rust: buffer: &read,
    // rust: layout: wgpu::TexelCopyBufferLayout {
    // rust: offset: 0,
    // rust: bytes_per_row: Some(1024),
    // rust: rows_per_image: None,
    // rust: },
    // rust: },
    // rust: size,
    // rust: );
    // rust: readbacks.push(read);
}
    // rust: uploads.finish(&encoder);
    // rust: queue.submit([encoder.finish()]);
    // rust: for read in &readbacks {
    // rust: read.slice(..)
    // rust: .map_async(wgpu::MapMode::Read, |r| r.unwrap());
}
    // rust: device.poll(wgpu::PollType::wait_indefinitely()).unwrap();
    // rust: let pixels: Vec<Vec<u8>> = readbacks
    // rust: .iter()
    // rust: .map(|read| read.slice(..).get_mapped_range().unwrap().to_vec())
    // rust: .collect();
    // rust: assert!(pixels[0].iter().any(|&b| b != 0), "empty reference frame");
    // rust: assert_eq!(pixels[0], pixels[1], "frame {frame}: GPU output differs");
}
}

/// `horizon/white` (4x4 texels) at (40, 12) of a 64x32 atlas.
pub const ATLAS: (u32, u32) = (64, 32);
pub fn white_sprite() c {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (w, h) = (ATLAS.0 as f32, ATLAS.1 as f32);
    // rust: crate::hud::Rect {
    // rust: u0: 40.0 / w,
    // rust: v0: 12.0 / h,
    // rust: u1: 44.0 / w,
    // rust: v1: 16.0 / h,
    // rust: w: 4,
    // rust: h: 4,
}
}

/// The white sprite's corner is on its border with the next atlas texels,
/// which nearest sampling picks for most of a bolt's fragments (#3171): the
/// point sampled is at least a texel inside the sprite.
pub fn white_uv_is_inside_the_white_sprite() void {
}
    // rust: let [u, v] = white_uv(&white_sprite());
    // rust: let (x, y) = (u * ATLAS.0 as f32, v * ATLAS.1 as f32);
    // rust: assert!((41.0..=43.0).contains(&x), "u at texel {x}");
    // rust: assert!((13.0..=15.0).contains(&y), "v at texel {y}");
}

/// A bolt seen from 14 blocks through the atlas as the game binds it (nearest
/// sampling, only the white sprite opaque) draws the same pixels as through a
/// texture that is white everywhere (#3171: the sprite's corner left a few
/// scattered pixels). Run explicitly, like the test above.
pub fn bolt_through_the_atlas_white_sprite_is_fully_drawn() void {
}
    // rust: let instance = crate::gfx::test_gpu::instance();
    // rust: let Ok(adapter) = pollster::block_on(instance.request_adapter(&Default::default())) else {
    // rust: eprintln!("no GPU adapter: skipped");
    // rust: return;
}
    // rust: let (device, queue) = pollster::block_on(adapter.request_device(&Default::default())).unwrap();
    // rust: let shader = device.create_shader_module(wgpu::ShaderModuleDescriptor {
    // rust: label: None,
    // rust: source: wgpu::ShaderSource::Wgsl(crate::gfx::entity_shader().into()),
    // rust: });
    // rust: let attributes = wgpu::vertex_attr_array![0=>Float32x3,1=>Float32x2,2=>Uint32,3=>Unorm8x4,4=>Uint8x4,5=>Snorm8x4,6=>Float32x2];
    // rust: let offsets = wgpu::vertex_attr_array![7=>Float32x3];
    // rust: let buffers = [
    // rust: Some(wgpu::VertexBufferLayout {
    // rust: array_stride: std::mem::size_of::<Vertex>() as u64,
    // rust: step_mode: wgpu::VertexStepMode::Vertex,
    // rust: attributes: &attributes,
    // rust: }),
    // rust: Some(wgpu::VertexBufferLayout {
    // rust: array_stride: 12,
    // rust: step_mode: wgpu::VertexStepMode::Instance,
    // rust: attributes: &offsets,
    // rust: }),
    // rust: ];
    // The lightning pipeline (gfx.rs): additive, into RGBA8.
    // rust: let additive = wgpu::BlendComponent {
    // rust: src_factor: wgpu::BlendFactor::SrcAlpha,
    // rust: dst_factor: wgpu::BlendFactor::One,
    // rust: operation: wgpu::BlendOperation::Add,
}
    // rust: let pipeline = device.create_render_pipeline(&wgpu::RenderPipelineDescriptor {
    // rust: label: None,
    // rust: layout: None,
    // rust: vertex: wgpu::VertexState {
    // rust: module: &shader,
    // rust: entry_point: Some("vs_lightning"),
    // rust: compilation_options: Default::default(),
    // rust: buffers: &buffers,
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
    // rust: color: additive,
    // rust: alpha: additive,
    // rust: }),
    // rust: write_mask: wgpu::ColorWrites::ALL,
    // rust: })],
    // rust: }),
    // rust: multiview_mask: None,
    // rust: cache: None,
    // rust: });
    // The game's camera: 70 degrees, reversed depth, the bolt 14 blocks ahead.
    // rust: let globals = crate::gfx::Globals {
    // rust: view_proj: (glam::Mat4::perspective_rh(70f32.to_radians(), 1.0, 400.0, 0.05)
    // rust: * glam::Mat4::look_at_rh(glam::Vec3::ZERO, glam::Vec3::Z, glam::Vec3::Y))
    // rust: .to_cols_array_2d(),
    // rust: ..bytemuck::Zeroable::zeroed()
}
    // rust: let globals = device.create_buffer_init(&wgpu::util::BufferInitDescriptor {
    // rust: label: None,
    // rust: contents: bytemuck::bytes_of(&globals),
    // rust: usage: wgpu::BufferUsages::UNIFORM,
    // rust: });
    // rust: let texture = |(width, height): (u32, u32), data: &[u8]| {
    // rust: device
    // rust: .create_texture_with_data(
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
    // rust: data,
    // rust: )
    // rust: .create_view(&Default::default())
}
    // rust: let white = texture((1, 1), &[255; 4]);
    // Transparent but for the white sprite.
    // rust: let mut texels = vec![0u8; (ATLAS.0 * ATLAS.1 * 4) as usize];
    // rust: for y in 12..16 {
    // rust: for x in 40..44 {
    // rust: let i = ((y * ATLAS.0 + x) * 4) as usize;
    // rust: texels[i..i + 4].copy_from_slice(&[255; 4]);
}
}
    // rust: let atlas = texture(ATLAS, &texels);
    // The atlas sampler (gfx.rs): wgpu's default, nearest.
    // rust: let sampler = device.create_sampler(&Default::default());
    // rust: let indices = crate::gfx::Renderer::quad_indices(&device, QUADS);
    // rust: let size = 256;
    // rust: let extent = wgpu::Extent3d {
    // rust: width: size,
    // rust: height: size,
    // rust: depth_or_array_layers: 1,
}
    // rust: let draw = |view: &wgpu::TextureView, uv: [f32; 2]| -> Vec<u8> {
    // rust: let group = device.create_bind_group(&wgpu::BindGroupDescriptor {
    // rust: label: None,
    // rust: layout: &pipeline.get_bind_group_layout(0),
    // rust: entries: &[
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 0,
    // rust: resource: globals.as_entire_binding(),
    // rust: },
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 1,
    // rust: resource: wgpu::BindingResource::TextureView(view),
    // rust: },
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 2,
    // rust: resource: wgpu::BindingResource::Sampler(&sampler),
    // rust: },
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 3,
    // rust: resource: wgpu::BindingResource::TextureView(&white),
    // rust: },
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 4,
    // rust: resource: wgpu::BindingResource::Sampler(&sampler),
    // rust: },
    // rust: ],
    // rust: });
    // rust: let bolts = [Bolt {
    // rust: seed: 123,
    // rust: at: [0.0, -1.62, 14.0],
    // rust: }];
    // rust: let input = Input { bolts: &bolts, uv };
    // rust: let mut renderer = Renderer::new();
    // rust: let mut uploads = Uploads::new(&device);
    // rust: let mut encoder = device.create_command_encoder(&Default::default());
    // rust: renderer.prepare(&device, &mut uploads, &mut encoder, &input, DVec3::ZERO);
    // rust: let color = device.create_texture(&wgpu::TextureDescriptor {
    // rust: label: None,
    // rust: size: extent,
    // rust: mip_level_count: 1,
    // rust: sample_count: 1,
    // rust: dimension: wgpu::TextureDimension::D2,
    // rust: format: wgpu::TextureFormat::Rgba8Unorm,
    // rust: usage: wgpu::TextureUsages::RENDER_ATTACHMENT | wgpu::TextureUsages::COPY_SRC,
    // rust: view_formats: &[],
    // rust: });
    // rust: {
    // rust: let target = color.create_view(&Default::default());
    // rust: let mut pass = encoder.begin_render_pass(&wgpu::RenderPassDescriptor {
    // rust: label: None,
    // rust: color_attachments: &[Some(wgpu::RenderPassColorAttachment {
    // rust: view: &target,
    // rust: resolve_target: None,
    // rust: depth_slice: None,
    // rust: ops: wgpu::Operations {
    // rust: load: wgpu::LoadOp::Clear(wgpu::Color::TRANSPARENT),
    // rust: store: wgpu::StoreOp::Store,
    // rust: },
    // rust: })],
    // rust: ..Default::default()
    // rust: });
    // rust: pass.set_pipeline(&pipeline);
    // rust: pass.set_bind_group(0, &group, &[]);
    // rust: pass.set_index_buffer(indices.slice(..), wgpu::IndexFormat::Uint32);
    // rust: renderer.draw(&mut pass, &input);
}
    // rust: let read = device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: None,
    // rust: size: u64::from(size * size * 4),
    // rust: usage: wgpu::BufferUsages::COPY_DST | wgpu::BufferUsages::MAP_READ,
    // rust: mapped_at_creation: false,
    // rust: });
    // rust: encoder.copy_texture_to_buffer(
    // rust: color.as_image_copy(),
    // rust: wgpu::TexelCopyBufferInfo {
    // rust: buffer: &read,
    // rust: layout: wgpu::TexelCopyBufferLayout {
    // rust: offset: 0,
    // rust: bytes_per_row: Some(size * 4),
    // rust: rows_per_image: None,
    // rust: },
    // rust: },
    // rust: extent,
    // rust: );
    // rust: uploads.finish(&encoder);
    // rust: queue.submit([encoder.finish()]);
    // rust: read.slice(..)
    // rust: .map_async(wgpu::MapMode::Read, |r| r.unwrap());
    // rust: device.poll(wgpu::PollType::wait_indefinitely()).unwrap();
    // rust: read.slice(..).get_mapped_range().unwrap().to_vec()
}
    // rust: let lit = |pixels: &[u8]| pixels.chunks(4).filter(|p| p[3] != 0).count();
    // rust: let expected = draw(&white, [0.5; 2]);
    // rust: let drawn = draw(&atlas, white_uv(&white_sprite()));
    // rust: assert!(lit(&expected) > 1000, "{} pixels", lit(&expected));
    // rust: assert_eq!(
    // rust: lit(&drawn),
    // rust: lit(&expected),
    // rust: "pixels drawn through the atlas"
    // rust: );
    // rust: assert!(drawn == expected, "the bolt's colours through the atlas");
}
