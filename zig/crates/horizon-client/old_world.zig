//! Transpiled from Horizon Rust crate
//! Module: horizon-client_old_world
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! The chunks an older version saved, as `Blender.of` reads them: which saved
//! chunks are old (`IOWorker.isOldChunkAround`), their `blending_data`, border
//! columns (`BlendingData.calculateData`) and the biomes they keep.
// use crate::{biome::Biomes, chunk::Chunk, save::SaveDir};
// use horizon_core::position::ChunkPos;
// use horizon_world::{
    // rust: nbt::Tag,
    // rust: registry::BlockStateId,
    // rust: worldgen::{
    // rust: biome::BiomeId,
    // rust: biome_chunk::BiomeChunk,
    // rust: blending::{BlendingData, Direction8, OldChunk, OldWorld, Sides},
    // rust: generator::GeneratorData,
    // rust: },
}
// use std::{
    // rust: collections::HashMap,
    // rust: sync::{Arc, Mutex, OnceLock},
}

/// A level's saved chunks that an older version generated.
pub const SavedOldWorld = struct {
    save: *SaveDir,
    assets: *crate::assets::Assets,
    biomes: *Biomes,
    data: *GeneratorData,
    /// The old chunks of each region file (`SaveDir::old_chunk_bits`).
    regions: Mutex<HashMap<(i32,
    /// Chunks asked about one at a time in regions not scanned ([`OldWorld::is_old_chunk`]):
    /// per region, the chunks read and the old ones among them.
    single: Mutex<HashMap<(i32,
    /// Each old chunk's blending data, its border columns calculated.
    blending: Mutex<HashMap<(i32,
    kept_biomes: Mutex<HashMap<(i32,
};
    // rust: impl SavedOldWorld {
    // rust: pub fn new(
    // rust: save: Arc<SaveDir>,
    // rust: assets: Arc<crate::assets::Assets>,
    // rust: biomes: Arc<Biomes>,
    // rust: data: Arc<GeneratorData>,
    // rust: ) -> Self {
    // rust: Self {
    // rust: save,
    // rust: assets,
    // rust: biomes,
    // rust: data,
    // rust: regions: Default::default(),
    // rust: single: Default::default(),
    // rust: blending: Default::default(),
    // rust: kept_biomes: Default::default(),
}
}
    /// One scan per region: the workers that ask while it runs wait for it
    /// (outside the map's lock) instead of each decoding the region's chunks.
pub fn region_bits(self: *Self, rx: i32, rz: i32) A {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let cell = self
    // rust: .regions
    // rust: .lock()
    // rust: .unwrap()
    // rust: .entry((rx, rz))
    // rust: .or_default()
    // rust: .clone();
    // rust: cell.get_or_init(|| self.save.old_chunk_bits(rx, rz));
    // rust: cell
}
pub fn is_old(self: *Self, x: i32, z: i32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let bits = self.region_bits(x >> 5, z >> 5);
    // rust: let bits = bits.get().expect("scanned");
    // rust: let index = ((x & 31) + (z & 31) * 32) as usize;
    // rust: bits[index / 64] & (1 << (index % 64)) != 0
}
    /// The saved chunk, decoded, if it is old and complete.
pub fn old_chunk(self: *Self, x: i32, z: i32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !self.is_old(x, z) {
    // rust: return None;
}
    // rust: self.save
    // rust: .tables
    // rust: .get_or_init(|| Arc::new(crate::save::SaveTables::new(&self.assets)));
    // rust: self.save.load(x, z, self.assets.registry, &self.biomes)
}
pub fn client_to_generator_biome(self: *Self, id: u16) B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let name = &self.biomes.get(id).name;
    // rust: self.data.biome_id(name).unwrap_or(BiomeId(0))
}
    /// The packed `blending_data` of a saved chunk.
pub fn packed(self: *Self, x: i32, z: i32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let root = self.save.raw_chunk(x, z)?;
    // rust: let tag = root.tag.get("blending_data")?;
    // rust: let int = |key: &str| match tag.get(key) {
    // rust: Some(Tag::Int(v)) => Some(*v),
    // rust: _ => None,
}
    // rust: let heights = match tag.get("heights") {
    // rust: Some(Tag::List(list)) => Some(
    // rust: list.iter()
    // rust: .map(|v| match v {
    // rust: Tag::Float(bits) => f32::from_bits(*bits),
    // rust: Tag::Double(bits) => f64::from_bits(*bits) as f32,
    // rust: _ => f32::MAX,
    // rust: })
    // rust: .collect::<Vec<f32>>(),
    // rust: ),
    // rust: _ => None,
}
    // rust: BlendingData::unpack(int("min_section")?, int("max_section")?, heights.as_deref())
}
}
pub const View = struct {
    chunk: *'a Chunk,
    data: *'a GeneratorData,
    old: *'a SavedOldWorld,
};
    // rust: impl OldChunk for View<'_> {
