//! Transpiled from Horizon Rust crate
package horizon_client_render_depth_test

import "core:fmt"
import "core:mem"
import "core:math"

// Original depth-buffer GPU regressions from public format documentation; no pack assets.
// use super::*;
// use crate::{gfx::Frame, hud::HudBatch};
// use wgpu::{TextureFormat as T, util::DeviceExt};

    // rust: pub(super) const SIZE: [u32; 2] = [16, 16];

    // rust: pub(super) struct Gpu {
    // rust: adapter: wgpu::Adapter,
    // rust: pub(super) device: wgpu::Device,
    // rust: pub(super) queue: wgpu::Queue,
}
    // rust: impl Gpu {
    // rust: pub(super) fn new() -> Option<Self> {
    // rust: let instance = crate::gfx::test_gpu::instance();
    // rust: let adapter = pollster::block_on(instance.request_adapter(&Default::default())).ok()?;
    // rust: let (device, queue) = pollster::block_on(adapter.request_device(&wgpu::DeviceDescriptor {
    // rust: required_limits: adapter.limits(),
    // rust: required_features: adapter.features() & wgpu::Features::FLOAT32_FILTERABLE,
    // rust: ..Default::default()
    // rust: }))
    // rust: .expect("GPU device required: setup failure is not a contract pass");
    // rust: eprintln!("DEPTH_FIXTURE_ADAPTER {:?}", adapter.get_info());
    // rust: Some(Self {
    // rust: adapter,
    // rust: device,
    // rust: queue,
    // rust: })
}
    // rust: pub(super) fn texture(&self, format: T) -> wgpu::TextureView {
    // rust: self.device
    // rust: .create_texture(&wgpu::TextureDescriptor {
    // rust: label: Some("Original depth fixture input"),
    // rust: size: wgpu::Extent3d {
    // rust: width: SIZE[0],
    // rust: height: SIZE[1],
    // rust: depth_or_array_layers: 1,
    // rust: },
    // rust: mip_level_count: 1,
    // rust: sample_count: 1,
    // rust: dimension: wgpu::TextureDimension::D2,
    // rust: format,
    // rust: usage: wgpu::TextureUsages::RENDER_ATTACHMENT
    // rust: | wgpu::TextureUsages::TEXTURE_BINDING
    // rust: | wgpu::TextureUsages::COPY_SRC,
    // rust: view_formats: &[],
    // rust: })
    // rust: .create_view(&Default::default())
}
    // rust: pub(super) fn load(
    // rust: &self,
    // rust: files: Vec<(String, String)>,
    // rust: world: World<'_>,
    // rust: inputs: horizon_shaders::GameInputs,
    // rust: ) -> PackPost {
