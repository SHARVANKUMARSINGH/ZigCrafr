//! Transpiled from Horizon Rust crate
//! Module: horizon-client-render_atlas_mip_tests
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The block atlas is read with nearest texels, blended between the two nearest levels: our
//! probe packs (#9307) read `gtexture` in gbuffers_terrain, and the atlas as a custom texture in
//! composite, at levels 0.5 and 1.25 in Iris 1.11.7, and got the two nearest levels mixed.
// use super::destination_tests::Fixture;
// use super::*;
// use std::io::{Cursor, Write};

pub const VERTEX: []const u8 = "#version 120\nvarying vec2 uv;\nvoid main() { uv = gl_MultiTexCoord0.xy; gl_Position = ftransform(); }\n";

/// The atlas as composite's `noisetex`, read at levels 0.5 (red) and 0.25 (green).
pub fn pack() P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut zip = zip::ZipWriter::new(Cursor::new(Vec::new()));
    // rust: let mut add = |name: &str, source: &str| {
    // rust: zip.start_file(name, zip::write::SimpleFileOptions::default())
    // rust: .unwrap();
    // rust: zip.write_all(source.as_bytes()).unwrap();
}
    // rust: add(
    // rust: "shaders/shaders.properties",
    // rust: "texture.composite.noisetex=minecraft:textures/atlas/blocks.png\n",
    // rust: );
    // rust: add("shaders/composite.vsh", VERTEX);
    // rust: add(
    // rust: "shaders/composite.fsh",
    // rust: "#version 130\nuniform sampler2D noisetex;\nvoid main() {\n/* DRAWBUFFERS:0 */\n\
    // rust: \x20   gl_FragData[0] = vec4(textureLod(noisetex, vec2(0.5), 0.5).r, textureLod(noisetex, vec2(0.5), 0.25).r, 0.0, 1.0);\n}\n",
    // rust: );
    // rust: let pack = horizon_shaders::Pack::from_zip_bytes(
    // rust: "original-atlas-levels",
    // rust: zip.finish().unwrap().into_inner(),
    // rust: )
    // rust: .unwrap();
    // rust: let mut macros = horizon_shaders::Macros::standard();
    // rust: let (properties, _) = horizon_shaders::read_properties(&pack, &mut macros);
    // rust: horizon_shaders::load_post(&pack, "", &properties, &macros, &Default::default())
}

/// A 4x4 atlas whose first level is black and second white.
pub fn atlas(gpu: *Fixture) w {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let texture = gpu.device.create_texture(&wgpu::TextureDescriptor {
    // rust: label: Some("Original two-level atlas"),
    // rust: size: wgpu::Extent3d {
    // rust: width: 4,
    // rust: height: 4,
    // rust: depth_or_array_layers: 1,
    // rust: },
    // rust: mip_level_count: 2,
    // rust: sample_count: 1,
    // rust: dimension: wgpu::TextureDimension::D2,
    // rust: format: wgpu::TextureFormat::Rgba8Unorm,
    // rust: usage: wgpu::TextureUsages::TEXTURE_BINDING | wgpu::TextureUsages::COPY_DST,
    // rust: view_formats: &[],
    // rust: });
    // rust: for (level, side, value) in [(0u32, 4u32, 0u8), (1, 2, 255)] {
    // rust: gpu.queue.write_texture(
    // rust: wgpu::TexelCopyTextureInfo {
    // rust: texture: &texture,
    // rust: mip_level: level,
    // rust: origin: wgpu::Origin3d::ZERO,
    // rust: aspect: wgpu::TextureAspect::All,
    // rust: },
    // rust: &[value, value, value, 255].repeat((side * side) as usize),
    // rust: wgpu::TexelCopyBufferLayout {
    // rust: offset: 0,
    // rust: bytes_per_row: Some(side * 4),
    // rust: rows_per_image: None,
    // rust: },
    // rust: wgpu::Extent3d {
    // rust: width: side,
    // rust: height: side,
    // rust: depth_or_array_layers: 1,
    // rust: },
    // rust: );
}
    // rust: texture.create_view(&Default::default())
}

pub fn the_atlas_blends_its_two_nearest_levels() void {
}
    // rust: let Some(gpu) = Fixture::new() else { return };
    // The pack reads no lightmap: any texture serves.
    // rust: let lightmap = atlas(&gpu);
    // rust: let mut post = PackPost::new(
    // rust: &gpu.device,
    // rust: &gpu.queue,
    // rust: &gpu.adapter,
    // rust: pack(),
    // rust: wgpu::TextureFormat::Rgba8Unorm,
    // rust: World {
    // rust: atlas: Some((atlas(&gpu), [4, 4])),
    // rust: material_maps: None,
    // rust: lightmap,
    // rust: terrain: None,
    // rust: block_ids: &[],
    // rust: sprite_rects: &[],
    // rust: celestial: None,
    // rust: gui_size: [16, 16],
    // rust: clouds: None,
    // rust: weather: false,
    // rust: hand: false,
    // rust: },
    // rust: )
    // rust: .expect("the pack runs");
    // rust: for p in gpu.render(&mut post, [4, 4]) {
        // Half of white, and a quarter (within the blend's 8-bit weight).
    // rust: assert!(p[0].abs_diff(128) <= 2 && p[1].abs_diff(64) <= 2, "{p:?}");
}
}
