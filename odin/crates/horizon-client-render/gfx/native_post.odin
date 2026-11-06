//! Transpiled from Horizon Rust crate
package horizon_client_render_native_post

import "core:fmt"
import "core:mem"
import "core:math"

// The post stage of Horizon's own shader packs (docs/shaders.md): each `[[post]]` pass is a
// full-screen pipeline built from its checked naga module (`horizon_shader_api::check`), with
// the pack's options as pipeline constants. A pass reads bind group 3: the frame, the world's
// colour and depth, the previous pass's output and two samplers. Passes before the last write
// half-float targets of the world's size, so values over 1 carry to the next; the last draws
// onto the screen. Every stage of a pack reads the same `frame`, written once a frame
// (`NativeFrame`).

// use glam::{Mat4, Vec3};
// use horizon_shader_api::{Frame as FrameInputs, check::CheckedStage, stages::GROUP};

// use super::Frame;

INTERMEDIATE :: wgpu::TextureFormat::Rgba16Float

// The world's colour and depth views a set of bind groups was made for.
    // rust: type WorldViews = (wgpu::TextureView, wgpu::TextureView, wgpu::TextureView);

// Where a post pass draws.
Writes :: enum {
    // One of the chain's two targets.
    Chain(usize),
    // A pack target (`[[post]] output`).
    Target(usize),
    // The screen: the last pass.
    Screen,
}

// A post pass's target, and the chain's picture it reads as `previous` (the world's for
// none).
PassPlan :: struct {
    writes: Writes,
    reads: Maybe(uint),
}

// The passes' plan for `outputs` (each pass's `[[post]] output`, by target index): the chain's
// passes write its targets in turn, each reading what the one before wrote; a pass with an
// output writes that and reads the chain's picture, which goes on past it.
plan :: proc(outputs: ^[Maybe(uint)]) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut current = None;
    // rust: outputs
    // rust: .iter()
    // rust: .enumerate()
    // rust: .map(|(i, output)| {
    // rust: let reads = current;
    // rust: let writes = match output {
    // rust: _ if i + 1 == outputs.len() => Writes::Screen,
    // rust: Some(t) => Writes::Target(*t),
    // rust: None => {
    // rust: let slot = usize::from(current == Some(0));
    // rust: current = Some(slot);
    // rust: Writes::Chain(slot)
}
}
    // rust: PassPlan { writes, reads }
    // rust: })
    // rust: .collect()
}

// A pack target's size: `scale` of the world's `size`, at least a texel.
scaled :: proc(size: [u32; 2], scale: f32) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: size.map(|s| ((s as f32 * scale).ceil() as u32).max(1))
}

