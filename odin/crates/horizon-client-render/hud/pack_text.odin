//! Transpiled from Horizon Rust crate
package horizon_client_render_pack_text

import "core:fmt"
import "core:mem"
import "core:math"

// A resource pack's `core/text` shader on the GUI's text (`RenderPipelines.GUI_TEXT`, the shader
// with `IS_GUI`): servers' HUDs that their pack's vertex shader moves to the screen's corners,
// and text effects in its fragment shader. Without one the text draws natively.

// use std::path::Path;
// use std::sync::Arc;

// use horizon_shaders::{CoreProgram, Glue};

// use super::{HudBatch, HudVertex};

// GUI text's vertex format (`POSITION_TEX_COLOR`) from the HUD's vertices. A glyph is two
// triangles here, its corners top left, top right, bottom right, top left, bottom right, bottom
// left; vanilla's quads go top left, bottom left, bottom right, top right, which is what
// `gl_VertexID % 4` tells a pack's shader. The draw passes its first vertex as its instance.
    // rust: const GLUE: Glue = Glue {
    // rust: inputs: &[("Position", "vec3"), ("Color", "vec4"), ("UV0", "vec2")],
    // rust: prelude: "layout(location = 0) in vec2 hz_pos;\n\
    // rust: layout(location = 1) in vec2 hz_uv;\n\
    // rust: layout(location = 2) in vec4 hz_color;\n\
    // rust: const int hz_corner[6] = int[6](0, 3, 2, 0, 2, 1);\n\
    // rust: int hz_vertex_id() {\n\
    // rust: int i = int(gl_VertexIndex) - int(gl_InstanceIndex);\n\
    // rust: return i / 6 * 4 + hz_corner[i % 6];\n\
    // rust: }",
    // rust: setup: "Position = vec3(hz_pos, 0.0); Color = hz_color; UV0 = hz_uv;",
    // GL's clip depth runs from -w to w, wgpu's from 0 to w; GUI text has no depth test.
    // rust: finish: "gl_Position.z = 0.5 * gl_Position.w;",
    // rust: vertex_id: "hz_vertex_id()",
}

// The packs' text shader, when a pack replaces either stage.
    // rust: pub(super) fn load(root: &Path, defaults: &Path) -> Option<Arc<CoreProgram>> {
    // rust: load_core(root, defaults, "text", &["IS_GUI"], &GLUE)
}

// The packs' core shader `name` (`shaders/core/<name>.vsh` and `.fsh`) over `defaults` (the
// game's own resources, which have vanilla's and its includes), when a pack replaces either
// stage.
    // rust: pub(super) fn load_core(
    // rust: root: &Path,
    // rust: defaults: &Path,
    // rust: name: &str,
    // rust: defines: &[&str],
    // rust: glue: &Glue,
    // rust: ) -> Option<Arc<CoreProgram>> {
    // rust: if root == defaults {
    // rust: return None;
}
    // rust: let read = |base: &Path, path: &str| std::fs::read_to_string(base.join(path)).ok();
    // rust: let own =
    // rust: |path: &str| read(root, path).filter(|text| read(defaults, path).as_ref() != Some(text));
    // rust: let vertex_path = format!("assets/minecraft/shaders/core/{name}.vsh");
    // rust: let fragment_path = format!("assets/minecraft/shaders/core/{name}.fsh");
    // rust: let (own_vertex, own_fragment) = (own(&vertex_path), own(&fragment_path));
    // rust: if own_vertex.is_none() && own_fragment.is_none() {
    // rust: return None;
}
    // rust: let vertex = own_vertex.or_else(|| read(defaults, &vertex_path))?;
    // rust: let fragment = own_fragment.or_else(|| read(defaults, &fragment_path))?;
    // rust: let include = |id: &str| {
    // rust: let (namespace, path) = id.split_once(':')?;
    // rust: let path = format!("assets/{namespace}/{path}");
    // rust: read(root, &path).or_else(|| read(defaults, &path))
}
    // rust: match horizon_shaders::translate_core(&vertex, &fragment, defines, &include, glue) {
    // rust: Ok(program) => {
    // rust: log::info!("the resource pack's {name} shader is used");
    // rust: Some(Arc::new(program))
}
    // rust: Err(e) => {
    // rust: log::warn!("the resource pack's {name} shader is not used: {e}");
    // rust: None
}
}
}

