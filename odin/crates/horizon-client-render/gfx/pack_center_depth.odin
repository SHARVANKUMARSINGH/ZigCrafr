//! Transpiled from Horizon Rust crate
package horizon_client_render_pack_center_depth

import "core:fmt"
import "core:mem"
import "core:math"

// `centerDepthSmooth`'s input: `depthtex0` at the centre of the screen. A depth texture can
// only be copied whole, so each frame a one-pixel pass loads that texel into a 1x1 `R32Float`
// target, copied to one of a few small buffers and read back frames later without waiting for
// the GPU (as `timing.rs` reads its timestamps); `FrameUniforms` smooths the latest value.

// use std::sync::Arc;
// use std::sync::atomic::{AtomicU8, Ordering};

SLOTS :: 3
FREE :: 0
// Copied this frame: mapped once the frame is submitted.
COPIED :: 1
PENDING :: 2
MAPPED :: 3
// One row of a texture copy, the alignment wgpu asks of `bytes_per_row`.
ROW :: wgpu::COPY_BYTES_PER_ROW_ALIGNMENT

    // rust: const SHADER: &str = "
// A depth view bound as unfilterable float: naga's GLSL backend cannot
// `textureLoad` a depth texture, and the texel is the same value.
    // rust: @group(0) @binding(0) var depth: texture_2d<f32>;
    // rust: @vertex fn vs(@builtin(vertex_index) i: u32) -> @builtin(position) vec4<f32> {
    // rust: let p = vec2<f32>(f32((i << 1u) & 2u), f32(i & 2u));
    // rust: return vec4<f32>(p * 2.0 - 1.0, 0.0, 1.0);
}
    // rust: @fragment fn fs() -> @location(0) vec4<f32> {
    // rust: let centre = vec2<i32>(textureDimensions(depth) / 2u);
    // rust: return vec4<f32>(textureLoad(depth, centre, 0).r, 0.0, 0.0, 1.0);
}
    // rust: ";

Slot :: struct {
    buffer: wgpu::Buffer,
    state: ^AtomicU8,
}

