//! Transpiled from Horizon Rust crate
//! Module: horizon-client-render_custom_type_tests
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! A custom uniform of `shaders.properties` that the GLSL declares with another type: an original
//! probe (#9307). In Iris 1.11.7 our probe packs read 0 for a float custom uniform declared `int`,
//! an int declared `float`, a vec3 declared `vec2` and a vec2 declared `vec3`, and the uniform's
//! own value where the types agree. A float of 2.5 declared `bool` read true (Iris logged it as
//! disabled, but it read true in both games).
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
    // rust: add(
    // rust: "shaders.properties",
    // rust: "uniform.float.floatAsInt = 7.0\n\
    // rust: uniform.int.intAsFloat = 7\n\
    // rust: uniform.vec3.vec3AsVec2 = vec3(1.0, 2.0, 3.0)\n\
    // rust: uniform.vec2.vec2AsVec3 = vec2(4.0, 5.0)\n\
    // rust: uniform.float.floatAsFloat = 0.5\n\
    // rust: uniform.int.intAsInt = 3\n\
    // rust: uniform.float.floatAsBool = 2.5\n",
    // rust: );
    // rust: add("final.vsh", VERTEX);
    // Pixel column x shows case x % 7 in red.
    // rust: add(
    // rust: "final.fsh",
    // rust: "#version 330 compatibility\n\
    // rust: uniform int floatAsInt;\nuniform float intAsFloat;\nuniform vec2 vec3AsVec2;\n\
    // rust: uniform vec3 vec2AsVec3;\nuniform float floatAsFloat;\nuniform int intAsInt;\n\
    // rust: uniform bool floatAsBool;\n\
    // rust: void main() {\n    int x = int(gl_FragCoord.x) % 7;\n    float o = 0.0;\n\
    // rust: if (x == 0) o = float(floatAsInt) / 10.0;\n\
    // rust: else if (x == 1) o = intAsFloat / 10.0;\n\
    // rust: else if (x == 2) o = (vec3AsVec2.x + vec3AsVec2.y) / 10.0;\n\
    // rust: else if (x == 3) o = (vec2AsVec3.x + vec2AsVec3.y) / 10.0;\n\
    // rust: else if (x == 4) o = floatAsFloat;\n\
    // rust: else if (x == 5) o = float(intAsInt) / 10.0;\n\
    // rust: else o = floatAsBool ? 1.0 : 0.0;\n\
    // rust: gl_FragColor = vec4(o, 0.0, 0.0, 1.0);\n}\n",
    // rust: );
    // rust: let pack = horizon_shaders::Pack::from_zip_bytes(
    // rust: "original-custom-types",
    // rust: zip.finish().unwrap().into_inner(),
    // rust: )
    // rust: .unwrap();
    // rust: let mut macros = horizon_shaders::Macros::standard();
    // rust: let (properties, _) = horizon_shaders::read_properties(&pack, &mut macros);
    // rust: let post = horizon_shaders::load_post(&pack, "", &properties, &macros, &Default::default());
    // rust: assert_eq!(post.programs.len(), 1, "{:?}", post.notes);
    // rust: post
}

pub fn a_custom_uniform_declared_with_another_type_reads_zero() void {
}
    // rust: let Some(gpu) = Fixture::new() else { return };
    // rust: let Ok(mut post) = gpu.try_build(pack()) else {
    // rust: panic!("the pack runs")
}
    // rust: let pixels = gpu.render(&mut post, [7, 1]);
    // rust: let red: Vec<u8> = pixels[..7].iter().map(|p| p[0]).collect();
    // 0 for the four mismatches, 0.5 and 0.3 where the types agree, then true.
    // rust: let want = [0.0, 0.0, 0.0, 0.0, 0.5, 0.3, 1.0].map(|v: f32| (v * 255.0).round() as u8);
    // rust: assert!(
    // rust: red.iter().zip(want).all(|(g, w)| g.abs_diff(w) <= 1),
    // rust: "{red:?}, expected {want:?}"
    // rust: );
}
