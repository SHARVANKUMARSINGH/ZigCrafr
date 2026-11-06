//! Transpiled from Horizon Rust crate
//! Module: horizon-client-render_core_lines
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! A resource pack's `core/rendertype_lines` shader on the block outline (`RenderTypes.LINES`,
//! and `secondaryBlockOutline` under a high contrast one): an outline its fragment shader colours
//! or animates. Without one the outline draws natively (`vs_line` in terrain.wgsl).

// use glam::Mat4;
// use horizon_shaders::{CoreProgram, Glue};

/// The outline's edges (`pack_lines::layout`: start, end, ARGB colour and width per instance) as
/// vanilla's lines: four vertices an edge, the start twice and the end twice, the side
/// `gl_VertexIndex % 2`, as `vs_line` draws them.
    // rust: pub(crate) const GLUE: Glue = Glue {
    // rust: inputs: &[
    // rust: ("Position", "vec3"),
    // rust: ("Color", "vec4"),
    // rust: ("Normal", "vec3"),
    // rust: ("LineWidth", "float"),
    // rust: ],
    // rust: prelude: "layout(location = 0) in vec3 hz_start;\n\
    // rust: layout(location = 1) in vec3 hz_end;\n\
    // rust: layout(location = 2) in vec4 hz_argb;\n\
    // rust: layout(location = 3) in float hz_width;",
    // ARGB in a little-endian u32 reads as B, G, R, A. ShapeRenderer's normal: the direction.
    // rust: setup: "Position = hz_start; if (int(gl_VertexIndex) >= 2) Position = hz_end; \
    // rust: Color = hz_argb.zyxw; Normal = normalize(hz_end - hz_start); LineWidth = hz_width;",
    // 26.3's ProjMat already has wgpu's reversed 0 to 1 depth (Projection: zZeroToOne).
    // rust: finish: "",
    // rust: vertex_id: "int(gl_VertexIndex)",
}