//         use std::io::{Cursor, Write};
    // rust: let mut zip = zip::ZipWriter::new(Cursor::new(Vec::new()));
    // rust: for (name, contents) in files {
    // rust: zip.start_file(
    // rust: format!("shaders/{name}"),
    // rust: zip::write::SimpleFileOptions::default(),
    // rust: )
    // rust: .unwrap();
    // rust: zip.write_all(contents.as_bytes()).unwrap();
}
    // rust: let pack = horizon_shaders::Pack::from_zip_bytes(
    // rust: "original-depth-fixture",
    // rust: zip.finish().unwrap().into_inner(),
    // rust: )
    // rust: .unwrap();
    // rust: let mut macros = horizon_shaders::Macros::standard();
    // rust: let (properties, _) = horizon_shaders::read_properties(&pack, &mut macros);
    // rust: let post = horizon_shaders::load_post(&pack, "", &properties, &macros, &inputs);
    // rust: assert!(
    // rust: post.programs.iter().any(|p| p.name == "final"),
    // rust: "{:?}",
    // rust: post.notes
    // rust: );
    // rust: let built = PackPost::new(
    // rust: &self.device,
    // rust: &self.queue,
    // rust: &self.adapter,
    // rust: post,
    // rust: T::Rgba8Unorm,
    // rust: world,
    // rust: )
    // rust: .expect("the pack runs");
    // rust: assert!(
    // rust: built.passes.iter().any(|p| p.group == Group::Final),
    // rust: "{:?}",
    // rust: built.notes
    // rust: );
    // rust: built
}
    // rust: pub(super) fn clear(
    // rust: &self,
    // rust: color: &wgpu::TextureView,
    // rust: depth: &wgpu::TextureView,
    // rust: reverse_depth: f32,
    // rust: ) {
    // rust: let mut encoder = self.device.create_command_encoder(&Default::default());
    // rust: encoder.begin_render_pass(&wgpu::RenderPassDescriptor {
    // rust: label: Some("Independent original fixture clear"),
    // rust: color_attachments: &[Some(wgpu::RenderPassColorAttachment {
    // rust: view: color,
    // rust: resolve_target: None,
    // rust: depth_slice: None,
    // rust: ops: wgpu::Operations {
    // rust: load: wgpu::LoadOp::Clear(wgpu::Color {
    // rust: r: 0.0625,
    // rust: g: 0.0625,
    // rust: b: 0.0625,
    // rust: a: 1.0,
    // rust: }),
    // rust: store: wgpu::StoreOp::Store,
    // rust: },
    // rust: })],
    // rust: depth_stencil_attachment: Some(wgpu::RenderPassDepthStencilAttachment {
    // rust: view: depth,
    // rust: depth_ops: Some(wgpu::Operations {
    // rust: load: wgpu::LoadOp::Clear(reverse_depth),
    // rust: store: wgpu::StoreOp::Store,
    // rust: }),
    // rust: stencil_ops: None,
    // rust: }),
    // rust: ..Default::default()
    // rust: });
    // rust: self.queue.submit([encoder.finish()]);
}
    // rust: pub(super) fn render(
    // rust: &self,
    // rust: post: &mut PackPost,
    // rust: color: &wgpu::TextureView,
    // rust: depth: &wgpu::TextureView,
    // rust: frame: &Frame<'_>,
    // rust: terrain: &mut TerrainDraw<'_>,
    // rust: ) -> Vec<[u8; 4]> {
    // rust: let screen = self.texture(T::Rgba8Unorm);
    // rust: let stride = wgpu::COPY_BYTES_PER_ROW_ALIGNMENT;
    // rust: let read = self.device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: Some("Original fixture readback"),
    // rust: size: u64::from(stride * SIZE[1]),
    // rust: usage: wgpu::BufferUsages::COPY_DST | wgpu::BufferUsages::MAP_READ,
    // rust: mapped_at_creation: false,
    // rust: });
    // rust: let mut encoder = self.device.create_command_encoder(&Default::default());
    // rust: post.run(
    // rust: &self.device,
    // rust: &self.queue,
    // rust: &mut encoder,
    // rust: color,
    // rust: depth,
    // rust: &screen,
    // rust: frame,
    // rust: &Default::default(),
    // rust: SIZE,
    // rust: SIZE,
    // rust: &[],
    // rust: terrain,
    // rust: );
    // rust: encoder.copy_texture_to_buffer(
    // rust: screen.texture().as_image_copy(),
    // rust: wgpu::TexelCopyBufferInfo {
    // rust: buffer: &read,
    // rust: layout: wgpu::TexelCopyBufferLayout {
    // rust: offset: 0,
    // rust: bytes_per_row: Some(stride),
    // rust: rows_per_image: None,
    // rust: },
    // rust: },
    // rust: screen.texture().size(),
    // rust: );
    // rust: self.queue.submit([encoder.finish()]);
    // rust: read.slice(..).map_async(wgpu::MapMode::Read, |_| {});
    // rust: self.device
    // rust: .poll(wgpu::PollType::wait_indefinitely())
    // rust: .unwrap();
    // rust: read.slice(..)
    // rust: .get_mapped_range()
    // rust: .unwrap()
    // rust: .chunks_exact(stride as usize)
    // rust: .flat_map(|row| {
    // rust: row[..SIZE[0] as usize * 4]
    // rust: .as_chunks::<4>()
    // rust: .0
    // rust: .iter()
    // rust: .copied()
    // rust: })
    // rust: .collect()
}
}

all_pixels :: proc(pixels: ^[[u8; 4]], expected: [u8; 4], name: string) {
}
    // rust: let wrong = pixels
    // rust: .iter()
    // rust: .filter(|p| p.iter().zip(expected).any(|(a, b)| a.abs_diff(b) > 1))
    // rust: .count();
    // rust: eprintln!(
    // rust: "DEPTH_FIXTURE_RESULT {name} expected={expected:?} actual_first={:?} wrong={wrong}/{}",
    // rust: pixels[0],
    // rust: pixels.len()
    // rust: );
    // rust: assert_eq!(wrong, 0, "{name}: independent expected pixels {expected:?}");
}

Stage :: enum {
    Fragment,
    Deferred,
    Attached,
    ComputeOnly,
    EarlierCompute,
}
Scene :: enum {
    World,
    Terrain { hand: bool, water: bool },
    WaterOnly,
}

    // rust: pub(super) const VERTEX: &str =
    // rust: "#version 120\nvarying vec2 uv;void main(){uv=gl_MultiTexCoord0.xy;gl_Position=ftransform();}";

