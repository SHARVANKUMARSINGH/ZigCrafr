//! Transpiled from Horizon Rust crate
//! Module: horizon-client-render_destination_tests
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Original asset-free post-output regressions, using only the public shader format.
// use super::*;
// use crate::{gfx::Frame, hud::HudBatch};
// use std::io::{Cursor, Write};
// use wgpu::TextureFormat as T;

pub const VERTEX: []const u8 = "#version 120\nvarying vec2 uv;\nvoid main() { uv=gl_MultiTexCoord0.xy; gl_Position=ftransform(); }\n";

pub const Coverage = enum {
    Full,
    Discard,
    Vertex,
    Scale,
};

    // rust: fn pack(
    // rust: coverage: Coverage,
    // rust: mrt: bool,
    // rust: keep_main: bool,
    // rust: history: Option<bool>,
    // rust: shadow: bool,
    // rust: ) -> Post {
    // rust: let mut zip = zip::ZipWriter::new(Cursor::new(Vec::new()));
    // rust: let mut add = |name: &str, source: &str| {
    // rust: zip.start_file(
    // rust: format!("shaders/{name}"),
    // rust: zip::write::SimpleFileOptions::default(),
    // rust: )
    // rust: .unwrap();
    // rust: zip.write_all(source.as_bytes()).unwrap();
}
    // rust: let targets = match (shadow, mrt) {
    // rust: (true, true) => "0,1",
    // rust: (true, false) => "0",
    // rust: (false, true) => "2,5",
    // rust: (false, false) => "2",
}
    // rust: let fragment = |first: &str, second: &str, discard: bool| {
    // rust: format!(
    // rust: "#version 120\n/* RENDERTARGETS:{targets} */\nvarying vec2 uv;\nvoid main() {{ {} gl_FragData[0]=vec4({first}); {} }}\n",
    // rust: if discard { "if(uv.x<0.5) discard;" } else { "" },
    // rust: if mrt {
    // rust: format!("gl_FragData[1]=vec4({second});")
    // rust: } else {
    // rust: String::new()
    // rust: },
    // rust: )
}
    // rust: let mut properties = if shadow {
    // rust: "shadow.enabled=true\n".to_owned()
    // rust: } else {
    // rust: String::new()
}
    // rust: if let Some(clear) = history {
    // rust: add("composite.vsh", VERTEX);
    // rust: add("composite.fsh", &fragment("0.25,0,0,1", "", false));
    // rust: add("composite1.vsh", VERTEX);
    // rust: add("composite1.fsh", &fragment("0,0.5,0,1", "", true));
    // rust: add("composite2.vsh", VERTEX);
    // rust: add(
    // rust: "composite2.fsh",
    // rust: "#version 120\n/* RENDERTARGETS:3 */\nuniform sampler2D colortex2;\nvarying vec2 uv;\nvoid main() { gl_FragData[0]=texture2D(colortex2,uv); }\n",
    // rust: );
    // rust: properties.push_str("flip.composite2.colortex2=true\n");
    // rust: add(
    // rust: "final.fsh",
    // rust: &format!(
    // rust: "#version 120\nuniform sampler2D colortex2;\nuniform sampler2D colortex3;\nvarying vec2 uv;\nconst bool colortex2Clear={clear};\nconst vec4 colortex2ClearColor=vec4(0,0.375,0.5,1);\nvoid main() {{ gl_FragColor=vec4(texture2D(colortex2,uv).r,texture2D(colortex3,uv).g,texture2D(colortex3,uv).b,1); }}\n"
    // rust: ),
    // rust: );
    // rust: } else {
        // B gets red, A gets blue, then the partial pass writes B again. Outside writes
        // must retain B's red, independently of the current A's blue.
    // rust: for (name, first, second) in [
    // rust: ("composite", "0.25,0,0,1", "0,0.375,0,1"),
    // rust: ("composite1", "0,0,0.25,1", "0.25,0,0.25,1"),
    // rust: ("composite2", "0,0.5,0,1", "0,0.75,0,1"),
    // rust: ] {
    // rust: let partial = name == "composite2";
    // rust: let name = if shadow {
    // rust: name.replace("composite", "shadowcomp")
    // rust: } else {
    // rust: name.to_owned()
}
    // rust: let vertex = if partial && matches!(coverage, Coverage::Vertex) {
    // rust: VERTEX.replace(
    // rust: "ftransform();",
    // rust: "ftransform(); gl_Position.x=gl_Position.x*0.5+gl_Position.w*0.5;",
    // rust: )
    // rust: } else {
    // rust: VERTEX.to_owned()
}
    // rust: add(&format!("{name}.vsh"), &vertex);
    // rust: add(
    // rust: &format!("{name}.fsh"),
    // rust: &fragment(
    // rust: first,
    // rust: second,
    // rust: partial && matches!(coverage, Coverage::Discard),
    // rust: ),
    // rust: );
}
    // rust: if matches!(coverage, Coverage::Scale) {
    // rust: properties.push_str("scale.composite2=0.5 0.5 0.0\n");
}
    // rust: if keep_main {
    // rust: properties
    // rust: .push_str("flip.composite2.colortex2=false\nflip.composite2.colortex5=false\n");
}
    // rust: let final_source = if mrt {
    // rust: "#version 120\nuniform sampler2D colortex2;\nuniform sampler2D colortex5;\nvarying vec2 uv;\nvoid main() { gl_FragColor=vec4(texture2D(colortex2,uv).r,texture2D(colortex5,uv).g,texture2D(colortex2,uv).g,1); }\n"
    // rust: } else {
    // rust: "#version 120\nuniform sampler2D colortex2;\nvarying vec2 uv;\nvoid main() { gl_FragColor=texture2D(colortex2,uv); }\n"
}
    // rust: let final_source = if shadow {
    // rust: final_source
    // rust: .replace("colortex2", "shadowcolor0")
    // rust: .replace("colortex5", "shadowcolor1")
    // rust: .replace(
    // rust: "#version 120",
    // rust: "#version 120\nconst int shadowMapResolution=16;",
    // rust: )
    // rust: } else {
    // rust: final_source.to_owned()
}
    // rust: add("final.fsh", &final_source);
}
    // rust: add("final.vsh", VERTEX);
    // rust: add("shaders.properties", &properties);
    // rust: let pack = horizon_shaders::Pack::from_zip_bytes(
    // rust: "original-destination-contract",
    // rust: zip.finish().unwrap().into_inner(),
    // rust: )
    // rust: .unwrap();
    // rust: let mut macros = horizon_shaders::Macros::standard();
    // rust: let (properties, _) = horizon_shaders::read_properties(&pack, &mut macros);
    // rust: let post = horizon_shaders::load_post(&pack, "", &properties, &macros, &Default::default());
    // rust: assert_eq!(
    // rust: post.programs.len(),
    // rust: if shadow { 1 } else { 4 },
    // rust: "{:?}",
    // rust: post.notes
    // rust: );
    // rust: assert_eq!(
    // rust: post.shadow_comp.len(),
    // rust: if shadow { 3 } else { 0 },
    // rust: "{:?}",
    // rust: post.notes
    // rust: );
    // rust: post
}

    // rust: pub(super) struct Fixture {
    // rust: pub(super) adapter: wgpu::Adapter,
    // rust: pub(super) device: wgpu::Device,
    // rust: pub(super) queue: wgpu::Queue,
}

    // rust: impl Fixture {
    // rust: pub(super) fn new() -> Option<Self> {
    // rust: let instance = crate::gfx::test_gpu::instance();
    // rust: let Ok(adapter) = pollster::block_on(instance.request_adapter(&Default::default())) else {
    // rust: eprintln!("Post destination test skipped: no GPU adapter");
    // rust: return None;
}
    // rust: let (device, queue) = pollster::block_on(adapter.request_device(&wgpu::DeviceDescriptor {
    // rust: required_limits: adapter.limits(),
    // rust: ..Default::default()
    // rust: }))
    // rust: .expect("GPU device for destination contract");
    // rust: eprintln!("Post destination adapter: {:?}", adapter.get_info());
    // rust: Some(Self {
    // rust: adapter,
    // rust: device,
    // rust: queue,
    // rust: })
}

