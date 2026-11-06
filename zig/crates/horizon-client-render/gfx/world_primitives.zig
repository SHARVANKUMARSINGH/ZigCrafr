//! Transpiled from Horizon Rust crate
//! Module: horizon-client-render_world_primitives
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Native mods' world primitives (`native_world_primitives`, docs/native-mods.md): lines, boxes,
//! beams and text a mod hands the game each frame, drawn here with Horizon's own pipelines at
//! the end of the world pass, after the entities and before the first-person hand. They draw
//! into the world's targets, so they take the world's reversed depth, its draw resolution and
//! TAA's jitter; a mod never touches wgpu for them.

// use super::Vertex;
// use glam::Mat4;

/// A frame's primitives, camera-relative, as the game tessellated them: quads of 4 vertices
/// from the shared atlas (plain colours on its white texel, text on its glyphs, beams on the
/// beacon beam sprite) and lines as `gizmos::camera_relative` gives them. `*_through` ones are
/// seen through walls: no depth test.
pub const Batch = struct {
    quads: *'a [Vertex],
    quads_through: *'a [Vertex],
    lines: *'a [[f32,
    lines_through: *'a [[f32,
};

    // rust: impl Batch<'_> {
pub fn is_empty(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.quads.is_empty()
    // rust: && self.quads_through.is_empty()
    // rust: && self.lines.is_empty()
    // rust: && self.lines_through.is_empty()
}
}