NativePost :: struct {
    passes: Vec<(string,
    layout: wgpu::BindGroupLayout,
    // The pack's textures.
    textures: Vec<(wgpu::TextureView,
    frame: wgpu::Buffer,
    linear: wgpu::Sampler,
    nearest: wgpu::Sampler,
    // Two targets of the world's size, written in turn (none with a single pass).
    targets: Option<([u32,
    // The frame's shadow map, its comparison sampler (bindings 6 and 7), the translucent map
    // and its colour (bindings 9 and 10).
    shadow: (,
    wgpu: :TextureView,
    wgpu: :Sampler,
    wgpu: :TextureView,
    wgpu: :TextureView,
    // rust: ),
    // Last frame's input to the last pass (`history`, binding 8), made with the targets,
    // and a black 1×1 in its place before then.
    history: Maybe(wgpu::Texture),
    history_blank: wgpu::Texture,
    // One bind group per pass, for these world views and either the valid history or black.
    groups: Option<(WorldViews,
    // Whether `history` contains the last frame's input to the last pass.
    history_valid: bool,
    // What each pass writes and reads (`[[post]] output`).
    plan: [dynamic]PassPlan,
    // The pack's targets' scales (`Manifest::post_targets`), and their views for the world's
    // size.
    scales: [dynamic]f32,
    named: Option<([u32,
    // The screen's colour format, the world target's too.
    format: wgpu::TextureFormat,
}

// The `frame` every stage of a pack reads (group 3, binding 0), written once a frame, and
// what the material stage reads besides.
NativeFrame :: struct {
    // The solid terrain's second target, the post stage's `scene_surface`.
    surface: wgpu::Texture,
    surface_view: wgpu::TextureView,
    // rust: pub(super) buffer: wgpu::Buffer,
    // Group 3 of the sky and material stages.
    layout: wgpu::BindGroupLayout,
    // The pack's `[[textures]]` and their samplers, bound for every stage.
    textures: Vec<(wgpu::TextureView,
    // The colour of block light around the camera (`[[lights]]`), bindings 9 and 10.
    block_light: super::block_light::BlockLight,
    group: wgpu::BindGroup,
    // The world's depth before translucent terrain (the material stage's `opaque_depth`,
    // binding 6), copied each frame.
    opaque_depth: wgpu::Texture,
    // The world's colour before translucent terrain (`opaque_color`, binding 11), copied
    // with it; 1×1 while the world draws straight to the window.
    opaque_color: wgpu::Texture,
    // The resource packs' LabPBR maps (bindings 12 and 13: normals, specular), a blank 1x1
    // without them.
    // rust: pub(super) pbr: [wgpu::TextureView; 2],
    // The material stage's `reflection` (binding 1): this frame's water mirror, else
    // `blank`; and its sampler (binding 2).
    reflection: wgpu::TextureView,
    blank: wgpu::TextureView,
    reflection_sampler: wgpu::Sampler,
    // The shadow map the stages read, and the camera that draws it when the pack asks for one.
    shadow_map: super::native_shadow::ShadowMap,
    shadow_camera: Maybe(horizon_shaders::Shadow),
    // Whether the pack's material reads `reflection` (`NativePack::new`): else no mirror
    // is drawn and `has_reflection` stays 0.
    reflects: bool,
    // Last frame's view-projection, camera and time (`write`).
    last: Option<([[f32,
    // The eased eye light (block, sky) and being in water and lava (`write`); NaN until the
    // first frame sets them.
    eye: [f32,
    // A post stage must use black history after a long gap until it has rendered a frame.
    history_reset: bool,
    start: std::time::Instant,
    frames: u32,
    // `frame.wetness`, and when it was last written.
    wetness: (f32,
}

// A depth texture of `size` the world's depth is copied into.
depth_copy :: proc(device: ^wgpu::Device, size: [u32; 2]) -> w {
    // Ported from Horizon
    return {}
}
    // rust: copy_target(
    // rust: device,
    // rust: "Native shader pack opaque depth",
    // rust: size,
    // rust: wgpu::TextureFormat::Depth32Float,
    // rust: )
}

// A colour texture of `size` and `format` the world's colour is copied into.
color_copy :: proc(device: ^wgpu::Device, size: [u32; 2], format: wgpu::TextureFormat) -> w {
    // Ported from Horizon
    return {}
}
    // rust: copy_target(device, "Native shader pack opaque colour", size, format)
}

    // rust: fn copy_target(
    // rust: device: &wgpu::Device,
    // rust: label: &str,
    // rust: size: [u32; 2],
    // rust: format: wgpu::TextureFormat,
    // rust: ) -> wgpu::Texture {
    // rust: device.create_texture(&wgpu::TextureDescriptor {
    // rust: label: Some(label),
    // rust: size: wgpu::Extent3d {
    // rust: width: size[0].max(1),
    // rust: height: size[1].max(1),
    // rust: depth_or_array_layers: 1,
    // rust: },
    // rust: mip_level_count: 1,
    // rust: sample_count: 1,
    // rust: dimension: wgpu::TextureDimension::D2,
    // rust: format,
    // rust: usage: wgpu::TextureUsages::TEXTURE_BINDING | wgpu::TextureUsages::COPY_DST,
    // rust: view_formats: &[],
    // rust: })
}

// The uniform `frame` at binding 0, read by `visibility`.
frame_entry :: proc(visibility: wgpu::ShaderStages) -> w {
    // Ported from Horizon
    return {}
}
    // rust: wgpu::BindGroupLayoutEntry {
    // rust: binding: 0,
    // rust: visibility,
    // rust: ty: wgpu::BindingType::Buffer {
    // rust: ty: wgpu::BufferBindingType::Uniform,
    // rust: has_dynamic_offset: false,
    // rust: min_binding_size: wgpu::BufferSize::new(size_of::<FrameInputs>() as u64),
    // rust: },
    // rust: count: None,
}
}

// The size of the water mirror for a world of `size`: half of it.
reflection_size :: proc(size: [u32; 2]) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: size.map(|s| s.div_ceil(2).max(1))
}

// Seconds between frames past which the last one is forgotten (`NativeFrame::write`).
MAX_FRAME_GAP :: 0.5

// `value` moved toward `target` over `dt` seconds by a half-life in seconds; a NaN `value`
// (the first frame) starts at `target`.
eased :: proc(value: f32, target: f32, half_life: f32, dt: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: if value.is_nan() {
    // rust: target
    // rust: } else {
    // rust: target + (value - target) * 0.5f32.powf(dt / half_life)
}
}

    // rust: impl NativeFrame {
    // The frame of a pack with the `[shadow]` settings `shadow`, if any, and the
    // block light colours `lights`.
    // rust: pub fn new(
    // rust: device: &wgpu::Device,
    // rust: shadow: Option<&horizon_shader_api::manifest::Shadow>,
    // rust: textures: Vec<(wgpu::TextureView, wgpu::Sampler)>,
    // rust: lights: super::block_light::LightTable,
    // rust: pbr: Option<&[wgpu::Texture; 2]>,
    // rust: ) -> Self {
    // rust: let buffer = device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: Some("Native shader pack frame"),
    // rust: size: size_of::<FrameInputs>() as u64,
    // rust: usage: wgpu::BufferUsages::UNIFORM | wgpu::BufferUsages::COPY_DST,
    // rust: mapped_at_creation: false,
    // rust: });
    // rust: let mut entries = vec![
    // rust: frame_entry(wgpu::ShaderStages::VERTEX_FRAGMENT),
    // rust: texture_entry(1, wgpu::TextureSampleType::Float { filterable: true }),
    // rust: sampler_entry(2),
    // rust: texture_entry(3, wgpu::TextureSampleType::Depth),
    // rust: comparison_entry(4),
    // rust: texture_entry(6, wgpu::TextureSampleType::Depth),
    // rust: texture_entry(7, wgpu::TextureSampleType::Depth),
    // rust: texture_entry(8, wgpu::TextureSampleType::Float { filterable: true }),
    // rust: texture_entry(11, wgpu::TextureSampleType::Float { filterable: false }),
    // rust: pbr_entry(12),
    // rust: pbr_entry(13),
    // rust: ];
    // rust: let block_light_entries = [
    // rust: wgpu::BindGroupLayoutEntry {
    // rust: binding: 9,
    // rust: visibility: wgpu::ShaderStages::FRAGMENT,
    // rust: ty: wgpu::BindingType::Texture {
    // rust: sample_type: wgpu::TextureSampleType::Float { filterable: true },
    // rust: view_dimension: wgpu::TextureViewDimension::D3,
    // rust: multisampled: false,
    // rust: },
    // rust: count: None,
    // rust: },
    // rust: wgpu::BindGroupLayoutEntry {
    // rust: binding: 10,
    // rust: visibility: wgpu::ShaderStages::FRAGMENT,
    // rust: ty: wgpu::BindingType::Buffer {
    // rust: ty: wgpu::BufferBindingType::Uniform,
    // rust: has_dynamic_offset: false,
    // rust: min_binding_size: None,
    // rust: },
    // rust: count: None,
    // rust: },
    // rust: ];
    // rust: entries.extend(block_light_entries);
    // rust: entries.extend(pack_texture_entries(textures.len()));
    // rust: let layout = device.create_bind_group_layout(&wgpu::BindGroupLayoutDescriptor {
    // rust: label: Some("Native shader pack frame"),
    // rust: entries: &entries,
    // rust: });
    // rust: let surface = surface_target(device, [1, 1]);
    // rust: let surface_view = surface.create_view(&Default::default());
    // rust: let opaque_depth = depth_copy(device, [1, 1]);
    // rust: let opaque_color = color_copy(device, [1, 1], wgpu::TextureFormat::Rgba8Unorm);
    // rust: let blank = copy_target(
    // rust: device,
    // rust: "Native shader pack reflection blank",
    // rust: [1, 1],
    // rust: wgpu::TextureFormat::Rgba8Unorm,
    // rust: )
    // rust: .create_view(&Default::default());
    // rust: let reflection_sampler = device.create_sampler(&wgpu::SamplerDescriptor {
    // rust: label: Some("Native shader pack reflection sampler"),
    // rust: mag_filter: wgpu::FilterMode::Linear,
    // rust: min_filter: wgpu::FilterMode::Linear,
    // rust: ..Default::default()
    // rust: });
    // rust: let shadow_map = super::native_shadow::ShadowMap::new(device, shadow);
    // rust: let block_light = super::block_light::BlockLight::new(device, lights);
    // rust: let array_view = |texture: &wgpu::Texture| {
    // rust: texture.create_view(&wgpu::TextureViewDescriptor {
    // rust: dimension: Some(wgpu::TextureViewDimension::D2Array),
    // rust: ..Default::default()
    // rust: })
}
    // rust: let pbr = match pbr {
    // rust: Some(maps) => maps.each_ref().map(array_view),
    // rust: None => {
                // Two layers: one would make a 2D texture on the OpenGL backend.
    // rust: let blank = device.create_texture(&wgpu::TextureDescriptor {
    // rust: label: Some("Native shader pack LabPBR (none)"),
    // rust: size: wgpu::Extent3d {
    // rust: width: 1,
    // rust: height: 1,
    // rust: depth_or_array_layers: 2,
    // rust: },
    // rust: mip_level_count: 1,
    // rust: sample_count: 1,
    // rust: dimension: wgpu::TextureDimension::D2,
    // rust: format: wgpu::TextureFormat::Rgba8Unorm,
    // rust: usage: wgpu::TextureUsages::TEXTURE_BINDING,
    // rust: view_formats: &[],
    // rust: });
    // rust: [array_view(&blank), array_view(&blank)]
}
}
    // rust: let group = Self::group(
    // rust: device,
    // rust: &layout,
    // rust: &buffer,
    // rust: (&blank, &reflection_sampler),
    // rust: &shadow_map,
    // rust: (&opaque_depth, &opaque_color),
    // rust: &textures,
    // rust: &block_light,
    // rust: &pbr,
    // rust: );
    // rust: Self {
    // rust: textures,
    // rust: block_light,
    // rust: pbr,
    // rust: buffer,
    // rust: layout,
    // rust: group,
    // rust: surface,
    // rust: surface_view,
    // rust: opaque_depth,
    // rust: opaque_color,
    // rust: reflection: blank.clone(),
    // rust: blank,
    // rust: reflection_sampler,
    // rust: shadow_map,
    // rust: shadow_camera: shadow.map(super::native_shadow::camera),
    // rust: reflects: false,
    // rust: last: None,
    // rust: eye: [f32::NAN; 4],
    // rust: history_reset: true,
    // rust: start: std::time::Instant::now(),
    // rust: frames: 0,
    // rust: wetness: (0.0, None),
}
}

    // What the shadow camera sees this frame, for the renderer's shadow lists.
shadow_view :: proc(self: ^Self, frame: ^Frame) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let camera = self.shadow_camera.as_ref()?;
    // rust: Some(super::pack_post::ShadowView {
    // rust: cull: super::pack_uniforms::shadow_culling(frame, camera),
    // rust: light: super::pack_uniforms::shadow_light(frame, camera),
            // The light's box culls: on the ground it reaches further than `distance` along
            // the sun's azimuth while the sun is low.
    // rust: distance: None,
    // rust: unculled: None,
    // rust: every_face: false,
    // rust: view_casters: false,
    // rust: depth_planes: true,
    // rust: })
}

    // rust: fn group(
    // rust: device: &wgpu::Device,
    // rust: layout: &wgpu::BindGroupLayout,
    // rust: buffer: &wgpu::Buffer,
    // rust: (reflection, sampler): (&wgpu::TextureView, &wgpu::Sampler),
    // rust: shadow: &super::native_shadow::ShadowMap,
    // rust: (opaque_depth, opaque_color): (&wgpu::Texture, &wgpu::Texture),
    // rust: textures: &[(wgpu::TextureView, wgpu::Sampler)],
    // rust: block_light: &super::block_light::BlockLight,
    // rust: pbr: &[wgpu::TextureView; 2],
    // rust: ) -> wgpu::BindGroup {
    // rust: let opaque_depth = opaque_depth.create_view(&Default::default());
    // rust: let opaque_color = opaque_color.create_view(&Default::default());
    // rust: let mut entries = vec![
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 0,
    // rust: resource: buffer.as_entire_binding(),
    // rust: },
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 1,
    // rust: resource: wgpu::BindingResource::TextureView(reflection),
    // rust: },
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 2,
    // rust: resource: wgpu::BindingResource::Sampler(sampler),
    // rust: },
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 3,
    // rust: resource: wgpu::BindingResource::TextureView(&shadow.view),
    // rust: },
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 4,
    // rust: resource: wgpu::BindingResource::Sampler(&shadow.sampler),
    // rust: },
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 7,
    // rust: resource: wgpu::BindingResource::TextureView(&shadow.translucent_view),
    // rust: },
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 8,
    // rust: resource: wgpu::BindingResource::TextureView(&shadow.color_view),
    // rust: },
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 6,
    // rust: resource: wgpu::BindingResource::TextureView(&opaque_depth),
    // rust: },
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 11,
    // rust: resource: wgpu::BindingResource::TextureView(&opaque_color),
    // rust: },
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 12,
    // rust: resource: wgpu::BindingResource::TextureView(&pbr[0]),
    // rust: },
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 13,
    // rust: resource: wgpu::BindingResource::TextureView(&pbr[1]),
    // rust: },
    // rust: ];
    // rust: entries.extend([
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 9,
    // rust: resource: wgpu::BindingResource::TextureView(&block_light.view),
    // rust: },
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 10,
    // rust: resource: block_light.grid.as_entire_binding(),
    // rust: },
    // rust: ]);
    // rust: entries.extend(pack_texture_group_entries(textures));
    // rust: device.create_bind_group(&wgpu::BindGroupDescriptor {
    // rust: label: Some("Native shader pack frame"),
    // rust: layout,
    // rust: entries: &entries,
    // rust: })
}

    // Keeps the opaque copies the size of the world's depth `depth` and, where the world's
    // colour `color` can be copied (the scaled target, not the window's own), its size and
    // format; the group is made again when they change.
    // rust: pub fn fit_opaque(
    // rust: &mut self,
    // rust: device: &wgpu::Device,
    // rust: depth: &wgpu::Texture,
    // rust: color: Option<&wgpu::Texture>,
    // rust: ) {
    // rust: let size = [depth.width(), depth.height()];
    // rust: let (color_size, format) = match color {
    // rust: Some(c) => ([c.width(), c.height()], c.format()),
    // rust: None => ([1, 1], self.opaque_color.format()),
}
    // rust: let color_fits = [self.opaque_color.width(), self.opaque_color.height()] == color_size
    // rust: && self.opaque_color.format() == format;
    // rust: let depth_fits = [self.opaque_depth.width(), self.opaque_depth.height()] == size;
    // rust: if depth_fits && color_fits {
    // rust: return;
}
    // rust: if !color_fits {
    // rust: self.opaque_color = color_copy(device, color_size, format);
}
    // rust: if !depth_fits {
    // rust: self.opaque_depth = depth_copy(device, size);
}
    // rust: self.regroup(device);
}

    // Sizes the surface target: the world's while a material stage writes it, else a blank.
fit_surface :: proc(self: ^Self, device: ^wgpu::Device, size: [u32; 2]) {
}
    // rust: if [self.surface.width(), self.surface.height()] != size {
    // rust: self.surface = surface_target(device, size);
    // rust: self.surface_view = self.surface.create_view(&Default::default());
}
}

    // Binds `view` as this frame's `reflection` (`None`: the blank). The mirror is drawn
    // before the stages read it.
set_reflection :: proc(self: ^Self, device: ^wgpu::Device, view: Maybe(^wgpu::TextureView)) {
}
    // rust: let view = view.unwrap_or(&self.blank);
    // rust: if *view != self.reflection {
    // rust: self.reflection = view.clone();
    // rust: self.regroup(device);
}
}