shaders :: proc(sampler: string, stage: Stage, scene: Scene) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let names = if sampler == "all" {
    // rust: vec!["depthtex0", "depthtex1", "depthtex2"]
    // rust: } else {
    // rust: vec![sampler]
}
    // rust: let declarations = names
    // rust: .iter()
    // rust: .map(|s| format!("uniform sampler2D {s};\n"))
    // rust: .collect::<String>();
    // rust: let sample = |s| {
    // rust: if matches!(stage, Stage::Fragment | Stage::Deferred) {
    // rust: format!("texture2D({s},uv).r")
    // rust: } else {
    // rust: format!("texelFetch({s},p,0).r")
}
}
    // rust: let result = if sampler == "all" {
    // rust: format!(
    // rust: "vec4({},{},{},1.0)",
    // rust: sample(names[0]),
    // rust: sample(names[1]),
    // rust: sample(names[2])
    // rust: )
    // rust: } else {
    // rust: format!("vec4({},0.25,0.5,1.0)", sample(names[0]))
}
    // rust: let mut files = vec![
    // rust: ("final.vsh".into(), VERTEX.into()),
    // rust: (
    // rust: "shaders.properties".into(),
    // rust: "blend.gbuffers_terrain=off\nblend.gbuffers_water=off\nblend.gbuffers_hand=off\n"
    // rust: .into(),
    // rust: ),
    // rust: ];
    // rust: if stage == Stage::Fragment {
    // rust: files.push((
    // rust: "final.fsh".into(),
    // rust: format!(
    // rust: "#version 120\n{declarations}varying vec2 uv;void main(){{gl_FragColor={result};}}"
    // rust: ),
    // rust: ));
    // rust: } else if stage == Stage::Deferred {
    // rust: files.push(("final.fsh".into(), "#version 120\nuniform sampler2D colortex1;varying vec2 uv;void main(){gl_FragColor=texture2D(colortex1,uv);}".into()));
    // rust: files.push(("deferred.vsh".into(), VERTEX.into()));
    // rust: files.push(("deferred.fsh".into(), format!("#version 120\n/* DRAWBUFFERS:1 */\n{declarations}varying vec2 uv;void main(){{gl_FragData[0]={result};}}")));
    // rust: } else {
    // rust: files.push(("final.fsh".into(),"#version 120\nuniform sampler2D colortex1;varying vec2 uv;void main(){gl_FragColor=texture2D(colortex1,uv);}".into()));
    // rust: files.push(("composite.csh".into(),format!("#version 430\nlayout(local_size_x=1,local_size_y=1)in;const ivec3 workGroups=ivec3(16,16,1);layout(rgba8) writeonly uniform image2D colorimg1;\n{declarations}\nvoid main(){{ivec2 p=ivec2(gl_GlobalInvocationID.xy);imageStore(colorimg1,p,{result});}}")));
    // rust: match stage {
    // rust: Stage::Attached => {
    // rust: files.push(("composite.vsh".into(),VERTEX.into()));
    // rust: files.push(("composite.fsh".into(),"#version 120\n/* DRAWBUFFERS:0 */\nvoid main(){gl_FragData[0]=vec4(0.0);}".into()));
}
    // rust: Stage::EarlierCompute => files.push(("composite_a.csh".into(),"#version 430\nlayout(local_size_x=1)in;const ivec3 workGroups=ivec3(1);layout(rgba8) writeonly uniform image2D colorimg2;void main(){imageStore(colorimg2,ivec2(0),vec4(0.125));}".into())),
    // rust: _ => {}
}
}
    // rust: if !matches!(scene, Scene::World) {
    // rust: let hand = matches!(scene, Scene::Terrain { hand: true, .. });
    // rust: for (name, clip) in [
    // rust: ("gbuffers_terrain", 0.4),
    // rust: ("gbuffers_water", -0.2),
    // rust: ("gbuffers_hand", -0.6),
    // rust: ] {
    // rust: if name == "gbuffers_hand" && !hand {
    // rust: continue;
}
    // rust: if name == "gbuffers_terrain" && matches!(scene, Scene::WaterOnly) {
    // rust: continue;
}
    // rust: files.push((
    // rust: format!("{name}.vsh"),
    // rust: format!("#version 120\nvoid main(){{gl_Position=vec4(gl_Vertex.xy,{clip},1.0);}}"),
    // rust: ));
    // rust: files.push((format!("{name}.fsh"),"#version 120\n/* DRAWBUFFERS:0 */\nvoid main(){gl_FragData[0]=vec4(0.0,0.0,0.0,1.0);}".into()));
}
}
    // rust: files
}

check :: proc(sampler: string, stage: Stage, scene: Scene, expected: [u8; 4]) {
}
    // rust: let Some(gpu) = Gpu::new() else {
    // rust: eprintln!("DEPTH_FIXTURE_NO_ADAPTER");
    // rust: return;
}
    // rust: let color = gpu.texture(T::Rgba8Unorm);
    // rust: let depth = gpu.texture(T::Depth32Float);
    // A seeded world depth of reverse-Z .3 is GL window depth .7.
    // rust: gpu.clear(&color, &depth, 0.3);
