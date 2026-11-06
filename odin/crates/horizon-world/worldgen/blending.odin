//! Transpiled from Horizon Rust crate
package horizon_world_blending

import "core:fmt"
import "core:mem"
import "core:math"

// `BlendingData` and `Blender`: the terrain, biomes and carving of a new
// chunk next to chunks an older version generated (`blending_data` in the
// save), so a world upgraded from before 1.18 meets its old terrain without
// a seam.
// use super::biome::BiomeId;
// use horizon_core::{
    // rust: density::{DensityBlender, DensitySampler, SampleError, SamplerContext},
    // rust: noise::{DensityVolume, Noise, NormalNoise},
    // rust: position::ChunkPos,
    // rust: random::XoroshiroRandom,
}
// use std::sync::Arc;

QUARTS_PER_SECTION :: 4
MAX_INSIDE :: QUARTS_PER_SECTION - 1
MAX_OUTSIDE :: QUARTS_PER_SECTION
COLUMN_INSIDE_COUNT :: 2 * MAX_INSIDE + 1
COLUMN_OUTSIDE_COUNT :: 2 * MAX_OUTSIDE + 1
// `BlendingData.CELL_COLUMN_COUNT`: the length of a saved `heights` array.
CELL_COLUMN_COUNT :: (COLUMN_INSIDE_COUNT + COLUMN_OUTSIDE_COUNT) 
// `BlendingData.NO_VALUE` (`Float.MAX_VALUE`).
NO_VALUE :: f32::MAX
// `Blender.HEIGHT_BLENDING_RANGE_CELLS`: `QuartPos.fromSection(7) - 1`.
HEIGHT_BLENDING_RANGE_CELLS :: 4 * 7 - 1
// `Blender.HEIGHT_BLENDING_RANGE_CHUNKS`: `QuartPos.toSection(cells + 3)`.
HEIGHT_BLENDING_RANGE_CHUNKS :: (HEIGHT_BLENDING_RANGE_CELLS + 3) >> 2
// `Blender.DENSITY_BLENDING_RANGE_CHUNKS`: `QuartPos.toSection(5)`.
DENSITY_BLENDING_RANGE_CHUNKS :: 5 >> 2

// `CompositeDirection.Direction8` in its declaration order.
Direction8 :: enum {
    North,
    NorthEast,
    East,
    SouthEast,
    South,
    SouthWest,
    West,
    NorthWest,
}
    // rust: impl Direction8 {
    // rust: pub const ALL: [Self; 8] = [
    // rust: Self::North,
    // rust: Self::NorthEast,
    // rust: Self::East,
    // rust: Self::SouthEast,
    // rust: Self::South,
    // rust: Self::SouthWest,
    // rust: Self::West,
    // rust: Self::NorthWest,
    // rust: ];
step :: proc(self: ^Self) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::North => (0, -1),
    // rust: Self::NorthEast => (1, -1),
    // rust: Self::East => (1, 0),
    // rust: Self::SouthEast => (1, 1),
    // rust: Self::South => (0, 1),
    // rust: Self::SouthWest => (-1, 1),
    // rust: Self::West => (-1, 0),
    // rust: Self::NorthWest => (-1, -1),
}
}
bit :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: 1 << Self::ALL.iter().position(|d| *d == self).unwrap()
}
}

// The directions of `Direction8` a chunk's neighbour is in, as a set.
Sides :: struct {
    // rust: impl Sides {
insert :: proc(self: ^Self, side: Direction8) {
}
    // rust: self.0 |= side.bit();
}
contains :: proc(self: ^Self, side: Direction8) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.0 & side.bit() != 0
}
}

// What `BlendingData` reads of an old chunk (`ChunkAccess`), with x and z
// relative to the chunk and y absolute.
    // rust: pub trait OldChunk {
    // `hasPrimedHeightmap(WORLD_SURFACE_WG)`.
has_surface_heightmap :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // `getHeight(WORLD_SURFACE_WG, x, z)`: the first free y above the surface.
surface_height :: proc(self: ^Self, x: i32, z: i32) -> i {
    // Ported from Horizon
    return {}
}
    // The block is one of `BlendingData.SURFACE_BLOCKS`.
is_surface_block :: proc(self: ^Self, x: i32, y: i32, z: i32) -> b {
    // Ported from Horizon
    return {}
}
    // `BlendingData.isGround`: not air, leaves, logs or a huge mushroom, and
    // with a collision shape.
is_ground :: proc(self: ^Self, x: i32, y: i32, z: i32) -> b {
    // Ported from Horizon
    return {}
}
    // `getNoiseBiome` at the quart column `(qx, qz)` of the chunk (0..4)
    // and absolute quart height `qy`.
noise_biome :: proc(self: ^Self, qx: i32, qy: i32, qz: i32) -> B {
    // Ported from Horizon
    return {}
}
}

