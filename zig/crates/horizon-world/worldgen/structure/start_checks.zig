//! Transpiled from Horizon Rust crate
//! Module: horizon-world_start_checks
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Start rules a carried structure mod adds on top of vanilla's jigsaw.
//!
//! Repurposed Structures and Moog's Structure Lib give their jigsaw
//! structures checks that run before the pieces are laid out: every biome
//! in a radius must be one the structure allows, the start column may not
//! end in liquid, and the terrain in a radius must lie within a height range.
//! Carry (`horizon-port-pack`) maps those structures to `minecraft:jigsaw`
//! and writes the checks under `"horizon:start_checks"`; vanilla data never
//! has the key, so vanilla structures are unchanged.
//!
//! ```json
//! "horizon:start_checks": {
//!   "biome_radius": 2,        // chunks; every noise biome must be allowed
//!   "liquid": "top",          // "top": the column's highest block; "lowest": the block above min_y
//!   "terrain_radius": 1,      // chunks, with terrain_range and/or min_y, max_y
//!   "terrain_range": 15,
//!   "min_y": 60,
//!   "max_y": 200,
//!   "repurposed": "city_nether" // or "shipwreck_nether", "stronghold_end": below
//! }
//! ```
//!
//! `repurposed` is the extra check of one of Repurposed Structures' jigsaw
//! types, after the others: its Nether city needs open air above the lava sea
//! in the chunks around, its Nether shipwreck open air or lava around the
//! start, and its End stronghold land around the chunk.
// use crate::{heightmap::HeightmapType, worldgen::biome::BiomeId};
// use horizon_core::position::ChunkPos;
// use serde_json::Value;
// use std::collections::BTreeSet;

/// Which block of the start column must not be a liquid.
pub const LiquidCheck = enum {
    /// The highest non-air block of the noise column (Moog's).
    Top,
    /// The block above the column's bottom (Repurposed Structures: its loop
    /// keeps the last block it reads, not the first solid one).
    Lowest,
};

/// The extra start check of a Repurposed Structures jigsaw type.
pub const Repurposed = enum {
    /// CityNetherStructure: air from sea level + 20 to + 45 (or the top of
    /// the noise) at the corner of each of the 8 chunks around.
    CityNether,
    /// ShipwreckNetherStructure: no solid block at 5×5 columns 8 apart
    /// around the chunk corner, from the start height up 30 in steps of 5.
    ShipwreckNether,
    /// StrongholdEndStructure: land at least 45 above the bottom 35 and 70
    /// blocks away in each direction and at the chunk corner.
    StrongholdEnd,
};

/// The checks of one structure; all empty for vanilla's.
pub const StartChecks = struct {
    biome_radius: ?i32,
    liquid: ?LiquidCheck,
    terrain_radius: ?i32,
    terrain_range: ?i32,
    min_y: ?i32,
    max_y: ?i32,
    repurposed: ?Repurposed,
};

/// The column and biome queries the checks need.
    // rust: pub trait CheckQueries {
    /// ChunkGenerator.getFirstFreeHeight.
pub fn first_free_height(self: *Self, x: i32, z: i32, kind: HeightmapType) i;
    /// The noise column at (`x`, `z`) as (not air, blocks motion) per block
    /// from the noise's bottom up: in a noise column a block that is not air
    /// and does not block motion is a liquid.
pub fn liquid_column(self: *Self, x: i32, z: i32) (;
pub fn noise_biome(self: *Self, quart: [i32; 3]) B;
pub fn sea_level(self: *Self) i;
    /// The noise's bottom, where the columns start.
pub fn bottom(self: *Self) i;
}

    // rust: impl<T: super::start::StartContext> CheckQueries for T {
pub fn first_free_height(self: *Self, x: i32, z: i32, kind: HeightmapType) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.base_height(x, z, kind)
}
pub fn liquid_column(self: *Self, x: i32, z: i32) ( {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let mut columns = self.base_columns(
    // rust: x,
    // rust: z,
    // rust: &[HeightmapType::WorldSurfaceWg, HeightmapType::OceanFloorWg],
    // rust: );
    // rust: let solid = columns.pop().unwrap_or_default();
    // rust: (columns.pop().unwrap_or_default(), solid)
}
pub fn noise_biome(self: *Self, quart: [i32; 3]) B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: super::start::StartContext::noise_biome(self, quart)
}
pub fn sea_level(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: super::start::StartContext::sea_level(self)
}
pub fn bottom(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.min_y()
}
}

    // rust: impl StartChecks {
    /// `"horizon:start_checks"` of a structure, or none.