pub const Globals = struct {
    view_proj: [[f32,
    viewport: [f32,
};

/// The pipelines and buffers that draw a [`Batch`].
pub const WorldPrimitives = struct {
    /// Depth tested, then seen through walls.
    quad_pipelines: [wgpu::RenderPipeline,
    line_pipelines: [wgpu::RenderPipeline,
    layout: wgpu::BindGroupLayout,
    globals: wgpu::Buffer,
    sampler: wgpu::Sampler,
    quads: wgpu::Buffer,
    lines: wgpu::Buffer,
    indices: wgpu::Buffer,
    index_quads: u32,
    group: ?wgpu::BindGroup,
    /// Quads depth tested, quads through walls, lines depth tested, lines through walls.
    counts: [u32,
};

/// Writes bytes into a buffer as part of the frame (the renderer's staging uploads, or the
/// queue in a test).
    // rust: pub type Upload<'u> = &'u mut dyn FnMut(&wgpu::Buffer, &[u8]);

    // rust: impl WorldPrimitives {
    /// Pipelines drawing into `color_format` over a reversed Depth32Float depth.
pub fn new(device: *wgpu::Device, color_format: wgpu::TextureFormat) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let shader = device.create_shader_module(wgpu::ShaderModuleDescriptor {
    // rust: label: Some("World primitives"),
    // rust: source: wgpu::ShaderSource::Wgsl(include_str!("world_primitives.wgsl").into()),
    // rust: });
    // rust: let layout = device.create_bind_group_layout(&wgpu::BindGroupLayoutDescriptor {
    // rust: label: Some("World primitives"),
    // rust: entries: &[
    // rust: wgpu::BindGroupLayoutEntry {
    // rust: binding: 0,
    // rust: visibility: wgpu::ShaderStages::VERTEX,
    // rust: ty: wgpu::BindingType::Buffer {
    // rust: ty: wgpu::BufferBindingType::Uniform,
    // rust: has_dynamic_offset: false,
    // rust: min_binding_size: None,
    // rust: },
    // rust: count: None,
    // rust: },
    // rust: wgpu::BindGroupLayoutEntry {
    // rust: binding: 1,
    // rust: visibility: wgpu::ShaderStages::FRAGMENT,
    // rust: ty: wgpu::BindingType::Texture {
    // rust: sample_type: wgpu::TextureSampleType::Float { filterable: true },
    // rust: view_dimension: wgpu::TextureViewDimension::D2,
    // rust: multisampled: false,
    // rust: },
    // rust: count: None,
    // rust: },
    // rust: wgpu::BindGroupLayoutEntry {
    // rust: binding: 2,
    // rust: visibility: wgpu::ShaderStages::FRAGMENT,
    // rust: ty: wgpu::BindingType::Sampler(wgpu::SamplerBindingType::Filtering),
    // rust: count: None,
    // rust: },
    // rust: ],
    // rust: });
    // rust: let pipeline_layout = device.create_pipeline_layout(&wgpu::PipelineLayoutDescriptor {
    // rust: label: Some("World primitives"),
    // rust: bind_group_layouts: &[Some(&layout)],
    // rust: ..Default::default()
    // rust: });
    // rust: let quad_attributes =
    // rust: wgpu::vertex_attr_array![0=>Float32x3,1=>Float32x2,2=>Uint32,3=>Unorm8x4,4=>Uint32];
    // rust: let line_attributes =
    // rust: wgpu::vertex_attr_array![0=>Float32x3,1=>Float32x3,2=>Unorm8x4,3=>Float32];
    // rust: let quad_buffers = [Some(wgpu::VertexBufferLayout {
    // rust: array_stride: std::mem::size_of::<Vertex>() as u64,
    // rust: step_mode: wgpu::VertexStepMode::Vertex,
    // rust: attributes: &quad_attributes,
    // rust: })];
    // rust: let line_buffers = [Some(wgpu::VertexBufferLayout {
    // rust: array_stride: 32,
    // rust: step_mode: wgpu::VertexStepMode::Instance,
    // rust: attributes: &line_attributes,
    // rust: })];
    // rust: let pipeline = |label: &str,
    // rust: entry: [&str; 2],
    // rust: buffers: &[Option<wgpu::VertexBufferLayout<'_>>],
    // rust: topology,
    // rust: through: bool| {
    // rust: device.create_render_pipeline(&wgpu::RenderPipelineDescriptor {
    // rust: label: Some(label),
    // rust: layout: Some(&pipeline_layout),
    // rust: vertex: wgpu::VertexState {
    // rust: module: &shader,
    // rust: entry_point: Some(entry[0]),
    // rust: compilation_options: Default::default(),
    // rust: buffers,
    // rust: },
    // rust: primitive: wgpu::PrimitiveState {
    // rust: topology,
                    // Seen from inside or behind as well: a box around the camera, a beam.
    // rust: cull_mode: None,
    // rust: ..Default::default()
    // rust: },
                // Blended over what is drawn, writing no depth: a translucent box doesn't hide
                // the primitives behind it. Reversed depth: nearer is greater.
    // rust: depth_stencil: Some(wgpu::DepthStencilState {
    // rust: format: wgpu::TextureFormat::Depth32Float,
    // rust: depth_write_enabled: Some(false),
    // rust: depth_compare: Some(if through {
    // rust: wgpu::CompareFunction::Always
    // rust: } else {
    // rust: wgpu::CompareFunction::GreaterEqual
    // rust: }),
    // rust: stencil: Default::default(),
    // rust: bias: Default::default(),
    // rust: }),
    // rust: multisample: Default::default(),
    // rust: fragment: Some(wgpu::FragmentState {
    // rust: module: &shader,
    // rust: entry_point: Some(entry[1]),
    // rust: compilation_options: Default::default(),
    // rust: targets: &[Some(wgpu::ColorTargetState {
    // rust: format: color_format,
    // rust: blend: Some(wgpu::BlendState::ALPHA_BLENDING),
    // rust: write_mask: wgpu::ColorWrites::ALL,
    // rust: })],
    // rust: }),
    // rust: multiview_mask: None,
    // rust: cache: None,
    // rust: })
}
    // rust: let quads = ["vs_quad", "fs_quad"];
    // rust: let lines = ["vs_line", "fs_line"];
    // rust: let list = wgpu::PrimitiveTopology::TriangleList;
    // rust: let strip = wgpu::PrimitiveTopology::TriangleStrip;
    // rust: let quad_pipelines = [
    // rust: pipeline("World primitives", quads, &quad_buffers, list, false),
    // rust: pipeline(
    // rust: "World primitives through walls",
    // rust: quads,
    // rust: &quad_buffers,
    // rust: list,
    // rust: true,
    // rust: ),
    // rust: ];
    // rust: let line_pipelines = [
    // rust: pipeline("World primitive lines", lines, &line_buffers, strip, false),
    // rust: pipeline(
    // rust: "World primitive lines through walls",
    // rust: lines,
    // rust: &line_buffers,
    // rust: strip,
    // rust: true,
    // rust: ),
    // rust: ];
    // rust: let buffer = |label, size, usage| {
    // rust: device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: Some(label),
    // rust: size,
    // rust: usage: usage | wgpu::BufferUsages::COPY_DST,
    // rust: mapped_at_creation: false,
    // rust: })
}
    // rust: Self {
    // rust: quad_pipelines,
    // rust: line_pipelines,
    // rust: globals: buffer(
    // rust: "World primitive globals",
    // rust: std::mem::size_of::<Globals>() as u64,
    // rust: wgpu::BufferUsages::UNIFORM,
    // rust: ),
    // rust: sampler: device.create_sampler(&wgpu::SamplerDescriptor {
    // rust: label: Some("World primitives"),
    // rust: ..Default::default()
    // rust: }),
    // rust: layout,
    // rust: quads: buffer("World primitive quads", 0, wgpu::BufferUsages::VERTEX),
    // rust: lines: buffer("World primitive lines", 0, wgpu::BufferUsages::VERTEX),
    // rust: indices: buffer("World primitive indices", 0, wgpu::BufferUsages::INDEX),
    // rust: index_quads: 0,
    // rust: group: None,
    // rust: counts: [0; 4],
}
}

    /// Uploads this frame's `batch`, drawn with `view_proj` (camera-relative world to clip,
    /// jittered as the world is) into a frame `viewport` pixels big, sampling `atlas`. Whether
    /// there is anything to draw.
    // rust: pub fn prepare(
    // rust: &mut self,
    // rust: device: &wgpu::Device,
    // rust: upload: Upload<'_>,
    // rust: batch: &Batch<'_>,
    // rust: view_proj: Mat4,
    // rust: viewport: [u32; 2],
    // rust: atlas: &wgpu::TextureView,
    // rust: ) -> bool {
    // rust: let quads = [batch.quads, batch.quads_through].map(|q| (q.len() / 4) as u32);
    // rust: let lines = [batch.lines, batch.lines_through].map(|l| l.len() as u32);
    // rust: self.counts = [quads[0], quads[1], lines[0], lines[1]];
    // rust: if batch.is_empty() {
    // rust: return false;
}
    // rust: let grow = |buffer: &mut wgpu::Buffer, bytes: u64| {
    // rust: if buffer.size() < bytes {
    // rust: *buffer = device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: Some("World primitives"),
    // rust: size: bytes.next_power_of_two(),
    // rust: usage: buffer.usage(),
    // rust: mapped_at_creation: false,
    // rust: });
}
}
    // rust: let total_quads = quads[0] + quads[1];
    // rust: if total_quads > 0 {
    // rust: let vertices: Vec<Vertex> = [batch.quads, batch.quads_through]
    // rust: .into_iter()
    // rust: .flat_map(|q| &q[..q.len() / 4 * 4])
    // rust: .copied()
    // rust: .collect();
    // rust: let bytes: &[u8] = bytemuck::cast_slice(&vertices);
    // rust: grow(&mut self.quads, bytes.len() as u64);
    // rust: upload(&self.quads, bytes);
    // rust: if total_quads > self.index_quads {
    // rust: self.index_quads = total_quads.next_power_of_two();
    // rust: let indices: Vec<u32> = (0..self.index_quads)
    // rust: .flat_map(|q| [0, 1, 2, 0, 2, 3].map(|i| q * 4 + i))
    // rust: .collect();
    // rust: let bytes: &[u8] = bytemuck::cast_slice(&indices);
    // rust: grow(&mut self.indices, bytes.len() as u64);
    // rust: upload(&self.indices, bytes);
}
}
    // rust: if lines[0] + lines[1] > 0 {
    // rust: let all: Vec<[f32; 8]> = batch
    // rust: .lines
    // rust: .iter()
    // rust: .chain(batch.lines_through)
    // rust: .copied()
    // rust: .collect();
    // rust: let bytes: &[u8] = bytemuck::cast_slice(&all);
    // rust: grow(&mut self.lines, bytes.len() as u64);
    // rust: upload(&self.lines, bytes);
}
    // rust: let globals = Globals {
    // rust: view_proj: view_proj.to_cols_array_2d(),
    // rust: viewport: [viewport[0] as f32, viewport[1] as f32, 0.0, 0.0],
}
    // rust: upload(&self.globals, bytemuck::bytes_of(&globals));
    // rust: self.group = Some(device.create_bind_group(&wgpu::BindGroupDescriptor {
    // rust: label: Some("World primitives"),
    // rust: layout: &self.layout,
    // rust: entries: &[
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 0,
    // rust: resource: self.globals.as_entire_binding(),
    // rust: },
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 1,
    // rust: resource: wgpu::BindingResource::TextureView(atlas),
    // rust: },
    // rust: wgpu::BindGroupEntry {
    // rust: binding: 2,
    // rust: resource: wgpu::BindingResource::Sampler(&self.sampler),
    // rust: },
    // rust: ],
    // rust: }));
    // rust: true
}

    /// Draws what [`Self::prepare`] uploaded into a pass over the world's colour and depth:
    /// the depth-tested quads and lines, then those seen through walls over everything.
