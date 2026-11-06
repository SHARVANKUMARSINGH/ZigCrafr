//! Transpiled from Horizon Rust crate
package horizon_client_render_world_post

import "core:fmt"
import "core:mem"
import "core:math"

// Resolution scale, FXAA and TAA (Horizon settings): the world renders into its
// own target at the scaled size, then one full-screen pass copies or
// anti-aliases it onto the screen, under the hand and HUD. With none on,
// the world renders straight to the screen.
//
// TAA jitters the world's projection by a sub-pixel offset each frame and blends
// the frame into a history reprojected through the depth buffer: its motion
// vectors are the camera's, so what moves on its own leans on the neighbourhood
// clamp alone.

// use glam::{DMat4, DVec3, Mat4, Vec2};

// The least a world is scaled to when memory runs out.
MIN_SCALE :: 0.25
// The TAA history format: 8 bits would band as frames accumulate.
HISTORY_FORMAT :: wgpu::TextureFormat::Rgba16Float

WorldTarget :: struct {
    size: [u32,
    color: wgpu::TextureView,
    depth: wgpu::TextureView,
    group: wgpu::BindGroup,
    taa: Maybe(History),
}

// TAA's two history textures at the output size (the world's, times the upscale), written
// in turn: `resolve[i]` writes `history[i]` from the world and `history[1 - i]`; `show[i]`
// copies `history[i]` to the screen.
History :: struct {
    size: [u32,
    history: [wgpu::TextureView,
    resolve: [wgpu::BindGroup,
    show: [wgpu::BindGroup,
}

// `world_post.wgsl`'s `Taa`.
TaaUniform :: struct {
    // This frame's unjittered clip space to the previous frame's.
    reproject: [[f32,
    // xy: this frame's jitter in clip space; z: 1 when the history is unusable.
    jitter: [f32,
}

// TAA's GPU resources, absent when the device cannot compile the shader.
TaaResources :: struct {
    layout: wgpu::BindGroupLayout,
    pipeline: wgpu::RenderPipeline,
    uniform: wgpu::Buffer,
}

Post :: struct {
    layout: wgpu::BindGroupLayout,
    sampler: wgpu::Sampler,
    copy: wgpu::RenderPipeline,
    fxaa: wgpu::RenderPipeline,
    format: wgpu::TextureFormat,
    // World resolution relative to the window (0.5..=2.0).
    scale: f32,
    antialias: bool,
    taa: bool,
    // Output pixels per rendered pixel while TAA is on (1: native): the world renders
    // this much smaller and TAA rebuilds it at the resolution scale's size.
    upscale: f32,
    // TAA runs this frame (`jitter`): not on the title screen or under a shader pack.
    taa_on: bool,
    target: Maybe(WorldTarget),
    taa_resources: Maybe(TaaResources),
    // Frames jittered so far (the Halton index), and which history the next resolve writes.
    taa_frame: u32,
    // The last TAA frame's unjittered `view_proj` and camera, `None` once a frame ran without it.
    taa_previous: Option<(DMat4,
    taa_this_frame: TaaUniform,
}

    // rust: impl Post {
new :: proc(device: ^wgpu::Device, format: wgpu::TextureFormat) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let shader = device.create_shader_module(wgpu::ShaderModuleDescriptor {
    // rust: label: Some("Horizon post"),
    // rust: source: wgpu::ShaderSource::Wgsl(include_str!("../world_post.wgsl").into()),
    // rust: });
    // rust: let layout = device.create_bind_group_layout(&wgpu::BindGroupLayoutDescriptor {
    // rust: label: Some("Horizon post bindings"),
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
    // rust: let texture = |binding, sample_type| wgpu::BindGroupLayoutEntry {
    // rust: binding,
    // rust: visibility: wgpu::ShaderStages::FRAGMENT,
    // rust: ty: wgpu::BindingType::Texture {
    // rust: sample_type,
    // rust: view_dimension: wgpu::TextureViewDimension::D2,
    // rust: multisampled: false,
    // rust: },
    // rust: count: None,
}
    // rust: let float = wgpu::TextureSampleType::Float { filterable: true };
    // rust: let pipeline_layout = device.create_pipeline_layout(&wgpu::PipelineLayoutDescriptor {
    // rust: label: Some("Horizon post"),
    // rust: bind_group_layouts: &[Some(&layout)],
    // rust: ..Default::default()
    // rust: });
    // rust: let pipeline = |entry: &str, layout: &wgpu::PipelineLayout, format| {
    // rust: device.create_render_pipeline(&wgpu::RenderPipelineDescriptor {
    // rust: label: Some("Horizon post"),
    // rust: layout: Some(layout),
    // rust: vertex: wgpu::VertexState {
    // rust: module: &shader,
    // rust: entry_point: Some("vs_post"),
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
    // rust: targets: &[Some(wgpu::ColorTargetState {
    // rust: format,
    // rust: blend: None,
    // rust: write_mask: wgpu::ColorWrites::ALL,
    // rust: })],
    // rust: }),
    // rust: multiview_mask: None,
    // rust: cache: None,
    // rust: })
}
    // rust: let taa_resources = {
    // rust: let taa_layout = device.create_bind_group_layout(&wgpu::BindGroupLayoutDescriptor {
    // rust: label: Some("Horizon TAA bindings"),
    // rust: entries: &[
    // rust: texture(0, float),
    // rust: wgpu::BindGroupLayoutEntry {
    // rust: binding: 1,
    // rust: visibility: wgpu::ShaderStages::FRAGMENT,
    // rust: ty: wgpu::BindingType::Sampler(wgpu::SamplerBindingType::Filtering),
    // rust: count: None,
    // rust: },
    // rust: texture(2, float),
                    // A depth view through an unfilterable float binding: the
                    // texel is the same, and the GLSL backend can read it.
    // rust: texture(3, wgpu::TextureSampleType::Float { filterable: false }),
    // rust: wgpu::BindGroupLayoutEntry {
    // rust: binding: 4,
    // rust: visibility: wgpu::ShaderStages::FRAGMENT,
    // rust: ty: wgpu::BindingType::Buffer {
    // rust: ty: wgpu::BufferBindingType::Uniform,
    // rust: has_dynamic_offset: false,
    // rust: min_binding_size: None,
    // rust: },
    // rust: count: None,
    // rust: },
    // rust: ],
    // rust: });
    // rust: let taa_pipeline_layout =
    // rust: device.create_pipeline_layout(&wgpu::PipelineLayoutDescriptor {
    // rust: label: Some("Horizon TAA"),
    // rust: bind_group_layouts: &[Some(&taa_layout)],
    // rust: ..Default::default()
    // rust: });
    // rust: let validation = device.push_error_scope(wgpu::ErrorFilter::Validation);
    // rust: let internal = device.push_error_scope(wgpu::ErrorFilter::Internal);
    // rust: let taa_pipeline = device.create_render_pipeline(&wgpu::RenderPipelineDescriptor {
    // rust: label: Some("Horizon TAA"),
    // rust: layout: Some(&taa_pipeline_layout),
    // rust: vertex: wgpu::VertexState {
    // rust: module: &shader,
    // rust: entry_point: Some("vs_post"),
    // rust: compilation_options: Default::default(),
    // rust: buffers: &[],
    // rust: },
    // rust: primitive: Default::default(),
    // rust: depth_stencil: None,
    // rust: multisample: Default::default(),
    // rust: fragment: Some(wgpu::FragmentState {
    // rust: module: &shader,
    // rust: entry_point: Some("fs_taa"),
    // rust: compilation_options: Default::default(),
    // rust: targets: &[Some(wgpu::ColorTargetState {
    // rust: format: HISTORY_FORMAT,
    // rust: blend: None,
    // rust: write_mask: wgpu::ColorWrites::ALL,
    // rust: })],
    // rust: }),
    // rust: multiview_mask: None,
    // rust: cache: None,
    // rust: });
    // rust: let internal = pollster::block_on(internal.pop());
    // rust: match internal.or(pollster::block_on(validation.pop())) {
    // rust: None => {
    // rust: let uniform = device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: Some("Horizon TAA"),
    // rust: size: std::mem::size_of::<TaaUniform>() as u64,
    // rust: usage: wgpu::BufferUsages::UNIFORM | wgpu::BufferUsages::COPY_DST,
    // rust: mapped_at_creation: false,
    // rust: });
    // rust: Some(TaaResources {
    // rust: layout: taa_layout,
    // rust: pipeline: taa_pipeline,
    // rust: uniform,
    // rust: })
}
    // rust: Some(e) => {
    // rust: log::warn!("Horizon renderer: temporal anti-aliasing unavailable ({e})");
    // rust: None
}
}
}
    // rust: let sampler = device.create_sampler(&wgpu::SamplerDescriptor {
    // rust: label: Some("Horizon post"),
    // rust: mag_filter: wgpu::FilterMode::Linear,
    // rust: min_filter: wgpu::FilterMode::Linear,
    // rust: ..Default::default()
    // rust: });
    // rust: Self {
    // rust: copy: pipeline("fs_copy", &pipeline_layout, format),
    // rust: fxaa: pipeline("fs_fxaa", &pipeline_layout, format),
    // rust: layout,
    // rust: sampler,
    // rust: format,
    // rust: scale: 1.0,
    // rust: antialias: false,
    // rust: taa: false,
    // rust: upscale: 1.0,
    // rust: taa_on: false,
    // rust: target: None,
    // rust: taa_resources,
    // rust: taa_frame: 0,
    // rust: taa_previous: None,
    // rust: taa_this_frame: bytemuck::Zeroable::zeroed(),
}
}

    // Whether TAA is supported on this GPU/backend.
supports_taa :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.taa_resources.is_some()
}

    // The world's rendered size and the size it is shown at (TAA's history).
sizes :: proc(self: ^Self, window: [u32; 2]) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let output = window.map(|v| ((v as f32 * self.scale).round() as u32).clamp(1, 8192));
    // rust: let upscale = if self.taa_on { self.upscale } else { 1.0 };
    // rust: (
    // rust: output.map(|v| ((v as f32 / upscale).round() as u32).max(1)),
    // rust: output,
    // rust: )
}

    // TAA's sub-pixel jitter this frame, as a clip-space matrix to multiply into the
    // world's projection (identity while `on` is false); `view_proj` is the unjittered
    // projection, relative to `camera`. Call it before `prepare`, once per frame.
jitter :: proc(self: ^Self, window: [u32; 2], on: bool, view_proj: Mat4, camera: DVec3) -> M {
    // Ported from Horizon
    return {}
}
    // rust: self.taa_on = on && self.taa && self.taa_resources.is_some();
    // rust: if !self.taa_on {
    // rust: self.taa_previous = None;
    // rust: return Mat4::IDENTITY;
}
    // rust: self.taa_frame = self.taa_frame.wrapping_add(1);
    // rust: let (size, _) = self.sizes(window);
        // Halton (2, 3) over 8 frames per output pixel (FSR's count), in rendered
        // pixels around the centre.
    // rust: let phases = (8.0 * self.upscale * self.upscale).ceil() as u32;
    // rust: let i = self.taa_frame % phases + 1;
    // rust: let offset = Vec2::new(halton(i, 2), halton(i, 3)) - 0.5;
    // rust: let jitter = offset * 2.0 / Vec2::new(size[0] as f32, size[1] as f32);
    // rust: let current = view_proj.as_dmat4();
    // rust: let (reproject, reset) = match self.taa_previous {
    // rust: Some((previous, previous_camera)) => (
    // rust: reprojection(previous, previous_camera, current, camera),
    // rust: 0.0,
    // rust: ),
    // rust: None => (DMat4::IDENTITY, 1.0),
}
    // rust: self.taa_previous = Some((current, camera));
    // rust: self.taa_this_frame = TaaUniform {
    // rust: reproject: reproject.as_mat4().to_cols_array_2d(),
    // rust: jitter: [jitter.x, jitter.y, reset, 0.0],
}
    // rust: Mat4::from_translation(jitter.extend(0.0))
}

    // This frame's jitter in rendered pixels, y down (FSR's `jitterOffset`); zero
    // without TAA.
