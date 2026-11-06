//! Transpiled from Horizon Rust crate
package horizon_client_render_menu_blur

import "core:fmt"
import "core:mem"
import "core:math"

// Vanilla's menu background blur (`GameRenderer.processBlurEffect`, the
// `minecraft:blur` post chain): three rounds of a horizontal then a vertical
// `post/box_blur` pass over the frame drawn so far, `menuBackgroundBlurriness`
// framebuffer pixels wide, before the screen is drawn over it. Works in the
// frame's own (gamma) values, as vanilla's main target does, and needs a
// swapchain that can be copied from.
//
// On a software adapter (WARP, llvmpipe) the rounds run at half the frame's
// width and height with half the radius: the same blur, a quarter of the
// pixels. At full size they took 250 ms of a CPU per frame at 1440x900, and
// every blurred menu ran at 3 FPS (#5185).

// `blur.json`: the passes' directions, ping-ponging between the copied
// frame and a swap texture; the last one writes the frame.
    // rust: const PASSES: [[f32; 2]; 6] = [
    // rust: [1.0, 0.0],
    // rust: [0.0, 1.0],
    // rust: [1.0, 0.0],
    // rust: [0.0, 1.0],
    // rust: [1.0, 0.0],
    // rust: [0.0, 1.0],
    // rust: ];

Uniform :: struct {
    size_dir: [f32,
    radius: [f32,
}

MenuBlur :: struct {
    layout: wgpu::BindGroupLayout,
    pipeline: wgpu::RenderPipeline,
    sampler: wgpu::Sampler,
    // One per pass, then the half-size copy's.
    uniforms: [dynamic]wgpu::Buffer,
    // The copied frame (`minecraft:main`) and `swap`; at half size, then the
    // frame copied at full size.
    targets: Vec<(wgpu::Texture,
    size: [u32,
    format: wgpu::TextureFormat,
    // Blur at half size (`new`'s `software`).
    half: bool,
}
    // rust: impl MenuBlur {
    // `format` is the swapchain's; the blur works in its non-sRGB view. `software`:
    // the adapter renders on the CPU, so the blur runs at half size.
new :: proc(device: ^wgpu::Device, format: wgpu::TextureFormat, software: bool) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let format = format.remove_srgb_suffix();
    // rust: let shader = device.create_shader_module(wgpu::ShaderModuleDescriptor {
    // rust: label: Some("Menu blur"),
    // rust: source: wgpu::ShaderSource::Wgsl(include_str!("menu_blur.wgsl").into()),
    // rust: });
    // rust: let layout = device.create_bind_group_layout(&wgpu::BindGroupLayoutDescriptor {
    // rust: label: Some("Menu blur bindings"),
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
    // rust: wgpu::BindGroupLayoutEntry {
    // rust: binding: 2,
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
    // rust: let pipeline_layout = device.create_pipeline_layout(&wgpu::PipelineLayoutDescriptor {
    // rust: label: Some("Menu blur"),
    // rust: bind_group_layouts: &[Some(&layout)],
    // rust: ..Default::default()
    // rust: });
    // rust: let pipeline = device.create_render_pipeline(&wgpu::RenderPipelineDescriptor {
    // rust: label: Some("Menu blur pass"),
    // rust: layout: Some(&pipeline_layout),
    // rust: vertex: wgpu::VertexState {
    // rust: module: &shader,
    // rust: entry_point: Some("vs_main"),
    // rust: buffers: &[],
    // rust: compilation_options: Default::default(),
    // rust: },
    // rust: fragment: Some(wgpu::FragmentState {
    // rust: module: &shader,
    // rust: entry_point: Some("fs_main"),
    // rust: targets: &[Some(wgpu::ColorTargetState {
    // rust: format,
    // rust: blend: None,
    // rust: write_mask: wgpu::ColorWrites::ALL,
    // rust: })],
    // rust: compilation_options: Default::default(),
    // rust: }),
    // rust: primitive: Default::default(),
    // rust: depth_stencil: None,
    // rust: multisample: Default::default(),
    // rust: multiview_mask: None,
    // rust: cache: None,
    // rust: });
        // The post chain's "bilinear": true inputs, clamped like render targets.
    // rust: let sampler = device.create_sampler(&wgpu::SamplerDescriptor {
    // rust: label: Some("Menu blur"),
    // rust: mag_filter: wgpu::FilterMode::Linear,
    // rust: min_filter: wgpu::FilterMode::Linear,
    // rust: address_mode_u: wgpu::AddressMode::ClampToEdge,
    // rust: address_mode_v: wgpu::AddressMode::ClampToEdge,
    // rust: ..Default::default()
    // rust: });
    // rust: let uniforms = (0..=PASSES.len())
    // rust: .map(|_| {
    // rust: device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: Some("Menu blur pass"),
    // rust: size: std::mem::size_of::<Uniform>() as u64,
    // rust: usage: wgpu::BufferUsages::UNIFORM | wgpu::BufferUsages::COPY_DST,
    // rust: mapped_at_creation: false,
    // rust: })
    // rust: })
    // rust: .collect();
    // rust: Self {
    // rust: layout,
    // rust: pipeline,
    // rust: sampler,
    // rust: uniforms,
    // rust: targets: Vec::new(),
    // rust: size: [0, 0],
    // rust: format,
    // rust: half: software,
}
}
    // The size the blur's rounds run at for a frame of `size`.
work_size :: proc(self: ^Self, size: [u32; 2]) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: if self.half {
    // rust: size.map(|s| s.div_ceil(2))
    // rust: } else {
    // rust: size
}
}
ensure :: proc(self: ^Self, device: ^wgpu::Device, size: [u32; 2]) {
}
    // rust: if self.size == size && !self.targets.is_empty() {
    // rust: return;
}
    // rust: self.size = size;
    // rust: let work = self.work_size(size);
    // rust: let sizes = if self.half {
    // rust: vec![work, work, size]
    // rust: } else {
    // rust: vec![work, work]
}
    // rust: self.targets = sizes
    // rust: .into_iter()
    // rust: .map(|size| {
    // rust: let texture = device.create_texture(&wgpu::TextureDescriptor {
    // rust: label: Some("Menu blur target"),
    // rust: size: wgpu::Extent3d {
    // rust: width: size[0],
    // rust: height: size[1],
    // rust: depth_or_array_layers: 1,
    // rust: },
    // rust: mip_level_count: 1,
    // rust: sample_count: 1,
    // rust: dimension: wgpu::TextureDimension::D2,
    // rust: format: self.format,
    // rust: usage: wgpu::TextureUsages::TEXTURE_BINDING
    // rust: | wgpu::TextureUsages::RENDER_ATTACHMENT
    // rust: | wgpu::TextureUsages::COPY_DST,
    // rust: view_formats: &[],
    // rust: });
    // rust: let view = texture.create_view(&Default::default());
    // rust: (texture, view)
    // rust: })
    // rust: .collect();
}
    // Give the targets' video memory back: no frame blurs until the next
    // screen that does, which makes them again.
