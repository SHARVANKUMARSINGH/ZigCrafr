//! Transpiled from Horizon Rust crate
package horizon_client_render_oit_features

import "core:fmt"
import "core:mem"
import "core:math"

// Improved transparency for what is drawn after the opaque world besides the
// terrain and the clouds: `LevelRenderer.executeOit`'s "Features, World
// Border, Weather" pass. Each kind keeps its classic vertex shader, vertex
// format and depth state (minus the depth writes, as every `OIT_*` pipeline),
// with the three stages' fragments (`oit_features.wgsl`, `oit_border.wgsl`).

// use super::oit::{Stage, stage_targets};

// One pipeline per stage.
    // rust: type Set = [wgpu::RenderPipeline; 3];

Features :: struct {
    // `OIT_ENTITY`/`OIT_ITEM`: translucent items and particles.
    entity: Set,
    // `OIT_TEXT_POLYGON_OFFSET`.
    text: Set,
    // `OIT_CRUMBLING`.
    crumbling: Set,
    // `OIT_ENTITY_SHADOW`.
    shadow: Set,
    // `OIT_ENERGY_SWIRL`.
    swirl: Set,
    // `OIT_LIGHTNING`: the retained bolts.
    lightning: Set,
    // `OIT_DRAGON_RAYS`: the additive geometry after the bolts.
    additive: Set,
    // `OIT_WEATHER`.
    weather: Set,
    // `OIT_WORLD_BORDER`.
    border: Set,
}

