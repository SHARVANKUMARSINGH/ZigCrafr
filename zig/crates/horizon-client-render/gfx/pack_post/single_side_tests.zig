//! Transpiled from Horizon Rust crate
//! Module: horizon-client-render_single_side_tests
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! A buffer gets its B texture only when a composite-style program draws into it or flips it:
//! the others' B is a second view of A, and they read the same as before. The programs here
//! are original and cut down.
// use super::destination_tests::Fixture;
// use super::*;
// use std::io::{Cursor, Write};

pub const VERTEX: []const u8 = "#version 120\nvarying vec2 uv;\nvoid main() { uv=gl_MultiTexCoord0.xy; gl_Position=ftransform(); }\n";

/// `composite` writes colortex1 from colortex2, which no program writes; colortex4 is only
/// flipped by a directive. `shadowcomp` writes shadowcolor1; shadowcolor0 is only read.
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
    // rust: "#version 120\n/* RENDERTARGETS: 1 */\nvoid main() { gl_FragData[0]=vec4(0,0.5,0,1); }\n",
    // rust: );
    // rust: add("composite.vsh", VERTEX);
    // rust: add(
    // rust: "composite.fsh",
    // rust: "#version 120\nuniform sampler2D colortex2;\nvarying vec2 uv;\n/* RENDERTARGETS: 1 */\n\
    // rust: void main() { gl_FragData[0]=vec4(texture2D(colortex2,uv).rgb*0.5,1); }\n",
    // rust: );
    // rust: add("final.vsh", VERTEX);
    // Pixel column x shows colortex1, colortex4, shadowcolor0 and shadowcolor1 in turn.
    // rust: add(
    // rust: "final.fsh",
    // rust: "#version 330 compatibility\nconst int shadowMapResolution=16;\n\
    // rust: const vec4 colortex2ClearColor=vec4(1,1,1,1);\n\
    // rust: const vec4 colortex4ClearColor=vec4(0,0,0.75,1);\n\
    // rust: const vec4 shadowcolor0ClearColor=vec4(0.25,0,0,1);\n\
    // rust: uniform sampler2D colortex1;\nuniform sampler2D colortex4;\n\
    // rust: uniform sampler2D shadowcolor0;\nuniform sampler2D shadowcolor1;\nin vec2 uv;\n\
    // rust: void main() {\n    vec4 c[4] = vec4[4](texture(colortex1,uv), texture(colortex4,uv),\n\
    // rust: texture(shadowcolor0,uv), texture(shadowcolor1,uv));\n\
    // rust: gl_FragColor = c[int(gl_FragCoord.x) % 4];\n}\n",
    // rust: );
    // rust: add(
    // rust: "shaders.properties",
    // rust: "shadow.enabled=true\nflip.composite.colortex4=true\n",
    // rust: );
    // rust: let pack = horizon_shaders::Pack::from_zip_bytes(
    // rust: "original-single-side",
    // rust: zip.finish().unwrap().into_inner(),
    // rust: )
    // rust: .unwrap();
    // rust: let mut macros = horizon_shaders::Macros::standard();
    // rust: let (properties, _) = horizon_shaders::read_properties(&pack, &mut macros);
    // rust: horizon_shaders::load_post(&pack, "", &properties, &macros, &Default::default())
}

pub fn only_buffers_drawn_into_or_flipped_get_a_second_texture() void {
}
    // rust: let Some(gpu) = Fixture::new() else { return };
    // rust: let mut post = gpu.build(pack());
    // Two frames: the second starts from the first one's buffers.
    // rust: for frame in 0..2 {
    // rust: let pixels = gpu.render(&mut post, [8, 8]);
    // rust: let expected = [
    // rust: [128, 128, 128, 255],
    // rust: [0, 0, 191, 255],
    // rust: [64, 0, 0, 255],
    // rust: [0, 128, 0, 255],
    // rust: ];
    // rust: for (x, want) in expected.iter().enumerate() {
    // rust: let got = pixels[x];
    // rust: assert!(
    // rust: got.iter().zip(want).all(|(g, w)| g.abs_diff(*w) <= 1),
    // rust: "frame {frame}, column {x}: {got:?}, expected {want:?}"
    // rust: );
}
}
    // rust: let shared = |sides: &[wgpu::TextureView; 2]| sides[0].texture() == sides[1].texture();
    // rust: let targets = post.targets.as_ref().expect("rendered");
    // rust: for (b, single) in [(1, false), (2, true), (4, false)] {
    // rust: let sides = targets.color[b].as_ref().expect("used buffer");
    // rust: assert_eq!(shared(sides), single, "colortex{b}");
}
    // rust: let shadow = post.shadow_targets.as_ref().expect("shadow pass");
    // rust: for (n, single) in [(0, true), (1, false)] {
    // rust: let sides = shadow.color[n].as_ref().expect("used buffer");
    // rust: assert_eq!(shared(sides), single, "shadowcolor{n}");
}
}