pub fn decode(value: ?*Value) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let Some(v) = value else {
    // rust: return Self::default();
}
    // rust: let int = |k: &str| v.get(k).and_then(Value::as_i64).map(|n| n as i32);
    // rust: Self {
    // rust: biome_radius: int("biome_radius"),
    // rust: liquid: match v.get("liquid").and_then(Value::as_str) {
    // rust: Some("top") => Some(LiquidCheck::Top),
    // rust: Some("lowest") => Some(LiquidCheck::Lowest),
    // rust: _ => None,
    // rust: },
    // rust: terrain_radius: int("terrain_radius"),
    // rust: terrain_range: int("terrain_range"),
    // rust: min_y: int("min_y"),
    // rust: max_y: int("max_y"),
    // rust: repurposed: match v.get("repurposed").and_then(Value::as_str) {
    // rust: Some("city_nether") => Some(Repurposed::CityNether),
    // rust: Some("shipwreck_nether") => Some(Repurposed::ShipwreckNether),
    // rust: Some("stronghold_end") => Some(Repurposed::StrongholdEnd),
    // rust: _ => None,
    // rust: },
}
}

    /// GenericJigsawStructure.extraSpawningChecks: whether the structure may
    /// start in `chunk` at `y` (the sampled start height).
    // rust: pub fn pass(
    // rust: &self,
    // rust: queries: &mut impl CheckQueries,
    // rust: biomes: &BTreeSet<BiomeId>,
    // rust: chunk: ChunkPos,
    // rust: y: i32,
    // rust: project_to: Option<HeightmapType>,
    // rust: ) -> bool {
    // rust: let (x0, z0) = (chunk.x * 16, chunk.z * 16);
    // rust: if let Some(radius) = self.biome_radius {
    // rust: let mut section_y = y;
    // rust: if let Some(kind) = project_to {
    // rust: section_y += queries.first_free_height(x0 + 7, z0 + 7, kind) - 1;
}
    // rust: for cx in chunk.x - radius..=chunk.x + radius {
    // rust: for cz in chunk.z - radius..=chunk.z + radius {
    // rust: if !biomes.contains(&queries.noise_biome([cx << 2, section_y >> 2, cz << 2])) {
    // rust: return false;
}
}
}
}
    // rust: if let Some(check) = self.liquid {
    // rust: let (filled, solid) = queries.liquid_column(x0 + 7, z0 + 7);
            // From the top down to the block above the bottom, as the mods loop.
    // rust: let index = match check {
    // rust: LiquidCheck::Top => (1..filled.len()).rev().find(|&i| filled[i]),
    // rust: LiquidCheck::Lowest => Some(1).filter(|&i| i < filled.len()),
}
    // rust: if index.is_some_and(|i| filled[i] && !solid[i]) {
    // rust: return false;
}
}
    // rust: if let Some(radius) = self
    // rust: .terrain_radius
    // rust: .filter(|_| self.terrain_range.is_some() || self.min_y.is_some())
    // rust: {
    // rust: let kind = project_to.unwrap_or(HeightmapType::WorldSurfaceWg);
    // rust: let (mut highest, mut lowest) = (i32::MIN, i32::MAX);
    // rust: for cx in chunk.x - radius..=chunk.x + radius {
    // rust: for cz in chunk.z - radius..=chunk.z + radius {
    // rust: let height = queries.first_free_height((cx << 4) + 7, (cz << 4) + 7, kind);
    // rust: highest = highest.max(height);
    // rust: lowest = lowest.min(height);
                    // Both bounds test the lowest height so far, as the mods do.
    // rust: if self.min_y.is_some_and(|m| lowest < m)
    // rust: || self.max_y.is_some_and(|m| lowest > m)
    // rust: {
    // rust: return false;
}
}
}
    // rust: if self
    // rust: .terrain_range
    // rust: .is_some_and(|range| highest - lowest > range)
    // rust: {
    // rust: return false;
}
}
    // rust: match self.repurposed {
    // rust: Some(check) => repurposed(check, queries, chunk, y),
    // rust: None => true,
}
}
}