// `BlendingData`: an old chunk's border heights, densities and biomes.
BlendingData :: struct {
    min_section: i32,
    max_section: i32,
    heights: [f32,
    densities: [Maybe([dynamic]f32),
    biomes: [Maybe([dynamic]BiomeId),
}

inside_index :: proc(x: i32, z: i32) -> u {
    // Ported from Horizon
    return {}
}
    // rust: (MAX_INSIDE - x + z) as usize
}
outside_index :: proc(x: i32, z: i32) -> u {
    // Ported from Horizon
    return {}
}
    // rust: (COLUMN_INSIDE_COUNT + x + MAX_OUTSIDE - z) as usize
}
zero_if_negative :: proc(value: i32) -> i {
    // Ported from Horizon
    return {}
}
    // rust: value & !(value >> 31)
}
index_x :: proc(index: uint) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let index = index as i32;
    // rust: if index < COLUMN_INSIDE_COUNT {
    // rust: return zero_if_negative(MAX_INSIDE - index);
}
    // rust: MAX_OUTSIDE - zero_if_negative(MAX_OUTSIDE - (index - COLUMN_INSIDE_COUNT))
}
index_z :: proc(index: uint) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let index = index as i32;
    // rust: if index < COLUMN_INSIDE_COUNT {
    // rust: return zero_if_negative(index - MAX_INSIDE);
}
    // rust: MAX_OUTSIDE - zero_if_negative(index - COLUMN_INSIDE_COUNT - MAX_OUTSIDE)
}
floor_f32 :: proc(value: f32) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let truncated = value as i32;
    // rust: if value < truncated as f32 {
    // rust: truncated - 1
    // rust: } else {
    // rust: truncated
}
}

    // rust: impl BlendingData {
    // `BlendingData.unpack`: the saved `blending_data` (`min_section`,
    // `max_section` and the optional `heights`).
unpack :: proc(min_section: i32, max_section: i32, heights: Maybe(^[f32])) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let mut all = [NO_VALUE; CELL_COLUMN_COUNT];
    // rust: if let Some(heights) = heights {
    // rust: if heights.len() != CELL_COLUMN_COUNT {
    // rust: return None;
}
    // rust: all.copy_from_slice(heights);
}
    // rust: Some(Self {
    // rust: min_section,
    // rust: max_section,
    // rust: heights: all,
    // rust: densities: Default::default(),
    // rust: biomes: Default::default(),
    // rust: })
}
    // `BlendingData.pack`: the saved form, `heights` only when one is set.
pack :: proc(self: ^Self) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let has_height = self.heights.iter().any(|h| *h != NO_VALUE);
    // rust: (
    // rust: self.min_section,
    // rust: self.max_section,
    // rust: has_height.then_some(self.heights),
    // rust: )
}
    // The lowest block y of the area the old generation covered.
min_y :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.min_section << 4
}
    // Its highest block y.
max_y :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: (self.max_section << 4) - 1
}
sections_count :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.max_section - self.min_section
}
height_blocks :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.sections_count() << 4
}
cell_count_per_column :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: (self.sections_count() * 2) as usize
}
quart_count_per_column :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: (self.sections_count() * 4) as usize
}
column_min_y :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.min_cell_y() + 1
}
min_cell_y :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.min_section * 2
}
cell_y_index :: proc(self: ^Self, cell_y: i32) -> i {
    // Ported from Horizon
    return {}
}
    // rust: cell_y - self.column_min_y()
}

    // `getOrUpdateBlendingData` + `calculateData`: the data with the border
    // columns read from `chunk`, which has `new_sides` (the neighbours that
    // are not old) around it.
calculated :: proc(chunk: ^dyn OldChunk, new_sides: Sides) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let has = |d| new_sides.contains(d);
    // rust: if has(Direction8::North) || has(Direction8::West) || has(Direction8::NorthWest) {
    // rust: self.add_values_for_column(inside_index(0, 0), chunk, 0, 0);
}
    // rust: if has(Direction8::North) {
    // rust: for i in 1..QUARTS_PER_SECTION {
    // rust: self.add_values_for_column(inside_index(i, 0), chunk, 4 * i, 0);
}
}
    // rust: if has(Direction8::West) {
    // rust: for i in 1..QUARTS_PER_SECTION {
    // rust: self.add_values_for_column(inside_index(0, i), chunk, 0, 4 * i);
}
}
    // rust: if has(Direction8::East) {
    // rust: for i in 1..QUARTS_PER_SECTION {
    // rust: self.add_values_for_column(outside_index(MAX_OUTSIDE, i), chunk, 15, 4 * i);
}
}
    // rust: if has(Direction8::South) {
    // rust: for i in 0..QUARTS_PER_SECTION {
    // rust: self.add_values_for_column(outside_index(i, MAX_OUTSIDE), chunk, 4 * i, 15);
}
}
    // rust: if has(Direction8::East) && has(Direction8::NorthEast) {
    // rust: self.add_values_for_column(outside_index(MAX_OUTSIDE, 0), chunk, 15, 0);
}
    // rust: if has(Direction8::East) && has(Direction8::South) && has(Direction8::SouthEast) {
    // rust: self.add_values_for_column(outside_index(MAX_OUTSIDE, MAX_OUTSIDE), chunk, 15, 15);
}
    // rust: self
}

add_values_for_column :: proc(self: ^Self, index: uint, chunk: ^dyn OldChunk, x: i32, z: i32) {
}
    // rust: if self.heights[index] == NO_VALUE {
    // rust: self.heights[index] = self.height_at_xz(chunk, x, z) as f32;
}
    // rust: self.densities[index] =
    // rust: Some(self.density_column(chunk, x, z, floor_f32(self.heights[index])));
    // rust: self.biomes[index] = Some(self.biome_column(chunk, x, z));
}

