//! Transpiled from Horizon Rust crate
package horizon_client_render_hdr_stats

import "core:fmt"
import "core:mem"
import "core:math"

// HDR emission thresholds (`hdr_stats.wgsl`): for every block sprite, the brightness its
// pixels must reach to shine in HDR output, measured on the GPU from the sprite's own
// darkest and brightest opaque pixel when HDR output turns on. Until then (and with HDR
// off) the texture holds zeros: every pixel of a light source may shine, and hdr.wgsl's
// tier windows alone decide, as before.

// use super::hdr::Masks;

EmissionStats :: struct {
    // One texel per sprite: x the layer in its array, y the array.
    view: wgpu::TextureView,
    layout: wgpu::BindGroupLayout,
    pipeline: wgpu::RenderPipeline,
    params: wgpu::Buffer,
}

    // rust: impl EmissionStats {
new :: proc(device: ^wgpu::Device, split: u32, arrays: u32) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let texture = device.create_texture(&wgpu::TextureDescriptor {
    // rust: label: Some("Horizon HDR emission thresholds"),
    // rust: size: wgpu::Extent3d {
    // rust: width: split,
    // rust: height: arrays,
    // rust: depth_or_array_layers: 1,
    // rust: },
    // rust: mip_level_count: 1,
    // rust: sample_count: 1,
    // rust: dimension: wgpu::TextureDimension::D2,
    // rust: format: wgpu::TextureFormat::Rgba8Unorm,
    // rust: usage: wgpu::TextureUsages::TEXTURE_BINDING | wgpu::TextureUsages::RENDER_ATTACHMENT,
    // rust: view_formats: &[],
    // rust: });
    // rust: let view = texture.create_view(&Default::default());
    // rust: let shader = device.create_shader_module(wgpu::ShaderModuleDescriptor {
    // rust: label: Some("Horizon HDR emission thresholds"),
    // rust: source: wgpu::ShaderSource::Wgsl(include_str!("../hdr_stats.wgsl").into()),
    // rust: });
    // rust: let mut entries: Vec<_> = (0..super::SPRITE_ARRAYS)
    // rust: .map(|binding| wgpu::BindGroupLayoutEntry {
    // rust: binding,
    // rust: visibility: wgpu::ShaderStages::FRAGMENT,
    // rust: ty: wgpu::BindingType::Texture {
    // rust: sample_type: wgpu::TextureSampleType::Float { filterable: true },
    // rust: view_dimension: wgpu::TextureViewDimension::D2Array,
    // rust: multisampled: false,
    // rust: },
    // rust: count: None,
    // rust: })
    // rust: .collect();
    // rust: entries.push(wgpu::BindGroupLayoutEntry {
    // rust: binding: super::SPRITE_ARRAYS,
    // rust: visibility: wgpu::ShaderStages::FRAGMENT,
    // rust: ty: wgpu::BindingType::Buffer {
    // rust: ty: wgpu::BufferBindingType::Uniform,
    // rust: has_dynamic_offset: false,
    // rust: min_binding_size: None,
    // rust: },
    // rust: count: None,
    // rust: });
    // rust: let layout = device.create_bind_group_layout(&wgpu::BindGroupLayoutDescriptor {
    // rust: label: Some("Horizon HDR emission thresholds"),
    // rust: entries: &entries,
    // rust: });
    // rust: let pipeline_layout = device.create_pipeline_layout(&wgpu::PipelineLayoutDescriptor {
    // rust: label: Some("Horizon HDR emission thresholds"),
    // rust: bind_group_layouts: &[Some(&layout)],
    // rust: ..Default::default()
    // rust: });
    // rust: let pipeline = device.create_render_pipeline(&wgpu::RenderPipelineDescriptor {
    // rust: label: Some("Horizon HDR emission thresholds"),
    // rust: layout: Some(&pipeline_layout),
    // rust: vertex: wgpu::VertexState {
    // rust: module: &shader,
    // rust: entry_point: Some("vs_stats"),
    // rust: compilation_options: Default::default(),
    // rust: buffers: &[],
    // rust: },
    // rust: primitive: Default::default(),
    // rust: depth_stencil: None,
    // rust: multisample: Default::default(),
    // rust: fragment: Some(wgpu::FragmentState {
    // rust: module: &shader,
    // rust: entry_point: Some("fs_stats"),
    // rust: compilation_options: Default::default(),
    // rust: targets: &[Some(wgpu::ColorTargetState {
    // rust: format: wgpu::TextureFormat::Rgba8Unorm,
    // rust: blend: None,
    // rust: write_mask: wgpu::ColorWrites::ALL,
    // rust: })],
    // rust: }),
    // rust: multiview_mask: None,
    // rust: cache: None,
    // rust: });
    // rust: let params = device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: Some("Horizon HDR emission threshold parameters"),
    // rust: size: 16,
    // rust: usage: wgpu::BufferUsages::UNIFORM | wgpu::BufferUsages::COPY_DST,
    // rust: mapped_at_creation: false,
    // rust: });
    // rust: Self {
    // rust: view,
    // rust: layout,
    // rust: pipeline,
    // rust: params,
}
}

    // Measures every sprite of `sprites` (terrain.wgsl's arrays) at `masks`.
    // rust: pub fn measure(
    // rust: &self,
    // rust: device: &wgpu::Device,
    // rust: queue: &wgpu::Queue,
    // rust: sprites: &[wgpu::TextureView],
    // rust: masks: Masks,
    // rust: ) {
    // rust: let mut params = [0u8; 16];
    // rust: params[..4].copy_from_slice(&masks.parts.to_le_bytes());
    // rust: params[4..8].copy_from_slice(&masks.whole.to_le_bytes());
    // rust: queue.write_buffer(&self.params, 0, &params);
    // rust: let mut entries: Vec<_> = sprites
    // rust: .iter()
    // rust: .enumerate()
    // rust: .map(|(binding, view)| wgpu::BindGroupEntry {
    // rust: binding: binding as u32,
    // rust: resource: wgpu::BindingResource::TextureView(view),
    // rust: })
    // rust: .collect();
    // rust: entries.push(wgpu::BindGroupEntry {
    // rust: binding: super::SPRITE_ARRAYS,
    // rust: resource: self.params.as_entire_binding(),
    // rust: });
    // rust: let group = device.create_bind_group(&wgpu::BindGroupDescriptor {
    // rust: label: Some("Horizon HDR emission thresholds"),
    // rust: layout: &self.layout,
    // rust: entries: &entries,
    // rust: });
    // rust: let mut encoder = device.create_command_encoder(&Default::default());
    // rust: {
    // rust: let mut pass = encoder.begin_render_pass(&wgpu::RenderPassDescriptor {
    // rust: label: Some("Horizon HDR emission thresholds"),
    // rust: color_attachments: &[Some(wgpu::RenderPassColorAttachment {
    // rust: view: &self.view,
    // rust: depth_slice: None,
    // rust: resolve_target: None,
    // rust: ops: wgpu::Operations {
    // rust: load: wgpu::LoadOp::Clear(wgpu::Color::TRANSPARENT),
    // rust: store: wgpu::StoreOp::Store,
    // rust: },
    // rust: })],
    // rust: ..Default::default()
    // rust: });
    // rust: pass.set_pipeline(&self.pipeline);
    // rust: pass.set_bind_group(0, &group, &[]);
    // rust: pass.draw(0..3, 0..1);
}
    // rust: queue.submit([encoder.finish()]);
}
}
