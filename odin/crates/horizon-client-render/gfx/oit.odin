//! Transpiled from Horizon Rust crate
package horizon_client_render_oit

import "core:fmt"
import "core:mem"
import "core:math"

// Improved transparency: vanilla 26.3's order-independent transparency
// (`LevelRenderer.executeOit`). The translucent layer is drawn three times
// against the opaque world's depth, without writing it, into targets the
// next stage reads (`oit.wgsl` says what each holds), then a full-screen pass
// composites the sum. With the option off none of this exists and the world
// draws as before.

// use super::oit_features::Features;
// use glam::Mat4;

// The depth bounds' clear: `LevelRenderer.DEPTH_BOUNDS_CLEAR_COLOR`.
    // rust: const BOUNDS_CLEAR: wgpu::Color = wgpu::Color {
    // rust: r: -(f32::MAX as f64),
    // rust: g: 0.0,
    // rust: b: 0.0,
    // rust: a: 0.0,
}
BOUNDS_FORMAT :: wgpu::TextureFormat::Rgba32Float
COEFFICIENT_FORMAT :: wgpu::TextureFormat::Rgba16Float
// The shader's bind group: `terrain.wgsl` holds groups 0 and 1.
GROUP :: 2

// `OitStage`.
Stage :: enum {
    DepthBounds,
    Transmittance,
    Accumulate,
}

// What the device must support: max blending on 32-bit float targets.
features :: proc(adapter: ^wgpu::Adapter) -> w {
    // Ported from Horizon
    return {}
}
    // rust: adapter.features() & wgpu::Features::FLOAT32_BLENDABLE
}

supported :: proc(device: ^wgpu::Device) -> b {
    // Ported from Horizon
    return {}
}
    // rust: device
    // rust: .features()
    // rust: .contains(wgpu::Features::FLOAT32_BLENDABLE)
}

// What a stage's pipelines write: `OIT_*_SNIPPET`'s colour targets.
    // rust: pub(super) fn stage_targets(stage: Stage) -> Vec<Option<wgpu::ColorTargetState>> {
    // rust: let blend = |operation| wgpu::BlendComponent {
    // rust: src_factor: wgpu::BlendFactor::One,
    // rust: dst_factor: wgpu::BlendFactor::One,
    // rust: operation,
}
    // rust: let target = |format, operation| {
    // rust: Some(wgpu::ColorTargetState {
    // rust: format,
    // rust: blend: Some(wgpu::BlendState {
    // rust: color: blend(operation),
    // rust: alpha: blend(operation),
    // rust: }),
    // rust: write_mask: wgpu::ColorWrites::ALL,
    // rust: })
}
    // rust: let add = wgpu::BlendOperation::Add;
    // rust: match stage {
    // rust: Stage::DepthBounds => vec![target(BOUNDS_FORMAT, wgpu::BlendOperation::Max)],
    // rust: Stage::Transmittance => vec![
    // rust: target(COEFFICIENT_FORMAT, add),
    // rust: target(COEFFICIENT_FORMAT, add),
    // rust: ],
    // rust: Stage::Accumulate => vec![target(COEFFICIENT_FORMAT, add)],
}
}

// `ProjMat[2][2]` and `ProjMat[3][2]`: a device depth `d` is `y / (d + x)`
// blocks along the view axis (`oit_linear_depth`).
projection_terms :: proc(projection: ^Mat4) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: [projection.z_axis.z, projection.w_axis.z]
}

Targets :: struct {
    size: [u32,
    bounds: wgpu::Texture,
    culled: wgpu::Texture,
    views: Views,
    // The uniform alone, with the culled bounds, with those and the
    // coefficients, for the cull with the unculled bounds, and the composite.
    alone: wgpu::BindGroup,
    sampled: wgpu::BindGroup,
    accumulate: wgpu::BindGroup,
    cull: wgpu::BindGroup,
    composite: wgpu::BindGroup,
    // The depth the terrain's stages test against while a water mask is
    // drawn (a copy of the world's, plus the masks), and the clouds' own.
    terrain_depth: Maybe(Depth),
    cloud_depth: Maybe(Depth),
}

Depth :: struct {
    texture: wgpu::Texture,
    view: wgpu::TextureView,
}

    // rust: impl Depth {
new :: proc(device: ^wgpu::Device, label: string, size: [u32; 2]) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let texture = device.create_texture(&wgpu::TextureDescriptor {
    // rust: label: Some(label),
    // rust: size: extent(size),
    // rust: mip_level_count: 1,
    // rust: sample_count: 1,
    // rust: dimension: wgpu::TextureDimension::D2,
    // rust: format: wgpu::TextureFormat::Depth32Float,
    // rust: usage: wgpu::TextureUsages::RENDER_ATTACHMENT | wgpu::TextureUsages::COPY_DST,
    // rust: view_formats: &[],
    // rust: });
    // rust: Self {
    // rust: view: texture.create_view(&Default::default()),
    // rust: texture,
}
}
}

extent :: proc(size: [u32; 2]) -> w {
    // Ported from Horizon
    return {}
}
    // rust: wgpu::Extent3d {
    // rust: width: size[0].max(1),
    // rust: height: size[1].max(1),
    // rust: depth_or_array_layers: 1,
}
}