regroup :: proc(self: ^Self, device: ^wgpu::Device) {
}
    // rust: self.group = Self::group(
    // rust: device,
    // rust: &self.layout,
    // rust: &self.buffer,
    // rust: (&self.reflection, &self.reflection_sampler),
    // rust: &self.shadow_map,
    // rust: (&self.opaque_depth, &self.opaque_color),
    // rust: &self.textures,
    // rust: &self.block_light,
    // rust: &self.pbr,
    // rust: );
}

    // Writes this frame's inputs, for a world of `size`.
write :: proc(self: ^Self, queue: ^wgpu::Queue, frame: ^Frame, size: [u32; 2]) {
}
        // Under `HORIZON_STILL` the world's ticks are the clock (`PackInputs::still_ticks`), and
        // eased values sit at their targets.
    // rust: let still = frame.pack.still_ticks;
    // rust: let seconds = still.map_or_else(
    // rust: || self.start.elapsed().as_secs_f32() % 3600.0,
    // rust: |ticks| (ticks as f32 / 20.0) % 3600.0,
    // rust: );
    // rust: let now = std::time::Instant::now();
    // rust: let since = match still {
    // rust: Some(_) => f32::INFINITY,
    // rust: None => self.wetness.1.map_or(0.0, |t| (now - t).as_secs_f32()),
}
    // rust: self.wetness = (wetness(self.wetness.0, frame.pack.rain, since), Some(now));
    // rust: let mut inputs = frame_inputs(
    // rust: frame,
    // rust: size,
    // rust: seconds,
    // rust: still.map_or(self.frames, |ticks| ticks as u32),
    // rust: self.shadow_camera.as_ref(),
    // rust: );
    // rust: inputs.wetness = self.wetness.0;
    // rust: if !self.reflects {
    // rust: inputs.has_reflection = 0;
}
    // rust: let view_proj = (Mat4::from_cols_array_2d(&inputs.projection)
    // rust: * Mat4::from_cols_array_2d(&inputs.view))
    // rust: .to_cols_array_2d();
    // rust: inputs.previous_view_projection = view_proj;
        // `write` skips title frames, so a gap means a pause or another world: the frame
        // before says nothing about this one, and the eased values start over.
    // rust: match self.last {
    // rust: Some((previous, camera, time)) if (now - time).as_secs_f32() < MAX_FRAME_GAP => {
    // rust: inputs.previous_view_projection = previous;
    // rust: inputs.camera_motion = (frame.camera - camera).as_vec3().to_array();
    // rust: inputs.delta_time = (now - time).as_secs_f32();
}
    // rust: _ => {
    // rust: self.eye = [f32::NAN; 4];
    // rust: self.history_reset = true;
}
}
    // rust: self.last = Some((view_proj, frame.camera, now));
        // The eye's light and medium eased by half-lives in seconds, from where they are at
        // first.
    // rust: let targets = [
    // rust: (inputs.eye_light[0], 2.0),
    // rust: (inputs.eye_light[1], 2.0),
    // rust: (f32::from(u8::from(inputs.eye_in == 1)), 0.25),
    // rust: (f32::from(u8::from(inputs.eye_in == 2)), 0.25),
    // rust: ];
    // rust: let dt = match still {
    // rust: Some(_) => {
    // rust: inputs.delta_time = 0.05;
    // rust: f32::INFINITY
}
    // rust: None => inputs.delta_time,
}
    // rust: for (value, (target, half_life)) in self.eye.iter_mut().zip(targets) {
    // rust: *value = eased(*value, target, half_life, dt);
}
    // rust: let [block, sky, water, lava] = self.eye;
    // rust: inputs.eye_light_smooth = [block, sky];
    // rust: inputs.in_water = water;
    // rust: inputs.in_lava = lava;
    // rust: self.frames = self.frames.wrapping_add(1);
    // rust: queue.write_buffer(&self.buffer, 0, bytemuck::bytes_of(&inputs));
}

    // Takes the post stage's pending history reset. It stays pending if post rendering is
    // skipped for a frame, so the first frame it does render still sees black history.
    // rust: pub(super) fn take_history_reset(&mut self) -> bool {
    // rust: let reset = self.history_reset;
    // rust: self.history_reset = false;
    // rust: reset
}
}

// The option values of `constants` that `module` declares as overrides (wgpu refuses others).
    // rust: pub fn present_constants<'a>(
    // rust: module: &naga::Module,
    // rust: constants: &'a [(String, f64)],
    // rust: ) -> Vec<(&'a str, f64)> {
    // rust: constants
    // rust: .iter()
    // rust: .filter(|(id, _)| {
    // rust: module
    // rust: .overrides
    // rust: .iter()
    // rust: .any(|(_, o)| o.name.as_ref() == Some(id))
    // rust: })
    // rust: .map(|(id, v)| (id.as_str(), *v))
    // rust: .collect()
}

// The solid terrain's surface target of `size`, drawn and read.
surface_target :: proc(device: ^wgpu::Device, size: [u32; 2]) -> w {
    // Ported from Horizon
    return {}
}
    // rust: device.create_texture(&wgpu::TextureDescriptor {
    // rust: label: Some("Native shader pack surface"),
    // rust: size: wgpu::Extent3d {
    // rust: width: size[0],
    // rust: height: size[1],
    // rust: depth_or_array_layers: 1,
    // rust: },
    // rust: mip_level_count: 1,
    // rust: sample_count: 1,
    // rust: dimension: wgpu::TextureDimension::D2,
    // rust: format: super::native_material::SURFACE_FORMAT,
    // rust: usage: wgpu::TextureUsages::RENDER_ATTACHMENT | wgpu::TextureUsages::TEXTURE_BINDING,
    // rust: view_formats: &[],
    // rust: })
}

texture_entry :: proc(binding: u32, sample_type: wgpu::TextureSampleType) -> w {
    // Ported from Horizon
    return {}
}
    // rust: wgpu::BindGroupLayoutEntry {
    // rust: binding,
    // rust: visibility: wgpu::ShaderStages::FRAGMENT,
    // rust: ty: wgpu::BindingType::Texture {
    // rust: sample_type,
    // rust: view_dimension: wgpu::TextureViewDimension::D2,
    // rust: multisampled: false,
    // rust: },
    // rust: count: None,
}
}

// A LabPBR map's array, read by the material entries (`native_material.rs`).
pbr_entry :: proc(binding: u32) -> w {
    // Ported from Horizon
    return {}
}
    // rust: wgpu::BindGroupLayoutEntry {
    // rust: binding,
        // `[displacement]`'s grid moves its corners by the heights (gfx/displace.rs).
    // rust: visibility: wgpu::ShaderStages::VERTEX_FRAGMENT,
    // rust: ty: wgpu::BindingType::Texture {
    // rust: sample_type: wgpu::TextureSampleType::Float { filterable: true },
    // rust: view_dimension: wgpu::TextureViewDimension::D2Array,
    // rust: multisampled: false,
    // rust: },
    // rust: count: None,
}
}

comparison_entry :: proc(binding: u32) -> w {
    // Ported from Horizon
    return {}
}
    // rust: wgpu::BindGroupLayoutEntry {
    // rust: binding,
    // rust: visibility: wgpu::ShaderStages::FRAGMENT,
    // rust: ty: wgpu::BindingType::Sampler(wgpu::SamplerBindingType::Comparison),
    // rust: count: None,
}
}

