//! Transpiled from Horizon Rust crate
package horizon_client_render_leaf_culling_tests

import "core:fmt"
import "core:mem"
import "core:math"

// Leaf culling through the real mesher: face counts, the opaque layer and the
// conservative cases (cavities, partial neighbours, missing chunks, column
// ends). Needs prepared resources, like the other mesher geometry tests.
// use super::*;
// use crate::{
    // rust: assets::{Assets, RenderAssets},
    // rust: biome::Biomes,
    // rust: blocks::BlockFacts,
    // rust: chunk::{Chunk, ColumnLayout},
    // rust: graphics::LeafCullingMode,
    // rust: models,
}

Fixture :: struct {
    assets: Assets,
    biomes: Biomes,
    render: RenderAssets,
    visibility: horizon_world::block_render::FaceVisibility,
    tables: MeshTables,
}

fixture :: proc() -> F {
    // Ported from Horizon
    return {}
}
    // rust: let root = std::env::var_os("HORIZON_MESH_TEST_RESOURCES")
    // rust: .map(std::path::PathBuf::from)
    // rust: .unwrap_or_else(|| {
    // rust: std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
    // rust: .join("../../.local/horizon-client/26.3")
    // rust: });
    // rust: let assets = Assets::load(&root).unwrap();
    // rust: let facts = BlockFacts::load(&root, assets.registry).unwrap();
    // rust: let biomes = Biomes::load(&root).unwrap();
    // rust: let render = assets.reload(&root).unwrap();
    // rust: let visibility = models::load_visibility(&root, assets.registry).unwrap();
    // rust: let tables = MeshTables::new(&assets, &render, &facts, visibility.clone()).unwrap();
    // rust: Fixture {
    // rust: assets,
    // rust: biomes,
    // rust: render,
    // rust: visibility,
    // rust: tables,
}
}

state :: proc(f: ^Fixture, name: string) -> u {
    // Ported from Horizon
    return {}
}
    // rust: f.assets.registry.default_state(name).unwrap().0
}

leaves_cube :: proc(chunk: ^Chunk, min: i32, max: i32, y: i32, state: u32) {
}
    // rust: for z in min..=max {
    // rust: for x in min..=max {
    // rust: chunk.set(x, y, z, state);
}
}
}

leaf_cube :: proc(f: ^Fixture, min: i32, max: i32, base: i32, name: string) -> C {
    // Ported from Horizon
    return {}
}
    // rust: let mut chunk = Chunk::empty(0, 0);
    // rust: let state = state(f, name);
    // rust: for y in base..base + (max - min + 1) {
    // rust: leaves_cube(&mut chunk, min, max, y, state);
}
    // rust: chunk
}

    // rust: fn mesh(
    // rust: f: &Fixture,
    // rust: _chunk: &Chunk,
    // rust: region: [[Option<&Chunk>; 3]; 3],
    // rust: sy: i32,
    // rust: mode: LeafCullingMode,
    // rust: ) -> SectionMesh {
    // rust: let mut mesher = Mesher {
    // rust: nether_shading: false,
    // rust: shader_pack_lighting: false,
    // rust: separate_ao: false,
    // rust: shader_pack: false,
    // rust: assets: &f.assets,
    // rust: render: &f.render,
    // rust: tables: &f.tables,
    // rust: biomes: &f.biomes,
    // rust: visibility: f.visibility.clone(),
    // rust: zoom: BiomeZoom::new(0),
    // rust: blend_radius: 0,
    // rust: smooth_lighting: false,
    // rust: cutout_leaves: true,
    // rust: translucent_layers: &[],
    // rust: leaf_culling: mode,
}
    // rust: mesher.mesh(&region, sy)
}

around :: proc(chunk: ^Chunk) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: [[Some(chunk); 3]; 3]
}

// (opaque, cutout) leaf quads, rejecting a quad whose four vertices disagree.
quads :: proc(mesh: ^SectionMesh) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let mut opaque = 0;
    // rust: let mut cutout = 0;
    // rust: for quad in mesh.solid.as_chunks::<4>().0 {
    // rust: let flags = quad
    // rust: .iter()
    // rust: .map(|v| v.layer & OPAQUE_LAYER != 0)
    // rust: .collect::<Vec<_>>();
    // rust: assert!(
    // rust: flags.iter().all(|flag| *flag == flags[0]),
    // rust: "a quad mixed opaque and cutout vertices: {flags:?}"
    // rust: );
    // rust: if flags[0] {
    // rust: opaque += 1;
    // rust: } else {
    // rust: cutout += 1;
}
}
    // rust: assert_eq!(mesh.solid.len() % 4, 0);
    // rust: (opaque, cutout)
}

