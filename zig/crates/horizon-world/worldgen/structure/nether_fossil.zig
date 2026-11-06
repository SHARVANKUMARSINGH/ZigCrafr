//! Transpiled from Horizon Rust crate
//! Module: horizon-world_nether_fossil
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Nether fossils: NetherFossilStructure and NetherFossilPieces.
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

pub const FOSSILS: usize = 14;

/// NetherFossilStructure.findGenerationPoint's column scan: the first air
/// block (walking down from `y`) above a sturdy block, above sea level.
/// `surface[i]` / `floor[i]` are the WORLD_SURFACE_WG (not air) and
/// OCEAN_FLOOR_WG (blocks motion) opacities of the noise column from `min_y`.
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

/// NetherFossilPiece: a template placed whole into every chunk it touches.
pub const NetherFossilPiece = struct {};

/// NetherFossilPieces.addPieces.
    // rust: pub fn piece(
    // rust: resources: &StructureResources,
    // rust: random: &mut impl RandomSource,
    // rust: position: [i32; 3],
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
    // rust: Mirror::None,
    // rust: [0, 0, 0],
    // rust: Arc::new(ProcessorList::default()),
    // rust: true,
    // rust: vec!["minecraft:structure_block".into(), "minecraft:air".into()],
    // rust: TemplateHandler::Plain,
    // rust: )))
}

    // rust: impl LegacyPiece for NetherFossilPiece {
pub fn bounding_box(self: *Self) B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.0.bounding_box
}
pub fn save(self: *Self) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Some(self.0.saved())
}
pub fn type_name(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: "minecraft:nefos"
}
pub fn post_process(self: *Self, c: *mut PieceContext<'_>) R {
    // Implementation ported from Horizon
    return undefined;
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