sampler_entry :: proc(binding: u32) -> w {
    // Ported from Horizon
    return {}
}
    // rust: wgpu::BindGroupLayoutEntry {
    // rust: binding,
    // rust: visibility: wgpu::ShaderStages::FRAGMENT,
    // rust: ty: wgpu::BindingType::Sampler(wgpu::SamplerBindingType::Filtering),
    // rust: count: None,
}
}

    // rust: impl NativePost {
    // Pipelines for `stages` (the pack's post passes, in order) with the option values
    // `constants`, drawing onto a screen of `format`. Errors name the pass wgpu refused.
    // rust: pub fn new(
    // rust: device: &wgpu::Device,
    // rust: stages: Vec<CheckedStage>,
    // rust: manifest: &horizon_shader_api::Manifest,
    // rust: constants: &[(String, f64)],
    // rust: format: wgpu::TextureFormat,
    // rust: frame: &NativeFrame,
    // rust: ) -> Result<Self, String> {
    // rust: let targets = manifest.post_targets();
    // rust: let outputs: Vec<Option<usize>> = manifest
    // rust: .post
    // rust: .iter()
    // rust: .map(|p| {
    // rust: let name = p.output.as_deref()?;
    // rust: targets.iter().position(|t| t.0 == name)
    // rust: })
    // rust: .collect();
    // rust: let plan = plan(&outputs);
    // rust: let float = wgpu::TextureSampleType::Float { filterable: true };
    // rust: let mut entries = vec![
    // rust: frame_entry(wgpu::ShaderStages::FRAGMENT),
    // rust: texture_entry(1, float),
    // rust: texture_entry(2, wgpu::TextureSampleType::Depth),
    // rust: texture_entry(3, float),
    // rust: sampler_entry(4),
    // rust: sampler_entry(5),
    // rust: texture_entry(6, wgpu::TextureSampleType::Depth),
    // rust: comparison_entry(7),
    // rust: texture_entry(8, float),
    // rust: texture_entry(9, wgpu::TextureSampleType::Depth),
    // rust: texture_entry(10, float),
    // rust: texture_entry(11, wgpu::TextureSampleType::Uint),
    // rust: ];
    // rust: entries.extend(pack_texture_entries(frame.textures.len()));
    // rust: entries
    // rust: .extend((0..targets.len() as u32).map(|j| {
    // rust: texture_entry(horizon_shader_api::stages::POST_TARGET_BINDING + j, float)
    // rust: }));
    // rust: let layout = device.create_bind_group_layout(&wgpu::BindGroupLayoutDescriptor {
    // rust: label: Some("Native shader pack post"),
    // rust: entries: &entries,
    // rust: });
    // rust: let mut groups: [Option<&wgpu::BindGroupLayout>; GROUP as usize + 1] = Default::default();
    // rust: groups[GROUP as usize] = Some(&layout);
    // rust: let pipeline_layout = device.create_pipeline_layout(&wgpu::PipelineLayoutDescriptor {
    // rust: label: Some("Native shader pack post"),
    // rust: bind_group_layouts: &groups,
    // rust: ..Default::default()
    // rust: });
    // rust: let count = stages.len();
    // rust: let mut passes = Vec::with_capacity(count);
    // rust: for (i, stage) in stages.into_iter().enumerate() {
    // rust: let present = present_constants(&stage.module, constants);
    // rust: let scope = device.push_error_scope(wgpu::ErrorFilter::Validation);
    // rust: let module = device.create_shader_module(wgpu::ShaderModuleDescriptor {
    // rust: label: Some(&stage.label),
    // rust: source: wgpu::ShaderSource::Naga(std::borrow::Cow::Owned(stage.module)),
    // rust: });
    // rust: let options = wgpu::PipelineCompilationOptions {
    // rust: constants: &present,
    // rust: ..Default::default()
}
    // rust: let pipeline = device.create_render_pipeline(&wgpu::RenderPipelineDescriptor {
    // rust: label: Some(&stage.label),
    // rust: layout: Some(&pipeline_layout),
    // rust: vertex: wgpu::VertexState {
    // rust: module: &module,
    // rust: entry_point: Some("horizon_vs_post"),
    // rust: compilation_options: options.clone(),
    // rust: buffers: &[],
    // rust: },
    // rust: primitive: Default::default(),
    // rust: depth_stencil: None,
    // rust: multisample: Default::default(),
    // rust: fragment: Some(wgpu::FragmentState {
    // rust: module: &module,
    // rust: entry_point: Some("horizon_fs_post"),
    // rust: compilation_options: options,
    // rust: targets: &[Some(wgpu::ColorTargetState {
    // rust: format: if plan[i].writes == Writes::Screen {
    // rust: format
    // rust: } else {
    // rust: INTERMEDIATE
    // rust: },
    // rust: blend: None,
    // rust: write_mask: wgpu::ColorWrites::ALL,
    // rust: })],
    // rust: }),
    // rust: multiview_mask: None,
    // rust: cache: None,
    // rust: });
    // rust: if let Some(e) = pollster::block_on(scope.pop()) {
    // rust: return Err(format!("{}: {e}", stage.file));
}
    // rust: passes.push((stage.label, pipeline));
}
    // rust: let sampler = |label, filter| {
    // rust: device.create_sampler(&wgpu::SamplerDescriptor {
    // rust: label: Some(label),
    // rust: mag_filter: filter,
    // rust: min_filter: filter,
    // rust: ..Default::default()
    // rust: })
}
    // rust: Ok(Self {
    // rust: passes,
    // rust: layout,
    // rust: textures: frame.textures.clone(),
    // rust: frame: frame.buffer.clone(),
    // rust: shadow: (
    // rust: frame.shadow_map.view.clone(),
    // rust: frame.shadow_map.sampler.clone(),
    // rust: frame.shadow_map.translucent_view.clone(),
    // rust: frame.shadow_map.color_view.clone(),
    // rust: ),
    // rust: linear: sampler("Native shader pack linear", wgpu::FilterMode::Linear),
    // rust: nearest: sampler("Native shader pack nearest", wgpu::FilterMode::Nearest),
    // rust: targets: None,
    // rust: history: None,
    // rust: history_blank: history_target(device, "Native shader pack history blank", [1, 1]),
    // rust: groups: None,
    // rust: history_valid: false,
    // rust: scales: targets.iter().map(|t| t.1).collect(),
    // rust: named: None,
    // rust: plan,
    // rust: format,
    // rust: })
}

    // The passes' labels, in order.
labels :: proc(self: ^Self) -> V {
    // Ported from Horizon
    return {}
}
    // rust: self.passes.iter().map(|(l, _)| l.as_str()).collect()
}

    // rust: fn prepare(
    // rust: &mut self,
    // rust: device: &wgpu::Device,
    // rust: world: (&wgpu::TextureView, &wgpu::TextureView, &wgpu::TextureView),
    // rust: size: [u32; 2],
    // rust: history_reset: bool,
    // rust: ) {
    // rust: if !self.scales.is_empty() && self.named.as_ref().is_none_or(|n| n.0 != size) {
    // rust: let views = self
    // rust: .scales
    // rust: .iter()
    // rust: .map(|&scale| {
    // rust: let size = scaled(size, scale);
    // rust: device
    // rust: .create_texture(&wgpu::TextureDescriptor {
    // rust: label: Some("Native shader pack target"),
    // rust: size: wgpu::Extent3d {
    // rust: width: size[0],
    // rust: height: size[1],
    // rust: depth_or_array_layers: 1,
    // rust: },
    // rust: mip_level_count: 1,
    // rust: sample_count: 1,
    // rust: dimension: wgpu::TextureDimension::D2,
    // rust: format: INTERMEDIATE,
    // rust: usage: wgpu::TextureUsages::RENDER_ATTACHMENT
    // rust: | wgpu::TextureUsages::TEXTURE_BINDING,
    // rust: view_formats: &[],
    // rust: })
    // rust: .create_view(&Default::default())
    // rust: })
    // rust: .collect();
    // rust: self.named = Some((size, views));
    // rust: self.groups = None;
}
    // rust: let chain = self
    // rust: .plan
    // rust: .iter()
    // rust: .any(|p| matches!(p.writes, Writes::Chain(_)));
    // rust: if chain && self.targets.as_ref().is_none_or(|t| t.0 != size) {
    // rust: let target = |label| {
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
    // rust: format: INTERMEDIATE,
                        // COPY_SRC: the last pass's input is kept as next frame's `history`.
    // rust: usage: wgpu::TextureUsages::RENDER_ATTACHMENT
    // rust: | wgpu::TextureUsages::TEXTURE_BINDING
    // rust: | wgpu::TextureUsages::COPY_SRC,
    // rust: view_formats: &[],
    // rust: })
    // rust: .create_view(&Default::default())
}
    // rust: self.targets = Some((
    // rust: size,
    // rust: [
    // rust: target("Native shader pack A"),
    // rust: target("Native shader pack B"),
    // rust: ],
    // rust: ));
    // rust: self.history = Some(history_target(device, "Native shader pack history", size));
    // rust: self.history_valid = false;
    // rust: self.groups = None;
}
    // rust: let blank_history = history_reset || !self.history_valid;
    // rust: if self
    // rust: .groups
    // rust: .as_ref()
    // rust: .is_some_and(|((color, depth, surface), blank, _)| {
    // rust: color == world.0
    // rust: && depth == world.1
    // rust: && surface == world.2
    // rust: && *blank == blank_history
    // rust: })
    // rust: {
    // rust: return;
}
    // rust: let history = if blank_history {
    // rust: &self.history_blank
    // rust: } else {
    // rust: self.history
    // rust: .as_ref()
    // rust: .expect("history exists after a post stage has more than one pass")
}
    // rust: .create_view(&Default::default());
    // rust: let blank = self.history_blank.create_view(&Default::default());
    // rust: let groups = (0..self.passes.len())
    // rust: .map(|i| {
                // The chain's picture so far: the world's before its first pass.
    // rust: let previous = match (&self.targets, self.plan[i].reads) {
    // rust: (Some((_, t)), Some(slot)) => &t[slot],
    // rust: _ => world.0,
}
    // rust: let mut entries = vec![
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 0,
    // rust: resource: self.frame.as_entire_binding(),
    // rust: },
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 1,
    // rust: resource: wgpu::BindingResource::TextureView(world.0),
    // rust: },
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 2,
    // rust: resource: wgpu::BindingResource::TextureView(world.1),
    // rust: },
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 3,
    // rust: resource: wgpu::BindingResource::TextureView(previous),
    // rust: },
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 4,
    // rust: resource: wgpu::BindingResource::Sampler(&self.linear),
    // rust: },
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 5,
    // rust: resource: wgpu::BindingResource::Sampler(&self.nearest),
    // rust: },
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 6,
    // rust: resource: wgpu::BindingResource::TextureView(&self.shadow.0),
    // rust: },
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 7,
    // rust: resource: wgpu::BindingResource::Sampler(&self.shadow.1),
    // rust: },
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 8,
    // rust: resource: wgpu::BindingResource::TextureView(&history),
    // rust: },
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 9,
    // rust: resource: wgpu::BindingResource::TextureView(&self.shadow.2),
    // rust: },
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 11,
    // rust: resource: wgpu::BindingResource::TextureView(world.2),
    // rust: },
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 10,
    // rust: resource: wgpu::BindingResource::TextureView(&self.shadow.3),
    // rust: },
    // rust: ];
    // rust: entries.extend(pack_texture_group_entries(&self.textures));
                // The pack's targets, a blank one in place of the one this pass writes.
    // rust: if let Some((_, views)) = &self.named {
    // rust: entries.extend(views.iter().enumerate().map(|(j, view)| {
    // rust: let view = if self.plan[i].writes == Writes::Target(j) {
    // rust: &blank
    // rust: } else {
    // rust: view
}
    // rust: wgpu::BindGroupEntry {
    // rust: binding: horizon_shader_api::stages::POST_TARGET_BINDING + j as u32,
    // rust: resource: wgpu::BindingResource::TextureView(view),
}
    // rust: }));
}
    // rust: device.create_bind_group(&wgpu::BindGroupDescriptor {
    // rust: label: Some("Native shader pack post"),
    // rust: layout: &self.layout,
    // rust: entries: &entries,
    // rust: })
    // rust: })
    // rust: .collect();
    // rust: self.groups = Some((
    // rust: (world.0.clone(), world.1.clone(), world.2.clone()),
    // rust: blank_history,
    // rust: groups,
    // rust: ));
}

    // Runs the passes over the world target `world` (colour, depth) of `size`, the last onto
    // `screen`, timed by `timing` when it times this frame.
    // rust: pub fn run(
    // rust: &mut self,
    // rust: device: &wgpu::Device,
    // rust: encoder: &mut wgpu::CommandEncoder,
    // rust: world: (&wgpu::TextureView, &wgpu::TextureView, &wgpu::TextureView),
    // rust: screen: &wgpu::TextureView,
    // rust: size: [u32; 2],
    // rust: history_reset: bool,
    // rust: mut timing: Option<&mut super::pack_timing::PassTiming>,
    // rust: ) {
    // rust: self.prepare(device, world, size, history_reset);
    // rust: if let Some(t) = timing.as_deref_mut() {
    // rust: t.mark(device, encoder, (world.0, self.format));
}
    // rust: let Some((_, _, groups)) = &self.groups else {
    // rust: return;
}
    // rust: for (i, ((label, pipeline), group)) in self.passes.iter().zip(groups).enumerate() {
    // rust: let view = match (self.plan[i].writes, &self.targets, &self.named) {
    // rust: (Writes::Chain(slot), Some((_, t)), _) => &t[slot],
    // rust: (Writes::Target(j), _, Some((_, n))) => &n[j],
    // rust: _ => screen,
}
    // rust: let attachments = [Some(wgpu::RenderPassColorAttachment {
    // rust: view,
    // rust: resolve_target: None,
    // rust: depth_slice: None,
    // rust: ops: wgpu::Operations {
    // rust: load: wgpu::LoadOp::Clear(wgpu::Color::BLACK),
    // rust: store: wgpu::StoreOp::Store,
    // rust: },
    // rust: })];
    // rust: let mut pass = encoder.begin_render_pass(&wgpu::RenderPassDescriptor {
    // rust: label: Some(label),
    // rust: color_attachments: &attachments,
    // rust: timestamp_writes: timing.as_deref_mut().and_then(|t| t.writes(label)),
    // rust: ..Default::default()
    // rust: });
    // rust: pass.set_pipeline(pipeline);
    // rust: pass.set_bind_group(GROUP, group, &[]);
    // rust: pass.draw(0..3, 0..1);
}
        // The chain's last picture becomes next frame's `history`, once every pass has read
        // this frame's.
    // rust: let before_last = &self.plan[..self.plan.len() - 1];
    // rust: if let Some(Writes::Chain(slot)) = before_last
    // rust: .iter()
    // rust: .rfind(|p| matches!(p.writes, Writes::Chain(_)))
    // rust: .map(|p| p.writes)
    // rust: && let (Some(history), Some((_, targets))) = (&self.history, &self.targets)
    // rust: {
    // rust: encoder.copy_texture_to_texture(
    // rust: targets[slot].texture().as_image_copy(),
    // rust: history.as_image_copy(),
    // rust: history.size(),
    // rust: );
    // rust: self.history_valid = true;
}
}
}

