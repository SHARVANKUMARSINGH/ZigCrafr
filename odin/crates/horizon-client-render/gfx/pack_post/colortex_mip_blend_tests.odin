//! Transpiled from Horizon Rust crate
package horizon_client_render_colortex_mip_blend_tests

import "core:fmt"
import "core:mem"
import "core:math"

// A buffer's mipmaps are read blended between the two nearest levels: our probe packs (#9307)
// read every colortex at levels 2.5 and 1.25 in composite and final, in Iris 1.11.7, and got the
// two nearest levels mixed.
// use super::destination_tests::Fixture;
// use super::*;
// use std::io::{Cursor, Write};

VERTEX :: "#version 120\nvarying vec2 uv;\nvoid main() { uv=gl_MultiTexCoord0.xy; gl_Position=ftransform(); }\n"

// composite writes 1.0 into the left half of a 4x4 colortex1 and 0 into the right half, so at
// (0.25, 0.5) level 1 reads 1.0 and level 2 (1x1) the mean, 0.5. final shows the read at
// level 1.5 in red and at level 1.25 in green.
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
    // rust: void main() {\n    o = vec4(gl_FragCoord.x < 2.0 ? 1.0 : 0.0, 0.0, 0.0, 1.0);\n}\n",
    // rust: );
    // rust: add("final.vsh", VERTEX);
    // rust: add(
    // rust: "final.fsh",
    // rust: "#version 330 compatibility\n/*\nconst bool colortex1MipmapEnabled = true;\n*/\n\
    // rust: uniform sampler2D colortex1;\n\
    // rust: void main() {\n    vec2 at = vec2(0.25, 0.5);\n\
    // rust: gl_FragColor = vec4(textureLod(colortex1, at, 1.5).r, textureLod(colortex1, at, 1.25).r, 0.0, 1.0);\n}\n",
    // rust: );
    // rust: let pack = horizon_shaders::Pack::from_zip_bytes(
    // rust: "original-colortex-mip-blend",
    // rust: zip.finish().unwrap().into_inner(),
    // rust: )
    // rust: .unwrap();
    // rust: let mut macros = horizon_shaders::Macros::standard();
    // rust: let (properties, _) = horizon_shaders::read_properties(&pack, &mut macros);
    // rust: let post = horizon_shaders::load_post(&pack, "", &properties, &macros, &Default::default());
    // rust: assert_eq!(post.programs.len(), 2, "{:?}", post.notes);
    // rust: post
}

a_buffer_blends_its_two_nearest_levels :: proc() {
}
    // rust: let Some(gpu) = Fixture::new() else { return };
    // rust: let mut post = gpu.build(pack());
    // rust: let pixels = gpu.render(&mut post, [4, 4]);
    // Level 1.5: 1.0 and 0.5 mixed 1:1, 0.75; level 1.25: mixed 3:1, 0.875.
    // rust: let [r, g, ..] = pixels[0];
    // rust: assert!(
    // rust: r.abs_diff(191) <= 2 && g.abs_diff(223) <= 2,
    // rust: "levels 1.5 and 1.25: got red {r}, green {g}, expected 191 and 223"
    // rust: );
}
