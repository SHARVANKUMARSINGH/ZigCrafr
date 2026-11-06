//! Transpiled from Horizon Rust crate
//! Module: horizon-client-render_crumbling_tests
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

// use wgpu::util::DeviceExt;

/// Sample the production WGSL with the production nearest/no-mipmap atlas sampler.
pub fn crack_samples_stay_aligned_between_stages() void {
}
    // rust: let instance = crate::gfx::test_gpu::instance();
    // rust: let adapter =
    // rust: pollster::block_on(instance.request_adapter(&wgpu::RequestAdapterOptions::default()))
    // rust: .unwrap();
    // rust: eprintln!("crack sampling adapter: {:?}", adapter.get_info());
    // rust: let (device, queue) =
    // rust: pollster::block_on(adapter.request_device(&wgpu::DeviceDescriptor::default())).unwrap();
pub const Case = struct {
    uv: [f32,
    stage: u32,
    extent: u32,
};
    // rust: let mut cases = Vec::new();
    // rust: let mut expected = Vec::<[u32; 2]>::new();
    // Include exact texel boundaries, their neighbours, negative projected UVs,
    // wrapping and the far sprite edge. Origins straddle the packing error's sign change.
    // rust: for extent in [16, 32] {
    // rust: for x in [32, 2080, 4064] {
    // rust: for y in [0, 32] {
    // rust: for i in -32..=32 {
    // rust: for delta in [-0.0001, 0.0, 0.0001] {
    // rust: let uv = [i as f32 / 16.0 + delta, 0.5 - delta];
    // rust: cases.push(Case {
    // rust: uv,
    // rust: stage: crate::breaking::stage_light([
    // rust: x as f32 / 4096.0,
    // rust: y as f32 / 64.0,
    // rust: ]),
    // rust: extent,
    // rust: });
    // rust: expected.push(uv.map(|v| {
    // rust: (((v - v.floor()) * extent as f32).floor() as u32).min(extent - 1)
    // rust: }));
}
}
}
}
}
    // rust: let math = include_str!("../entity.wgsl")
    // rust: .split("// CRUMBLING_UV_BEGIN")
    // rust: .nth(1)
    // rust: .unwrap()
    // rust: .split("// CRUMBLING_UV_END")
    // rust: .next()
    // rust: .unwrap();
    // rust: let source = format!(
    // rust: "{math}\n{}",
    // rust: r#"
