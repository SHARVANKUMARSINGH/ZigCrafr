//! Transpiled from Horizon Rust crate
//! Module: horizon-client-render_interpolation
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! FSR 3.1's frame interpolation (AMD FidelityFX SDK 1.1.4, `ffx_frameinterpolation*`,
//! MIT), ported to WGSL (`interpolation.wgsl`): the frame halfway between the previous
//! real frame and this one, from the camera's motion vectors, the optical flow
//! (`optical_flow.rs`) and the depth.
//!
//! The passes and their order are `ffxFrameInterpolationPrepare` then
//! `ffxFrameInterpolationDispatch`'s: dilate the depth and motion vectors and estimate
//! the previous frame's depth; estimate the made frame's depth; splat the game's and the
//! optical flow's vectors to the made frame's pixels (atomic maximums of packed
//! priorities and vectors) and fill the game field's holes from a pyramid; mask what each
//! frame can't see; blend the two frames along both fields; fill what is left from a
//! pyramid of the result. What differs from AMD's, all forced by WGSL or by Horizon:
//! the game's motion vectors are the camera's, from the depth and `Inputs::reproject`,
//! except where `Inputs::object_motion` has an entity's own; textures AMD updates
//! with image atomics are storage buffers; SPD's single-pass pyramids are a pass per
//! level; and there is no HUD-less pass, as Horizon draws its HUD over the made frame.

// use glam::Mat4;

