//! Transpiled from Horizon Rust crate
package horizon_client_render_entity_outline

import "core:fmt"
import "core:mem"
import "core:math"

// The entity outline (`LevelRenderer.entityOutlineTarget`): the glowing entities'
// silhouettes in their team colours, drawn without depth so walls do not hide them
// (`RenderTypes.outline`), the `entity_outline` post chain over them (`entity_sobel`, then
// `entity_outline_box_blur` across and up), and `LevelRenderer.blitEntityOutline` onto
// the frame after the hand.
// use super::Vertex;

// `entityOutlineTarget`'s `GpuFormat.RGBA8_UNORM`.
FORMAT :: wgpu::TextureFormat::Rgba8Unorm

Targets :: struct {
    size: [u32,
    // `entityOutlineTarget`.
    outline: wgpu::TextureView,
    // The chain's `swap` target.
    swap: wgpu::TextureView,
    // What each pass reads: the outline (nearest), swap (bilinear), the outline
    // (bilinear), swap (nearest).
    groups: [wgpu::BindGroup,
}

    // rust: pub(super) struct EntityOutline {
    // rust: silhouette: wgpu::RenderPipeline,
    // Sobel, blur across, blur up (into `FORMAT`) and the blended blit (onto the frame).
    // rust: passes: [wgpu::RenderPipeline; 4],
    // rust: layout: wgpu::BindGroupLayout,
    // rust: nearest: wgpu::Sampler,
    // rust: bilinear: wgpu::Sampler,
    // rust: vertices: wgpu::Buffer,
    // rust: capacity: u64,
    // rust: quads: u32,
    // The silhouettes posed on the GPU: first vertex in the entity buffer, quads.
    // rust: posed: (u32, u32),
    // rust: targets: Option<Targets>,
}

    // rust: impl EntityOutline {
    // `entity` draws the silhouettes with the entity shader's vertex stage and
    // `fs_outline`; `format` is the frame's.
    // rust: pub(super) fn new(
    // rust: device: &wgpu::Device,
    // rust: entity: (
    // rust: &wgpu::ShaderModule,
    // rust: &wgpu::PipelineLayout,
    // rust: &[Option<wgpu::VertexBufferLayout>],
    // rust: ),
    // rust: format: wgpu::TextureFormat,
    // rust: ) -> Self {
    // rust: let (entity_shader, entity_layout, entity_vertex) = entity;
        // RenderPipelines.OUTLINE_NO_CULL: no depth test, the colour replaced.
    // rust: let silhouette = device.create_render_pipeline(&wgpu::RenderPipelineDescriptor {
    // rust: label: Some("Entity outline silhouettes"),
    // rust: layout: Some(entity_layout),
    // rust: vertex: wgpu::VertexState {
    // rust: module: entity_shader,
    // rust: entry_point: Some("vs_entity"),
    // rust: compilation_options: Default::default(),
    // rust: buffers: entity_vertex,
    // rust: },
    // rust: primitive: Default::default(),
    // rust: depth_stencil: None,
    // rust: multisample: Default::default(),
    // rust: fragment: Some(wgpu::FragmentState {
    // rust: module: entity_shader,
    // rust: entry_point: Some("fs_outline"),
    // rust: compilation_options: Default::default(),
    // rust: targets: &[Some(FORMAT.into())],
    // rust: }),
    // rust: multiview_mask: None,
    // rust: cache: None,
    // rust: });
    // rust: let shader = device.create_shader_module(wgpu::ShaderModuleDescriptor {
    // rust: label: Some("Entity outline"),
    // rust: source: wgpu::ShaderSource::Wgsl(include_str!("entity_outline.wgsl").into()),
    // rust: });
    // rust: let layout = device.create_bind_group_layout(&wgpu::BindGroupLayoutDescriptor {
    // rust: label: Some("Entity outline bindings"),
    // rust: entries: &[
    // rust: wgpu::BindGroupLayoutEntry {
    // rust: binding: 0,
    // rust: visibility: wgpu::ShaderStages::FRAGMENT,
    // rust: ty: wgpu::BindingType::Texture {
    // rust: sample_type: wgpu::TextureSampleType::Float { filterable: true },
    // rust: view_dimension: wgpu::TextureViewDimension::D2,
    // rust: multisampled: false,
    // rust: },
    // rust: count: None,
    // rust: },
    // rust: wgpu::BindGroupLayoutEntry {
    // rust: binding: 1,
    // rust: visibility: wgpu::ShaderStages::FRAGMENT,
    // rust: ty: wgpu::BindingType::Sampler(wgpu::SamplerBindingType::Filtering),
    // rust: count: None,
    // rust: },
    // rust: ],
    // rust: });
    // rust: let pipeline_layout = device.create_pipeline_layout(&wgpu::PipelineLayoutDescriptor {
    // rust: label: Some("Entity outline"),
    // rust: bind_group_layouts: &[Some(&layout)],
    // rust: ..Default::default()
    // rust: });
    // rust: let pass = |entry: &str, target: wgpu::ColorTargetState| {
    // rust: device.create_render_pipeline(&wgpu::RenderPipelineDescriptor {
    // rust: label: Some(entry),
    // rust: layout: Some(&pipeline_layout),
    // rust: vertex: wgpu::VertexState {
    // rust: module: &shader,
    // rust: entry_point: Some("vs_quad"),
    // rust: compilation_options: Default::default(),
    // rust: buffers: &[],
    // rust: },
    // rust: primitive: Default::default(),
    // rust: depth_stencil: None,
    // rust: multisample: Default::default(),
    // rust: fragment: Some(wgpu::FragmentState {
    // rust: module: &shader,
    // rust: entry_point: Some(entry),
    // rust: compilation_options: Default::default(),
    // rust: targets: &[Some(target)],
    // rust: }),
    // rust: multiview_mask: None,
    // rust: cache: None,
    // rust: })
}
        // BlendFunction.ENTITY_OUTLINE_BLIT over the colour only (write mask 7).
    // rust: let blit = wgpu::ColorTargetState {
    // rust: format,
    // rust: blend: Some(wgpu::BlendState {
    // rust: color: wgpu::BlendComponent {
    // rust: src_factor: wgpu::BlendFactor::SrcAlpha,
    // rust: dst_factor: wgpu::BlendFactor::OneMinusSrcAlpha,
    // rust: operation: wgpu::BlendOperation::Add,
    // rust: },
    // rust: alpha: wgpu::BlendComponent {
    // rust: src_factor: wgpu::BlendFactor::Zero,
    // rust: dst_factor: wgpu::BlendFactor::One,
    // rust: operation: wgpu::BlendOperation::Add,
    // rust: },
    // rust: }),
    // rust: write_mask: wgpu::ColorWrites::COLOR,
}
    // rust: let sampler = |label, filter| {
    // rust: device.create_sampler(&wgpu::SamplerDescriptor {
    // rust: label: Some(label),
    // rust: mag_filter: filter,
    // rust: min_filter: filter,
    // rust: ..Default::default()
    // rust: })
}
    // rust: Self {
    // rust: silhouette,
    // rust: passes: [
    // rust: pass("fs_sobel", FORMAT.into()),
    // rust: pass("fs_blur_x", FORMAT.into()),
    // rust: pass("fs_blur_y", FORMAT.into()),
    // rust: pass("fs_blit", blit),
    // rust: ],
    // rust: layout,
    // rust: nearest: sampler("Entity outline nearest", wgpu::FilterMode::Nearest),
    // rust: bilinear: sampler("Entity outline bilinear", wgpu::FilterMode::Linear),
    // rust: vertices: Self::vertex_buffer(device, 256),
    // rust: capacity: 256,
    // rust: quads: 0,
    // rust: posed: (0, 0),
    // rust: targets: None,
}
}

