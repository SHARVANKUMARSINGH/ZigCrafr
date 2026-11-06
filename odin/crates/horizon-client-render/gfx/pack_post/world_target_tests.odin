//! Transpiled from Horizon Rust crate
package horizon_client_render_world_target_tests

import "core:fmt"
import "core:mem"
import "core:math"

// Original offscreen inputs exercise the production blit and post-processing output.
// use super::*;
// use crate::{gfx::Frame, hud::HudBatch};
// use std::io::{Cursor, Write};
// use wgpu::TextureFormat as T;

Change :: enum {
    Colour,
    Depth,
    Both,
    Contents,
    Resize,
}

replacing_only_world_colour_at_the_same_size_reads_the_new_view :: proc() {
}
    // rust: replacement(Change::Colour, true);
}

replacing_only_world_depth_at_the_same_size_reads_the_new_view :: proc() {
}
    // rust: replacement(Change::Depth, true);
}

replacing_both_world_views_at_the_same_size_matches_fresh_bindings :: proc() {
}
    // rust: replacement(Change::Both, true);
}

retained_world_views_read_updated_contents :: proc() {
}
    // rust: replacement(Change::Contents, true);
}

resized_world_views_match_fresh_bindings :: proc() {
}
    // rust: replacement(Change::Resize, true);
}

a_pack_without_final_reads_the_replaced_world_colour :: proc() {
}
    // rust: replacement(Change::Colour, false);
}

// A Resolution Scale leaves the pack's picture smaller than the window. Its `final` draws at
// the picture's size and one copy upsizes it to the window (#9291), so a final that fetches
// its pixel by `gl_FragCoord` (as Photon's does) covers every pixel, not a quarter of them.
a_scaled_picture_fills_the_whole_window :: proc() {
}
    // rust: let instance = crate::gfx::test_gpu::instance();
    // rust: let Ok(adapter) = pollster::block_on(instance.request_adapter(&Default::default())) else {
    // rust: return;
}
    // rust: let Ok((device, queue)) = pollster::block_on(adapter.request_device(&wgpu::DeviceDescriptor {
    // rust: required_limits: adapter.limits(),
    // rust: ..Default::default()
    // rust: })) else {
    // rust: return;
}
    // rust: eprintln!("scaled picture adapter: {:?}", adapter.get_info());
    // rust: let picture = [4, 2];
    // rust: let window = [8, 4];
    // rust: let colour = texture(&device, picture, T::Rgba8Unorm);
    // rust: let depth = texture(&device, picture, T::Depth32Float);
    // rust: clear(&device, &queue, &colour, &depth, [32, 64, 16, 255], 0.25);
    // rust: let mut post = pack_with(
    // rust: &device,
    // rust: &queue,
    // rust: &adapter,
    // rust: &colour,
    // rust: &[
    // rust: (
    // rust: "final.vsh",
    // rust: "#version 120\nvoid main(){gl_Position=ftransform();}",
    // rust: ),
    // rust: (
    // rust: "final.fsh",
    // rust: "#version 330 compatibility\nuniform sampler2D colortex0;\nvoid main(){gl_FragColor=texelFetch(colortex0,ivec2(gl_FragCoord.xy),0);}",
    // rust: ),
    // rust: ],
    // rust: );
    // rust: let hud = HudBatch::new(window);
    // rust: let pixels = render(
    // rust: &device,
    // rust: &queue,
    // rust: &mut post,
    // rust: &colour,
    // rust: &depth,
    // rust: &frame(&hud),
    // rust: picture,
    // rust: window,
    // rust: );
    // Independently specified: the world's colour at every window pixel.
    // rust: let wrong = pixels.iter().filter(|p| **p != [32, 64, 16, 255]).count();
    // rust: assert_eq!(
    // rust: wrong,
    // rust: 0,
    // rust: "{wrong} of {} pixels are not the picture",
    // rust: pixels.len()
    // rust: );
}