// A target of `size` the post stage's `history` is copied into.
history_target :: proc(device: ^wgpu::Device, label: string, size: [u32; 2]) -> w {
    // Ported from Horizon
    return {}
}
    // rust: device.create_texture(&wgpu::TextureDescriptor {
    // rust: label: Some(label),
    // rust: size: wgpu::Extent3d {
    // rust: width: size[0].max(1),
    // rust: height: size[1].max(1),
    // rust: depth_or_array_layers: 1,
    // rust: },
    // rust: mip_level_count: 1,
    // rust: sample_count: 1,
    // rust: dimension: wgpu::TextureDimension::D2,
    // rust: format: INTERMEDIATE,
    // rust: usage: wgpu::TextureUsages::TEXTURE_BINDING | wgpu::TextureUsages::COPY_DST,
    // rust: view_formats: &[],
    // rust: })
}

// `wetness` after `dt` seconds of `rain`: halfway there in 30 seconds while it rains
// harder, in 10 while it dries (the half-lives of the `shaders/` format's `wetness`).
wetness :: proc(wetness: f32, rain: f32, dt: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let half_life = if rain > wetness { 30.0 } else { 10.0 };
    // rust: rain + (wetness - rain) * 0.5f32.powf(dt / half_life)
}

// The frame as packs read it (docs/api/shaders-reference.md), from the renderer's `Frame`.
    // rust: pub fn frame_inputs(
    // rust: frame: &Frame,
    // rust: size: [u32; 2],
    // rust: seconds: f32,
    // rust: index: u32,
    // rust: shadow: Option<&horizon_shaders::Shadow>,
    // rust: ) -> FrameInputs {
    // rust: let aspect = size[0] as f32 / size[1].max(1) as f32;
    // rust: let view = crate::camera::view_matrix(frame.yaw, frame.pitch);
    // rust: let projection = super::world_projection(frame.fov_degrees, aspect, frame.depth_far)
    // rust: * frame.bob
    // rust: * frame.spin;
    // A celestial body's direction at `angle` degrees (SkyRenderer: Y -90°, then X by the
    // angle, of straight up): overhead at 0, rising in the east (+x).
    // rust: let body = |angle: f32| {
    // rust: let a = angle.to_radians();
    // rust: Vec3::new(-a.sin(), a.cos(), 0.0)
}
    // rust: let (fog_color, fog_start, fog_end) = match &frame.fog {
    // rust: Some(f) => (
    // rust: [f.color[0], f.color[1], f.color[2]],
    // rust: f.environmental_start.min(f.render_distance_start),
    // rust: f.environmental_end.min(f.render_distance_end),
    // rust: ),
    // rust: None => (frame.sky.fog_color, frame.distance * 0.9, frame.distance),
}
    // rust: let pack = &frame.pack;
    // rust: let level = |l: i32| l as f32 / 15.0;
    // rust: let m = |m: Mat4| m.to_cols_array_2d();
    // rust: FrameInputs {
    // rust: view: m(view),
    // rust: projection: m(projection),
    // rust: view_inverse: m(view.inverse()),
    // rust: projection_inverse: m(projection.inverse()),
    // rust: camera_position: frame.camera.as_vec3().to_array(),
    // rust: time: seconds,
    // rust: sun_direction: body(frame.sky.sun_angle).to_array(),
    // rust: day_time: pack.day_time.rem_euclid(24000) as f32 / 24000.0,
    // rust: moon_direction: body(frame.sky.moon_angle).to_array(),
    // rust: game_time: frame.shader_game_time,
    // rust: sky_color: frame.sky.sky_color,
    // rust: rain: pack.rain,
    // rust: fog_color,
    // rust: thunder: pack.thunder,
    // rust: resolution: [size[0] as f32, size[1] as f32],
    // rust: eye_light: [level(pack.eye_light[0]), level(pack.eye_light[1])],
    // rust: fog_start,
    // rust: fog_end,
    // rust: render_distance: frame.distance,
    // rust: far: frame.depth_far,
    // rust: night_vision: frame.night_vision,
    // rust: blindness: pack.blindness,
    // rust: darkness: frame.darkness.1.clamp(0.0, 1.0),
    // rust: brightness: pack.brightness,
    // rust: eye_in: pack.eye_in as u32,
    // rust: dimension: if frame.end_sky {
    // rust: 1
    // rust: } else if frame.nether_lighting {
    // rust: -1
    // rust: } else {
    // rust: 0
    // rust: },
    // rust: frame_index: index,
    // rust: hide_gui: u32::from(pack.hide_gui),
    // rust: precipitation: pack.biome_precipitation.clamp(0, 2) as u32,
    // rust: temperature: pack.temperature,
    // rust: downfall: pack.rainfall,
    // rust: wetness: pack.rain,
        // Filled by `NativeFrame::write`, which remembers the frames before.
    // rust: previous_view_projection: m(Mat4::IDENTITY),
    // rust: camera_motion: [0.0; 3],
    // rust: delta_time: 0.0,
    // rust: eye_light_smooth: [level(pack.eye_light[0]), level(pack.eye_light[1])],
    // rust: in_water: f32::from(u8::from(pack.eye_in as u32 == 1)),
    // rust: in_lava: f32::from(u8::from(pack.eye_in as u32 == 2)),
    // rust: water_plane: frame.water_plane.unwrap_or(0.0),
    // rust: has_reflection: u32::from(frame.water_plane.is_some()),
    // rust: reflection_resolution: reflection_size(size).map(|s| s as f32),
    // rust: mods: pack.mod_params,
    // rust: light_direction: match shadow {
    // rust: Some(s) => super::pack_uniforms::shadow_light(frame, s),
    // rust: None => Vec3::Y,
}
    // rust: .to_array(),
    // rust: has_shadow: u32::from(shadow.is_some()),
    // rust: shadow_view_proj: m(shadow.map_or(Mat4::IDENTITY, |s| {
    // rust: super::pack_uniforms::shadow_culling(frame, s)
    // rust: })),
    // rust: shadow_distance: shadow.map_or(0.0, |s| s.distance),
    // rust: shadow_distortion: shadow.map_or(0.0, |s| {
    // rust: super::native_shadow::distortion(s.distance, s.resolution)
    // rust: }),
    // rust: shadow_resolution: shadow.map_or(0.0, |s| s.resolution as f32),
    // rust: shadow_center_texel: shadow.map_or(0.0, |s| {
    // rust: let k = super::native_shadow::distortion(s.distance, s.resolution);
    // rust: 2.0 * s.distance / s.resolution.max(1) as f32 * (1.0 - k)
    // rust: }),
        // Shader API 0.2's display fields, which 0.1 packs don't declare: SDR's values, also
        // with HDR on, until HDR output is served for 0.2 packs.
    // rust: hdr: 0,
    // rust: headroom: 1.0,
    // rust: paper_white: 80.0,
    // rust: peak: 80.0,
    // rust: black_level: 0.0,
    // rust: padding: [0; 3],
}
}

// The pack's `[[textures]]` (`check::Image`s), uploaded with samplers as the manifest says.
    // rust: pub fn pack_textures(
    // rust: device: &wgpu::Device,
    // rust: queue: &wgpu::Queue,
    // rust: report: &horizon_shader_api::Report,
    // rust: ) -> Vec<(wgpu::TextureView, wgpu::Sampler)> {
    // rust: report
    // rust: .textures
    // rust: .iter()
    // rust: .map(|(t, image)| {
    // rust: let texture = wgpu::util::DeviceExt::create_texture_with_data(
    // rust: device,
    // rust: queue,
    // rust: &wgpu::TextureDescriptor {
    // rust: label: Some(&t.id),
    // rust: size: wgpu::Extent3d {
    // rust: width: image.width,
    // rust: height: image.height,
    // rust: depth_or_array_layers: 1,
    // rust: },
    // rust: mip_level_count: 1,
    // rust: sample_count: 1,
    // rust: dimension: wgpu::TextureDimension::D2,
    // rust: format: wgpu::TextureFormat::Rgba8Unorm,
    // rust: usage: wgpu::TextureUsages::TEXTURE_BINDING,
    // rust: view_formats: &[],
    // rust: },
    // rust: wgpu::util::TextureDataOrder::LayerMajor,
    // rust: &image.rgba,
    // rust: );
    // rust: let filter = if t.linear {
    // rust: wgpu::FilterMode::Linear
    // rust: } else {
    // rust: wgpu::FilterMode::Nearest
}
    // rust: let address = if t.repeat {
    // rust: wgpu::AddressMode::Repeat
    // rust: } else {
    // rust: wgpu::AddressMode::ClampToEdge
}
    // rust: let sampler = device.create_sampler(&wgpu::SamplerDescriptor {
    // rust: label: Some(&t.id),
    // rust: address_mode_u: address,
    // rust: address_mode_v: address,
    // rust: mag_filter: filter,
    // rust: min_filter: filter,
    // rust: ..Default::default()
    // rust: });
    // rust: (texture.create_view(&Default::default()), sampler)
    // rust: })
    // rust: .collect()
}