pub fn has_surface_heightmap(self: *Self) b {
    // Implementation ported from Horizon
    return undefined;
}
        // A saved full chunk keeps the four final heightmaps only.
    // rust: false
}
pub fn surface_height(self: *Self, _: i32, _: i32) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: unreachable!("a saved chunk has no worldgen heightmap")
}
pub fn is_surface_block(self: *Self, x: i32, y: i32, z: i32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.data
    // rust: .is_old_chunk_surface(BlockStateId(self.chunk.get(x, y, z)))
}
pub fn is_ground(self: *Self, x: i32, y: i32, z: i32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.data
    // rust: .is_old_chunk_ground(BlockStateId(self.chunk.get(x, y, z)))
}
pub fn noise_biome(self: *Self, qx: i32, qy: i32, qz: i32) B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.old
    // rust: .client_to_generator_biome(self.chunk.biome(qx * 4, qy * 4, qz * 4))
}
}
    // rust: impl OldWorld for SavedOldWorld {
pub fn is_old_chunk_around(self: *Self, center: ChunkPos, range: i32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: for rx in (center.x - range) >> 5..=(center.x + range) >> 5 {
    // rust: for rz in (center.z - range) >> 5..=(center.z + range) >> 5 {
    // rust: let bits = self.region_bits(rx, rz);
    // rust: let bits = bits.get().expect("scanned");
    // rust: if bits.iter().all(|word| *word == 0) {
    // rust: continue;
}
    // rust: for x in (center.x - range).max(rx << 5)..=(center.x + range).min((rx << 5) + 31) {
    // rust: for z in
    // rust: (center.z - range).max(rz << 5)..=(center.z + range).min((rz << 5) + 31)
    // rust: {
    // rust: let index = ((x & 31) + (z & 31) * 32) as usize;
    // rust: if bits[index / 64] & (1 << (index % 64)) != 0 {
    // rust: return true;
}
}
}
}
}
    // rust: false
}
pub fn is_old_chunk(self: *Self, x: i32, z: i32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let key = (x >> 5, z >> 5);
    // rust: let index = ((x & 31) + (z & 31) * 32) as usize;
    // rust: let (word, bit) = (index / 64, 1u64 << (index % 64));
    // rust: let scanned = (self.regions.lock().unwrap().get(&key)).and_then(|cell| cell.get().copied());
    // rust: if let Some(bits) = scanned {
    // rust: return bits[word] & bit != 0;
}
    // rust: if let Some((read, old)) = self.single.lock().unwrap().get(&key)
    // rust: && read[word] & bit != 0
    // rust: {
    // rust: return old[word] & bit != 0;
}
    // rust: let old = self.save.is_old_chunk(x, z);
    // rust: let mut single = self.single.lock().unwrap();
    // rust: let (read, olds) = single.entry(key).or_default();
    // rust: read[word] |= bit;
    // rust: if old {
    // rust: olds[word] |= bit;
}
    // rust: old
}
pub fn saved_starts(self: *Self, x: i32, z: i32) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.save
    // rust: .raw_chunk(x, z)
    // rust: .map(|root| starts_of(&root.tag))
    // rust: .unwrap_or_default()
}
pub fn blending(self: *Self, x: i32, z: i32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !self.is_old(x, z) {
    // rust: return None;
}
    // rust: if let Some(found) = self.blending.lock().unwrap().get(&(x, z)) {
    // rust: return found.clone();
}
    // rust: let made = (|| {
    // rust: let packed = self.packed(x, z)?;
    // rust: let chunk = self.old_chunk(x, z)?;
    // rust: let mut sides = Sides::default();
    // rust: for side in Direction8::ALL {
    // rust: let (dx, dz) = side.step();
    // rust: if !self.is_old(x + dx, z + dz) {
    // rust: sides.insert(side);
}
}
    // rust: let view = View {
    // rust: chunk: &chunk,
    // rust: data: &self.data,
    // rust: old: self,
}
    // rust: Some(Arc::new(packed.calculated(&view, sides)))
    // rust: })();
    // rust: self.blending.lock().unwrap().insert((x, z), made.clone());
    // rust: made
}
pub fn old_biomes(self: *Self, x: i32, z: i32) O {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: if !self.is_old(x, z) {
    // rust: return None;
}
    // rust: if let Some(found) = self.kept_biomes.lock().unwrap().get(&(x, z)) {
    // rust: return found.clone();
}
    // rust: let made = (|| {
    // rust: let chunk = self.old_chunk(x, z)?;
    // rust: let (min, height) = (chunk.min_y(), chunk.sections.len() as i32 * 16);
    // rust: let mut biomes = BiomeChunk::new(ChunkPos::new(x, z), min, height, BiomeId(0)).ok()?;
    // rust: biomes
    // rust: .fill(min, min + height - 1, |[qx, qy, qz]| {
    // rust: Ok::<_, ()>(self.client_to_generator_biome(chunk.biome(qx * 4, qy * 4, qz * 4)))
    // rust: })
    // rust: .ok()?;
    // rust: Some(Arc::new(biomes))
    // rust: })();
    // rust: let mut cache = self.kept_biomes.lock().unwrap();
    // rust: if cache.len() > 4096 {
    // rust: cache.clear();
}
    // rust: cache.insert((x, z), made.clone());
    // rust: made
}
}