// Each uniform block's offset in the one buffer (`core_shader::BLOCKS` order).
BLOCK_OFFSETS :: [0, 256, 512, 768]
BLOCK_SIZES :: [48, 64, 160, 48]

// The pipeline and its resources.
    // rust: pub(super) struct PackText {
    // rust: pipeline: wgpu::RenderPipeline,
    // rust: group: wgpu::BindGroup,
    // rust: uniform: wgpu::Buffer,
}

    // rust: impl PackText {
    // rust: pub(super) fn new(
    // rust: device: &wgpu::Device,
    // rust: format: wgpu::TextureFormat,
    // rust: atlas: &wgpu::TextureView,
    // rust: program: &CoreProgram,
    // rust: ) -> Option<Self> {
    // rust: let scope = device.push_error_scope(wgpu::ErrorFilter::Validation);
    // rust: let module = |label, module: &naga::Module| {
    // rust: device.create_shader_module(wgpu::ShaderModuleDescriptor {
    // rust: label: Some(label),
    // rust: source: wgpu::ShaderSource::Naga(std::borrow::Cow::Owned(module.clone())),
    // rust: })
}
    // rust: let vertex = module("Resource pack text (vertex)", &program.vertex);
    // rust: let fragment = module("Resource pack text (fragment)", &program.fragment);
    // rust: let visibility = wgpu::ShaderStages::VERTEX_FRAGMENT;
    // rust: let mut entries: Vec<wgpu::BindGroupLayoutEntry> = (0..4)
    // rust: .map(|binding| wgpu::BindGroupLayoutEntry {
    // rust: binding,
    // rust: visibility,
    // rust: ty: wgpu::BindingType::Buffer {
    // rust: ty: wgpu::BufferBindingType::Uniform,
    // rust: has_dynamic_offset: false,
    // rust: min_binding_size: None,
    // rust: },
    // rust: count: None,
    // rust: })
    // rust: .collect();
    // rust: for (_, binding) in horizon_shaders::SAMPLERS {
    // rust: entries.push(wgpu::BindGroupLayoutEntry {
    // rust: binding,
    // rust: visibility,
    // rust: ty: wgpu::BindingType::Texture {
    // rust: sample_type: wgpu::TextureSampleType::Float { filterable: true },
    // rust: view_dimension: wgpu::TextureViewDimension::D2,
    // rust: multisampled: false,
    // rust: },
    // rust: count: None,
    // rust: });
    // rust: entries.push(wgpu::BindGroupLayoutEntry {
    // rust: binding: binding + 1,
    // rust: visibility,
    // rust: ty: wgpu::BindingType::Sampler(wgpu::SamplerBindingType::Filtering),
    // rust: count: None,
    // rust: });
}
    // rust: let layout = device.create_bind_group_layout(&wgpu::BindGroupLayoutDescriptor {
    // rust: label: Some("Resource pack text"),
    // rust: entries: &entries,
    // rust: });
    // rust: let uniform = device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: Some("Resource pack text uniforms"),
    // rust: size: 1024,
    // rust: usage: wgpu::BufferUsages::UNIFORM | wgpu::BufferUsages::COPY_DST,
    // rust: mapped_at_creation: false,
    // rust: });
        // The font textures' nearest filtering; every sampler a pack names reads the atlas.
    // rust: let sampler = device.create_sampler(&wgpu::SamplerDescriptor {
    // rust: label: Some("Resource pack text"),
    // rust: ..Default::default()
    // rust: });
    // rust: let mut resources: Vec<wgpu::BindGroupEntry> = (0..4)
    // rust: .map(|i| wgpu::BindGroupEntry {
    // rust: binding: i as u32,
    // rust: resource: wgpu::BindingResource::Buffer(wgpu::BufferBinding {
    // rust: buffer: &uniform,
    // rust: offset: BLOCK_OFFSETS[i],
    // rust: size: wgpu::BufferSize::new(BLOCK_SIZES[i]),
    // rust: }),
    // rust: })
    // rust: .collect();
    // rust: for (_, binding) in horizon_shaders::SAMPLERS {
    // rust: resources.push(wgpu::BindGroupEntry {
    // rust: binding,
    // rust: resource: wgpu::BindingResource::TextureView(atlas),
    // rust: });
    // rust: resources.push(wgpu::BindGroupEntry {
    // rust: binding: binding + 1,
    // rust: resource: wgpu::BindingResource::Sampler(&sampler),
    // rust: });
}
    // rust: let group = device.create_bind_group(&wgpu::BindGroupDescriptor {
    // rust: label: Some("Resource pack text"),
    // rust: layout: &layout,
    // rust: entries: &resources,
    // rust: });
    // rust: let pipeline_layout = device.create_pipeline_layout(&wgpu::PipelineLayoutDescriptor {
    // rust: label: Some("Resource pack text"),
    // rust: bind_group_layouts: &[Some(&layout)],
    // rust: ..Default::default()
    // rust: });
    // rust: let attributes = wgpu::vertex_attr_array![0=>Float32x2,1=>Float32x2,2=>Unorm8x4];
    // rust: let pipeline = device.create_render_pipeline(&wgpu::RenderPipelineDescriptor {
    // rust: label: Some("Resource pack text"),
    // rust: layout: Some(&pipeline_layout),
    // rust: vertex: wgpu::VertexState {
    // rust: module: &vertex,
    // rust: entry_point: Some("main"),
    // rust: compilation_options: Default::default(),
    // rust: buffers: &[Some(wgpu::VertexBufferLayout {
    // rust: array_stride: std::mem::size_of::<HudVertex>() as u64,
    // rust: step_mode: wgpu::VertexStepMode::Vertex,
    // rust: attributes: &attributes,
    // rust: })],
    // rust: },
    // rust: primitive: Default::default(),
    // rust: depth_stencil: None,
    // rust: multisample: Default::default(),
    // rust: fragment: Some(wgpu::FragmentState {
    // rust: module: &fragment,
    // rust: entry_point: Some("main"),
    // rust: compilation_options: Default::default(),
                // BlendFunction.TRANSLUCENT.
    // rust: targets: &[Some(wgpu::ColorTargetState {
    // rust: format,
    // rust: blend: Some(wgpu::BlendState::ALPHA_BLENDING),
    // rust: write_mask: wgpu::ColorWrites::ALL,
    // rust: })],
    // rust: }),
    // rust: multiview_mask: None,
    // rust: cache: None,
    // rust: });
    // rust: if let Some(e) = pollster::block_on(scope.pop()) {
    // rust: log::warn!("the resource pack's text shader is not used: {e}");
    // rust: return None;
}
    // rust: Some(Self {
    // rust: pipeline,
    // rust: group,
    // rust: uniform,
    // rust: })
}

    // The frame's blocks, as `GuiRenderer` sets them for the GUI.
    // rust: pub(super) fn prepare(
    // rust: &self,
    // rust: uploads: &mut crate::gfx::upload::Uploads,
    // rust: encoder: &mut wgpu::CommandEncoder,
    // rust: batch: &HudBatch,
    // rust: size: [u32; 2],
    // rust: scale: f32,
    // rust: ) {
    // rust: uploads.buffer(encoder, &self.uniform, 0, &uniforms(batch, size, scale));
}

    // Draw `range` (whole glyph quads) with the pack's shader; the caller sets its own
    // pipeline and bind group again after.
    // rust: pub(super) fn draw(&self, pass: &mut wgpu::RenderPass<'_>, range: std::ops::Range<u32>) {
    // rust: pass.set_pipeline(&self.pipeline);
    // rust: pass.set_bind_group(0, &self.group, &[]);
    // rust: pass.draw(range.clone(), range.start..range.start + 1);
}
}

