//! Transpiled from Horizon Rust crate
package horizon_client_render_native_sky

import "core:fmt"
import "core:mem"
import "core:math"

// The sky stage of Horizon's own shader packs (docs/shaders.md): the pack's `sky` function,
// called for each pixel of the sky disc with vanilla's colour along its view ray. The
// pipeline's shader is the pack's stage (`CheckedStage::source`) followed by a copy of the
// renderer's sky (terrain.wgsl's `Globals`, `linear_fog` and sky section) whose names all
// take a `horizon_sky_` prefix, so none can meet a pack's (the check refuses `horizon_`
// names). It reads the renderer's globals (group 0) and the pack's frame (group 3), and
// draws where vanilla's sky draws; the sun, moon, stars and the dark disc are drawn over it.

// use horizon_shader_api::{check::CheckedStage, stages::GROUP};

// use super::native_post::{NativeFrame, present_constants};
// use super::wgsl_prefix::{TERRAIN, prefixed, section};

PREFIX :: "horizon_sky_"

// The fragment entry that calls the pack: vanilla's colour in, an opaque colour out.
    // rust: const PACK_ENTRY: &str = "
    // rust: @fragment fn horizon_sky_fs_pack(in: horizon_sky_SkyOut) -> @location(0) vec4<f32> {
    // rust: let d = horizon_sky_view_ray(in.ndc);
    // rust: return vec4(sky(SkyInput(d, vec4(horizon_sky_sky_along_ray(d), 1.0))).rgb, 1.0);
}
    // rust: ";

NativeSky :: struct {
    pipeline: wgpu::RenderPipeline,
    label: string,
}

// terrain.wgsl's sky with every name it declares (and `globals`) prefixed.
vanilla_sky :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: let text = [
    // rust: section(TERRAIN, "struct Globals {", "@group(0) @binding(1)"),
    // rust: section(TERRAIN, "fn linear_fog(", "fn apply_fog("),
    // rust: section(TERRAIN, "struct SkyOut {", "// rendertype_lines"),
    // rust: ]
    // rust: .concat();
    // rust: prefixed(&text, PREFIX)
}

// The sky shader for the pack's sky stage `source`.
shader_source :: proc(source: string) -> S {
    // Ported from Horizon
    return {}
}
    // rust: format!(
    // rust: "{source}\n// Horizon's sky (terrain.wgsl)\n{}{PACK_ENTRY}",
    // rust: vanilla_sky()
    // rust: )
}

// A sky pipeline over `module` whose fragment entry is `fragment`.
    // rust: fn pipeline(
    // rust: device: &wgpu::Device,
    // rust: layout: &wgpu::PipelineLayout,
    // rust: module: &wgpu::ShaderModule,
    // rust: fragment: &str,
    // rust: constants: &[(&str, f64)],
    // rust: format: wgpu::TextureFormat,
    // rust: ) -> wgpu::RenderPipeline {
    // rust: let options = wgpu::PipelineCompilationOptions {
    // rust: constants,
    // rust: ..Default::default()
}
    // rust: device.create_render_pipeline(&wgpu::RenderPipelineDescriptor {
    // rust: label: Some("Native shader pack sky"),
    // rust: layout: Some(layout),
    // rust: vertex: wgpu::VertexState {
    // rust: module,
    // rust: entry_point: Some("horizon_sky_vs_sky"),
    // rust: compilation_options: options.clone(),
    // rust: buffers: &[],
    // rust: },
    // rust: primitive: Default::default(),
    // rust: depth_stencil: Some(wgpu::DepthStencilState {
    // rust: format: wgpu::TextureFormat::Depth32Float,
    // rust: depth_write_enabled: Some(false),
    // rust: depth_compare: Some(wgpu::CompareFunction::Always),
    // rust: stencil: Default::default(),
    // rust: bias: Default::default(),
    // rust: }),
    // rust: multisample: Default::default(),
    // rust: fragment: Some(wgpu::FragmentState {
    // rust: module,
    // rust: entry_point: Some(fragment),
    // rust: compilation_options: options,
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