// What the translucent layer's other drawers add to a frame: each draws with
// a pipeline per stage where it has one.
Extras :: struct {
    // `executeOitWaterMask`: the boats' water patches, depth only.
    water_mask: Maybe(^'a dyn Fn(^wgpu::RenderPass<'_))>,
    // `CloudRenderer.renderOit`: draws the clouds with the pipeline given.
    clouds: Maybe(^'a dyn Fn(^wgpu::RenderPass<'_),
    // "Features, World Border, Weather": draws what the entity, weather and
    // border shaders put after the opaque world, with `Oit::features`'s
    // pipelines of the stage.
    features: Maybe(^'a dyn Fn(^wgpu::RenderPass<'_),
}

Views :: struct {
    bounds: wgpu::TextureView,
    culled: wgpu::TextureView,
    coefficients: [wgpu::TextureView,
    accumulated: wgpu::TextureView,
}

Oit :: struct {
    uniform: wgpu::Buffer,
    // Layouts of the groups at `GROUP`: the uniform; with the bounds; with the
    // coefficients; and with the accumulation too.
    layouts: [wgpu::BindGroupLayout,
    // One per `Stage`.
    terrain: [wgpu::RenderPipeline,
    // The terrain's flat section draws (`Flat`), where the device has them.
    flat: Option<[wgpu::RenderPipeline,
    features: Features,
    clouds: [wgpu::RenderPipeline,
    cull: wgpu::RenderPipeline,
    composite: wgpu::RenderPipeline,
    targets: Maybe(Targets),
}

    // rust: impl Oit {
    // `terrain`: the terrain bind group layout that `vs_terrain` reads,
    // `flat` the flat draws' second group, `features` the entity, weather
    // and world border layouts,
    // `clouds` the cloud pipeline's two, `sprites` the terrain's override
    // constants, `format` the world target's.
    // rust: pub fn new(
    // rust: device: &wgpu::Device,
    // rust: terrain: &wgpu::BindGroupLayout,
    // rust: flat: Option<&wgpu::BindGroupLayout>,
    // rust: features: [&wgpu::BindGroupLayout; 3],
    // rust: clouds: [&wgpu::BindGroupLayout; 2],
    // rust: sprites: [f64; 2],
    // rust: format: wgpu::TextureFormat,
    // rust: ) -> Self {
    // rust: let instance = wgpu::vertex_attr_array![5=>Float32x4];
    // rust: let buffers = [
    // rust: Some(wgpu::VertexBufferLayout {
    // rust: array_stride: std::mem::size_of::<super::TerrainVertex>() as u64,
    // rust: step_mode: wgpu::VertexStepMode::Vertex,
    // rust: attributes: &super::TERRAIN_ATTRIBUTES,
    // rust: }),
    // rust: Some(wgpu::VertexBufferLayout {
    // rust: array_stride: 16,
    // rust: step_mode: wgpu::VertexStepMode::Instance,
    // rust: attributes: &instance,
    // rust: }),
    // rust: ];
    // rust: let buffers = &buffers[..];
    // rust: let shader = device.create_shader_module(wgpu::ShaderModuleDescriptor {
    // rust: label: Some("Horizon improved transparency"),
    // rust: source: wgpu::ShaderSource::Wgsl(
    // rust: (include_str!("../terrain.wgsl").to_owned()
    // rust: + include_str!("../oit.wgsl")
    // rust: + include_str!("../oit_world.wgsl"))
    // rust: .into(),
    // rust: ),
    // rust: });
    // rust: let uniform = device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: Some("Improved transparency"),
    // rust: size: 16,
    // rust: usage: wgpu::BufferUsages::UNIFORM | wgpu::BufferUsages::COPY_DST,
    // rust: mapped_at_creation: false,
    // rust: });
    // rust: let entry = |binding: u32, ty| wgpu::BindGroupLayoutEntry {
    // rust: binding,
    // rust: visibility: wgpu::ShaderStages::FRAGMENT,
    // rust: ty,
    // rust: count: None,
}
    // rust: let texture = |binding| {
    // rust: entry(
    // rust: binding,
    // rust: wgpu::BindingType::Texture {
    // rust: sample_type: wgpu::TextureSampleType::Float { filterable: false },
    // rust: view_dimension: wgpu::TextureViewDimension::D2,
    // rust: multisampled: false,
    // rust: },
    // rust: )
}
    // rust: let params = entry(
    // rust: 0,
    // rust: wgpu::BindingType::Buffer {
    // rust: ty: wgpu::BufferBindingType::Uniform,
    // rust: has_dynamic_offset: false,
    // rust: min_binding_size: None,
    // rust: },
    // rust: );
    // rust: let layout = |label, entries: &[wgpu::BindGroupLayoutEntry]| {
    // rust: device.create_bind_group_layout(&wgpu::BindGroupLayoutDescriptor {
    // rust: label: Some(label),
    // rust: entries,
    // rust: })
}
    // rust: let layouts = [
    // rust: layout("Improved transparency", &[params]),
    // rust: layout("Improved transparency bounds", &[params, texture(1)]),
    // rust: layout(
    // rust: "Improved transparency coefficients",
    // rust: &[params, texture(1), texture(2), texture(3)],
    // rust: ),
    // rust: layout(
    // rust: "Improved transparency composite",
    // rust: &[params, texture(1), texture(2), texture(3), texture(4)],
    // rust: ),
    // rust: ];
    // rust: let pipeline_layout = |first: Option<&wgpu::BindGroupLayout>, group: usize| {
    // rust: device.create_pipeline_layout(&wgpu::PipelineLayoutDescriptor {
    // rust: label: Some("Improved transparency"),
    // rust: bind_group_layouts: &[first, None, Some(&layouts[group])],
    // rust: ..Default::default()
    // rust: })
}
    // rust: let constants = [("SPRITE_ARRAYS", sprites[0]), ("SPRITE_SPLIT", sprites[1])];
    // rust: let add = wgpu::BlendOperation::Add;
    // rust: let depth = |write| {
    // rust: Some(wgpu::DepthStencilState {
    // rust: format: wgpu::TextureFormat::Depth32Float,
    // rust: depth_write_enabled: Some(write),
    // rust: depth_compare: Some(wgpu::CompareFunction::GreaterEqual),
    // rust: stencil: Default::default(),
    // rust: bias: Default::default(),
    // rust: })
}
    // rust: let pipeline = |label,
    // rust: layout: &wgpu::PipelineLayout,
    // rust: vertex: &str,
    // rust: fragment: &str,
    // rust: buffers: &[Option<wgpu::VertexBufferLayout<'_>>],
    // rust: targets: &[Option<wgpu::ColorTargetState>],
    // rust: depth_stencil| {
    // rust: device.create_render_pipeline(&wgpu::RenderPipelineDescriptor {
    // rust: label: Some(label),
    // rust: layout: Some(layout),
    // rust: vertex: wgpu::VertexState {
    // rust: module: &shader,
    // rust: entry_point: Some(vertex),
    // rust: compilation_options: wgpu::PipelineCompilationOptions {
    // rust: constants: &constants,
    // rust: ..Default::default()
    // rust: },
    // rust: buffers,
    // rust: },
    // rust: primitive: wgpu::PrimitiveState {
    // rust: cull_mode: vertex.starts_with("vs_terrain").then_some(wgpu::Face::Back),
    // rust: ..Default::default()
    // rust: },
    // rust: depth_stencil,
    // rust: multisample: Default::default(),
    // rust: fragment: Some(wgpu::FragmentState {
    // rust: module: &shader,
    // rust: entry_point: Some(fragment),
    // rust: compilation_options: wgpu::PipelineCompilationOptions {
    // rust: constants: &constants,
    // rust: ..Default::default()
    // rust: },
    // rust: targets,
    // rust: }),
    // rust: multiview_mask: None,
    // rust: cache: None,
    // rust: })
}
    // rust: let terrain_pipeline = |label, fragment, stage| {
    // rust: pipeline(
    // rust: label,
    // rust: &pipeline_layout(Some(terrain), stage as usize),
    // rust: "vs_terrain",
    // rust: fragment,
    // rust: buffers,
    // rust: &stage_targets(stage),
    // rust: depth(false),
    // rust: )
}
    // rust: let terrain_pipelines = [
    // rust: terrain_pipeline("OIT depth bounds", "fs_oit_bounds", Stage::DepthBounds),
    // rust: terrain_pipeline(
    // rust: "OIT transmittance",
    // rust: "fs_oit_transmittance",
    // rust: Stage::Transmittance,
    // rust: ),
    // rust: terrain_pipeline("OIT accumulate", "fs_oit_accumulate", Stage::Accumulate),
    // rust: ];
        // The same fragments over `vs_terrain_flat`: one vertex buffer, and
        // the draw table at group 1.
    // rust: let flat_pipelines = flat.map(|draw| {
    // rust: let flat_buffers = &buffers[..1];
    // rust: [
    // rust: (
    // rust: "OIT depth bounds (flat)",
    // rust: "fs_oit_bounds",
    // rust: Stage::DepthBounds,
    // rust: ),
    // rust: (
    // rust: "OIT transmittance (flat)",
    // rust: "fs_oit_transmittance",
    // rust: Stage::Transmittance,
    // rust: ),
    // rust: (
    // rust: "OIT accumulate (flat)",
    // rust: "fs_oit_accumulate",
    // rust: Stage::Accumulate,
    // rust: ),
    // rust: ]
    // rust: .map(|(label, fragment, stage)| {
    // rust: let layout = device.create_pipeline_layout(&wgpu::PipelineLayoutDescriptor {
    // rust: label: Some("Improved transparency flat terrain"),
    // rust: bind_group_layouts: &[
    // rust: Some(terrain),
    // rust: Some(draw),
    // rust: Some(&layouts[stage as usize]),
    // rust: ],
    // rust: ..Default::default()
    // rust: });
    // rust: pipeline(
    // rust: label,
    // rust: &layout,
    // rust: "vs_terrain_flat",
    // rust: fragment,
    // rust: flat_buffers,
    // rust: &stage_targets(stage),
    // rust: depth(false),
    // rust: )
    // rust: })
    // rust: });
    // rust: let screen = |label, fragment, group, targets: &[_], depth_stencil| {
    // rust: pipeline(
    // rust: label,
    // rust: &pipeline_layout(None, group),
    // rust: "vs_sky",
    // rust: fragment,
    // rust: &[],
    // rust: targets,
    // rust: depth_stencil,
    // rust: )
}
    // rust: let replace = |format| {
    // rust: Some(wgpu::ColorTargetState {
    // rust: format,
    // rust: blend: None,
    // rust: write_mask: wgpu::ColorWrites::ALL,
    // rust: })
}
    // rust: let cull = screen(
    // rust: "OIT cull depth bounds",
    // rust: "fs_oit_cull",
    // rust: 1,
    // rust: &[replace(BOUNDS_FORMAT)],
    // rust: depth(true),
    // rust: );
        // `RenderPipelines.OIT_COMPOSITE`: premultiplied alpha over the world,
        // the nearest see-through depth written.
    // rust: let premultiplied = wgpu::BlendComponent {
    // rust: src_factor: wgpu::BlendFactor::One,
    // rust: dst_factor: wgpu::BlendFactor::OneMinusSrcAlpha,
    // rust: operation: add,
}
    // rust: let composite = screen(
    // rust: "OIT composite",
    // rust: "fs_oit_composite",
    // rust: 3,
    // rust: &[Some(wgpu::ColorTargetState {
    // rust: format,
    // rust: blend: Some(wgpu::BlendState {
    // rust: color: premultiplied,
    // rust: alpha: premultiplied,
    // rust: }),
    // rust: write_mask: wgpu::ColorWrites::ALL,
    // rust: })],
    // rust: Some(wgpu::DepthStencilState {
    // rust: format: wgpu::TextureFormat::Depth32Float,
    // rust: depth_write_enabled: Some(true),
    // rust: depth_compare: Some(wgpu::CompareFunction::Always),
    // rust: stencil: Default::default(),
    // rust: bias: Default::default(),
    // rust: }),
    // rust: );
        // The clouds: entity.wgsl's vertex shader and vertex format, with the
        // stages' fragments.
    // rust: let cloud_shader = device.create_shader_module(wgpu::ShaderModuleDescriptor {
    // rust: label: Some("Horizon improved transparency clouds"),
    // rust: source: wgpu::ShaderSource::Wgsl(
    // rust: (super::entity_shader()
    // rust: + include_str!("../oit.wgsl")
    // rust: + include_str!("../oit_clouds.wgsl"))
    // rust: .into(),
    // rust: ),
    // rust: });
    // rust: let cloud_attributes = wgpu::vertex_attr_array![0=>Float32x3,1=>Float32x2,2=>Uint32,3=>Unorm8x4,4=>Uint8x4,5=>Snorm8x4,6=>Float32x2];
    // rust: let cloud_buffers = [Some(wgpu::VertexBufferLayout {
    // rust: array_stride: std::mem::size_of::<super::Vertex>() as u64,
    // rust: step_mode: wgpu::VertexStepMode::Vertex,
    // rust: attributes: &cloud_attributes,
    // rust: })];
    // rust: let cloud_pipeline = |label, fragment, stage: Stage| {
    // rust: device.create_render_pipeline(&wgpu::RenderPipelineDescriptor {
    // rust: label: Some(label),
    // rust: layout: Some(
    // rust: &device.create_pipeline_layout(&wgpu::PipelineLayoutDescriptor {
    // rust: label: Some("Improved transparency clouds"),
    // rust: bind_group_layouts: &[
    // rust: Some(clouds[0]),
    // rust: Some(clouds[1]),
    // rust: Some(&layouts[stage as usize]),
    // rust: ],
    // rust: ..Default::default()
    // rust: }),
    // rust: ),
    // rust: vertex: wgpu::VertexState {
    // rust: module: &cloud_shader,
    // rust: entry_point: Some("vs_cloud"),
    // rust: compilation_options: Default::default(),
    // rust: buffers: &cloud_buffers,
    // rust: },
    // rust: primitive: wgpu::PrimitiveState {
    // rust: cull_mode: Some(wgpu::Face::Back),
    // rust: ..Default::default()
    // rust: },
                // `OIT_CLOUDS`: only the bounds stage writes the cloud depth,
                // so the later stages keep the nearest face of each cloud.
    // rust: depth_stencil: depth(stage == Stage::DepthBounds),
    // rust: multisample: Default::default(),
    // rust: fragment: Some(wgpu::FragmentState {
    // rust: module: &cloud_shader,
    // rust: entry_point: Some(fragment),
    // rust: compilation_options: Default::default(),
    // rust: targets: &stage_targets(stage),
    // rust: }),
    // rust: multiview_mask: None,
    // rust: cache: None,
    // rust: })
}
    // rust: let cloud_pipelines = [
    // rust: cloud_pipeline(
    // rust: "OIT cloud depth bounds",
    // rust: "fs_oit_cloud_bounds",
    // rust: Stage::DepthBounds,
    // rust: ),
    // rust: cloud_pipeline(
    // rust: "OIT cloud transmittance",
    // rust: "fs_oit_cloud_transmittance",
    // rust: Stage::Transmittance,
    // rust: ),
    // rust: cloud_pipeline(
    // rust: "OIT cloud accumulate",
    // rust: "fs_oit_cloud_accumulate",
    // rust: Stage::Accumulate,
    // rust: ),
    // rust: ];
    // rust: let features = Features::new(device, &layouts, features[0], features[1], features[2]);
    // rust: Self {
    // rust: uniform,
    // rust: layouts,
    // rust: terrain: terrain_pipelines,
    // rust: flat: flat_pipelines,
    // rust: features,
    // rust: clouds: cloud_pipelines,
    // rust: cull,
    // rust: composite,
    // rust: targets: None,
}
}

    // The pipeline the terrain's translucent layer draws with in `stage`.