// Layout entries of `count` pack textures and their samplers.
    // rust: pub(super) fn pack_texture_entries(count: usize) -> Vec<wgpu::BindGroupLayoutEntry> {
//     use horizon_shader_api::stages::{TEXTURE_BINDING, TEXTURE_SAMPLER_BINDING};
    // rust: (0..count as u32)
    // rust: .flat_map(|i| {
    // rust: [
    // rust: wgpu::BindGroupLayoutEntry {
    // rust: binding: TEXTURE_BINDING + i,
    // rust: visibility: wgpu::ShaderStages::VERTEX_FRAGMENT,
    // rust: ty: wgpu::BindingType::Texture {
    // rust: sample_type: wgpu::TextureSampleType::Float { filterable: true },
    // rust: view_dimension: wgpu::TextureViewDimension::D2,
    // rust: multisampled: false,
    // rust: },
    // rust: count: None,
    // rust: },
    // rust: wgpu::BindGroupLayoutEntry {
    // rust: binding: TEXTURE_SAMPLER_BINDING + i,
    // rust: visibility: wgpu::ShaderStages::VERTEX_FRAGMENT,
    // rust: ty: wgpu::BindingType::Sampler(wgpu::SamplerBindingType::Filtering),
    // rust: count: None,
    // rust: },
    // rust: ]
    // rust: })
    // rust: .collect()
}

// Group entries of the pack's textures, as `pack_texture_entries` lays them out.
    // rust: pub(super) fn pack_texture_group_entries(
    // rust: textures: &[(wgpu::TextureView, wgpu::Sampler)],
    // rust: ) -> Vec<wgpu::BindGroupEntry<'_>> {
//     use horizon_shader_api::stages::{TEXTURE_BINDING, TEXTURE_SAMPLER_BINDING};
    // rust: textures
    // rust: .iter()
    // rust: .enumerate()
    // rust: .flat_map(|(i, (view, sampler))| {
    // rust: [
    // rust: wgpu::BindGroupEntry {
    // rust: binding: TEXTURE_BINDING + i as u32,
    // rust: resource: wgpu::BindingResource::TextureView(view),
    // rust: },
    // rust: wgpu::BindGroupEntry {
    // rust: binding: TEXTURE_SAMPLER_BINDING + i as u32,
    // rust: resource: wgpu::BindingResource::Sampler(sampler),
    // rust: },
    // rust: ]
    // rust: })
    // rust: .collect()
}

    // rust: mod tests {
a_pass_with_an_output_leaves_the_chain_as_it_was :: proc() {
}
//         use super::{Writes, plan};
        // Bloom into a target, a pass of the chain, a second target, the picture.
    // rust: let p = plan(&[Some(0), None, Some(1), None, None]);
    // rust: let writes: Vec<_> = p.iter().map(|p| p.writes).collect();
    // rust: assert!(writes[0] == Writes::Target(0));
    // rust: assert!(writes[1] == Writes::Chain(0));
    // rust: assert!(writes[2] == Writes::Target(1));
    // rust: assert!(writes[3] == Writes::Chain(1));
    // rust: assert!(writes[4] == Writes::Screen);
    // rust: let reads: Vec<_> = p.iter().map(|p| p.reads).collect();
    // rust: assert_eq!(reads, [None, None, Some(0), Some(0), Some(1)]);
}
eased_values_start_at_the_target_and_halve_the_distance :: proc() {
}
//         use super::eased;
    // rust: assert_eq!(eased(f32::NAN, 0.25, 2.0, 0.0), 0.25);
    // rust: assert_eq!(eased(1.0, 0.0, 2.0, 2.0), 0.5);
    // rust: assert_eq!(eased(1.0, 0.0, 2.0, 0.0), 1.0);
}
//     use super::*;
//     use horizon_shader_api::{MANIFEST, Pack, check};

wetness_rises_slower_than_it_dries :: proc() {
}
    // rust: assert_eq!(wetness(0.0, 1.0, 30.0), 0.5);
    // rust: assert_eq!(wetness(1.0, 0.0, 10.0), 0.5);
    // rust: assert_eq!(wetness(0.25, 0.25, 5.0), 0.25);
}

device :: proc() -> O {
    // Ported from Horizon
    return {}
}
    // rust: let instance = crate::gfx::test_gpu::instance();
    // rust: let adapter = pollster::block_on(instance.request_adapter(&Default::default())).ok()?;
    // rust: pollster::block_on(adapter.request_device(&Default::default())).ok()
}

    // rust: fn texture(
    // rust: device: &wgpu::Device,
    // rust: format: wgpu::TextureFormat,
    // rust: usage: wgpu::TextureUsages,
    // rust: ) -> wgpu::Texture {
    // rust: device.create_texture(&wgpu::TextureDescriptor {
    // rust: label: None,
    // rust: size: wgpu::Extent3d {
    // rust: width: 4,
    // rust: height: 4,
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

    // Two passes: the first doubles the world's colour (over 1, so the half-float target
    // must keep it) times an option, the second halves it and writes the depth as alpha.
passes_chain_through_half_float_targets_with_options_and_depth :: proc() {
}
    // rust: let Some((device, queue)) = device() else {
    // rust: return;
}
    // rust: let manifest = "schema = 1\nid = \"t\"\nname = \"T\"\nversion = \"1\"\napi = \"0.1\"\n\
    // rust: [[post]]\nfile = \"a.wgsl\"\n[[post]]\nfile = \"b.wgsl\"\n\
    // rust: [[options]]\nid = \"gain\"\nname = \"Gain\"\ntype = \"float\"\ndefault = 0.0\nmin = 0.0\nmax = 2.0\n";
    // rust: let a = "override gain: f32;\nfn post(input: PostInput) -> vec4<f32> { return vec4<f32>(input.color.rgb * 2.0 * gain, 1.0); }\n";
    // rust: let b = "fn post(input: PostInput) -> vec4<f32> { return vec4<f32>(input.color.rgb * 0.5, input.depth); }\n";
    // rust: let files = [(MANIFEST, manifest), ("a.wgsl", a), ("b.wgsl", b)]
    // rust: .map(|(n, t)| (n.to_owned(), t.as_bytes().to_vec()))
    // rust: .into();
    // rust: let report = check(&Pack::from_files(files).unwrap()).unwrap();
    // rust: let format = wgpu::TextureFormat::Rgba8Unorm;
    // rust: let frame = NativeFrame::new(&device, None, Vec::new(), Default::default(), None);
    // rust: queue.write_buffer(
    // rust: &frame.buffer,
    // rust: 0,
    // rust: bytemuck::bytes_of(&FrameInputs::default()),
    // rust: );
    // rust: let mut post = NativePost::new(
    // rust: &device,
    // rust: report.stages,
    // rust: &report.manifest,
    // rust: &[("gain".into(), 1.0)],
    // rust: format,
    // rust: &frame,
    // rust: )
    // rust: .unwrap();
    // rust: assert_eq!(post.labels(), ["a.wgsl", "b.wgsl"]);

    // rust: let usage = wgpu::TextureUsages::RENDER_ATTACHMENT | wgpu::TextureUsages::TEXTURE_BINDING;
    // rust: let color = texture(&device, format, usage).create_view(&Default::default());
    // rust: let depth = texture(&device, wgpu::TextureFormat::Depth32Float, usage)
    // rust: .create_view(&Default::default());
    // rust: let screen = texture(
    // rust: &device,
    // rust: format,
    // rust: wgpu::TextureUsages::RENDER_ATTACHMENT | wgpu::TextureUsages::COPY_SRC,
    // rust: );
    // rust: let mut encoder = device.create_command_encoder(&Default::default());
    // rust: encoder.begin_render_pass(&wgpu::RenderPassDescriptor {
    // rust: label: None,
    // rust: color_attachments: &[Some(wgpu::RenderPassColorAttachment {
    // rust: view: &color,
    // rust: resolve_target: None,
    // rust: depth_slice: None,
    // rust: ops: wgpu::Operations {
    // rust: load: wgpu::LoadOp::Clear(wgpu::Color {
    // rust: r: 0.8,
    // rust: g: 0.4,
    // rust: b: 0.2,
    // rust: a: 1.0,
    // rust: }),
    // rust: store: wgpu::StoreOp::Store,
    // rust: },
    // rust: })],
    // rust: depth_stencil_attachment: Some(wgpu::RenderPassDepthStencilAttachment {
    // rust: view: &depth,
    // rust: depth_ops: Some(wgpu::Operations {
    // rust: load: wgpu::LoadOp::Clear(0.5),
    // rust: store: wgpu::StoreOp::Store,
    // rust: }),
    // rust: stencil_ops: None,
    // rust: }),
    // rust: ..Default::default()
    // rust: });
    // rust: let view = screen.create_view(&Default::default());
    // rust: post.run(
    // rust: &device,
    // rust: &mut encoder,
    // rust: (&color, &depth, &frame.surface_view),
    // rust: &view,
    // rust: [4, 4],
    // rust: true,
    // rust: None,
    // rust: );
    // rust: let buffer = device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: None,
    // rust: size: u64::from(wgpu::COPY_BYTES_PER_ROW_ALIGNMENT * 4),
    // rust: usage: wgpu::BufferUsages::MAP_READ | wgpu::BufferUsages::COPY_DST,
    // rust: mapped_at_creation: false,
    // rust: });
    // rust: encoder.copy_texture_to_buffer(
    // rust: screen.as_image_copy(),
    // rust: wgpu::TexelCopyBufferInfo {
    // rust: buffer: &buffer,
    // rust: layout: wgpu::TexelCopyBufferLayout {
    // rust: offset: 0,
    // rust: bytes_per_row: Some(wgpu::COPY_BYTES_PER_ROW_ALIGNMENT),
    // rust: rows_per_image: Some(4),
    // rust: },
    // rust: },
    // rust: screen.size(),
    // rust: );
    // rust: queue.submit([encoder.finish()]);
    // rust: buffer
    // rust: .slice(..)
    // rust: .map_async(wgpu::MapMode::Read, |r| r.unwrap());
    // rust: device.poll(wgpu::PollType::wait_indefinitely()).unwrap();
    // rust: let pixel = buffer.slice(..).get_mapped_range().unwrap()[..4].to_vec();
    // rust: let near = |got: u8, want: u8| got.abs_diff(want) <= 1;
    // rust: assert!(
    // rust: near(pixel[0], 204) && near(pixel[1], 102) && near(pixel[2], 51) && near(pixel[3], 128),
    // rust: "{pixel:?}"
    // rust: );
}

    // `history` is black on the first frame, then what the pass before the last wrote the
    // frame before.
