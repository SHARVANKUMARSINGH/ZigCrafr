//! Transpiled from Horizon Rust crate
//! Module: horizon-client-render_fade_test
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Original pack-to-pixel controls of terrain's visibility input, with no external fixture.
// use super::PackAtlas;
// use crate::gfx::{section_instance, section_visibility};
// use crate::mesher::TerrainVertex;
// use std::{
    // rust: path::PathBuf,
    // rust: time::{Duration, Instant},
}
// use wgpu::util::DeviceExt;

pub const ProbePack = struct {};
    // rust: impl Drop for ProbePack {
pub fn drop(self: *Self) void {
}
    // rust: std::fs::remove_dir_all(&self.0).unwrap();
}
}

pub fn terrain_fade_reaches_pack_pixels_through_real_instances() void {
}
    // rust: let instance = crate::gfx::test_gpu::instance();
    // rust: let adapter = match pollster::block_on(instance.request_adapter(&Default::default())) {
    // rust: Ok(adapter) => adapter,
    // rust: Err(error) => {
    // rust: eprintln!("SKIP terrain fade GPU control: no adapter: {error}");
    // rust: return;
}
}
    // rust: eprintln!("terrain fade adapter: {:?}", adapter.get_info());
    // rust: let (device, queue) = pollster::block_on(adapter.request_device(&Default::default())).unwrap();
    // rust: let array = device.create_texture(&wgpu::TextureDescriptor {
    // rust: label: None,
    // rust: size: wgpu::Extent3d {
    // rust: width: 2,
    // rust: height: 2,
    // rust: depth_or_array_layers: 1,
    // rust: },
    // rust: mip_level_count: 1,
    // rust: sample_count: 1,
    // rust: dimension: wgpu::TextureDimension::D2,
    // rust: format: wgpu::TextureFormat::Rgba8Unorm,
    // rust: usage: wgpu::TextureUsages::COPY_SRC | wgpu::TextureUsages::TEXTURE_BINDING,
    // rust: view_formats: &[],
    // rust: });
    // rust: let mut encoder = device.create_command_encoder(&Default::default());
    // rust: let mut atlas = PackAtlas::new(&device, &mut encoder, &[array], 1, 1, 2).unwrap();
    // rust: atlas.separate_ao = true;
    // rust: queue.submit([encoder.finish()]);
    // rust: let folder = ProbePack(
    // rust: std::env::temp_dir().join(format!("horizon-terrain-fade-{}", std::process::id())),
    // rust: );
    // rust: std::fs::create_dir_all(folder.0.join("shaders")).unwrap();
    // The guard, initializer, varying and integer output are independent probe code.
    // rust: let vertex = "#version 330\nout vec4 observation;\n\
    // rust: #ifdef IRIS_FEATURE_FADE_VARIABLE\nfloat first = mc_chunkFade;\n#endif\n\
    // rust: void main() {\n#ifdef IRIS_FEATURE_FADE_VARIABLE\n\
    // rust: observation = vec4(mc_chunkFade, first, gl_Color.a, gl_MultiTexCoord0.x);\n\
    // rust: #else\nobservation = vec4(1.0, 1.0, gl_Color.a, gl_MultiTexCoord0.x);\n#endif\n\
    // rust: gl_Position = vec4(0.0, 0.0, 0.0, 1.0);\n}";
    // rust: let fragment = "#version 330\nin vec4 observation;\nlayout(location = 0) out uvec4 pixel;\n\
    // rust: void main() { pixel = floatBitsToUint(observation); }";
    // rust: let geometry_vertex = vertex
    // rust: .replace("float first = mc_chunkFade;", "")
    // rust: .replace("mc_chunkFade, first,", "mc_chunkFade, mc_chunkFade,")
    // rust: .replace("observation", "vertex_observation");
    // rust: let geometry_shader = "#version 330\nlayout(triangles) in;\n\
    // rust: layout(triangle_strip, max_vertices=3) out;\nin vec4 vertex_observation[];\n\
    // rust: out vec4 observation;\nconst float mc_chunkFade = 0.8125;\nvoid main() {\n\
    // rust: for (int k=0; k<3; ++k) {\nobservation = vertex_observation[k];\n\
    // rust: observation.y = mc_chunkFade;\n\
    // rust: gl_Position = vec4(k == 1 ? 3.0 : -1.0, k == 2 ? 3.0 : -1.0, 0.0, 1.0);\n\
    // rust: EmitVertex();\n}\nEndPrimitive();\n}";
    // rust: for name in ["gbuffers_terrain", "gbuffers_water", "shadow"] {
    // rust: for (extension, code) in [("vsh", vertex), ("fsh", fragment)] {
    // rust: std::fs::write(folder.0.join(format!("shaders/{name}.{extension}")), code).unwrap();
}
}
    // rust: let uploaded = Instant::now();
    // rust: let cases = [
    // rust: ("first frame", Some(&uploaded), 0, 1000, 0, 0.0),
    // rust: ("137ms", Some(&uploaded), 137, 1000, 0, 0.137),
    // rust: ("midpoint", Some(&uploaded), 500, 1000, 0, 0.5),
    // rust: ("finished", Some(&uploaded), 1000, 1000, 0, 1.0),
    // rust: ("disabled", Some(&uploaded), 0, 0, 0, 1.0),
    // rust: ("no upload transition", None, 0, 1000, 0, 1.0),
    // rust: ("distant handover", Some(&uploaded), 500, 1000, 17, 1.0),
    // rust: ];
    // rust: let mut count = 0;
    // rust: for requested in [false, true] {
    // rust: std::fs::write(
    // rust: folder.0.join("shaders/shaders.properties"),
    // rust: if requested {
    // rust: "shadow.enabled=true\niris.features.optional=FADE_VARIABLE\niris.features.required=FADE_VARIABLE\n"
    // rust: } else {
    // rust: "shadow.enabled=true\n"
    // rust: },
    // rust: )
    // rust: .unwrap();
    // rust: let pack = horizon_shaders::Pack::open(&folder.0).unwrap();
    // rust: let mut macros = horizon_shaders::Macros::standard();
    // rust: let (properties, notes) = horizon_shaders::read_properties(&pack, &mut macros);
    // rust: assert!(notes.is_empty(), "{notes:?}");
    // rust: for flat in [false, true] {
    // rust: for geometry in [false, true].into_iter().filter(|g| !*g || flat) {
    // rust: let geometry_path = folder.0.join("shaders/shadow.gsh");
    // rust: if geometry {
    // rust: std::fs::write(&geometry_path, geometry_shader).unwrap();
    // rust: } else if geometry_path.exists() {
    // rust: std::fs::remove_file(&geometry_path).unwrap();
}
    // rust: std::fs::write(
    // rust: folder.0.join("shaders/shadow.vsh"),
    // rust: if geometry {
    // rust: geometry_vertex.as_str()
    // rust: } else {
    // rust: vertex
    // rust: },
    // rust: )
    // rust: .unwrap();
    // rust: let post = horizon_shaders::load_post(
    // rust: &pack,
    // rust: "",
    // rust: &properties,
    // rust: &macros,
    // rust: &horizon_shaders::GameInputs {
    // rust: terrain: Some(atlas.terrain_inputs(flat)),
    // rust: terrain_geometry: geometry.then(|| horizon_shaders::GeometryInputs {
    // rust: inputs: atlas.terrain_inputs(true),
    // rust: pull: super::PULL.to_owned(),
    // rust: index: "@".to_owned(),
    // rust: }),
    // rust: ..Default::default()
    // rust: },
    // rust: );
    // rust: for (name, program) in [
    // rust: ("terrain", &post.terrain),
    // rust: ("water", &post.water),
    // rust: ("shadow", &post.shadow),
    // rust: ] {
    // rust: if geometry && name != "shadow" {
    // rust: continue;
}
    // rust: let program = program
    // rust: .as_ref()
    // rust: .unwrap_or_else(|| panic!("{name}: {:?}", post.notes));
    // rust: for &(case, timestamp, elapsed, fade_ms, handover, expected) in &cases {
    // rust: let visibility = section_visibility(
    // rust: timestamp,
    // rust: fade_ms,
    // rust: uploaded + Duration::from_millis(elapsed),
    // rust: );
    // rust: let origin = section_instance([48.0, 0.0, -16.0], handover, visibility);
    // rust: let pixel = sample(
    // rust: &device,
    // rust: &queue,
    // rust: &atlas,
    // rust: program.program.as_ref().unwrap(),
    // rust: flat,
    // rust: geometry,
    // rust: origin,
    // rust: );
    // rust: let fade = if requested { expected } else { 1.0 };
    // rust: let expected = [
    // rust: fade,
    // rust: if geometry { 0.8125 } else { fade },
    // rust: 128.0 / 255.0,
    // rust: 0.25,
    // rust: ];
    // rust: assert!(
    // rust: pixel
    // rust: .iter()
    // rust: .zip(expected)
    // rust: .all(|(a, b)| a.is_finite() && (a - b).abs() < 2e-7),
    // rust: "{name} {case} flat={flat} geometry={geometry} requested={requested}: {pixel:?} != {expected:?}"
    // rust: );
    // rust: count += 1;
}
}
}
}
}
    // rust: eprintln!("terrain fade pack-to-pixel cases executed: {count}");
    // rust: assert_eq!(count, 98);
}

    // rust: fn sample(
    // rust: device: &wgpu::Device,
    // rust: queue: &wgpu::Queue,
    // rust: atlas: &PackAtlas,
    // rust: program: &horizon_shaders::Program,
    // rust: flat: bool,
    // rust: geometry: bool,
    // rust: origin: [f32; 4],
    // rust: ) -> [f32; 4] {
    // rust: let buffer = |bytes: &[u8], usage| {
    // rust: device.create_buffer_init(&wgpu::util::BufferInitDescriptor {
    // rust: label: None,
    // rust: contents: bytes,
    // rust: usage,
    // rust: })
}
    // rust: let uniform = buffer(
    // rust: &vec![0; program.interface.uniform_size as usize],
    // rust: wgpu::BufferUsages::UNIFORM,
    // rust: );
    // rust: let origins = buffer(
    // rust: bytemuck::bytes_of(&origin),
    // rust: wgpu::BufferUsages::STORAGE | wgpu::BufferUsages::VERTEX,
    // rust: );
    // rust: let slots = buffer(bytemuck::bytes_of(&0u32), wgpu::BufferUsages::STORAGE);
    // rust: let vertices: Vec<_> = [[0., 0., 0.], [1., 0., 0.], [1., 1., 0.], [0., 1., 0.]]
    // rust: .into_iter()
    // rust: .map(|pos| TerrainVertex::new(pos, [0.25, 0.75], 0, 0x80ffffff, 0))
    // rust: .collect();
    // rust: let data = buffer(
    // rust: bytemuck::cast_slice(&vertices),
    // rust: wgpu::BufferUsages::STORAGE | wgpu::BufferUsages::VERTEX,
    // rust: );
    // rust: let ids = buffer(bytemuck::bytes_of(&[0i32; 3]), wgpu::BufferUsages::STORAGE);
    // rust: let rects = buffer(
    // rust: bytemuck::cast_slice(&atlas.rects_table()),
    // rust: wgpu::BufferUsages::STORAGE,
    // rust: );
    // rust: let binding = |n, storage| wgpu::BindGroupLayoutEntry {
    // rust: binding: n,
    // rust: visibility: wgpu::ShaderStages::VERTEX_FRAGMENT,
    // rust: ty: wgpu::BindingType::Buffer {
    // rust: ty: if storage {
    // rust: wgpu::BufferBindingType::Storage { read_only: true }
    // rust: } else {
    // rust: wgpu::BufferBindingType::Uniform
    // rust: },
    // rust: has_dynamic_offset: false,
    // rust: min_binding_size: None,
    // rust: },
    // rust: count: None,
}
    // rust: let entries = [
    // rust: vec![binding(0, false)],
    // rust: if flat {
    // rust: vec![binding(0, true), binding(1, true)]
    // rust: } else {
    // rust: vec![]
    // rust: },
    // rust: vec![],
    // rust: if flat {
    // rust: vec![binding(0, true), binding(1, true), binding(2, true)]
    // rust: } else {
    // rust: vec![]
    // rust: },
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
    // rust: let bindings = [
    // rust: vec![(0, &uniform)],
    // rust: if flat {
    // rust: vec![(0, &slots), (1, &origins)]
    // rust: } else {
    // rust: vec![]
    // rust: },
    // rust: vec![],
    // rust: if flat {
    // rust: vec![(0, &ids), (1, &data), (2, &rects)]
    // rust: } else {
    // rust: vec![]
    // rust: },
    // rust: ];
    // rust: let groups: Vec<_> = layouts
    // rust: .iter()
    // rust: .zip(bindings)
    // rust: .map(|(layout, buffers)| {
    // rust: device.create_bind_group(&wgpu::BindGroupDescriptor {
    // rust: label: None,
    // rust: layout,
    // rust: entries: &buffers
    // rust: .into_iter()
    // rust: .map(|(binding, buffer)| wgpu::BindGroupEntry {
    // rust: binding,
    // rust: resource: buffer.as_entire_binding(),
    // rust: })
    // rust: .collect::<Vec<_>>(),
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
    // rust: let vs = module(program.vertex.clone());
    // rust: let fs = module(program.fragment.clone());
    // rust: let vertices = [
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
    // rust: buffers: &vertices[..if flat { 1 } else { 2 }],
    // rust: },
    // rust: primitive: wgpu::PrimitiveState {
    // rust: topology: if geometry {
    // rust: wgpu::PrimitiveTopology::TriangleList
    // rust: } else {
    // rust: wgpu::PrimitiveTopology::PointList
    // rust: },
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
    // rust: let output = device.create_texture(&wgpu::TextureDescriptor {
    // rust: label: None,
    // rust: size: wgpu::Extent3d {
    // rust: width: 1,
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
    // rust: size: 16,
    // rust: usage: wgpu::BufferUsages::MAP_READ | wgpu::BufferUsages::COPY_DST,
    // rust: mapped_at_creation: false,
    // rust: });
    // rust: let view = output.create_view(&Default::default());
    // rust: let mut encoder = device.create_command_encoder(&Default::default());
    // rust: {
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
    // rust: for (n, group) in groups.iter().enumerate() {
    // rust: pass.set_bind_group(n as u32, group, &[]);
}
    // rust: pass.set_vertex_buffer(0, data.slice(..));
    // rust: if !flat {
    // rust: pass.set_vertex_buffer(1, origins.slice(..));
}
    // rust: pass.draw(0..if geometry { 3 } else { 1 }, 0..1);
}
    // rust: encoder.copy_texture_to_buffer(
    // rust: output.as_image_copy(),
    // rust: wgpu::TexelCopyBufferInfo {
    // rust: buffer: &read,
    // rust: layout: Default::default(),
    // rust: },
    // rust: output.size(),
    // rust: );
    // rust: queue.submit([encoder.finish()]);
    // rust: read.map_async(wgpu::MapMode::Read, .., |_| {});
    // rust: device.poll(wgpu::PollType::wait_indefinitely()).unwrap();
    // rust: *bytemuck::from_bytes(&read.get_mapped_range(..).unwrap())
}