release :: proc(self: ^Self) {
}
    // rust: self.targets.clear();
}
    // Blur `frame` (the swapchain texture) in place through `target`, its
    // non-sRGB view, by `radius` pixels (`menuBackgroundBlurriness`).
    // rust: pub fn apply(
    // rust: &mut self,
    // rust: device: &wgpu::Device,
    // rust: queue: &wgpu::Queue,
    // rust: encoder: &mut wgpu::CommandEncoder,
    // rust: frame: &wgpu::Texture,
    // rust: target: &wgpu::TextureView,
    // rust: size: [u32; 2],
    // rust: radius: f32,
    // rust: mut timing: Option<&mut crate::gfx::pack_timing::PassTiming>,
    // rust: ) {
    // rust: self.ensure(device, size);
    // rust: let work = self.work_size(size);
    // rust: let copy = if self.half { 2 } else { 0 };
    // rust: encoder.copy_texture_to_texture(
    // rust: frame.as_image_copy(),
    // rust: self.targets[copy].0.as_image_copy(),
    // rust: wgpu::Extent3d {
    // rust: width: size[0],
    // rust: height: size[1],
    // rust: depth_or_array_layers: 1,
    // rust: },
    // rust: );
    // rust: let radius = if self.half { radius / 2.0 } else { radius };
    // rust: if self.half {
            // A radius of 0 samples each half-size pixel's 2x2 block at its shared
            // corner: their mean.
    // rust: let data = Uniform {
    // rust: size_dir: [size[0] as f32, size[1] as f32, 0.0, 0.0],
    // rust: radius: [0.0; 4],
}
    // rust: let (source, output) = (&self.targets[2].1, &self.targets[0].1);
    // rust: self.pass(
    // rust: device,
    // rust: queue,
    // rust: encoder,
    // rust: PASSES.len(),
    // rust: data,
    // rust: source,
    // rust: output,
    // rust: None,
    // rust: );
}
    // rust: for (i, dir) in PASSES.iter().enumerate() {
    // rust: let data = Uniform {
    // rust: size_dir: [work[0] as f32, work[1] as f32, dir[0], dir[1]],
    // rust: radius: [radius, 0.0, 0.0, 0.0],
}
    // rust: let source = &self.targets[i % 2].1;
            // The last pass writes the frame; from half size it samples up as it blurs.
    // rust: let output = if i + 1 == PASSES.len() {
    // rust: target
    // rust: } else {
    // rust: &self.targets[(i + 1) % 2].1
}
    // rust: self.pass(
    // rust: device,
    // rust: queue,
    // rust: encoder,
    // rust: i,
    // rust: data,
    // rust: source,
    // rust: output,
    // rust: timing.as_deref_mut(),
    // rust: );
}
}
    // One `box_blur` pass from `source` into `output` with uniform buffer `slot`.
    // rust: fn pass(
    // rust: &self,
    // rust: device: &wgpu::Device,
    // rust: queue: &wgpu::Queue,
    // rust: encoder: &mut wgpu::CommandEncoder,
    // rust: slot: usize,
    // rust: data: Uniform,
    // rust: source: &wgpu::TextureView,
    // rust: output: &wgpu::TextureView,
    // rust: timing: Option<&mut crate::gfx::pack_timing::PassTiming>,
    // rust: ) {
    // rust: queue.write_buffer(&self.uniforms[slot], 0, bytemuck::bytes_of(&data));
    // rust: let group = device.create_bind_group(&wgpu::BindGroupDescriptor {
    // rust: label: Some("Menu blur pass"),
    // rust: layout: &self.layout,
    // rust: entries: &[
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 0,
    // rust: resource: wgpu::BindingResource::TextureView(source),
    // rust: },
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 1,
    // rust: resource: wgpu::BindingResource::Sampler(&self.sampler),
    // rust: },
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 2,
    // rust: resource: self.uniforms[slot].as_entire_binding(),
    // rust: },
    // rust: ],
    // rust: });
    // rust: let attachments = [Some(wgpu::RenderPassColorAttachment {
    // rust: view: output,
    // rust: resolve_target: None,
    // rust: depth_slice: None,
    // rust: ops: wgpu::Operations {
    // rust: load: wgpu::LoadOp::Clear(wgpu::Color::BLACK),
    // rust: store: wgpu::StoreOp::Store,
    // rust: },
    // rust: })];
    // rust: let mut pass = encoder.begin_render_pass(&wgpu::RenderPassDescriptor {
    // rust: label: Some("Menu blur pass"),
    // rust: timestamp_writes: timing.and_then(|t| t.writes("Menu blur")),
    // rust: color_attachments: &attachments,
    // rust: ..Default::default()
    // rust: });
    // rust: pass.set_pipeline(&self.pipeline);
    // rust: pass.set_bind_group(0, &group, &[]);
    // rust: pass.draw(0..3, 0..1);
}
}

    // rust: mod tests {