the_last_pass_reads_last_frames_input_as_history :: proc() {
}
    // rust: let Some((device, queue)) = device() else {
    // rust: return;
}
    // rust: let manifest = "schema = 1
    // rust: id = \"t\"
    // rust: name = \"T\"
    // rust: version = \"1\"
    // rust: api = \"0.1\"
    // rust: [[post]]
    // rust: file = \"a.wgsl\"
    // rust: [[post]]
    // rust: file = \"b.wgsl\"
    // rust: ";
    // rust: let a = "fn post(input: PostInput) -> vec4<f32> { return vec4<f32>(input.color.rgb * 0.5, 1.0); }
    // rust: ";
    // rust: let b = "fn post(input: PostInput) -> vec4<f32> { return textureLoad(history, vec2<i32>(input.pixel), 0); }
    // rust: ";
    // rust: let files = [(MANIFEST, manifest), ("a.wgsl", a), ("b.wgsl", b)]
    // rust: .map(|(n, t)| (n.to_owned(), t.as_bytes().to_vec()))
    // rust: .into();
    // rust: let report = check(&Pack::from_files(files).unwrap()).unwrap();
    // rust: let format = wgpu::TextureFormat::Rgba8Unorm;
    // rust: let frame = NativeFrame::new(&device, None, Vec::new(), Default::default(), None);
    // rust: let mut post = NativePost::new(
    // rust: &device,
    // rust: report.stages,
    // rust: &report.manifest,
    // rust: &[],
    // rust: format,
    // rust: &frame,
    // rust: )
    // rust: .unwrap();
    // rust: let usage = wgpu::TextureUsages::RENDER_ATTACHMENT | wgpu::TextureUsages::TEXTURE_BINDING;
    // rust: let color = texture(&device, format, usage).create_view(&Default::default());
    // rust: let depth = texture(&device, wgpu::TextureFormat::Depth32Float, usage)
    // rust: .create_view(&Default::default());
    // rust: let screen = texture(
    // rust: &device,
    // rust: format,
    // rust: wgpu::TextureUsages::RENDER_ATTACHMENT | wgpu::TextureUsages::COPY_SRC,
    // rust: );
    // rust: let view = screen.create_view(&Default::default());
    // rust: let buffer = device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: None,
    // rust: size: u64::from(wgpu::COPY_BYTES_PER_ROW_ALIGNMENT * 4),
    // rust: usage: wgpu::BufferUsages::MAP_READ | wgpu::BufferUsages::COPY_DST,
    // rust: mapped_at_creation: false,
    // rust: });
    // rust: let mut frame_pixel = |history_reset| {
    // rust: let mut encoder = device.create_command_encoder(&Default::default());
    // rust: encoder.begin_render_pass(&wgpu::RenderPassDescriptor {
    // rust: label: None,
    // rust: color_attachments: &[Some(wgpu::RenderPassColorAttachment {
    // rust: view: &color,
    // rust: resolve_target: None,
    // rust: depth_slice: None,
    // rust: ops: wgpu::Operations {
    // rust: load: wgpu::LoadOp::Clear(wgpu::Color::WHITE),
    // rust: store: wgpu::StoreOp::Store,
    // rust: },
    // rust: })],
    // rust: ..Default::default()
    // rust: });
    // rust: post.run(
    // rust: &device,
    // rust: &mut encoder,
    // rust: (&color, &depth, &frame.surface_view),
    // rust: &view,
    // rust: [4, 4],
    // rust: history_reset,
    // rust: None,
    // rust: );
    // rust: encoder.copy_texture_to_buffer(
    // rust: screen.as_image_copy(),
    // rust: wgpu::TexelCopyBufferInfo {
    // rust: buffer: &buffer,
    // rust: layout: wgpu::TexelCopyBufferLayout {
    // rust: offset: 0,
    // rust: bytes_per_row: Some(wgpu::COPY_BYTES_PER_ROW_ALIGNMENT),
    // rust: rows_per_image: Some(4),
    // rust: },
    // rust: },
    // rust: screen.size(),
    // rust: );
    // rust: queue.submit([encoder.finish()]);
    // rust: buffer
    // rust: .slice(..)
    // rust: .map_async(wgpu::MapMode::Read, |r| r.unwrap());
    // rust: device.poll(wgpu::PollType::wait_indefinitely()).unwrap();
    // rust: let pixel = buffer.slice(..).get_mapped_range().unwrap()[..4].to_vec();
    // rust: buffer.unmap();
    // rust: pixel
}
    // rust: assert_eq!(
    // rust: frame_pixel(true)[..3],
    // rust: [0, 0, 0],
    // rust: "black on the first frame"
    // rust: );
    // rust: let second = frame_pixel(false);
    // rust: assert!(
    // rust: second[..3].iter().all(|&v| v.abs_diff(128) <= 1),
    // rust: "{second:?}"
    // rust: );
    // rust: assert_eq!(frame_pixel(true)[..3], [0, 0, 0], "black after a frame gap");
    // rust: let fourth = frame_pixel(false);
    // rust: assert!(
    // rust: fourth[..3].iter().all(|&v| v.abs_diff(128) <= 1),
    // rust: "{fourth:?}"
    // rust: );
}

    // OpenGL refuses `Rgba32Float` as a render attachment (GLES 3 semantics, absent
    // `EXT_color_buffer_float`) but always renders to the integer formats, so the surface
    // is an integer format, and `surface_at` gets the floats back from the stored bits.