/// One real frame's inputs.
pub const Inputs = struct {
    /// This frame's colour without the hand and HUD: `display` size, a filterable
    /// float texture (gamma-encoded RGB, the swapchain's values) that can be copied from.
    color: *'a wgpu::TextureView,
    /// This frame's depth: `Depth32Float` at `render_size`, reversed (1 at the near
    /// plane, 0 at the far one), finite, jittered by `jitter`.
    depth: *'a wgpu::TextureView,
    render_size: [u32,
    /// The projection's sub-pixel jitter this frame, in render pixels (FSR's
    /// `jitterOffset`); zero without TAA.
    jitter: [f32,
    /// This frame's unjittered clip space to the previous frame's (camera-relative, as
    /// `world_post::reprojection`): the motion vectors are the camera's, from this and
    /// the depth.
    reproject: Mat4,
    /// What moved on its own: `motion::FORMAT` at `render_size`, xy its motion vector
    /// (FSR's convention, in UV) where z is 1, used over the camera's.
    object_motion: *'a wgpu::TextureView,
    near: f32,
    far: f32,
    /// Vertical field of view, radians.
    fov_y: f32,
    /// The previous frame is unrelated (first frame, resize, teleport): show this one.
    reset: bool,
    /// The optical flow from the previous frame's `color` to this one's
    /// (`OpticalFlow::vectors`, `scene_change`).
    flow_vectors: *'a wgpu::TextureView,
    scene_change: *'a wgpu::Buffer,
};

/// `interpolation.wgsl`'s `Params`.
pub const Params = struct {
    reproject: [[f32,
    device_to_view: [f32,
    render_size: [i32,
    display_size: [i32,
    jitter: [f32,
    optical_flow_scale: [f32,
    optical_flow_size: [i32,
    reset: u32,
    tan_half_fov: f32,
    level_size: [i32,
    _pad: [u32,
};

/// The game vector field pyramid's levels (`LoadInpaintedGameFieldMv`) and the
/// inpainting pyramid's (`ComputeInpainting`).
pub const GAME_LEVELS: u32 = 11;
pub const INPAINTING_LEVELS: u32 = 10;

pub const Pipelines = struct {
    prepare: wgpu::ComputePipeline,
    setup: wgpu::ComputePipeline,
    reconstruct_previous_depth: wgpu::ComputePipeline,
    game_motion_vector_field: wgpu::ComputePipeline,
    game_field_pyramid_first: wgpu::ComputePipeline,
    game_field_pyramid: wgpu::ComputePipeline,
    optical_flow_vector_field: wgpu::ComputePipeline,
    disocclusion_mask: wgpu::ComputePipeline,
    interpolate: wgpu::ComputePipeline,
    inpainting_pyramid_first: wgpu::ComputePipeline,
    inpainting_pyramid: wgpu::ComputePipeline,
    inpainting: wgpu::ComputePipeline,
};

/// A texture with a view of each of its levels (`levels`, for writing one from the one
/// above) and of all of them.
pub const Pyramid = struct {
    all: wgpu::TextureView,
    levels: std.ArrayList(wgpu::TextureView),
    sizes: Vec<[u32,
};

/// What is sized like the world's render.
pub const RenderTargets = struct {
    size: [u32,
    dilated_depth: wgpu::TextureView,
    dilated_mv: wgpu::TextureView,
    rec_prev_depth: wgpu::Buffer,
    rec_interp_depth: wgpu::Buffer,
    game_x: wgpu::Buffer,
    game_y: wgpu::Buffer,
    of_x: wgpu::Buffer,
    of_y: wgpu::Buffer,
    disocclusion: wgpu::TextureView,
    game_pyramid: Pyramid,
};

pub const Interpolation = struct {
    display: [u32,
    pipelines: Pipelines,
    sampler: wgpu::Sampler,
    /// The passes' constants, and each pyramid level's.
    params: wgpu::Buffer,
    game_level_params: std.ArrayList(wgpu::Buffer),
    inpainting_level_params: std.ArrayList(wgpu::Buffer),
    counters: wgpu::Buffer,
    interpolated: wgpu::TextureView,
    output: wgpu::TextureView,
    inpainting_pyramid: Pyramid,
    /// The last dispatch's colour (`PREVIOUS_INTERPOLATION_SOURCE`), made on the first.
    previous: ?wgpu::Texture,
    render: ?RenderTargets,
};

    // rust: fn texture(
    // rust: device: &wgpu::Device,
    // rust: label: &str,
    // rust: size: [u32; 2],
    // rust: format: wgpu::TextureFormat,
    // rust: levels: u32,
    // rust: ) -> wgpu::Texture {
    // rust: device.create_texture(&wgpu::TextureDescriptor {
    // rust: label: Some(label),
    // rust: size: wgpu::Extent3d {
    // rust: width: size[0].max(1),
    // rust: height: size[1].max(1),
    // rust: depth_or_array_layers: 1,
    // rust: },
    // rust: mip_level_count: levels,
    // rust: sample_count: 1,
    // rust: dimension: wgpu::TextureDimension::D2,
    // rust: format,
    // rust: usage: wgpu::TextureUsages::STORAGE_BINDING
    // rust: | wgpu::TextureUsages::TEXTURE_BINDING
    // rust: | wgpu::TextureUsages::COPY_SRC,
    // rust: view_formats: &[],
    // rust: })
}

pub fn storage(device: *wgpu::Device, label: []const u8, size: u64) w {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: Some(label),
    // rust: size: size.max(4),
    // rust: usage: wgpu::BufferUsages::STORAGE | wgpu::BufferUsages::COPY_DST,
    // rust: mapped_at_creation: false,
    // rust: })
}

pub fn uniform(device: *wgpu::Device) w {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: Some("Frame interpolation constants"),
    // rust: size: std::mem::size_of::<Params>() as u64,
    // rust: usage: wgpu::BufferUsages::UNIFORM | wgpu::BufferUsages::COPY_DST,
    // rust: mapped_at_creation: false,
    // rust: })
}

/// Levels of `base >> (i + 1)` for `i` below `max`, while both sides are 1 or more.
pub fn pyramid(device: *wgpu::Device, label: []const u8, base: [u32; 2], max: u32) P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let sizes: Vec<[u32; 2]> = (0..max)
    // rust: .map(|i| base.map(|v| v >> (i + 1)))
    // rust: .take_while(|s| s[0] >= 1 && s[1] >= 1)
    // rust: .collect();
    // rust: let levels = (sizes.len() as u32).max(1);
    // rust: let t = texture(
    // rust: device,
    // rust: label,
    // rust: base.map(|v| (v / 2).max(1)),
    // rust: wgpu::TextureFormat::Rgba16Float,
    // rust: levels,
    // rust: );
    // rust: Pyramid {
    // rust: all: t.create_view(&Default::default()),
    // rust: levels: (0..levels)
    // rust: .map(|i| {
    // rust: t.create_view(&wgpu::TextureViewDescriptor {
    // rust: base_mip_level: i,
    // rust: mip_level_count: Some(1),
    // rust: ..Default::default()
    // rust: })
    // rust: })
    // rust: .collect(),
    // rust: sizes,
}
}

    // rust: impl RenderTargets {
pub fn new(device: *wgpu::Device, size: [u32; 2]) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let view = |t: wgpu::Texture| t.create_view(&Default::default());
    // rust: let field = |label| storage(device, label, u64::from(size[0] * size[1]) * 4);
    // rust: Self {
    // rust: size,
    // rust: dilated_depth: view(texture(
    // rust: device,
    // rust: "Frame interpolation dilated depth",
    // rust: size,
    // rust: wgpu::TextureFormat::R32Float,
    // rust: 1,
    // rust: )),
    // rust: dilated_mv: view(texture(
    // rust: device,
    // rust: "Frame interpolation dilated motion vectors",
    // rust: size,
    // rust: wgpu::TextureFormat::Rg32Float,
    // rust: 1,
    // rust: )),
    // rust: rec_prev_depth: field("Frame interpolation previous depth"),
    // rust: rec_interp_depth: field("Frame interpolation interpolated depth"),
    // rust: game_x: field("Frame interpolation game vectors x"),
    // rust: game_y: field("Frame interpolation game vectors y"),
    // rust: of_x: field("Frame interpolation flow vectors x"),
    // rust: of_y: field("Frame interpolation flow vectors y"),
    // rust: disocclusion: view(texture(
    // rust: device,
    // rust: "Frame interpolation disocclusion",
    // rust: size,
    // rust: wgpu::TextureFormat::Rgba8Unorm,
    // rust: 1,
    // rust: )),
    // rust: game_pyramid: pyramid(
    // rust: device,
    // rust: "Frame interpolation game vector pyramid",
    // rust: size,
    // rust: GAME_LEVELS,
    // rust: ),
}
}
}

    // rust: fn bind(
    // rust: device: &wgpu::Device,
    // rust: pipeline: &wgpu::ComputePipeline,
    // rust: entries: &[(u32, wgpu::BindingResource)],
    // rust: ) -> wgpu::BindGroup {
    // rust: let entries: Vec<_> = entries
    // rust: .iter()
    // rust: .map(|(binding, resource)| wgpu::BindGroupEntry {
    // rust: binding: *binding,
    // rust: resource: resource.clone(),
    // rust: })
    // rust: .collect();
    // rust: device.create_bind_group(&wgpu::BindGroupDescriptor {
    // rust: label: Some("Frame interpolation"),
    // rust: layout: &pipeline.get_bind_group_layout(0),
    // rust: entries: &entries,
    // rust: })
}

pub fn view(v: *wgpu::TextureView) w {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: wgpu::BindingResource::TextureView(v)
}

pub fn whole(b: *wgpu::Buffer) w {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: b.as_entire_binding()
}

/// `setupDeviceDepthToViewSpaceDepthParams` for inverted, finite depth, in blocks
/// (`viewSpaceToMetersFactor` 1).
pub fn device_to_view(near: f32, far: f32, fov_y: f32, aspect: f32) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (f_min, f_max) = (near.max(far), near.min(far));
    // rust: let q = f_max / (f_min - f_max);
    // rust: let cot_half_fov = (0.5 * fov_y).cos() / (0.5 * fov_y).sin();
    // rust: [-q, q * f_min, aspect / cot_half_fov, 1.0 / cot_half_fov]
}

    // rust: impl Interpolation {
    /// For frames of `display` size; the render size may change between dispatches.
pub fn new(device: *wgpu::Device, display: [u32; 2]) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let module = device.create_shader_module(wgpu::ShaderModuleDescriptor {
    // rust: label: Some("Frame interpolation"),
    // rust: source: wgpu::ShaderSource::Wgsl(include_str!("interpolation.wgsl").into()),
    // rust: });
    // rust: let pipeline = |entry: &str| {
    // rust: device.create_compute_pipeline(&wgpu::ComputePipelineDescriptor {
    // rust: label: Some(entry),
    // rust: layout: None,
    // rust: module: &module,
    // rust: entry_point: Some(entry),
    // rust: compilation_options: Default::default(),
    // rust: cache: None,
    // rust: })
}
    // rust: let view = |t: wgpu::Texture| t.create_view(&Default::default());
    // rust: Self {
    // rust: display,
    // rust: pipelines: Pipelines {
    // rust: prepare: pipeline("prepare_pass"),
    // rust: setup: pipeline("setup_pass"),
    // rust: reconstruct_previous_depth: pipeline("reconstruct_previous_depth_pass"),
    // rust: game_motion_vector_field: pipeline("game_motion_vector_field_pass"),
    // rust: game_field_pyramid_first: pipeline("game_field_pyramid_first_pass"),
    // rust: game_field_pyramid: pipeline("game_field_pyramid_pass"),
    // rust: optical_flow_vector_field: pipeline("optical_flow_vector_field_pass"),
    // rust: disocclusion_mask: pipeline("disocclusion_mask_pass"),
    // rust: interpolate: pipeline("interpolate_pass"),
    // rust: inpainting_pyramid_first: pipeline("inpainting_pyramid_first_pass"),
    // rust: inpainting_pyramid: pipeline("inpainting_pyramid_pass"),
    // rust: inpainting: pipeline("inpainting_pass"),
    // rust: },
    // rust: sampler: device.create_sampler(&wgpu::SamplerDescriptor {
    // rust: label: Some("Frame interpolation"),
    // rust: mag_filter: wgpu::FilterMode::Linear,
    // rust: min_filter: wgpu::FilterMode::Linear,
    // rust: ..Default::default()
    // rust: }),
    // rust: params: uniform(device),
    // rust: game_level_params: (0..GAME_LEVELS).map(|_| uniform(device)).collect(),
    // rust: inpainting_level_params: (0..INPAINTING_LEVELS).map(|_| uniform(device)).collect(),
    // rust: counters: storage(device, "Frame interpolation counters", 8),
    // rust: interpolated: view(texture(
    // rust: device,
    // rust: "Frame interpolation",
    // rust: display,
    // rust: wgpu::TextureFormat::Rgba16Float,
    // rust: 1,
    // rust: )),
    // rust: output: view(texture(
    // rust: device,
    // rust: "Interpolated frame",
    // rust: display,
    // rust: wgpu::TextureFormat::Rgba16Float,
    // rust: 1,
    // rust: )),
    // rust: inpainting_pyramid: pyramid(
    // rust: device,
    // rust: "Frame interpolation inpainting pyramid",
    // rust: display,
    // rust: INPAINTING_LEVELS,
    // rust: ),
    // rust: previous: None,
    // rust: render: None,
}
}

    /// The frame halfway between the previous dispatch's `color` and this one's, into
    /// `output`. Keeps what it needs of this frame for the next dispatch.
    // rust: pub fn dispatch(
    // rust: &mut self,
    // rust: device: &wgpu::Device,
    // rust: queue: &wgpu::Queue,
    // rust: encoder: &mut wgpu::CommandEncoder,
    // rust: inputs: &Inputs,
    // rust: ) {
    // rust: let color = inputs.color.texture();
    // rust: let mut reset = inputs.reset;
    // rust: if self
    // rust: .previous
    // rust: .as_ref()
    // rust: .is_none_or(|p| p.size() != color.size() || p.format() != color.format())
    // rust: {
    // rust: self.previous = Some(device.create_texture(&wgpu::TextureDescriptor {
    // rust: label: Some("Frame interpolation previous frame"),
    // rust: size: color.size(),
    // rust: mip_level_count: 1,
    // rust: sample_count: 1,
    // rust: dimension: wgpu::TextureDimension::D2,
    // rust: format: color.format(),
    // rust: usage: wgpu::TextureUsages::TEXTURE_BINDING | wgpu::TextureUsages::COPY_DST,
    // rust: view_formats: &[],
    // rust: }));
    // rust: reset = true;
}
    // rust: if self
    // rust: .render
    // rust: .as_ref()
    // rust: .is_none_or(|r| r.size != inputs.render_size)
    // rust: {
    // rust: self.render = Some(RenderTargets::new(device, inputs.render_size));
    // rust: reset = true;
}
    // rust: let r = self.render.as_ref().expect("made above");
    // rust: let previous_texture = self.previous.as_ref().expect("made above");
    // rust: let previous = previous_texture.create_view(&Default::default());
    // rust: let display = self.display.map(|v| v as i32);
    // rust: let render = inputs.render_size.map(|v| v as i32);
    // rust: let flow_size = self
    // rust: .display
    // rust: .map(|v| v.div_ceil(super::optical_flow::BLOCK_SIZE) as i32);
    // rust: let base = Params {
    // rust: reproject: inputs.reproject.to_cols_array_2d(),
    // rust: device_to_view: device_to_view(
    // rust: inputs.near,
    // rust: inputs.far,
    // rust: inputs.fov_y,
    // rust: render[0] as f32 / render[1].max(1) as f32,
    // rust: ),
    // rust: render_size: render,
    // rust: display_size: display,
    // rust: jitter: inputs.jitter,
    // rust: optical_flow_scale: self.display.map(|v| 1.0 / v as f32),
    // rust: optical_flow_size: flow_size,
    // rust: reset: u32::from(reset),
    // rust: tan_half_fov: (0.5 * inputs.fov_y).tan() * render[0] as f32 / render[1].max(1) as f32,
    // rust: level_size: [0; 2],
    // rust: _pad: [0; 2],
}
    // rust: queue.write_buffer(&self.params, 0, bytemuck::bytes_of(&base));
    // rust: let level_params = |buffers: &[wgpu::Buffer], sizes: &[[u32; 2]]| {
    // rust: for (buffer, size) in buffers.iter().zip(sizes) {
    // rust: let params = Params {
    // rust: level_size: size.map(|v| v as i32),
    // rust: ..base
}
    // rust: queue.write_buffer(buffer, 0, bytemuck::bytes_of(&params));
}
}
    // rust: level_params(&self.game_level_params, &r.game_pyramid.sizes);
    // rust: level_params(
    // rust: &self.inpainting_level_params,
    // rust: &self.inpainting_pyramid.sizes,
    // rust: );
    // rust: for b in [
    // rust: &r.rec_prev_depth,
    // rust: &r.rec_interp_depth,
    // rust: &r.game_x,
    // rust: &r.game_y,
    // rust: &r.of_x,
    // rust: &r.of_y,
    // rust: ] {
    // rust: encoder.clear_buffer(b, 0, None);
}
    // rust: if reset {
    // rust: encoder.clear_buffer(&self.counters, 0, None);
}
    // rust: let p = &self.pipelines;
    // rust: let params = || whole(&self.params);
    // rust: let sampler = || wgpu::BindingResource::Sampler(&self.sampler);
    // rust: let groups =
    // rust: |pipeline, entries: &[(u32, wgpu::BindingResource)]| bind(device, pipeline, entries);
    // rust: let prepare = groups(
    // rust: &p.prepare,
    // rust: &[
    // rust: (0, params()),
    // rust: (2, view(inputs.depth)),
    // rust: (34, view(inputs.object_motion)),
    // rust: (5, view(&r.dilated_depth)),
    // rust: (6, view(&r.dilated_mv)),
    // rust: (9, whole(&r.rec_prev_depth)),
    // rust: ],
    // rust: );
    // rust: let setup = groups(
    // rust: &p.setup,
    // rust: &[
    // rust: (0, params()),
    // rust: (22, whole(inputs.scene_change)),
    // rust: (23, whole(&self.counters)),
    // rust: ],
    // rust: );
    // rust: let colors = || {
    // rust: [
    // rust: (3, view(inputs.color)),
    // rust: (4, view(&previous)),
    // rust: (1, sampler()),
    // rust: ]
}
    // rust: let reconstruct = groups(
    // rust: &p.reconstruct_previous_depth,
    // rust: &[
    // rust: (0, params()),
    // rust: (7, view(&r.dilated_depth)),
    // rust: (8, view(&r.dilated_mv)),
    // rust: (10, whole(&r.rec_interp_depth)),
    // rust: ],
    // rust: );
    // rust: let mut entries = vec![
    // rust: (0, params()),
    // rust: (7, view(&r.dilated_depth)),
    // rust: (8, view(&r.dilated_mv)),
    // rust: (13, whole(&r.game_x)),
    // rust: (14, whole(&r.game_y)),
    // rust: ];
    // rust: entries.extend(colors());
    // rust: let game_field = groups(&p.game_motion_vector_field, &entries);
    // rust: let game_pyramid: Vec<_> = (0..r.game_pyramid.sizes.len())
    // rust: .map(|i| {
    // rust: let mut entries = vec![
    // rust: (0, whole(&self.game_level_params[i])),
    // rust: (26, view(&r.game_pyramid.levels[i])),
    // rust: ];
    // rust: if i == 0 {
    // rust: entries.extend([(15, whole(&r.game_x)), (16, whole(&r.game_y))]);
    // rust: groups(&p.game_field_pyramid_first, &entries)
    // rust: } else {
    // rust: entries.push((25, view(&r.game_pyramid.levels[i - 1])));
    // rust: groups(&p.game_field_pyramid, &entries)
}
    // rust: })
    // rust: .collect();
    // rust: let mut entries = vec![
    // rust: (0, params()),
    // rust: (21, view(inputs.flow_vectors)),
    // rust: (17, whole(&r.of_x)),
    // rust: (18, whole(&r.of_y)),
    // rust: ];
    // rust: entries.extend(colors());
    // rust: let flow_field = groups(&p.optical_flow_vector_field, &entries);
    // rust: let game_mv = || {
    // rust: [
    // rust: (15, whole(&r.game_x)),
    // rust: (16, whole(&r.game_y)),
    // rust: (27, view(&r.game_pyramid.all)),
    // rust: ]
}
    // rust: let mut entries = vec![
    // rust: (0, params()),
    // rust: (7, view(&r.dilated_depth)),
    // rust: (11, whole(&r.rec_prev_depth)),
    // rust: (12, whole(&r.rec_interp_depth)),
    // rust: (29, view(&r.disocclusion)),
    // rust: ];
    // rust: entries.extend(game_mv());
    // rust: let disocclusion = groups(&p.disocclusion_mask, &entries);
    // rust: let mut entries = vec![
    // rust: (0, params()),
    // rust: (19, whole(&r.of_x)),
    // rust: (20, whole(&r.of_y)),
    // rust: (24, whole(&self.counters)),
    // rust: (30, view(&r.disocclusion)),
    // rust: (31, view(&self.interpolated)),
    // rust: ];
    // rust: entries.extend(game_mv());
    // rust: entries.extend(colors());
    // rust: let interpolate = groups(&p.interpolate, &entries);
    // rust: let inpainting_pyramid: Vec<_> = (0..self.inpainting_pyramid.sizes.len())
    // rust: .map(|i| {
    // rust: let mut entries = vec![
    // rust: (0, whole(&self.inpainting_level_params[i])),
    // rust: (26, view(&self.inpainting_pyramid.levels[i])),
    // rust: ];
    // rust: if i == 0 {
    // rust: entries.push((32, view(&self.interpolated)));
    // rust: groups(&p.inpainting_pyramid_first, &entries)
    // rust: } else {
    // rust: entries.push((25, view(&self.inpainting_pyramid.levels[i - 1])));
    // rust: groups(&p.inpainting_pyramid, &entries)
}
    // rust: })
    // rust: .collect();
    // rust: let inpainting = groups(
    // rust: &p.inpainting,
    // rust: &[
    // rust: (0, params()),
    // rust: (28, view(&self.inpainting_pyramid.all)),
    // rust: (32, view(&self.interpolated)),
    // rust: (33, view(&self.output)),
    // rust: ],
    // rust: );
    // rust: let groups_for = |size: [u32; 2]| (size[0].div_ceil(8), size[1].div_ceil(8));
    // rust: let (rx, ry) = groups_for(inputs.render_size);
    // rust: let (dx, dy) = groups_for(self.display);
    // rust: let mut pass = encoder.begin_compute_pass(&wgpu::ComputePassDescriptor {
    // rust: label: Some("Frame interpolation"),
    // rust: timestamp_writes: None,
    // rust: });
    // rust: let mut run = |pipeline: &wgpu::ComputePipeline, group: &wgpu::BindGroup, (x, y)| {
    // rust: pass.set_pipeline(pipeline);
    // rust: pass.set_bind_group(0, group, &[]);
    // rust: pass.dispatch_workgroups(x, y, 1);
}
    // rust: run(&p.prepare, &prepare, (rx, ry));
    // rust: run(&p.setup, &setup, (1, 1));
    // rust: if !reset {
    // rust: run(&p.reconstruct_previous_depth, &reconstruct, (rx, ry));
    // rust: run(&p.game_motion_vector_field, &game_field, (rx, ry));
    // rust: for (i, (group, size)) in game_pyramid.iter().zip(&r.game_pyramid.sizes).enumerate() {
    // rust: let pipeline = if i == 0 {
    // rust: &p.game_field_pyramid_first
    // rust: } else {
    // rust: &p.game_field_pyramid
}
    // rust: run(pipeline, group, groups_for(*size));
}
    // rust: run(
    // rust: &p.optical_flow_vector_field,
    // rust: &flow_field,
    // rust: groups_for(flow_size.map(|v| v as u32)),
    // rust: );
    // rust: run(&p.disocclusion_mask, &disocclusion, (rx, ry));
}
    // rust: run(&p.interpolate, &interpolate, (dx, dy));
    // rust: for (i, (group, size)) in inpainting_pyramid
    // rust: .iter()
    // rust: .zip(&self.inpainting_pyramid.sizes)
    // rust: .enumerate()
    // rust: {
    // rust: let pipeline = if i == 0 {
    // rust: &p.inpainting_pyramid_first
    // rust: } else {
    // rust: &p.inpainting_pyramid
}
    // rust: run(pipeline, group, groups_for(*size));
}
    // rust: run(&p.inpainting, &inpainting, (dx, dy));
    // rust: drop(pass);
    // rust: encoder.copy_texture_to_texture(
    // rust: color.as_image_copy(),
    // rust: previous_texture.as_image_copy(),
    // rust: color.size(),
    // rust: );
}

    /// The interpolated frame: `display` size, `Rgba16Float`, sampled; its colour is
    /// encoded as `Inputs::color`'s is.