jitter_pixels :: proc(self: ^Self) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: let Some(size) = self.size().filter(|_| self.taa_on) else {
    // rust: return [0.0; 2];
}
    // rust: let j = self.taa_this_frame.jitter;
    // rust: [j[0] * size[0] as f32 * 0.5, -j[1] * size[1] as f32 * 0.5]
}

    // The world's colour and depth targets this frame, or `None` to draw
    // it straight to the screen.
    // `always`: a target even at scale 1 without anti-aliasing (a shader pack reads it).
    // rust: pub fn prepare(
    // rust: &mut self,
    // rust: device: &wgpu::Device,
    // rust: window: [u32; 2],
    // rust: always: bool,
    // rust: ) -> Option<(wgpu::TextureView, wgpu::TextureView)> {
    // rust: if self.scale == 1.0 && !self.antialias && !self.taa_on && !always {
    // rust: self.target = None;
    // rust: return None;
}
        // The old target goes first: a slider drag would otherwise hold the old and the new
        // targets together, and the sum is what runs a small GPU out of memory.
    // rust: loop {
    // rust: let (size, output) = self.sizes(window);
    // rust: let history_size = self.taa_on.then_some(output);
    // rust: if self
    // rust: .target
    // rust: .as_ref()
    // rust: .is_some_and(|t| t.size == size && t.taa.as_ref().map(|h| h.size) == history_size)
    // rust: {
    // rust: break;
}
    // rust: self.target = None;
            // Errors raised are fatal, so catch an out-of-memory one and scale down. A texture
            // that failed is invalid, so its view fails validation too: catch that as well.
    // rust: let validation = device.push_error_scope(wgpu::ErrorFilter::Validation);
    // rust: let memory = device.push_error_scope(wgpu::ErrorFilter::OutOfMemory);
    // rust: let target = self.build_target(device, size, history_size);
    // rust: let error = pollster::block_on(memory.pop()).or(pollster::block_on(validation.pop()));
    // rust: if error.is_none() {
                // New textures: no history yet.
    // rust: self.taa_this_frame.jitter[2] = 1.0;
    // rust: self.target = Some(target);
    // rust: break;
}
    // rust: drop(target);
    // rust: if self.scale <= MIN_SCALE {
    // rust: log::warn!(
    // rust: "Horizon renderer: no video memory for the scaled world at {size:?} ({}); drawing at the window's size",
    // rust: error.map_or_else(String::new, |e| e.to_string())
    // rust: );
    // rust: self.scale = 1.0;
    // rust: self.target = None;
    // rust: return None;
}
    // rust: let reduced = (self.scale * 0.75).max(MIN_SCALE);
    // rust: log::warn!(
    // rust: "Horizon renderer: out of video memory for the scaled world at {size:?}; resolution scale {:.2} -> {reduced:.2} ({})",
    // rust: self.scale,
    // rust: error.map_or_else(String::new, |e| e.to_string())
    // rust: );
    // rust: self.scale = reduced;
    // rust: if self.scale == 1.0 && !self.antialias && !self.taa_on && !always {
    // rust: return None;
}
}
    // rust: self.target
    // rust: .as_ref()
    // rust: .map(|t| (t.color.clone(), t.depth.clone()))
}

    // The world's colour and depth targets at `size`, and TAA's history when `history_size`
    // is set.
    // rust: fn build_target(
    // rust: &self,
    // rust: device: &wgpu::Device,
    // rust: size: [u32; 2],
    // rust: history_size: Option<[u32; 2]>,
    // rust: ) -> WorldTarget {
    // rust: {
    // rust: let make_tex = |label, size: [u32; 2], format, usage| {
    // rust: device.create_texture(&wgpu::TextureDescriptor {
    // rust: label: Some(label),
    // rust: size: wgpu::Extent3d {
    // rust: width: size[0],
    // rust: height: size[1],
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
            // COPY_SRC: a native pack's material stage reads copies of them (`opaque_depth`,
            // `opaque_color`).
    // rust: let sampled = wgpu::TextureUsages::RENDER_ATTACHMENT
    // rust: | wgpu::TextureUsages::TEXTURE_BINDING
    // rust: | wgpu::TextureUsages::COPY_SRC;
    // rust: let color = make_tex("Scaled world", size, self.format, sampled)
    // rust: .create_view(&Default::default());
            // TEXTURE_BINDING: occlusion culling and TAA read it.
    // rust: let depth = make_tex(
    // rust: "Scaled world depth",
    // rust: size,
    // rust: wgpu::TextureFormat::Depth32Float,
    // rust: sampled | wgpu::TextureUsages::COPY_SRC,
    // rust: )
    // rust: .create_view(&Default::default());
    // rust: let group = self.bind(device, &color);
    // rust: let taa = history_size.and_then(|output| {
    // rust: let res = self.taa_resources.as_ref()?;
    // rust: let history = [0, 1].map(|_| {
    // rust: make_tex("TAA history", output, HISTORY_FORMAT, sampled)
    // rust: .create_view(&Default::default())
    // rust: });
    // rust: let resolve = [0, 1].map(|i| {
    // rust: device.create_bind_group(&wgpu::BindGroupDescriptor {
    // rust: label: Some("Horizon TAA"),
    // rust: layout: &res.layout,
    // rust: entries: &[
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 0,
    // rust: resource: wgpu::BindingResource::TextureView(&color),
    // rust: },
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 1,
    // rust: resource: wgpu::BindingResource::Sampler(&self.sampler),
    // rust: },
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 2,
    // rust: resource: wgpu::BindingResource::TextureView(&history[1 - i]),
    // rust: },
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 3,
    // rust: resource: wgpu::BindingResource::TextureView(&depth),
    // rust: },
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 4,
    // rust: resource: res.uniform.as_entire_binding(),
    // rust: },
    // rust: ],
    // rust: })
    // rust: });
    // rust: let show = [0, 1].map(|i| self.bind(device, &history[i]));
    // rust: Some(History {
    // rust: size: output,
    // rust: history,
    // rust: resolve,
    // rust: show,
    // rust: })
    // rust: });
    // rust: WorldTarget {
    // rust: size,
    // rust: color,
    // rust: depth,
    // rust: group,
    // rust: taa,
}
}
}

    // The size of the world's own target, when it has one.