ATTRS :: wgpu::vertex_attr_array![0=>Float32x3]
    // rust: let layouts = [Some(wgpu::VertexBufferLayout {
    // rust: array_stride: 12,
    // rust: step_mode: wgpu::VertexStepMode::Vertex,
    // rust: attributes: &ATTRS,
    // rust: })];
    // rust: let terrain = !matches!(scene, Scene::World);
    // rust: let hand = matches!(scene, Scene::Terrain { hand: true, .. });
    // rust: let water = matches!(scene, Scene::Terrain { water: true, .. } | Scene::WaterOnly);
    // rust: let inputs=horizon_shaders::GameInputs {
    // rust: terrain:terrain.then(|| horizon_shaders::GbuffersInputs { declarations:"layout(location=0)in vec3 fixture_position;\n".into(),body:"hz_Vertex=vec4(fixture_position,1.0);hz_Color=vec4(1.0);hz_MultiTexCoord0=vec4(0.0);hz_MultiTexCoord1=vec4(240.0);hz_MultiTexCoord2=vec4(240.0);hz_Normal=vec3(0.0,0.0,1.0);\n".into(),attributes:vec![],after:String::new(),alpha_test:None,item_id_declared:false,far_depth:false }),
    // rust: hand:hand.then(crate::gfx::pack_hand::inputs),..Default::default()
}
    // rust: let mut post = gpu.load(
    // rust: shaders(sampler, stage, scene),
    // rust: World {
    // rust: atlas: None,
    // rust: material_maps: None,
    // rust: lightmap: color.clone(),
    // rust: terrain: terrain.then_some(Geometry {
    // rust: buffers: &layouts,
    // rust: table: None,
    // rust: depth_write: true,
    // rust: atlas: None,
    // rust: material_maps: false,
    // rust: ids: None,
    // rust: cull: false,
    // rust: }),
    // rust: block_ids: &[],
    // rust: sprite_rects: &[],
    // rust: celestial: None,
    // rust: gui_size: SIZE,
    // rust: clouds: None,
    // rust: weather: false,
    // rust: hand,
    // rust: },
    // rust: inputs,
    // rust: );
    // rust: if terrain {
    // rust: assert!(
    // rust: post.terrain.is_some() != matches!(scene, Scene::WaterOnly) && post.water.is_some(),
    // rust: "{:?}",
    // rust: post.notes
    // rust: );
}
    // rust: if hand {
    // rust: assert!(post.hand.is_some(), "{:?}", post.notes);
}
    // rust: if stage == Stage::Deferred {
    // rust: assert!(
    // rust: post.passes.iter().any(|p| p.group == Group::Deferred),
    // rust: "{:?}",
    // rust: post.notes
    // rust: );
    // rust: } else if stage != Stage::Fragment {
    // rust: let count = post
    // rust: .passes
    // rust: .iter()
    // rust: .flat_map(|p| std::iter::once(p).chain(&p.compute))
    // rust: .filter(|p| p.name.starts_with("composite"))
    // rust: .count();
    // rust: let expected = if matches!(stage, Stage::Attached | Stage::EarlierCompute) {
    // rust: 2
    // rust: } else {
    // rust: 1
}
    // rust: assert_eq!(
    // rust: count, expected,
    // rust: "all original compute/draw stages must build: {:?}",
    // rust: post.notes
    // rust: );
}
    // rust: let positions: [[f32; 3]; 6] = [
    // rust: [-1., -1., 0.],
    // rust: [1., -1., 0.],
    // rust: [1., 1., 0.],
    // rust: [-1., -1., 0.],
    // rust: [1., 1., 0.],
    // rust: [-1., 1., 0.],
    // rust: ];
    // rust: let vertices = gpu
    // rust: .device
    // rust: .create_buffer_init(&wgpu::util::BufferInitDescriptor {
    // rust: label: Some("Original fixed depth geometry"),
    // rust: contents: bytemuck::cast_slice(&positions),
    // rust: usage: wgpu::BufferUsages::VERTEX,
    // rust: });
    // rust: let quad = [[-1., -1., 0.], [1., -1., 0.], [1., 1., 0.], [-1., 1., 0.]].map(|pos| {
    // rust: crate::mesher::Vertex {
    // rust: pos,
    // rust: uv: [0.; 2],
    // rust: layer: 0,
    // rust: color: u32::MAX,
    // rust: light: 0,
    // rust: normal: [0, 0, 127, 0],
    // rust: glint_uv: [0.; 2],
}
    // rust: });
    // rust: let hud = HudBatch::new(SIZE);
    // rust: let mut frame = fixture_frame(&hud);
    // rust: if hand {
    // rust: frame.hand = &quad;
}
    // rust: let actual = gpu.render(&mut post, &color, &depth, &frame, &mut |rp, list, _, _| {
    // rust: if list == TerrainList::Solid || (water && list == TerrainList::Translucent) {
    // rust: rp.set_vertex_buffer(0, vertices.slice(..));
    // rust: rp.draw(0..6, 0..1);
}
    // rust: });
    // rust: all_pixels(&actual, expected, &format!("{sampler} {stage:?} {scene:?}"));
}