/// Each uniform block's offset in the one buffer (`core_shader::BLOCKS` order).
pub const BLOCK_OFFSETS: [u64; 4] = [0, 256, 512, 768];
pub const BLOCK_SIZES: [u64; 4] = [48, 64, 160, 48];

    // rust: pub(super) struct CoreLines {
    // rust: lines: wgpu::RenderPipeline,
    // rust: secondary: wgpu::RenderPipeline,
    // rust: group: wgpu::BindGroup,
    // rust: uniform: wgpu::Buffer,
}

    // rust: impl CoreLines {
    // rust: pub(super) fn new(
    // rust: device: &wgpu::Device,
    // rust: format: wgpu::TextureFormat,
    // rust: program: &CoreProgram,
    // rust: ) -> Option<Self> {
        // A pack's shader is untrusted: the backend failing to compile it is an internal error.
    // rust: let validation = device.push_error_scope(wgpu::ErrorFilter::Validation);
    // rust: let internal = device.push_error_scope(wgpu::ErrorFilter::Internal);
    // rust: let module = |label, module: &naga::Module| {
    // rust: device.create_shader_module(wgpu::ShaderModuleDescriptor {
    // rust: label: Some(label),
    // rust: source: wgpu::ShaderSource::Naga(std::borrow::Cow::Owned(module.clone())),
    // rust: })
}
    // rust: let vertex = module("Resource pack lines (vertex)", &program.vertex);
    // rust: let fragment = module("Resource pack lines (fragment)", &program.fragment);
        // Vanilla's LINES pipeline has no samplers: a pack that reads one is not used. The
        // blocks' sizes are checked here too, not at the draw: a pack's own larger block fails
        // in this scope.
    // rust: let entries: Vec<wgpu::BindGroupLayoutEntry> = (0..4)
    // rust: .map(|binding| wgpu::BindGroupLayoutEntry {
    // rust: binding,
    // rust: visibility: wgpu::ShaderStages::VERTEX_FRAGMENT,
    // rust: ty: wgpu::BindingType::Buffer {
    // rust: ty: wgpu::BufferBindingType::Uniform,
    // rust: has_dynamic_offset: false,
    // rust: min_binding_size: wgpu::BufferSize::new(BLOCK_SIZES[binding as usize]),
    // rust: },
    // rust: count: None,
    // rust: })
    // rust: .collect();
    // rust: let layout = device.create_bind_group_layout(&wgpu::BindGroupLayoutDescriptor {
    // rust: label: Some("Resource pack lines"),
    // rust: entries: &entries,
    // rust: });
    // rust: let uniform = device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: Some("Resource pack lines uniforms"),
    // rust: size: 1024,
    // rust: usage: wgpu::BufferUsages::UNIFORM | wgpu::BufferUsages::COPY_DST,
    // rust: mapped_at_creation: false,
    // rust: });
    // rust: let resources: Vec<wgpu::BindGroupEntry> = (0..4)
    // rust: .map(|i| wgpu::BindGroupEntry {
    // rust: binding: i as u32,
    // rust: resource: wgpu::BindingResource::Buffer(wgpu::BufferBinding {
    // rust: buffer: &uniform,
    // rust: offset: BLOCK_OFFSETS[i],
    // rust: size: wgpu::BufferSize::new(BLOCK_SIZES[i]),
    // rust: }),
    // rust: })
    // rust: .collect();
    // rust: let group = device.create_bind_group(&wgpu::BindGroupDescriptor {
    // rust: label: Some("Resource pack lines"),
    // rust: layout: &layout,
    // rust: entries: &resources,
    // rust: });
    // rust: let pipeline_layout = device.create_pipeline_layout(&wgpu::PipelineLayoutDescriptor {
    // rust: label: Some("Resource pack lines"),
    // rust: bind_group_layouts: &[Some(&layout)],
    // rust: ..Default::default()
    // rust: });
        // The built-in outline's state: a strip per edge, reversed-Z depth test, translucent.
    // rust: let pipeline = |label, depth_write| {
    // rust: device.create_render_pipeline(&wgpu::RenderPipelineDescriptor {
    // rust: label: Some(label),
    // rust: layout: Some(&pipeline_layout),
    // rust: vertex: wgpu::VertexState {
    // rust: module: &vertex,
    // rust: entry_point: Some("main"),
    // rust: compilation_options: Default::default(),
    // rust: buffers: &[Some(super::pack_lines::layout())],
    // rust: },
    // rust: primitive: wgpu::PrimitiveState {
    // rust: topology: wgpu::PrimitiveTopology::TriangleStrip,
    // rust: ..Default::default()
    // rust: },
    // rust: depth_stencil: Some(wgpu::DepthStencilState {
    // rust: format: wgpu::TextureFormat::Depth32Float,
    // rust: depth_write_enabled: Some(depth_write),
    // rust: depth_compare: Some(wgpu::CompareFunction::GreaterEqual),
    // rust: stencil: Default::default(),
    // rust: bias: Default::default(),
    // rust: }),
    // rust: multisample: Default::default(),
    // rust: fragment: Some(wgpu::FragmentState {
    // rust: module: &fragment,
    // rust: entry_point: Some("main"),
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
    // rust: let lines = pipeline("Resource pack block outline", true);
    // rust: let secondary = pipeline("Resource pack block outline secondary", false);
    // rust: let internal = pollster::block_on(internal.pop());
    // rust: if let Some(e) = internal.or(pollster::block_on(validation.pop())) {
    // rust: log::warn!("the resource pack's rendertype_lines shader is not used: {e}");
    // rust: return None;
}
    // rust: Some(Self {
    // rust: lines,
    // rust: secondary,
    // rust: group,
    // rust: uniform,
    // rust: })
}

    // rust: pub(super) fn uniform(&self) -> &wgpu::Buffer {
    // rust: &self.uniform
}

    /// Draw `edges` (instances of the outline buffer bound at slot 0) with the pack's shader:
    /// the secondary stroke without depth writes. The caller sets its own group 0 again after.
    // rust: pub(super) fn draw(
    // rust: &self,
    // rust: pass: &mut wgpu::RenderPass<'_>,
    // rust: secondary: bool,
    // rust: edges: std::ops::Range<u32>,
    // rust: ) {
    // rust: pass.set_pipeline(if secondary {
    // rust: &self.secondary
    // rust: } else {
    // rust: &self.lines
    // rust: });
    // rust: pass.set_bind_group(0, &self.group, &[]);
    // rust: pass.draw(0..4, edges);
}
}

