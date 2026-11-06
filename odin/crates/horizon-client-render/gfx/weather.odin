//! Transpiled from Horizon Rust crate
package horizon_client_render_weather

import "core:fmt"
import "core:mem"
import "core:math"

// Weather's unsplit quads, using the entity atlas/lightmap resources.
// use crate::weather::{Time, Vertex};

    // rust: pub(super) struct Weather {
    // rust: pipeline: wgpu::RenderPipeline,
    // The layouts of groups 0 (the entities') and 1 (the fall clock), for a native pack's
    // weather pipeline.
    // rust: pub entity_layout: wgpu::BindGroupLayout,
    // rust: pub time_layout: wgpu::BindGroupLayout,
    // rust: group: wgpu::BindGroup,
    // rust: uniform: wgpu::Buffer,
    // rust: vertices: wgpu::Buffer,
    // rust: capacity: usize,
    // rust: count: u32,
}
    // rust: impl Weather {
    // rust: pub fn new(
    // rust: device: &wgpu::Device,
    // rust: format: wgpu::TextureFormat,
    // rust: entities: &wgpu::BindGroupLayout,
    // rust: shader: &wgpu::ShaderModule,
    // rust: ) -> Self {
    // rust: let bindings = device.create_bind_group_layout(&wgpu::BindGroupLayoutDescriptor {
    // rust: label: Some("Weather time"),
    // rust: entries: &[wgpu::BindGroupLayoutEntry {
    // rust: binding: 1,
    // rust: visibility: wgpu::ShaderStages::VERTEX,
    // rust: ty: wgpu::BindingType::Buffer {
    // rust: ty: wgpu::BufferBindingType::Uniform,
    // rust: has_dynamic_offset: false,
    // rust: min_binding_size: None,
    // rust: },
    // rust: count: None,
    // rust: }],
    // rust: });
    // rust: let layout = device.create_pipeline_layout(&wgpu::PipelineLayoutDescriptor {
    // rust: label: Some("Weather layout"),
    // rust: bind_group_layouts: &[Some(entities), Some(&bindings)],
    // rust: ..Default::default()
    // rust: });
    // rust: let attributes = wgpu::vertex_attr_array![0=>Float32x3,1=>Float32x2,2=>Float32x4,
    // rust: 3=>Float32x4,4=>Uint32x4,5=>Unorm8x4,6=>Uint8x4,7=>Uint32];
    // rust: let pipeline = device.create_render_pipeline(&wgpu::RenderPipelineDescriptor {
    // rust: label: Some("Weather"),
    // rust: layout: Some(&layout),
    // rust: vertex: wgpu::VertexState {
    // rust: module: shader,
    // rust: entry_point: Some("vs_weather"),
    // rust: compilation_options: Default::default(),
    // rust: buffers: &[Some(wgpu::VertexBufferLayout {
    // rust: array_stride: std::mem::size_of::<Vertex>() as u64,
    // rust: step_mode: wgpu::VertexStepMode::Vertex,
    // rust: attributes: &attributes,
    // rust: })],
    // rust: },
    // rust: primitive: wgpu::PrimitiveState {
    // rust: topology: wgpu::PrimitiveTopology::TriangleList,
    // rust: ..Default::default()
    // rust: },
    // rust: depth_stencil: Some(depth_stencil()),
    // rust: multisample: Default::default(),
    // rust: fragment: Some(wgpu::FragmentState {
    // rust: module: shader,
    // rust: entry_point: Some("fs_weather"),
    // rust: compilation_options: Default::default(),
    // rust: targets: &[Some(wgpu::ColorTargetState {
    // rust: format,
    // rust: blend: Some(wgpu::BlendState::ALPHA_BLENDING),
    // rust: write_mask: wgpu::ColorWrites::ALL,
    // rust: })],
    // rust: }),
    // rust: multiview_mask: None,
    // rust: cache: None,
    // rust: });
    // rust: let uniform = device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: Some("Weather time"),
    // rust: size: 16,
    // rust: usage: wgpu::BufferUsages::UNIFORM | wgpu::BufferUsages::COPY_DST,
    // rust: mapped_at_creation: false,
    // rust: });
    // rust: let group = device.create_bind_group(&wgpu::BindGroupDescriptor {
    // rust: label: Some("Weather time"),
    // rust: layout: &bindings,
    // rust: entries: &[wgpu::BindGroupEntry {
    // rust: binding: 1,
    // rust: resource: uniform.as_entire_binding(),
    // rust: }],
    // rust: });
    // rust: Self {
    // rust: pipeline,
    // rust: entity_layout: entities.clone(),
    // rust: time_layout: bindings,
    // rust: group,
    // rust: uniform,
    // rust: vertices: Self::buffer(device, 4),
    // rust: capacity: 4,
    // rust: count: 0,
}
}
buffer :: proc(device: ^wgpu::Device, capacity: uint) -> w {
    // Ported from Horizon
    return {}
}
    // rust: device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: Some("Weather vertices"),
    // rust: size: (capacity * std::mem::size_of::<Vertex>()) as u64,
    // rust: usage: wgpu::BufferUsages::VERTEX | wgpu::BufferUsages::COPY_DST,
    // rust: mapped_at_creation: false,
    // rust: })
}
    // rust: pub fn prepare(
    // rust: &mut self,
    // rust: device: &wgpu::Device,
    // rust: encoder: &mut wgpu::CommandEncoder,
    // rust: uploads: &mut super::upload::Uploads,
    // rust: vertices: &[Vertex],
    // rust: time: Time,
    // rust: ) {
    // rust: self.count = vertices.len() as u32;
    // rust: if vertices.is_empty() {
    // rust: return;
}
    // rust: if vertices.len() > self.capacity {
    // rust: self.capacity = vertices.len().next_power_of_two();
    // rust: self.vertices = Self::buffer(device, self.capacity);
}
    // rust: uploads.buffer(encoder, &self.vertices, 0, bytemuck::cast_slice(vertices));
    // rust: uploads.buffer(encoder, &self.uniform, 0, bytemuck::bytes_of(&time));
}
    // The classic pipeline, for its layouts.