CenterDepth :: struct {
    slots: [dynamic]Slot,
    pipeline: wgpu::RenderPipeline,
    layout: wgpu::BindGroupLayout,
    // The 1x1 target the centre texel is loaded into.
    texel: wgpu::Texture,
    texel_view: wgpu::TextureView,
    // The bind group of the depth texture it reads, made again when that texture changes.
    group: Option<(wgpu::Texture,
    // The depth last read back: GL window depth, 0..1.
    latest: Maybe(f32),
}

    // rust: impl CenterDepth {
new :: proc(device: ^wgpu::Device) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let slots = (0..SLOTS)
    // rust: .map(|_| Slot {
    // rust: buffer: device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: Some("Shader pack centre depth"),
    // rust: size: u64::from(ROW),
    // rust: usage: wgpu::BufferUsages::COPY_DST | wgpu::BufferUsages::MAP_READ,
    // rust: mapped_at_creation: false,
    // rust: }),
    // rust: state: Arc::new(AtomicU8::new(FREE)),
    // rust: })
    // rust: .collect();
    // rust: let layout = device.create_bind_group_layout(&wgpu::BindGroupLayoutDescriptor {
    // rust: label: Some("Shader pack centre depth"),
    // rust: entries: &[wgpu::BindGroupLayoutEntry {
    // rust: binding: 0,
    // rust: visibility: wgpu::ShaderStages::FRAGMENT,
    // rust: ty: wgpu::BindingType::Texture {
    // rust: sample_type: wgpu::TextureSampleType::Float { filterable: false },
    // rust: view_dimension: wgpu::TextureViewDimension::D2,
    // rust: multisampled: false,
    // rust: },
    // rust: count: None,
    // rust: }],
    // rust: });
    // rust: let module = device.create_shader_module(wgpu::ShaderModuleDescriptor {
    // rust: label: Some("Shader pack centre depth"),
    // rust: source: wgpu::ShaderSource::Wgsl(SHADER.into()),
    // rust: });
    // rust: let pipeline_layout = device.create_pipeline_layout(&wgpu::PipelineLayoutDescriptor {
    // rust: label: Some("Shader pack centre depth"),
    // rust: bind_group_layouts: &[Some(&layout)],
    // rust: immediate_size: 0,
    // rust: });
    // rust: let format = wgpu::TextureFormat::R32Float;
    // rust: let pipeline = device.create_render_pipeline(&wgpu::RenderPipelineDescriptor {
    // rust: label: Some("Shader pack centre depth"),
    // rust: layout: Some(&pipeline_layout),
    // rust: vertex: wgpu::VertexState {
    // rust: module: &module,
    // rust: entry_point: Some("vs"),
    // rust: compilation_options: Default::default(),
    // rust: buffers: &[],
    // rust: },
    // rust: primitive: Default::default(),
    // rust: depth_stencil: None,
    // rust: multisample: Default::default(),
    // rust: fragment: Some(wgpu::FragmentState {
    // rust: module: &module,
    // rust: entry_point: Some("fs"),
    // rust: compilation_options: Default::default(),
    // rust: targets: &[Some(format.into())],
    // rust: }),
    // rust: multiview_mask: None,
    // rust: cache: None,
    // rust: });
    // rust: let texel = device.create_texture(&wgpu::TextureDescriptor {
    // rust: label: Some("Shader pack centre depth"),
    // rust: size: wgpu::Extent3d {
    // rust: width: 1,
    // rust: height: 1,
    // rust: depth_or_array_layers: 1,
    // rust: },
    // rust: mip_level_count: 1,
    // rust: sample_count: 1,
    // rust: dimension: wgpu::TextureDimension::D2,
    // rust: format,
    // rust: usage: wgpu::TextureUsages::RENDER_ATTACHMENT | wgpu::TextureUsages::COPY_SRC,
    // rust: view_formats: &[],
    // rust: });
    // rust: let texel_view = texel.create_view(&Default::default());
    // rust: Self {
    // rust: slots,
    // rust: pipeline,
    // rust: layout,
    // rust: texel,
    // rust: texel_view,
    // rust: group: None,
    // rust: latest: None,
}
}

    // Loads the centre texel of `depth` (a `Depth32Float` texture that can be bound) and
    // copies it into a free slot; with none free (the GPU is behind), this frame is skipped.
    // rust: pub fn copy(
    // rust: &mut self,
    // rust: device: &wgpu::Device,
    // rust: encoder: &mut wgpu::CommandEncoder,
    // rust: depth: &wgpu::Texture,
    // rust: ) {
    // rust: let Some(slot) = self
    // rust: .slots
    // rust: .iter()
    // rust: .find(|s| s.state.load(Ordering::Acquire) == FREE)
    // rust: else {
    // rust: return;
}
    // rust: if self.group.as_ref().is_none_or(|(t, _)| t != depth) {
    // rust: let view = depth.create_view(&Default::default());
    // rust: let group = device.create_bind_group(&wgpu::BindGroupDescriptor {
    // rust: label: Some("Shader pack centre depth"),
    // rust: layout: &self.layout,
    // rust: entries: &[wgpu::BindGroupEntry {
    // rust: binding: 0,
    // rust: resource: wgpu::BindingResource::TextureView(&view),
    // rust: }],
    // rust: });
    // rust: self.group = Some((depth.clone(), group));
}
    // rust: let Some((_, group)) = &self.group else {
    // rust: return;
}
    // rust: {
    // rust: let mut pass = encoder.begin_render_pass(&wgpu::RenderPassDescriptor {
    // rust: label: Some("Shader pack centre depth"),
    // rust: color_attachments: &[Some(wgpu::RenderPassColorAttachment {
    // rust: view: &self.texel_view,
    // rust: depth_slice: None,
    // rust: resolve_target: None,
    // rust: ops: wgpu::Operations {
    // rust: load: wgpu::LoadOp::Clear(wgpu::Color::WHITE),
    // rust: store: wgpu::StoreOp::Store,
    // rust: },
    // rust: })],
    // rust: ..Default::default()
    // rust: });
    // rust: pass.set_pipeline(&self.pipeline);
    // rust: pass.set_bind_group(0, group, &[]);
    // rust: pass.draw(0..3, 0..1);
}
    // rust: encoder.copy_texture_to_buffer(
    // rust: self.texel.as_image_copy(),
    // rust: wgpu::TexelCopyBufferInfo {
    // rust: buffer: &slot.buffer,
    // rust: layout: wgpu::TexelCopyBufferLayout {
    // rust: offset: 0,
    // rust: bytes_per_row: Some(ROW),
    // rust: rows_per_image: Some(1),
    // rust: },
    // rust: },
    // rust: self.texel.size(),
    // rust: );
    // rust: slot.state.store(COPIED, Ordering::Release);
}

    // The readback of what the frame copied, to start by calling it right after the frame's
    // submission: on the submit thread when the frame goes there, as culling's readback.
