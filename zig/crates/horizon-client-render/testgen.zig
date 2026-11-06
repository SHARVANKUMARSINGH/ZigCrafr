//! Transpiled from Horizon Rust crate
//! Module: horizon-client-render_testgen
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Simple rolling terrain used only until the vanilla overworld generator is
//! bound (`--test-terrain`). Not vanilla generation.
// use crate::{chunk::Chunk, streaming::ChunkGenerator};
// use horizon_world::registry::BlockRegistry;

pub const TestTerrain = struct {
    stone: u32,
    dirt: u32,
    grass: u32,
    water: u32,
    sand: u32,
    bedrock: u32,
    log: u32,
    leaves: u32,
    short_grass: u32,
    plains: u16,
};
    // rust: impl TestTerrain {
pub fn new(registry: *BlockRegistry, biomes: *crate::biome::Biomes) c {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let id = |name: &str| -> crate::Result<u32> {
    // rust: Ok(registry
    // rust: .default_state(name)
    // rust: .ok_or_else(|| format!("missing {name}"))?
    // rust: .0)
}
    // rust: Ok(Self {
    // rust: stone: id("minecraft:stone")?,
    // rust: dirt: id("minecraft:dirt")?,
    // rust: grass: id("minecraft:grass_block")?,
    // rust: water: id("minecraft:water")?,
    // rust: sand: id("minecraft:sand")?,
    // rust: bedrock: id("minecraft:bedrock")?,
    // rust: log: id("minecraft:oak_log")?,
    // rust: leaves: registry
    // rust: .resolve(&horizon_world::chunk::BlockState {
    // rust: name: "minecraft:oak_leaves".into(),
    // rust: properties: [
    // rust: ("distance".to_owned(), "1".to_owned()),
    // rust: ("persistent".to_owned(), "false".to_owned()),
    // rust: ("waterlogged".to_owned(), "false".to_owned()),
    // rust: ]
    // rust: .into(),
    // rust: })?
    // rust: .0,
    // rust: short_grass: id("minecraft:short_grass")?,
    // rust: plains: biomes.id("minecraft:plains"),
    // rust: })
}
pub fn height(x: i32, z: i32) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (x, z) = (f64::from(x), f64::from(z));
    // rust: let h = 68.0
    // rust: + 10.0 * (x / 47.0).sin() * (z / 61.0).cos()
    // rust: + 5.0 * ((x + z) / 23.0).sin()
    // rust: + 3.0 * (x / 11.0).cos() * (z / 13.0).sin();
    // rust: h as i32
}
}
pub fn hash(x: i32, z: i32) u {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut h = (x as u32).wrapping_mul(0x9E37_79B1) ^ (z as u32).wrapping_mul(0x85EB_CA77);
    // rust: h ^= h >> 15;
    // rust: h = h.wrapping_mul(0x2C1B_3C6D);
    // rust: h ^ (h >> 12)
}
    // rust: impl ChunkGenerator for TestTerrain {
    // rust: type Worker = ();
pub fn worker(self: *Self) void {
}
pub fn lod_surface(self: *Self, _: *mut () void {
}
    // rust: let h = Self::height(x, z);
    // rust: Some(crate::lod::Surface {
    // rust: height: h + 1,
    // rust: state: horizon_world::registry::BlockStateId(if h <= 63 {
    // rust: self.sand
    // rust: } else {
    // rust: self.grass
    // rust: }),
    // rust: water: (h < 62).then_some((63, horizon_world::registry::BlockStateId(self.water))),
    // rust: biome: self.plains,
    // rust: })
}
pub fn proto(self: *Self, w: *mut () void {
}
    // rust: Box::new(self.generate(w, x, z))
}
pub fn finish(self: *Self, proto: crate::streaming::Proto) C {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut chunk = *proto.downcast::<Chunk>().expect("test terrain proto");
    // rust: chunk.fresh = true;
    // rust: chunk
}
}
    // rust: impl TestTerrain {
pub fn generate(self: *Self, _: *mut () void {
}
    // rust: let mut chunk = Chunk::empty(cx, cz);
    // rust: for s in &mut chunk.sections {
    // rust: std::sync::Arc::make_mut(s).biomes = horizon_core::paletted::PalettedContainer::new(
    // rust: crate::chunk::BIOME_STRATEGY,
    // rust: u32::from(self.plains),
    // rust: );
}
    // rust: for z in 0..16 {
    // rust: for x in 0..16 {
    // rust: let (wx, wz) = (cx * 16 + x, cz * 16 + z);
    // rust: let h = Self::height(wx, wz);
    // rust: for y in -64..=h.max(62) {
    // rust: let b = if y == -64 {
    // rust: self.bedrock
    // rust: } else if y > h {
    // rust: self.water
    // rust: } else if y < h - 3 {
    // rust: self.stone
    // rust: } else if h <= 63 {
    // rust: self.sand
    // rust: } else if y == h {
    // rust: self.grass
    // rust: } else {
    // rust: self.dirt
}
    // rust: chunk.set(x, y, z, b);
}
    // rust: if h > 63 && hash(wx, wz).is_multiple_of(13) {
    // rust: chunk.set(x, h + 1, z, self.short_grass);
}
}
}
        // Trees fully inside the chunk.
    // rust: for z in 2..14 {
    // rust: for x in 2..14 {
    // rust: let (wx, wz) = (cx * 16 + x, cz * 16 + z);
    // rust: let h = Self::height(wx, wz);
    // rust: if h <= 64 || !hash(wx, wz).is_multiple_of(97) {
    // rust: continue;
}
    // rust: for y in h + 1..h + 6 {
    // rust: chunk.set(x, y, z, self.log);
}
    // rust: for dy in 3..7 {
    // rust: let r = if dy >= 5 { 1 } else { 2 };
    // rust: for dz in -r..=r {
    // rust: for dx in -r..=r {
    // rust: if chunk.get(x + dx, h + dy, z + dz) == 0 {
    // rust: chunk.set(x + dx, h + dy, z + dz, self.leaves);
}
}
}
}
}
}
    // rust: for s in &mut chunk.sections {
    // rust: std::sync::Arc::make_mut(s).compact();
}
    // rust: chunk
}
}

    // rust: mod tests {
//     use super::*;

pub fn far_surface_agrees_with_generated_land_and_water() void {
}
    // rust: let terrain = TestTerrain {
    // rust: stone: 1,
    // rust: dirt: 2,
    // rust: grass: 3,
    // rust: water: 4,
    // rust: sand: 5,
    // rust: bedrock: 6,
    // rust: log: 7,
    // rust: leaves: 8,
    // rust: short_grass: 9,
    // rust: plains: 10,
}
    // rust: let mut wet = false;
    // rust: for (cx, cz) in [(0, 0), (-7, 3), (15, -12), (-21, -8)] {
    // rust: let chunk = terrain.generate(&mut (), cx, cz);
    // rust: for x in 0..16 {
    // rust: let surface = terrain.lod_surface(&mut (), cx * 16 + x, cz * 16).unwrap();
    // rust: assert_eq!(chunk.get(x, surface.height - 1, 0), surface.state.0);
    // rust: if let Some((height, state)) = surface.water {
    // rust: wet = true;
    // rust: assert_eq!(chunk.get(x, height - 1, 0), state.0);
    // rust: assert_eq!(chunk.get(x, height, 0), 0);
}
}
}
    // rust: assert!(wet, "fixture includes underwater land");
}
}