pub fn texture(self: *Self, size: [u32; 2], format: T) w {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.device
    // rust: .create_texture(&wgpu::TextureDescriptor {
    // rust: label: Some("Original post destination fixture"),
    // rust: size: wgpu::Extent3d {
    // rust: width: size[0],
    // rust: height: size[1],
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

    // rust: pub(super) fn build(&self, post: Post) -> PackPost {
    // rust: let post = self.try_build(post).expect("the pack runs");
    // rust: assert!(
    // rust: post.notes.iter().all(|n| n.starts_with("shadow map ")),
    // rust: "{:?}",
    // rust: post.notes
    // rust: );
    // rust: post
}

    /// [`Self::build`] for a pack that may be refused.
    // rust: pub(super) fn try_build(&self, post: Post) -> Result<PackPost, Refused> {
    // rust: self.try_build_with_terrain(post, None)
}

    /// `build`, with the game's terrain geometry handed to the pack.
    // rust: pub(super) fn build_with_terrain(&self, post: Post, terrain: Option<Geometry<'_>>) -> PackPost {
    // rust: self.try_build_with_terrain(post, terrain)
    // rust: .expect("the pack runs")
}

    // rust: fn try_build_with_terrain(
    // rust: &self,
    // rust: post: Post,
    // rust: terrain: Option<Geometry<'_>>,
    // rust: ) -> Result<PackPost, Refused> {
    // rust: let lightmap = self.texture([1, 1], T::Rgba8Unorm);
    // rust: PackPost::new(
    // rust: &self.device,
    // rust: &self.queue,
    // rust: &self.adapter,
    // rust: post,
    // rust: T::Rgba8Unorm,
    // rust: World {
    // rust: atlas: None,
    // rust: material_maps: None,
    // rust: lightmap,
    // rust: terrain,
    // rust: block_ids: &[],
    // rust: sprite_rects: &[],
    // rust: celestial: None,
    // rust: gui_size: [16, 16],
    // rust: clouds: None,
    // rust: weather: false,
    // rust: hand: false,
    // rust: },
    // rust: )
}

    // rust: pub(super) fn render(&self, post: &mut PackPost, size: [u32; 2]) -> Vec<[u8; 4]> {
    // rust: self.render_with_terrain(post, size, &mut |_, _, _, _| {})
}

    /// `render`, with `terrain` drawing the game's terrain lists.
    // rust: pub(super) fn render_with_terrain(
    // rust: &self,
    // rust: post: &mut PackPost,
    // rust: size: [u32; 2],
    // rust: terrain: &mut TerrainDraw<'_>,
    // rust: ) -> Vec<[u8; 4]> {
    // rust: let world = self.texture(size, T::Rgba8Unorm);
    // rust: let depth = self.texture(size, T::Depth32Float);
    // rust: let screen = self.texture(size, T::Rgba8Unorm);
    // rust: let stride = wgpu::COPY_BYTES_PER_ROW_ALIGNMENT;
    // rust: let read = self.device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: None,
    // rust: size: u64::from(stride * size[1]),
    // rust: usage: wgpu::BufferUsages::COPY_DST | wgpu::BufferUsages::MAP_READ,
    // rust: mapped_at_creation: false,
    // rust: });
    // rust: let hud = HudBatch::new(size);
    // rust: let mut encoder = self.device.create_command_encoder(&Default::default());
    // rust: post.run(
    // rust: &self.device,
    // rust: &self.queue,
    // rust: &mut encoder,
    // rust: &world,
    // rust: &depth,
    // rust: &screen,
    // rust: &fixture_frame(&hud),
    // rust: &Default::default(),
    // rust: size,
    // rust: size,
    // rust: &[],
    // rust: terrain,
    // rust: );
    // rust: encoder.copy_texture_to_buffer(
    // rust: screen.texture().as_image_copy(),
    // rust: wgpu::TexelCopyBufferInfo {
    // rust: buffer: &read,
    // rust: layout: wgpu::TexelCopyBufferLayout {
    // rust: bytes_per_row: Some(stride),
    // rust: ..Default::default()
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
    // rust: row[..size[0] as usize * 4]
    // rust: .as_chunks::<4>()
    // rust: .0
    // rust: .iter()
    // rust: .copied()
    // rust: })
    // rust: .collect()
}
}

