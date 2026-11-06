//! Transpiled from Horizon Rust crate
package horizon_client_render_weather_depth_tests

import "core:fmt"
import "core:mem"
import "core:math"

// Original synthetic weather oracle: no pack assets or external shader algorithms.
// use super::*;
// use std::io::{Cursor, Write};
// use wgpu::util::DeviceExt;

rain_depth_controls_writes_for_rain_snow_and_fallbacks :: proc() {
}
    // rust: let instance = crate::gfx::test_gpu::instance();
    // rust: let adapter = pollster::block_on(instance.request_adapter(&Default::default())).unwrap();
    // rust: eprintln!("Weather depth GPU: {:?}", adapter.get_info());
    // rust: assert_ne!(adapter.get_info().device_type, wgpu::DeviceType::Cpu);
    // rust: let (device, queue) = pollster::block_on(adapter.request_device(&wgpu::DeviceDescriptor {
    // rust: required_limits: adapter.limits(),
    // rust: ..Default::default()
    // rust: }))
    // rust: .unwrap();
    // rust: let mut depth_failures = Vec::new();
    // rust: for program in ["gbuffers_weather", "gbuffers_textured_lit"] {
    // rust: for (property, writes) in [
    // rust: ("rain.depth=true", true),
    // rust: ("rain.depth=false", false),
            // An evidence-limited compatibility choice: preserve accepted main here.
            // The permitted packs do not establish the external omitted-value default.
    // rust: ("", true),
    // rust: ] {
    // rust: let mut post = pack(&device, &queue, &adapter, program, property);
            // Retain the pipelines for another frame, then resize their targets.
    // rust: for size in [[6, 1], [6, 1], [12, 2]] {
    // rust: post.resize(&device, size);
    // rust: let mut encoder = device.create_command_encoder(&Default::default());
    // rust: let targets = post.targets.as_ref().unwrap();
    // rust: let color = &targets.color[0].as_ref().unwrap()[0];
    // rust: encoder.begin_render_pass(&wgpu::RenderPassDescriptor {
    // rust: color_attachments: &[attach(
    // rust: color,
    // rust: wgpu::Operations {
    // rust: load: wgpu::LoadOp::Clear(wgpu::Color::BLUE),
    // rust: store: wgpu::StoreOp::Store,
    // rust: },
    // rust: )],
    // rust: depth_stencil_attachment: Some(wgpu::RenderPassDepthStencilAttachment {
    // rust: view: &targets.depth,
    // rust: depth_ops: Some(wgpu::Operations {
    // rust: load: wgpu::LoadOp::Clear(0.5),
    // rust: store: wgpu::StoreOp::Store,
    // rust: }),
    // rust: stencil_ops: None,
    // rust: }),
    // rust: ..Default::default()
    // rust: });
    // rust: post.set_weather(Some(geometry(&device)));
    // rust: post.draw_weather(&device, &queue, &mut encoder, size);
    // rust: assert!(post.weather_draw.is_none(), "draw consumes this frame only");
    // rust: assert!(post.has_weather(), "pipelines survive the draw");
                // A dry frame must neither redraw old quads nor discard the pipelines.
    // rust: post.set_weather(None);
    // rust: post.draw_weather(&device, &queue, &mut encoder, size);
    // rust: assert!(post.has_weather());
    // rust: let targets = post.targets.as_ref().unwrap();
    // rust: let color = targets.color[0].as_ref().unwrap()[0].texture();
    // rust: let colors = readback(&device, &mut encoder, color);
    // rust: let depths = readback(&device, &mut encoder, &targets.depth_texture);
    // rust: queue.submit([encoder.finish()]);
    // rust: for buffer in [&colors, &depths] {
    // rust: buffer.slice(..).map_async(wgpu::MapMode::Read, |_| {});
}
    // rust: device.poll(wgpu::PollType::wait_indefinitely()).unwrap();
    // rust: let colors = colors.slice(..).get_mapped_range().unwrap();
    // rust: let depths = depths.slice(..).get_mapped_range().unwrap();
    // rust: for y in 0..size[1] as usize {
    // rust: for x in 0..size[0] as usize {
    // rust: let quad = x / (size[0] as usize / 6);
    // rust: let visible = quad.is_multiple_of(3);
                        // First quad is in front; second is behind scene depth; third discards.
    // rust: let expected_color = if visible && quad < 3 {
    // rust: [128, 0, 127, 255]
    // rust: } else if visible {
    // rust: [0, 128, 127, 255]
    // rust: } else {
    // rust: [0, 0, 255, 255]
}
    // rust: let offset = y * 256 + x * 4;
    // rust: let actual_color = &colors[offset..offset + 4];
    // rust: for (actual, expected) in actual_color.iter().zip(expected_color) {
    // rust: assert!(
    // rust: i16::from(*actual).abs_diff(expected) <= 1,
    // rust: "{program} {property:?} size={size:?} ({x},{y}): color {actual_color:?}"
    // rust: );
}
    // rust: let depth =
    // rust: f32::from_le_bytes(depths[offset..offset + 4].try_into().unwrap());
    // rust: let expected_depth = if visible && writes { 0.25 } else { 0.5 };
    // rust: if depth != expected_depth {
    // rust: depth_failures.push(format!(
    // rust: "{program} {property:?} size={size:?} ({x},{y}): depth={depth}, expected={expected_depth}"
    // rust: ));
}
}
}
    // rust: eprintln!(
    // rust: "Weather oracle {program} {property:?} {size:?}: color, occlusion and discard pass; cumulative depth mismatches={}",
    // rust: depth_failures.len()
    // rust: );
}
}
}
    // rust: assert!(depth_failures.is_empty(), "{}", depth_failures.join("\n"));
}

    // rust: fn pack(
    // rust: device: &wgpu::Device,
    // rust: queue: &wgpu::Queue,
    // rust: adapter: &wgpu::Adapter,
    // rust: program: &str,
    // rust: property: &str,
    // rust: ) -> PackPost {
    // rust: let mut zip = zip::ZipWriter::new(Cursor::new(Vec::new()));
    // rust: for (extension, source) in [
    // rust: (
    // rust: "vsh",
    // rust: "#version 120\nvarying vec4 color; varying float marker; void main(){gl_Position=gl_Vertex;color=gl_Color;marker=gl_MultiTexCoord0.x;}",
    // rust: ),
    // rust: (
    // rust: "fsh",
    // rust: "#version 120\nvarying vec4 color; varying float marker; /* DRAWBUFFERS:0 */ void main(){if(marker>1.5) discard;gl_FragData[0]=color;}",
    // rust: ),
    // rust: ] {
    // rust: zip.start_file(
    // rust: format!("shaders/{program}.{extension}"),
    // rust: zip::write::SimpleFileOptions::default(),
    // rust: )
    // rust: .unwrap();
    // rust: zip.write_all(source.as_bytes()).unwrap();
}
    // rust: let pack = horizon_shaders::Pack::from_zip_bytes(
    // rust: "original-weather-depth",
    // rust: zip.finish().unwrap().into_inner(),
    // rust: )
    // rust: .unwrap();
    // rust: let macros = horizon_shaders::Macros::standard();
    // rust: let properties = horizon_shaders::Properties::parse(property, &macros);
    // rust: let post = horizon_shaders::load_post(
    // rust: &pack,
    // rust: "",
    // rust: &properties,
    // rust: &macros,
    // rust: &horizon_shaders::GameInputs {
    // rust: weather: Some(super::super::pack_weather::inputs()),
    // rust: ..Default::default()
    // rust: },
    // rust: );
    // rust: assert!(post.notes.is_empty(), "{:?}", post.notes);
    // rust: assert_eq!(post.weather.as_ref().unwrap().name, program);
    // rust: let lightmap = device
    // rust: .create_texture(&wgpu::TextureDescriptor {
    // rust: label: None,
    // rust: size: wgpu::Extent3d {
    // rust: width: 1,
    // rust: height: 1,
    // rust: depth_or_array_layers: 1,
    // rust: },
    // rust: mip_level_count: 1,
    // rust: sample_count: 1,
    // rust: dimension: wgpu::TextureDimension::D2,
    // rust: format: wgpu::TextureFormat::Rgba8Unorm,
    // rust: usage: wgpu::TextureUsages::TEXTURE_BINDING,
    // rust: view_formats: &[],
    // rust: })
    // rust: .create_view(&Default::default());
    // rust: let mut post = PackPost::new(
    // rust: device,
    // rust: queue,
    // rust: adapter,
    // rust: post,
    // rust: wgpu::TextureFormat::Rgba8Unorm,
    // rust: World {
    // rust: atlas: None,
    // rust: material_maps: None,
    // rust: lightmap,
    // rust: terrain: None,
    // rust: block_ids: &[],
    // rust: sprite_rects: &[],
    // rust: celestial: None,
    // rust: gui_size: [1, 1],
    // rust: clouds: None,
    // rust: weather: true,
    // rust: hand: false,
    // rust: },
    // rust: )
    // rust: .expect("weather pack runs");
    // rust: assert!(
    // rust: post.has_weather(),
    // rust: "production weather pipelines must compile: {:?}",
    // rust: post.notes
    // rust: );
    // rust: post.copied |= 1; // Keep colortex0 readable for the independent color oracle.
    // rust: post
}