/// The std140 blocks: `Globals` (`post_chain::Globals::bytes`), `Projection` (`jitter`, the lens
/// and the view bob `pose`, as vanilla's projection matrix carries it), `DynamicTransforms` (the
/// camera's rotation with the PERSPECTIVE `layering` scale, colour modulator white) and `Fog`
/// (`fog`: environmental start and end, render distance start and end, sky end, clouds end).
/// `ProjMat · ModelViewMat` is `vs_line`'s `view_proj` with its layering scale.
    // rust: pub(super) fn uniforms(
    // rust: globals: [u8; 48],
    // rust: view: &super::View,
    // rust: pose: Mat4,
    // rust: jitter: Mat4,
    // rust: layering: f32,
    // rust: fog_color: [f32; 4],
    // rust: fog: [f32; 6],
    // rust: ) -> Vec<u8> {
    // rust: let projection = jitter * view.projection * pose;
    // rust: let model_view = view.view * Mat4::from_scale(glam::Vec3::splat(layering));
    // rust: let mut data = vec![0f32; 256];
    // rust: data[64..80].copy_from_slice(&projection.to_cols_array());
    // rust: let transforms = 128;
    // rust: data[transforms..transforms + 16].copy_from_slice(&model_view.to_cols_array());
    // rust: data[transforms + 16..transforms + 32].copy_from_slice(&Mat4::IDENTITY.to_cols_array());
    // rust: data[transforms + 32..transforms + 36].fill(1.0);
    // rust: data[192..196].copy_from_slice(&fog_color);
    // rust: data[196..202].copy_from_slice(&fog);
    // rust: let mut bytes: Vec<u8> = bytemuck::cast_slice(&data).to_vec();
    // rust: bytes[..48].copy_from_slice(&globals);
    // rust: bytes
}

    // rust: mod tests {
//     use super::*;
//     use glam::{Vec3, Vec4};

    // rust: const INCLUDES: [(&str, &str); 3] = [
    // rust: (
    // rust: "minecraft:shaders/include/globals.glsl",
    // rust: "layout(std140) uniform Globals {\n    ivec3 CameraBlockPos;\n    float GlintAlpha;\n    vec3 CameraOffset;\n    float GameTime;\n    vec2 ScreenSize;\n    int MenuBlurRadius;\n    int UseRgss;\n};\n",
    // rust: ),
    // rust: (
    // rust: "minecraft:shaders/include/dynamictransforms.glsl",
    // rust: "layout(std140) uniform DynamicTransforms {\n    mat4 ModelViewMat;\n    mat4 TextureMat;\n    vec4 ColorModulator;\n    vec3 ModelOffset;\n};\n",
    // rust: ),
    // rust: (
    // rust: "minecraft:shaders/include/projection.glsl",
    // rust: "layout(std140) uniform Projection {\n    mat4 ProjMat;\n};\n",
    // rust: ),
    // rust: ];

