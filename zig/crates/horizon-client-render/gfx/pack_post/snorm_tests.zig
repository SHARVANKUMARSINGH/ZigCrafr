//! Transpiled from Horizon Rust crate
//! Module: horizon-client-render_snorm_tests
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! SNORM colortex buffers clamp to [-1, 1] and quantise, as in Iris 1.11.7, where the adapter
//! renders to SNORM formats. Expected values are those probe pack p8106 read back in Iris (the
//! PR has them); the programs here are the probe's, cut down. Values that land halfway between
//! two steps (-0.5 × 127) are left out: GPUs may round them either way.
// use super::destination_tests::Fixture;
// use super::*;
// use std::io::{Cursor, Write};

pub const VERTEX: []const u8 = "#version 120\nvarying vec2 uv;\nvoid main() { uv=gl_MultiTexCoord0.xy; gl_Position=ftransform(); }\n";

pub fn pack() P {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut zip = zip::ZipWriter::new(Cursor::new(Vec::new()));
    // rust: let mut add = |name: &str, source: &str| {
    // rust: zip.start_file(
    // rust: format!("shaders/{name}"),
    // rust: zip::write::SimpleFileOptions::default(),
    // rust: )
    // rust: .unwrap();
    // rust: zip.write_all(source.as_bytes()).unwrap();
}
    // rust: add("composite.vsh", VERTEX);
    // rust: add(
    // rust: "composite.fsh",
    // rust: "#version 120\n/* RENDERTARGETS: 1,2,3 */\n\
    // rust: /*\nconst int colortex1Format = RGBA8_SNORM;\nconst int colortex2Format = RGBA16_SNORM;\n\
    // rust: const int colortex3Format = R16_SNORM;\nconst int colortex4Format = RGBA8_SNORM;\n*/\n\
    // rust: const vec4 colortex4ClearColor = vec4(-1.5, 0.1, 0.3337, 0.0);\n\
    // rust: void main() {\n    gl_FragData[0] = vec4(-1.5, 0.1, 0.3337, 1000.0);\n\
    // rust: gl_FragData[1] = vec4(-1.5, 0.1, 0.3337, 1000.0);\n    gl_FragData[2] = vec4(0.1);\n}\n",
    // rust: );
    // rust: add("final.vsh", VERTEX);
    // Pixel column x shows component x % 4 of buffer 1 + x / 4, as the bytes of its bits.
    // rust: add(
    // rust: "final.fsh",
    // rust: "#version 330 compatibility\nuniform sampler2D colortex1;\nuniform sampler2D colortex2;\n\
    // rust: uniform sampler2D colortex3;\nuniform sampler2D colortex4;\n\
    // rust: void main() {\n    ivec2 p = ivec2(gl_FragCoord.xy);\n    vec4 c = vec4(0.0);\n\
    // rust: switch (p.x / 4) {\n\
    // rust: case 0: c = texelFetch(colortex1, p, 0); break;\n\
    // rust: case 1: c = texelFetch(colortex2, p, 0); break;\n\
    // rust: case 2: c = texelFetch(colortex3, p, 0); break;\n\
    // rust: case 3: c = texelFetch(colortex4, p, 0); break;\n\
    // rust: }\n    uint u = floatBitsToUint(c[p.x % 4]);\n\
    // rust: gl_FragColor = vec4(uvec4(u >> 24u, u >> 16u, u >> 8u, u) & 255u) / 255.0;\n}\n",
    // rust: );
    // rust: let pack =
    // rust: horizon_shaders::Pack::from_zip_bytes("original-snorm", zip.finish().unwrap().into_inner())
    // rust: .unwrap();
    // rust: let mut macros = horizon_shaders::Macros::standard();
    // rust: let (properties, _) = horizon_shaders::read_properties(&pack, &mut macros);
    // rust: let post = horizon_shaders::load_post(&pack, "", &properties, &macros, &Default::default());
    // rust: assert_eq!(post.programs.len(), 2, "{:?}", post.notes);
    // rust: post
}

pub fn snorm_buffers_clamp_and_quantise() void {
}
    // rust: let Some(gpu) = Fixture::new() else { return };
    // The fixture's device asks for no features; SNORM targets need these.
    // rust: let wanted = wgpu::Features::TEXTURE_ADAPTER_SPECIFIC_FORMAT_FEATURES
    // rust: | wgpu::Features::TEXTURE_FORMAT_16BIT_NORM;
    // rust: let renders = [
    // rust: wgpu::TextureFormat::Rgba8Snorm,
    // rust: wgpu::TextureFormat::Rgba16Snorm,
    // rust: ]
    // rust: .iter()
    // rust: .all(|&f| {
    // rust: (gpu.adapter.get_texture_format_features(f).allowed_usages)
    // rust: .contains(wgpu::TextureUsages::RENDER_ATTACHMENT)
    // rust: });
    // rust: if !gpu.adapter.features().contains(wanted) || !renders {
    // rust: eprintln!("SNORM test skipped: this adapter doesn't render to SNORM formats");
    // rust: return;
}
    // rust: let (device, queue) = pollster::block_on(gpu.adapter.request_device(&wgpu::DeviceDescriptor {
    // rust: required_features: wanted,
    // rust: required_limits: gpu.adapter.limits(),
    // rust: ..Default::default()
    // rust: }))
    // rust: .expect("GPU device with SNORM formats");
    // rust: let gpu = Fixture {
    // rust: adapter: gpu.adapter,
    // rust: device,
    // rust: queue,
}
    // rust: let mut post = gpu.build(pack());
    // rust: let pixels = gpu.render(&mut post, [16, 1]);
    // rust: let read: Vec<f32> = pixels
    // rust: .iter()
    // rust: .map(|p| f32::from_bits(u32::from_be_bytes(*p)))
    // rust: .collect();
    // Iris 1.11.7: RGBA8_SNORM written (-1.5, 0.1, 0.3337, 1000); RGBA16_SNORM the same;
    // R16_SNORM written 0.1 (G and B read 0, alpha 1); RGBA8_SNORM cleared to
    // (-1.5, 0.1, 0.3337, 0).
    // rust: let expected = [
    // rust: -1.0,
    // rust: 0.102_362_2,
    // rust: 0.330_708_7,
    // rust: 1.0, //
    // rust: -1.0,
    // rust: 0.100_009_2,
    // rust: 0.333_689_4,
    // rust: 1.0, //
    // rust: 0.100_009_2,
    // rust: 0.0,
    // rust: 0.0,
    // rust: 1.0, //
    // rust: -1.0,
    // rust: 0.102_362_2,
    // rust: 0.330_708_7,
    // rust: 0.0,
    // rust: ];
    // rust: for (n, (got, want)) in read.iter().zip(expected).enumerate() {
    // rust: assert!(
    // rust: (got - want).abs() <= 1e-6,
    // rust: "buffer {} component {}: {got}, expected {want}; all {read:?}",
    // rust: 1 + n / 4,
    // rust: n % 4
    // rust: );
}
}