hand_is_in_depth1_and_excluded_from_depth2 :: proc() {
}
    // rust: check(
    // rust: "all",
    // rust: Stage::Fragment,
    // rust: Scene::Terrain {
    // rust: hand: true,
    // rust: water: true,
    // rust: },
    // rust: [51, 51, 179, 255],
    // rust: );
}
depth2_only_without_hand_excludes_water :: proc() {
}
    // rust: check(
    // rust: "depthtex2",
    // rust: Stage::Fragment,
    // rust: Scene::Terrain {
    // rust: hand: false,
    // rust: water: true,
    // rust: },
    // rust: [179, 64, 128, 255],
    // rust: );
}
depth1_only_without_hand_excludes_water_control :: proc() {
}
    // rust: check(
    // rust: "depthtex1",
    // rust: Stage::Fragment,
    // rust: Scene::Terrain {
    // rust: hand: false,
    // rust: water: true,
    // rust: },
    // rust: [179, 64, 128, 255],
    // rust: );
}
water_only_program_populates_both_opaque_snapshots :: proc() {
}
    // rust: check(
    // rust: "all",
    // rust: Stage::Fragment,
    // rust: Scene::WaterOnly,
    // rust: [102, 179, 179, 255],
    // rust: );
}
deferred_depth2_only_excludes_hand :: proc() {
}
    // rust: check(
    // rust: "depthtex2",
    // rust: Stage::Deferred,
    // rust: Scene::Terrain {
    // rust: hand: true,
    // rust: water: false,
    // rust: },
    // rust: [179, 64, 128, 255],
    // rust: );
}
deferred_depth1_contains_hand_control :: proc() {
}
    // rust: check(
    // rust: "depthtex1",
    // rust: Stage::Deferred,
    // rust: Scene::Terrain {
    // rust: hand: true,
    // rust: water: false,
    // rust: },
    // rust: [51, 64, 128, 255],
    // rust: );
}
direct_fragment_gets_world_depth_control :: proc() {
}
    // rust: check(
    // rust: "depthtex0",
    // rust: Stage::Fragment,
    // rust: Scene::World,
    // rust: [179, 64, 128, 255],
    // rust: );
}
attached_compute_gets_world_depth :: proc() {
}
    // rust: check(
    // rust: "depthtex0",
    // rust: Stage::Attached,
    // rust: Scene::World,
    // rust: [179, 64, 128, 255],
    // rust: );
}
compute_only_gets_world_depth_control :: proc() {
}
    // rust: check(
    // rust: "depthtex0",
    // rust: Stage::ComputeOnly,
    // rust: Scene::World,
    // rust: [179, 64, 128, 255],
    // rust: );
}
earlier_compute_child_gets_world_depth :: proc() {
}
    // rust: check(
    // rust: "depthtex0",
    // rust: Stage::EarlierCompute,
    // rust: Scene::World,
    // rust: [179, 64, 128, 255],
    // rust: );
}
attached_compute_depth1_without_hand_excludes_water :: proc() {
}
    // rust: check(
    // rust: "depthtex1",
    // rust: Stage::Attached,
    // rust: Scene::Terrain {
    // rust: hand: false,
    // rust: water: true,
    // rust: },
    // rust: [179, 64, 128, 255],
    // rust: );
}
attached_compute_depth2_without_hand_excludes_water :: proc() {
}
    // rust: check(
    // rust: "depthtex2",
    // rust: Stage::Attached,
    // rust: Scene::Terrain {
    // rust: hand: false,
    // rust: water: true,
    // rust: },
    // rust: [179, 64, 128, 255],
    // rust: );
}
attached_compute_preserves_distinct_hand_snapshots :: proc() {
}
    // rust: check(
    // rust: "all",
    // rust: Stage::Attached,
    // rust: Scene::Terrain {
    // rust: hand: true,
    // rust: water: true,
    // rust: },
    // rust: [51, 51, 179, 255],
    // rust: );
}

// Frame literal adapted from MIT Horizon f700231 pack_uniforms.rs test API setup.
    // rust: pub(super) fn fixture_frame(hud: &HudBatch) -> Frame<'_> {
    // rust: Frame {
    // rust: eye: glam::DVec3::ZERO,
    // rust: eye_rotation: [0.0; 2],
    // rust: first_person: true,
    // rust: shadow_scene_revision: (0, 0),
    // rust: shadow_cache: false,
    // rust: water_plane: None,
    // rust: weather: &[],
    // rust: weather_time: crate::weather::Time::new(0, 0.0),
    // rust: camera: glam::DVec3::new(0.5, 100.0, 0.5),
    // rust: yaw: 0.0,
    // rust: pitch: 0.0,
    // rust: fov_degrees: 90.0,
    // rust: bob: glam::Mat4::IDENTITY,
    // rust: spin: glam::Mat4::IDENTITY,
    // rust: sky: crate::environment::Sky::default(),
    // rust: distance: 12.0,
    // rust: detail_distance: 12.0,
    // rust: depth_far: 1000.0,
    // rust: underwater: false,
    // rust: cave_culling: false,
    // rust: title: true,
    // rust: sky_blocked: false,
    // rust: skybox: false,
    // rust: end_sky: false,
    // rust: end_sky_sprite: None,
    // rust: environment_fog: None,
    // rust: water_fog: [0.0; 3],
    // rust: fog: None,
    // rust: dark_disc: false,
    // rust: outline: Vec::new(),
    // rust: outline_after_terrain: false,
    // rust: outline_high_contrast: false,
    // rust: pvp: Default::default(),
    // rust: debug_lines: &[],
    // rust: debug_lines_on_top: &[],
    // rust: debug_crosshair: &[],
    // rust: hud,
    // rust: glint_alpha: 0.75,
    // rust: glint_ticks: 0.0,
    // rust: nether_lighting: false,
    // rust: entities: &[],
    // rust: static_block_entities: &[],
    // rust: visible_static_block_entity_sections: &[],
    // rust: static_block_entity_stats: crate::block_entity_render::StaticCacheFrameStats::default(),
    // rust: entity_motion: &[],
    // rust: colored_lights: &[],
    // rust: emissive_layers: &[],
    // rust: shadow_only: &[],
    // rust: entity_spans: &[],
    // rust: skin: None,
    // rust: glowing: &[],
    // rust: dynamic_lights: &[],
    // rust: clouds: None,
    // rust: lightning: Default::default(),
    // rust: additive: &[],
    // rust: see_through: &[],
    // rust: world_primitives: Default::default(),
    // rust: celestial: &[],
    // rust: stars: None,
    // rust: hand: &[],
    // rust: hand_items: &[],
    // rust: hand_fov_degrees: 70.0,
    // rust: screen: &[],
    // rust: pack: Default::default(),
    // rust: border: None,
    // rust: game_time: 0.0,
    // rust: shader_game_time: 0.0,
    // rust: end_portal_sprites: [[0.0; 4]; 2],
    // rust: crumbling_sprite: [0.0; 4],
    // rust: ticks: 0,
    // rust: darkness: (0.0, 0.0),
    // rust: night_vision: 0.0,
    // rust: block_flicker: 0.0,
    // rust: boss_darken: 0.0,
    // rust: menu_blur: None,
    // rust: chunk_fade: 0.0,
    // rust: post_effects: crate::post_chain::Request::none(),
}
}