replacement :: proc(change: Change, final_shader: bool) {
}
    // rust: let instance = crate::gfx::test_gpu::instance();
    // rust: let Ok(adapter) = pollster::block_on(instance.request_adapter(&Default::default())) else {
    // rust: return;
}
    // rust: let Ok((device, queue)) = pollster::block_on(adapter.request_device(&wgpu::DeviceDescriptor {
    // rust: required_limits: adapter.limits(),
    // rust: ..Default::default()
    // rust: })) else {
    // rust: return;
}
    // rust: eprintln!("world-target adapter: {:?}", adapter.get_info());
    // rust: let mut size = [4, 2];
    // rust: let mut colour = texture(&device, size, T::Rgba8Unorm);
    // rust: let mut depth = texture(&device, size, T::Depth32Float);
    // rust: clear(&device, &queue, &colour, &depth, [32, 64, 16, 255], 0.25);
    // rust: let mut post = pack(&device, &queue, &adapter, &colour, final_shader);
    // rust: let hud = HudBatch::new(size);
    // rust: let frame = frame(&hud);
    // rust: let initial = render(
    // rust: &device, &queue, &mut post, &colour, &depth, &frame, size, size,
    // rust: );
    // rust: let expected = if final_shader {
    // rust: [32, 64, 191, 255]
    // rust: } else {
    // rust: [32, 64, 16, 255]
}
    // rust: assert!(
    // rust: initial.iter().all(|pixel| *pixel == expected),
    // rust: "{initial:?}"
    // rust: );

    // rust: if matches!(change, Change::Resize) {
    // rust: size = [6, 3];
}
    // rust: if matches!(change, Change::Colour | Change::Both | Change::Resize) {
    // rust: colour = texture(&device, size, T::Rgba8Unorm);
}
    // rust: if matches!(change, Change::Depth | Change::Both | Change::Resize) {
    // rust: depth = texture(&device, size, T::Depth32Float);
}
    // rust: let pixel = if matches!(change, Change::Depth) {
    // rust: [32, 64, 16, 255]
    // rust: } else {
    // rust: [160, 96, 48, 255]
}
    // rust: let reverse_depth = if matches!(change, Change::Colour) {
    // rust: 0.25
    // rust: } else {
    // rust: 0.75
}
    // rust: clear(&device, &queue, &colour, &depth, pixel, reverse_depth);
    // rust: let actual = render(
    // rust: &device, &queue, &mut post, &colour, &depth, &frame, size, size,
    // rust: );
    // rust: let mut fresh = pack(&device, &queue, &adapter, &colour, final_shader);
    // rust: let reference = render(
    // rust: &device, &queue, &mut fresh, &colour, &depth, &frame, size, size,
    // rust: );
    // Independently specified RG channels and GL depth (1 - reverse-Z), in UNORM8.
    // rust: let expected = if !final_shader {
    // rust: [160, 96, 48, 255]
    // rust: } else if matches!(change, Change::Colour) {
    // rust: [160, 96, 191, 255]
    // rust: } else if matches!(change, Change::Depth) {
    // rust: [32, 64, 64, 255]
    // rust: } else {
    // rust: [160, 96, 64, 255]
}
    // rust: assert!(
    // rust: reference.iter().all(|pixel| *pixel == expected),
    // rust: "{reference:?}"
    // rust: );
    // rust: eprintln!("world-target {change:?}, final={final_shader}, size={size:?}: {actual:?}");
    // rust: assert_eq!(
    // rust: actual, reference,
    // rust: "current world inputs must match fresh bindings"
    // rust: );
}

texture :: proc(device: ^wgpu::Device, height]: [u32; 2], format: T) -> w {
    // Ported from Horizon
    return {}
}
    // rust: device
    // rust: .create_texture(&wgpu::TextureDescriptor {
    // rust: label: Some("Original world-target regression input"),
    // rust: size: wgpu::Extent3d {
    // rust: width,
    // rust: height,
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

    // rust: fn clear(
    // rust: device: &wgpu::Device,
    // rust: queue: &wgpu::Queue,
    // rust: colour: &wgpu::TextureView,
    // rust: depth: &wgpu::TextureView,
    // rust: pixel: [u8; 4],
    // rust: reverse_depth: f32,
    // rust: ) {
    // rust: let [r, g, b, a] = pixel.map(|n| f64::from(n) / 255.0);
    // rust: let mut encoder = device.create_command_encoder(&Default::default());
    // rust: encoder.begin_render_pass(&wgpu::RenderPassDescriptor {
    // rust: color_attachments: &[Some(wgpu::RenderPassColorAttachment {
    // rust: view: colour,
    // rust: resolve_target: None,
    // rust: depth_slice: None,
    // rust: ops: wgpu::Operations {
    // rust: load: wgpu::LoadOp::Clear(wgpu::Color { r, g, b, a }),
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
    // rust: queue.submit([encoder.finish()]);
}

    // rust: fn pack(
    // rust: device: &wgpu::Device,
    // rust: queue: &wgpu::Queue,
    // rust: adapter: &wgpu::Adapter,
    // rust: lightmap: &wgpu::TextureView,
    // rust: final_shader: bool,
    // rust: ) -> PackPost {
    // rust: let programs: &[(&str, &str)] = if final_shader {
    // rust: &[
    // rust: (
    // rust: "final.vsh",
    // rust: "#version 120\nvarying vec2 uv;\nvoid main(){gl_Position=ftransform();uv=gl_MultiTexCoord0.xy;}",
    // rust: ),
    // rust: (
    // rust: "final.fsh",
    // rust: "#version 120\nvarying vec2 uv;uniform sampler2D colortex0;uniform sampler2D depthtex0;\nvoid main(){gl_FragColor=vec4(texture2D(colortex0,uv).rg,texture2D(depthtex0,uv).r,1.0);}",
    // rust: ),
    // rust: ]
    // rust: } else {
    // rust: &[]
}
    // rust: pack_with(device, queue, adapter, lightmap, programs)
}