pub fn draw(self: *Self, pass: *mut wgpu::RenderPass<'_>) void {
}
    // rust: let Some(group) = &self.group else {
    // rust: return;
}
    // rust: let [quads, quads_through, lines, lines_through] = self.counts;
    // rust: pass.set_bind_group(0, group, &[]);
    // rust: for (through, (quad_range, line_range)) in [
    // rust: (0..quads, 0..lines),
    // rust: (quads..quads + quads_through, lines..lines + lines_through),
    // rust: ]
    // rust: .into_iter()
    // rust: .enumerate()
    // rust: {
    // rust: if !quad_range.is_empty() {
    // rust: pass.set_pipeline(&self.quad_pipelines[through]);
    // rust: pass.set_vertex_buffer(0, self.quads.slice(..));
    // rust: pass.set_index_buffer(self.indices.slice(..), wgpu::IndexFormat::Uint32);
    // rust: pass.draw_indexed(quad_range.start * 6..quad_range.end * 6, 0, 0..1);
}
    // rust: if !line_range.is_empty() {
    // rust: pass.set_pipeline(&self.line_pipelines[through]);
    // rust: pass.set_vertex_buffer(0, self.lines.slice(..));
    // rust: pass.draw(0..4, line_range);
}
}
}
}

    // rust: mod tests {