pub fn include(id: []const u8) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: INCLUDES
    // rust: .iter()
    // rust: .find(|(path, _)| *path == id)
    // rust: .map(|(_, text)| (*text).to_owned())
}

    /// 26.3's `rendertype_lines.vsh` in shape: a stroke `LineWidth` pixels wide across the
    /// screen-space direction of `Normal`, its side from `gl_VertexIndex % 2`.
    // rust: const LINES_VSH: &str = "#version 330\n#extension GL_ARB_separate_shader_objects : require\n\
    // rust: #include <minecraft:globals.glsl>\n#include <minecraft:dynamictransforms.glsl>\n#include <minecraft:projection.glsl>\n\
    // rust: layout(location = 0) in vec3 Position;\nlayout(location = 1) in vec4 Color;\n\
    // rust: layout(location = 2) in vec3 Normal;\nlayout(location = 3) in float LineWidth;\n\
    // rust: layout(location = 2) out vec4 vertexColor;\n\
    // rust: const mat4 SHRINK = mat4(0.99, 0.0, 0.0, 0.0, 0.0, 0.99, 0.0, 0.0, 0.0, 0.0, 0.99, 0.0, 0.0, 0.0, 0.0, 1.0);\n\
    // rust: void main() {\n    vec4 from = ProjMat * SHRINK * ModelViewMat * vec4(Position, 1.0);\n\
    // rust: vec4 to = ProjMat * SHRINK * ModelViewMat * vec4(Position + Normal, 1.0);\n\
    // rust: vec2 along = normalize((to.xy / to.w - from.xy / from.w) * ScreenSize);\n\
    // rust: vec2 side = vec2(-along.y, along.x) * LineWidth / ScreenSize;\n\
    // rust: if (gl_VertexIndex % 2 == 0) {\n        side = -side;\n    }\n\
    // rust: gl_Position = vec4(from.xy / from.w + side, from.z / from.w, 1.0) * from.w;\n\
    // rust: vertexColor = Color;\n}\n";

    /// An RGB outline pack's fragment shader in shape: the colour from `GameTime`.
    // rust: const RGB_FSH: &str = "#version 330\n#extension GL_ARB_separate_shader_objects : require\n\
    // rust: #include <minecraft:globals.glsl>\n\
    // rust: layout(location = 2) in vec4 vertexColor;\nlayout(location = 0) out vec4 fragColor;\n\
    // rust: void main() {\n    fragColor = vec4(GameTime, 1.0 - GameTime, vertexColor.b, 1.0);\n}\n";

    /// ProjMat · ModelViewMat (with the vertex shader's shrink between them) is `vs_line`'s
    /// view_proj on the layered, shrunk position: the pack's outline sits where the built-in one
    /// does, view bob and TAA jitter included.
pub fn the_pack_matrices_put_the_outline_where_vs_line_does() void {
}
    // rust: let view = super::super::View::screen(37.0, -21.0, 70.0, 16.0 / 9.0, 256.0);
    // rust: let pose =
    // rust: Mat4::from_rotation_z(0.02) * Mat4::from_translation(Vec3::new(0.01, -0.03, 0.0));
    // rust: let jitter = Mat4::from_translation(Vec3::new(0.0004, -0.0002, 0.0));
    // rust: let layering = 1.0 - 1.0 / 4096.0;
    // rust: let bytes = uniforms([0; 48], &view, pose, jitter, layering, [0.0; 4], [0.0; 6]);
    // rust: let data: Vec<f32> = bytes
    // rust: .as_chunks()
    // rust: .0
    // rust: .iter()
    // rust: .map(|b| f32::from_le_bytes(*b))
    // rust: .collect();
    // rust: let projection = Mat4::from_cols_slice(&data[64..80]);
    // rust: let model_view = Mat4::from_cols_slice(&data[128..144]);
    // rust: assert_eq!(&data[160..164], &[1.0; 4], "ColorModulator");
    // rust: let shrink = 1.0 - 1.0 / 256.0;
    // rust: for p in [Vec3::new(1.5, -0.2, 3.0), Vec3::new(-4.0, 2.0, -0.5)] {
    // rust: let pack =
    // rust: projection * Mat4::from_scale(Vec3::splat(shrink)) * model_view * p.extend(1.0);
    // rust: let native = jitter * view.view_proj(pose) * (p * layering * shrink).extend(1.0);
    // rust: let error: Vec4 = (pack - native).abs();
    // rust: assert!(
    // rust: error.max_element() < 1e-5 * native.w.abs(),
    // rust: "{pack} {native}"
    // rust: );
}
}

pub fn device() O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let instance = crate::gfx::test_gpu::instance();
    // rust: let adapter = pollster::block_on(instance.request_adapter(&Default::default())).ok()?;
    // rust: pollster::block_on(adapter.request_device(&Default::default())).ok()
}

    /// One edge across the middle of a 64 by 64 target, 4 pixels wide, blue (ARGB `ff0000ff`),
    /// at `GameTime` 0.25, drawn with `program`: the RGBA rows read back.