BASE :: MIN_Y + 4

off_draws_every_fancy_leaf_face :: proc() {
}
    // rust: let f = fixture();
    // rust: let chunk = leaf_cube(&f, 6, 8, BASE, "minecraft:oak_leaves");
    // rust: let mesh = mesh(&f, &chunk, around(&chunk), 0, LeafCullingMode::Off);
    // 27 blocks, six quads each: vanilla's fancy leaves keep the inside.
    // rust: assert_eq!(quads(&mesh), (0, 162));
    // rust: assert_eq!(mesh.translucent.len(), 0);
}

solid_draws_the_fully_enclosed_leaf_opaque :: proc() {
}
    // rust: let f = fixture();
    // rust: let chunk = leaf_cube(&f, 6, 8, BASE, "minecraft:oak_leaves");
    // rust: let solid = mesh(&f, &chunk, around(&chunk), 0, LeafCullingMode::Solid);
    // Only the centre has all six sides covered: its six quads go opaque.
    // rust: assert_eq!(quads(&solid), (6, 156));

    // rust: let aggressive = mesh(
    // rust: &f,
    // rust: &chunk,
    // rust: around(&chunk),
    // rust: 0,
    // rust: LeafCullingMode::SolidAggressive,
    // rust: );
    // Aggressive also takes the six face-centre leaves: seven blocks opaque.
    // rust: assert_eq!(quads(&aggressive), (42, 120));
}

aggressive_solidifies_the_next_shell_layer_of_a_five_cube :: proc() {
}
    // rust: let f = fixture();
    // rust: let chunk = leaf_cube(&f, 5, 9, BASE, "minecraft:oak_leaves");
    // rust: let solid = mesh(&f, &chunk, around(&chunk), 0, LeafCullingMode::Solid);
    // The 3x3x3 inside the surface: 27 blocks, six quads each.
    // rust: assert_eq!(quads(&solid), (162, 588));
    // rust: let aggressive = mesh(
    // rust: &f,
    // rust: &chunk,
    // rust: around(&chunk),
    // rust: 0,
    // rust: LeafCullingMode::SolidAggressive,
    // rust: );
    // The 3x3x3 inside plus the 3x3 face centre of each of the six sides.
    // rust: assert_eq!(quads(&aggressive), (486, 264));
}

hollow_drops_only_the_faces_two_leaves_share :: proc() {
}
    // rust: let f = fixture();
    // rust: let chunk = leaf_cube(&f, 6, 8, BASE, "minecraft:oak_leaves");
    // rust: let hollow = mesh(&f, &chunk, around(&chunk), 0, LeafCullingMode::Hollow);
    // 162 quads minus the 54 shared pairs' 108 faces: the 3x3x3 shell.
    // rust: assert_eq!(quads(&hollow), (0, 54));
}

mixed_species_count_as_one_leaf_volume :: proc() {
}
    // rust: let f = fixture();
    // rust: let oak = state(&f, "minecraft:oak_leaves");
    // rust: let birch = state(&f, "minecraft:birch_leaves");
    // rust: let mut chunk = Chunk::empty(0, 0);
    // rust: for y in BASE..BASE + 3 {
    // rust: for z in 6..=8 {
    // rust: for x in 6..=8 {
    // rust: chunk.set(x, y, z, if (x + y + z) % 2 == 0 { oak } else { birch });
}
}
}
    // rust: let solid = mesh(&f, &chunk, around(&chunk), 0, LeafCullingMode::Solid);
    // rust: assert_eq!(quads(&solid), (6, 156));
    // rust: let hollow = mesh(&f, &chunk, around(&chunk), 0, LeafCullingMode::Hollow);
    // rust: assert_eq!(quads(&hollow), (0, 54));
}

a_cavity_keeps_its_six_faces_and_its_rim_stays_cutout :: proc() {
}
    // rust: let f = fixture();
    // rust: let mut chunk = leaf_cube(&f, 5, 9, BASE, "minecraft:oak_leaves");
    // rust: chunk.set(7, BASE + 2, 7, 0);
    // rust: let hollow = mesh(&f, &chunk, around(&chunk), 0, LeafCullingMode::Hollow);
    // Five-cube shell (150) plus the six faces around the one-block cavity.
    // rust: assert_eq!(quads(&hollow), (0, 156));
    // rust: let solid = mesh(&f, &chunk, around(&chunk), 0, LeafCullingMode::Solid);
    // The six leaves around the cavity are exposed, so they stay cutout; the
    // other 20 inner leaves draw solid. The cavity block itself has no quads.
    // rust: assert_eq!(quads(&solid), (120, 624));
}

