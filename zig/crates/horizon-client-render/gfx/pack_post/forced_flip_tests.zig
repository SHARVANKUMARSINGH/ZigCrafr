//! Transpiled from Horizon Rust crate
//! Module: horizon-client-render_forced_flip_tests
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! `flip.<program>.<buffer> = true` on a buffer the program writes (#9010). The expected values
//! are Iris 1.11.7's, measured with probe packs of our own.
// use super::destination_tests::Fixture;
// use std::io::{Cursor, Write};

pub const VERTEX: []const u8 = "#version 120\nvarying vec2 uv;\nvoid main() { uv=gl_MultiTexCoord0.xy; gl_Position=ftransform(); }\n";

/// `composite` writes 0.25 to colortex2 and colortex4 and forces both to flip: the forced flip
/// cancels the write's own, so `composite1` samples colortex2's cleared side (Iris 1.11.7: 0),
/// and `composite2`, blended `ONE ONE`, adds 0.5 onto colortex4's 0.25 (Iris 1.11.7: 0.749).
pub fn a_forced_flip_of_a_written_buffer_leaves_it_unflipped() void {
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
    // rust: "#version 120\n/* RENDERTARGETS:2,4 */\n\
    // rust: void main() { gl_FragData[0]=vec4(0.25,0.25,0.25,1); gl_FragData[1]=vec4(0.25,0.25,0.25,1); }\n",
    // rust: ),
    // rust: (
    // rust: "composite1",
    // rust: "#version 120\nuniform sampler2D colortex2;\nvarying vec2 uv;\n/* RENDERTARGETS:3 */\n\
    // rust: void main() { gl_FragData[0]=texture2D(colortex2,uv); }\n",
    // rust: ),
    // rust: (
    // rust: "composite2",
    // rust: "#version 120\n/* RENDERTARGETS:4 */\nvoid main() { gl_FragData[0]=vec4(0.5,0.5,0.5,0); }\n",
    // rust: ),
    // rust: (
    // rust: "final",
    // rust: "#version 120\nuniform sampler2D colortex3;\nuniform sampler2D colortex4;\nvarying vec2 uv;\n\
    // rust: void main() { gl_FragColor=vec4(texture2D(colortex4,uv).r,texture2D(colortex3,uv).r,0,1); }\n",
    // rust: ),
    // rust: ] {
    // rust: add(&format!("{program}.vsh"), VERTEX);
    // rust: add(&format!("{program}.fsh"), fragment);
}
    // rust: add(
    // rust: "shaders.properties",
    // rust: "flip.composite.colortex2=true\nflip.composite.colortex4=true\nblend.composite2=ONE ONE ONE ONE\n",
    // rust: );
    // rust: let pack = horizon_shaders::Pack::from_zip_bytes(
    // rust: "forced-flip-of-a-written-buffer",
    // rust: zip.finish().unwrap().into_inner(),
    // rust: )
    // rust: .unwrap();
    // rust: let mut macros = horizon_shaders::Macros::standard();
    // rust: let (properties, _) = horizon_shaders::read_properties(&pack, &mut macros);
    // rust: let post = horizon_shaders::load_post(&pack, "", &properties, &macros, &Default::default());
    // rust: let mut post = gpu.build(post);
    // rust: for frame in 0..2 {
    // rust: let actual = gpu.render(&mut post, [16, 16]);
    // rust: let wrong: Vec<_> = (actual.iter().enumerate())
    // rust: .filter(|(_, p)| {
    // rust: p.iter()
    // rust: .zip([191, 0, 0, 255])
    // rust: .any(|(a, b)| a.abs_diff(b) > 1)
    // rust: })
    // rust: .map(|(n, p)| (n, *p))
    // rust: .take(4)
    // rust: .collect();
    // rust: assert!(wrong.is_empty(), "frame {frame}: {wrong:?}");
}
}