the_surface_is_an_integer_target_that_the_post_stage_reads_bit_exact :: proc() {
}
    // rust: assert_eq!(
    // rust: super::super::native_material::SURFACE_FORMAT.sample_type(None, None),
    // rust: Some(wgpu::TextureSampleType::Uint)
    // rust: );
    // rust: let Some((device, queue)) = device() else {
    // rust: return;
}
    // rust: let manifest = "schema = 1\nid = \"t\"\nname = \"T\"\nversion = \"1\"\napi = \"0.1\"\n\
    // rust: [[post]]\nfile = \"a.wgsl\"\n";
        // The surface's fields on the colour: normal x, smoothness, data, and 1 when present.
    // rust: let a = "fn post(input: PostInput) -> vec4<f32> {\n    \
    // rust: let s = surface_at(vec2<i32>(input.pixel));\n    \
    // rust: return vec4<f32>(s.normal.x, s.smoothness, s.data, select(0.0, 1.0, s.present));\n}\n";
    // rust: let files = [(MANIFEST, manifest), ("a.wgsl", a)]
    // rust: .map(|(n, t)| (n.to_owned(), t.as_bytes().to_vec()))
    // rust: .into();
    // rust: let report = check(&Pack::from_files(files).unwrap()).unwrap();
    // rust: let format = wgpu::TextureFormat::Rgba8Unorm;
    // rust: let frame = NativeFrame::new(&device, None, Vec::new(), Default::default(), None);
    // rust: let mut post = NativePost::new(
    // rust: &device,
    // rust: report.stages,
    // rust: &report.manifest,
    // rust: &[],
    // rust: format,
    // rust: &frame,
    // rust: )
    // rust: .unwrap();
    // rust: let usage = wgpu::TextureUsages::RENDER_ATTACHMENT | wgpu::TextureUsages::TEXTURE_BINDING;
    // rust: let color = texture(&device, format, usage).create_view(&Default::default());
    // rust: let depth = texture(&device, wgpu::TextureFormat::Depth32Float, usage)
    // rust: .create_view(&Default::default());
    // rust: let screen = texture(
    // rust: &device,
    // rust: format,
    // rust: wgpu::TextureUsages::RENDER_ATTACHMENT | wgpu::TextureUsages::COPY_SRC,
    // rust: );
    // rust: let view = screen.create_view(&Default::default());
    // rust: let buffer = device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: None,
    // rust: size: u64::from(wgpu::COPY_BYTES_PER_ROW_ALIGNMENT * 4),
    // rust: usage: wgpu::BufferUsages::MAP_READ | wgpu::BufferUsages::COPY_DST,
    // rust: mapped_at_creation: false,
    // rust: });
        // What the material stage stores, as the bits of floats: the normal +x (octahedral
        // (1, 0), two snorm16), smoothness 0.75, data 0.25 and the fragment's depth 0.5.
    // rust: let writer = device.create_shader_module(wgpu::ShaderModuleDescriptor {
    // rust: label: None,
    // rust: source: wgpu::ShaderSource::Wgsl(
    // rust: "@vertex fn vs(@builtin(vertex_index) i: u32) -> @builtin(position) vec4<f32> {
    // rust: return vec4<f32>(f32((i << 1u) & 2u) * 2.0 - 1.0, f32(i & 2u) * 2.0 - 1.0, 0.0, 1.0);
}
    // rust: @fragment fn fs() -> @location(0) vec4<u32> {
    // rust: return bitcast<vec4<u32>>(vec4<f32>(
    // rust: bitcast<f32>(pack2x16snorm(vec2<f32>(1.0, 0.0))), 0.75, 0.25, 0.5));
    // rust: }"
    // rust: .into(),
    // rust: ),
    // rust: });
    // rust: let writer = device.create_render_pipeline(&wgpu::RenderPipelineDescriptor {
    // rust: label: None,
    // rust: layout: None,
    // rust: vertex: wgpu::VertexState {
    // rust: module: &writer,
    // rust: entry_point: Some("vs"),
    // rust: compilation_options: Default::default(),
    // rust: buffers: &[],
    // rust: },
    // rust: primitive: Default::default(),
    // rust: depth_stencil: None,
    // rust: multisample: Default::default(),
    // rust: fragment: Some(wgpu::FragmentState {
    // rust: module: &writer,
    // rust: entry_point: Some("fs"),
    // rust: compilation_options: Default::default(),
    // rust: targets: &[Some(wgpu::ColorTargetState {
    // rust: format: super::super::native_material::SURFACE_FORMAT,
    // rust: blend: None,
    // rust: write_mask: wgpu::ColorWrites::ALL,
    // rust: })],
    // rust: }),
    // rust: multiview_mask: None,
    // rust: cache: None,
    // rust: });
    // rust: let mut read = |depth_of_world: f64| {
    // rust: let mut encoder = device.create_command_encoder(&Default::default());
    // rust: {
    // rust: let mut pass = encoder.begin_render_pass(&wgpu::RenderPassDescriptor {
    // rust: label: None,
    // rust: color_attachments: &[Some(wgpu::RenderPassColorAttachment {
    // rust: view: &frame.surface_view,
    // rust: resolve_target: None,
    // rust: depth_slice: None,
    // rust: ops: wgpu::Operations {
    // rust: load: wgpu::LoadOp::Clear(wgpu::Color::TRANSPARENT),
    // rust: store: wgpu::StoreOp::Store,
    // rust: },
    // rust: })],
    // rust: ..Default::default()
    // rust: });
    // rust: pass.set_pipeline(&writer);
    // rust: pass.draw(0..3, 0..1);
}
    // rust: encoder.begin_render_pass(&wgpu::RenderPassDescriptor {
    // rust: label: None,
    // rust: color_attachments: &[Some(wgpu::RenderPassColorAttachment {
    // rust: view: &color,
    // rust: resolve_target: None,
    // rust: depth_slice: None,
    // rust: ops: wgpu::Operations {
    // rust: load: wgpu::LoadOp::Clear(wgpu::Color::BLACK),
    // rust: store: wgpu::StoreOp::Store,
    // rust: },
    // rust: })],
    // rust: depth_stencil_attachment: Some(wgpu::RenderPassDepthStencilAttachment {
    // rust: view: &depth,
    // rust: depth_ops: Some(wgpu::Operations {
    // rust: load: wgpu::LoadOp::Clear(depth_of_world as f32),
    // rust: store: wgpu::StoreOp::Store,
    // rust: }),
    // rust: stencil_ops: None,
    // rust: }),
    // rust: ..Default::default()
    // rust: });
    // rust: post.run(
    // rust: &device,
    // rust: &mut encoder,
    // rust: (&color, &depth, &frame.surface_view),
    // rust: &view,
    // rust: [4, 4],
    // rust: true,
    // rust: None,
    // rust: );
    // rust: encoder.copy_texture_to_buffer(
    // rust: screen.as_image_copy(),
    // rust: wgpu::TexelCopyBufferInfo {
    // rust: buffer: &buffer,
    // rust: layout: wgpu::TexelCopyBufferLayout {
    // rust: offset: 0,
    // rust: bytes_per_row: Some(wgpu::COPY_BYTES_PER_ROW_ALIGNMENT),
    // rust: rows_per_image: Some(4),
    // rust: },
    // rust: },
    // rust: screen.size(),
    // rust: );
    // rust: queue.submit([encoder.finish()]);
    // rust: buffer
    // rust: .slice(..)
    // rust: .map_async(wgpu::MapMode::Read, |r| r.unwrap());
    // rust: device.poll(wgpu::PollType::wait_indefinitely()).unwrap();
    // rust: let pixel = buffer.slice(..).get_mapped_range().unwrap()[..4].to_vec();
    // rust: buffer.unmap();
    // rust: pixel
}
        // Present where the world's depth is the stored one: +x, 0.75, 0.25 as 8-bit. No value
        // here sits halfway between two 8-bit levels, where drivers round either way.
    // rust: assert_eq!(read(0.5), [255, 191, 64, 255]);
        // Hidden by something nearer drawn since: the stored values no longer show.
    // rust: assert_eq!(read(0.25), [0, 0, 0, 0]);
}

    // The surface holds float bit patterns, some of which are NaNs (a normal's two snorm16
    // can form one). The material stage writes `bitcast<vec4<u32>>(vec4<f32>(..))`; this
    // runs that same expression (not the whole material fragment, which needs a full terrain
    // pipeline) on bits fed as integers and checks the texture holds them exactly: payloads,
    // signs and denormals included.
the_surface_keeps_every_bit_of_the_floats_written_through_the_material_stage_bitcast :: proc() {
}
    // rust: let Some((device, queue)) = device() else {
    // rust: return;
}
    // rust: let cases: [[u32; 4]; 4] = [
    // rust: [0x7fc0_1234, 0xffbf_ffff, 0x7fff_8001, 0x7f80_0001],
    // rust: [0x8000_0000, 0x0000_0001, 0x007f_ffff, 0x8000_0001],
    // rust: [0xffff_ffff, 0x7f80_0000, 0xff80_0000, 0x3f80_0000],
    // rust: [0x7fff_8001, 0x0000_0000, 0x1234_5678, 0xdead_beef],
    // rust: ];
    // rust: let mut bits = [[0u32; 4]; 16];
    // rust: bits[..4].copy_from_slice(&cases);
    // rust: let inputs = device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: None,
    // rust: size: 256,
    // rust: usage: wgpu::BufferUsages::UNIFORM | wgpu::BufferUsages::COPY_DST,
    // rust: mapped_at_creation: false,
    // rust: });
    // rust: queue.write_buffer(&inputs, 0, bytemuck::cast_slice(&bits));
    // rust: let module = device.create_shader_module(wgpu::ShaderModuleDescriptor {
    // rust: label: None,
    // rust: source: wgpu::ShaderSource::Wgsl(
    // rust: "@group(0) @binding(0) var<uniform> bits: array<vec4<u32>, 16>;
    // rust: @vertex fn vs(@builtin(vertex_index) i: u32) -> @builtin(position) vec4<f32> {
    // rust: return vec4<f32>(f32((i << 1u) & 2u) * 2.0 - 1.0, f32(i & 2u) * 2.0 - 1.0, 0.0, 1.0);
}
    // rust: @fragment fn fs(@builtin(position) p: vec4<f32>) -> @location(0) vec4<u32> {
    // rust: let v = bitcast<vec4<f32>>(bits[u32(p.y) * 4u + u32(p.x)]);
    // rust: return bitcast<vec4<u32>>(v);
    // rust: }"
    // rust: .into(),
    // rust: ),
    // rust: });
    // rust: let pipeline = device.create_render_pipeline(&wgpu::RenderPipelineDescriptor {
    // rust: label: None,
    // rust: layout: None,
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
    // rust: targets: &[Some(wgpu::ColorTargetState {
    // rust: format: super::super::native_material::SURFACE_FORMAT,
    // rust: blend: None,
    // rust: write_mask: wgpu::ColorWrites::ALL,
    // rust: })],
    // rust: }),
    // rust: multiview_mask: None,
    // rust: cache: None,
    // rust: });
    // rust: let group = device.create_bind_group(&wgpu::BindGroupDescriptor {
    // rust: label: None,
    // rust: layout: &pipeline.get_bind_group_layout(0),
    // rust: entries: &[wgpu::BindGroupEntry {
    // rust: binding: 0,
    // rust: resource: inputs.as_entire_binding(),
    // rust: }],
    // rust: });
    // rust: let surface = texture(
    // rust: &device,
    // rust: super::super::native_material::SURFACE_FORMAT,
    // rust: wgpu::TextureUsages::RENDER_ATTACHMENT | wgpu::TextureUsages::COPY_SRC,
    // rust: );
    // rust: let row = u64::from(wgpu::COPY_BYTES_PER_ROW_ALIGNMENT);
    // rust: let buffer = device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: None,
    // rust: size: row * 4,
    // rust: usage: wgpu::BufferUsages::MAP_READ | wgpu::BufferUsages::COPY_DST,
    // rust: mapped_at_creation: false,
    // rust: });
    // rust: let mut encoder = device.create_command_encoder(&Default::default());
    // rust: {
    // rust: let view = surface.create_view(&Default::default());
    // rust: let mut pass = encoder.begin_render_pass(&wgpu::RenderPassDescriptor {
    // rust: label: None,
    // rust: color_attachments: &[Some(wgpu::RenderPassColorAttachment {
    // rust: view: &view,
    // rust: resolve_target: None,
    // rust: depth_slice: None,
    // rust: ops: wgpu::Operations {
    // rust: load: wgpu::LoadOp::Clear(wgpu::Color::BLACK),
    // rust: store: wgpu::StoreOp::Store,
    // rust: },
    // rust: })],
    // rust: ..Default::default()
    // rust: });
    // rust: pass.set_pipeline(&pipeline);
    // rust: pass.set_bind_group(0, &group, &[]);
    // rust: pass.draw(0..3, 0..1);
}
    // rust: encoder.copy_texture_to_buffer(
    // rust: surface.as_image_copy(),
    // rust: wgpu::TexelCopyBufferInfo {
    // rust: buffer: &buffer,
    // rust: layout: wgpu::TexelCopyBufferLayout {
    // rust: offset: 0,
    // rust: bytes_per_row: Some(wgpu::COPY_BYTES_PER_ROW_ALIGNMENT),
    // rust: rows_per_image: Some(4),
    // rust: },
    // rust: },
    // rust: surface.size(),
    // rust: );
    // rust: queue.submit([encoder.finish()]);
    // rust: buffer
    // rust: .slice(..)
    // rust: .map_async(wgpu::MapMode::Read, |r| r.unwrap());
    // rust: device.poll(wgpu::PollType::wait_indefinitely()).unwrap();
    // rust: let data = buffer.slice(..).get_mapped_range().unwrap().to_vec();
    // rust: buffer.unmap();
    // rust: for (i, expected) in bits.iter().enumerate() {
    // rust: let (x, y) = (i % 4, i / 4);
    // rust: let at = y * row as usize + x * 16;
    // rust: let got: [u32; 4] = std::array::from_fn(|c| {
    // rust: u32::from_ne_bytes(data[at + c * 4..at + c * 4 + 4].try_into().unwrap())
    // rust: });
    // rust: assert_eq!(
    // rust: got.map(|v| format!("{v:08x}")),
    // rust: expected.map(|v| format!("{v:08x}")),
    // rust: "texel {x},{y}"
    // rust: );
}
}
}