//     use super::*;
//     use glam::Vec3;

pub const SIZE: u32 = 64;
    /// RGBA, as `Vertex::color` holds it.
pub const RED: u32 = 0xFF00_00FF;
pub const GREEN: u32 = 0xFF00_FF00;
pub const BLUE: u32 = 0xFFFF_0000;
    /// ARGB, as a line carries it.
pub const MAGENTA_ARGB: u32 = 0xFFFF_00FF;

    /// A camera-relative quad of plain colour facing the camera, `z` blocks ahead of it, over
    /// the pixels `x0..x1`, `y0..y1` of the frame (y down).
pub fn quad(view_proj: Mat4, y1]: [f32; 4], z: f32, rgba: u32) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let depth = view_proj.project_point3(Vec3::new(0.0, 0.0, -z)).z;
    // rust: let inverse = view_proj.inverse();
    // rust: let at = |x: f32, y: f32| {
    // rust: let ndc = Vec3::new(
    // rust: x / SIZE as f32 * 2.0 - 1.0,
    // rust: 1.0 - y / SIZE as f32 * 2.0,
    // rust: depth,
    // rust: );
    // rust: inverse.project_point3(ndc).to_array()
}
    // rust: [at(x0, y0), at(x0, y1), at(x1, y1), at(x1, y0)].map(|pos| Vertex {
    // rust: pos,
    // rust: uv: [0.5, 0.5],
    // rust: layer: 0,
    // rust: color: rgba,
    // rust: light: 0,
    // rust: normal: [0; 4],
    // rust: glint_uv: [0.0, 0.0],
    // rust: })
}

    /// A horizontal line, 4 pixels wide, over the pixels `x0..x1` of row `y`, `z` blocks ahead.