// shadowtex0 and shadowtex1 read through a plain sampler a quarter texel past a texel's centre,
// over a shadow map whose depth rises a sixteenth a texel: red and green are how far each
// moved toward the next texel, times four (0 nearest, 255 linear). `nearest` is a line for
// both stage files.
shadow_depth_filtering :: proc(nearest: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: shadow_depth_reads(
    // rust: nearest,
    // rust: "float moved(sampler2D s, ivec2 t) {\n\
    // rust: float a = texelFetch(s, t, 0).r;\n\
    // rust: return (texture(s, (vec2(t) + vec2(0.75, 0.5)) / 16.0).r - a) * 16.0;\n\
    // rust: }\n\
    // rust: void main() {\n\
    // rust: ivec2 t = ivec2(int(gl_FragCoord.x) % 15, 8);\n\
    // rust: gl_FragColor = vec4(moved(shadowtex0, t) * 4.0, moved(shadowtex1, t) * 4.0, 0.0, 1.0);\n\
    // rust: }\n",
    // rust: )
}

// `shadow_depth_filtering`'s shadow map read by `reads`: `final`'s code after its declarations
// of shadowtex0 and shadowtex1.
shadow_depth_reads :: proc(nearest: string, reads: string) -> O {
    // Ported from Horizon
    return {}
}
    // The shadow map's depth runs from 0 at its left edge to 1 at its right.
    // rust: let ramp = [
    // rust: [-1., -1., 0.],
    // rust: [1., -1., 0.],
    // rust: [1., 1., 0.],
    // rust: [-1., -1., 0.],
    // rust: [1., 1., 0.],
    // rust: [-1., 1., 0.],
    // rust: ];
    // rust: shadow_depth_map_reads(
    // rust: nearest,
    // rust: reads,
    // rust: "#version 120\nvoid main(){gl_Position=vec4(gl_Vertex.xy,gl_Vertex.x,1.0);}",
    // rust: ramp,
    // rust: )
}

// A shadow map drawn by `shadow_vsh` from the two triangles `positions` (the rest keeps its
// clear depth, the far plane), read by `reads` as in `shadow_depth_reads`.
    // rust: fn shadow_depth_map_reads(
    // rust: nearest: &str,
    // rust: reads: &str,
    // rust: shadow_vsh: &str,
    // rust: positions: [[f32; 3]; 6],
    // rust: ) -> Option<Vec<[u8; 4]>> {
    // rust: let gpu = Gpu::new()?;
    // rust: let color = gpu.texture(T::Rgba8Unorm);
    // rust: let depth = gpu.texture(T::Depth32Float);
    // rust: gpu.clear(&color, &depth, 0.0);