/// [`Repurposed`]'s checks. A noise column reads air past its ends; its
/// length is the noise's depth (GeneralUtils.getMaxTerrainLimit).
pub fn repurposed(check: Repurposed, queries: *mut impl CheckQueries, chunk: ChunkPos, y: i32) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let (x0, z0) = (chunk.x * 16, chunk.z * 16);
    // rust: let bottom = queries.bottom();
    // rust: let at = |column: &[bool], y: i32| {
    // rust: usize::try_from(y - bottom)
    // rust: .ok()
    // rust: .and_then(|i| column.get(i).copied())
    // rust: .unwrap_or(false)
}
    // rust: match check {
    // rust: Repurposed::CityNether => {
    // rust: let sea = queries.sea_level();
    // rust: for cx in chunk.x - 1..=chunk.x + 1 {
    // rust: for cz in chunk.z - 1..=chunk.z + 1 {
    // rust: if (cx, cz) == (chunk.x, chunk.z) {
    // rust: continue;
}
    // rust: let (filled, _) = queries.liquid_column(cx << 4, cz << 4);
    // rust: let top = (bottom + filled.len() as i32).min(sea + 45);
    // rust: if (sea + 20..top).any(|y| at(&filled, y)) {
    // rust: return false;
}
}
}
    // rust: true
}
    // rust: Repurposed::ShipwreckNether => {
    // rust: for dx in (-16..=16).step_by(8) {
    // rust: for dz in (-16..=16).step_by(8) {
    // rust: let (filled, solid) = queries.liquid_column(x0 + dx, z0 + dz);
                    // Not air and no fluid: in a noise column, a solid block.
    // rust: if (0..=30)
    // rust: .step_by(5)
    // rust: .any(|dy| at(&filled, y + dy) && at(&solid, y + dy))
    // rust: {
    // rust: return false;
}
}
}
    // rust: true
}
    // rust: Repurposed::StrongholdEnd => {
    // rust: let (filled, _) = queries.liquid_column(x0, z0);
    // rust: let min_land = (bottom + filled.len() as i32).min(bottom + 45);
            // getHeightAt: the lowest height so far, less one at every sample.
    // rust: let mut land = i32::MAX;
    // rust: let mut sample = |x: i32, z: i32, land: &mut i32| {
    // rust: let h = queries.first_free_height(x, z, HeightmapType::WorldSurfaceWg);
    // rust: *land = (*land).min(h) - 1;
    // rust: *land >= min_land
}
    // rust: for distance in [70, 35] {
                // Direction.Plane.HORIZONTAL: north, east, south, west.
    // rust: for (dx, dz) in [(0, -1), (1, 0), (0, 1), (-1, 0)] {
    // rust: if !sample(x0 + dx * distance, z0 + dz * distance, &mut land) {
    // rust: return false;
}
}
}
    // rust: sample(x0, z0, &mut land)
}
}
}

    // rust: mod tests {
//     use super::*;
//     use serde_json::json;
//     use std::collections::BTreeMap;

    /// Heights per (x, z), a liquid column, one biome per quart column.