height_at_xz :: proc(self: ^Self, chunk: ^dyn OldChunk, x: i32, z: i32) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let max_y = self.max_y();
    // rust: let mut height = if chunk.has_surface_heightmap() {
    // rust: chunk.surface_height(x, z).min(max_y)
    // rust: } else {
    // rust: max_y
}
    // rust: let min_y = self.min_y();
    // rust: while height > min_y {
    // rust: if chunk.is_surface_block(x, height, z) {
    // rust: return height;
}
    // rust: height -= 1;
}
    // rust: min_y
}

density_column :: proc(self: ^Self, chunk: ^dyn OldChunk, x: i32, z: i32, height: i32) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let count = self.cell_count_per_column();
    // rust: let mut densities = vec![-1.0f32; count];
    // rust: let mut y = self.max_y() + 1;
    // rust: let read1 = |y: &mut i32| {
    // rust: *y -= 1;
    // rust: if chunk.is_ground(x, *y, z) {
    // rust: 1.0f32
    // rust: } else {
    // rust: -1.0f32
}
}
    // rust: let read7 = |y: &mut i32| {
    // rust: let mut sum = 0.0f32;
    // rust: for _ in 0..7 {
    // rust: sum += read1(y);
}
    // rust: sum
}
    // rust: let mut last7 = read7(&mut y);
    // rust: for cell in (0..count - 1).rev() {
    // rust: let one = read1(&mut y);
    // rust: let current7 = read7(&mut y);
    // rust: densities[cell] = (last7 + one + current7) / 15.0f32;
    // rust: last7 = current7;
}
    // rust: let highest = self.cell_y_index(height.div_euclid(8));
    // rust: if highest >= 0 && (highest as usize) < count - 1 {
    // rust: let in_cell = (height as f32 + 0.5f32) % 8.0f32 / 8.0f32;
    // rust: let amplitude = (1.0f32 - in_cell) / in_cell;
    // rust: let max = amplitude.max(1.0f32) * 0.25f32;
    // rust: densities[highest as usize + 1] = -amplitude / max;
    // rust: densities[highest as usize] = 1.0f32 / max;
}
    // rust: densities
}

biome_column :: proc(self: ^Self, chunk: ^dyn OldChunk, x: i32, z: i32) -> V {
    // Ported from Horizon
    return {}
}
    // rust: let min_quart = self.min_y() >> 2;
    // rust: (0..self.quart_count_per_column())
    // rust: .map(|i| chunk.noise_biome(x >> 2, i as i32 + min_quart, z >> 2))
    // rust: .collect()
}

    // `getHeight(cellX, cellY, cellZ)`.
height :: proc(self: ^Self, cell_x: i32, _cell_y: i32, cell_z: i32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: if cell_x == MAX_OUTSIDE || cell_z == MAX_OUTSIDE {
    // rust: self.heights[outside_index(cell_x, cell_z)]
    // rust: } else if cell_x != 0 && cell_z != 0 {
    // rust: NO_VALUE
    // rust: } else {
    // rust: self.heights[inside_index(cell_x, cell_z)]
}
}
column_density :: proc(self: ^Self, column: Maybe(^[dynamic]f32), cell_y: i32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let Some(column) = column else {
    // rust: return NO_VALUE;
}
    // rust: let index = self.cell_y_index(cell_y);
    // rust: if index >= 0 && (index as usize) < column.len() {
    // rust: column[index as usize] * 0.1f32
    // rust: } else {
    // rust: NO_VALUE
}
}
    // `getDensity(cellX, cellY, cellZ)`.
density :: proc(self: ^Self, cell_x: i32, cell_y: i32, cell_z: i32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: if cell_y == self.min_cell_y() {
    // rust: 0.1f32
    // rust: } else if cell_x == MAX_OUTSIDE || cell_z == MAX_OUTSIDE {
    // rust: self.column_density(
    // rust: self.densities[outside_index(cell_x, cell_z)].as_ref(),
    // rust: cell_y,
    // rust: )
    // rust: } else if cell_x != 0 && cell_z != 0 {
    // rust: NO_VALUE
    // rust: } else {
    // rust: self.column_density(
    // rust: self.densities[inside_index(cell_x, cell_z)].as_ref(),
    // rust: cell_y,
    // rust: )
}
}
    // rust: fn iterate_biomes(
    // rust: &self,
    // rust: min_cell_x: i32,
    // rust: quart_y: i32,
    // rust: min_cell_z: i32,
    // rust: mut consumer: impl FnMut(i32, i32, BiomeId),
    // rust: ) {
    // rust: let min_quart = self.min_y() >> 2;
    // rust: let max_quart = self.max_y() >> 2;
    // rust: if quart_y < min_quart || quart_y > max_quart {
    // rust: return;
}
    // rust: let quart_index = (quart_y - min_quart) as usize;
    // rust: for (i, column) in self.biomes.iter().enumerate() {
    // rust: if let Some(column) = column {
    // rust: consumer(
    // rust: min_cell_x + index_x(i),
    // rust: min_cell_z + index_z(i),
    // rust: column[quart_index],
    // rust: );
}
}
}
    // rust: fn iterate_heights(
    // rust: &self,
    // rust: min_cell_x: i32,
    // rust: min_cell_z: i32,
    // rust: mut consumer: impl FnMut(i32, i32, f32),
    // rust: ) {
    // rust: for (i, height) in self.heights.iter().enumerate() {
    // rust: if *height != NO_VALUE {
    // rust: consumer(min_cell_x + index_x(i), min_cell_z + index_z(i), *height);
}
}
}
    // rust: fn iterate_densities(
    // rust: &self,
    // rust: min_cell_x: i32,
    // rust: min_cell_z: i32,
    // rust: from_cell_y: i32,
    // rust: to_cell_y: i32,
    // rust: mut consumer: impl FnMut(i32, i32, i32, f32),
    // rust: ) {
    // rust: let min_cell_y = self.column_min_y();
    // rust: let min_index = 0.max(from_cell_y - min_cell_y);
    // rust: let max_index = (self.cell_count_per_column() as i32).min(to_cell_y - min_cell_y);
    // rust: for (i, column) in self.densities.iter().enumerate() {
    // rust: let Some(column) = column else { continue };
    // rust: let (x, z) = (min_cell_x + index_x(i), min_cell_z + index_z(i));
    // rust: for y in min_index..max_index {
    // rust: consumer(x, y + min_cell_y, z, column[y as usize] * 0.1f32);
}
}
}
}

