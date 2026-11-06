//! Transpiled from Horizon Rust crate
//! Module: horizon-client-render_clear_false_tests
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! A buffer that isn't cleared, in passes that leave pixels alone or blend: what is under them.
//! The expected values are Iris 1.11.7's, measured with probe packs of our own (#9009).
// use super::*;

/// colortex6 is written three times a frame, the first write leaving the right half alone:
/// there it reads the previous frame's last write, 0.125 (Iris 1.11.7), not the 0.25 written into
/// that texture before. colortex8 is written twice a frame the same way: its right half was never
/// written and reads 0 (Iris 1.11.7). colortex10 is only blended onto (`ONE ONE`), 0.125 a frame:
/// it grows by 0.125 every frame (Iris 1.11.7 adds once per frame).
pub fn a_buffer_that_is_not_cleared_starts_the_frame_with_its_last_write() void {
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
    // rust: let fill = |v: f32| format!("vec4({v},{v},{v},1)");
    // rust: let programs = [
    // rust: (
    // rust: "composite",
    // rust: format!(
    // rust: "#version 120\nvarying vec2 uv;\n/* RENDERTARGETS:6 */\n\
    // rust: /*\nconst int colortex6Format=RGBA16F;\nconst int colortex7Format=RGBA16F;\n\
    // rust: const int colortex8Format=RGBA16F;\nconst int colortex9Format=RGBA16F;\n\
    // rust: const int colortex10Format=RGBA16F;\nconst bool colortex6Clear=false;\n\
    // rust: const bool colortex8Clear=false;\nconst bool colortex10Clear=false;\n*/\n\
    // rust: void main() {{ if(uv.x>0.5) discard; gl_FragData[0]={}; }}\n",
    // rust: fill(0.5)
    // rust: ),
    // rust: ),
    // rust: (
    // rust: "composite1",
    // rust: format!(
    // rust: "#version 120\nuniform sampler2D colortex6;\nvarying vec2 uv;\n/* RENDERTARGETS:7,6 */\n\
    // rust: void main() {{ gl_FragData[0]=texture2D(colortex6,uv); gl_FragData[1]={}; }}\n",
    // rust: fill(0.25)
    // rust: ),
    // rust: ),
    // rust: (
    // rust: "composite2",
    // rust: format!(
    // rust: "#version 120\n/* RENDERTARGETS:6 */\nvoid main() {{ gl_FragData[0]={}; }}\n",
    // rust: fill(0.125)
    // rust: ),
    // rust: ),
    // rust: (
    // rust: "composite3",
    // rust: format!(
    // rust: "#version 120\nvarying vec2 uv;\n/* RENDERTARGETS:8 */\n\
    // rust: void main() {{ if(uv.x>0.5) discard; gl_FragData[0]={}; }}\n",
    // rust: fill(0.5)
    // rust: ),
    // rust: ),
    // rust: (
    // rust: "composite4",
    // rust: format!(
    // rust: "#version 120\nuniform sampler2D colortex8;\nvarying vec2 uv;\n/* RENDERTARGETS:9,8 */\n\
    // rust: void main() {{ gl_FragData[0]=texture2D(colortex8,uv); gl_FragData[1]={}; }}\n",
    // rust: fill(0.125)
    // rust: ),
    // rust: ),
    // rust: (
    // rust: "composite5",
    // rust: "#version 120\n/* RENDERTARGETS:10 */\nvoid main() { gl_FragData[0]=vec4(0.125,0.125,0.125,0); }\n"
    // rust: .to_owned(),
    // rust: ),
    // rust: (
    // rust: "final",
    // rust: "#version 120\nuniform sampler2D colortex7;\nuniform sampler2D colortex9;\n\
    // rust: uniform sampler2D colortex10;\nvarying vec2 uv;\n\
    // rust: void main() { gl_FragColor=vec4(texture2D(colortex7,uv).r,texture2D(colortex9,uv).r,texture2D(colortex10,uv).r,1); }\n"
    // rust: .to_owned(),
    // rust: ),
    // rust: ];
    // rust: for (program, fragment) in &programs {
    // rust: add(&format!("{program}.vsh"), VERTEX);
    // rust: add(&format!("{program}.fsh"), fragment);
}
    // rust: add("shaders.properties", "blend.composite5=ONE ONE ONE ONE\n");
    // rust: let pack = horizon_shaders::Pack::from_zip_bytes(
    // rust: "clear-false-history",
    // rust: zip.finish().unwrap().into_inner(),
    // rust: )
    // rust: .unwrap();
    // rust: let mut macros = horizon_shaders::Macros::standard();
    // rust: let (properties, _) = horizon_shaders::read_properties(&pack, &mut macros);
    // rust: let post = horizon_shaders::load_post(&pack, "", &properties, &macros, &Default::default());
    // rust: let mut post = gpu.build(post);
    // rust: for frame in 0..4u8 {
    // rust: let actual = gpu.render(&mut post, [16, 16]);
    // rust: let sum = 32 * (frame + 1);
    // rust: let wrong: Vec<_> = (actual.iter().enumerate())
    // rust: .filter(|(n, p)| {
    // rust: let expected = match (n % 16 < 8, frame) {
    // rust: (true, _) => [128, 128, sum, 255],
    // rust: (false, 0) => [0, 0, sum, 255],
    // rust: (false, _) => [32, 0, sum, 255],
}
    // rust: p.iter().zip(expected).any(|(a, b)| a.abs_diff(b) > 1)
    // rust: })
    // rust: .map(|(n, p)| (n, *p))
    // rust: .take(4)
    // rust: .collect();
    // rust: assert!(wrong.is_empty(), "frame {frame}: {wrong:?}");
}
}