//     use super::*;

    // A frame of hard stripes, blurred, read back.
    // rust: fn blurred(
    // rust: device: &wgpu::Device,
    // rust: queue: &wgpu::Queue,
    // rust: blur: &mut MenuBlur,
    // rust: size: [u32; 2],
    // rust: ) -> Vec<u8> {
    // rust: let format = wgpu::TextureFormat::Rgba8Unorm;
    // rust: let extent = wgpu::Extent3d {
    // rust: width: size[0],
    // rust: height: size[1],
    // rust: depth_or_array_layers: 1,
}
    // rust: let stripes: Vec<u8> = (0..size[0] * size[1])
    // rust: .flat_map(|i| if i % 4 < 2 { [255; 4] } else { [0, 0, 0, 255] })
    // rust: .collect();
    // rust: let frame = wgpu::util::DeviceExt::create_texture_with_data(
    // rust: device,
    // rust: queue,
    // rust: &wgpu::TextureDescriptor {
    // rust: label: None,
    // rust: size: extent,
    // rust: mip_level_count: 1,
    // rust: sample_count: 1,
    // rust: dimension: wgpu::TextureDimension::D2,
    // rust: format,
    // rust: usage: wgpu::TextureUsages::RENDER_ATTACHMENT
    // rust: | wgpu::TextureUsages::COPY_SRC
    // rust: | wgpu::TextureUsages::COPY_DST,
    // rust: view_formats: &[],
    // rust: },
    // rust: wgpu::util::TextureDataOrder::LayerMajor,
    // rust: &stripes,
    // rust: );
    // rust: let out = device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: None,
    // rust: size: u64::from(size[0] * size[1] * 4),
    // rust: usage: wgpu::BufferUsages::COPY_DST | wgpu::BufferUsages::MAP_READ,
    // rust: mapped_at_creation: false,
    // rust: });
    // rust: let mut encoder = device.create_command_encoder(&Default::default());
    // rust: let view = frame.create_view(&Default::default());
    // rust: blur.apply(device, queue, &mut encoder, &frame, &view, size, 2.0, None);
    // rust: encoder.copy_texture_to_buffer(
    // rust: frame.as_image_copy(),
    // rust: wgpu::TexelCopyBufferInfo {
    // rust: buffer: &out,
    // rust: layout: wgpu::TexelCopyBufferLayout {
    // rust: offset: 0,
    // rust: bytes_per_row: Some(size[0] * 4),
    // rust: rows_per_image: None,
    // rust: },
    // rust: },
    // rust: extent,
    // rust: );
    // rust: queue.submit([encoder.finish()]);
    // rust: out.slice(..).map_async(wgpu::MapMode::Read, |_| ());
    // rust: device.poll(wgpu::PollType::wait_indefinitely()).unwrap();
    // rust: out.slice(..).get_mapped_range().unwrap().to_vec()
}

    // Released between two screens, the blur makes its targets again and
    // blurs the same.