// The sky's naga module and the layout of its pipelines: `globals` at group 0, the frame
// at group 3.
    // rust: fn build(
    // rust: device: &wgpu::Device,
    // rust: globals: &wgpu::BindGroupLayout,
    // rust: frame: &NativeFrame,
    // rust: stage: &CheckedStage,
    // rust: ) -> Result<(naga::Module, wgpu::PipelineLayout), String> {
    // rust: let text = shader_source(&stage.source);
    // rust: let module = naga::front::wgsl::parse_str(&text)
    // rust: .map_err(|e| format!("{}: {}", stage.file, e.emit_to_string(&text)))?;
    // rust: let mut groups: [Option<&wgpu::BindGroupLayout>; GROUP as usize + 1] = Default::default();
    // rust: groups[0] = Some(globals);
    // rust: groups[GROUP as usize] = Some(&frame.layout);
    // rust: let layout = device.create_pipeline_layout(&wgpu::PipelineLayoutDescriptor {
    // rust: label: Some("Native shader pack sky"),
    // rust: bind_group_layouts: &groups,
    // rust: ..Default::default()
    // rust: });
    // rust: Ok((module, layout))
}

    // rust: impl NativeSky {
    // The pipeline of the pack's sky `stage` with the option values `constants`, drawing
    // onto the world's target of `format`; `globals` is the terrain's group 0.
    // rust: pub fn new(
    // rust: device: &wgpu::Device,
    // rust: globals: &wgpu::BindGroupLayout,
    // rust: frame: &NativeFrame,
    // rust: stage: &CheckedStage,
    // rust: constants: &[(String, f64)],
    // rust: format: wgpu::TextureFormat,
    // rust: ) -> Result<Self, String> {
    // rust: let (module, layout) = build(device, globals, frame, stage)?;
    // rust: let present = present_constants(&module, constants);
    // rust: let scope = device.push_error_scope(wgpu::ErrorFilter::Validation);
    // rust: let module = device.create_shader_module(wgpu::ShaderModuleDescriptor {
    // rust: label: Some(&stage.label),
    // rust: source: wgpu::ShaderSource::Naga(std::borrow::Cow::Owned(module)),
    // rust: });
    // rust: let pipeline = pipeline(
    // rust: device,
    // rust: &layout,
    // rust: &module,
    // rust: "horizon_sky_fs_pack",
    // rust: &present,
    // rust: format,
    // rust: );
    // rust: if let Some(e) = pollster::block_on(scope.pop()) {
    // rust: return Err(format!("{}: {e}", stage.file));
}
    // rust: Ok(Self {
    // rust: pipeline,
    // rust: label: stage.label.clone(),
    // rust: })
}

    // Draws the sky in a pass whose group 0 is the terrain's.
draw :: proc(self: ^Self, pass: ^wgpu::RenderPass<'_>, frame: ^NativeFrame) {
}
    // rust: pass.set_pipeline(&self.pipeline);
    // rust: pass.set_bind_group(GROUP, &frame.group, &[]);
    // rust: pass.draw(0..3, 0..1);
}
}

    // rust: mod tests {
//     use super::*;
//     use horizon_shader_api::{Frame as FrameInputs, MANIFEST, Pack, StageKind, check};

stage :: proc(sky: string) -> C {
    // Ported from Horizon
    return {}
}
    // rust: let mut manifest = "schema = 1\nid = \"t\"\nname = \"T\"\nversion = \"1\"\napi = \"0.1\"\n\
    // rust: [sky]\nfile = \"sky.wgsl\"\n"
    // rust: .to_owned();
    // rust: if sky.contains("gain") {
    // rust: manifest += "[[options]]\nid = \"gain\"\nname = \"Gain\"\ntype = \"float\"\n\
    // rust: default = 1.0\nmin = 0.0\nmax = 2.0\n";
}
    // rust: let manifest = manifest.as_str();
    // rust: let files = [(MANIFEST, manifest), ("sky.wgsl", sky)]
    // rust: .map(|(n, t)| (n.to_owned(), t.as_bytes().to_vec()))
    // rust: .into();
    // rust: let mut report = check(&Pack::from_files(files).unwrap()).unwrap();
    // rust: assert_eq!(report.stages[0].kind, StageKind::Sky);
    // rust: report.stages.remove(0)
}

the_renderer_s_sky_takes_a_prefix_and_validates_with_a_pack :: proc() {
}
    // rust: let sky = vanilla_sky();
    // rust: for name in [
    // rust: "Globals",
    // rust: "SkyOut",
    // rust: "view_ray",
    // rust: "PI",
    // rust: "sky_along_ray",
    // rust: "linear_fog",
    // rust: "fs_sky",
    // rust: ] {
    // rust: assert!(sky.contains(&format!("{PREFIX}{name}")), "{name}");
}
        // A pack may use the renderer's names for its own things.
    // rust: let own = "override gain: f32;\nconst PI: f32 = 3.0;\nfn view_ray() -> f32 { return PI; }\n\