pub const Fake = struct {
    heights: BTreeMap<(i32,
    column: std.ArrayList(char),
    biomes: BTreeMap<(i32,
    asked: Vec<[i32,
        /// Columns by (x, z), instead of `column`, from y 0.
    columns: BTreeMap<(i32,
};
    // rust: impl CheckQueries for Fake {
pub fn first_free_height(self: *Self, x: i32, z: i32, _: HeightmapType) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.heights.get(&(x, z)).copied().unwrap_or(64)
}
pub fn liquid_column(self: *Self, x: i32, z: i32) ( {
    // Implementation ported from Horizon
    return undefined;
}
            // '.' air, '#' stone, '~' water, from the bottom up.
    // rust: let column = self.columns.get(&(x, z)).unwrap_or(&self.column);
    // rust: (
    // rust: column.iter().map(|&c| c != '.').collect(),
    // rust: column.iter().map(|&c| c == '#').collect(),
    // rust: )
}
pub fn sea_level(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: 32
}
pub fn bottom(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: 0
}
pub fn noise_biome(self: *Self, quart: [i32; 3]) B {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.asked.push(quart);
    // rust: BiomeId(self.biomes.get(&(quart[0], quart[2])).copied().unwrap_or(1))
}
}
pub fn checks(v: Value) S {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: StartChecks::decode(Some(&v))
}
pub const CHUNK: ChunkPos = ChunkPos { x: 2, z: -1 };

pub fn vanilla_structures_pass_everything() void {
}
    // rust: let mut fake = Fake {
    // rust: column: "#~~.".chars().collect(),
    // rust: ..Fake::default()
}
    // rust: let none = StartChecks::decode(None);
    // rust: assert_eq!(none, StartChecks::default());
    // rust: assert!(none.pass(&mut fake, &BTreeSet::new(), CHUNK, 0, None));
    // rust: assert!(fake.asked.is_empty());
}

pub fn every_biome_in_the_radius_must_be_allowed() void {
}
    // rust: let allowed = BTreeSet::from([BiomeId(1)]);
    // rust: let mut fake = Fake::default();
    // rust: fake.heights.insert((39, -9), 70);
    // rust: let c = checks(json!({"biome_radius": 1}));
    // rust: assert!(c.pass(
    // rust: &mut fake,
    // rust: &allowed,
    // rust: CHUNK,
    // rust: 10,
    // rust: Some(HeightmapType::WorldSurfaceWg)
    // rust: ));
        // Section y: start height plus the projected height minus one, in quarts.
    // rust: assert_eq!(fake.asked.len(), 9);
    // rust: assert!(fake.asked.iter().all(|q| q[1] == (10 + 70 - 1) >> 2));
    // rust: assert_eq!(fake.asked[0], [4, 19, -8]);
    // rust: fake.biomes.insert((12, 0), 2); // chunk (3, 0), the radius' corner
    // rust: assert!(!c.pass(&mut fake, &allowed, CHUNK, 10, None));
}

pub fn liquid_checks_read_the_mods_block() void {
}
    // rust: let top = checks(json!({"liquid": "top"}));
    // rust: let lowest = checks(json!({"liquid": "lowest"}));
    // rust: let none = BTreeSet::new();
    // rust: let mut ocean = Fake {
    // rust: column: "##~~~..".chars().collect(),
    // rust: ..Fake::default()
}
    // rust: assert!(!top.pass(&mut ocean, &none, CHUNK, 0, None));
    // rust: assert!(lowest.pass(&mut ocean, &none, CHUNK, 0, None));
    // rust: let mut land = Fake {
    // rust: column: "#~###..".chars().collect(),
    // rust: ..Fake::default()
}
    // rust: assert!(top.pass(&mut land, &none, CHUNK, 0, None));
    // rust: assert!(!lowest.pass(&mut land, &none, CHUNK, 0, None));
        // The bottom block itself is never read; an empty column passes.
    // rust: let mut empty = Fake {
    // rust: column: "~....".chars().collect(),
    // rust: ..Fake::default()
}
    // rust: assert!(top.pass(&mut empty, &none, CHUNK, 0, None));
}

pub fn terrain_must_lie_within_its_range() void {
}
    // rust: let none = BTreeSet::new();
    // rust: let mut fake = Fake::default();
        // Chunk centres around (2, -1): x 23, 39, 55; z -25, -9, 7.
    // rust: fake.heights.insert((23, -25), 60);
    // rust: fake.heights.insert((55, 7), 75);
    // rust: let range = |r: i32| checks(json!({"terrain_radius": 1, "terrain_range": r}));
    // rust: assert!(range(15).pass(&mut fake, &none, CHUNK, 0, None));
    // rust: assert!(!range(14).pass(&mut fake, &none, CHUNK, 0, None));
        // The radius alone, or with only max_y, checks nothing.
    // rust: assert!(
    // rust: checks(json!({"terrain_radius": 1, "max_y": 0})).pass(&mut fake, &none, CHUNK, 0, None)
    // rust: );
    // rust: let bounds =
    // rust: |min: i32, max: i32| checks(json!({"terrain_radius": 1, "min_y": min, "max_y": max}));
    // rust: assert!(bounds(60, 64).pass(&mut fake, &none, CHUNK, 0, None));
    // rust: assert!(!bounds(61, 100).pass(&mut fake, &none, CHUNK, 0, None));
        // max_y is compared with the lowest height so far: 75 never fails it.
    // rust: assert!(bounds(0, 64).pass(&mut fake, &none, CHUNK, 0, None));
    // rust: assert!(!bounds(0, 59).pass(&mut fake, &none, CHUNK, 0, None));
}

    /// A column of `n` blocks: `fill` up to `top` (exclusive), air above.