// The old chunks around a chunk being generated: what `WorldGenRegion`
// tells `Blender.of` and the carving filter.
    // rust: pub trait OldWorld: Send + Sync {
    // `WorldGenRegion.isOldChunkAround`: a chunk within `range` of `center`
    // (a square) is old, as far as the storage can tell without reading it.
is_old_chunk_around :: proc(self: ^Self, center: ChunkPos, range: i32) -> b {
    // Ported from Horizon
    return {}
}
    // Whether the chunk at `x, z` is old, as `StructureCheck.tryLoadFromStorage` finds out:
    // from that chunk's record alone. A structure search asks this of one chunk per spacing
    // cell across thousands of cells; scanning each region it touched, as the blender does,
    // read every chunk an explored world saved there (#8669).
is_old_chunk :: proc(self: ^Self, x: i32, z: i32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.is_old_chunk_around(ChunkPos::new(x, z), 0)
}
    // The blending data of the old chunk at `x, z`, its border columns
    // calculated, or None for a chunk that is not old.
blending :: proc(self: ^Self, x: i32, z: i32) -> O {
    // Ported from Horizon
    return {}
}
    // The biomes an old chunk keeps (what the chunk stores, not what the
    // generator would make there), which its neighbours' surfaces read.
old_biomes :: proc(self: ^Self, x: i32, z: i32) -> O {
    // Ported from Horizon
    return {}
}
    // The structure starts an old chunk saved (`structures.starts`): each
    // structure's name and the union of its pieces' bounding boxes
    // (`[min x, min y, min z, max x, max y, max z]`). What the chunk saved
    // is what `getStructureAt` and `/locate` see there, not what this
    // generator would make.
saved_starts :: proc(self: ^Self, _x: i32, _z: i32) -> V {
    // Ported from Horizon
    return {}
}
    // rust: Vec::new()
}
}

// A structure start an old chunk saved (`structures.starts.<name>`).
SavedStart :: struct {
    name: string,
    // The union of the pieces' `BB`: `[min x, min y, min z, max x, max y, max z]`.
    bounds: Option<[i32,
    // The start's `Children`, as saved.
    pieces: [dynamic]crate::nbt::Tag,
}

// `Blender.BlendingOutput`.
BlendingOutput :: struct {
    alpha: f32,
    offset: f32,
}

// `Blender`: empty (`Blender.empty()`) when no old chunk is near.
Blender :: struct {
    height_and_biome: OpenMap<(ChunkPos,
    density: OpenMap<(ChunkPos,
    carving: Maybe(OldChunkDistance),
}

shift_noise :: proc() -> ^ {
    // Ported from Horizon
    return {}
}
NOISE :: std::sync::OnceLock::new()
    // rust: NOISE.get_or_init(|| {
    // rust: NormalNoise::create_parity(-3, &[1.0, 1.0, 1.0, 0.0])
    // rust: .expect("the default shift noise")
    // rust: .create(&mut XoroshiroRandom::new(42))
    // rust: .expect("the default shift noise")
    // rust: })
}

    // rust: impl Blender {
    // `Blender.empty`.
empty :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self::default()
}
is_empty :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.height_and_biome.is_empty() && self.density.is_empty() && self.carving.is_none()
}
    // `Blender.of`: the blender of the chunk at `center`.
of :: proc(world: ^dyn OldWorld, center: ChunkPos) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let range = HEIGHT_BLENDING_RANGE_CHUNKS;
    // rust: if !world.is_old_chunk_around(center, range) {
    // rust: return Self::empty();
}
    // rust: let around = |dx: i32, dz: i32| world.blending(center.x + dx, center.z + dz);
    // rust: let mut height_and_biome = OpenMap::default();
    // rust: let mut density = OpenMap::default();
    // rust: let max_dist_sq = (range + 1) * (range + 1);
    // rust: for dx in -range..=range {
    // rust: for dz in -range..=range {
    // rust: if dx * dx + dz * dz > max_dist_sq {
    // rust: continue;
}
    // rust: let Some(data) = around(dx, dz) else { continue };
    // rust: let pos = ChunkPos::new(center.x + dx, center.z + dz);
    // rust: height_and_biome.insert(pos.pack(), (pos, data.clone()));
    // rust: if dx.abs() <= DENSITY_BLENDING_RANGE_CHUNKS
    // rust: && dz.abs() <= DENSITY_BLENDING_RANGE_CHUNKS
    // rust: {
    // rust: density.insert(pos.pack(), (pos, data));
}
}
}
    // rust: let carving = OldChunkDistance::around(world, center);
    // rust: if height_and_biome.is_empty() && density.is_empty() && carving.is_none() {
    // rust: return Self::empty();
}
    // rust: Self {
    // rust: height_and_biome,
    // rust: density,
    // rust: carving,
}
}

    // `Blender.blendOffsetAndFactor(x, z)` for a block column.