pub fn output(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: &self.output
}
}

    // rust: mod tests {
//     use super::super::optical_flow::{OpticalFlow, tests as of};
//     use super::*;

pub fn shader_validates() void {
}
    // rust: let module = naga::front::wgsl::parse_str(include_str!("interpolation.wgsl")).unwrap();
    // rust: naga::valid::Validator::new(
    // rust: naga::valid::ValidationFlags::all(),
    // rust: naga::valid::Capabilities::empty(),
    // rust: )
    // rust: .validate(&module)
    // rust: .unwrap();
}

pub fn f16(bits: u16) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (sign, exp, frac) = (bits >> 15, (bits >> 10) & 0x1f, bits & 0x3ff);
    // rust: let v = match exp {
    // rust: 0 => f32::from(frac) / 1024.0 * 2f32.powi(-14),
    // rust: 31 => f32::INFINITY,
    // rust: e => (1.0 + f32::from(frac) / 1024.0) * 2f32.powi(i32::from(e) - 15),
}
    // rust: if sign == 1 { -v } else { v }
}

    /// Runs `frames` (pattern shifts) through the optical flow and the interpolation with
    /// a camera that moves by `reproject` each frame, and returns the mean error of the
    /// last made frame's interior against `expected`, and the last two real frames'.
    /// `object`: every pixel's own motion vector (UV), as if all of it moved on its own.
    // rust: fn interpolate(
    // rust: seed: u32,
    // rust: shifts: &[[i32; 2]],
    // rust: reproject: Mat4,
    // rust: object: Option<[f32; 2]>,
    // rust: expected: [i32; 2],
    // rust: ) -> Option<[f32; 3]> {
    // rust: let (device, queue) = of::device()?;
    // rust: let size = [512, 288];
    // rust: let depth = device.create_texture(&wgpu::TextureDescriptor {
    // rust: label: None,
    // rust: size: wgpu::Extent3d {
    // rust: width: size[0],
    // rust: height: size[1],
    // rust: depth_or_array_layers: 1,
    // rust: },
    // rust: mip_level_count: 1,
    // rust: sample_count: 1,
    // rust: dimension: wgpu::TextureDimension::D2,
    // rust: format: wgpu::TextureFormat::Depth32Float,
    // rust: usage: wgpu::TextureUsages::RENDER_ATTACHMENT | wgpu::TextureUsages::TEXTURE_BINDING,
    // rust: view_formats: &[],
    // rust: });
    // rust: let depth = depth.create_view(&Default::default());
    // rust: let mut encoder = device.create_command_encoder(&Default::default());
    // rust: encoder.begin_render_pass(&wgpu::RenderPassDescriptor {
    // rust: label: None,
    // rust: color_attachments: &[],
    // rust: depth_stencil_attachment: Some(wgpu::RenderPassDepthStencilAttachment {
    // rust: view: &depth,
    // rust: depth_ops: Some(wgpu::Operations {
    // rust: load: wgpu::LoadOp::Clear(0.01),
    // rust: store: wgpu::StoreOp::Store,
    // rust: }),
    // rust: stencil_ops: None,
    // rust: }),
    // rust: ..Default::default()
    // rust: });
    // rust: queue.submit([encoder.finish()]);
    // rust: let object_motion = device.create_texture(&wgpu::TextureDescriptor {
    // rust: label: None,
    // rust: size: wgpu::Extent3d {
    // rust: width: size[0],
    // rust: height: size[1],
    // rust: depth_or_array_layers: 1,
    // rust: },
    // rust: mip_level_count: 1,
    // rust: sample_count: 1,
    // rust: dimension: wgpu::TextureDimension::D2,
    // rust: format: super::super::motion::FORMAT,
    // rust: usage: wgpu::TextureUsages::TEXTURE_BINDING | wgpu::TextureUsages::COPY_DST,
    // rust: view_formats: &[],
    // rust: });
    // rust: if let Some(mv) = object {
    // rust: let texel = [mv[0], mv[1], 1.0, 0.0].map(|v| half::f16::from_f32(v).to_bits());
    // rust: let texels: Vec<u16> = (0..size[0] * size[1]).flat_map(|_| texel).collect();
    // rust: queue.write_texture(
    // rust: object_motion.as_image_copy(),
    // rust: bytemuck::cast_slice(&texels),
    // rust: wgpu::TexelCopyBufferLayout {
    // rust: offset: 0,
    // rust: bytes_per_row: Some(size[0] * 8),
    // rust: rows_per_image: None,
    // rust: },
    // rust: object_motion.size(),
    // rust: );
}
    // rust: let object_motion = object_motion.create_view(&Default::default());
    // rust: let mut flow = OpticalFlow::new(&device, size);
    // rust: let mut interpolation = Interpolation::new(&device, size);
    // rust: let frames: Vec<_> = shifts
    // rust: .iter()
    // rust: .map(|s| {
    // rust: let pixels = of::pattern(size, seed, *s);
                // COPY_SRC as the frame generation's world texture has.
    // rust: let t = device.create_texture(&wgpu::TextureDescriptor {
    // rust: label: None,
    // rust: size: wgpu::Extent3d {
    // rust: width: size[0],
    // rust: height: size[1],
    // rust: depth_or_array_layers: 1,
    // rust: },
    // rust: mip_level_count: 1,
    // rust: sample_count: 1,
    // rust: dimension: wgpu::TextureDimension::D2,
    // rust: format: wgpu::TextureFormat::Rgba8Unorm,
    // rust: usage: wgpu::TextureUsages::TEXTURE_BINDING
    // rust: | wgpu::TextureUsages::COPY_DST
    // rust: | wgpu::TextureUsages::COPY_SRC,
    // rust: view_formats: &[],
    // rust: });
    // rust: queue.write_texture(
    // rust: t.as_image_copy(),
    // rust: &pixels,
    // rust: wgpu::TexelCopyBufferLayout {
    // rust: offset: 0,
    // rust: bytes_per_row: Some(size[0] * 4),
    // rust: rows_per_image: None,
    // rust: },
    // rust: t.size(),
    // rust: );
    // rust: (t.create_view(&Default::default()), pixels)
    // rust: })
    // rust: .collect();
    // rust: for (i, (color, _)) in frames.iter().enumerate() {
    // rust: let mut encoder = device.create_command_encoder(&Default::default());
    // rust: flow.dispatch(&device, &queue, &mut encoder, color, i == 0);
    // rust: interpolation.dispatch(
    // rust: &device,
    // rust: &queue,
    // rust: &mut encoder,
    // rust: &Inputs {
    // rust: color,
    // rust: depth: &depth,
    // rust: render_size: size,
    // rust: jitter: [0.0; 2],
    // rust: reproject: if i == 0 { Mat4::IDENTITY } else { reproject },
    // rust: object_motion: &object_motion,
    // rust: near: 0.05,
    // rust: far: 512.0,
    // rust: fov_y: 1.2,
    // rust: reset: i == 0,
    // rust: flow_vectors: flow.vectors(),
    // rust: scene_change: flow.scene_change(),
    // rust: },
    // rust: );
    // rust: queue.submit([encoder.finish()]);
}
    // rust: let out = of::read(&device, &queue, interpolation.output.texture(), 8);
    // rust: let made: Vec<f32> = out
    // rust: .chunks(2)
    // rust: .map(|c| f16(u16::from_le_bytes([c[0], c[1]])))
    // rust: .collect();
    // rust: let truth = of::pattern(size, seed, expected);
    // rust: let n = frames.len();
    // rust: let error = |pixels: &dyn Fn(usize) -> f32| {
    // rust: let (mut sum, mut count) = (0.0, 0.0);
    // rust: for y in 32..size[1] as usize - 32 {
    // rust: for x in 32..size[0] as usize - 32 {
    // rust: for c in 0..3 {
    // rust: let i = (y * size[0] as usize + x) * 4 + c;
    // rust: sum += (pixels(i) - f32::from(truth[i]) / 255.0).abs();
    // rust: count += 1.0;
}
}
}
    // rust: sum / count
}
    // rust: Some([
    // rust: error(&|i| made[i]),
    // rust: error(&|i| f32::from(frames[n - 2].1[i]) / 255.0),
    // rust: error(&|i| f32::from(frames[n - 1].1[i]) / 255.0),
    // rust: ])
}

    /// Something moving on its own (the camera still): the optical flow puts the made
    /// frame's blocks halfway where its colours match better than the still camera's
    /// (FSR prefers the game's vectors unless they clearly don't: primaries make it
    /// clear). The first 10 frames after a reset use the game's vectors only.
