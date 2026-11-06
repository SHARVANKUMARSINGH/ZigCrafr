//! Transpiled from Horizon Rust crate
package horizon_client_render_integer_colortex0_tests

import "core:fmt"
import "core:mem"
import "core:math"

// A pack may give colortex0 an integer format (OptiFine's `shaders.txt`, "Texture Formats",
// lists `RGBA32UI`, as #8459 quotes it): the pack still loads, and reads back what it wrote
// there. #8459's probe; #8459 reports Iris 1.11.7 drawing (0, 200, 0) at every point
// sampled from it. Without a `final` that draws it, the pack is refused (#9165).
// use super::destination_tests::Fixture;
// use super::*;
// use std::io::{Cursor, Write};

VERTEX :: "#version 120\nvarying vec2 uv;\nvoid main() { uv=gl_MultiTexCoord0.xy; gl_Position=ftransform(); }\n"

// A `final` that shows the integer colortex0.
FINAL :: "#version 330 compatibility\nuniform usampler2D colortex0
    // rust: void main() { gl_FragColor = vec4(texelFetch(colortex0, ivec2(gl_FragCoord.xy), 0)) / 255.0; }\n";

// A `final` that doesn't compile (it calls a function nobody declares), so it is skipped.
    // rust: const BROKEN_FINAL: &str =
    // rust: "#version 330 compatibility\nvoid main() { gl_FragColor = undeclared_function(); }\n";

// `depth`: the composite reads depthtex0, so the blit copies the world's depth; `last`: the
// pack's `final`, if it has one.
pack :: proc(depth: bool, last: Maybe(string)) -> P {
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
    // With depthtex0: green where it holds the empty world's far plane (1), red elsewhere.
    // rust: let value = if depth {
    // rust: "texelFetch(depthtex0, ivec2(gl_FragCoord.xy), 0).r == 1.0 ? uvec4(0u, 200u, 0u, 255u) : uvec4(200u, 0u, 0u, 255u)"
    // rust: } else {
    // rust: "uvec4(0u, 200u, 0u, 255u)"
}
    // rust: add(
    // rust: "composite.fsh",
    // rust: &format!(
    // rust: "#version 330 compatibility\n/* RENDERTARGETS: 0 */\n/*\nconst int colortex0Format = RGBA32UI;\n*/\n\
    // rust: uniform sampler2D depthtex0;\nlayout(location = 0) out uvec4 o;\nvoid main() {{ o = {value}; }}\n"
    // rust: ),
    // rust: );
    // rust: if let Some(source) = last {
    // rust: add("final.vsh", VERTEX);
    // rust: add("final.fsh", source);
}
    // rust: let pack = horizon_shaders::Pack::from_zip_bytes(
    // rust: "original-integer-colortex0",
    // rust: zip.finish().unwrap().into_inner(),
    // rust: )
    // rust: .unwrap();
    // rust: let mut macros = horizon_shaders::Macros::standard();
    // rust: let (properties, _) = horizon_shaders::read_properties(&pack, &mut macros);
    // rust: horizon_shaders::load_post(&pack, "", &properties, &macros, &Default::default())
}

an_integer_colortex0_keeps_what_the_pack_wrote :: proc() {
}
    // rust: let Some(gpu) = Fixture::new() else { return };
    // rust: for depth in [false, true] {
    // rust: let mut post = gpu.build(pack(depth, Some(FINAL)));
        // Twice: the second frame's world blit runs over a colortex0 the first frame wrote.
    // rust: for frame in 0..2 {
    // rust: let pixels = gpu.render(&mut post, [8, 8]);
    // rust: let wrong: Vec<_> = pixels.iter().filter(|p| **p != [0, 200, 0, 255]).collect();
    // rust: assert!(wrong.is_empty(), "depth {depth}, frame {frame}: {wrong:?}");
}
}
}

// Without a `final` left to draw it (none, or one that is skipped), an integer colortex0 has
// no colours the screen can show: the pack is refused, so the game turns it off and draws
// without it instead of a black screen (#9165). The refusal keeps why `final` was skipped.
an_integer_colortex0_without_a_working_final_is_refused :: proc() {
}
    // rust: let Some(gpu) = Fixture::new() else { return };
    // rust: for last in [None, Some(BROKEN_FINAL)] {
    // rust: let Err(refused) = gpu.try_build(pack(false, last)) else {
    // rust: panic!("{last:?}: a pack that can't show colortex0 runs");
}
    // rust: assert_eq!(
    // rust: refused.notes.iter().any(|n| n.starts_with("final")),
    // rust: last.is_some(),
    // rust: "{refused:?}"
    // rust: );
}
}