blend_offset_and_factor :: proc(self: ^Self, block_x: i32, block_z: i32) -> B {
    // Ported from Horizon
    return {}
}
    // rust: if self.is_empty() {
    // rust: return BlendingOutput {
    // rust: alpha: 1.0,
    // rust: offset: 0.0,
}
}
    // rust: let cell_x = block_x >> 2;
    // rust: let cell_z = block_z >> 2;
    // rust: let fixed = self.blending_value(cell_x, 0, cell_z, BlendingData::height);
    // rust: if fixed != NO_VALUE {
    // rust: return BlendingOutput {
    // rust: alpha: 0.0,
    // rust: offset: height_to_offset(f64::from(fixed)) as f32,
}
}
    // rust: let mut total_weight = 0.0f64;
    // rust: let mut weighted_heights = 0.0f64;
    // rust: let mut closest = f64::INFINITY;
    // rust: for (pos, data) in self.height_and_biome.iter() {
    // rust: data.iterate_heights(pos.x << 2, pos.z << 2, |test_x, test_z, height| {
    // rust: let distance = length2(f64::from(cell_x - test_x), f64::from(cell_z - test_z));
    // rust: if !(distance > f64::from(HEIGHT_BLENDING_RANGE_CELLS)) {
    // rust: if distance < closest {
    // rust: closest = distance;
}
    // rust: let weight = 1.0 / (distance * distance * distance * distance);
    // rust: weighted_heights += f64::from(height) * weight;
    // rust: total_weight += weight;
}
    // rust: });
}
    // rust: if closest == f64::INFINITY {
    // rust: return BlendingOutput {
    // rust: alpha: 1.0,
    // rust: offset: 0.0,
}
}
    // rust: let average = weighted_heights / total_weight;
    // rust: let mut alpha = (closest / f64::from(HEIGHT_BLENDING_RANGE_CELLS + 1)).clamp(0.0, 1.0);
    // rust: alpha = 3.0 * alpha * alpha - 2.0 * alpha * alpha * alpha;
    // rust: BlendingOutput {
    // rust: alpha: alpha as f32,
    // rust: offset: height_to_offset(average) as f32,
}
}

    // `Blender.blendDensity`.
blend_density :: proc(self: ^Self, block_x: i32, block_y: i32, block_z: i32, noise: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: if self.is_empty() {
    // rust: return noise;
}
    // rust: let cell_x = block_x >> 2;
    // rust: let cell_y = block_y.div_euclid(8);
    // rust: let cell_z = block_z >> 2;
    // rust: let fixed = self.blending_value(cell_x, cell_y, cell_z, BlendingData::density);
    // rust: if fixed != NO_VALUE {
    // rust: return fixed;
}
    // rust: let mut total_weight = 0.0f64;
    // rust: let mut weighted = 0.0f64;
    // rust: let mut closest = f64::INFINITY;
    // rust: for (pos, data) in self.density.iter() {
    // rust: data.iterate_densities(
    // rust: pos.x << 2,
    // rust: pos.z << 2,
    // rust: cell_y - 1,
    // rust: cell_y + 1,
    // rust: |test_x, test_y, test_z, density| {
    // rust: let distance = length3(
    // rust: f64::from(cell_x - test_x),
    // rust: f64::from((cell_y - test_y) * 2),
    // rust: f64::from(cell_z - test_z),
    // rust: );
    // rust: if !(distance > 2.0) {
    // rust: if distance < closest {
    // rust: closest = distance;
}
    // rust: let weight = 1.0 / (distance * distance * distance * distance);
    // rust: weighted += f64::from(density) * weight;
    // rust: total_weight += weight;
}
    // rust: },
    // rust: );
}
    // rust: if closest == f64::INFINITY {
    // rust: return noise;
}
    // rust: let average = weighted / total_weight;
    // rust: let alpha = (closest / 3.0).clamp(0.0, 1.0);
    // rust: (average + alpha * (f64::from(noise) - average)) as f32
}

    // rust: fn blending_value(
    // rust: &self,
    // rust: cell_x: i32,
    // rust: cell_y: i32,
    // rust: cell_z: i32,
    // rust: getter: fn(&BlendingData, i32, i32, i32) -> f32,
    // rust: ) -> f32 {
    // rust: let chunk_x = cell_x >> 2;
    // rust: let chunk_z = cell_z >> 2;
    // rust: let min_x = cell_x & 3 == 0;
    // rust: let min_z = cell_z & 3 == 0;
    // rust: let mut value = self.value_in(getter, chunk_x, chunk_z, cell_x, cell_y, cell_z);
    // rust: if value == NO_VALUE {
    // rust: if min_x && min_z {
    // rust: value = self.value_in(getter, chunk_x - 1, chunk_z - 1, cell_x, cell_y, cell_z);
}
    // rust: if value == NO_VALUE {
    // rust: if min_x {
    // rust: value = self.value_in(getter, chunk_x - 1, chunk_z, cell_x, cell_y, cell_z);
}
    // rust: if value == NO_VALUE && min_z {
    // rust: value = self.value_in(getter, chunk_x, chunk_z - 1, cell_x, cell_y, cell_z);
}
}
}
    // rust: value
}
    // rust: fn value_in(
    // rust: &self,
    // rust: getter: fn(&BlendingData, i32, i32, i32) -> f32,
    // rust: chunk_x: i32,
    // rust: chunk_z: i32,
    // rust: cell_x: i32,
    // rust: cell_y: i32,
    // rust: cell_z: i32,
    // rust: ) -> f32 {
    // rust: match self
    // rust: .height_and_biome
    // rust: .get(ChunkPos::new(chunk_x, chunk_z).pack())
    // rust: {
    // rust: Some((_, data)) => getter(
    // rust: data,
    // rust: cell_x - (chunk_x << 2),
    // rust: cell_y,
    // rust: cell_z - (chunk_z << 2),
    // rust: ),
    // rust: None => NO_VALUE,
}
}

    // `Blender.getBiomeResolver`: the old chunks' biome at a quart position,
    // or None where the new generator's biome stands.
