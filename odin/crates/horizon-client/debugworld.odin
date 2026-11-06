//! Transpiled from Horizon Rust crate
package horizon_client_debugworld

import "core:fmt"
import "core:mem"
import "core:math"

// `DebugLevelSource`: the `minecraft:debug` generator of the Debug world preset,
// a grid of every block state floating over a layer of barriers.
// use crate::{
    // rust: chunk::{Chunk, LevelShape},
    // rust: streaming::ChunkGenerator,
}
// use horizon_world::{nbt::Tag, registry::BlockRegistry};

// `DebugLevelSource.HEIGHT`: the layer the block states stand in.
HEIGHT :: 70
// `DebugLevelSource.BARRIER_HEIGHT`.
BARRIER_HEIGHT :: 60

// The debug world's generator: every block state in registry order
// (`ALL_BLOCKS`) on a square grid, one every other block, at `HEIGHT`.
DebugTerrain :: struct {
    shape: LevelShape,
    biome: u16,
    barrier: u32,
    // `ALL_BLOCKS.size()`: block states are numbered in that order, so the
    // state at an index is the state with that id.
    states: u32,
}
    // rust: impl DebugTerrain {
    // The generator of a world whose overworld is `minecraft:debug`.
    // rust: pub fn from_settings(
    // rust: settings: &Tag,
    // rust: registry: &BlockRegistry,
    // rust: biomes: &crate::biome::Biomes,
    // rust: shape: LevelShape,
    // rust: ) -> Option<Self> {
    // rust: let generator = settings
    // rust: .get("dimensions")?
    // rust: .get("minecraft:overworld")?
    // rust: .get("generator")?;
    // rust: if crate::save::text(generator.get("type"))?.trim_start_matches("minecraft:") != "debug" {
    // rust: return None;
}
    // rust: Some(Self {
    // rust: shape,
            // `FixedBiomeSource(plains)`.
    // rust: biome: biomes.id("minecraft:plains"),
    // rust: barrier: registry.default_state("minecraft:barrier")?.0,
    // rust: states: u32::try_from(registry.len()).ok()?,
    // rust: })
}
    // `DebugLevelSource.getBlockStateFor`: the state id at a block column
    // (air, id 0, where the grid has none).
state_for :: proc(self: ^Self, x: i32, z: i32) -> u {
    // Ported from Horizon
    return {}
}
    // rust: grid_state(self.states, x, z)
}
}
// `DebugLevelSource.GRID_WIDTH` and `GRID_HEIGHT` for `count` block states:
// `Mth.ceil(Mth.sqrt(size))` and `ceil(size / width)`.
grid :: proc(count: u32) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let width = (count as f32).sqrt().ceil() as i32;
    // rust: let height = (count as f32 / width as f32).ceil() as i32;
    // rust: (width, height)
}
// `getBlockStateFor(worldX, worldZ)` as a state id.
grid_state :: proc(count: u32, mut x: i32, mut z: i32) -> u {
    // Ported from Horizon
    return {}
}
    // rust: let (width, height) = grid(count);
    // rust: if x > 0 && z > 0 && x % 2 != 0 && z % 2 != 0 {
    // rust: x /= 2;
    // rust: z /= 2;
    // rust: if x <= width && z <= height {
    // rust: let index = (x * width + z).unsigned_abs();
    // rust: if index < count {
    // rust: return index;
}
}
}
    // rust: 0
}
    // rust: impl ChunkGenerator for DebugTerrain {
    // rust: type Worker = ();
worker :: proc(self: ^Self) {
}
    // `DebugLevelSource.buildTerrain` builds nothing; `applyBiomeDecoration`
    // writes the barriers and the grid.
proto :: proc(self: ^Self, _: ^() {
}
    // rust: let mut chunk = Chunk::with_layout(cx, cz, self.shape.column());
    // rust: for s in &mut chunk.sections {
    // rust: std::sync::Arc::make_mut(s).biomes = horizon_core::paletted::PalettedContainer::new(
    // rust: crate::chunk::BIOME_STRATEGY,
    // rust: u32::from(self.biome),
    // rust: );
}
    // rust: for z in 0..16 {
    // rust: for x in 0..16 {
    // rust: chunk.set(x, BARRIER_HEIGHT, z, self.barrier);
    // rust: let state = self.state_for(cx * 16 + x, cz * 16 + z);
    // rust: if state != 0 {
    // rust: chunk.set(x, HEIGHT, z, state);
}
}
}
    // rust: for s in &mut chunk.sections {
    // rust: std::sync::Arc::make_mut(s).compact();
}
    // rust: Box::new(chunk)
}
    // `spawnOriginalMobs` is empty.
finish :: proc(self: ^Self, proto: crate::streaming::Proto) -> C {
    // Ported from Horizon
    return {}
}
    // rust: *proto.downcast::<Chunk>().expect("debug terrain proto")
}
}

    // rust: mod tests {
//     use super::*;

    // `getBlockStateFor`: only odd, positive columns hold a state, in the order
    // `x / 2 * width + z / 2`, and nothing past the last state.
the_grid_holds_a_state_every_other_block :: proc() {
}
        // 1000 states: a 32 wide grid, 32 high (ceil(1000 / 32) = 32).
    // rust: assert_eq!(grid(1000), (32, 32));
    // rust: assert_eq!(grid(1), (1, 1));
    // rust: assert_eq!(grid(26_000), (162, 161));
        // Even, zero and negative columns are air.
    // rust: for (x, z) in [(2, 1), (1, 2), (0, 1), (1, 0), (-1, 1), (1, -1)] {
    // rust: assert_eq!(grid_state(1000, x, z), 0, "{x} {z}");
}
        // (1, 1) is index 0 (air), (3, 5) is 1 * 32 + 2 = 34.
    // rust: assert_eq!(grid_state(1000, 1, 1), 0);
    // rust: assert_eq!(grid_state(1000, 3, 5), 34);
        // x = 2 * 32 + 1 maps to x / 2 = 32: index 32 * 32 + z / 2, past the 1000 states.
    // rust: assert_eq!(grid_state(1000, 65, 1), 0);
    // rust: assert_eq!(grid_state(1000, 61, 3), 30 * 32 + 1);
}
}