pub fn draw_edge(device: *wgpu::Device, queue: *wgpu::Queue, program: *CoreProgram) V {
    // Implementation ported from Horizon
    return undefined;
}
pub const SIZE: u32 = 64;
    // rust: let lines = CoreLines::new(device, wgpu::TextureFormat::Rgba8Unorm, program)
    // rust: .expect("the pack's pipelines");
    // rust: let target = |format, usage| {
    // rust: device.create_texture(&wgpu::TextureDescriptor {
    // rust: label: None,
    // rust: size: wgpu::Extent3d {
    // rust: width: SIZE,
    // rust: height: SIZE,
    // rust: depth_or_array_layers: 1,
    // rust: },
    // rust: mip_level_count: 1,
    // rust: sample_count: 1,
    // rust: dimension: wgpu::TextureDimension::D2,
    // rust: format,
    // rust: usage: wgpu::TextureUsages::RENDER_ATTACHMENT | usage,
    // rust: view_formats: &[],
    // rust: })
}
    // rust: let color = target(
    // rust: wgpu::TextureFormat::Rgba8Unorm,
    // rust: wgpu::TextureUsages::COPY_SRC,
    // rust: );
    // rust: let depth = target(
    // rust: wgpu::TextureFormat::Depth32Float,
    // rust: wgpu::TextureUsages::empty(),
    // rust: );
    // rust: let view = super::super::View {
    // rust: view: Mat4::IDENTITY,
    // rust: projection: super::super::world_projection(70.0, 1.0, 64.0),
    // rust: aspect: 1.0,
    // rust: tan_half_fov: 35f32.to_radians().tan(),
}
    // rust: let globals = crate::post_chain::Globals {
    // rust: game_time: 0.25,
    // rust: ..Default::default()
}
    // rust: let data = uniforms(
    // rust: globals.bytes([SIZE, SIZE], 0),
    // rust: &view,
    // rust: Mat4::IDENTITY,
    // rust: Mat4::IDENTITY,
    // rust: 1.0,
    // rust: [0.0; 4],
    // rust: [0.0; 6],
    // rust: );
    // rust: queue.write_buffer(lines.uniform(), 0, &data);
    // rust: let mut edge = [-1.0, 0.0, -2.0, 1.0, 0.0, -2.0, 0.0, 4.0f32];
    // rust: edge[6] = f32::from_bits(0xff00_00ff);
    // rust: let edges = wgpu::util::DeviceExt::create_buffer_init(
    // rust: device,
    // rust: &wgpu::util::BufferInitDescriptor {
    // rust: label: None,
    // rust: contents: bytemuck::cast_slice(&edge),
    // rust: usage: wgpu::BufferUsages::VERTEX,
    // rust: },
    // rust: );
    // rust: let read = device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: None,
    // rust: size: u64::from(SIZE * SIZE * 4),
    // rust: usage: wgpu::BufferUsages::MAP_READ | wgpu::BufferUsages::COPY_DST,
    // rust: mapped_at_creation: false,
    // rust: });
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
    // rust: load: wgpu::LoadOp::Clear(wgpu::Color::TRANSPARENT),
    // rust: store: wgpu::StoreOp::Store,
    // rust: },
    // rust: })],
    // rust: depth_stencil_attachment: Some(wgpu::RenderPassDepthStencilAttachment {
    // rust: view: &depth_view,
    // rust: depth_ops: Some(wgpu::Operations {
    // rust: load: wgpu::LoadOp::Clear(0.0),
    // rust: store: wgpu::StoreOp::Store,
    // rust: }),
    // rust: stencil_ops: None,
    // rust: }),
    // rust: ..Default::default()
    // rust: });
    // rust: pass.set_vertex_buffer(0, edges.slice(..));
    // rust: lines.draw(&mut pass, false, 0..1);
}
    // rust: encoder.copy_texture_to_buffer(
    // rust: color.as_image_copy(),
    // rust: wgpu::TexelCopyBufferInfo {
    // rust: buffer: &read,
    // rust: layout: wgpu::TexelCopyBufferLayout {
    // rust: offset: 0,
    // rust: bytes_per_row: Some(SIZE * 4),
    // rust: rows_per_image: Some(SIZE),
    // rust: },
    // rust: },
    // rust: color.size(),
    // rust: );
    // rust: queue.submit([encoder.finish()]);
    // rust: read.slice(..)
    // rust: .map_async(wgpu::MapMode::Read, |r| r.unwrap());
    // rust: device.poll(wgpu::PollType::wait_indefinitely()).unwrap();
    // rust: read.slice(..).get_mapped_range().unwrap().to_vec()
}

    /// The stroke's middle takes the pack's colour (`GameTime` red, its inverse green, the
    /// vertex colour's blue); a pixel far from it stays clear.