blend_biome :: proc(self: ^Self, quart_x: i32, quart_y: i32, quart_z: i32) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let mut closest = f32::INFINITY;
    // rust: let mut biome = None;
    // rust: for (pos, data) in self.height_and_biome.iter() {
    // rust: data.iterate_biomes(pos.x << 2, quart_y, pos.z << 2, |test_x, test_z, found| {
    // rust: let distance = length2_f32((quart_x - test_x) as f32, (quart_z - test_z) as f32);
    // rust: if !(distance > HEIGHT_BLENDING_RANGE_CELLS as f32) && distance < closest {
    // rust: biome = Some(found);
    // rust: closest = distance;
}
    // rust: });
}
    // rust: if closest == f32::INFINITY {
    // rust: return None;
}
    // rust: let shift = shift_noise().get3(f64::from(quart_x), 0.0, f64::from(quart_z)) * 12.0f32;
    // rust: let alpha = ((closest + shift) / (HEIGHT_BLENDING_RANGE_CELLS + 1) as f32).clamp(0.0, 1.0);
    // rust: if alpha > 0.5 { None } else { biome }
}

    // `Blender.getCarvingFilter`: whether a block is within 4 blocks of an
    // old chunk's area, after the shift noise moves it.
carving_filter :: proc(self: ^Self, x: i32, y: i32, z: i32) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let distance = self.carving.as_ref()?;
    // rust: let noise = shift_noise();
    // rust: let sx = f64::from(x)
    // rust: + 0.5
    // rust: + f64::from(noise.get3(f64::from(x), f64::from(y), f64::from(z)) * 4.0f32);
    // rust: let sy = f64::from(y)
    // rust: + 0.5
    // rust: + f64::from(noise.get3(f64::from(y), f64::from(z), f64::from(x)) * 4.0f32);
    // rust: let sz = f64::from(z)
    // rust: + 0.5
    // rust: + f64::from(noise.get3(f64::from(z), f64::from(x), f64::from(y)) * 4.0f32);
    // rust: Some(distance.distance(sx, sy, sz) < 4.0)
}
has_carving_filter :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.carving.is_some()
}

    // `Blender.OutputBuffer` for the columns of `volume`: the alpha and
    // offset fields of the density graph.
output_buffer :: proc(self: ^^Self, volume: DensityVolume) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let min_x = volume.minimum()[0] >> 2;
    // rust: let min_z = volume.minimum()[2] >> 2;
    // rust: let max_x = (volume.maximum()[0] >> 2) + 1;
    // rust: let max_z = (volume.maximum()[2] >> 2) + 1;
    // rust: let count_x = max_x - min_x + 1;
    // rust: let count_z = max_z - min_z + 1;
    // rust: let mut alphas = vec![0.0f32; (count_x * count_z) as usize];
    // rust: let mut offsets = alphas.clone();
    // rust: for z in 0..count_z {
    // rust: for x in 0..count_x {
    // rust: let output = self.blend_offset_and_factor((min_x + x) << 2, (min_z + z) << 2);
    // rust: alphas[(x + z * count_x) as usize] = output.alpha;
    // rust: offsets[(x + z * count_x) as usize] = output.offset;
}
}
    // rust: OutputBuffer {
    // rust: blender: self.clone(),
    // rust: min_cell_x: min_x,
    // rust: min_cell_z: min_z,
    // rust: count_x,
    // rust: count_z,
    // rust: alphas,
    // rust: offsets,
}
}
}

// fastutil's `Long2ObjectOpenHashMap`, for the order it walks its entries in:
// `Blender` adds floating point sums in that order, and a sum's last bits
// depend on it.
OpenMap :: struct {
    n: uint,
    keys: [dynamic]i64,
    values: [dynamic]Maybe(V),
    // The value of the key 0, which the table keeps apart (at index `n`).
    null_value: Maybe(V),
    size: uint,
    max_fill: uint,
}
    // rust: impl<V> Default for OpenMap<V> {
default :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: let n = Self::array_size(16);
    // rust: Self {
    // rust: n,
    // rust: keys: vec![0; n],
    // rust: values: (0..n).map(|_| None).collect(),
    // rust: null_value: None,
    // rust: size: 0,
    // rust: max_fill: Self::max_fill(n),
}
}
}
    // rust: impl<V> OpenMap<V> {
    // `HashCommon.arraySize(expected, 0.75F)`.
array_size :: proc(expected: uint) -> u {
    // Ported from Horizon
    return {}
}
    // rust: let wanted = (expected as f32 / 0.75f32).ceil() as u64;
    // rust: wanted.next_power_of_two().max(2) as usize
}
    // `HashCommon.maxFill(n, 0.75F)`.