terrain :: proc(self: ^Self, stage: Stage) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &self.terrain[stage as usize]
}

    // The pipeline the terrain's translucent layer draws with in `stage`
    // as flat section draws, where they run.
flat :: proc(self: ^Self, stage: Stage) -> O {
    // Ported from Horizon
    return {}
}
    // rust: self.flat.as_ref().map(|f| &f[stage as usize])
}

features :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: &self.features
}

    // Sizes the targets to the world's and writes this frame's projection.
    // rust: pub fn prepare(
    // rust: &mut self,
    // rust: device: &wgpu::Device,
    // rust: queue: &wgpu::Queue,
    // rust: size: [u32; 2],
    // rust: projection: &Mat4,
    // rust: wants: [bool; 2],
    // rust: ) {
    // rust: queue.write_buffer(
    // rust: &self.uniform,
    // rust: 0,
    // rust: bytemuck::cast_slice(&[projection_terms(projection), [0.0; 2]].concat()),
    // rust: );
    // rust: let [mask, clouds] = wants;
    // rust: if let Some(t) = self.targets.as_mut().filter(|t| t.size == size) {
    // rust: if mask && t.terrain_depth.is_none() {
    // rust: t.terrain_depth = Some(Depth::new(device, "OIT terrain depth", size));
}
    // rust: if clouds && t.cloud_depth.is_none() {
    // rust: t.cloud_depth = Some(Depth::new(device, "OIT cloud depth", size));
}
    // rust: return;
}
    // rust: let make = |label, format, usage| {
    // rust: device.create_texture(&wgpu::TextureDescriptor {
    // rust: label: Some(label),
    // rust: size: extent(size),
    // rust: mip_level_count: 1,
    // rust: sample_count: 1,
    // rust: dimension: wgpu::TextureDimension::D2,
    // rust: format,
    // rust: usage,
    // rust: view_formats: &[],
    // rust: })
}
    // rust: let attachment =
    // rust: wgpu::TextureUsages::RENDER_ATTACHMENT | wgpu::TextureUsages::TEXTURE_BINDING;
    // rust: let bounds = make(
    // rust: "OIT depth bounds",
    // rust: BOUNDS_FORMAT,
    // rust: attachment | wgpu::TextureUsages::COPY_SRC,
    // rust: );
    // rust: let culled = make(
    // rust: "OIT culled depth bounds",
    // rust: BOUNDS_FORMAT,
    // rust: attachment | wgpu::TextureUsages::COPY_DST,
    // rust: );
    // rust: let coefficients =
    // rust: [0, 1].map(|_| make("OIT transmittance", COEFFICIENT_FORMAT, attachment));
    // rust: let accumulated = make("OIT accumulate", COEFFICIENT_FORMAT, attachment);
    // rust: let views = Views {
    // rust: bounds: bounds.create_view(&Default::default()),
    // rust: culled: culled.create_view(&Default::default()),
    // rust: coefficients: coefficients.map(|t| t.create_view(&Default::default())),
    // rust: accumulated: accumulated.create_view(&Default::default()),
}
    // rust: let group = |layout: &wgpu::BindGroupLayout, views: &[&wgpu::TextureView]| {
    // rust: let mut entries = vec![wgpu::BindGroupEntry {
    // rust: binding: 0,
    // rust: resource: self.uniform.as_entire_binding(),
    // rust: }];
    // rust: entries.extend(views.iter().enumerate().map(|(i, v)| wgpu::BindGroupEntry {
    // rust: binding: i as u32 + 1,
    // rust: resource: wgpu::BindingResource::TextureView(v),
    // rust: }));
    // rust: device.create_bind_group(&wgpu::BindGroupDescriptor {
    // rust: label: Some("Improved transparency"),
    // rust: layout,
    // rust: entries: &entries,
    // rust: })
}
    // rust: let [c0, c1] = &views.coefficients;
    // rust: self.targets = Some(Targets {
    // rust: size,
    // rust: alone: group(&self.layouts[0], &[]),
    // rust: sampled: group(&self.layouts[1], &[&views.culled]),
    // rust: accumulate: group(&self.layouts[2], &[&views.culled, c0, c1]),
    // rust: cull: group(&self.layouts[1], &[&views.bounds]),
    // rust: composite: group(
    // rust: &self.layouts[3],
    // rust: &[&views.bounds, c0, c1, &views.accumulated],
    // rust: ),
    // rust: terrain_depth: mask.then(|| Depth::new(device, "OIT terrain depth", size)),
    // rust: cloud_depth: clouds.then(|| Depth::new(device, "OIT cloud depth", size)),
    // rust: bounds,
    // rust: culled,
    // rust: views,
    // rust: });
}

    // `LevelRenderer.executeOit`: `draw` records the terrain's translucent
    // layer into each stage's pass with that stage's pipeline, `extras` the
    // water masks and clouds, then the composite goes over `color`. `depth`
    // is the opaque world's: the stages only read it; the cull and the
    // composite write it.
    // rust: pub fn run(
    // rust: &self,
    // rust: encoder: &mut wgpu::CommandEncoder,
    // rust: color: &wgpu::TextureView,
    // rust: depth: &wgpu::TextureView,
    // rust: draw: &dyn Fn(&mut wgpu::RenderPass<'_>, Stage),
    // rust: extras: &Extras<'_>,
    // rust: mut timing: Option<&mut super::pack_timing::PassTiming>,
    // rust: ) {
    // rust: let Some(t) = &self.targets else { return };
    // rust: let attachment = |view, load| {
    // rust: Some(wgpu::RenderPassColorAttachment {
    // rust: view,
    // rust: resolve_target: None,
    // rust: depth_slice: None,
    // rust: ops: wgpu::Operations {
    // rust: load,
    // rust: store: wgpu::StoreOp::Store,
    // rust: },
    // rust: })
}
    // rust: let clear = wgpu::LoadOp::Clear(wgpu::Color::TRANSPARENT);
    // rust: let load = wgpu::LoadOp::Load;
    // rust: let read_only = |view| {
    // rust: Some(wgpu::RenderPassDepthStencilAttachment {
    // rust: view,
    // rust: depth_ops: None,
    // rust: stencil_ops: None,
    // rust: })
}
    // rust: let water_mask = extras.water_mask.zip(t.terrain_depth.as_ref());
    // rust: let cloud_depth = extras.clouds.zip(t.cloud_depth.as_ref());
    // rust: if let Some((mask, _)) = water_mask {
    // rust: self.execute_water_mask(encoder, t, color, depth, mask, timing.as_deref_mut());
}
    // rust: let terrain_depth = water_mask.map_or(depth, |(_, d)| &d.view);
    // rust: let [c0, c1] = &t.views.coefficients;
    // rust: let culled = &t.views.culled;
    // rust: for (stage, label, group, first, then) in [
    // rust: (
    // rust: Stage::DepthBounds,
    // rust: "OIT depth bounds",
    // rust: &t.alone,
    // rust: vec![attachment(
    // rust: &t.views.bounds,
    // rust: wgpu::LoadOp::Clear(BOUNDS_CLEAR),
    // rust: )],
                // The clouds' bounds join the culled ones.
    // rust: vec![attachment(culled, load)],
    // rust: ),
    // rust: (
    // rust: Stage::Transmittance,
    // rust: "OIT transmittance",
    // rust: &t.sampled,
    // rust: vec![attachment(c0, clear), attachment(c1, clear)],
    // rust: vec![attachment(c0, load), attachment(c1, load)],
    // rust: ),
    // rust: (
    // rust: Stage::Accumulate,
    // rust: "OIT accumulate",
    // rust: &t.accumulate,
    // rust: vec![attachment(&t.views.accumulated, clear)],
    // rust: vec![attachment(&t.views.accumulated, load)],
    // rust: ),
    // rust: ] {
    // rust: {
    // rust: let mut pass = encoder.begin_render_pass(&wgpu::RenderPassDescriptor {
    // rust: label: Some(label),
    // rust: timestamp_writes: timing.as_deref_mut().and_then(|t| t.writes(label)),
    // rust: color_attachments: &first,
    // rust: depth_stencil_attachment: read_only(terrain_depth),
    // rust: ..Default::default()
    // rust: });
    // rust: pass.set_bind_group(GROUP, group, &[]);
    // rust: draw(&mut pass, stage);
}
    // rust: if let Some(features) = extras.features {
                // Over the world's own depth, even where a water mask patched
                // the terrain's: the masks only hide water.
    // rust: let mut pass = encoder.begin_render_pass(&wgpu::RenderPassDescriptor {
    // rust: label: Some(label),
    // rust: timestamp_writes: timing.as_deref_mut().and_then(|t| t.writes("OIT features")),
    // rust: color_attachments: &[attachment(
    // rust: match stage {
    // rust: Stage::DepthBounds => &t.views.bounds,
    // rust: Stage::Transmittance => c0,
    // rust: Stage::Accumulate => &t.views.accumulated,
    // rust: },
    // rust: load,
    // rust: )]
    // rust: .into_iter()
    // rust: .chain((stage == Stage::Transmittance).then(|| attachment(c1, load)))
    // rust: .collect::<Vec<_>>(),
    // rust: depth_stencil_attachment: read_only(depth),
    // rust: ..Default::default()
    // rust: });
    // rust: pass.set_bind_group(GROUP, group, &[]);
    // rust: features(&mut pass, stage);
}
    // rust: if stage == Stage::DepthBounds {
    // rust: self.execute_depth_bounds_cull(encoder, t, depth, timing.as_deref_mut());
}
    // rust: if let Some((clouds, cloud_depth)) = cloud_depth {
    // rust: self.render_clouds(
    // rust: encoder,
    // rust: t,
    // rust: stage,
    // rust: depth,
    // rust: (label, group, &then),
    // rust: (clouds, cloud_depth),
    // rust: timing.as_deref_mut(),
    // rust: );
}
    // rust: if stage == Stage::DepthBounds
    // rust: && let Some((mask, _)) = water_mask
    // rust: {
    // rust: self.execute_water_mask(encoder, t, color, depth, mask, timing.as_deref_mut());
}
}
    // rust: let mut pass = encoder.begin_render_pass(&wgpu::RenderPassDescriptor {
    // rust: label: Some("OIT composite"),
    // rust: timestamp_writes: timing.and_then(|t| t.writes("OIT composite")),
    // rust: color_attachments: &[attachment(color, wgpu::LoadOp::Load)],
    // rust: depth_stencil_attachment: Some(wgpu::RenderPassDepthStencilAttachment {
    // rust: view: depth,
    // rust: depth_ops: Some(wgpu::Operations {
    // rust: load: wgpu::LoadOp::Load,
    // rust: store: wgpu::StoreOp::Store,
    // rust: }),
    // rust: stencil_ops: None,
    // rust: }),
    // rust: ..Default::default()
    // rust: });
    // rust: pass.set_pipeline(&self.composite);
    // rust: pass.set_bind_group(GROUP, &t.composite, &[]);
    // rust: pass.draw(0..3, 0..1);
}

    // `CloudRenderer.renderOit` for one stage. The bounds stage first copies
    // the world's depth (after the cull) and draws into it, so the later
    // stages, which only read it, keep each pixel's nearest cloud face.
    // rust: fn render_clouds(
    // rust: &self,
    // rust: encoder: &mut wgpu::CommandEncoder,
    // rust: t: &Targets,
    // rust: stage: Stage,
    // rust: depth: &wgpu::TextureView,
    // rust: (label, group, targets): (
    // rust: &str,
    // rust: &wgpu::BindGroup,
    // rust: &[Option<wgpu::RenderPassColorAttachment<'_>>],
    // rust: ),
    // rust: (draw, cloud_depth): (
    // rust: &dyn Fn(&mut wgpu::RenderPass<'_>, &wgpu::RenderPipeline),
    // rust: &Depth,
    // rust: ),
    // rust: timing: Option<&mut super::pack_timing::PassTiming>,
    // rust: ) {
    // rust: if stage == Stage::DepthBounds {
    // rust: encoder.copy_texture_to_texture(
    // rust: depth.texture().as_image_copy(),
    // rust: cloud_depth.texture.as_image_copy(),
    // rust: extent(t.size),
    // rust: );
}
    // rust: let mut pass = encoder.begin_render_pass(&wgpu::RenderPassDescriptor {
    // rust: label: Some(label),
    // rust: timestamp_writes: timing.and_then(|t| t.writes("OIT clouds")),
    // rust: color_attachments: targets,
    // rust: depth_stencil_attachment: Some(wgpu::RenderPassDepthStencilAttachment {
    // rust: view: &cloud_depth.view,
    // rust: depth_ops: (stage == Stage::DepthBounds).then_some(wgpu::Operations {
    // rust: load: wgpu::LoadOp::Load,
    // rust: store: wgpu::StoreOp::Store,
    // rust: }),
    // rust: stencil_ops: None,
    // rust: }),
    // rust: ..Default::default()
    // rust: });
    // rust: pass.set_bind_group(GROUP, group, &[]);
    // rust: draw(&mut pass, &self.clouds[stage as usize]);
}

    // `LevelRenderer.executeOitWaterMask`: the terrain's depth is the world's
    // again, with the boats' water patches on top.
    // rust: fn execute_water_mask(
    // rust: &self,
    // rust: encoder: &mut wgpu::CommandEncoder,
    // rust: t: &Targets,
    // rust: color: &wgpu::TextureView,
    // rust: depth: &wgpu::TextureView,
    // rust: mask: &dyn Fn(&mut wgpu::RenderPass<'_>),
    // rust: timing: Option<&mut super::pack_timing::PassTiming>,
    // rust: ) {
    // rust: let Some(terrain) = &t.terrain_depth else {
    // rust: return;
}
    // rust: encoder.copy_texture_to_texture(
    // rust: depth.texture().as_image_copy(),
    // rust: terrain.texture.as_image_copy(),
    // rust: extent(t.size),
    // rust: );
        // The mask pipeline writes depth only but has a colour target.
    // rust: let mut pass = encoder.begin_render_pass(&wgpu::RenderPassDescriptor {
    // rust: label: Some("OIT water mask"),
    // rust: timestamp_writes: timing.and_then(|t| t.writes("OIT water mask")),
    // rust: color_attachments: &[Some(wgpu::RenderPassColorAttachment {
    // rust: view: color,
    // rust: resolve_target: None,
    // rust: depth_slice: None,
    // rust: ops: wgpu::Operations {
    // rust: load: wgpu::LoadOp::Load,
    // rust: store: wgpu::StoreOp::Store,
    // rust: },
    // rust: })],
    // rust: depth_stencil_attachment: Some(wgpu::RenderPassDepthStencilAttachment {
    // rust: view: &terrain.view,
    // rust: depth_ops: Some(wgpu::Operations {
    // rust: load: wgpu::LoadOp::Load,
    // rust: store: wgpu::StoreOp::Store,
    // rust: }),
    // rust: stencil_ops: None,
    // rust: }),
    // rust: ..Default::default()
    // rust: });
    // rust: mask(&mut pass);
}

    // `LevelRenderer.executeDepthBoundsCull`: the bounds are copied, then where
    // the nearest fully opaque see-through fragment is in front of the world,
    // the far bound stops there and its depth replaces the world's.
    // rust: fn execute_depth_bounds_cull(
    // rust: &self,
    // rust: encoder: &mut wgpu::CommandEncoder,
    // rust: t: &Targets,
    // rust: depth: &wgpu::TextureView,
    // rust: timing: Option<&mut super::pack_timing::PassTiming>,
    // rust: ) {
    // rust: encoder.copy_texture_to_texture(
    // rust: t.bounds.as_image_copy(),
    // rust: t.culled.as_image_copy(),
    // rust: wgpu::Extent3d {
    // rust: width: t.size[0].max(1),
    // rust: height: t.size[1].max(1),
    // rust: depth_or_array_layers: 1,
    // rust: },
    // rust: );
    // rust: let mut pass = encoder.begin_render_pass(&wgpu::RenderPassDescriptor {
    // rust: label: Some("OIT cull depth bounds"),
    // rust: timestamp_writes: timing.and_then(|t| t.writes("OIT cull depth bounds")),
    // rust: color_attachments: &[Some(wgpu::RenderPassColorAttachment {
    // rust: view: &t.views.culled,
    // rust: resolve_target: None,
    // rust: depth_slice: None,
    // rust: ops: wgpu::Operations {
    // rust: load: wgpu::LoadOp::Load,
    // rust: store: wgpu::StoreOp::Store,
    // rust: },
    // rust: })],
    // rust: depth_stencil_attachment: Some(wgpu::RenderPassDepthStencilAttachment {
    // rust: view: depth,
    // rust: depth_ops: Some(wgpu::Operations {
    // rust: load: wgpu::LoadOp::Load,
    // rust: store: wgpu::StoreOp::Store,
    // rust: }),
    // rust: stencil_ops: None,
    // rust: }),
    // rust: ..Default::default()
    // rust: });
    // rust: pass.set_pipeline(&self.cull);
    // rust: pass.set_bind_group(GROUP, &t.cull, &[]);
    // rust: pass.draw(0..3, 0..1);
}
}

    // rust: mod tests {
