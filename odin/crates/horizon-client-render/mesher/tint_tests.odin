//! Transpiled from Horizon Rust crate
package horizon_client_render_tint_tests

import "core:fmt"
import "core:mem"
import "core:math"

// The one-biome shortcut of `Tints::get` against the full blend. Needs the
// prepared biome data, like the other mesher tests that load resources.
// use super::*;

biomes :: proc() -> B {
    // Ported from Horizon
    return {}
}
    // rust: let root = std::env::var_os("HORIZON_MESH_TEST_RESOURCES")
    // rust: .map(std::path::PathBuf::from)
    // rust: .unwrap_or_else(|| {
    // rust: std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client/26.3")
    // rust: });
    // rust: Biomes::load(&root).unwrap()
}

// A chunk whose every quart cell holds `biome`.
filled :: proc(cx: i32, cz: i32, biome: u16) -> C {
    // Ported from Horizon
    return {}
}
    // rust: let mut chunk = Chunk::empty(cx, cz);
    // rust: for qy in 0..(384 / 4) {
    // rust: for qz in 0..4 {
    // rust: for qx in 0..4 {
    // rust: chunk.set_biome_cell(qx, qy, qz, biome);
}
}
}
    // rust: chunk
}

one_biome_shortcut_blends_like_the_full_square :: proc() {
}
    // rust: let biomes = biomes();
    // rust: let desert = biomes.id("minecraft:desert");
    // rust: let (cx, cz) = (3, -2);
    // Grass without and with the dark forest modifier, swamp noise, and
    // biomes whose foliage, dry foliage and water differ from the defaults.
    // rust: for name in [
    // rust: "minecraft:plains",
    // rust: "minecraft:dark_forest",
    // rust: "minecraft:swamp",
    // rust: "minecraft:mangrove_swamp",
    // rust: "minecraft:cherry_grove",
    // rust: "minecraft:warm_ocean",
    // rust: "minecraft:badlands",
    // rust: ] {
    // rust: let biome = biomes.id(name);
    // rust: let chunks: Vec<Vec<Chunk>> = (0..3)
    // rust: .map(|rz| {
    // rust: (0..3)
    // rust: .map(|rx| filled(cx + rx - 1, cz + rz - 1, biome))
    // rust: .collect()
    // rust: })
    // rust: .collect();
        // One desert column in the east neighbour, next to the section's edge,
        // where every blend radius reaches it.
    // rust: let mut east = filled(cx + 1, cz, biome);
    // rust: for qy in 0..(384 / 4) {
    // rust: east.set_biome_cell(0, qy, 2, desert);
}
    // rust: let all = |rz: usize, rx: usize| Some(&chunks[rz][rx]);
    // rust: let uniform: [[Option<&Chunk>; 3]; 3] =
    // rust: std::array::from_fn(|rz| std::array::from_fn(|rx| all(rz, rx)));
    // rust: let mut mixed = uniform;
    // rust: mixed[1][2] = Some(&east);
        // A missing neighbour reads as plains.
    // rust: let mut missing = uniform;
    // rust: missing[0][0] = None;
    // rust: for (region, one_biome) in [
    // rust: (&uniform, true),
    // rust: (&mixed, false),
    // rust: (&missing, name == "minecraft:plains"),
    // rust: ] {
    // rust: for base_y in [MIN_Y, 0, 304] {
    // rust: for (radius, seed) in [(0, 0), (1, 42), (2, -7), (5, 1234), (7, i64::MAX)] {
    // rust: let new = || {
    // rust: Tints::new(
    // rust: region,
    // rust: &biomes,
    // rust: BiomeZoom::new(seed),
    // rust: radius,
    // rust: [cx, cz, base_y],
    // rust: )
}
    // rust: let mut fast = new();
    // rust: let mut full = new();
    // rust: full.uniform = Some(None);
    // rust: assert_eq!(
    // rust: fast.uniform_biome().is_some(),
    // rust: one_biome,
    // rust: "{name} r{radius} y{base_y}"
    // rust: );
    // rust: for resolver in [
    // rust: Resolver::Grass,
    // rust: Resolver::Foliage,
    // rust: Resolver::Dry,
    // rust: Resolver::Water,
    // rust: ] {
    // rust: for y in 0..16 {
    // rust: for z in 0..16 {
    // rust: for x in 0..16 {
    // rust: assert_eq!(
    // rust: fast.get(resolver, x, y, z),
    // rust: full.get(resolver, x, y, z),
    // rust: "{name} resolver {} r{radius} at {x} {y} {z} of y{base_y}",
    // rust: resolver as usize
    // rust: );
}
}
}
}
}
}
}
}
}