max_fill :: proc(n: uint) -> u {
    // Ported from Horizon
    return {}
}
    // rust: ((n as f32 * 0.75f32).ceil() as usize).min(n - 1)
}
    // `HashCommon.mix(long)`.
mix :: proc(key: i64) -> u {
    // Ported from Horizon
    return {}
}
    // rust: let mut h = (key as u64).wrapping_mul(0x9E37_79B9_7F4A_7C15);
    // rust: h ^= h >> 32;
    // rust: (h ^ (h >> 16)) as u32 as usize
}
is_empty :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.size == 0
}
get :: proc(self: ^Self, key: i64) -> O {
    // Ported from Horizon
    return {}
}
    // rust: if key == 0 {
    // rust: return self.null_value.as_ref();
}
    // rust: let mask = self.n - 1;
    // rust: let mut pos = Self::mix(key) & mask;
    // rust: while self.keys[pos] != 0 {
    // rust: if self.keys[pos] == key {
    // rust: return self.values[pos].as_ref();
}
    // rust: pos = (pos + 1) & mask;
}
    // rust: None
}
insert :: proc(self: ^Self, key: i64, value: V) {
}
    // rust: if key == 0 {
    // rust: if self.null_value.is_some() {
    // rust: self.null_value = Some(value);
    // rust: return;
}
    // rust: self.null_value = Some(value);
    // rust: } else {
    // rust: let mask = self.n - 1;
    // rust: let mut pos = Self::mix(key) & mask;
    // rust: while self.keys[pos] != 0 {
    // rust: if self.keys[pos] == key {
    // rust: self.values[pos] = Some(value);
    // rust: return;
}
    // rust: pos = (pos + 1) & mask;
}
    // rust: self.keys[pos] = key;
    // rust: self.values[pos] = Some(value);
}
    // rust: let grow = self.size >= self.max_fill;
    // rust: self.size += 1;
    // rust: if grow {
    // rust: self.rehash(Self::array_size(self.size + 1));
}
}
rehash :: proc(self: ^Self, new_n: uint) {
}
    // rust: let mask = new_n - 1;
    // rust: let mut keys = vec![0i64; new_n];
    // rust: let mut values: Vec<Option<V>> = (0..new_n).map(|_| None).collect();
    // rust: let real = self.size - usize::from(self.null_value.is_some());
    // rust: let mut i = self.n;
    // rust: for _ in 0..real {
    // rust: loop {
    // rust: i -= 1;
    // rust: if self.keys[i] != 0 {
    // rust: break;
}
}
    // rust: let mut pos = Self::mix(self.keys[i]) & mask;
    // rust: while keys[pos] != 0 {
    // rust: pos = (pos + 1) & mask;
}
    // rust: keys[pos] = self.keys[i];
    // rust: values[pos] = self.values[i].take();
}
    // rust: self.n = new_n;
    // rust: self.keys = keys;
    // rust: self.values = values;
    // rust: self.max_fill = Self::max_fill(new_n);
}
    // The entries as `forEach` visits them: the key 0 first, then the table
    // from its end to its start.
iter :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.null_value.iter().chain(
    // rust: (0..self.n)
    // rust: .rev()
    // rust: .filter(|&pos| self.keys[pos] != 0)
    // rust: .filter_map(|pos| self.values[pos].as_ref()),
    // rust: )
}
}

height_to_offset :: proc(height: f64) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let target_y = height + 0.5;
    // rust: let modulo = (target_y % 8.0 + 8.0) % 8.0;
    // rust: 1.0 * (32.0 * (target_y - 128.0) - 3.0 * (target_y - 120.0) * modulo + 3.0 * modulo * modulo)
    // rust: / (128.0 * (32.0 - 3.0 * modulo))
}
length2 :: proc(x: f64, z: f64) -> f {
    // Ported from Horizon
    return {}
}
    // rust: (x * x + z * z).sqrt()
}
length2_f32 :: proc(x: f32, z: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: (x * x + z * z).sqrt()
}
length3 :: proc(x: f64, y: f64, z: f64) -> f {
    // Ported from Horizon
    return {}
}
    // rust: (x * x + y * y + z * z).sqrt()
}

    // rust: impl DensityBlender for Blender {
is_empty :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: Blender::is_empty(self)
}
blend_density :: proc(self: ^Self, z]: [i32; 3], input: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: Blender::blend_density(self, x, y, z, input)
}
}

// `Blender.OutputBuffer`: the alpha and offset of each quart column of a
// volume, and of any other column on demand.
OutputBuffer :: struct {
    blender: ^Blender,
    min_cell_x: i32,
    min_cell_z: i32,
    count_x: i32,
    count_z: i32,
    alphas: [dynamic]f32,
    offsets: [dynamic]f32,
}
    // rust: impl OutputBuffer {
index :: proc(self: ^Self, block_x: i32, block_z: i32) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let x = (block_x >> 2) - self.min_cell_x;
    // rust: let z = (block_z >> 2) - self.min_cell_z;
    // rust: (x >= 0 && z >= 0 && x < self.count_x && z < self.count_z)
    // rust: .then(|| (x + z * self.count_x) as usize)
}
alpha :: proc(self: ^Self, block_x: i32, block_z: i32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: match self.index(block_x, block_z) {
    // rust: Some(i) => self.alphas[i],
    // rust: None => self.blender.blend_offset_and_factor(block_x, block_z).alpha,
}
}
offset :: proc(self: ^Self, block_x: i32, block_z: i32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: match self.index(block_x, block_z) {
    // rust: Some(i) => self.offsets[i],
    // rust: None => {
    // rust: self.blender
    // rust: .blend_offset_and_factor(block_x, block_z)
    // rust: .offset
}
}
}
}