// The std140 blocks: `Globals` (`GlobalSettingsUniform.update`: the camera at the origin,
// `GlintAlpha`, `GameTime`, `ScreenSize`), `Projection` (`GuiRenderer`'s orthographic GUI
// projection, 1000 to 11000 deep, in GL's depth range), `DynamicTransforms` (the GUI's model view
// moving 11000 back, colour modulator white) and an empty `Fog`.
// `scale`: target pixels per GUI pixel (`batch.scale`, times `HudRenderer::zoom`).
uniforms :: proc(batch: ^HudBatch, size: [u32; 2], scale: f32) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let mut data = vec![0f32; 256];
    // rust: let globals = 0;
    // rust: data[globals + 3] = batch.glint_alpha;
    // rust: data[globals + 7] = batch.game_time;
    // rust: data[globals + 8] = size[0] as f32;
    // rust: data[globals + 9] = size[1] as f32;
    // Matrix4f.setOrtho(0, width, height, 0, near, far) with the GUI's scale, columns.
    // rust: let (w, h) = (size[0] as f32 / scale, size[1] as f32 / scale);
    // rust: let (near, far) = (1000.0f32, 11000.0f32);
    // rust: let projection = 64;
    // rust: data[projection] = 2.0 / w;
    // rust: data[projection + 5] = -2.0 / h;
    // rust: data[projection + 10] = 2.0 / (near - far);
    // rust: data[projection + 12] = -1.0;
    // rust: data[projection + 13] = 1.0;
    // rust: data[projection + 14] = (far + near) / (near - far);
    // rust: data[projection + 15] = 1.0;
    // rust: let transforms = 128;
    // rust: for (matrix, z) in [(transforms, -11000.0), (transforms + 16, 0.0)] {
    // rust: data[matrix] = 1.0;
    // rust: data[matrix + 5] = 1.0;
    // rust: data[matrix + 10] = 1.0;
    // rust: data[matrix + 14] = z;
    // rust: data[matrix + 15] = 1.0;
}
    // rust: data[transforms + 32..transforms + 36].fill(1.0);
    // rust: bytemuck::cast_slice(&data).to_vec()
}