pipeline :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &self.pipeline
}
    // `draw` with another pipeline of the same layouts and vertex format.
    // rust: pub fn draw_with(
    // rust: &self,
    // rust: pass: &mut wgpu::RenderPass<'_>,
    // rust: pipeline: &wgpu::RenderPipeline,
    // rust: entities: &wgpu::BindGroup,
    // rust: ) {
    // rust: if self.count == 0 {
    // rust: return;
}
    // rust: pass.set_pipeline(pipeline);
    // rust: pass.set_bind_group(0, entities, &[]);
    // rust: pass.set_bind_group(1, &self.group, &[]);
    // rust: pass.set_vertex_buffer(0, self.vertices.slice(..));
    // rust: pass.draw_indexed(0..self.count / 4 * 6, 0, 0..1);
}
    // Draws the streaks, through a native pack's weather stage when `native` is given (its
    // pipeline and the pack's frame group).
    // rust: pub fn draw(
    // rust: &self,
    // rust: pass: &mut wgpu::RenderPass<'_>,
    // rust: entities: &wgpu::BindGroup,
    // rust: native: Option<(&wgpu::RenderPipeline, &wgpu::BindGroup)>,
    // rust: ) {
    // rust: if self.count == 0 {
    // rust: return;
}
    // rust: match native {
    // rust: Some((pipeline, frame)) => {
    // rust: pass.set_pipeline(pipeline);
    // rust: pass.set_bind_group(horizon_shader_api::stages::GROUP, frame, &[]);
}
    // rust: None => pass.set_pipeline(&self.pipeline),
}
    // rust: pass.set_bind_group(0, entities, &[]);
    // rust: pass.set_bind_group(1, &self.group, &[]);
    // rust: pass.set_vertex_buffer(0, self.vertices.slice(..));
        // The renderer binds the shared triangle-list quad indices.
    // rust: pass.draw_indexed(0..self.count / 4 * 6, 0, 0..1);
}
}