pub fn moves_what_the_optical_flow_follows_halfway() void {
}
    // rust: let mut shifts = vec![[0, 0]; 20];
    // rust: shifts.push([16, 8]);
    // rust: let Some([made, previous, current]) =
    // rust: interpolate(100, &shifts, Mat4::IDENTITY, None, [8, 4])
    // rust: else {
    // rust: return;
}
        // Where the still camera's two colours happen to be the same primary (a third of
        // the pixels), FSR keeps the game's vectors.
    // rust: assert!(
    // rust: made * 3.0 < previous.min(current),
    // rust: "{made} against {previous} and {current}"
    // rust: );
}

    /// The camera turning: the game's motion vectors put the made frame halfway.
pub fn moves_the_view_halfway_with_the_camera() void {
}
    // rust: let size = [512.0, 288.0];
        // What is at a pixel now was 16 pixels to its right last frame.
    // rust: let reproject = Mat4::from_translation(glam::Vec3::new(32.0 / size[0], 0.0, 0.0));
    // rust: let shifts = [[0, 0], [-16, 0], [-32, 0], [-48, 0]];
    // rust: let Some([made, previous, current]) = interpolate(1, &shifts, reproject, None, [-40, 0])
    // rust: else {
    // rust: return;
}
    // rust: assert!(
    // rust: made * 4.0 < previous.min(current),
    // rust: "{made} against {previous} and {current}"
    // rust: );
}

    /// Something moving on its own with its own motion vectors (the camera still): the
    /// made frame is halfway, as with the camera's.
pub fn moves_what_has_its_own_motion_vectors_halfway() void {
}
    // rust: let size = [512.0, 288.0];
    // rust: let shifts = [[0, 0], [16, 8], [32, 16], [48, 24]];
    // rust: let mv = [-16.0 / size[0], -8.0 / size[1]];
    // rust: let Some([made, previous, current]) =
    // rust: interpolate(1, &shifts, Mat4::IDENTITY, Some(mv), [40, 20])
    // rust: else {
    // rust: return;
}
    // rust: assert!(
    // rust: made * 4.0 < previous.min(current),
    // rust: "{made} against {previous} and {current}"
    // rust: );
}
}