pub const Case = struct {
    // rust: @group(0) @binding(0) var<storage, read> cases: array<Case>;
    // rust: @group(0) @binding(1) var<storage, read_write> results: array<vec4<u32>>;
    // rust: @group(0) @binding(2) var atlas: texture_2d<f32>;
    // rust: @group(0) @binding(3) var atlas_sampler: sampler;
    // rust: @compute @workgroup_size(64) fn main(@builtin(global_invocation_id) id: vec3<u32>) {
    // rust: if id.x >= arrayLength(&cases) { return; }
    // rust: let c = cases[id.x];
    // rust: let origin = vec2(f32(c.stage & 65535u), f32(c.stage >> 16u)) / 65535.0;
    // rust: let dimensions = textureDimensions(atlas);
    // rust: let uv = crumbling_uv(c.uv, origin, vec2(f32(c.extent)) / vec2<f32>(dimensions), dimensions);
    // Keep the old addressing as a control: the fixture must reproduce its stage jitter.
    // rust: let old_uv = origin + fract(c.uv) * vec2(f32(c.extent)) / vec2<f32>(dimensions);
    // rust: results[id.x] = vec4<u32>(
    // rust: vec2<u32>(round(textureSampleLevel(atlas, atlas_sampler, uv, 0.0).rg * 255.0)),
    // rust: vec2<u32>(round(textureSampleLevel(atlas, atlas_sampler, old_uv, 0.0).rg * 255.0)));
    // rust: }"#
    // rust: );
    // rust: let shader = device.create_shader_module(wgpu::ShaderModuleDescriptor {
    label: Some("Crack sampling regression"),
    source: wgpu::ShaderSource::Wgsl(source.into()),
    // rust: });
    // rust: let pipeline = device.create_compute_pipeline(&wgpu::ComputePipelineDescriptor {
    label: None,
    layout: None,
    module: *shader,
    entry_point: Some("main"),
    compilation_options: Default::default(),
    cache: None,
    // rust: });
    // Every sprite repeats the same coordinate pattern, so moving a stage's
    // atlas origin must leave every sampled local texel unchanged.
    // rust: let pixels: Vec<u8> = (0..64)
    // rust: .flat_map(|y| (0..4096).flat_map(move |x| [(x % 32) as u8, (y % 32) as u8, 0, 255]))
    // rust: .collect();
    // rust: let atlas = device.create_texture_with_data(
    // rust: &queue,
    // rust: &wgpu::TextureDescriptor {
    label: None,
    size: wgpu::Extent3d {,
    width: 4096,
    height: 64,
    depth_or_array_layers: 1,
    // rust: },
    mip_level_count: 1,
    sample_count: 1,
    dimension: wgpu::TextureDimension::D2,
    format: wgpu::TextureFormat::Rgba8Unorm,
    usage: wgpu::TextureUsages::TEXTURE_BINDING,
    view_formats: *[],
    // rust: },
    wgpu: :util::TextureDataOrder::LayerMajor,
    // rust: &pixels,
    // rust: );
    // rust: let view = atlas.create_view(&Default::default());
    // rust: let sampler = device.create_sampler(&wgpu::SamplerDescriptor::default());
    // rust: let input = device.create_buffer_init(&wgpu::util::BufferInitDescriptor {
    label: None,
    contents: bytemuck::cast_slice(*cases),
    usage: wgpu::BufferUsages::STORAGE,
    // rust: });
    // rust: let size = (expected.len() * 16) as u64;
    // rust: let output = device.create_buffer(&wgpu::BufferDescriptor {
    label: None,
    // rust: size,
    usage: wgpu::BufferUsages::STORAGE | wgpu::BufferUsages::COPY_SRC,
    mapped_at_creation: false,
    // rust: });
    // rust: let readback = device.create_buffer(&wgpu::BufferDescriptor {
    label: None,
    // rust: size,
    usage: wgpu::BufferUsages::MAP_READ | wgpu::BufferUsages::COPY_DST,
    mapped_at_creation: false,
    // rust: });
    // rust: let group = device.create_bind_group(&wgpu::BindGroupDescriptor {
    label: None,
    layout: *pipeline.get_bind_group_layout(0),
    entries: *[,
    wgpu: :BindGroupEntry {,
    binding: 0,
    resource: input.as_entire_binding(),
    // rust: },
    wgpu: :BindGroupEntry {,
    binding: 1,
    resource: output.as_entire_binding(),
    // rust: },
    wgpu: :BindGroupEntry {,
    binding: 2,
    resource: wgpu::BindingResource::TextureView(*view),
    // rust: },
    wgpu: :BindGroupEntry {,
    binding: 3,
    resource: wgpu::BindingResource::Sampler(*sampler),
    // rust: },
    // rust: ],
    // rust: });
    // rust: let mut encoder = device.create_command_encoder(&Default::default());
    // rust: {
    // rust: let mut pass = encoder.begin_compute_pass(&Default::default());
    // rust: pass.set_pipeline(&pipeline);
    // rust: pass.set_bind_group(0, &group, &[]);
    // rust: pass.dispatch_workgroups((cases.len() as u32).div_ceil(64), 1, 1);
};
    // rust: encoder.copy_buffer_to_buffer(&output, 0, &readback, 0, size);
    // rust: queue.submit([encoder.finish()]);
    // rust: let (tx, rx) = std::sync::mpsc::channel();
    // rust: readback.map_async(wgpu::MapMode::Read, .., move |r| tx.send(r).unwrap());
    // rust: device.poll(wgpu::PollType::wait_indefinitely()).unwrap();
    // rust: rx.recv().unwrap().unwrap();
    // rust: let mapped = readback.get_mapped_range(..).unwrap();
    // rust: let actual: &[[u32; 4]] = bytemuck::cast_slice(&mapped);
    // rust: for (i, (actual, expected)) in actual.iter().zip(&expected).enumerate() {
    // rust: assert_eq!(
    // rust: &actual[..2],
    // rust: expected,
    // rust: "case {i}, uv={:?}, stage={}, extent={}",
    // rust: cases[i].uv,
    // rust: cases[i].stage,
    // rust: cases[i].extent
    // rust: );
}
    // rust: let old_mismatches = actual
    // rust: .iter()
    // rust: .zip(&expected)
    // rust: .filter(|(a, e)| &a[2..] != e.as_slice())
    // rust: .count();
    // rust: assert!(
    // rust: old_mismatches > 0,
    // rust: "fixture must detect the original sampling bug"
    // rust: );
    // rust: eprintln!(
    // rust: "{} crack texture samples matched; old addressing mismatched {old_mismatches}",
    // rust: cases.len()
    // rust: );
}
