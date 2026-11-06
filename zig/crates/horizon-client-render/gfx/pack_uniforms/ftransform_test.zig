//! Transpiled from Horizon Rust crate
//! Module: horizon-client-render_ftransform_test
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Original GPU probe of a pack's `ftransform()`, in gbuffers and shadow programs.

// use wgpu::util::DeviceExt;

/// Iris 1.11.7's `ftransform()` read back with a probe pack of ours (#8464) has the bits of
/// `gl_ProjectionMatrix * (gl_ModelViewMatrix * gl_Vertex)` at every vertex our probes read: the
/// model-view matrix first, then the projection, not their product matrix. These matrices tell
/// the two apart (one rounding against two): the model-view matrix takes 16777 from x, so the
/// vertex at 16777.25 comes out at exactly 0.25, and a third of that is one rounding; the product
/// matrix holds a third of 16777 rounded to a float, which leaves an error near 1e-4 after the
/// subtraction.
pub fn ftransform_applies_the_model_view_matrix_before_the_projection() void {
}
    // rust: let instance = crate::gfx::test_gpu::instance();
    // rust: let Ok(adapter) = pollster::block_on(instance.request_adapter(&Default::default())) else {
    // rust: return;
}
    // rust: let (device, queue) = pollster::block_on(adapter.request_device(&Default::default())).unwrap();
    // rust: let third = 1.0f32 / 3.0;
    // rust: let model_view = glam::Mat4::from_translation(glam::Vec3::new(-16777.0, 2.0, 0.0));
    // rust: let projection = glam::Mat4::from_scale(glam::Vec3::new(third, 0.5, 1.0));
    // rust: let vertices = [[16777.25f32, 1.0, -3.0], [16778.0, -2.0, 5.0]];
    // `0.25 * third` and `1.0 * third` are exact products: one rounding of each.
    // rust: let expected = [[0.25 * third, 1.5, -3.0, 1.0], [third, 0.0, 5.0, 1.0]];
    // rust: let mut failures = Vec::new();
    // rust: for shadow in [false, true] {
    // rust: let got = ftransform(&device, &queue, model_view, projection, &vertices, shadow);
    // rust: for ((v, want), got) in vertices.iter().zip(&expected).zip(&got) {
    // rust: if got.map(f32::to_bits) != want.map(f32::to_bits) {
    // rust: failures.push(format!("{v:?}, shadow={shadow}: {got:?} != {want:?}"));
}
}
}
    // rust: assert!(failures.is_empty(), "{}", failures.join("\n"));
}

/// `ftransform()` of each of `vertices` in a gbuffers program (or a shadow program, with the
/// matrices as the shadow camera's), read back from a point per vertex as float bits.
    // rust: fn ftransform(
    // rust: device: &wgpu::Device,
    // rust: queue: &wgpu::Queue,
    // rust: model_view: glam::Mat4,
    // rust: projection: glam::Mat4,
    // rust: vertices: &[[f32; 3]],
    // rust: shadow: bool,
    // rust: ) -> Vec<[f32; 4]> {
    // rust: let pp = |code: &str| horizon_shaders::Preprocessed {
    // rust: code: code.to_owned(),
    // rust: ..Default::default()
}
    // rust: let vertex = pp(&format!(
    // rust: "varying vec4 probe;\nvoid main() {{\n    probe = ftransform();\n    \
    // rust: gl_Position = vec4((float(gl_VertexID) + 0.5) * {} - 1.0, 0.0, 0.0, 1.0);\n}}",
    // rust: 2.0 / vertices.len() as f32,
    // rust: ));
    // An integer target keeps the float bits on any adapter.
    // rust: let fragment = pp(
    // rust: "varying vec4 probe;\nlayout(location = 0) out uvec4 bits;\n\
    // rust: void main() { bits = floatBitsToUint(probe); }",
    // rust: );
    // rust: let inputs = horizon_shaders::GbuffersInputs {
    // rust: declarations: "layout(location = 0) in vec3 hz_v_pos;".into(),
    // rust: body: "    hz_Vertex = vec4(hz_v_pos, 1.0);\n    hz_Color = vec4(1.0);\n".into(),
    // rust: ..Default::default()
}
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
    // rust: let prefix = if shadow { "shadow" } else { "gbuffer" };
    // rust: let mut block = program.interface.initial_values.clone();
    // rust: block.resize(program.interface.uniform_size.max(16) as usize, 0);
    // rust: for (name, matrix) in [("ModelView", model_view), ("Projection", projection)] {
    // rust: let name = format!("{prefix}{name}");
    // rust: let at = (program.interface.uniforms.iter())
    // rust: .find(|u| u.name == name)
    // rust: .unwrap_or_else(|| panic!("no {name}"))
    // rust: .offset as usize;
    // rust: block[at..at + 64].copy_from_slice(bytemuck::cast_slice(&matrix.to_cols_array()));
}
    // rust: let uniform = device.create_buffer_init(&wgpu::util::BufferInitDescriptor {
    // rust: label: None,
    // rust: contents: &block,
    // rust: usage: wgpu::BufferUsages::UNIFORM,
    // rust: });
    // rust: let data = device.create_buffer_init(&wgpu::util::BufferInitDescriptor {
    // rust: label: None,
    // rust: contents: bytemuck::cast_slice(vertices),
    // rust: usage: wgpu::BufferUsages::VERTEX,
    // rust: });
    // rust: let group_layout = device.create_bind_group_layout(&wgpu::BindGroupLayoutDescriptor {
    // rust: label: None,
    // rust: entries: &[wgpu::BindGroupLayoutEntry {
    // rust: binding: 0,
    // rust: visibility: wgpu::ShaderStages::VERTEX_FRAGMENT,
    // rust: ty: wgpu::BindingType::Buffer {
    // rust: ty: wgpu::BufferBindingType::Uniform,
    // rust: has_dynamic_offset: false,
    // rust: min_binding_size: None,
    // rust: },
    // rust: count: None,
    // rust: }],
    // rust: });
    // rust: let group = device.create_bind_group(&wgpu::BindGroupDescriptor {
    // rust: label: None,
    // rust: layout: &group_layout,
    // rust: entries: &[wgpu::BindGroupEntry {
    // rust: binding: 0,
    // rust: resource: uniform.as_entire_binding(),
    // rust: }],
    // rust: });
    // rust: let layout = device.create_pipeline_layout(&wgpu::PipelineLayoutDescriptor {
    // rust: label: None,
    // rust: bind_group_layouts: &[Some(&group_layout)],
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
    // rust: let pipeline = device.create_render_pipeline(&wgpu::RenderPipelineDescriptor {
    // rust: label: None,
    // rust: layout: Some(&layout),
    // rust: vertex: wgpu::VertexState {
    // rust: module: &vs,
    // rust: entry_point: Some("main"),
    // rust: compilation_options: Default::default(),
    // rust: buffers: &[Some(wgpu::VertexBufferLayout {
    // rust: array_stride: 12,
    // rust: step_mode: wgpu::VertexStepMode::Vertex,
    // rust: attributes: &wgpu::vertex_attr_array![0 => Float32x3],
    // rust: })],
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
    // rust: pass.set_bind_group(0, &group, &[]);
    // rust: pass.set_vertex_buffer(0, data.slice(..));
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
