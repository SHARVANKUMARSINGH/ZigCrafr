//! Transpiled from Horizon Rust crate
package horizon_client_render_potent_sulfur

import "core:fmt"
import "core:mem"
import "core:math"

// `PotentSulfurBlockEntity`'s reads of the level: where the noxious gas of a
// potent sulfur block comes out, how far a geyser throws, and whether the gas
// reaches a point. The client's particles and the server's nausea and
// launches read the level the same way, through a [`ParticleLevel`].
// use crate::{blocks::Fluid, collisions::SceneCollisions, particles::ParticleLevel};
// use horizon_core::{
    // rust: geometry::{Vec3, traverse_blocks},
    // rust: position::BlockPos,
}

// `PotentSulfurBlock.ALLOWED_WATER_BLOCKS_ABOVE`.
ALLOWED_WATER_BLOCKS_ABOVE :: 4

// `PotentSulfurBlockEntity.isGeyserPassableBlock`: air, water, or a block
// with no collision shape.
is_geyser_passable_block :: proc(level: ^ParticleLevel, pos: [i32; 3]) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let state = level.world.block(pos[0], pos[1], pos[2]);
    // rust: if level.facts.is_air(state) || &*level.facts.get(state).name == "minecraft:water" {
    // rust: return true;
}
    // rust: let mut scene = SceneCollisions {
    // rust: world: level.world,
    // rust: binding: level.collision,
    // rust: subject: None,
}
    // rust: match level.collision.collision_shape(&mut scene, state, pos) {
    // rust: Ok(shape) => shape.is_empty(),
    // rust: Err(_) => !level.facts.get(state).full_collision,
}
}

// `PotentSulfurBlockEntity.isWater`: the block at `pos` holds a water source
// (`FluidState.isSourceOfType`).
is_water_source :: proc(level: ^ParticleLevel, pos: [i32; 3]) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let (fluid, source) = level.fluid_source(pos);
    // rust: fluid == Fluid::Water && source
}

// `PotentSulfurBlockEntity.findNoxiousGasSourceBlock`: the first block above
// the sulfur, within the water column's reach, that is not water-filled and
// lets gas through; None when something solid or a deeper column stops it.
find_noxious_gas_source_block :: proc(level: ^ParticleLevel, origin: [i32; 3]) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let max_y = origin[1] + ALLOWED_WATER_BLOCKS_ABOVE + 1;
    // rust: let mut pos = [origin[0], origin[1] + 1, origin[2]];
    // rust: while pos[1] <= max_y {
    // rust: let state = level.world.block(pos[0], pos[1], pos[2]);
    // rust: let is_water_block = &*level.facts.get(state).name == "minecraft:water";
    // rust: if !is_water_source(level, pos)
    // rust: || (!is_water_block && !is_geyser_passable_block(level, pos))
    // rust: {
    // rust: if level.facts.is_air(state) || is_geyser_passable_block(level, pos) {
    // rust: return Some(pos);
}
    // rust: break;
}
    // rust: pos[1] += 1;
}
    // rust: None
}

// `PotentSulfurBlockEntity.getUnobstructedBlockCount`: how many blocks from
// `pos` up, at most six per water block, a geyser's push goes through.
unobstructed_block_count :: proc(level: ^ParticleLevel, pos: [i32; 3], water_blocks: i32) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let geyser_force_height = 6 * water_blocks;
    // rust: for i in 0..geyser_force_height {
    // rust: if !is_geyser_passable_block(level, [pos[0], pos[1] + i, pos[2]]) {
    // rust: return i;
}
}
    // rust: geyser_force_height
}

// `PotentSulfurBlockEntity.canBeReachedByNoxiousGas`: `pos` is in a block gas
// can enter, within three blocks of the source block's centre, and above
// water the source's water can be seen from.
    // rust: pub fn can_be_reached_by_noxious_gas(
    // rust: level: &ParticleLevel,
    // rust: source_block: [i32; 3],
    // rust: pos: [f64; 3],
    // rust: ) -> bool {
    // rust: let block = ParticleLevel::block_at(pos);
    // rust: if !is_geyser_passable_block(level, block) {
    // rust: return false;
}
    // rust: let center = source_block.map(|c| f64::from(c) + 0.5);
    // rust: let distance_sqr =
    // rust: (center[0] - pos[0]).powi(2) + (center[1] - pos[1]).powi(2) + (center[2] - pos[2]).powi(2);
    // rust: if distance_sqr > 9.0 {
    // rust: return false;
}
    // rust: let below_source = [center[0], f64::from(source_block[1] - 1) + 0.5, center[2]];
    // rust: let below_pos = [pos[0], pos[1] - 1.0, pos[2]];
    // rust: is_water_source(level, ParticleLevel::block_at(below_pos))
    // rust: && have_line_of_sight(level, below_source, below_pos)
}

// `PotentSulfurBlockEntity.haveLineOfSight`: a clip over collider shapes and
// no fluids (as the mobs' line of sight does) finds no block between the
// points.
have_line_of_sight :: proc(level: ^ParticleLevel, a: [f64; 3], b: [f64; 3]) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let (from, to) = (Vec3::new(a[0], a[1], a[2]), Vec3::new(b[0], b[1], b[2]));
    // rust: let mut scene = SceneCollisions {
    // rust: world: level.world,
    // rust: binding: level.collision,
    // rust: subject: None,
}
    // rust: let hit = traverse_blocks(from, to, 512, |p: BlockPos| {
    // rust: let state = level.world.block(p.x, p.y, p.z);
    // rust: if level.facts.is_air(state) {
    // rust: return None;
}
    // rust: let shape = level
    // rust: .collision
    // rust: .collision_shape(&mut scene, state, [p.x, p.y, p.z])
    // rust: .ok()?;
    // rust: shape.clip(from, to, p).map(|_| ())
    // rust: });
    // rust: !matches!(hit, Ok(Some(())))
}