// `OutputBuffer.createAlphaSampler` / `createOffsetSampler`.
BlendFieldSampler :: struct {
    buffer: ^OutputBuffer,
    offset: bool,
}
    // rust: impl DensitySampler for BlendFieldSampler {
    // rust: fn sample_value(
    // rust: &self,
    // rust: _: &mut SamplerContext,
    // rust: [x, _, z]: [i32; 3],
    // rust: ) -> Result<f32, SampleError> {
    // rust: Ok(if self.offset {
    // rust: self.buffer.offset(x, z)
    // rust: } else {
    // rust: self.buffer.alpha(x, z)
    // rust: })
}
}

// `Blender.makeOldChunkDistanceGetter`: the distance to the nearest old
// chunk's box (the chunk itself and its eight neighbours).
OldChunkDistance :: struct {
    // `(offset x, offset z, centre y, radius y)` per old chunk.
    boxes: Vec<(f64,
}
    // rust: impl OldChunkDistance {
around :: proc(world: ^dyn OldWorld, center: ChunkPos) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let mut boxes = Vec::new();
    // rust: let mut add = |offset: (f64, f64), data: &BlendingData| {
    // rust: let radius_y = f64::from(data.height_blocks()) / 2.0;
    // rust: boxes.push((
    // rust: offset.0,
    // rust: offset.1,
    // rust: f64::from(data.min_y()) + radius_y,
    // rust: radius_y,
    // rust: ));
}
        // `centerBlendingData` first, then the neighbours in `Direction8` order.
    // rust: if let Some(data) = world.blending(center.x, center.z) {
    // rust: add((0.0, 0.0), &data);
}
    // rust: for side in Direction8::ALL {
    // rust: let (dx, dz) = side.step();
    // rust: if let Some(data) = world.blending(center.x + dx, center.z + dz) {
    // rust: add((f64::from(dx * 16), f64::from(dz * 16)), &data);
}
}
    // rust: (!boxes.is_empty()).then_some(Self { boxes })
}
distance :: proc(self: ^Self, x: f64, y: f64, z: f64) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let mut closest = f64::INFINITY;
    // rust: for &(offset_x, offset_z, center_y, radius_y) in &self.boxes {
    // rust: let dx = ((x - 8.0 - offset_x).abs() - 8.0).max(0.0);
    // rust: let dy = ((y - center_y).abs() - radius_y).max(0.0);
    // rust: let dz = ((z - 8.0 - offset_z).abs() - 8.0).max(0.0);
    // rust: let distance = length3(dx, dy, dz);
    // rust: if distance < closest {
    // rust: closest = distance;
}
}
    // rust: closest
}
}

    // rust: mod tests {
//     use super::*;

the_column_indices_walk_the_border_of_the_chunk :: proc() {
}
        // `getX`/`getZ` undo `getInsideIndex`/`getOutsideIndex`.
    // rust: for x in 0..4 {
    // rust: assert_eq!(
    // rust: (index_x(inside_index(x, 0)), index_z(inside_index(x, 0))),
    // rust: (x, 0)
    // rust: );
}
    // rust: for z in 0..4 {
    // rust: assert_eq!(
    // rust: (index_x(inside_index(0, z)), index_z(inside_index(0, z))),
    // rust: (0, z)
    // rust: );
}
    // rust: for i in 0..=4 {
    // rust: assert_eq!(
    // rust: (index_x(outside_index(i, 4)), index_z(outside_index(i, 4))),
    // rust: (i, 4)
    // rust: );
    // rust: assert_eq!(
    // rust: (index_x(outside_index(4, i)), index_z(outside_index(4, i))),
    // rust: (4, i)
    // rust: );
}
    // rust: assert_eq!(CELL_COLUMN_COUNT, 16);
    // rust: assert_eq!(HEIGHT_BLENDING_RANGE_CHUNKS, 7);
}

the_open_map_keeps_every_entry_as_it_grows :: proc() {
}
    // rust: let mut map = OpenMap::default();
    // rust: for i in 0..200i64 {
    // rust: map.insert(
    // rust: ChunkPos::new((i % 17) as i32 - 8, (i / 17) as i32 - 5).pack(),
    // rust: i,
    // rust: );
}
    // rust: assert_eq!(map.iter().count(), 200);
    // rust: assert_eq!(map.get(ChunkPos::new(0, 0).pack()), Some(&(8 + 5 * 17)));
    // rust: let mut seen: Vec<i64> = map.iter().copied().collect();
    // rust: seen.sort_unstable();
    // rust: assert_eq!(seen, (0..200).collect::<Vec<_>>());
}

a_blender_without_old_chunks_changes_nothing :: proc() {
}
    // rust: let blender = Blender::empty();
    // rust: assert_eq!(
    // rust: blender.blend_offset_and_factor(5, 9),
    // rust: BlendingOutput {
    // rust: alpha: 1.0,
    // rust: offset: 0.0
}
    // rust: );
    // rust: assert_eq!(blender.blend_density(1, 2, 3, 0.25), 0.25);
    // rust: assert!(blender.blend_biome(1, 2, 3).is_none());
}
}