size :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.target.as_ref().map(|t| t.size)
}

    // Bindings that copy (or anti-alias) `view` onto the screen in `finish_with`.
bind :: proc(self: ^Self, device: ^wgpu::Device, view: ^wgpu::TextureView) -> w {
    // Ported from Horizon
    return {}
}
    // rust: device.create_bind_group(&wgpu::BindGroupDescriptor {
    // rust: label: Some("Horizon post"),
    // rust: layout: &self.layout,
    // rust: entries: &[
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 0,
    // rust: resource: wgpu::BindingResource::TextureView(view),
    // rust: },
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 1,
    // rust: resource: wgpu::BindingResource::Sampler(&self.sampler),
    // rust: },
    // rust: ],
    // rust: })
}

    // Draw the scaled world onto `screen`, through TAA when this frame's `jitter` had it on.
    // rust: pub fn finish(
    // rust: &self,
    // rust: queue: &wgpu::Queue,
    // rust: encoder: &mut wgpu::CommandEncoder,
    // rust: screen: &wgpu::TextureView,
    // rust: mut timing: Option<&mut super::pack_timing::PassTiming>,
    // rust: ) {
    // rust: let Some(target) = &self.target else { return };
    // rust: let Some(taa) = target.taa.as_ref().filter(|_| self.taa_previous.is_some()) else {
    // rust: self.finish_with(encoder, screen, &target.group, timing.as_deref_mut());
    // rust: return;
}
    // rust: let Some(res) = &self.taa_resources else {
    // rust: self.finish_with(encoder, screen, &target.group, timing.as_deref_mut());
    // rust: return;
}
    // rust: let i = (self.taa_frame % 2) as usize;
    // rust: queue.write_buffer(&res.uniform, 0, bytemuck::bytes_of(&self.taa_this_frame));
    // rust: let attachments = [Some(wgpu::RenderPassColorAttachment {
    // rust: view: &taa.history[i],
    // rust: resolve_target: None,
    // rust: depth_slice: None,
    // rust: ops: wgpu::Operations {
    // rust: load: wgpu::LoadOp::Clear(wgpu::Color::BLACK),
    // rust: store: wgpu::StoreOp::Store,
    // rust: },
    // rust: })];
    // rust: let mut pass = encoder.begin_render_pass(&wgpu::RenderPassDescriptor {
    // rust: label: Some("Horizon TAA"),
    // rust: timestamp_writes: timing.as_deref_mut().and_then(|t| t.writes("TAA")),
    // rust: color_attachments: &attachments,
    // rust: ..Default::default()
    // rust: });
    // rust: pass.set_pipeline(&res.pipeline);
    // rust: pass.set_bind_group(0, &taa.resolve[i], &[]);
    // rust: pass.draw(0..3, 0..1);
    // rust: drop(pass);
    // rust: self.finish_with(encoder, screen, &taa.show[i], timing);
}

    // Draw what `group` binds (`bind`) onto `screen`.
    // rust: pub fn finish_with(
    // rust: &self,
    // rust: encoder: &mut wgpu::CommandEncoder,
    // rust: screen: &wgpu::TextureView,
    // rust: group: &wgpu::BindGroup,
    // rust: timing: Option<&mut super::pack_timing::PassTiming>,
    // rust: ) {
    // rust: let attachments = [Some(wgpu::RenderPassColorAttachment {
    // rust: view: screen,
    // rust: resolve_target: None,
    // rust: depth_slice: None,
    // rust: ops: wgpu::Operations {
    // rust: load: wgpu::LoadOp::Clear(wgpu::Color::BLACK),
    // rust: store: wgpu::StoreOp::Store,
    // rust: },
    // rust: })];
    // rust: let mut pass = encoder.begin_render_pass(&wgpu::RenderPassDescriptor {
    // rust: label: Some("Horizon post"),
    // rust: timestamp_writes: timing.and_then(|t| t.writes("Post")),
    // rust: color_attachments: &attachments,
    // rust: ..Default::default()
    // rust: });
    // rust: pass.set_pipeline(if self.antialias {
    // rust: &self.fxaa
    // rust: } else {
    // rust: &self.copy
    // rust: });
    // rust: pass.set_bind_group(0, group, &[]);
    // rust: pass.draw(0..3, 0..1);
}
}