// `range` split into runs of GUI text and of the rest, in order.
    // rust: pub(super) fn text_runs(
    // rust: vertices: &[HudVertex],
    // rust: range: std::ops::Range<u32>,
    // rust: ) -> Vec<(std::ops::Range<u32>, bool)> {
    // rust: let mut runs: Vec<(std::ops::Range<u32>, bool)> = Vec::new();
    // rust: for i in range {
    // rust: let text = vertices.get(i as usize).is_some_and(|v| v.text != 0);
    // rust: match runs.last_mut() {
    // rust: Some((run, t)) if *t == text => run.end = i + 1,
    // rust: _ => runs.push((i..i + 1, text)),
}
}
    // rust: runs
}

    // rust: mod tests {
//     use super::*;

the_gui_projection_maps_gui_pixels_to_the_screen :: proc() {
}
    // rust: let mut batch = HudBatch::new([1920, 1080]);
    // rust: batch.scale = 4.0;
    // rust: let data: Vec<f32> =
    // rust: bytemuck::cast_slice(&uniforms(&batch, [1920, 1080], batch.scale)).to_vec();
    // rust: let column = |matrix: usize, c: usize| &data[matrix + 4 * c..matrix + 4 * c + 4];
    // rust: let apply = |matrix: usize, v: [f32; 4]| -> [f32; 4] {
    // rust: std::array::from_fn(|r| (0..4).map(|c| column(matrix, c)[r] * v[c]).sum())
}
        // ProjMat * ModelViewMat * (x, y, 0, 1) for the GUI's corners: 480 x 270 GUI pixels.
    // rust: for ([x, y], [cx, cy]) in [([0.0, 0.0], [-1.0, 1.0]), ([480.0, 270.0], [1.0, -1.0])] {
    // rust: let clip = apply(64, apply(128, [x, y, 0.0, 1.0]));
    // rust: assert!(
    // rust: (clip[0] - cx).abs() < 1e-5 && (clip[1] - cy).abs() < 1e-5,
    // rust: "{clip:?}"
    // rust: );
            // At GL's far plane, as vanilla's GUI is.
    // rust: assert!((clip[2] - 1.0).abs() < 1e-4, "{clip:?}");
}
        // A pack finds the GUI scale as ScreenSize.x * ProjMat[0][0] / 2.
    // rust: assert!((data[8] * data[64] / 2.0 - 4.0).abs() < 1e-4);
}

text_splits_from_the_rest :: proc() {
}
    // rust: let vertex = |text| HudVertex {
    // rust: pos: [0.0; 2],
    // rust: uv: [0.0; 2],
    // rust: color: 0,
    // rust: depth: 0.0,
    // rust: glint_uv: [0.0; 2],
    // rust: text,
}
    // rust: let vertices: Vec<HudVertex> = [0, 0, 1, 1, 1, 0].into_iter().map(vertex).collect();
    // rust: assert_eq!(
    // rust: text_runs(&vertices, 1..6),
    // rust: [(1..2, false), (2..5, true), (5..6, false)]
    // rust: );
}
}