section_boundary_faces_stay_with_a_loaded_neighbour :: proc() {
}
    // rust: let f = fixture();
    // rust: let leaf = state(&f, "minecraft:oak_leaves");
    // rust: let chunk = leaf_cube(&f, 12, 15, BASE, "minecraft:oak_leaves");
    // A loaded east chunk whose x=0 column continues the canopy.
    // rust: let mut east = Chunk::empty(1, 0);
    // rust: for y in BASE..BASE + 4 {
    // rust: for z in 12..=15 {
    // rust: east.set(0, y, z, leaf);
}
}
    // rust: let mut region = around(&chunk);
    // rust: region[1][2] = Some(&east);
    // rust: let joined = mesh(&f, &chunk, region, 0, LeafCullingMode::Hollow);
    // rust: let mut region = around(&chunk);
    // rust: region[1][2] = None;
    // rust: let missing = mesh(&f, &chunk, region, 0, LeafCullingMode::Hollow);
    // The east faces of the x=15 leaves are on the section boundary: a loaded
    // neighbour does not let Hollow drop them, and a missing one does not
    // change the mesh either.
    // rust: assert_eq!(joined.solid.len(), missing.solid.len());
    // rust: let off = mesh(&f, &chunk, around(&chunk), 0, LeafCullingMode::Off);
    // rust: assert!(joined.solid.len() < off.solid.len());
}

the_top_of_a_one_section_column_stays_visible :: proc() {
}
    // rust: let f = fixture();
    // rust: let leaf = state(&f, "minecraft:oak_leaves");
    // rust: let layout = ColumnLayout::new(0, 16).unwrap();
    // rust: let mut chunk = Chunk::with_layout(0, 0, layout);
    // rust: for y in 13..16 {
    // rust: leaves_cube(&mut chunk, 5, 7, y, leaf);
}
    // rust: let hollow = mesh(&f, &chunk, around(&chunk), 0, LeafCullingMode::Hollow);
    // rust: let solid = mesh(&f, &chunk, around(&chunk), 0, LeafCullingMode::Solid);
    // y=15 is the column's top: the faces toward y=16 are unknown, so they
    // stay, and the y=15 leaves are not enclosed.
    // rust: assert!(!hollow.solid.is_empty());
    // rust: assert!(solid.solid.iter().any(|v| v.pos[1] == 16.0));
    // rust: assert!(
    // rust: solid
    // rust: .solid
    // rust: .iter()
    // rust: .filter(|v| v.pos[1] == 16.0)
    // rust: .all(|v| v.layer & OPAQUE_LAYER == 0)
    // rust: );
}

a_world_without_leaves_meshes_identically_in_every_mode :: proc() {
}
    // rust: let f = fixture();
    // rust: let mut chunk = Chunk::empty(0, 0);
    // rust: for y in BASE..BASE + 3 {
    // rust: leaves_cube(&mut chunk, 6, 8, y, state(&f, "minecraft:stone"));
}
    // rust: let off = mesh(&f, &chunk, around(&chunk), 0, LeafCullingMode::Off);
    // rust: for mode in LeafCullingMode::ALL {
    // rust: let other = mesh(&f, &chunk, around(&chunk), 0, mode);
    // rust: assert_eq!(off.solid.len(), other.solid.len(), "{mode:?}");
    // rust: assert_eq!(off.translucent.len(), other.translucent.len(), "{mode:?}");
    // rust: for (a, b) in off.solid.iter().zip(&other.solid) {
    // rust: assert_eq!(
    // rust: (a.pos, a.uv, a.layer, a.light, a.color),
    // rust: (b.pos, b.uv, b.layer, b.light, b.color),
    // rust: "{mode:?}"
    // rust: );
}
    // rust: for (a, b) in off.translucent.iter().zip(&other.translucent) {
    // rust: assert_eq!(
    // rust: (a.pos, a.uv, a.layer, a.light, a.color),
    // rust: (b.pos, b.uv, b.layer, b.light, b.color),
    // rust: "{mode:?}"
    // rust: );
}
}
}