//     use super::*;

validate :: proc(source: string, entries: ^[string]) {
}
    // rust: let module = naga::front::wgsl::parse_str(source).unwrap();
    // rust: naga::valid::Validator::new(
    // rust: naga::valid::ValidationFlags::all(),
    // rust: naga::valid::Capabilities::all(),
    // rust: )
    // rust: .validate(&module)
    // rust: .unwrap();
    // rust: for entry in entries {
    // rust: assert!(
    // rust: module.entry_points.iter().any(|e| e.name == *entry),
    // rust: "{entry}"
    // rust: );
}
}

the_terrain_shader_validates :: proc() {
}
    // rust: validate(
    // rust: &(include_str!("../terrain.wgsl").to_owned()
    // rust: + include_str!("../oit.wgsl")
    // rust: + include_str!("../oit_world.wgsl")),
    // rust: &[
    // rust: "fs_oit_bounds",
    // rust: "fs_oit_transmittance",
    // rust: "fs_oit_accumulate",
    // rust: "fs_oit_cull",
    // rust: "fs_oit_composite",
    // rust: ],
    // rust: );
}

the_cloud_shader_validates :: proc() {
}
    // rust: validate(
    // rust: &(super::super::entity_shader()
    // rust: + include_str!("../oit.wgsl")
    // rust: + include_str!("../oit_clouds.wgsl")),
    // rust: &[
    // rust: "fs_oit_cloud_bounds",
    // rust: "fs_oit_cloud_transmittance",
    // rust: "fs_oit_cloud_accumulate",
    // rust: ],
    // rust: );
}

