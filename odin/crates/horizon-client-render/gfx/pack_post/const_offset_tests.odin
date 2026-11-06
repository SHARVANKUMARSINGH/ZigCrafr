//! Transpiled from Horizon Rust crate
package horizon_client_render_const_offset_tests

import "core:fmt"
import "core:mem"
import "core:math"

// A texel offset given by a `const` local reads the texel that far away, as a literal offset
// does (GLSL 4.60, 4.3.3 and 8.9.2, as #8462 quotes them). #8462's probe.
// use super::destination_tests::Fixture;
// use super::*;
// use std::io::{Cursor, Write};

VERTEX :: "#version 120\nvarying vec2 uv;\nvoid main() { uv=gl_MultiTexCoord0.xy; gl_Position=ftransform(); }\n"

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
    // Each texel of colortex1 holds its own column and row, in eighths.
    // rust: add(
    // rust: "composite.fsh",
    // rust: "#version 120\n/* RENDERTARGETS: 1 */\n\
    // rust: void main() { gl_FragData[0] = vec4(floor(gl_FragCoord.xy) / 8.0, 0.0, 1.0); }\n",
    // rust: );
    // rust: add("final.vsh", VERTEX);
    // Red and green: what the texel two columns right and one row down holds; blue: this row.
    // rust: add(
    // rust: "final.fsh",
    // rust: "#version 330 compatibility\nuniform sampler2D colortex1;\nin vec2 uv;\n\
    // rust: vec4 f(vec2 p) { const ivec2 offset = ivec2(2, -1); return textureLodOffset(colortex1, p, 0.0, offset); }\n\
    // rust: void main() { gl_FragColor = vec4(f(uv).rg, floor(gl_FragCoord.y) / 8.0, 1.0); }\n",
    // rust: );
    // rust: let pack = horizon_shaders::Pack::from_zip_bytes(
    // rust: "original-const-offset",
    // rust: zip.finish().unwrap().into_inner(),
    // rust: )
    // rust: .unwrap();
    // rust: let mut macros = horizon_shaders::Macros::standard();
    // rust: let (properties, _) = horizon_shaders::read_properties(&pack, &mut macros);
    // rust: let post = horizon_shaders::load_post(&pack, "", &properties, &macros, &Default::default());
    // rust: assert_eq!(post.programs.len(), 2, "{:?}", post.notes);
    // rust: post
}

a_const_local_offset_reads_the_offset_texel :: proc() {
}
    // rust: let Some(gpu) = Fixture::new() else { return };
    // rust: let mut post = gpu.build(pack());
    // rust: let pixels = gpu.render(&mut post, [8, 8]);
    // rust: let eighth = |n: u8| (f32::from(n) * 255.0 / 8.0).round() as u8;
    // rust: let mut checked = 0;
    // rust: for (n, p) in pixels.iter().enumerate() {
    // rust: let x = (n % 8) as u8;
        // The bottom row (GL's row 0) and the two right columns read past the edge.
    // rust: if x >= 6 || p[2] == 0 {
    // rust: continue;
}
    // rust: let row = (0..8)
    // rust: .find(|&r| eighth(r).abs_diff(p[2]) <= 1)
    // rust: .expect("row in blue");
    // rust: let want = [eighth(x + 2), eighth(row - 1)];
    // rust: assert!(
    // rust: p[0].abs_diff(want[0]) <= 1 && p[1].abs_diff(want[1]) <= 1,
    // rust: "pixel {n} (column {x}, GL row {row}): {p:?}, expected red and green {want:?}"
    // rust: );
    // rust: checked += 1;
}
    // rust: assert_eq!(checked, 6 * 7);
}
