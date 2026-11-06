//! Transpiled from Horizon Rust crate
//! Module: horizon-client-render_rgb_alpha_tests
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Three-channel buffers read alpha 1, as in Iris 1.11.7: written with alpha 0, cleared with
//! alpha 0, or never written. The values come from probe pack p8106 run in Iris (the PR has
//! them); the programs here are the probe's, cut down.
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
    // rust: "#version 120\n/* RENDERTARGETS: 1,5,7 */\n\
    // rust: /*\nconst int colortex0Format = RGB16F;\nconst int colortex1Format = RGB16F;\n\
    // rust: const int colortex2Format = RGB8;\nconst int colortex3Format = RGB32F;\n\
    // rust: const int colortex4Format = RGB32UI;\nconst int colortex5Format = RGBA16F;\n\
    // rust: const int colortex7Format = RGB16;\n*/\n\
    // rust: const vec4 colortex2ClearColor = vec4(0.25, 0.5, 0.75, 0.0);\n\
    // rust: const bool colortex3Clear = false;\n\
    // rust: void main() {\n    gl_FragData[0] = vec4(0.25, 0.5, 0.75, 0.0);\n\
    // rust: gl_FragData[1] = vec4(0.25, 0.5, 0.75, 0.0);\n    gl_FragData[2] = vec4(0.25, 0.5, 0.75, 0.0);\n}\n",
    // rust: );
    // rust: add("composite1.vsh", VERTEX);
    // rust: add(
    // rust: "composite1.fsh",
    // rust: "#version 330 compatibility\n/* RENDERTARGETS: 4 */\nlayout(location = 0) out uvec4 o;\n\
    // rust: void main() { o = uvec4(5u, 6u, 7u, 0u); }\n",
    // rust: );
    // rust: add("final.vsh", VERTEX);
    // Pixel column x shows buffer x % 8: its alpha in red, its green in green.
    // rust: add(
    // rust: "final.fsh",
    // rust: "#version 330 compatibility\nuniform sampler2D colortex0;\nuniform sampler2D colortex1;\n\
    // rust: uniform sampler2D colortex2;\nuniform sampler2D colortex3;\nuniform usampler2D colortex4;\n\
    // rust: uniform sampler2D colortex5;\nuniform sampler2D colortex7;\n\
    // rust: void main() {\n    ivec2 p = ivec2(gl_FragCoord.xy);\n    vec4 c = vec4(0.0);\n\
    // rust: switch (p.x % 8) {\n\
    // rust: case 0: c = texelFetch(colortex0, p, 0); break;\n\
    // rust: case 1: c = texelFetch(colortex1, p, 0); break;\n\
    // rust: case 2: c = texelFetch(colortex2, p, 0); break;\n\
    // rust: case 3: c = texelFetch(colortex3, p, 0); break;\n\
    // rust: case 4: c = vec4(texelFetch(colortex4, p, 0)) / 12.0; c.a *= 12.0; break;\n\
    // rust: case 5: c = texelFetch(colortex5, p, 0); break;\n\
    // rust: case 7: c = texelFetch(colortex7, p, 0); break;\n\
    // rust: }\n    gl_FragColor = vec4(c.a, c.g, 0.0, 1.0);\n}\n",
    // rust: );
    // rust: let pack = horizon_shaders::Pack::from_zip_bytes(
    // rust: "original-rgb-alpha",
    // rust: zip.finish().unwrap().into_inner(),
    // rust: )
    // rust: .unwrap();
    // rust: let mut macros = horizon_shaders::Macros::standard();
    // rust: let (properties, _) = horizon_shaders::read_properties(&pack, &mut macros);
    // rust: let post = horizon_shaders::load_post(&pack, "", &properties, &macros, &Default::default());
    // rust: assert_eq!(post.programs.len(), 3, "{:?}", post.notes);
    // rust: post
}

pub fn three_channel_buffers_read_alpha_1() void {
}
    // rust: let Some(gpu) = Fixture::new() else { return };
    // rust: let mut post = gpu.build(pack());
    // Twice: the second frame reads buffers that a first frame already used.
    // rust: for frame in 0..2 {
    // rust: let pixels = gpu.render(&mut post, [8, 8]);
        // (alpha, green) per buffer: 0 is the world (black) through the blit; 1, 5 and 7 are
        // written with alpha 0, 2 is cleared with alpha 0, 3 is never cleared nor written, 4 is
        // RGB32UI written (5, 6, 7, 0). Only 5 (RGBA16F) keeps the alpha 0 it was given.
    // rust: let expected = [
    // rust: [255, 0],
    // rust: [255, 128],
    // rust: [255, 128],
    // rust: [255, 0],
    // rust: [255, 128],
    // rust: [0, 128],
    // rust: [0, 0],
    // rust: [255, 128],
    // rust: ];
    // rust: let row: Vec<[u8; 2]> = pixels[..8].iter().map(|p| [p[0], p[1]]).collect();
    // rust: for (b, (got, want)) in row.iter().zip(expected).enumerate() {
    // rust: if b == 6 {
    // rust: continue;
}
    // rust: assert!(
    // rust: got.iter().zip(want).all(|(g, w)| g.abs_diff(w) <= 1),
    // rust: "frame {frame}, colortex{b}: (alpha, green) {got:?}, expected {want:?}; row {row:?}"
    // rust: );
}
}
}