submitted :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let copied: Vec<_> = self
    // rust: .slots
    // rust: .iter()
    // rust: .filter(|s| s.state.load(Ordering::Acquire) == COPIED)
    // rust: .map(|s| {
    // rust: s.state.store(PENDING, Ordering::Release);
    // rust: (s.buffer.clone(), s.state.clone())
    // rust: })
    // rust: .collect();
    // rust: (!copied.is_empty()).then_some(move || {
    // rust: for (buffer, state) in copied {
    // rust: buffer
    // rust: .slice(..)
    // rust: .map_async(wgpu::MapMode::Read, move |result| {
    // rust: let next = if result.is_ok() { MAPPED } else { FREE };
    // rust: state.store(next, Ordering::Release);
    // rust: });
}
    // rust: })
}

    // The newest depth read back so far, `None` before the first arrives.
collect :: proc(self: ^Self, device: ^wgpu::Device) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let _ = device.poll(wgpu::PollType::Poll);
    // rust: for slot in &self.slots {
    // rust: if slot.state.load(Ordering::Acquire) != MAPPED {
    // rust: continue;
}
    // rust: let depth = slot
    // rust: .buffer
    // rust: .slice(..4)
    // rust: .get_mapped_range()
    // rust: .ok()
    // rust: .map(|bytes| bytemuck::pod_read_unaligned::<f32>(&bytes[..4]));
    // rust: slot.buffer.unmap();
    // rust: slot.state.store(FREE, Ordering::Release);
    // rust: if let Some(depth) = depth.filter(|d| d.is_finite()) {
    // rust: self.latest = Some(depth.clamp(0.0, 1.0));
}
}
    // rust: self.latest
}
}

    // rust: mod tests {
//     use super::*;

test_device :: proc() -> O {
    // Ported from Horizon
    return {}
}
    // rust: let instance =
    // rust: wgpu::Instance::new(wgpu::InstanceDescriptor::new_without_display_handle().with_env());
    // rust: let adapter = pollster::block_on(instance.request_adapter(&Default::default())).ok()?;
    // rust: pollster::block_on(adapter.request_device(&Default::default())).ok()
}

clear :: proc(encoder: ^wgpu::CommandEncoder, view: ^wgpu::TextureView, depth: f32) {
}
    // rust: encoder.begin_render_pass(&wgpu::RenderPassDescriptor {
    // rust: depth_stencil_attachment: Some(wgpu::RenderPassDepthStencilAttachment {
    // rust: view,
    // rust: depth_ops: Some(wgpu::Operations {
    // rust: load: wgpu::LoadOp::Clear(depth),
    // rust: store: wgpu::StoreOp::Store,
    // rust: }),
    // rust: stencil_ops: None,
    // rust: }),
    // rust: ..Default::default()
    // rust: });
}

    // Frames that go to the submit thread start their readback there: the centre depth
    // follows the frames instead of keeping the first ones' depth.
