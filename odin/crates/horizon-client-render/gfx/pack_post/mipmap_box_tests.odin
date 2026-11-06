//! Transpiled from Horizon Rust crate
package horizon_client_render_mipmap_box_tests

import "core:fmt"
import "core:mem"
import "core:math"

// A buffer's mip chain is a box filter of the level above, odd sides included, so a small
// bright spot keeps its share of every level down to the last, the buffer's mean: OpenGL 4.6
// (8.14.4) recommends a box filter for generated mipmaps, and Iris 1.11.7's colortex mipmaps
// kept a 26x22-pixel spot of a 1280x720 buffer in its last level (probe packs of ours).
// use super::destination_tests::Fixture;
// use super::*;
// use std::io::{Cursor, Write};

VERTEX :: "#version 120\nvarying vec2 uv;\nvoid main() { uv=gl_MultiTexCoord0.xy; gl_Position=ftransform(); }\n"

// composite writes 1.0 into one texel of colortex1, its top right corner, and 0 elsewhere;
// final shows level 2 (the 1x1 level of a 5x3 buffer) in red and texel (1, 0) of level 1 (2x1)
// in green, both scaled so that the box filter's values read 0.5.
pack :: proc() -> P {
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
    // rust: add("composite.vsh", VERTEX);
    // rust: add(
    // rust: "composite.fsh",
    // rust: "#version 330 compatibility\n/*\nconst int colortex1Format = RGBA16F;\n*/\n\
    // rust: /* RENDERTARGETS: 1 */\nlayout(location = 0) out vec4 o;\n\
    // rust: void main() {\n    ivec2 p = ivec2(gl_FragCoord.xy);\n\
    // rust: o = vec4(p == ivec2(4, 2) ? 1.0 : 0.0, 0.0, 0.0, 1.0);\n}\n",
    // rust: );
    // rust: add("final.vsh", VERTEX);
    // rust: add(
    // rust: "final.fsh",
    // rust: "#version 330 compatibility\n/*\nconst bool colortex1MipmapEnabled = true;\n*/\n\
    // rust: uniform sampler2D colortex1;\n\
    // rust: void main() {\n    float mean = textureLod(colortex1, vec2(0.5), 2.0).r;\n\
    // rust: float right = texelFetch(colortex1, ivec2(1, 0), 1).r;\n\
    // rust: gl_FragColor = vec4(mean * 7.5, right * 3.75, 0.0, 1.0);\n}\n",
    // rust: );
    // rust: let pack = horizon_shaders::Pack::from_zip_bytes(
    // rust: "original-mipmap-box",
    // rust: zip.finish().unwrap().into_inner(),
    // rust: )
    // rust: .unwrap();
    // rust: let mut macros = horizon_shaders::Macros::standard();
    // rust: let (properties, _) = horizon_shaders::read_properties(&pack, &mut macros);
    // rust: let post = horizon_shaders::load_post(&pack, "", &properties, &macros, &Default::default());
    // rust: assert_eq!(post.programs.len(), 2, "{:?}", post.notes);
    // rust: post
}

a_bright_texel_keeps_its_share_of_odd_sized_levels :: proc() {
}
    // rust: let Some(gpu) = Fixture::new() else { return };
    // rust: let mut post = gpu.build(pack());
    // rust: let pixels = gpu.render(&mut post, [5, 3]);
    // The 1x1 level is the mean of the 15 texels, 1/15; texel (1, 0) of the 2x1 level covers
    // columns 2, 3 and 4 (weights 1, 2, 2 of 5) of all three rows (1 of 3 each): 2/15.
    // rust: let [r, g, ..] = pixels[0];
    // rust: assert!(
    // rust: r.abs_diff(128) <= 2 && g.abs_diff(128) <= 2,
    // rust: "mean and level-1 texel scaled to 0.5: got red {r}, green {g}, expected 128 and 128"
    // rust: );
}
