//! Transpiled from Horizon Rust crate
package horizon_client_render_clear_budget_tests

import "core:fmt"
import "core:mem"
import "core:math"

// Original regression guard: each HDR post draw fits, so its frame clears must also fit.
// use super::*;

hdr_pack :: proc(sized: bool, format: string) -> P {
    // Ported from Horizon
    return {}
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
    // rust: let mut properties = String::new();
    // rust: for buffer in 2..7 {
    // rust: let program = if buffer == 2 {
    // rust: "composite".to_owned()
    // rust: } else {
    // rust: format!("composite{}", buffer - 2)
}
    // rust: add(&format!("{program}.vsh"), VERTEX);
    // rust: add(
    // rust: &format!("{program}.fsh"),
    // rust: &format!(
    // rust: "#version 120\n/* RENDERTARGETS:{buffer} */\n/*\nconst int colortex{buffer}Format={format};\n*/\nvoid main() {{ gl_FragData[0]=vec4(0,0.5,0,1); }}\n"
    // rust: ),
    // rust: );
    // rust: if sized {
    // rust: properties.push_str(&format!("size.buffer.colortex{buffer}=0.5 0.5\n"));
}
}
    // rust: add("final.vsh", VERTEX);
    // rust: add(
    // rust: "final.fsh",
    // rust: "#version 120\nuniform sampler2D colortex2;\nvarying vec2 uv;\nvoid main() { gl_FragColor=texture2D(colortex2,uv); }\n",
    // rust: );
    // rust: add("shaders.properties", &properties);
    // rust: let pack = horizon_shaders::Pack::from_zip_bytes(
    // rust: "original-hdr-clear-budget",
    // rust: zip.finish().unwrap().into_inner(),
    // rust: )
    // rust: .unwrap();
    // rust: let mut macros = horizon_shaders::Macros::standard();
    // rust: let (properties, _) = horizon_shaders::read_properties(&pack, &mut macros);
    // rust: let post = horizon_shaders::load_post(&pack, "", &properties, &macros, &Default::default());
    // rust: assert_eq!(post.programs.len(), 6, "{:?}", post.notes);
    // rust: let expected = horizon_shaders::Format {
    // rust: channels: 4,
    // rust: bits: if format == "RGBA16F" { 16 } else { 8 },
    // rust: kind: if format == "RGBA16F" {
    // rust: horizon_shaders::Kind::Float
    // rust: } else {
    // rust: horizon_shaders::Kind::Unorm
    // rust: },
}
    // rust: for buffer in 2..7 {
    // rust: assert_eq!(
    // rust: post.config.buffers[buffer].format, expected,
    // rust: "fixture buffer {buffer} must have {format}"
    // rust: );
}
    // rust: post
}

// Check the fixture contract even when the render tests cannot find an adapter.
clear_fixture_loads_the_requested_formats_without_a_gpu :: proc() {
}
    // rust: for sized in [false, true] {
    // rust: for format in ["RGBA16F", "RGBA8"] {
    // rust: hdr_pack(sized, format);
}
}
}

hdr_clear_case :: proc(sized: bool, attachment_limit: u32, byte_budget: u32, format: string) {
}
    // rust: let instance = crate::gfx::test_gpu::instance();
    // rust: let Ok(adapter) = pollster::block_on(instance.request_adapter(&Default::default())) else {
    // rust: eprintln!("HDR clear-budget test skipped: no GPU adapter");
    // rust: return;
}
    // rust: let mut limits = adapter.limits();
    // rust: limits.max_color_attachment_bytes_per_sample = limits
    // rust: .max_color_attachment_bytes_per_sample
    // rust: .min(byte_budget);
    // rust: limits.max_color_attachments = limits.max_color_attachments.min(attachment_limit);
    // rust: let (device, queue) = pollster::block_on(adapter.request_device(&wgpu::DeviceDescriptor {
    // rust: required_limits: limits,
    // rust: ..Default::default()
    // rust: }))
    // rust: .expect("GPU device for HDR clear-budget contract");
    // rust: eprintln!(
    // rust: "HDR clear-budget adapter {:?}, requested attachments {} / bytes {}",
    // rust: adapter.get_info(),
    // rust: device.limits().max_color_attachments,
    // rust: device.limits().max_color_attachment_bytes_per_sample
    // rust: );
    // rust: let gpu = Fixture {
    // rust: adapter,
    // rust: device,
    // rust: queue,
}
    // Five sequential single-output programs are legal. An implementation may group
    // their clears, but it cannot turn those legal draws into an over-budget MRT.
    // rust: let mut post = gpu.build(hdr_pack(sized, format));
    // rust: let actual = gpu.render(&mut post, [16, 16]);
    // rust: assert!(
    // rust: actual.iter().all(|p| p
    // rust: .iter()
    // rust: .zip([0, 128, 0, 255])
    // rust: .all(|(a, b)| a.abs_diff(b) <= 1)),
    // rust: "sized={sized}: {:?}",
    // rust: &actual[..16]
    // rust: );
}

fullsize_hdr_clear_respects_byte_budget :: proc() {
}
    // rust: hdr_clear_case(false, 8, 32, "RGBA16F");
}
sized_hdr_clear_respects_byte_budget :: proc() {
}
    // rust: hdr_clear_case(true, 8, 32, "RGBA16F");
}
fullsize_hdr_clear_respects_attachment_count :: proc() {
}
    // rust: hdr_clear_case(false, 2, 64, "RGBA16F");
}
sized_hdr_clear_respects_attachment_count :: proc() {
}
    // rust: hdr_clear_case(true, 2, 64, "RGBA16F");
}

fullsize_unorm_clear_respects_byte_budget :: proc() {
}
    // rust: hdr_clear_case(false, 8, 32, "RGBA8");
}
sized_unorm_clear_respects_byte_budget :: proc() {
}
    // rust: hdr_clear_case(true, 8, 32, "RGBA8");
}