the_centre_depth_follows_frames_submitted_on_the_submit_thread :: proc() {
}
    // rust: let Some((device, queue)) = test_device() else {
    // rust: return;
}
    // rust: let queue = super::super::submit::Queue::new(queue, true);
    // rust: if !queue.threaded() {
    // rust: return;
}
    // rust: let depth = device.create_texture(&wgpu::TextureDescriptor {
    // rust: label: None,
    // rust: size: wgpu::Extent3d {
    // rust: width: 4,
    // rust: height: 4,
    // rust: depth_or_array_layers: 1,
    // rust: },
    // rust: mip_level_count: 1,
    // rust: sample_count: 1,
    // rust: dimension: wgpu::TextureDimension::D2,
    // rust: format: wgpu::TextureFormat::Depth32Float,
    // rust: usage: wgpu::TextureUsages::RENDER_ATTACHMENT | wgpu::TextureUsages::TEXTURE_BINDING,
    // rust: view_formats: &[],
    // rust: });
    // rust: let view = depth.create_view(&Default::default());
    // rust: let mut center = CenterDepth::new(&device);
    // rust: let mut latest = None;
    // rust: for frame in 1..=4 * SLOTS {
    // rust: let value = frame as f32 / 16.0;
    // rust: let mut encoder = device.create_command_encoder(&Default::default());
    // rust: clear(&mut encoder, &view, value);
    // rust: center.copy(&device, &mut encoder, &depth);
    // rust: let after = center
    // rust: .submitted()
    // rust: .map(|f| Box::new(f) as super::super::submit::AfterSubmit);
    // rust: let job = super::super::submit::Job {
    // rust: encoder,
    // rust: surface: None,
    // rust: after,
}
    // rust: assert!(queue.submit_later(job).is_ok());
    // rust: queue.wait();
    // rust: let _ = device.poll(wgpu::PollType::wait_indefinitely());
    // rust: latest = center.collect(&device);
    // rust: assert_eq!(latest, Some(value), "frame {frame}");
}
    // rust: assert_eq!(latest, Some(0.75));
}

    // A depth texture cleared to a known depth comes back as that depth, a frame or more
    // later, without the frame waiting for it.
the_centre_depth_comes_back :: proc() {
}
    // rust: let Some((device, queue)) = test_device() else {
    // rust: return;
}
    // rust: let depth = device.create_texture(&wgpu::TextureDescriptor {
    // rust: label: None,
    // rust: size: wgpu::Extent3d {
    // rust: width: 9,
    // rust: height: 7,
    // rust: depth_or_array_layers: 1,
    // rust: },
    // rust: mip_level_count: 1,
    // rust: sample_count: 1,
    // rust: dimension: wgpu::TextureDimension::D2,
    // rust: format: wgpu::TextureFormat::Depth32Float,
    // rust: usage: wgpu::TextureUsages::RENDER_ATTACHMENT | wgpu::TextureUsages::TEXTURE_BINDING,
    // rust: view_formats: &[],
    // rust: });
    // rust: let view = depth.create_view(&Default::default());
    // rust: let mut center = CenterDepth::new(&device);
    // rust: assert_eq!(center.collect(&device), None);
    // rust: let mut encoder = device.create_command_encoder(&Default::default());
    // rust: encoder.begin_render_pass(&wgpu::RenderPassDescriptor {
    // rust: depth_stencil_attachment: Some(wgpu::RenderPassDepthStencilAttachment {
    // rust: view: &view,
    // rust: depth_ops: Some(wgpu::Operations {
    // rust: load: wgpu::LoadOp::Clear(0.375),
    // rust: store: wgpu::StoreOp::Store,
    // rust: }),
    // rust: stencil_ops: None,
    // rust: }),
    // rust: ..Default::default()
    // rust: });
    // rust: center.copy(&device, &mut encoder, &depth);
    // rust: queue.submit([encoder.finish()]);
    // rust: center.submitted().expect("a copy to read back")();
    // rust: let _ = device.poll(wgpu::PollType::wait_indefinitely());
    // rust: assert_eq!(center.collect(&device), Some(0.375));
        // Its slot is free again: every slot can be used once more.
    // rust: for _ in 0..SLOTS {
    // rust: let mut encoder = device.create_command_encoder(&Default::default());
    // rust: center.copy(&device, &mut encoder, &depth);
    // rust: queue.submit([encoder.finish()]);
    // rust: center.submitted().expect("a free slot")();
}
    // rust: let _ = device.poll(wgpu::PollType::wait_indefinitely());
    // rust: assert_eq!(center.collect(&device), Some(0.375));
}
}
