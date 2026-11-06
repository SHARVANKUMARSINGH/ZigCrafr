//! Transpiled from Horizon Rust crate
package horizon_client_render_particle_tests

import "core:fmt"
import "core:mem"
import "core:math"

// use super::*;

// `TerrainParticle`: the model's particle sprite and tint source 0's
// `colorAsTerrainParticle` (#1034: grass blocks crumbled as tinted grass tops).
terrain_particles_use_the_particle_sprite_and_vanilla_tint_sources :: proc() {
}
    // rust: let root =
    // rust: std::path::Path::new(env!("CARGO_MANIFEST_DIR")).join("../../.local/horizon-client/26.3");
    // rust: if !root.join("horizon-resources.json").exists() {
    // rust: return;
}
    // rust: let assets = Assets::load(&root).unwrap();
    // rust: let render = assets.reload(&root).unwrap();
    // rust: let facts = BlockFacts::load(&root, assets.registry).unwrap();
    // rust: let visibility = crate::models::load_visibility(&root, assets.registry).unwrap();
    // rust: let tables = MeshTables::new(&assets, &render, &facts, visibility).unwrap();
    // rust: let biomes = Biomes::load(&root).unwrap();
    // rust: let state = |name| assets.registry.default_state(name).unwrap();
    // rust: let sprite = |name| {
    // rust: let layer = render.model_catalog.particle(state(name)).unwrap();
    // rust: let (sprite, _) = render
    // rust: .sprite_layers
    // rust: .iter()
    // rust: .find(|(_, l)| **l == layer)
    // rust: .unwrap();
    // rust: sprite.clone()
}
    // rust: assert_eq!(sprite("minecraft:grass_block"), "minecraft:block/dirt");
    // rust: assert_eq!(
    // rust: sprite("minecraft:short_grass"),
    // rust: "minecraft:block/short_grass"
    // rust: );
    // rust: assert_eq!(sprite("minecraft:oak_leaves"), "minecraft:block/oak_leaves");

    // rust: let center = Chunk::empty(0, 0);
    // rust: let mut region = [[None; 3]; 3];
    // rust: region[1][1] = Some(&center);
    // rust: let tint = |name| {
    // rust: tables.terrain_particle_tint(
    // rust: state(name),
    // rust: [5, 70, 9],
    // rust: &region,
    // rust: &biomes,
    // rust: BiomeZoom::new(0),
    // rust: 2,
    // rust: )
}
    // grassBlock() overrides colorAsTerrainParticle to -1: the dirt stays untinted.
    // rust: assert_eq!(tint("minecraft:grass_block"), None);
    // rust: assert!(tint("minecraft:short_grass").is_some());
    // rust: assert!(tint("minecraft:oak_leaves").is_some());
    // rust: assert_eq!(tint("minecraft:spruce_leaves"), Some(0x61_9961));
    // Pink petals' layer 0 is BLANK_LAYER; stone has no tint source.
    // rust: assert_eq!(tint("minecraft:pink_petals"), None);
    // rust: assert_eq!(tint("minecraft:stone"), None);
}

// Blocks drawn outside the chunk mesh (moved by a piston) take the chunk
// mesher's per-layer tints: a grass block's top and side overlay are tinted
// as in the world, not left gray like its particles.
block_tints_match_the_chunk_mesh_for_grass_blocks :: proc() {
}
    // rust: let root =
    // rust: std::path::Path::new(env!("CARGO_MANIFEST_DIR")).join("../../.local/horizon-client/26.3");
    // rust: if !root.join("horizon-resources.json").exists() {
    // rust: return;
}
    // rust: let assets = Assets::load(&root).unwrap();
    // rust: let render = assets.reload(&root).unwrap();
    // rust: let facts = BlockFacts::load(&root, assets.registry).unwrap();
    // rust: let visibility = crate::models::load_visibility(&root, assets.registry).unwrap();
    // rust: let tables = MeshTables::new(&assets, &render, &facts, visibility).unwrap();
    // rust: let biomes = Biomes::load(&root).unwrap();
    // rust: let state = |name| assets.registry.default_state(name).unwrap();
    // rust: let center = Chunk::empty(0, 0);
    // rust: let mut region = [[None; 3]; 3];
    // rust: region[1][1] = Some(&center);
    // rust: let tints = |name| {
    // rust: tables.block_tints(
    // rust: state(name),
    // rust: [5, 70, 9],
    // rust: &region,
    // rust: &biomes,
    // rust: BiomeZoom::new(0),
    // rust: 2,
    // rust: )
}
    // rust: let grass = tints("minecraft:grass_block");
    // rust: assert!(grass(0).is_some());
    // rust: assert_eq!(grass(-1), None);
    // rust: assert_eq!(tints("minecraft:spruce_leaves")(0), Some(0x61_9961));
    // rust: assert_eq!(tints("minecraft:stone")(0), None);
}