blurs_the_same_after_its_targets_were_released :: proc() {
}
    // rust: let instance = wgpu::Instance::new(wgpu::InstanceDescriptor::new_without_display_handle());
    // rust: let Ok(adapter) = pollster::block_on(instance.request_adapter(&Default::default())) else {
    // rust: return;
}
    // rust: let Ok((device, queue)) = pollster::block_on(adapter.request_device(&Default::default()))
    // rust: else {
    // rust: return;
}
    // rust: let mut blur = MenuBlur::new(&device, wgpu::TextureFormat::Rgba8UnormSrgb, false);
    // rust: let size = [64, 8];
    // rust: let first = blurred(&device, &queue, &mut blur, size);
        // The stripes are blurred into greys.
    // rust: assert!(first.chunks(4).any(|p| p[0] != 0 && p[0] != 255));
    // rust: blur.release();
    // rust: assert_eq!(blurred(&device, &queue, &mut blur, size), first);
}

    // On a software adapter the blur runs at half size and still blurs the
    // frame much as at full size: stripes two pixels wide turn to an even grey.
the_half_size_blur_blurs_like_the_full_size_one :: proc() {
}
    // rust: let instance = wgpu::Instance::new(wgpu::InstanceDescriptor::new_without_display_handle());
    // rust: let Ok(adapter) = pollster::block_on(instance.request_adapter(&Default::default())) else {
    // rust: return;
}
    // rust: let Ok((device, queue)) = pollster::block_on(adapter.request_device(&Default::default()))
    // rust: else {
    // rust: return;
}
    // rust: let format = wgpu::TextureFormat::Rgba8UnormSrgb;
    // rust: let size = [64, 8];
    // rust: let full = blurred(
    // rust: &device,
    // rust: &queue,
    // rust: &mut MenuBlur::new(&device, format, false),
    // rust: size,
    // rust: );
    // rust: let half = blurred(
    // rust: &device,
    // rust: &queue,
    // rust: &mut MenuBlur::new(&device, format, true),
    // rust: size,
    // rust: );
        // Away from the edges, both are within a few levels of the stripes' mean grey.
    // rust: for row in 0..size[1] as usize {
    // rust: for x in 8..56 {
    // rust: let at = (row * size[0] as usize + x) * 4;
    // rust: for (name, frame) in [("full", &full), ("half", &half)] {
    // rust: let v = frame[at];
    // rust: assert!((120..=136).contains(&v), "{name} size: {v} at ({x}, {row})");
}
}
}
}

box_blur_shader_validates :: proc() {
}
    // rust: let module = naga::front::wgsl::parse_str(include_str!("menu_blur.wgsl")).unwrap();
    // rust: naga::valid::Validator::new(
    // rust: naga::valid::ValidationFlags::all(),
    // rust: naga::valid::Capabilities::all(),
    // rust: )
    // rust: .validate(&module)
    // rust: .unwrap();
}
}