ATTRS :: wgpu::vertex_attr_array![0=>Float32x3]
    // rust: let layouts = [Some(wgpu::VertexBufferLayout {
    // rust: array_stride: 12,
    // rust: step_mode: wgpu::VertexStepMode::Vertex,
    // rust: attributes: &ATTRS,
    // rust: })];
    // rust: let inputs = horizon_shaders::GameInputs {
    // rust: terrain: Some(horizon_shaders::GbuffersInputs {
    // rust: declarations: "layout(location=0)in vec3 fixture_position;\n".into(),
    // rust: body: "hz_Vertex=vec4(fixture_position,1.0);hz_Color=vec4(1.0);\
    // rust: hz_MultiTexCoord0=vec4(0.0);hz_MultiTexCoord1=vec4(240.0);\
    // rust: hz_MultiTexCoord2=vec4(240.0);hz_Normal=vec3(0.0,0.0,1.0);\n"
    // rust: .into(),
    // rust: attributes: vec![],
    // rust: after: String::new(),
    // rust: alpha_test: None,
    // rust: item_id_declared: false,
    // rust: far_depth: false,
    // rust: }),
    // rust: ..Default::default()
}
    // rust: let settings = format!("const int shadowMapResolution = 16;\n{nearest}\n");
    // rust: let files = vec![
    // rust: ("final.vsh".to_string(), VERTEX.to_string()),
    // rust: (
    // rust: "final.fsh".into(),
    // rust: format!(
    // rust: "#version 330 compatibility\n{settings}\
    // rust: uniform sampler2D shadowtex0;\nuniform sampler2D shadowtex1;\n{reads}"
    // rust: ),
    // rust: ),
    // rust: ("shadow.vsh".into(), shadow_vsh.into()),
    // rust: (
    // rust: "shadow.fsh".into(),
    // rust: format!("#version 120\n{settings}void main(){{gl_FragData[0]=vec4(1.0);}}"),
    // rust: ),
    // rust: ];
    // rust: let mut post = gpu.load(
    // rust: files,
    // rust: World {
    // rust: sprite_rects: &[],
    // rust: atlas: None,
    // rust: material_maps: None,
    // rust: lightmap: color.clone(),
    // rust: terrain: Some(Geometry {
    // rust: buffers: &layouts,
    // rust: table: None,
    // rust: depth_write: true,
    // rust: atlas: None,
    // rust: ids: None,
    // rust: cull: false,
    // rust: material_maps: false,
    // rust: }),
    // rust: block_ids: &[],
    // rust: celestial: None,
    // rust: gui_size: SIZE,
    // rust: clouds: None,
    // rust: weather: false,
    // rust: hand: false,
    // rust: },
    // rust: inputs,
    // rust: );
    // rust: assert!(post.has_shadow(), "{:?}", post.notes);
    // rust: let vertices = gpu
    // rust: .device
    // rust: .create_buffer_init(&wgpu::util::BufferInitDescriptor {
    // rust: label: Some("Original shadow depth ramp"),
    // rust: contents: bytemuck::cast_slice(&positions),
    // rust: usage: wgpu::BufferUsages::VERTEX,
    // rust: });
    // rust: let hud = HudBatch::new(SIZE);
    // rust: let frame = fixture_frame(&hud);
    // rust: Some(
    // rust: gpu.render(&mut post, &color, &depth, &frame, &mut |rp, list, _, _| {
    // rust: if list == TerrainList::ShadowSolid {
    // rust: rp.set_vertex_buffer(0, vertices.slice(..));
    // rust: rp.draw(0..6, 0..1);
}
    // rust: }),
    // rust: )
}

shadow_depth_is_read_linearly_through_a_plain_sampler :: proc() {
}
    // Iris 1.11.7 filters both (probe packs of our own; the PR has the readings).
    // rust: if let Some(pixels) = shadow_depth_filtering("") {
    // rust: all_pixels(&pixels, [255, 255, 0, 255], "shadowtex linear");
}
}

shadow_depth_reads_filter_directly_and_with_a_texel_offset :: proc() {
}
    // texture2D on the sampler itself, and textureOffset one texel to the right: both a quarter
    // texel past a centre, so each moves a quarter of the way to the next texel.
    // rust: let reads = "void main() {\n\
    // rust: ivec2 t = ivec2(int(gl_FragCoord.x) % 14, 8);\n\
    // rust: vec2 p = (vec2(t) + vec2(0.75, 0.5)) / 16.0;\n\
    // rust: float a = texelFetch(shadowtex0, t, 0).r;\n\
    // rust: float b = texelFetch(shadowtex1, t + ivec2(1, 0), 0).r;\n\
    // rust: float r = (texture2D(shadowtex0, p).r - a) * 64.0;\n\
    // rust: float g = (textureOffset(shadowtex1, p, ivec2(1, 0)).r - b) * 64.0;\n\
    // rust: gl_FragColor = vec4(r, g, 0.0, 1.0);\n\
    // rust: }\n";
    // rust: if let Some(pixels) = shadow_depth_reads("", reads) {
    // rust: all_pixels(&pixels, [255, 255, 0, 255], "shadowtex direct and offset");
}
}

shadow_depth_filter_weights_are_256ths_as_in_our_iris_readings :: proc() {
}
    // The map is at the far plane but for texel (8, 8), which is nearer. Reads between texels
    // (7, 7) and (8, 8) give (8, 8)'s weight: Iris 1.11.7's filtered reads on our NVIDIA GPU
    // fit weights of 1/256 along each axis, rounded half up, and a corner's product weight
    // rounded half up to 1/256 (#8464). Red: a read a + 0.25/256 of the way along x only
    // moves a/256 (77). Green: at (77.25, 77.25)/256 along both, (8, 8) weighs 23/256
    // (77 × 77 / 256 = 23.16; exact weights would give 23.31).
    // rust: let reads = "void main() {\n\
    // rust: float far = texelFetch(shadowtex0, ivec2(7, 7), 0).r;\n\
    // rust: float near = texelFetch(shadowtex0, ivec2(8, 8), 0).r;\n\
    // rust: float f = 77.25 / 256.0;\n\
    // rust: float along = texture(shadowtex0, vec2(7.5 + f, 8.5) / 16.0).r;\n\
    // rust: float corner = texture(shadowtex0, vec2(7.5 + f, 7.5 + f) / 16.0).r;\n\
    // rust: float x = (far - along) / (far - near) * 256.0;\n\
    // rust: float w = (far - corner) / (far - near) * 256.0;\n\
    // rust: gl_FragColor = vec4(abs(x - 77.0) < 0.01 ? 1.0 : 0.0,\n\
    // rust: abs(w - 23.0) < 0.01 ? 1.0 : 0.0, 0.0, 1.0);\n\
    // rust: }\n";
    // Texel (8, 8) of the 16² map: x and y from 0 to 1/8 in clip space, depth 0.
    // rust: let bump = [
    // rust: [0., 0., -1.],
    // rust: [0.125, 0., -1.],
    // rust: [0.125, 0.125, -1.],
    // rust: [0., 0., -1.],
    // rust: [0.125, 0.125, -1.],
    // rust: [0., 0.125, -1.],
    // rust: ];
    // rust: let vsh = "#version 120\nvoid main(){gl_Position=vec4(gl_Vertex.xyz,1.0);}";
    // rust: if let Some(pixels) = shadow_depth_map_reads("", reads, vsh, bump) {
    // rust: all_pixels(&pixels, [255, 255, 0, 255], "shadowtex filter weights");
}
}