the_feature_shaders_validate :: proc() {
}
    // rust: let stages = |name: &str| {
    // rust: ["bounds", "transmittance", "accumulate"].map(|s| format!("fs_oit_{name}_{s}"))
}
    // rust: let entity = ["entity", "shadow", "weather", "swirl"]
    // rust: .map(stages)
    // rust: .concat();
    // rust: validate(
    // rust: &(super::super::entity_shader()
    // rust: + include_str!("../oit.wgsl")
    // rust: + include_str!("../oit_features.wgsl")),
    // rust: &entity.iter().map(String::as_str).collect::<Vec<_>>(),
    // rust: );
    // rust: let border = stages("border");
    // rust: validate(
    // rust: &(include_str!("../border.wgsl").to_owned()
    // rust: + include_str!("../oit.wgsl")
    // rust: + include_str!("../oit_border.wgsl")),
    // rust: &border.iter().map(String::as_str).collect::<Vec<_>>(),
    // rust: );
}

a_device_depth_gives_the_distance_along_the_view_axis :: proc() {
}
        // The world's reversed-Z projection: near plane at depth 1.
    // rust: let projection = super::super::world_projection(70.0, 16.0 / 9.0, 512.0);
    // rust: let [x, y] = projection_terms(&projection);
    // rust: for distance in [0.1_f32, 1.0, 7.5, 64.0, 500.0] {
    // rust: let clip = projection * glam::Vec4::new(0.0, 0.0, -distance, 1.0);
    // rust: let device = clip.z / clip.w;
    // rust: let linear = y / (device + x);
    // rust: assert!(
    // rust: (linear - distance).abs() < distance * 2e-3,
    // rust: "{distance}: {linear}"
    // rust: );
}
}
}