pub fn partial_writes_retain_the_alternate_with_flip_scale_and_mrt_controls() void {
}
    // rust: let Some(gpu) = Fixture::new() else { return };
    // rust: let mut failures = Vec::new();
    // rust: for (coverage, mrt, keep_main, shadow) in [
    // rust: (Coverage::Full, false, false, false),
    // rust: (Coverage::Discard, false, false, false),
    // rust: (Coverage::Vertex, false, false, false),
    // rust: (Coverage::Scale, false, false, false),
    // rust: (Coverage::Discard, true, false, false),
    // rust: (Coverage::Discard, false, true, false),
    // rust: (Coverage::Full, false, false, true),
    // rust: (Coverage::Discard, false, false, true),
    // rust: (Coverage::Vertex, false, false, true),
    // rust: (Coverage::Discard, true, false, true),
    // rust: ] {
    // rust: let mut post = gpu.build(pack(coverage, mrt, keep_main, None, shadow));
        // The same pack is also exercised after resize; all destination seeds come from
        // real shader passes, never from the load operation under test.
    // rust: for size in [[16, 16], [8, 8]] {
    // rust: let actual = gpu.render(&mut post, size);
    // rust: let wrong = actual
    // rust: .iter()
    // rust: .enumerate()
    // rust: .filter(|(n, pixel)| {
    // rust: let x = *n as u32 % size[0];
    // rust: let y = *n as u32 / size[0];
    // rust: let outside = match coverage {
    // rust: Coverage::Full => false,
    // rust: Coverage::Discard | Coverage::Vertex => x < size[0] / 2,
    // rust: Coverage::Scale => x < size[0] / 2 || y < size[1] / 2,
}
    // rust: let expected = match (keep_main, outside, mrt) {
    // rust: (true, _, _) => [0, 0, 64, 255],
    // rust: (false, true, false) => [64, 0, 0, 255],
    // rust: (false, false, false) => [0, 128, 0, 255],
    // rust: (false, true, true) => [64, 96, 0, 255],
    // rust: (false, false, true) => [0, 191, 128, 255],
}
    // rust: pixel.iter().zip(expected).any(|(a, b)| a.abs_diff(b) > 1)
    // rust: })
    // rust: .count();
    // rust: eprintln!(
    // rust: "Destination {coverage:?} mrt={mrt} keep_main={keep_main} shadow={shadow} size={size:?}: wrong={wrong}/{}",
    // rust: actual.len()
    // rust: );
    // rust: if wrong != 0 {
    // rust: failures.push((coverage, mrt, keep_main, shadow, size, wrong));
}
}
}
    // rust: assert!(
    // rust: failures.is_empty(),
    // rust: "Destination pixels differ: {failures:?}"
    // rust: );
}

