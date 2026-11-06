//! Transpiled from Horizon Rust crate
package horizon_client_render_wrong_type_uniform_tests

import "core:fmt"
import "core:mem"
import "core:math"

// A built-in uniform declared with another GLSL type than the one Iris 1.11.7 gives is disabled
// there ("Wrong uniform type ... Disabling that uniform") and reads 0; our probe packs (#9307)
// read 0 for each such declaration. Declared with its own type, it keeps its value.
// use super::destination_tests::Fixture;
// use super::*;
// use std::io::{Cursor, Write};

VERTEX :: "#version 120\nvarying vec2 uv;\nvoid main() { uv = gl_MultiTexCoord0.xy; gl_Position = ftransform(); }\n"

// composite declares two floats as `int` and `vec2` and an int as `float`, and writes what it
// reads into colortex1; final declares the same names with their own types and adds them.
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
    // rust: add("final.vsh", VERTEX);
    // rust: add(
    // rust: "composite.fsh",
    // rust: "#version 130\nuniform int viewWidth;\nuniform vec2 viewHeight;\nuniform float fogShape;\n\
    // rust: void main() {\n/* DRAWBUFFERS:1 */\n\
    // rust: \x20   gl_FragData[0] = vec4(float(viewWidth), viewHeight.x, fogShape + 1.0, 255.0) / 255.0;\n}\n",
    // rust: );
    // rust: add(
    // rust: "final.fsh",
    // rust: "#version 130\nuniform sampler2D colortex1;\nuniform float viewWidth;\nuniform int fogShape;\n\
    // rust: varying vec2 uv;\nvoid main() {\n\
    // rust: \x20   vec4 c = texture(colortex1, uv);\n\
    // rust: \x20   gl_FragColor = vec4(c.r, c.g + viewWidth * 4.0 / 255.0, c.b + float(fogShape + 2) * 10.0 / 255.0, 1.0);\n}\n",
    // rust: );
    // rust: let pack = horizon_shaders::Pack::from_zip_bytes(
    // rust: "original-wrong-uniform-types",
    // rust: zip.finish().unwrap().into_inner(),
    // rust: )
    // rust: .unwrap();
    // rust: let mut macros = horizon_shaders::Macros::standard();
    // rust: let (properties, _) = horizon_shaders::read_properties(&pack, &mut macros);
    // rust: horizon_shaders::load_post(&pack, "", &properties, &macros, &Default::default())
}

built_ins_declared_with_another_type_read_zero :: proc() {
}
    // rust: let Some(gpu) = Fixture::new() else { return };
    // rust: let mut post = gpu.build(pack());
    // 8 pixels wide; post programs read `fogShape` -1. composite reads 0, 0 and 0 (+1 = 1);
    // final reads 8 (green 32) and -1 (+2 = 1, blue 10).
    // rust: for p in gpu.render(&mut post, [8, 8]) {
    // rust: assert_eq!(p, [0, 32, 11, 255]);
}
}