pub fn column(n: usize, top: usize, fill: char) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: (0..n).map(|y| if y < top { fill } else { '.' }).collect()
}

pub fn repurposed_city_needs_air_above_the_lava_sea_around() void {
}
    // rust: let none = BTreeSet::new();
    // rust: let city = checks(json!({"repurposed": "city_nether"}));
        // Sea 32: air needed from 52 to 76 (128 deep), in the 8 chunks around.
    // rust: let mut fake = Fake {
    // rust: column: column(128, 52, '#'),
    // rust: ..Fake::default()
}
        // The chunk itself is not read.
    // rust: fake.columns.insert((32, -16), column(128, 100, '#'));
    // rust: assert!(city.pass(&mut fake, &none, CHUNK, 33, None));
    // rust: fake.columns.insert((48, 0), column(128, 53, '#'));
    // rust: assert!(!city.pass(&mut fake, &none, CHUNK, 33, None));
        // Above sea + 45 nothing is read.
    // rust: fake.columns.insert((48, 0), {
    // rust: let mut c = column(128, 52, '#');
    // rust: c[77] = '#';
    // rust: c
    // rust: });
    // rust: assert!(city.pass(&mut fake, &none, CHUNK, 33, None));
}

pub fn repurposed_shipwreck_needs_no_solid_block_around() void {
}
    // rust: let none = BTreeSet::new();
    // rust: let wreck = checks(json!({"repurposed": "shipwreck_nether"}));
        // Lava up to 40, air above: the samples at 28..=58 meet only lava and air.
    // rust: let mut fake = Fake {
    // rust: column: column(128, 40, '~'),
    // rust: ..Fake::default()
}
    // rust: assert!(wreck.pass(&mut fake, &none, CHUNK, 28, None));
        // Netherrack at y 43, between samples (28 + 15, + 20 are 43, 48).
    // rust: let mut rock = column(128, 40, '~');
    // rust: rock[43] = '#';
    // rust: fake.columns.insert((32 - 16, -16 + 16), rock.clone());
    // rust: assert!(!wreck.pass(&mut fake, &none, CHUNK, 28, None));
    // rust: rock[43] = '.';
    // rust: rock[44] = '#';
    // rust: fake.columns.insert((16, 0), rock);
    // rust: assert!(wreck.pass(&mut fake, &none, CHUNK, 28, None));
}

pub fn repurposed_end_stronghold_needs_land_around() void {
}
    // rust: let none = BTreeSet::new();
    // rust: let end = checks(json!({"repurposed": "stronghold_end"}));
    // rust: let mut fake = Fake {
    // rust: column: column(256, 0, '#'),
    // rust: ..Fake::default()
}
        // Every height 64 by default: 63, 62, ... 55 after the 9 samples.
    // rust: assert!(end.pass(&mut fake, &none, CHUNK, 0, None));
        // Land at least 45 above the bottom, after the sample's minus one:
        // 46 at the corner passes, 45 fails.
    // rust: fake.heights.insert((32, -16), 46);
    // rust: assert!(end.pass(&mut fake, &none, CHUNK, 0, None));
    // rust: fake.heights.insert((32, -16), 45);
    // rust: assert!(!end.pass(&mut fake, &none, CHUNK, 0, None));
        // Void 70 blocks north fails at once.
    // rust: fake.heights.clear();
    // rust: fake.heights.insert((32, -86), 0);
    // rust: assert!(!end.pass(&mut fake, &none, CHUNK, 0, None));
}
}