shadowtex_nearest_settings_read_the_nearest_texel :: proc() {
}
    // rust: for (line, expected) in [
    // rust: ("const bool shadowtex0Nearest = true;", [0, 255, 0, 255]),
    // rust: ("const bool shadowtexNearest = true;", [0, 255, 0, 255]),
    // rust: ("const bool shadow0MinMagNearest = true;", [0, 255, 0, 255]),
    // rust: ("const bool shadowtex1Nearest = true;", [255, 0, 0, 255]),
    // rust: ("const bool shadow1MinMagNearest = true;", [255, 0, 0, 255]),
    // rust: ] {
    // rust: if let Some(pixels) = shadow_depth_filtering(line) {
    // rust: all_pixels(&pixels, expected, line);
}
}
}

// The sky program covers the horizon and downward viewing directions too.
// This original probe reports sky colour in RGB and window depth in alpha.
sky_covers_the_horizon_without_writing_depth_or_overpainting_terrain :: proc() {
}
    // rust: let gpu = Gpu::new().expect("GPU required for the sky coverage regression");
    // rust: assert_ne!(gpu.adapter.get_info().device_type, wgpu::DeviceType::Cpu);
    // rust: let color = gpu.texture(T::Rgba8Unorm);
    // rust: let depth = gpu.texture(T::Depth32Float);
    // rust: let files = vec![
    // rust: ("gbuffers_skybasic.vsh".into(), "#version 120\nvoid main(){gl_Position=ftransform();}".into()),
    // rust: ("gbuffers_skybasic.fsh".into(), "#version 120\n/* DRAWBUFFERS:0 */\nvoid main(){gl_FragData[0]=vec4(1.0,0.0,0.0,1.0);}".into()),
    // rust: ("final.vsh".into(), VERTEX.into()),
    // rust: ("final.fsh".into(), "#version 120\nuniform sampler2D colortex0;uniform sampler2D depthtex0;varying vec2 uv;\nconst vec4 colortex0ClearColor=vec4(0.0,1.0,0.0,1.0);\nvoid main(){gl_FragColor=vec4(texture2D(colortex0,uv).rgb,texture2D(depthtex0,uv).r);}".into()),
    // rust: ];
    // rust: let mut post = gpu.load(
    // rust: files,
    // rust: World {
    // rust: atlas: None,
    // rust: material_maps: None,
    // rust: lightmap: color.clone(),
    // rust: terrain: None,
    // rust: block_ids: &[],
    // rust: sprite_rects: &[],
    // rust: celestial: None,
    // rust: gui_size: SIZE,
    // rust: clouds: None,
    // rust: weather: false,
    // rust: hand: false,
    // rust: },
    // rust: horizon_shaders::GameInputs {
    // rust: sky: Some(crate::gfx::pack_sky::inputs()),
    // rust: ..Default::default()
    // rust: },
    // rust: );
    // rust: let hud = HudBatch::new(SIZE);
    // rust: let mut frame = fixture_frame(&hud);
    // rust: frame.title = false;
    // rust: frame.skybox = true;
    // rust: frame.distance = 512.0;
    // rust: frame.detail_distance = 512.0;
    // rust: frame.depth_far = 2048.0;
    // rust: for yaw in [0.0, 45.0, 90.0, 180.0, 270.0] {
    // rust: for pitch in [-60.0, 0.0, 21.1, 60.0] {
    // rust: frame.yaw = yaw;
    // rust: frame.pitch = pitch;
    // rust: gpu.clear(&color, &depth, 0.0);
    // rust: let pixels = gpu.render(&mut post, &color, &depth, &frame, &mut |_, _, _, _| {});
    // rust: all_pixels(
    // rust: &pixels,
    // rust: [255, 0, 0, 255],
    // rust: &format!("sky yaw={yaw} pitch={pitch}"),
    // rust: );
}
}
    // A pre-existing foreground depth must survive the sky, as must its colour.
    // rust: gpu.clear(&color, &depth, 0.5);
    // rust: let pixels = gpu.render(&mut post, &color, &depth, &frame, &mut |_, _, _, _| {});
    // rust: all_pixels(
    // rust: &pixels,
    // rust: [16, 16, 16, 128],
    // rust: "foreground colour and depth survive sky",
    // rust: );
}
