//! Transpiled from Horizon Rust crate
//! Module: horizon-client-render_world_text
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! NORMAL world text: alpha blended, back-face culled, ordinary depth writes.
    // rust: pub(super) fn pipeline(
    // rust: device: &wgpu::Device,
    // rust: layout: Option<&wgpu::PipelineLayout>,
    // rust: shader: &wgpu::ShaderModule,
    // rust: format: wgpu::TextureFormat,
    // rust: ) -> wgpu::RenderPipeline {
    // rust: let attributes = wgpu::vertex_attr_array![0=>Float32x3,1=>Float32x2,2=>Uint32,3=>Unorm8x4,4=>Uint8x4,5=>Snorm8x4,6=>Float32x2];
    // rust: device.create_render_pipeline(&wgpu::RenderPipelineDescriptor {
    // rust: label: Some("Normal world text"),
    // rust: layout,
    // rust: vertex: wgpu::VertexState {
    // rust: module: shader,
    // rust: entry_point: Some("vs_entity"),
    // rust: compilation_options: Default::default(),
    // rust: buffers: &[Some(wgpu::VertexBufferLayout {
    // rust: array_stride: std::mem::size_of::<super::Vertex>() as u64,
    // rust: step_mode: wgpu::VertexStepMode::Vertex,
    // rust: attributes: &attributes,
    // rust: })],
    // rust: },
    // rust: primitive: wgpu::PrimitiveState {
    // rust: cull_mode: Some(wgpu::Face::Back),
    // rust: ..Default::default()
    // rust: },
    // rust: depth_stencil: Some(wgpu::DepthStencilState {
    // rust: format: wgpu::TextureFormat::Depth32Float,
    // rust: depth_write_enabled: Some(true),
    // rust: depth_compare: Some(wgpu::CompareFunction::GreaterEqual),
    // rust: stencil: Default::default(),
    // rust: bias: Default::default(),
    // rust: }),
    // rust: multisample: Default::default(),
    // rust: fragment: Some(wgpu::FragmentState {
    // rust: module: shader,
    // rust: entry_point: Some("fs_entity"),
    // rust: compilation_options: Default::default(),
    // rust: targets: &[Some(wgpu::ColorTargetState {
    // rust: format,
    // rust: blend: Some(wgpu::BlendState::ALPHA_BLENDING),
    // rust: write_mask: wgpu::ColorWrites::ALL,
    // rust: })],
    // rust: }),
    // rust: multiview_mask: None,
    // rust: cache: None,
    // rust: })
}

    // rust: mod tests {
//     use super::*;
//     use wgpu::util::DeviceExt;
pub fn world_text_blends_culls_and_obeys_world_depth() void {
}
    // rust: let instance = crate::gfx::test_gpu::instance();
    // rust: let adapter = pollster::block_on(instance.request_adapter(&Default::default())).unwrap();
    // rust: let (device, queue) =
    // rust: pollster::block_on(adapter.request_device(&Default::default())).unwrap();
        // Use the production pipeline/vertex layout with a pass-through shader
        // to isolate its actual depth, winding and blend behavior from lighting.
    // rust: let shader = device.create_shader_module(wgpu::ShaderModuleDescriptor {
    // rust: label: None,
    // rust: source: wgpu::ShaderSource::Wgsl(
    // rust: r#"