// RenderPipelines.WEATHER: depth-tested, but no depth write, so the water
// and glass drawn behind the rain still show through it.
depth_stencil :: proc() -> w {
    // Ported from Horizon
    return {}
}
    // rust: wgpu::DepthStencilState {
    // rust: format: wgpu::TextureFormat::Depth32Float,
    // rust: depth_write_enabled: Some(false),
    // rust: depth_compare: Some(wgpu::CompareFunction::GreaterEqual),
    // rust: stencil: Default::default(),
    // rust: bias: Default::default(),
}
}

// The entries around a native pack's `weather`: Horizon's weather vertex, then the texture
// as `fs_weather` reads it, handed to the pack with the light and the position.
    // rust: const NATIVE_ENTRIES: &str = "
HorizonWeatherOut :: struct {
    // rust: @builtin(position) clip: vec4<f32>,
    // rust: @location(0) uv: vec2<f32>,
    // rust: @location(1) color: vec4<f32>,
    // rust: @location(2) @interpolate(flat) rect: vec4<f32>,
    // rust: @location(3) light: vec2<f32>,
    // rust: @location(4) position: vec3<f32>,
    // rust: @location(5) @interpolate(flat) snow: u32,
}
    // rust: @vertex fn horizon_weather_vs(@location(0) position: vec3<f32>, @location(1) uv: vec2<f32>,
    // rust: @location(2) rect: vec4<f32>, @location(3) animation: vec4<f32>,
    // rust: @location(4) bases: vec4<u32>, @location(5) color: vec4<f32>,
    // rust: @location(6) light: vec4<u32>, @location(7) snow: u32) -> HorizonWeatherOut {
    // rust: let phase = horizon_entity_weather_phase(animation, bases, snow,
    // rust: horizon_entity_weather_time.values);
    // rust: let v = horizon_entity_entity_vertex(position, uv + phase, 0u, color, light, vec4(0.0));
    // rust: var out: HorizonWeatherOut;
    // rust: out.clip = v.clip;
    // rust: out.uv = v.uv;
    // rust: out.color = v.color;
    // rust: out.rect = rect;
    // entity_vertex's light: block in y, sky in x, 0..240.
    // rust: out.light = min(vec2(f32(light.y), f32(light.x)) / 240.0, vec2(1.0));
    // rust: out.position = position;
    // rust: out.snow = snow;
    // rust: return out;
}
    // rust: @fragment fn horizon_weather_fs(in: HorizonWeatherOut) -> @location(0) vec4<f32> {
    // rust: let texel = horizon_entity_weather_texel(in.uv, in.rect,
    // rust: textureDimensions(horizon_entity_atlas));
    // rust: let color = textureLoad(horizon_entity_atlas, texel, 0) * in.color;
    // rust: if color.a < 0.1 { discard; }
    // rust: return weather(WeatherInput(color, in.light, in.position, in.snow != 0u));
}
    // rust: ";

