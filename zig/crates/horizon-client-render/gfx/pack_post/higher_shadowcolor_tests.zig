//! Transpiled from Horizon Rust crate
//! Module: horizon-client-render_higher_shadowcolor_tests
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! `HIGHER_SHADOWCOLOR`: shadowcolor2 to 7 are written by shadow programs' directives, read by
//! them and by the other programs, and cleared to their own colours, as in Iris 1.11.7 (probe
//! packs p7951a to c; the PR has the readings). The programs here are original and cut down.
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
    // rust: add("shadowcomp.vsh", VERTEX);
    // rust: add(
    // rust: "shadowcomp.fsh",
    // rust: "#version 120\n/* RENDERTARGETS: 2,7 */\n\
    // rust: void main() { gl_FragData[0]=vec4(0.25,0,0,1); gl_FragData[1]=vec4(0,0.5,0,1); }\n",
    // rust: );
    // A shadow program reads a higher buffer it didn't write.
    // rust: add("shadowcomp1.vsh", VERTEX);
    // rust: add(
    // rust: "shadowcomp1.fsh",
    // rust: "#version 120\n/* RENDERTARGETS: 3 */\nuniform sampler2D shadowcolor7;\nvarying vec2 uv;\n\
    // rust: void main() { gl_FragData[0]=texture2D(shadowcolor7,uv); }\n",
    // rust: );
    // rust: add("final.vsh", VERTEX);
    // Pixel column x shows shadowcolor 2, 3, 5 and 6 in turn.
    // rust: add(
    // rust: "final.fsh",
    // rust: "#version 330 compatibility\nconst int shadowMapResolution=16;\n\
    // rust: const vec4 shadowcolor5ClearColor=vec4(0,0,0.75,1);\n\
    // rust: uniform sampler2D shadowcolor2;\nuniform sampler2D shadowcolor3;\n\
    // rust: uniform sampler2D shadowcolor5;\nuniform sampler2D shadowcolor6;\nin vec2 uv;\n\
    // rust: void main() {\n    vec4 c[4] = vec4[4](texture(shadowcolor2,uv), texture(shadowcolor3,uv),\n\
    // rust: texture(shadowcolor5,uv), texture(shadowcolor6,uv));\n\
    // rust: gl_FragColor = c[int(gl_FragCoord.x) % 4];\n}\n",
    // rust: );
    // rust: add(
    // rust: "shaders.properties",
    // rust: "shadow.enabled=true\niris.features.required = HIGHER_SHADOWCOLOR\n",
    // rust: );
    // rust: let pack = horizon_shaders::Pack::from_zip_bytes(
    // rust: "original-higher-shadowcolor",
    // rust: zip.finish().unwrap().into_inner(),
    // rust: )
    // rust: .unwrap();
    // rust: let mut macros = horizon_shaders::Macros::standard();
    // rust: let (properties, _) = horizon_shaders::read_properties(&pack, &mut macros);
    // rust: horizon_shaders::load_post(&pack, "", &properties, &macros, &Default::default())
}

pub fn higher_shadowcolor_buffers_are_written_read_and_cleared() void {
}
    // rust: let Some(gpu) = Fixture::new() else { return };
    // rust: let mut post = gpu.build(pack());
    // Two frames: the second starts from the first one's buffers.
    // rust: for frame in 0..2 {
    // rust: let pixels = gpu.render(&mut post, [8, 8]);
        // shadowcolor2 written red, 3 a copy of 7 (green), 5 its clear colour, 6 white.
    // rust: let expected = [
    // rust: [64, 0, 0, 255],
    // rust: [0, 128, 0, 255],
    // rust: [0, 0, 191, 255],
    // rust: [255; 4],
    // rust: ];
    // rust: for (x, want) in expected.iter().enumerate() {
    // rust: let got = pixels[x];
    // rust: assert!(
    // rust: got.iter().zip(want).all(|(g, w)| g.abs_diff(*w) <= 1),
    // rust: "frame {frame}, column {x}: {got:?}, expected {want:?}; row {:?}",
    // rust: &pixels[..4]
    // rust: );
}
}
}