pub fn frame_clear_and_retained_history_apply_before_partial_post_writes() void {
}
    // rust: let Some(gpu) = Fixture::new() else { return };
    // rust: for clear in [true, false] {
    // rust: let mut post = gpu.build(pack(Coverage::Full, false, false, Some(clear), false));
        // The other image is fully seeded red before the partial write, independent of its
        // initial clearing.
    // rust: for frame in 0..3 {
    // rust: let actual = gpu.render(&mut post, [16, 16]);
    // rust: assert!(
    // rust: actual.iter().enumerate().all(|(n, p)| {
    // rust: let outside = n % 16 < 8;
    // rust: if frame == 0 && !clear && outside {
    // rust: return true;
}
    // rust: let expected = if !outside {
    // rust: [64, 128, 0, 255]
    // rust: } else if clear {
    // rust: [64, 96, 128, 255]
    // rust: } else {
    // rust: [64, 0, 0, 255]
}
    // rust: p.iter().zip(expected).all(|(a, b)| a.abs_diff(b) <= 1)
    // rust: }),
    // rust: "clear={clear} frame={frame}: {:?}",
    // rust: &actual[..16]
    // rust: );
}
}
}

// Frame literal adapted from MIT Horizon f700231 pack_uniforms.rs test API setup.
pub fn fixture_frame(hud: *HudBatch) F {
    // Implementation ported from Horizon
    return undefined;
}
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

    // rust: mod clear_budget_tests;