// The shader of a native pack's weather stage `source`.
native_source :: proc(source: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: format!(
    // rust: "{source}\n// Horizon's weather (entity.wgsl)\n{}{NATIVE_ENTRIES}",
    // rust: super::wgsl_prefix::prefixed(&super::entity_shader(), "horizon_entity_")
    // rust: )
}

// A native pack's weather pipeline: its `stage` (with the option values `constants`), then
// entity.wgsl with every name prefixed, then the entries above. Group 0 is the entities',
// 1 the fall clock (`time_layout`), 3 the pack's frame.
    // rust: pub(super) fn native_pipeline(
    // rust: device: &wgpu::Device,
    // rust: format: wgpu::TextureFormat,
    // rust: entities: &wgpu::BindGroupLayout,
    // rust: time_layout: &wgpu::BindGroupLayout,
    // rust: frame: &super::native_post::NativeFrame,
    // rust: stage: &horizon_shader_api::check::CheckedStage,
    // rust: constants: &[(String, f64)],
    // rust: ) -> Result<wgpu::RenderPipeline, String> {
//     use horizon_shader_api::stages::GROUP;
    // rust: let text = native_source(&stage.source);
    // rust: let module = naga::front::wgsl::parse_str(&text)
    // rust: .map_err(|e| format!("{}: {}", stage.file, e.emit_to_string(&text)))?;
    // rust: let present = super::native_post::present_constants(&module, constants);
    // rust: let mut groups: [Option<&wgpu::BindGroupLayout>; GROUP as usize + 1] = Default::default();
    // rust: groups[0] = Some(entities);
    // rust: groups[1] = Some(time_layout);
    // rust: groups[GROUP as usize] = Some(&frame.layout);
    // rust: let layout = device.create_pipeline_layout(&wgpu::PipelineLayoutDescriptor {
    // rust: label: Some("Native shader pack weather"),
    // rust: bind_group_layouts: &groups,
    // rust: ..Default::default()
    // rust: });
    // rust: let scope = device.push_error_scope(wgpu::ErrorFilter::Validation);
    // rust: let module = device.create_shader_module(wgpu::ShaderModuleDescriptor {
    // rust: label: Some(&stage.label),
    // rust: source: wgpu::ShaderSource::Naga(std::borrow::Cow::Owned(module)),
    // rust: });
    // rust: let options = wgpu::PipelineCompilationOptions {
    // rust: constants: &present,
    // rust: ..Default::default()
}
    // rust: let attributes = wgpu::vertex_attr_array![0=>Float32x3,1=>Float32x2,2=>Float32x4,
    // rust: 3=>Float32x4,4=>Uint32x4,5=>Unorm8x4,6=>Uint8x4,7=>Uint32];
    // rust: let pipeline = device.create_render_pipeline(&wgpu::RenderPipelineDescriptor {
    // rust: label: Some("Native shader pack weather"),
    // rust: layout: Some(&layout),
    // rust: vertex: wgpu::VertexState {
    // rust: module: &module,
    // rust: entry_point: Some("horizon_weather_vs"),
    // rust: compilation_options: options.clone(),
    // rust: buffers: &[Some(wgpu::VertexBufferLayout {
    // rust: array_stride: std::mem::size_of::<Vertex>() as u64,
    // rust: step_mode: wgpu::VertexStepMode::Vertex,
    // rust: attributes: &attributes,
    // rust: })],
    // rust: },
    // rust: primitive: wgpu::PrimitiveState {
    // rust: topology: wgpu::PrimitiveTopology::TriangleList,
    // rust: ..Default::default()
    // rust: },
    // rust: depth_stencil: Some(depth_stencil()),
    // rust: multisample: Default::default(),
    // rust: fragment: Some(wgpu::FragmentState {
    // rust: module: &module,
    // rust: entry_point: Some("horizon_weather_fs"),
    // rust: compilation_options: options,
    // rust: targets: &[Some(wgpu::ColorTargetState {
    // rust: format,
    // rust: blend: Some(wgpu::BlendState {
    // rust: color: wgpu::BlendState::ALPHA_BLENDING.color,
                    // The frame's alpha stays as the surfaces left it (entities mark it 0).
    // rust: alpha: wgpu::BlendComponent {
    // rust: src_factor: wgpu::BlendFactor::Zero,
    // rust: dst_factor: wgpu::BlendFactor::One,
    // rust: operation: wgpu::BlendOperation::Add,
    // rust: },
    // rust: }),
    // rust: write_mask: wgpu::ColorWrites::ALL,
    // rust: })],
    // rust: }),
    // rust: multiview_mask: None,
    // rust: cache: None,
    // rust: });
    // rust: if let Some(e) = pollster::block_on(scope.pop()) {
    // rust: return Err(format!("{}: {e}", stage.file));
}
    // rust: Ok(pipeline)
}

    // rust: mod tests {
//     use super::native_source;

a_native_weather_stage_validates :: proc() {
}
//         use horizon_shader_api::stages::StageKind;
    // rust: let source = StageKind::Weather.prelude(horizon_shader_api::Api::V0_1)
    // rust: + "fn weather(input: WeatherInput) -> vec4<f32> {\n    \
    // rust: return input.color * vec4(input.light, input.position.x, f32(input.snow));\n}\n";
    // rust: let text = native_source(&source);
    // rust: let module = naga::front::wgsl::parse_str(&text)
    // rust: .unwrap_or_else(|e| panic!("{}", e.emit_to_string(&text)));
    // rust: naga::valid::Validator::new(
    // rust: naga::valid::ValidationFlags::all(),
    // rust: naga::valid::Capabilities::all(),
    // rust: )
    // rust: .validate(&module)
    // rust: .unwrap_or_else(|e| panic!("{}", e.emit_to_string(&text)));
}
//     use crate::weather::{Parameters, Time};
//     use wgpu::util::DeviceExt;