// What a kind differs in.
Kind :: struct {
    label: ^'a str,
    // The entry points' common prefix: `fs_oit_<name>_<stage>`.
    name: ^'a str,
    vertex: ^'a str,
    cull: Maybe(wgpu::Face),
    bias: wgpu::DepthBiasState,
}

    // rust: const PLAIN: wgpu::DepthBiasState = wgpu::DepthBiasState {
    // rust: constant: 0,
    // rust: slope_scale: 0.0,
    // rust: clamp: 0.0,
}

    // rust: impl Features {
    // `layouts`: `Oit`'s stage groups (at group 2); `entity`, `weather` and
    // `border` the bind group layouts of the classic pipelines.
    // rust: pub fn new(
    // rust: device: &wgpu::Device,
    // rust: layouts: &[wgpu::BindGroupLayout; 4],
    // rust: entity: &wgpu::BindGroupLayout,
    // rust: weather: &wgpu::BindGroupLayout,
    // rust: border: &wgpu::BindGroupLayout,
    // rust: ) -> Self {
    // rust: let entity_module = device.create_shader_module(wgpu::ShaderModuleDescriptor {
    // rust: label: Some("Horizon improved transparency features"),
    // rust: source: wgpu::ShaderSource::Wgsl(
    // rust: (super::entity_shader()
    // rust: + include_str!("../oit.wgsl")
    // rust: + include_str!("../oit_features.wgsl"))
    // rust: .into(),
    // rust: ),
    // rust: });
    // rust: let border_module = device.create_shader_module(wgpu::ShaderModuleDescriptor {
    // rust: label: Some("Horizon improved transparency world border"),
    // rust: source: wgpu::ShaderSource::Wgsl(
    // rust: (include_str!("../border.wgsl").to_owned()
    // rust: + include_str!("../oit.wgsl")
    // rust: + include_str!("../oit_border.wgsl"))
    // rust: .into(),
    // rust: ),
    // rust: });
    // rust: let entity_attributes = wgpu::vertex_attr_array![0=>Float32x3,1=>Float32x2,2=>Uint32,3=>Unorm8x4,4=>Uint8x4,5=>Snorm8x4,6=>Float32x2];
    // rust: let weather_attributes = wgpu::vertex_attr_array![0=>Float32x3,1=>Float32x2,2=>Float32x4,
    // rust: 3=>Float32x4,4=>Uint32x4,5=>Unorm8x4,6=>Uint8x4,7=>Uint32];
    // rust: let border_attributes = wgpu::vertex_attr_array![0=>Float32x3,1=>Float32x2];
    // rust: let entity_buffers = [Some(wgpu::VertexBufferLayout {
    // rust: array_stride: std::mem::size_of::<super::Vertex>() as u64,
    // rust: step_mode: wgpu::VertexStepMode::Vertex,
    // rust: attributes: &entity_attributes,
    // rust: })];
    // rust: let weather_buffers = [Some(wgpu::VertexBufferLayout {
    // rust: array_stride: std::mem::size_of::<crate::weather::Vertex>() as u64,
    // rust: step_mode: wgpu::VertexStepMode::Vertex,
    // rust: attributes: &weather_attributes,
    // rust: })];
    // rust: let border_buffers = [Some(wgpu::VertexBufferLayout {
    // rust: array_stride: std::mem::size_of::<crate::border_render::BorderVertex>() as u64,
    // rust: step_mode: wgpu::VertexStepMode::Vertex,
    // rust: attributes: &border_attributes,
    // rust: })];
    // rust: let lightning_attributes = wgpu::vertex_attr_array![7=>Float32x3];
    // rust: let lightning_buffers = [
    // rust: entity_buffers[0].clone(),
    // rust: Some(wgpu::VertexBufferLayout {
    // rust: array_stride: std::mem::size_of::<[f32; 3]>() as u64,
    // rust: step_mode: wgpu::VertexStepMode::Instance,
    // rust: attributes: &lightning_attributes,
    // rust: }),
    // rust: ];
    // rust: let set = |module: &wgpu::ShaderModule,
    // rust: groups: [Option<&wgpu::BindGroupLayout>; 2],
    // rust: buffers: &[Option<wgpu::VertexBufferLayout<'_>>],
    // rust: kind: Kind<'_>| {
    // rust: [Stage::DepthBounds, Stage::Transmittance, Stage::Accumulate].map(|stage| {
    // rust: let suffix = ["bounds", "transmittance", "accumulate"][stage as usize];
    // rust: let layout = device.create_pipeline_layout(&wgpu::PipelineLayoutDescriptor {
    // rust: label: Some("Improved transparency features"),
    // rust: bind_group_layouts: &[groups[0], groups[1], Some(&layouts[stage as usize])],
    // rust: ..Default::default()
    // rust: });
    // rust: device.create_render_pipeline(&wgpu::RenderPipelineDescriptor {
    // rust: label: Some(&format!("OIT {} {suffix}", kind.label)),
    // rust: layout: Some(&layout),
    // rust: vertex: wgpu::VertexState {
    // rust: module,
    // rust: entry_point: Some(kind.vertex),
    // rust: compilation_options: Default::default(),
    // rust: buffers,
    // rust: },
    // rust: primitive: wgpu::PrimitiveState {
    // rust: cull_mode: kind.cull,
    // rust: ..Default::default()
    // rust: },
    // rust: depth_stencil: Some(wgpu::DepthStencilState {
    // rust: format: wgpu::TextureFormat::Depth32Float,
    // rust: depth_write_enabled: Some(false),
    // rust: depth_compare: Some(wgpu::CompareFunction::GreaterEqual),
    // rust: stencil: Default::default(),
    // rust: bias: kind.bias,
    // rust: }),
    // rust: multisample: Default::default(),
    // rust: fragment: Some(wgpu::FragmentState {
    // rust: module,
    // rust: entry_point: Some(&format!("fs_oit_{}_{suffix}", kind.name)),
    // rust: compilation_options: Default::default(),
    // rust: targets: &stage_targets(stage),
    // rust: }),
    // rust: multiview_mask: None,
    // rust: cache: None,
    // rust: })
    // rust: })
}
    // rust: let entities = [Some(entity), None];
    // rust: let kind = |label, name, cull, bias| Kind {
    // rust: label,
    // rust: name,
    // rust: vertex: "vs_entity",
    // rust: cull,
    // rust: bias,
}
        // The classic pipelines' biases: text and cracks (10, 1), shadows
        // (128 ulps and a slope, over the block tops they lie on).
    // rust: let offset = wgpu::DepthBiasState {
    // rust: constant: 10,
    // rust: slope_scale: 1.0,
    // rust: clamp: 0.0,
}
    // rust: let shadow_bias = wgpu::DepthBiasState {
    // rust: constant: 128,
    // rust: slope_scale: 0.015,
    // rust: clamp: 0.0,
}
    // rust: Self {
    // rust: entity: set(
    // rust: &entity_module,
    // rust: entities,
    // rust: &entity_buffers,
    // rust: kind("entities", "entity", None, PLAIN),
    // rust: ),
    // rust: text: set(
    // rust: &entity_module,
    // rust: entities,
    // rust: &entity_buffers,
    // rust: kind("text", "entity", Some(wgpu::Face::Back), offset),
    // rust: ),
    // rust: crumbling: set(
    // rust: &entity_module,
    // rust: entities,
    // rust: &entity_buffers,
    // rust: kind("breaking cracks", "entity", Some(wgpu::Face::Back), offset),
    // rust: ),
    // rust: shadow: set(
    // rust: &entity_module,
    // rust: entities,
    // rust: &entity_buffers,
    // rust: kind(
    // rust: "entity shadows",
    // rust: "shadow",
    // rust: Some(wgpu::Face::Back),
    // rust: shadow_bias,
    // rust: ),
    // rust: ),
    // rust: swirl: set(
    // rust: &entity_module,
    // rust: entities,
    // rust: &entity_buffers,
    // rust: kind("energy swirls", "swirl", None, PLAIN),
    // rust: ),
    // rust: lightning: set(
    // rust: &entity_module,
    // rust: entities,
    // rust: &lightning_buffers,
    // rust: Kind {
    // rust: label: "lightning",
    // rust: name: "lightning",
    // rust: vertex: "vs_lightning",
    // rust: cull: None,
    // rust: bias: PLAIN,
    // rust: },
    // rust: ),
    // rust: additive: set(
    // rust: &entity_module,
    // rust: entities,
    // rust: &entity_buffers,
    // rust: kind(
    // rust: "additive entities",
    // rust: "lightning",
    // rust: Some(wgpu::Face::Back),
    // rust: PLAIN,
    // rust: ),
    // rust: ),
    // rust: weather: set(
    // rust: &entity_module,
    // rust: [Some(entity), Some(weather)],
    // rust: &weather_buffers,
    // rust: Kind {
    // rust: label: "weather",
    // rust: name: "weather",
    // rust: vertex: "vs_weather",
    // rust: cull: None,
    // rust: bias: PLAIN,
    // rust: },
    // rust: ),
            // `OIT_WORLD_BORDER`: a polygon offset of 3 towards the camera.
    // rust: border: set(
    // rust: &border_module,
    // rust: [Some(border), None],
    // rust: &border_buffers,
    // rust: Kind {
    // rust: label: "world border",
    // rust: name: "border",
    // rust: vertex: "vs_border",
    // rust: cull: None,
    // rust: bias: wgpu::DepthBiasState {
    // rust: constant: 3,
    // rust: slope_scale: 3.0,
    // rust: clamp: 0.0,
    // rust: },
    // rust: },
    // rust: ),
}
}
}