geometry :: proc(device: ^wgpu::Device) -> W {
    // Ported from Horizon
    return {}
}
    // rust: let mut vertices = Vec::new();
    // rust: let mut indices = Vec::new();
    // rust: for quad in 0..6u32 {
    // rust: let left = quad as f32 / 3.0 - 1.0;
    // rust: let right = (quad + 1) as f32 / 3.0 - 1.0;
    // rust: let z = if quad % 3 == 1 { 0.5 } else { -0.5 };
    // rust: for pos in [
    // rust: [left, -1.0, z],
    // rust: [right, -1.0, z],
    // rust: [right, 1.0, z],
    // rust: [left, 1.0, z],
    // rust: ] {
    // rust: vertices.push(super::super::Vertex {
    // rust: pos,
    // rust: uv: [(quad % 3) as f32, 0.0],
    // rust: layer: 0,
    // rust: color: u32::from_le_bytes(if quad < 3 {
    // rust: [255, 0, 0, 128]
    // rust: } else {
    // rust: [0, 255, 0, 128]
    // rust: }),
    // rust: light: 0,
    // rust: normal: [0; 4],
    // rust: glint_uv: [0.0; 2],
    // rust: });
}
    // rust: indices.extend([0, 1, 2, 0, 2, 3].map(|i| quad * 4 + i));
}
    // rust: let buffer = |contents: &[u8], usage| {
    // rust: device.create_buffer_init(&wgpu::util::BufferInitDescriptor {
    // rust: label: None,
    // rust: contents,
    // rust: usage,
    // rust: })
}
    // rust: Weather {
    // rust: vertices: buffer(bytemuck::cast_slice(&vertices), wgpu::BufferUsages::VERTEX),
    // rust: indices: buffer(bytemuck::cast_slice(&indices), wgpu::BufferUsages::INDEX),
    // rust: quads: [0..3, 3..6],
    // rust: sprites: [None, None],
    // rust: generation: 1,
}
}

    // rust: fn readback(
    // rust: device: &wgpu::Device,
    // rust: encoder: &mut wgpu::CommandEncoder,
    // rust: texture: &wgpu::Texture,
    // rust: ) -> wgpu::Buffer {
    // rust: let buffer = device.create_buffer(&wgpu::BufferDescriptor {
    // rust: label: None,
    // rust: size: u64::from(256 * texture.height()),
    // rust: usage: wgpu::BufferUsages::COPY_DST | wgpu::BufferUsages::MAP_READ,
    // rust: mapped_at_creation: false,
    // rust: });
    // rust: encoder.copy_texture_to_buffer(
    // rust: wgpu::TexelCopyTextureInfo {
    // rust: aspect: if texture.format().is_depth_stencil_format() {
    // rust: wgpu::TextureAspect::DepthOnly
    // rust: } else {
    // rust: wgpu::TextureAspect::All
    // rust: },
    // rust: ..texture.as_image_copy()
    // rust: },
    // rust: wgpu::TexelCopyBufferInfo {
    // rust: buffer: &buffer,
    // rust: layout: wgpu::TexelCopyBufferLayout {
    // rust: offset: 0,
    // rust: bytes_per_row: Some(256),
    // rust: rows_per_image: None,
    // rust: },
    // rust: },
    // rust: texture.size(),
    // rust: );
    // rust: buffer
}