weather_writes_no_depth :: proc() {
}
    // rust: let depth = super::depth_stencil();
    // rust: assert_eq!(depth.depth_write_enabled, Some(false));
    // rust: assert_eq!(
    // rust: depth.depth_compare,
    // rust: Some(wgpu::CompareFunction::GreaterEqual)
    // rust: );
}

Case :: struct {
    animation: [f32,
    bases: [u32,
    time: [f32,
    uv: [f32,
    snow: u32,
    _pad: u32,
}

    // Execute the production WGSL math, rather than a Rust translation of it.
    // Requires a GPU; run explicitly on renderer changes, not on headless CI.
weather_shader_uvs_match_legacy_bits :: proc() {
}
    // rust: let instance = crate::gfx::test_gpu::instance();
    // rust: let adapter =
    // rust: pollster::block_on(instance.request_adapter(&wgpu::RequestAdapterOptions::default()))
    // rust: .unwrap();
    // rust: eprintln!("weather parity adapter: {:?}", adapter.get_info());
    // rust: let (device, queue) =
    // rust: pollster::block_on(adapter.request_device(&wgpu::DeviceDescriptor::default())).unwrap();
    // rust: let mut cases = Vec::new();
    // rust: let mut expected = Vec::new();
    // rust: for i in 0..4096i32 {
    // rust: let x = i.wrapping_mul(45_238_971);
    // rust: let z = i.wrapping_mul(-418_711).wrapping_add(i32::MIN);
    // rust: let p = Parameters::new(x, z);
    // rust: let bases = p.snow_base.map(f64::to_bits);
    // rust: for ticks in [-1, 0, 511, 512, 131_071, 131_072, i64::MAX] {
    // rust: let partial = [0.0, 0.5, 0.999, f32::from_bits(0x3f7fffff)][i as usize % 4];
    // rust: for snow in [false, true] {
    // rust: let column = p.column(snow, ticks, x, -64, 320, z, 0, partial);
    // rust: let uv = [1.0, if i & 1 == 0 { -16.0 } else { 80.0 }];
    // rust: cases.push(Case {
    // rust: animation: [
    // rust: p.rain_speed,
    // rust: p.rain_tick_offset,
    // rust: p.snow_drift[0],
    // rust: p.snow_drift[1],
    // rust: ],
    // rust: bases: [
    // rust: bases[0] as u32,
    // rust: (bases[0] >> 32) as u32,
    // rust: bases[1] as u32,
    // rust: (bases[1] >> 32) as u32,
    // rust: ],
    // rust: time: Time::new(ticks, partial).values,
    // rust: uv,
    // rust: snow: u32::from(snow),
    // rust: _pad: 0,
    // rust: });
    // rust: expected.push([
    // rust: (uv[0] + column.u_offset).to_bits(),
    // rust: (uv[1] + column.v_offset).to_bits(),
    // rust: ]);
}
}
}
        // Force halfway rounding, cancellation, zero, tiny bases and either
        // sign of drift. Gaussian seeds alone rarely land on exact midpoints.
    // rust: for base in [
    // rust: 0.0,
    // rust: 2.0f64.powi(-53),
    // rust: 0.5,
    // rust: 0.5 + 2.0f64.powi(-25),
    // rust: 0.5 + 2.0f64.powi(-25) + 2.0f64.powi(-53),
    // rust: 0.5 + 2.0f64.powi(-14) + 2.0f64.powi(-53),
    // rust: 1.0 - 2.0f64.powi(-53),
    // rust: ] {
    // rust: for delta in [0.0f32, -0.0, -0.5, 0.5, 1024.0, -1024.0, 2.0f32.powi(-40)] {
                // time=100, u scale=.01 -> delta exactly, v is unused.
    // rust: let bits = base.to_bits();
    // rust: cases.push(Case {
    // rust: animation: [3.0, 0.0, delta, 0.0],
    // rust: bases: [bits as u32, (bits >> 32) as u32, 0, 0],
    // rust: time: [100.0, 0.0, 0.0, 0.0],
    // rust: uv: [0.0, 0.0],
    // rust: snow: 1,
    // rust: _pad: 0,
    // rust: });
    // rust: expected.push([((base + f64::from(delta)) as f32).to_bits(), 0]);
}
}
    // rust: let expected: Vec<[u32; 4]> = expected
    // rust: .into_iter()
    // rust: .map(|bits| {
    // rust: let uv = bits.map(f32::from_bits);
    // rust: let texel = [
    // rust: 256 + ((uv[0] - uv[0].floor()) * 16.0).floor() as u32,
    // rust: 512 + ((uv[1] - uv[1].floor()) * 32.0).floor() as u32,
    // rust: ];
    // rust: [bits[0], bits[1], texel[0], texel[1]]
    // rust: })
    // rust: .collect();
    // rust: let math = include_str!("../entity.wgsl")
    // rust: .split("// WEATHER_MATH_BEGIN")
    // rust: .nth(1)
    // rust: .unwrap()
    // rust: .split("// WEATHER_MATH_END")
    // rust: .next()
    // rust: .unwrap();
    // rust: let source = format!(
    // rust: "{math}\n{}",
    // rust: r#"