// A pack of `programs` (`name`, GLSL source) over `lightmap`.
    // rust: fn pack_with(
    // rust: device: &wgpu::Device,
    // rust: queue: &wgpu::Queue,
    // rust: adapter: &wgpu::Adapter,
    // rust: lightmap: &wgpu::TextureView,
    // rust: programs: &[(&str, &str)],
    // rust: ) -> PackPost {
    // rust: let mut zip = zip::ZipWriter::new(Cursor::new(Vec::new()));
    // rust: let options = zip::write::SimpleFileOptions::default();
    // rust: zip.start_file("shaders/shaders.properties", options)
    // rust: .unwrap();
    // rust: zip.write_all(b"oldLighting=false\n").unwrap();
    // rust: for (name, source) in programs {
    // rust: zip.start_file(format!("shaders/{name}"), options).unwrap();
    // rust: zip.write_all(source.as_bytes()).unwrap();
}
    // rust: let pack = horizon_shaders::Pack::from_zip_bytes(
    // rust: "original-world-inputs",
    // rust: zip.finish().unwrap().into_inner(),
    // rust: )
    // rust: .unwrap();
    // rust: let macros = horizon_shaders::Macros::standard();
    // rust: let properties = horizon_shaders::Properties::parse("oldLighting=false", &macros);
    // rust: let post = horizon_shaders::load_post(&pack, "", &properties, &macros, &Default::default());
    // rust: assert!(post.notes.is_empty(), "{:?}", post.notes);
    // rust: let post = PackPost::new(
    // rust: device,
    // rust: queue,
    // rust: adapter,
    // rust: post,
    // rust: T::Rgba8Unorm,
    // rust: World {
    // rust: atlas: None,
    // rust: material_maps: None,
    // rust: lightmap: lightmap.clone(),
    // rust: terrain: None,
    // rust: block_ids: &[],
    // rust: sprite_rects: &[],
    // rust: celestial: None,
    // rust: gui_size: [1, 1],
    // rust: clouds: None,
    // rust: weather: false,
    // rust: hand: false,
    // rust: },
    // rust: )
    // rust: .expect("the pack runs");
    // rust: assert!(post.notes.is_empty(), "{:?}", post.notes);
    // rust: post
}

    // rust: fn render(
    // rust: device: &wgpu::Device,
    // rust: queue: &wgpu::Queue,
    // rust: post: &mut PackPost,
    // rust: colour: &wgpu::TextureView,
    // rust: depth: &wgpu::TextureView,
    // rust: frame: &Frame,
    // rust: size: [u32; 2],
    // rust: window: [u32; 2],
    // rust: ) -> Vec<[u8; 4]> {
    // rust: let screen = texture(device, window, T::Rgba8Unorm);
    // rust: let stride = wgpu::COPY_BYTES_PER_ROW_ALIGNMENT;
    // rust: let read = device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: None,
    // rust: size: u64::from(stride * window[1]),
    // rust: usage: wgpu::BufferUsages::COPY_DST | wgpu::BufferUsages::MAP_READ,
    // rust: mapped_at_creation: false,
    // rust: });
    // rust: let mut encoder = device.create_command_encoder(&Default::default());
    // rust: post.run(
    // rust: device,
    // rust: queue,
    // rust: &mut encoder,
    // rust: colour,
    // rust: depth,
    // rust: &screen,
    // rust: frame,
    // rust: &Default::default(),
    // rust: size,
    // rust: window,
    // rust: &[],
    // rust: &mut |_, _, _, _| {},
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
    // rust: queue.submit([encoder.finish()]);
    // rust: read.slice(..).map_async(wgpu::MapMode::Read, |_| {});
    // rust: device.poll(wgpu::PollType::wait_indefinitely()).unwrap();
    // rust: read.slice(..)
    // rust: .get_mapped_range()
    // rust: .unwrap()
    // rust: .chunks_exact(stride as usize)
    // rust: .flat_map(|row| {
    // rust: row[..window[0] as usize * 4]
    // rust: .as_chunks::<4>()
    // rust: .0
    // rust: .iter()
    // rust: .copied()
    // rust: })
    // rust: .collect()
}

frame :: proc(hud: ^HudBatch) -> F {
    // Ported from Horizon
    return {}
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
    // rust: pitch: 10.0,
    // rust: fov_degrees: 85.0,
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