vertex_buffer :: proc(device: ^wgpu::Device, capacity: u64) -> w {
    // Ported from Horizon
    return {}
}
    // rust: device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: Some("Entity outline vertices"),
    // rust: size: capacity * std::mem::size_of::<Vertex>() as u64,
    // rust: usage: wgpu::BufferUsages::VERTEX | wgpu::BufferUsages::COPY_DST,
    // rust: mapped_at_creation: false,
    // rust: })
}

    // Uploads this frame's silhouettes (`LevelRenderer.currentFrameRendersEntityOutline`
    // when there are any) and sizes the targets like the window. A frame with
    // none gives the targets' video memory back until an entity glows again.
    // `posed`: where the silhouettes posed on the GPU start in the entity
    // buffer (`entity_skin`'s outline jobs), and how many quads they are.
    // rust: pub(super) fn prepare(
    // rust: &mut self,
    // rust: device: &wgpu::Device,
    // rust: uploads: &mut super::upload::Uploads,
    // rust: encoder: &mut wgpu::CommandEncoder,
    // rust: silhouettes: &[Vertex],
    // rust: posed: (u32, u32),
    // rust: size: [u32; 2],
    // rust: ) {
    // rust: self.quads = (silhouettes.len() / 4) as u32;
    // rust: self.posed = posed;
    // rust: if self.quads == 0 && posed.1 == 0 {
    // rust: self.targets = None;
    // rust: return;
}
    // rust: let vertices = silhouettes.len() as u64;
    // rust: if vertices > self.capacity {
    // rust: self.capacity = vertices.next_power_of_two();
    // rust: self.vertices = Self::vertex_buffer(device, self.capacity);
}
    // rust: if !silhouettes.is_empty() {
    // rust: uploads.buffer(
    // rust: encoder,
    // rust: &self.vertices,
    // rust: 0,
    // rust: bytemuck::cast_slice(silhouettes),
    // rust: );
}
    // rust: if self.targets.as_ref().is_some_and(|t| t.size == size) {
    // rust: return;
}
    // rust: let texture = |label| {
    // rust: device
    // rust: .create_texture(&wgpu::TextureDescriptor {
    // rust: label: Some(label),
    // rust: size: wgpu::Extent3d {
    // rust: width: size[0],
    // rust: height: size[1],
    // rust: depth_or_array_layers: 1,
    // rust: },
    // rust: mip_level_count: 1,
    // rust: sample_count: 1,
    // rust: dimension: wgpu::TextureDimension::D2,
    // rust: format: FORMAT,
    // rust: usage: wgpu::TextureUsages::RENDER_ATTACHMENT
    // rust: | wgpu::TextureUsages::TEXTURE_BINDING,
    // rust: view_formats: &[],
    // rust: })
    // rust: .create_view(&Default::default())
}
    // rust: let outline = texture("Entity outline");
    // rust: let swap = texture("Entity outline swap");
    // rust: let group = |view: &wgpu::TextureView, sampler: &wgpu::Sampler| {
    // rust: device.create_bind_group(&wgpu::BindGroupDescriptor {
    // rust: label: Some("Entity outline pass"),
    // rust: layout: &self.layout,
    // rust: entries: &[
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 0,
    // rust: resource: wgpu::BindingResource::TextureView(view),
    // rust: },
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 1,
    // rust: resource: wgpu::BindingResource::Sampler(sampler),
    // rust: },
    // rust: ],
    // rust: })
}
    // rust: let groups = [
    // rust: group(&outline, &self.nearest),
    // rust: group(&swap, &self.bilinear),
    // rust: group(&outline, &self.bilinear),
    // rust: group(&swap, &self.nearest),
    // rust: ];
    // rust: self.targets = Some(Targets {
    // rust: size,
    // rust: outline,
    // rust: swap,
    // rust: groups,
    // rust: });
}

    // `LevelRenderer.executeOutline`, the post chain and `blitEntityOutline` onto `frame`.
    // rust: pub(super) fn draw(
    // rust: &self,
    // rust: encoder: &mut wgpu::CommandEncoder,
    // rust: frame: &wgpu::TextureView,
    // rust: entity_group: &wgpu::BindGroup,
    // rust: indices: &wgpu::Buffer,
    // rust: entities: &wgpu::Buffer,
    // rust: mut timing: Option<&mut super::pack_timing::PassTiming>,
    // rust: ) {
    // rust: let Some(t) = self
    // rust: .targets
    // rust: .as_ref()
    // rust: .filter(|_| self.quads > 0 || self.posed.1 > 0)
    // rust: else {
    // rust: return;
}
    // rust: let clear = wgpu::LoadOp::Clear(wgpu::Color::TRANSPARENT);
    // rust: {
    // rust: let mut pass = begin(
    // rust: encoder,
    // rust: "Entity outline",
    // rust: &t.outline,
    // rust: clear,
    // rust: timing.as_deref_mut(),
    // rust: );
    // rust: pass.set_pipeline(&self.silhouette);
    // rust: pass.set_bind_group(0, entity_group, &[]);
    // rust: pass.set_index_buffer(indices.slice(..), wgpu::IndexFormat::Uint32);
    // rust: if self.quads > 0 {
    // rust: pass.set_vertex_buffer(0, self.vertices.slice(..));
    // rust: pass.draw_indexed(0..self.quads * 6, 0, 0..1);
}
    // rust: let (first, quads) = self.posed;
    // rust: if quads > 0 {
    // rust: pass.set_vertex_buffer(0, entities.slice(..));
    // rust: pass.draw_indexed(0..quads * 6, first as i32, 0..1);
}
}
        // post_effect/entity_outline.json; its last pass only copies swap back to the
        // outline target, so the blit reads swap.
    // rust: let steps = [
    // rust: ("Entity outline sobel", &t.swap, clear),
    // rust: ("Entity outline blur across", &t.outline, clear),
    // rust: ("Entity outline blur up", &t.swap, clear),
    // rust: ("Entity outline blit", frame, wgpu::LoadOp::Load),
    // rust: ];
    // rust: for (i, (label, view, load)) in steps.into_iter().enumerate() {
    // rust: let mut pass = begin(encoder, label, view, load, timing.as_deref_mut());
    // rust: pass.set_pipeline(&self.passes[i]);
    // rust: pass.set_bind_group(0, &t.groups[i], &[]);
    // rust: pass.draw(0..3, 0..1);
}
}
}

    // rust: fn begin<'e>(
    // rust: encoder: &'e mut wgpu::CommandEncoder,
    // rust: label: &str,
    // rust: view: &wgpu::TextureView,
    // rust: load: wgpu::LoadOp<wgpu::Color>,
    // rust: timing: Option<&mut super::pack_timing::PassTiming>,
    // rust: ) -> wgpu::RenderPass<'e> {
    // rust: let attachments = [Some(wgpu::RenderPassColorAttachment {
    // rust: view,
    // rust: resolve_target: None,
    // rust: depth_slice: None,
    // rust: ops: wgpu::Operations {
    // rust: load,
    // rust: store: wgpu::StoreOp::Store,
    // rust: },
    // rust: })];
    // rust: encoder.begin_render_pass(&wgpu::RenderPassDescriptor {
    // rust: label: Some(label),
    // rust: timestamp_writes: timing.and_then(|t| t.writes(label)),
    // rust: color_attachments: &attachments,
    // rust: ..Default::default()
    // rust: })
}