pub fn line(view_proj: Mat4, x1]: [f32; 2], y: f32, z: f32, argb: u32) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let q = quad(view_proj, [x0, y, x1, y], z, 0);
    // rust: let [a, b] = [q[0].pos, q[3].pos];
    // rust: [
    // rust: a[0],
    // rust: a[1],
    // rust: a[2],
    // rust: b[0],
    // rust: b[1],
    // rust: b[2],
    // rust: f32::from_bits(argb),
    // rust: 4.0,
    // rust: ]
}

    /// A wall 5 blocks ahead fills the depth (reversed: nearer is greater). Behind it, a
    /// depth-tested quad and line stay hidden while the same seen through walls show; a
    /// depth-tested quad in front of the wall shows.
pub fn depth_tested_primitives_hide_behind_walls_and_see_through_ones_do_not() void {
}
    // rust: let instance = crate::gfx::test_gpu::instance();
    // rust: let Some((device, queue)) =
    // rust: pollster::block_on(instance.request_adapter(&Default::default()))
    // rust: .ok()
    // rust: .and_then(|adapter| {
    // rust: pollster::block_on(adapter.request_device(&Default::default())).ok()
    // rust: })
    // rust: else {
    // rust: eprintln!("no GPU adapter: skipped");
    // rust: return;
}
    // rust: let view_proj = super::super::world_projection(70.0, 1.0, 512.0);
    // rust: let wall = view_proj.project_point3(Vec3::new(0.0, 0.0, -5.0)).z;
        // Reversed depth: 10 blocks away is less than the wall, 2 blocks away more.
    // rust: assert!(view_proj.project_point3(Vec3::new(0.0, 0.0, -10.0)).z < wall);
    // rust: assert!(view_proj.project_point3(Vec3::new(0.0, 0.0, -2.0)).z > wall);

    // rust: let format = wgpu::TextureFormat::Rgba8Unorm;
    // rust: let texture = |size: u32, format, usage| {
    // rust: device.create_texture(&wgpu::TextureDescriptor {
    // rust: label: None,
    // rust: size: wgpu::Extent3d {
    // rust: width: size,
    // rust: height: size,
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
    // rust: SIZE,
    // rust: format,
    // rust: wgpu::TextureUsages::RENDER_ATTACHMENT | wgpu::TextureUsages::COPY_SRC,
    // rust: );
    // rust: let depth = texture(
    // rust: SIZE,
    // rust: wgpu::TextureFormat::Depth32Float,
    // rust: wgpu::TextureUsages::RENDER_ATTACHMENT,
    // rust: );
        // The atlas: one white texel, what plain colours sample.
    // rust: let atlas = texture(
    // rust: 1,
    // rust: format,
    // rust: wgpu::TextureUsages::TEXTURE_BINDING | wgpu::TextureUsages::COPY_DST,
    // rust: );
    // rust: queue.write_texture(
    // rust: atlas.as_image_copy(),
    // rust: &[255; 4],
    // rust: wgpu::TexelCopyBufferLayout {
    // rust: offset: 0,
    // rust: bytes_per_row: Some(4),
    // rust: rows_per_image: None,
    // rust: },
    // rust: atlas.size(),
    // rust: );

    // rust: let (half, full) = (SIZE as f32 / 2.0, SIZE as f32);
        // Top left: behind the wall, depth tested. Top right: behind it, through walls.
        // Bottom left: in front of it, depth tested. Bottom right: lines behind it, the
        // depth-tested one along row 40, the one through walls along row 56.
    // rust: let quads = [
    // rust: quad(view_proj, [0.0, 0.0, half, half], 10.0, RED),
    // rust: quad(view_proj, [0.0, half, half, full], 2.0, BLUE),
    // rust: ]
    // rust: .concat();
    // rust: let quads_through = quad(view_proj, [half, 0.0, full, half], 10.0, GREEN);
    // rust: let lines = [line(view_proj, [half, full], 40.0, 10.0, MAGENTA_ARGB)];
    // rust: let lines_through = [line(view_proj, [half, full], 56.0, 10.0, MAGENTA_ARGB)];
    // rust: let batch = Batch {
    // rust: quads: &quads,
    // rust: quads_through: &quads_through,
    // rust: lines: &lines,
    // rust: lines_through: &lines_through,
}

    // rust: let mut primitives = WorldPrimitives::new(&device, format);
    // rust: let atlas_view = atlas.create_view(&Default::default());
    // rust: assert!(primitives.prepare(
    // rust: &device,
    // rust: &mut |buffer, bytes| queue.write_buffer(buffer, 0, bytes),
    // rust: &batch,
    // rust: view_proj,
    // rust: [SIZE, SIZE],
    // rust: &atlas_view,
    // rust: ));
    // rust: let mut encoder = device.create_command_encoder(&Default::default());
    // rust: {
    // rust: let color_view = color.create_view(&Default::default());
    // rust: let depth_view = depth.create_view(&Default::default());
    // rust: let mut pass = encoder.begin_render_pass(&wgpu::RenderPassDescriptor {
    // rust: label: None,
    // rust: color_attachments: &[Some(wgpu::RenderPassColorAttachment {
    // rust: view: &color_view,
    // rust: depth_slice: None,
    // rust: resolve_target: None,
    // rust: ops: wgpu::Operations {
    // rust: load: wgpu::LoadOp::Clear(wgpu::Color::BLACK),
    // rust: store: wgpu::StoreOp::Store,
    // rust: },
    // rust: })],
    // rust: depth_stencil_attachment: Some(wgpu::RenderPassDepthStencilAttachment {
    // rust: view: &depth_view,
    // rust: depth_ops: Some(wgpu::Operations {
    // rust: load: wgpu::LoadOp::Clear(wall),
    // rust: store: wgpu::StoreOp::Store,
    // rust: }),
    // rust: stencil_ops: None,
    // rust: }),
    // rust: ..Default::default()
    // rust: });
    // rust: primitives.draw(&mut pass);
}
    // rust: let readback = device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: None,
    // rust: size: u64::from(SIZE * SIZE * 4),
    // rust: usage: wgpu::BufferUsages::COPY_DST | wgpu::BufferUsages::MAP_READ,
    // rust: mapped_at_creation: false,
    // rust: });
    // rust: encoder.copy_texture_to_buffer(
    // rust: color.as_image_copy(),
    // rust: wgpu::TexelCopyBufferInfo {
    // rust: buffer: &readback,
    // rust: layout: wgpu::TexelCopyBufferLayout {
    // rust: offset: 0,
    // rust: bytes_per_row: Some(SIZE * 4),
    // rust: rows_per_image: None,
    // rust: },
    // rust: },
    // rust: color.size(),
    // rust: );
    // rust: queue.submit([encoder.finish()]);
    // rust: readback.slice(..).map_async(wgpu::MapMode::Read, |_| {});
    // rust: device.poll(wgpu::PollType::wait_indefinitely()).unwrap();
    // rust: let texels = readback.slice(..).get_mapped_range().unwrap().to_vec();
    // rust: let at = |x: u32, y: u32| {
    // rust: let i = ((y * SIZE + x) * 4) as usize;
    // rust: [texels[i], texels[i + 1], texels[i + 2], texels[i + 3]]
}
    // rust: let black = [0, 0, 0, 255];
    // rust: assert_eq!(
    // rust: at(16, 16),
    // rust: black,
    // rust: "a depth-tested quad behind the wall is hidden"
    // rust: );
    // rust: assert_eq!(
    // rust: at(48, 16),
    // rust: [0, 255, 0, 255],
    // rust: "a quad through walls shows behind it"
    // rust: );
    // rust: assert_eq!(
    // rust: at(16, 48),
    // rust: [0, 0, 255, 255],
    // rust: "a depth-tested quad before it shows"
    // rust: );
    // rust: assert_eq!(
    // rust: at(48, 40),
    // rust: black,
    // rust: "a depth-tested line behind the wall is hidden"
    // rust: );
    // rust: assert_eq!(
    // rust: at(48, 56),
    // rust: [255, 0, 255, 255],
    // rust: "a line through walls shows behind it"
    // rust: );
        // The line is its width (4 pixels) thick, not more.
    // rust: assert_eq!(at(48, 52), black);
}
}
