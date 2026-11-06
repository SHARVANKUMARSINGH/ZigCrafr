//! Transpiled from Horizon Rust crate
package horizon_client_render_packed_tests

import "core:fmt"
import "core:mem"
import "core:math"

// `RGB5_A1`, `RGB565` and `R3_G3_B2` buffers read back as in Iris 1.11.7. Expected values are
// those probe packs p8106c (written values) and p8106d (clear colours) read back in Iris (the PR
// has them); the programs here are the probes', cut down. Written values are ones whose byte
// (× 255) is not near a half: GPUs may round those either way.
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
    // rust: add(
    // rust: "composite.fsh",
    // rust: "#version 120\n/* RENDERTARGETS: 1,2,3 */\n\
    // rust: /*\nconst int colortex1Format = RGB5_A1;\nconst int colortex2Format = RGB565;\n\
    // rust: const int colortex3Format = R3_G3_B2;\nconst int colortex4Format = RGB5_A1;\n\
    // rust: const int colortex5Format = RGB565;\n*/\n\
    // rust: const vec4 colortex4ClearColor = vec4(0.3337, 0.1, 0.6, 0.3);\n\
    // rust: const vec4 colortex5ClearColor = vec4(0.3337, 0.1, 0.6, 0.3);\n\
    // rust: void main() {\n\
    // rust: gl_FragData[0] = vec4(175.0, 176.0, 766.5, 256.0) / 511.0;\n\
    // rust: gl_FragData[1] = vec4(400.0, 175.0, 44.0, 0.0) / 511.0;\n\
    // rust: gl_FragData[2] = vec4(-255.5, 176.0, 300.0, 0.0) / 511.0;\n}\n",
    // rust: );
    // rust: add("final.vsh", VERTEX);
    // Pixel column x shows component x % 4 of buffer 1 + x / 4, as the bytes of its bits.
    // rust: add(
    // rust: "final.fsh",
    // rust: "#version 330 compatibility\nuniform sampler2D colortex1;\nuniform sampler2D colortex2;\n\
    // rust: uniform sampler2D colortex3;\nuniform sampler2D colortex4;\nuniform sampler2D colortex5;\n\
    // rust: void main() {\n    ivec2 p = ivec2(gl_FragCoord.xy);\n    vec4 c = vec4(0.0);\n\
    // rust: switch (p.x / 4) {\n\
    // rust: case 0: c = texelFetch(colortex1, p, 0); break;\n\
    // rust: case 1: c = texelFetch(colortex2, p, 0); break;\n\
    // rust: case 2: c = texelFetch(colortex3, p, 0); break;\n\
    // rust: case 3: c = texelFetch(colortex4, p, 0); break;\n\
    // rust: case 4: c = texelFetch(colortex5, p, 0); break;\n\
    // rust: }\n    uint u = floatBitsToUint(c[p.x % 4]);\n\
    // rust: gl_FragColor = vec4(uvec4(u >> 24u, u >> 16u, u >> 8u, u) & 255u) / 255.0;\n}\n",
    // rust: );
    // rust: let pack = horizon_shaders::Pack::from_zip_bytes(
    // rust: "original-packed",
    // rust: zip.finish().unwrap().into_inner(),
    // rust: )
    // rust: .unwrap();
    // rust: let mut macros = horizon_shaders::Macros::standard();
    // rust: let (properties, _) = horizon_shaders::read_properties(&pack, &mut macros);
    // rust: let post = horizon_shaders::load_post(&pack, "", &properties, &macros, &Default::default());
    // rust: assert_eq!(post.programs.len(), 2, "{:?}", post.notes);
    // rust: post
}

small_packed_buffers_keep_their_bits :: proc() {
}
    // rust: let Some(gpu) = Fixture::new() else { return };
    // rust: let mut post = gpu.build(pack());
    // Twice: the second frame writes the buffers' other sides.
    // rust: for frame in 0..2 {
    // rust: let pixels = gpu.render(&mut post, [20, 1]);
    // rust: let read: Vec<f32> = pixels
    // rust: .iter()
    // rust: .map(|p| f32::from_bits(u32::from_be_bytes(*p)))
    // rust: .collect();
        // Iris 1.11.7, in 255ths: RGB5_A1 written (175, 176, 766.5, 256) / 511; RGB565 written
        // (400, 175, 44, 0) / 511; R3_G3_B2 written (-255.5, 176, 300, 0) / 511; RGB5_A1 and
        // RGB565 cleared to (0.3337, 0.1, 0.6, 0.3). Three-channel formats read alpha 1.
    // rust: let expected: [f32; 20] = [
    // rust: 82.0, 90.0, 255.0, 255.0, //
    // rust: 206.0, 85.0, 16.0, 255.0, //
    // rust: 0.0, 89.0, 148.0, 255.0, //
    // rust: 82.0, 24.0, 156.0, 0.0, //
    // rust: 82.0, 24.0, 156.0, 255.0,
    // rust: ];
    // rust: for (n, (got, want)) in read.iter().zip(expected).enumerate() {
    // rust: assert!(
    // rust: (got - want / 255.0).abs() <= 1e-6,
    // rust: "frame {frame}, buffer {} component {}: {}/255, expected {want}/255; all {:?}",
    // rust: 1 + n / 4,
    // rust: n % 4,
    // rust: got * 255.0,
    // rust: read.iter().map(|v| v * 255.0).collect::<Vec<_>>()
    // rust: );
}
}
}