// This frame's clip space to the previous frame's, for camera-relative projections:
// a point `camera - previous_camera` further from the previous camera than from this one.
    // rust: pub(super) fn reprojection(
    // rust: previous: DMat4,
    // rust: previous_camera: DVec3,
    // rust: current: DMat4,
    // rust: camera: DVec3,
    // rust: ) -> DMat4 {
    // rust: previous * DMat4::from_translation(camera - previous_camera) * current.inverse()
}

// The radical inverse of `i` in `base`: a low-discrepancy sequence in 0..1.
halton :: proc(mut i: u32, base: u32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let (mut f, mut r) = (1.0, 0.0);
    // rust: while i > 0 {
    // rust: f /= base as f32;
    // rust: r += f * (i % base) as f32;
    // rust: i /= base;
}
    // rust: r
}

    // rust: mod tests {
//     use super::*;

reprojection_finds_where_a_block_was_last_frame :: proc() {
}
    // rust: let projection = DMat4::perspective_rh(1.2, 16.0 / 9.0, 1024.0, 0.05);
    // rust: let previous = projection * DMat4::from_rotation_y(0.3);
    // rust: let current = projection * DMat4::from_rotation_y(0.35);
    // rust: let (previous_camera, camera) = (DVec3::new(10.0, 64.0, 5.0), DVec3::new(10.5, 64.2, 4.0));
    // rust: let block = DVec3::new(14.0, 66.0, -8.0);
    // rust: let clip = |m: DMat4, eye: DVec3| m * (block - eye).extend(1.0);
    // rust: let now = clip(current, camera);
    // rust: let then = reprojection(previous, previous_camera, current, camera) * (now / now.w);
    // rust: let expected = clip(previous, previous_camera);
    // rust: assert!((then.truncate() / then.w - expected.truncate() / expected.w).length() < 1e-9);
}

jitter_stays_inside_the_pixel :: proc() {
}
    // rust: for i in 1..=8 {
    // rust: let (x, y) = (halton(i, 2), halton(i, 3));
    // rust: assert!((0.0..1.0).contains(&x) && (0.0..1.0).contains(&y));
}
    // rust: assert_eq!(
    // rust: [halton(1, 2), halton(2, 2), halton(3, 2)],
    // rust: [0.5, 0.25, 0.75]
    // rust: );
}

test_device :: proc() -> O {
    // Ported from Horizon
    return {}
}
    // rust: let instance = crate::gfx::test_gpu::instance();
    // rust: let adapter = pollster::block_on(instance.request_adapter(&Default::default())).ok()?;
    // rust: pollster::block_on(adapter.request_device(&Default::default())).ok()
}

world_post_pipelines_compile_or_fall_back :: proc() {
}
    // rust: let Some((device, _)) = test_device() else {
    // rust: return;
}
    // rust: let post = Post::new(&device, wgpu::TextureFormat::Rgba8Unorm);
        // Copy and FXAA pipelines always compile; TAA compiles if supported by backend.
    // rust: let _ = post.supports_taa();
}
}