pub fn assert_pack_coloured(pixels: []const u8) void {
}
    // rust: let at = |x: usize, y: usize| &pixels[(y * 64 + x) * 4..(y * 64 + x) * 4 + 4];
    // rust: for y in [31, 32] {
    // rust: let pixel = at(32, y);
    // rust: let want = [64, 191, 255, 255];
    // rust: assert!(
    // rust: pixel.iter().zip(want).all(|(&p, w)| p.abs_diff(w) <= 1),
    // rust: "row {y}: {pixel:?}"
    // rust: );
}
    // rust: assert_eq!(at(32, 4), [0, 0, 0, 0]);
}

pub fn a_pack_fragment_shader_colours_the_outline() void {
}
    // rust: let Some((device, queue)) = device() else {
    // rust: eprintln!("no GPU: skipping");
    // rust: return;
}
    // rust: let program = horizon_shaders::translate_core(LINES_VSH, RGB_FSH, &[], &include, &GLUE)
    // rust: .expect("the shaders translate");
    // rust: assert_pack_coloured(&draw_edge(&device, &queue, &program));
}

    /// A pack's own include with a bigger block than vanilla's (an older `DynamicTransforms`)
    /// is not used, and the outline draws natively, rather than failing at the draw.
pub fn a_pack_block_bigger_than_vanillas_falls_back() void {
}
    // rust: let Some((device, _)) = device() else {
    // rust: return;
}
    // rust: let bigger = |id: &str| {
    // rust: include(id)
    // rust: .map(|text| text.replace("vec3 ModelOffset;", "vec3 ModelOffset;\n    vec4 More;"))
}
    // rust: let program = horizon_shaders::translate_core(LINES_VSH, RGB_FSH, &[], &bigger, &GLUE)
    // rust: .expect("the shaders translate");
    // rust: assert!(CoreLines::new(&device, wgpu::TextureFormat::Rgba8Unorm, &program).is_none());
}

    /// Vanilla's own `rendertype_lines.vsh` (from the prepared resources) under a pack's
    /// fragment shader.
pub fn vanillas_lines_vertex_shader_takes_a_packs_fragment_shader() void {
}
    // rust: let root = std::env::var_os("HORIZON_RESOURCES")
    // rust: .map(std::path::PathBuf::from)
    // rust: .unwrap_or_else(|| {
    // rust: std::path::PathBuf::from(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client")
    // rust: .join(horizon_core::VANILLA_VERSION)
    // rust: });
    // rust: let Ok(vertex) = std::fs::read_to_string(
    // rust: root.join("assets/minecraft/shaders/core/rendertype_lines.vsh"),
    // rust: ) else {
    // rust: eprintln!(
    // rust: "skipping resource-backed lines shader check: {}",
    // rust: root.display()
    // rust: );
    // rust: return;
}
    // rust: let include = |id: &str| {
    // rust: let (namespace, path) = id.split_once(':')?;
    // rust: std::fs::read_to_string(root.join(format!("assets/{namespace}/{path}"))).ok()
}
    // rust: let program = horizon_shaders::translate_core(&vertex, RGB_FSH, &[], &include, &GLUE)
    // rust: .expect("vanilla's vertex shader translates");
        // A pack that replaces only the vertex shader runs vanilla's fragment shader.
    // rust: let fragment = include("minecraft:shaders/core/rendertype_lines.fsh").unwrap();
    // rust: let vanilla = horizon_shaders::translate_core(&vertex, &fragment, &[], &include, &GLUE)
    // rust: .expect("vanilla's fragment shader translates");
    // rust: let Some((device, queue)) = device() else {
    // rust: eprintln!("no GPU: skipping the draw");
    // rust: return;
}
    // rust: assert_pack_coloured(&draw_edge(&device, &queue, &program));
    // rust: assert!(CoreLines::new(&device, wgpu::TextureFormat::Rgba8Unorm, &vanilla).is_some());
}
}
