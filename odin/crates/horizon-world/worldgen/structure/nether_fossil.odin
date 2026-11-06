//! Transpiled from Horizon Rust crate
package horizon_world_nether_fossil

import "core:fmt"
import "core:mem"
import "core:math"

// Nether fossils: NetherFossilStructure and NetherFossilPieces.
// use super::{
    // rust: BoundingBox, Mirror, Rotation, StructureResources,
    // rust: legacy::{LegacyPiece, PieceContext, Result, TemplateHandler, TemplatePiece},
    // rust: processor::ProcessorList,
}
// use horizon_core::{
    // rust: position::BlockPos,
    // rust: random::{LegacyRandom, PositionalRandom, RandomSource},
}
// use std::sync::Arc;

FOSSILS :: 14

// NetherFossilStructure.findGenerationPoint's column scan: the first air
// block (walking down from `y`) above a sturdy block, above sea level.
// `surface[i]` / `floor[i]` are the WORLD_SURFACE_WG (not air) and
// OCEAN_FLOOR_WG (blocks motion) opacities of the noise column from `min_y`.
    // rust: pub fn find_floor(
    // rust: surface: &[bool],
    // rust: floor: &[bool],
    // rust: min_y: i32,
    // rust: mut y: i32,
    // rust: sea_level: i32,
    // rust: ) -> Option<i32> {
    // rust: let at = |column: &[bool], y: i32| {
    // rust: usize::try_from(y - min_y)
    // rust: .ok()
    // rust: .and_then(|i| column.get(i).copied())
    // rust: .unwrap_or(false)
}
    // rust: while y > sea_level {
    // rust: let air = !at(surface, y);
    // rust: y -= 1;
        // Noise columns hold only the default block (sturdy), fluid and air,
        // so "soul sand or sturdy top face" is "blocks motion".
    // rust: if air && at(floor, y) {
    // rust: break;
}
}
    // rust: (y > sea_level).then_some(y)
}

// NetherFossilPiece: a template placed whole into every chunk it touches.
NetherFossilPiece :: struct {

// NetherFossilPieces.addPieces.
    // rust: pub fn piece(
    resources: ^StructureResources,
    random: ^impl RandomSource,
    position: [i32,
    // rust: ) -> Option<NetherFossilPiece> {
    // rust: let rotation = Rotation::random(random);
    // rust: let index = random.next_int_bound(FOSSILS as i32).ok()? + 1;
    // rust: let name = format!("minecraft:nether_fossils/fossil_{index}");
    // rust: Some(NetherFossilPiece(TemplatePiece::new(
    // rust: "minecraft:nefos",
    // rust: &name,
    // rust: resources.template(&name)?,
    // rust: position,
    // rust: rotation,
    Mirror: :None,
    // rust: [0, 0, 0],
    Arc: :new(ProcessorList::default()),
    // rust: true,
    // rust: vec!["minecraft:structure_block".into(), "minecraft:air".into()],
    TemplateHandler: :Plain,
    // rust: )))
}

    // rust: impl LegacyPiece for NetherFossilPiece {
bounding_box :: proc(self: ^Self) -> B {
    // Ported from Horizon
    return {}
}
    // rust: self.0.bounding_box
}
save :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: Some(self.0.saved())
}
type_name :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: "minecraft:nefos"
}
post_process :: proc(self: ^Self, c: ^PieceContext<'_>) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let piece = &self.0;
    // rust: let fossil =
    // rust: piece
    // rust: .template
    // rust: .bounding_box(piece.position, piece.rotation, piece.pivot, piece.mirror);
        // Vanilla grows the chunk box to the whole fossil before placing.
    // rust: let saved = c.chunk_box;
    // rust: c.chunk_box.encapsulate(&fossil);
    // rust: let result = piece.place_at(c, piece.position, &[]).and_then(|_| {
            // placeDriedGhast.
    // rust: let seed = c.world.seed()?;
    // rust: let center = fossil.center();
    // rust: let mut random = LegacyRandom::new(seed)
    // rust: .fork_positional()
    // rust: .at(BlockPos::new(center[0], center[1], center[2]));
    // rust: if random.next_float() < 0.5 {
    // rust: let [sx, _, sz] = fossil.span();
    // rust: let x = fossil.min[0] + random.next_int_bound(sx).unwrap_or(0);
    // rust: let z = fossil.min[2] + random.next_int_bound(sz).unwrap_or(0);
    // rust: let pos = [x, fossil.min[1], z];
    // rust: let current = c.world.block(pos)?;
    // rust: if c.is_air(current) && c.chunk_box.is_inside(pos) {
    // rust: let state = c
    // rust: .resources
    // rust: .transforms
    // rust: .rotate(c.state("dried_ghast"), Rotation::random(&mut random));
    // rust: c.world.set(pos, state, 2)?;
}
}
    // rust: Ok(())
    // rust: });
    // rust: c.chunk_box = saved;
    // rust: result
}
}