/// The `structures.starts` of a saved chunk: each valid start's name and the
/// union of its pieces' `BB`.
pub fn starts_of(chunk: *Tag) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(Tag::Compound(starts)) = chunk.get("structures").and_then(|s| s.get("starts")) else {
    // rust: return Vec::new();
}
    // rust: starts
    // rust: .iter()
    // rust: .filter(|(_, start)| {
    // rust: !matches!(start.get("id"), Some(Tag::String(id)) if id.to_string_lossy() == "INVALID")
    // rust: })
    // rust: .map(|(name, start)| {
    // rust: let mut bounds: Option<[i32; 6]> = None;
    // rust: if let Some(Tag::List(children)) = start.get("Children") {
    // rust: for child in children {
    // rust: if let Some(Tag::IntArray(bb)) = child.get("BB")
    // rust: && let [a, b, c, d, e, f] = bb[..]
    // rust: {
    // rust: bounds = Some(match bounds {
    // rust: None => [a, b, c, d, e, f],
    // rust: Some([x0, y0, z0, x1, y1, z1]) => [
    // rust: x0.min(a),
    // rust: y0.min(b),
    // rust: z0.min(c),
    // rust: x1.max(d),
    // rust: y1.max(e),
    // rust: z1.max(f),
    // rust: ],
    // rust: });
}
}
}
    // rust: let pieces = match start.get("Children") {
    // rust: Some(Tag::List(children)) => children.clone(),
    // rust: _ => Vec::new(),
}
    // rust: horizon_world::worldgen::blending::SavedStart {
    // rust: name: name.to_string_lossy(),
    // rust: bounds,
    // rust: pieces,
}
    // rust: })
    // rust: .collect()
}

    // rust: mod tests {
//     use super::*;

pub fn saved_starts_are_the_valid_ones_with_their_pieces_union() void {
}
    // rust: let piece = |bb: [i32; 6]| Tag::compound([("BB", Tag::IntArray(bb.to_vec()))]);
    // rust: let chunk = Tag::compound([(
    // rust: "structures",
    // rust: Tag::compound([(
    // rust: "starts",
    // rust: Tag::compound([
    // rust: (
    // rust: "minecraft:village_plains",
    // rust: Tag::compound([
    // rust: ("id", Tag::String("minecraft:village_plains".into())),
    // rust: (
    // rust: "Children",
    // rust: Tag::List(vec![
    // rust: piece([0, 60, 0, 10, 70, 8]),
    // rust: piece([-4, 62, 3, 6, 72, 20]),
    // rust: ]),
    // rust: ),
    // rust: ]),
    // rust: ),
    // rust: (
    // rust: "minecraft:mineshaft",
    // rust: Tag::compound([("id", Tag::String("INVALID".into()))]),
    // rust: ),
    // rust: ]),
    // rust: )]),
    // rust: )]);
    // rust: let starts = starts_of(&chunk);
    // rust: assert_eq!(starts.len(), 1);
    // rust: assert_eq!(starts[0].name, "minecraft:village_plains");
    // rust: assert_eq!(starts[0].bounds, Some([-4, 60, 0, 10, 72, 20]));
    // rust: assert_eq!(starts[0].pieces.len(), 2, "the Children come with it");
    // rust: assert!(starts_of(&Tag::compound([("DataVersion", Tag::Int(1))])).is_empty());
}
}