pub const Out = struct {
    // rust: @vertex fn vs_entity(@location(0) pos:vec3<f32>, @location(3) color:vec4<f32>)->Out {
    // rust: return Out(vec4(pos,1.0),color);
};
    // rust: @fragment fn fs_entity(v:Out)->@location(0) vec4<f32> { return v.color; }
    // rust: "#
    // rust: .into(),
    // rust: ),
    // rust: });
    // rust: let pipeline = pipeline(&device, None, &shader, wgpu::TextureFormat::Rgba8Unorm);
    // rust: let texture = |format, usage| {
    // rust: device.create_texture(&wgpu::TextureDescriptor {
    // rust: label: None,
    // rust: size: wgpu::Extent3d {
    // rust: width: 4,
    // rust: height: 1,
    // rust: depth_or_array_layers: 1,
    // rust: },
    // rust: mip_level_count: 1,
    // rust: sample_count: 1,
    // rust: dimension: wgpu::TextureDimension::D2,
    // rust: format,
    // rust: usage,
    // rust: view_formats: &[],
    // rust: })
}
    // rust: let color = texture(
    // rust: wgpu::TextureFormat::Rgba8Unorm,
    // rust: wgpu::TextureUsages::RENDER_ATTACHMENT | wgpu::TextureUsages::COPY_SRC,
    // rust: );
    // rust: let depth = texture(
    // rust: wgpu::TextureFormat::Depth32Float,
    // rust: wgpu::TextureUsages::RENDER_ATTACHMENT,
    // rust: );
    // rust: let mut vertices = Vec::new();
    // rust: let mut indices = Vec::new();
    // rust: let mut quad = |pixel: u32, z: f32, color: [u8; 4], back: bool| {
    // rust: let x = -1.0 + pixel as f32 * 0.5;
    // rust: let first = vertices.len() as u32;
    // rust: for pos in [
    // rust: [x, -1.0, z],
    // rust: [x + 0.5, -1.0, z],
    // rust: [x + 0.5, 1.0, z],
    // rust: [x, 1.0, z],
    // rust: ] {
    // rust: vertices.push(super::super::Vertex {
    // rust: pos,
    // rust: uv: [0.0; 2],
    // rust: color: u32::from_le_bytes(color),
    // rust: layer: 0,
    // rust: light: 0,
    // rust: normal: [0; 4],
    // rust: glint_uv: [0.0; 2],
    // rust: });
}
    // rust: for i in if back {
    // rust: [0, 2, 1, 0, 3, 2]
    // rust: } else {
    // rust: [0, 1, 2, 0, 2, 3]
    // rust: } {
    // rust: indices.push(first + i);
}
}
    // rust: quad(0, 0.6, [255, 0, 0, 255], false);
        // A hair behind: the entity model pipeline's 128-ulp depth bias
        // would incorrectly put the green quad in front of the red surface.
    // rust: quad(0, 0.599_999, [0, 255, 0, 255], false);
    // rust: quad(1, 0.8, [0, 255, 0, 255], false);
    // rust: quad(1, 0.7, [255, 0, 0, 255], false);
    // rust: quad(2, 0.5, [255, 0, 0, 128], false);
    // rust: quad(3, 0.5, [255, 255, 0, 255], true);
    // rust: let buffer = |data: &[u8], usage| {
    // rust: device.create_buffer_init(&wgpu::util::BufferInitDescriptor {
    // rust: label: None,
    // rust: contents: data,
    // rust: usage,
    // rust: })
}
    // rust: let vertex = buffer(bytemuck::cast_slice(&vertices), wgpu::BufferUsages::VERTEX);
    // rust: let index = buffer(bytemuck::cast_slice(&indices), wgpu::BufferUsages::INDEX);
    // rust: let readback = device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: None,
    // rust: size: 256,
    // rust: usage: wgpu::BufferUsages::COPY_DST | wgpu::BufferUsages::MAP_READ,
    // rust: mapped_at_creation: false,
    // rust: });
    // rust: let mut encoder = device.create_command_encoder(&Default::default());
    // rust: {
    // rust: let color = color.create_view(&Default::default());
    // rust: let depth = depth.create_view(&Default::default());
    // rust: let mut pass = encoder.begin_render_pass(&wgpu::RenderPassDescriptor {
    // rust: color_attachments: &[Some(wgpu::RenderPassColorAttachment {
    // rust: view: &color,
    // rust: depth_slice: None,
    // rust: resolve_target: None,
    // rust: ops: wgpu::Operations {
    // rust: load: wgpu::LoadOp::Clear(wgpu::Color::BLUE),
    // rust: store: wgpu::StoreOp::Store,
    // rust: },
    // rust: })],
    // rust: depth_stencil_attachment: Some(wgpu::RenderPassDepthStencilAttachment {
    // rust: view: &depth,
    // rust: depth_ops: Some(wgpu::Operations {
    // rust: load: wgpu::LoadOp::Clear(0.0),
    // rust: store: wgpu::StoreOp::Store,
    // rust: }),
    // rust: stencil_ops: None,
    // rust: }),
    // rust: ..Default::default()
    // rust: });
    // rust: pass.set_pipeline(&pipeline);
    // rust: pass.set_vertex_buffer(0, vertex.slice(..));
    // rust: pass.set_index_buffer(index.slice(..), wgpu::IndexFormat::Uint32);
    // rust: pass.draw_indexed(0..indices.len() as u32, 0, 0..1);
}
    // rust: encoder.copy_texture_to_buffer(
    // rust: color.as_image_copy(),
    // rust: wgpu::TexelCopyBufferInfo {
    // rust: buffer: &readback,
    // rust: layout: wgpu::TexelCopyBufferLayout {
    // rust: offset: 0,
    // rust: bytes_per_row: Some(256),
    // rust: rows_per_image: None,
    // rust: },
    // rust: },
    // rust: color.size(),
    // rust: );
    // rust: queue.submit([encoder.finish()]);
    // rust: let (tx, rx) = std::sync::mpsc::channel();
    // rust: readback.map_async(wgpu::MapMode::Read, .., move |result| {
    // rust: tx.send(result).unwrap()
    // rust: });
    // rust: device.poll(wgpu::PollType::wait_indefinitely()).unwrap();
    // rust: rx.recv().unwrap().unwrap();
    // rust: let pixels = readback.get_mapped_range(..).unwrap();
    // rust: assert_eq!(
    // rust: &pixels[..16],
    // rust: &[
    // rust: 255, 0, 0, 255, 0, 255, 0, 255, 128, 0, 127, 255, 0, 0, 255, 255
    // rust: ]
    // rust: );
}
}