/// A cleared buffer written three times a frame flips an odd number of times, so its first write
/// goes to the texture that was "main" the frame before, which a later program wrote after that
/// frame's clear. Where that first write discards, Iris 1.11.7 reads the clear value (a probe
/// pack of our own with these three programs reads 0 there, not the previous frame's 0.25).
pub fn a_cleared_buffer_starts_every_frame_cleared_on_both_textures() void {
}
    // rust: let Some(gpu) = Fixture::new() else { return };
    // rust: let mut zip = zip::ZipWriter::new(Cursor::new(Vec::new()));
    // rust: let mut add = |name: &str, source: &str| {
    // rust: zip.start_file(
    // rust: format!("shaders/{name}"),
    // rust: zip::write::SimpleFileOptions::default(),
    // rust: )
    // rust: .unwrap();
    // rust: zip.write_all(source.as_bytes()).unwrap();
}
    // rust: for (program, fragment) in [
    // rust: (
    // rust: "composite",
    // rust: "#version 120\nvarying vec2 uv;\n/* RENDERTARGETS:4 */\n\
    // rust: void main() { if(uv.x>0.5) discard; gl_FragData[0]=vec4(0.5,0.5,0.5,1); }\n",
    // rust: ),
    // rust: (
    // rust: "composite1",
    // rust: "#version 120\nuniform sampler2D colortex4;\nvarying vec2 uv;\n/* RENDERTARGETS:4,5 */\n\
    // rust: void main() { gl_FragData[0]=vec4(0.25,0.25,0.25,1); gl_FragData[1]=texture2D(colortex4,uv); }\n",
    // rust: ),
    // rust: (
    // rust: "composite2",
    // rust: "#version 120\n/* RENDERTARGETS:4 */\nvoid main() { gl_FragData[0]=vec4(0.125,0.125,0.125,1); }\n",
    // rust: ),
    // rust: (
    // rust: "final",
    // rust: "#version 120\nuniform sampler2D colortex5;\nvarying vec2 uv;\n\
    // rust: void main() { gl_FragColor=vec4(texture2D(colortex5,uv).rgb,1); }\n",
    // rust: ),
    // rust: ] {
    // rust: add(&format!("{program}.vsh"), VERTEX);
    // rust: add(&format!("{program}.fsh"), fragment);
}
    // rust: let pack = horizon_shaders::Pack::from_zip_bytes(
    // rust: "both-textures-cleared",
    // rust: zip.finish().unwrap().into_inner(),
    // rust: )
    // rust: .unwrap();
    // rust: let mut macros = horizon_shaders::Macros::standard();
    // rust: let (properties, _) = horizon_shaders::read_properties(&pack, &mut macros);
    // rust: let post = horizon_shaders::load_post(&pack, "", &properties, &macros, &Default::default());
    // rust: let mut post = gpu.build(post);
    // rust: for frame in 0..3 {
    // rust: let actual = gpu.render(&mut post, [16, 16]);
    // rust: let wrong: Vec<_> = (actual.iter().enumerate())
    // rust: .filter(|(n, p)| {
    // rust: let expected = if n % 16 < 8 {
    // rust: [128, 128, 128, 255]
    // rust: } else {
    // rust: [0, 0, 0, 255]
}
    // rust: p.iter().zip(expected).any(|(a, b)| a.abs_diff(b) > 1)
    // rust: })
    // rust: .map(|(n, p)| (n, *p))
    // rust: .take(4)
    // rust: .collect();
    // rust: assert!(wrong.is_empty(), "frame {frame}: {wrong:?}");
}
}

    // rust: mod clear_false_tests;