Case :: struct {
    // rust: @group(0) @binding(0) var<storage, read> cases: array<Case>;
    // rust: @group(0) @binding(1) var<storage, read_write> results: array<vec4<u32>>;
    // rust: @compute @workgroup_size(64) fn main(@builtin(global_invocation_id) id: vec3<u32>) {
    // rust: if id.x >= arrayLength(&cases) { return; }
    // rust: let c = cases[id.x];
    // rust: let uv = c.uv + weather_phase(c.animation, c.bases, c.snow, c.time);
    // rust: let texel = weather_texel(uv, vec4(0.25, 0.5, 0.015625, 0.03125), vec2(1024u));
    // rust: results[id.x] = vec4(bitcast<vec2<u32>>(uv), vec2<u32>(texel));
    // rust: }"#
    // rust: );
    // rust: let shader = device.create_shader_module(wgpu::ShaderModuleDescriptor {
    label: Some("Weather parity"),
    source: wgpu::ShaderSource::Wgsl(source.into()),
    // rust: });
    // rust: let pipeline = device.create_compute_pipeline(&wgpu::ComputePipelineDescriptor {
    label: Some("Weather parity"),
    layout: None,
    module: ^shader,
    entry_point: Some("main"),
    compilation_options: Default::default(),
    cache: None,
    // rust: });
    // rust: let input = device.create_buffer_init(&wgpu::util::BufferInitDescriptor {
    label: None,
    contents: bytemuck::cast_slice(^cases),
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
    layout: ^pipeline.get_bind_group_layout(0),
    entries: ^[,
    wgpu: :BindGroupEntry {,
    binding: 0,
    resource: input.as_entire_binding(),
    // rust: },
    wgpu: :BindGroupEntry {,
    binding: 1,
    resource: output.as_entire_binding(),
    // rust: },
    // rust: ],
    // rust: });
    // rust: let mut encoder = device.create_command_encoder(&Default::default());
    // rust: {
    // rust: let mut pass = encoder.begin_compute_pass(&Default::default());
    // rust: pass.set_pipeline(&pipeline);
    // rust: pass.set_bind_group(0, &group, &[]);
    // rust: pass.dispatch_workgroups((cases.len() as u32).div_ceil(64), 1, 1);
}
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
    // rust: actual, expected,
    // rust: "case {i}, snow={}, time={:?}, animation={:?}",
    // rust: cases[i].snow, cases[i].time, cases[i].animation
    // rust: );
}
    // rust: eprintln!("{} GPU weather UV cases matched bit for bit", cases.len());
}
}