sky :: proc(input: SkyInput) -> v {
    // Ported from Horizon
    return {}
}
    // rust: let text = shader_source(&stage(own).source);
    // rust: let module = naga::front::wgsl::parse_str(&text).unwrap_or_else(|e| {
    // rust: panic!("{}", e.emit_to_string(&text));
    // rust: });
    // rust: naga::valid::Validator::new(
    // rust: naga::valid::ValidationFlags::all(),
    // rust: naga::valid::Capabilities::default(),
    // rust: )
    // rust: .validate(&module)
    // rust: .unwrap();
}

    // Vanilla's sky and two packs over the same globals: one that returns its input draws
    // vanilla's pixels, one that inverts them draws the inverse (and stays opaque).
a_pack_gets_vanilla_s_colour_and_draws_opaque :: proc() {
}
    // rust: let instance = crate::gfx::test_gpu::instance();
    // rust: let Ok(adapter) = pollster::block_on(instance.request_adapter(&Default::default())) else {
    // rust: return;
}
    // rust: let (device, queue) =
    // rust: pollster::block_on(adapter.request_device(&Default::default())).unwrap();
    // rust: let format = wgpu::TextureFormat::Rgba8Unorm;
    // rust: let globals_layout = device.create_bind_group_layout(&wgpu::BindGroupLayoutDescriptor {
    // rust: label: None,
    // rust: entries: &[wgpu::BindGroupLayoutEntry {
    // rust: binding: 0,
    // rust: visibility: wgpu::ShaderStages::VERTEX_FRAGMENT,
    // rust: ty: wgpu::BindingType::Buffer {
    // rust: ty: wgpu::BufferBindingType::Uniform,
    // rust: has_dynamic_offset: false,
    // rust: min_binding_size: None,
    // rust: },
    // rust: count: None,
    // rust: }],
    // rust: });
    // rust: let mut globals: super::super::Globals = bytemuck::Zeroable::zeroed();
    // rust: globals.inverse_view = glam::Mat4::IDENTITY.to_cols_array_2d();
    // rust: globals.misc = [0.0, 0.0, 1.0, 1.0];
    // rust: globals.fog_color = [0.2, 0.4, 0.6, 1.0];
    // rust: globals.sky_color = [0.5, 0.7, 1.0, 1.0];
    // rust: globals.fog_ends = [64.0, 0.0, 0.0, 0.0];
    // rust: let globals_buffer = device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: None,
    // rust: size: size_of::<super::super::Globals>() as u64,
    // rust: usage: wgpu::BufferUsages::UNIFORM | wgpu::BufferUsages::COPY_DST,
    // rust: mapped_at_creation: false,
    // rust: });
    // rust: queue.write_buffer(&globals_buffer, 0, bytemuck::bytes_of(&globals));
    // rust: let globals_group = device.create_bind_group(&wgpu::BindGroupDescriptor {
    // rust: label: None,
    // rust: layout: &globals_layout,
    // rust: entries: &[wgpu::BindGroupEntry {
    // rust: binding: 0,
    // rust: resource: globals_buffer.as_entire_binding(),
    // rust: }],
    // rust: });
    // rust: let frame = NativeFrame::new(&device, None, Vec::new(), Default::default(), None);
    // rust: queue.write_buffer(
    // rust: &frame.buffer,
    // rust: 0,
    // rust: bytemuck::bytes_of(&FrameInputs::default()),
    // rust: );

    // rust: let gain = [("gain".to_owned(), 1.0)];
    // rust: let draw = |stage: &CheckedStage, vanilla: bool| -> Vec<u8> {
    // rust: let sky =
    // rust: NativeSky::new(&device, &globals_layout, &frame, stage, &gain, format).unwrap();
    // rust: let pipeline = if vanilla {
    // rust: let (module, layout) = build(&device, &globals_layout, &frame, stage).unwrap();
    // rust: let module = device.create_shader_module(wgpu::ShaderModuleDescriptor {
    // rust: label: None,
    // rust: source: wgpu::ShaderSource::Naga(std::borrow::Cow::Owned(module)),
    // rust: });
    // rust: pipeline(&device, &layout, &module, "horizon_sky_fs_sky", &[], format)
    // rust: } else {
    // rust: sky.pipeline.clone()
}
    // rust: let texture = |format, usage| {
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
    // rust: let color = texture(
    // rust: format,
    // rust: wgpu::TextureUsages::RENDER_ATTACHMENT | wgpu::TextureUsages::COPY_SRC,
    // rust: );
    // rust: let depth = texture(
    // rust: wgpu::TextureFormat::Depth32Float,
    // rust: wgpu::TextureUsages::RENDER_ATTACHMENT,
    // rust: );
    // rust: let (color_view, depth_view) = (
    // rust: color.create_view(&Default::default()),
    // rust: depth.create_view(&Default::default()),
    // rust: );
    // rust: let mut encoder = device.create_command_encoder(&Default::default());
    // rust: {
    // rust: let mut pass = encoder.begin_render_pass(&wgpu::RenderPassDescriptor {
    // rust: label: None,
    // rust: color_attachments: &[Some(wgpu::RenderPassColorAttachment {
    // rust: view: &color_view,
    // rust: resolve_target: None,
    // rust: depth_slice: None,
    // rust: ops: wgpu::Operations {
    // rust: load: wgpu::LoadOp::Clear(wgpu::Color::TRANSPARENT),
    // rust: store: wgpu::StoreOp::Store,
    // rust: },
    // rust: })],
    // rust: depth_stencil_attachment: Some(wgpu::RenderPassDepthStencilAttachment {
    // rust: view: &depth_view,
    // rust: depth_ops: Some(wgpu::Operations {
    // rust: load: wgpu::LoadOp::Clear(0.0),
    // rust: store: wgpu::StoreOp::Discard,
    // rust: }),
    // rust: stencil_ops: None,
    // rust: }),
    // rust: ..Default::default()
    // rust: });
    // rust: pass.set_bind_group(0, &globals_group, &[]);
    // rust: pass.set_pipeline(&pipeline);
    // rust: pass.set_bind_group(GROUP, &frame.group, &[]);
    // rust: pass.draw(0..3, 0..1);
}
    // rust: let buffer = device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: None,
    // rust: size: u64::from(wgpu::COPY_BYTES_PER_ROW_ALIGNMENT * 4),
    // rust: usage: wgpu::BufferUsages::MAP_READ | wgpu::BufferUsages::COPY_DST,
    // rust: mapped_at_creation: false,
    // rust: });
    // rust: encoder.copy_texture_to_buffer(
    // rust: color.as_image_copy(),
    // rust: wgpu::TexelCopyBufferInfo {
    // rust: buffer: &buffer,
    // rust: layout: wgpu::TexelCopyBufferLayout {
    // rust: offset: 0,
    // rust: bytes_per_row: Some(wgpu::COPY_BYTES_PER_ROW_ALIGNMENT),
    // rust: rows_per_image: Some(4),
    // rust: },
    // rust: },
    // rust: color.size(),
    // rust: );
    // rust: queue.submit([encoder.finish()]);
    // rust: buffer
    // rust: .slice(..)
    // rust: .map_async(wgpu::MapMode::Read, |r| r.unwrap());
    // rust: device.poll(wgpu::PollType::wait_indefinitely()).unwrap();
    // rust: let bytes = buffer.slice(..).get_mapped_range().unwrap().to_vec();
    // rust: (0..4)
    // rust: .flat_map(|row| {
    // rust: let start = row * wgpu::COPY_BYTES_PER_ROW_ALIGNMENT as usize;
    // rust: bytes[start..start + 16].to_vec()
    // rust: })
    // rust: .collect()
}
    // rust: let same = stage("fn sky(input: SkyInput) -> vec4<f32> { return input.color; }\n");
    // rust: let vanilla = draw(&same, true);
    // rust: assert_eq!(draw(&same, false), vanilla);
        // The top row looks up into the sky disc, the bottom one down into the fog.
    // rust: assert_ne!(vanilla[..4], vanilla[vanilla.len() - 4..]);
    // rust: let inverse = stage(
    // rust: "override gain: f32;\nfn sky(input: SkyInput) -> vec4<f32> { return vec4(vec3(gain) - input.color.rgb, 0.25); }\n",
    // rust: );
    // rust: let inverted = draw(&inverse, false);
    // rust: for (got, want) in inverted.chunks(4).zip(vanilla.chunks(4)) {
    // rust: assert_eq!(got[3], 255);
    // rust: for i in 0..3 {
    // rust: assert!(got[i].abs_diff(255 - want[i]) <= 1, "{got:?} {want:?}");
}
}
}
}
