//! Transpiled from Horizon Rust crate
package horizon_world_start

import "core:fmt"
import "core:mem"
import "core:math"

// Structures, structure sets and their placements, structure starts,
// references, terrain adaptation and per-chunk piece placement.
// use super::{
    // rust: BoundingBox, StructureResources,
    // rust: jigsaw::{
    // rust: JigsawConfig, JigsawContext, PlaceFeature, PoolPiece, Pools, Projection, lay_out_children,
    // rust: place_start,
    // rust: },
    // rust: legacy::{LegacyPiece, PieceContext},
}
// use crate::{
    // rust: heightmap::HeightmapType,
    // rust: worldgen::{
    // rust: DecodeError,
    // rust: anchor::WorldGenerationContext,
    // rust: biome::BiomeId,
    // rust: block_feature::FeatureBlockBindings,
    // rust: feature::FeatureWorld,
    // rust: height_provider::HeightProvider,
    // rust: placement::{PlacementContext, PlacementQueryError},
    // rust: weighted::WeightedList,
    // rust: },
}
// use horizon_core::{
    // rust: density::{Beardifier, JigsawJunction, RigidPiece, StructureBounds, TerrainAdjustment},
    // rust: position::{BlockPos, ChunkPos},
    // rust: random::{LegacyRandom, PositionalRandom, RandomSource, WorldgenRandom},
}
// use serde_json::{Value, value::RawValue};
// use std::{
    // rust: collections::{BTreeMap, BTreeSet},
    // rust: sync::Arc,
}

    // rust: pub const STEPS: [&str; 11] = [
    // rust: "raw_generation",
    // rust: "lakes",
    // rust: "local_modifications",
    // rust: "underground_structures",
    // rust: "surface_structures",
    // rust: "strongholds",
    // rust: "underground_ores",
    // rust: "underground_decoration",
    // rust: "fluid_springs",
    // rust: "vegetal_decoration",
    // rust: "top_layer_modification",
    // rust: ];

JigsawDef :: struct {
    start_pool: string,
    start_jigsaw: Maybe(string),
    max_depth: i32,
    start_height: HeightProvider,
    use_expansion_hack: bool,
    project_to: Maybe(HeightmapType),
    max_distance: [i32,
    aliases: [dynamic]Value,
    padding: [i32,
    waterlogging: bool,
    // A carried mod's start rules (`"horizon:start_checks"`).
    checks: super::start_checks::StartChecks,
    // Vanilla's draws, or YUNG's API's for `yungsapi:yung_jigsaw`.
    draws: super::jigsaw::Draws,
    // Laid out by Repurposed Structures' and Moog's piece-limited
    // assembler (`"horizon:piece_limited"`).
    piece_limited: Maybe(super::piece_limited::Config),
}
StructureKind :: enum {
    Jigsaw(JigsawDef),
    BuriedTreasure,
    Igloo,
    SwampHut,
    DesertPyramid,
    JungleTemple,
    RuinedPortal(Vec<super::ruined_portal::Setup>),
    Mansion,
    // The biomes allowed around a monument (#required_ocean_monument_surrounding).
    Monument(BTreeSet<BiomeId>),
    Shipwreck {,
    beached: bool,
    // rust: },
    OceanRuin {,
    warm: bool,
    large: f32,
    cluster: f32,
    // rust: },
    Mineshaft {,
    mesa: bool,
        // #minecraft:mineshaft_blocking
    blocking: Arc<BTreeSet<BiomeId>>,
    // rust: },
    Stronghold,
    Fortress,
    NetherFossil(HeightProvider),
    EndCity,
    // `horizon:formations`: Formations' SimpleStructure.
    Formations(super::formations::Def),
    // A structure type whose generator is not implemented yet.
    Unsupported(String),
}
StructureDef :: struct {
    name: string,
    kind: StructureKind,
    biomes: BTreeSet<BiomeId>,
    step: uint,
    terrain: TerrainAdjustment,
    // A structure library's terrain kernel
    // (`"horizon:enhanced_terrain_adaptation"`).
    enhanced_terrain: Maybe(super::enhanced_terrain::StructureAdaptation),
}
Reduction :: enum {
    Default,
    Legacy1,
    Legacy2,
    Legacy3,
}
Placement :: enum {
    RandomSpread {,
    spacing: i32,
    separation: i32,
    triangular: bool,
    // rust: },
    ConcentricRings {,
    distance: i32,
    spread: i32,
    count: i32,
    preferred: BTreeSet<BiomeId>,
    // rust: },
    // `DimensionOriginStructurePlacement.isStructureChunk`: the set's start
    // is the generator's origin chunk and no other
    // (`ChunkGenerator.getOrigin`, `NoiseBasedChunkGenerator`'s override
    // being the chunk of the NoiseSpawnFinder position). The type has no
    // salt, frequency reduction or exclusion zone: the chunk alone decides.
    DimensionOrigin,
    Unsupported,
}
// Concentric ring chunk positions by structure set name.
    // rust: pub type Rings = BTreeMap<String, Vec<ChunkPos>>;
StructureSet :: struct {
    name: string,
    structures: Vec<(uint,
    placement: Placement,
    salt: i32,
    frequency: f32,
    reduction: Reduction,
    exclusion: Option<(string,
    // A carried mod's placement rules: no start nearer the world origin
    // than this many blocks (`"horizon:min_distance_from_world_origin"`),
    // and none within `chunk_count` chunks of any of several sets
    // (`"horizon:exclusion_zone"`: `other_sets`, `chunk_count`).
    min_distance: Maybe(i64),
    avoid: Maybe(Avoid),
    // `"horizon:ring_sections"`: starts only in odd rings around the origin.
    rings: Maybe(RingSections),
    // `"horizon:avoid_biomes"`: no start with one of these biomes near.
    avoid_biomes: Maybe(AvoidBiomes),
    // `placement.locate_offset` (buried treasure's [9, 0, 9]).
    locate_offset: [i32,
}

// `"horizon:exclusion_zone"`: no start within `chunk_count` chunks of a
// start of any of `sets`. With `"their_zones": false` those sets' own
// exclusion zones are not checked (Mo' Structures' ModStructurePlacement
// tests the sets it avoids by their spread and frequency alone).
Avoid :: struct {
    sets: [dynamic]string,
    chunk_count: i32,
    their_zones: bool,
}

// YUNG's Better Strongholds' placement (BetterStrongholdsPlacement
// .isPlacementChunk): the world is cut into rings `thickness` chunks wide,
// the first one starting `distance_to_first_ring` chunks out; a start is
// placed only in the odd ones, and in none past `max_section`.
//
// ```json
// "horizon:ring_sections": {"distance_to_first_ring": 80, "thickness": 96, "max_section": 5}
// ```
RingSections :: struct {
    first: i32,
    thickness: i32,
    max: Maybe(i32),
}
    // rust: impl RingSections {
decode :: proc(v: ^Value) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let int = |k: &str| v[k].as_i64().map(|n| n as i32);
    // rust: Self {
    // rust: first: int("distance_to_first_ring").unwrap_or(0),
    // rust: thickness: int("thickness").unwrap_or(1).max(1),
    // rust: max: int("max_section"),
}
}
allows :: proc(self: ^Self, x: i32, z: i32) -> b {
    // Ported from Horizon
    return {}
}
        // Java int arithmetic: the squares wrap past 46,340 chunks, and the
        // square root of a negative int is NaN, which casts to 0.
    // rust: let squared = x.wrapping_mul(x).wrapping_add(z.wrapping_mul(z));
    // rust: let distance = f64::from(squared).sqrt() as i32;
    // rust: let section = distance.wrapping_add(self.thickness - self.first) / self.thickness;
    // rust: self.max.is_none_or(|max| section <= max) && section % 2 == 1
}
}

// YUNG's Better Desert and Jungle Temples' placement: no start when a
// biome of the set is found around the chunk's middle block at height `y`
// (BiomeSource.findBiomeHorizontal with `radius` blocks and `step` quarts
// between samples, closest first).
//
// ```json
// "horizon:avoid_biomes": {"biomes": ["#minecraft:is_river", "#minecraft:is_ocean"],
//   "radius": 48, "step": 2, "y": 120}
// ```
AvoidBiomes :: struct {
    biomes: BTreeSet<BiomeId>,
    radius: i32,
    step: i32,
    y: i32,
}
    // rust: impl AvoidBiomes {
    // rust: fn decode(
    // rust: v: &Value,
    // rust: biome_set: &dyn Fn(&Value) -> Result<BTreeSet<BiomeId>, DecodeError>,
    // rust: ) -> Result<Self, DecodeError> {
    // rust: let mut biomes = BTreeSet::new();
    // rust: match &v["biomes"] {
    // rust: Value::Array(list) => {
    // rust: for entry in list {
    // rust: biomes.extend(biome_set(entry)?);
}
}
    // rust: other => biomes = biome_set(other)?,
}
    // rust: let int = |k: &str, default: i32| v[k].as_i64().map_or(default, |n| n as i32);
    // rust: Ok(Self {
    // rust: biomes,
    // rust: radius: int("radius", 0),
    // rust: step: int("step", 1).max(1),
    // rust: y: int("y", 0),
    // rust: })
}
near :: proc(self: ^Self, chunk: ChunkPos, mut biome: impl FnMut([i32; 3]) -> B {
    // Ported from Horizon
    return {}
}
        // ChunkPos.getMiddleBlockPosition, then QuartPos.fromBlock.
    // rust: let (cx, cz) = ((chunk.x * 16 + 8) >> 2, (chunk.z * 16 + 8) >> 2);
    // rust: let (radius, y) = (self.radius >> 2, self.y >> 2);
    // rust: let mut r = 0;
    // rust: while r <= radius {
    // rust: let mut dz = -r;
    // rust: while dz <= r {
    // rust: let z_edge = dz.abs() == r;
    // rust: let mut dx = -r;
    // rust: while dx <= r {
    // rust: if (z_edge || dx.abs() == r)
    // rust: && self.biomes.contains(&biome([cx + dx, y, cz + dz]))
    // rust: {
    // rust: return true;
}
    // rust: dx += self.step;
}
    // rust: dz += self.step;
}
    // rust: r += self.step;
}
    // rust: false
}
}

heightmap :: proc(name: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: HeightmapType::ALL.into_iter().find(|k| k.name() == name)
}
terrain :: proc(name: Maybe(string)) -> T {
    // Ported from Horizon
    return {}
}
    // rust: match name {
    // rust: Some("bury") => TerrainAdjustment::Bury,
    // rust: Some("beard_thin") => TerrainAdjustment::BeardThin,
    // rust: Some("beard_box") => TerrainAdjustment::BeardBox,
    // rust: Some("encapsulate") => TerrainAdjustment::Encapsulate,
    // rust: _ => TerrainAdjustment::None,
}
}
// A jigsaw field given as one number or as an object of two. In the object a
// missing `a` is 0 and a missing `b` is `missing_b` (`JigsawStructure.MaxDistance`
// and `DimensionPadding` default their second value, not copy the first).
pair :: proc(value: Maybe(^Value), a: string, b: string, default: i32, missing_b: i32) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: match value {
    // rust: Some(Value::Number(n)) => [n.as_i64().unwrap_or(0) as i32; 2],
    // rust: Some(Value::Object(o)) => {
    // rust: let get = |k: &str| o.get(k).and_then(Value::as_i64).map(|v| v as i32);
    // rust: [get(a).unwrap_or(0), get(b).unwrap_or(missing_b)]
}
    // rust: _ => [default; 2],
}
}
// `JigsawStructure`'s `size` (its depth) and `max_distance_from_center`.
jigsaw_depth_and_reach :: proc(v: ^Value) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: (
    // rust: v["size"].as_i64().unwrap_or(0) as i32,
    // rust: pair(
    // rust: v.get("max_distance_from_center"),
    // rust: "horizontal",
    // rust: "vertical",
    // rust: 80,
            // DimensionType.Y_SIZE.
    // rust: 4064,
    // rust: ),
    // rust: )
}
// The bounds `JigsawStructure`'s codec puts on those two: `size` is
// `Codec.intRange(0, 20)` and `MaxDistance` is `horizontal`
// `Codec.intRange(1, 128)` beside `vertical`
// `ExtraCodecs.intRange(1, DimensionType.Y_SIZE)`.
jigsaw_reach_in_range :: proc(depth: i32, vertical]: [i32; 2]) -> b {
    // Ported from Horizon
    return {}
}
    // rust: (0..=20).contains(&depth) && (1..=128).contains(&horizontal) && (1..=4064).contains(&vertical)
}

// All structures and structure sets of a resource bundle, in registry
// (identifier) order.
StructureRegistry :: struct {
    structures: [dynamic]StructureDef,
    sets: [dynamic]StructureSet,
    pools: Pools,
    // `ChunkGenerator.getOrigin`: the chunk a `minecraft:dimension_origin`
    // placement puts its start in. Vanilla's default origin (a generator
    // with no noise spawn target) is chunk 0 0, until the generator gives
    // its structure state the origin it has.
    origin: ChunkPos,
}
    // rust: impl StructureRegistry {
    // rust: pub fn new(
    // rust: structures: &BTreeMap<String, String>,
    // rust: sets: &BTreeMap<String, String>,
    // rust: pools: BTreeMap<String, String>,
    // rust: biome_set: &dyn Fn(&Value) -> Result<BTreeSet<BiomeId>, DecodeError>,
    // rust: ) -> Result<Self, DecodeError> {
    // rust: let mut defs = Vec::new();
    // rust: for (name, json) in structures {
    // rust: let v: Value = serde_json::from_str(json)?;
    // rust: let draws = match v["type"].as_str() {
    // rust: Some("yungsapi:yung_jigsaw") => super::jigsaw::Draws::Yung,
    // rust: _ => super::jigsaw::Draws::Vanilla,
}
    // rust: let kind = match v["type"].as_str().unwrap_or_default() {
    // rust: "minecraft:jigsaw" | "yungsapi:yung_jigsaw" => {
    // rust: let (depth, max_distance) = jigsaw_depth_and_reach(&v);
    // rust: let def = JigsawDef {
    // rust: draws,
    // rust: start_pool: v["start_pool"].as_str().unwrap_or_default().to_owned(),
    // rust: start_jigsaw: v["start_jigsaw_name"].as_str().map(str::to_owned),
    // rust: max_depth: depth,
    // rust: start_height: HeightProvider::from_json(&v["start_height"].to_string())?,
    // rust: use_expansion_hack: v["use_expansion_hack"].as_bool().unwrap_or(false),
    // rust: project_to: v["project_start_to_heightmap"].as_str().and_then(heightmap),
    // rust: max_distance,
    // rust: aliases: v["pool_aliases"].as_array().cloned().unwrap_or_default(),
    // rust: padding: pair(v.get("dimension_padding"), "bottom", "top", 0, 0),
    // rust: waterlogging: v["liquid_settings"].as_str() != Some("ignore_waterlogging"),
    // rust: checks: super::start_checks::StartChecks::decode(
    // rust: v.get("horizon:start_checks"),
    // rust: ),
    // rust: piece_limited: v
    // rust: .get("horizon:piece_limited")
    // rust: .map(super::piece_limited::Config::decode),
}
                    // JigsawStructure's codec bounds `size` and
                    // `max_distance_from_center`: vanilla registers no
                    // structure carrying others, so one that does places
                    // nothing here either rather than reaching past what the
                    // generator allows.
    // rust: if jigsaw_reach_in_range(depth, max_distance) {
    // rust: StructureKind::Jigsaw(def)
    // rust: } else {
    // rust: StructureKind::Unsupported("minecraft:jigsaw".into())
}
}
    // rust: "minecraft:buried_treasure" => StructureKind::BuriedTreasure,
    // rust: "minecraft:igloo" => StructureKind::Igloo,
    // rust: "minecraft:swamp_hut" => StructureKind::SwampHut,
    // rust: "minecraft:desert_pyramid" => StructureKind::DesertPyramid,
    // rust: "minecraft:jungle_temple" => StructureKind::JungleTemple,
    // rust: "minecraft:woodland_mansion" => StructureKind::Mansion,
    // rust: "minecraft:ocean_monument" => StructureKind::Monument(biome_set(
    // rust: &serde_json::json!("#minecraft:required_ocean_monument_surrounding"),
    // rust: )?),
    // rust: "minecraft:ruined_portal" => StructureKind::RuinedPortal(
    // rust: v["setups"]
    // rust: .as_array()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .map(super::ruined_portal::Setup::decode)
    // rust: .collect(),
    // rust: ),
    // rust: "minecraft:shipwreck" => StructureKind::Shipwreck {
    // rust: beached: v["is_beached"].as_bool().unwrap_or(false),
    // rust: },
    // rust: "minecraft:ocean_ruin" => StructureKind::OceanRuin {
    // rust: warm: v["biome_temp"].as_str() == Some("warm"),
    // rust: large: v["large_probability"].as_f64().unwrap_or(0.) as f32,
    // rust: cluster: v["cluster_probability"].as_f64().unwrap_or(0.) as f32,
    // rust: },
    // rust: "minecraft:mineshaft" => StructureKind::Mineshaft {
    // rust: mesa: v["mineshaft_type"].as_str() == Some("mesa"),
    // rust: blocking: Arc::new(biome_set(&Value::String(
    // rust: "#minecraft:mineshaft_blocking".into(),
    // rust: ))?),
    // rust: },
    // rust: "minecraft:stronghold" => StructureKind::Stronghold,
    // rust: "minecraft:fortress" => StructureKind::Fortress,
    // rust: "minecraft:end_city" => StructureKind::EndCity,
    // rust: "minecraft:nether_fossil" => StructureKind::NetherFossil(
    // rust: HeightProvider::from_json(&v["height"].to_string())?,
    // rust: ),
    // rust: "horizon:formations" => match super::formations::Def::decode(&v) {
    // rust: Ok(def) => StructureKind::Formations(def),
    // rust: Err(_) => StructureKind::Unsupported("horizon:formations".into()),
    // rust: },
    // rust: other => StructureKind::Unsupported(other.to_owned()),
}
    // rust: defs.push(StructureDef {
    // rust: name: name.clone(),
    // rust: kind,
    // rust: biomes: biome_set(&v["biomes"])?,
    // rust: step: STEPS
    // rust: .iter()
    // rust: .position(|s| Some(*s) == v["step"].as_str())
    // rust: .unwrap_or(4),
    // rust: terrain: terrain(v["terrain_adaptation"].as_str()),
    // rust: enhanced_terrain: v
    // rust: .get("horizon:enhanced_terrain_adaptation")
    // rust: .map(super::enhanced_terrain::StructureAdaptation::decode)
    // rust: .transpose()?,
    // rust: });
}
    // rust: let index = |name: &str| defs.iter().position(|d| d.name == name);
    // rust: let mut out = Vec::new();
    // rust: for (name, json) in sets {
    // rust: let v: Value = serde_json::from_str(json)?;
    // rust: let p = &v["placement"];
            // AbstractSpreadingStructurePlacement's codec: `frequency` is a
            // floatRange(0.0F, 1.0F) and the salt any int.
    // rust: let frequency = p["frequency"].as_f64().unwrap_or(1.);
    // rust: if !(0. ..=1.).contains(&frequency) {
    // rust: return Err(DecodeError::Field("structure set frequency"));
}
    // rust: let placement = match p["type"].as_str().unwrap_or_default() {
    // rust: "minecraft:random_spread" => {
                    // The codec's intRange(0, 4096) and
                    // RandomSpreadStructurePlacement.validate: a spread whose
                    // separation reaches its spacing is refused, not clamped
                    // to the grid corners.
    // rust: let spacing = p["spacing"].as_i64().unwrap_or(1);
    // rust: let separation = p["separation"].as_i64().unwrap_or(0);
    // rust: if !(0..=4096).contains(&spacing) || !(0..=4096).contains(&separation) {
    // rust: return Err(DecodeError::Field("random spread spacing range"));
}
    // rust: if spacing <= separation {
    // rust: return Err(DecodeError::Field(
    // rust: "random spread spacing not larger than separation",
    // rust: ));
}
    // rust: Placement::RandomSpread {
    // rust: spacing: spacing as i32,
    // rust: separation: separation as i32,
    // rust: triangular: p["spread_type"].as_str() == Some("triangular"),
}
}
    // rust: "minecraft:dimension_origin" => Placement::DimensionOrigin,
    // rust: "minecraft:concentric_rings" => Placement::ConcentricRings {
    // rust: distance: p["distance"].as_i64().unwrap_or(0) as i32,
    // rust: spread: p["spread"].as_i64().unwrap_or(0) as i32,
    // rust: count: p["count"].as_i64().unwrap_or(0) as i32,
    // rust: preferred: biome_set(&p["preferred_biomes"])?,
    // rust: },
    // rust: _ => Placement::Unsupported,
}
    // rust: out.push(StructureSet {
    // rust: name: name.clone(),
    // rust: structures: v["structures"]
    // rust: .as_array()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .filter_map(|e| {
    // rust: Some((
    // rust: index(e["structure"].as_str()?)?,
    // rust: e["weight"].as_i64().unwrap_or(1) as i32,
    // rust: ))
    // rust: })
    // rust: .collect(),
    // rust: placement,
    // rust: salt: p["salt"].as_i64().unwrap_or(0) as i32,
    // rust: frequency: frequency as f32,
    // rust: locate_offset: {
    // rust: let at = |i: usize| p["locate_offset"][i].as_i64().unwrap_or(0) as i32;
    // rust: [at(0), at(1), at(2)]
    // rust: },
    // rust: reduction: match p["frequency_reduction_method"].as_str() {
    // rust: Some("legacy_type_1") => Reduction::Legacy1,
    // rust: Some("legacy_type_2") => Reduction::Legacy2,
    // rust: Some("legacy_type_3") => Reduction::Legacy3,
    // rust: _ => Reduction::Default,
    // rust: },
    // rust: exclusion: p.get("exclusion_zone").map(|z| {
    // rust: (
    // rust: z["other_set"].as_str().unwrap_or_default().to_owned(),
    // rust: z["chunk_count"].as_i64().unwrap_or(0) as i32,
    // rust: )
    // rust: }),
    // rust: min_distance: p
    // rust: .get("horizon:min_distance_from_world_origin")
    // rust: .and_then(Value::as_i64),
    // rust: avoid: p.get("horizon:exclusion_zone").map(|z| Avoid {
    // rust: sets: z["other_sets"]
    // rust: .as_array()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .filter_map(|s| Some(s.as_str()?.to_owned()))
    // rust: .collect(),
    // rust: chunk_count: z["chunk_count"].as_i64().unwrap_or(0) as i32,
    // rust: their_zones: z["their_zones"].as_bool().unwrap_or(true),
    // rust: }),
    // rust: rings: p.get("horizon:ring_sections").map(RingSections::decode),
    // rust: avoid_biomes: p
    // rust: .get("horizon:avoid_biomes")
    // rust: .map(|a| AvoidBiomes::decode(a, biome_set))
    // rust: .transpose()?,
    // rust: });
}
    // rust: Ok(Self {
    // rust: structures: defs,
    // rust: sets: out,
    // rust: pools: Pools::new(pools),
    // rust: origin: ChunkPos::new(0, 0),
    // rust: })
}
    // `ChunkGenerator.getOrigin`: the dimension origin chunk.
dimension_origin :: proc(self: ^Self) -> C {
    // Ported from Horizon
    return {}
}
    // rust: self.origin
}
    // The origin the generator reports for this dimension.
set_dimension_origin :: proc(self: ^Self, origin: ChunkPos) {
}
    // rust: self.origin = origin;
}
    // Whether a set is placed by the dimension's origin chunk alone, so the
    // generator has to work out where its origin is.
needs_dimension_origin :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.sets
    // rust: .iter()
    // rust: .any(|set| matches!(set.placement, Placement::DimensionOrigin))
}
    // ChunkGeneratorStructureState.generatePositions: the ring positions of
    // each concentric-ring set among `possible_sets` before their biome
    // searches (set index, searches in order).
    // rust: pub fn ring_searches(
    // rust: &self,
    // rust: possible_sets: &[usize],
    // rust: seed: i64,
    // rust: ) -> Vec<(usize, Vec<super::stronghold::RingSearch>)> {
    // rust: possible_sets
    // rust: .iter()
    // rust: .filter_map(|&i| match &self.sets[i].placement {
    // rust: Placement::ConcentricRings {
    // rust: distance,
    // rust: spread,
    // rust: count,
    // rust: ..
    // rust: } => Some((
    // rust: i,
    // rust: super::stronghold::ring_searches(seed, *distance, *spread, *count),
    // rust: )),
    // rust: _ => None,
    // rust: })
    // rust: .collect()
}
    // How far from a chunk, in chunks, deciding its starts can look at
    // other sets' start chunks through exclusion zones: every set's zones
    // summed, a bound on any chain of them.
zone_reach :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.sets
    // rust: .iter()
    // rust: .map(|s| {
    // rust: s.exclusion.as_ref().map_or(0, |e| e.1.max(0))
    // rust: + s.avoid.as_ref().map_or(0, |a| a.chunk_count.max(0))
    // rust: })
    // rust: .sum()
}
    // The preferred biomes of a concentric-ring set (empty for others).
ring_biomes :: proc(self: ^Self, set: uint) -> ^ {
    // Ported from Horizon
    return {}
}
NONE :: BTreeSet::new()
    // rust: match &self.sets[set].placement {
    // rust: Placement::ConcentricRings { preferred, .. } => preferred,
    // rust: _ => &NONE,
}
}
    // RandomSpreadStructurePlacement.getPotentialStructureChunk et al.
    // RandomSpreadStructurePlacement.getPotentialStructureChunk for the
    // sector holding chunk (`x`, `z`); `None` for other placements.
potential_chunk :: proc(set: ^StructureSet, seed: i64, x: i32, z: i32) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let Placement::RandomSpread {
    // rust: spacing,
    // rust: separation,
    // rust: triangular,
    // rust: } = set.placement
    // rust: else {
    // rust: return None;
}
    // rust: let (gx, gz) = (x.div_euclid(spacing), z.div_euclid(spacing));
    // rust: let mut random = WorldgenRandom::new(LegacyRandom::new(0));
    // rust: random.set_large_feature_with_salt(seed, gx, gz, set.salt);
    // rust: let limit = spacing - separation;
    // rust: let spread = |r: &mut WorldgenRandom<LegacyRandom>| {
    // rust: if triangular {
    // rust: (r.next_int_bound(limit).unwrap_or(0) + r.next_int_bound(limit).unwrap_or(0)) / 2
    // rust: } else {
    // rust: r.next_int_bound(limit).unwrap_or(0)
}
}
    // rust: let sx = spread(&mut random);
    // rust: let sz = spread(&mut random);
    // rust: Some(ChunkPos::new(gx * spacing + sx, gz * spacing + sz))
}
    // rust: pub fn is_structure_chunk(
    // rust: &self,
    // rust: set: &StructureSet,
    // rust: seed: i64,
    // rust: x: i32,
    // rust: z: i32,
    // rust: rings: &Rings,
    // rust: ) -> bool {
    // rust: self.structure_chunk(set, seed, x, z, rings, true)
}
    // [`Self::is_structure_chunk`]; without the set's exclusion zones when
    // `zones` is false.
    // rust: fn structure_chunk(
    // rust: &self,
    // rust: set: &StructureSet,
    // rust: seed: i64,
    // rust: x: i32,
    // rust: z: i32,
    // rust: rings: &Rings,
    // rust: zones: bool,
    // rust: ) -> bool {
        // DimensionOriginStructurePlacement names the generator's origin
        // chunk alone: it is no AbstractSpreadingStructurePlacement, so no
        // frequency reduction and no exclusion zone can take that chunk away.
    // rust: if matches!(set.placement, Placement::DimensionOrigin) {
    // rust: return x == self.origin.x && z == self.origin.z;
}
    // rust: let placed = match set.placement {
    // rust: Placement::DimensionOrigin => unreachable!("handled above"),
    // rust: Placement::RandomSpread {
    // rust: spacing,
    // rust: separation,
    // rust: triangular,
    // rust: } => {
    // rust: let (gx, gz) = (x.div_euclid(spacing), z.div_euclid(spacing));
    // rust: let mut random = WorldgenRandom::new(LegacyRandom::new(0));
    // rust: random.set_large_feature_with_salt(seed, gx, gz, set.salt);
    // rust: let limit = spacing - separation;
    // rust: let spread = |r: &mut WorldgenRandom<LegacyRandom>| {
    // rust: if triangular {
    // rust: (r.next_int_bound(limit).unwrap_or(0)
    // rust: + r.next_int_bound(limit).unwrap_or(0))
    // rust: / 2
    // rust: } else {
    // rust: r.next_int_bound(limit).unwrap_or(0)
}
}
    // rust: let sx = spread(&mut random);
    // rust: let sz = spread(&mut random);
    // rust: gx * spacing + sx == x && gz * spacing + sz == z
}
    // rust: Placement::ConcentricRings { .. } => rings
    // rust: .get(&set.name)
    // rust: .is_some_and(|r| r.contains(&ChunkPos::new(x, z))),
    // rust: Placement::Unsupported => false,
}
    // rust: if !placed {
    // rust: return false;
}
    // rust: if set.rings.as_ref().is_some_and(|r| !r.allows(x, z)) {
    // rust: return false;
}
        // AdvancedRandomSpread.isPlacementChunk, in blocks from the chunk's corner.
    // rust: if let Some(d) = set.min_distance {
    // rust: let (bx, bz) = (i64::from(x) * 16, i64::from(z) * 16);
    // rust: if bx * bx + bz * bz < d * d {
    // rust: return false;
}
}
    // rust: if let Some(avoid) = set.avoid.as_ref().filter(|_| zones) {
    // rust: if avoid.sets.iter().any(|other| {
    // rust: let range = avoid.chunk_count;
    // rust: self.has_start_in_range(other, seed, x, z, range, rings, avoid.their_zones)
    // rust: }) {
    // rust: return false;
}
}
    // rust: if set.frequency < 1. && !reduce(set.reduction, seed, set.salt, x, z, set.frequency) {
    // rust: return false;
}
    // rust: match set.exclusion.as_ref().filter(|_| zones) {
    // rust: Some((other, range)) => {
    // rust: !self.has_start_in_range(other, seed, x, z, *range, rings, true)
}
    // rust: None => true,
}
}
    // ChunkGeneratorStructureState.hasStructureChunkInRange: whether set
    // `other` places a structure within `range` chunks of (`x`, `z`),
    // checking its own exclusion zones when `zones` is true.
    // rust: fn has_start_in_range(
    // rust: &self,
    // rust: other: &str,
    // rust: seed: i64,
    // rust: x: i32,
    // rust: z: i32,
    // rust: range: i32,
    // rust: rings: &Rings,
    // rust: zones: bool,
    // rust: ) -> bool {
    // rust: let Some(other) = self.sets.iter().find(|s| s.name == other) else {
    // rust: return false;
}
    // rust: (x - range..=x + range).any(|tx| {
    // rust: (z - range..=z + range)
    // rust: .any(|tz| self.structure_chunk(other, seed, tx, tz, rings, zones))
    // rust: })
}
}
    // rust: impl StructureSet {
    // The random spread's spacing in chunks (`None` for rings).
spacing :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match self.placement {
    // rust: Placement::RandomSpread { spacing, .. } => Some(spacing),
    // rust: _ => None,
}
}
    // StructurePlacement.getLocatePos: the chunk's corner at y 0, moved by
    // the set's `locate_offset`.
locate_pos :: proc(self: ^Self, chunk: ChunkPos) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: let o = self.locate_offset;
    // rust: [chunk.x * 16 + o[0], o[1], chunk.z * 16 + o[2]]
}
}
reduce :: proc(method: Reduction, seed: i64, salt: i32, x: i32, z: i32, probability: f32) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let mut random = WorldgenRandom::new(LegacyRandom::new(0));
    // rust: match method {
    // rust: Reduction::Default => {
    // rust: random.set_large_feature_with_salt(seed, salt, x, z);
    // rust: random.next_float() < probability
}
    // rust: Reduction::Legacy1 => {
    // rust: let (cx, cz) = (x >> 4, z >> 4);
    // rust: random.set_seed(i64::from(cx ^ (cz << 4)) ^ seed);
    // rust: random.next_int();
    // rust: random
    // rust: .next_int_bound((1. / probability) as i32)
    // rust: .unwrap_or(1)
    // rust: == 0
}
    // rust: Reduction::Legacy2 => {
    // rust: random.set_large_feature_with_salt(seed, x, z, 10_387_320);
    // rust: random.next_float() < probability
}
    // rust: Reduction::Legacy3 => {
    // rust: random.set_large_feature_seed(seed, x, z);
    // rust: random.next_double() < f64::from(probability)
}
}
}

Piece :: enum {
    Pool(PoolPiece),
    Legacy(Box<dyn LegacyPiece>),
}
    // rust: impl Piece {
bounding_box :: proc(self: ^Self) -> B {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::Pool(p) => p.bounding_box,
    // rust: Self::Legacy(p) => p.bounding_box(),
}
}
type_name :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::Pool(_) => "minecraft:jigsaw",
    // rust: Self::Legacy(p) => p.type_name(),
}
}
    // `StructurePiece.createTag`; None for a type Horizon cannot save yet.
save :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::Pool(p) => Some(p.save()),
    // rust: Self::Legacy(p) => p.save(),
}
}
}
legacy :: proc(pieces: [dynamic]impl LegacyPiece + 'static) -> V {
    // Ported from Horizon
    return {}
}
    // rust: pieces
    // rust: .into_iter()
    // rust: .map(|p| Piece::Legacy(Box::new(p)))
    // rust: .collect()
}
// Structure.onTopOfChunkCenter: the start position, or None when no valid
// biome can exist in the chunk-center column.
    // rust: fn top_of_chunk_center(
    // rust: context: &mut impl StartContext,
    // rust: chunk: ChunkPos,
    // rust: kind: HeightmapType,
    // rust: ) -> Option<[i32; 3]> {
    // rust: let (x, z) = (chunk.x * 16 + 8, chunk.z * 16 + 8);
    // rust: let (min, max) = (context.min_y(), context.max_y());
    // rust: if !context.column_has_valid_biome(x, z, min - 1, max) {
    // rust: return None;
}
    // rust: Some([x, context.base_height(x, z, kind) - 1, z])
}
first_occupied :: proc(context: ^impl StartContext, x: i32, z: i32) -> i {
    // Ported from Horizon
    return {}
}
    // rust: context.base_height(x, z, HeightmapType::WorldSurfaceWg) - 1
}
corner_heights :: proc(context: ^impl StartContext, x: i32, sx: i32, z: i32, sz: i32) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: [
    // rust: first_occupied(context, x, z),
    // rust: first_occupied(context, x, z + sz),
    // rust: first_occupied(context, x + sx, z),
    // rust: first_occupied(context, x + sx, z + sz),
    // rust: ]
}
StructureStart :: struct {
    structure: uint,
    name: string,
    chunk: ChunkPos,
    pieces: [dynamic]Piece,
    // Piece union, inflated by 12 for terrain-adapting structures.
    bounding_box: BoundingBox,
}
    // rust: impl StructureStart {
    // `StructureStart.createTag` in its own chunk; None while one of its
    // pieces cannot be saved. `references` counts `addReference` calls,
    // which only locating structures makes: 0 in a freshly made world.
save :: proc(self: ^Self) -> O {
    // Ported from Horizon
    return {}
}
//         use crate::nbt::Tag;
    // rust: let children: Option<Vec<Tag>> = self
    // rust: .pieces
    // rust: .iter()
    // rust: .map(|p| p.save().map(Tag::Compound))
    // rust: .collect();
    // rust: Some(Tag::compound([
    // rust: ("id", Tag::String(self.name.as_str().into())),
    // rust: ("ChunkX", Tag::Int(self.chunk.x)),
    // rust: ("ChunkZ", Tag::Int(self.chunk.z)),
    // rust: ("references", Tag::Int(0)),
    // rust: ("Children", Tag::List(children?)),
    // rust: ]))
}
}

// A block of a noise column (ChunkGenerator.getBaseColumn), by what
// structures ask of it.
NoiseBlock :: enum {
    Air,
    // The water block (`is(Blocks.WATER)`), as the aquifers and the sea
    // fill it.
    Water,
    Lava,
    // BlockState.isSolid: the noise's own blocks (stone, deepslate, ore
    // veins, netherrack...).
    Solid,
    Other,
}
    // rust: impl NoiseBlock {
is_solid :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self == Self::Solid
}
}
// ChunkGenerator.getBaseColumn's blocks from `min` up; past its ends a
// NoiseColumn reads air.
NoiseColumn :: struct {
    min: i32,
    blocks: [dynamic]NoiseBlock,
}
    // rust: impl NoiseColumn {
get :: proc(self: ^Self, y: i32) -> N {
    // Ported from Horizon
    return {}
}
    // rust: usize::try_from(y - self.min)
    // rust: .ok()
    // rust: .and_then(|i| self.blocks.get(i).copied())
    // rust: .unwrap_or(NoiseBlock::Air)
}
}

// Biome and height queries for one structure generation attempt.
    // rust: pub trait StartContext: JigsawContext {
    // A chunk an older version generated: its structure starts are the ones
    // it saved, which are in its blocks, not the ones this generator would
    // make there.
is_old_chunk :: proc(self: ^Self, _chunk: ChunkPos) -> b {
    // Ported from Horizon
    return {}
}
    // rust: false
}
    // The starts that old chunk saved: see `OldWorld::saved_starts`.
saved_starts :: proc(self: ^Self, _chunk: ChunkPos) -> V {
    // Ported from Horizon
    return {}
}
    // rust: Vec::new()
}
seed :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
sea_level :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // `ChunkGenerator.getMinY`: the noise settings' minimum Y, or a superflat generator's 0
    // (`MineshaftStructure` and `StrongholdStructure` read it, not the level's).
generator_min_y :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.min_y()
}
    // ChunkGenerator.getBaseColumn as heightmap opacity, indexed from min_y.
base_column :: proc(self: ^Self, x: i32, z: i32, kind: HeightmapType) -> V {
    // Ported from Horizon
    return {}
}
    // base_column for several heightmap kinds from one noise-column pass.
base_columns :: proc(self: ^Self, x: i32, z: i32, kinds: ^[HeightmapType]) -> V {
    // Ported from Horizon
    return {}
}
    // ChunkGenerator.getBaseColumn's blocks: the noise column's states, as
    // mods' placements test them (Formations').
noise_column :: proc(self: ^Self, x: i32, z: i32) -> N {
    // Ported from Horizon
    return {}
}
    // Biome.coldEnoughToSnow at a position.
cold_enough_to_snow :: proc(self: ^Self, biome: BiomeId, pos: [i32; 3]) -> b {
    // Ported from Horizon
    return {}
}
generation :: proc(self: ^Self) -> W {
    // Ported from Horizon
    return {}
}
    // Noise biome at a quart position (caching resolver, no zoom).
noise_biome :: proc(self: ^Self, quart: [i32; 3]) -> B {
    // Ported from Horizon
    return {}
}
    // Noise biomes of `quarts` in order through one resolver, as
    // BiomeSource.findBiomeHorizontal samples: each climate lookup starts
    // from the previous result, which a tie keeps.
noise_biomes :: proc(self: ^Self, quarts: ^[[i32; 3]]) -> V {
    // Ported from Horizon
    return {}
}
    // `GenerationContext.validBiome`'s set: `None` is the `biome -> true`
    // predicate `/place structure` passes, so every biome counts as valid.
set_valid_biomes :: proc(self: ^Self, biomes: Maybe(^BTreeSet<BiomeId)>) {
}
}

// ChunkGenerator.createStructures for one chunk: the starts it owns.
    // rust: pub fn create_starts(
    // rust: registry: &StructureRegistry,
    // rust: resources: &StructureResources,
    // rust: bindings: &FeatureBlockBindings<'_>,
    // rust: context: &mut impl StartContext,
    // rust: possible_sets: &[usize],
    // rust: rings: &Rings,
    // rust: chunk: ChunkPos,
    // rust: ) -> Vec<StructureStart> {
    // rust: let seed = context.seed();
    // rust: let mut starts = Vec::new();
    // rust: for &set_index in possible_sets {
    // rust: let set = &registry.sets[set_index];
    // rust: if !registry.is_structure_chunk(set, seed, chunk.x, chunk.z, rings) {
    // rust: continue;
}
        // Part of the set's placement in YUNG's mods; checked here, where the
        // biome source is at hand, so another set's exclusion zone naming
        // this one does not see it.
    // rust: if set
    // rust: .avoid_biomes
    // rust: .as_ref()
    // rust: .is_some_and(|a| a.near(chunk, |q| context.noise_biome(q)))
    // rust: {
    // rust: continue;
}
    // rust: if set.structures.len() == 1 {
    // rust: if let Some(start) = try_generate(
    // rust: registry,
    // rust: resources,
    // rust: bindings,
    // rust: context,
    // rust: set.structures[0].0,
    // rust: chunk,
    // rust: false,
    // rust: ) {
    // rust: starts.push(start);
}
    // rust: continue;
}
    // rust: let mut options = set.structures.clone();
    // rust: let mut random = WorldgenRandom::new(LegacyRandom::new(0));
    // rust: random.set_large_feature_seed(seed, chunk.x, chunk.z);
    // rust: let mut total: i32 = options.iter().map(|o| o.1).sum();
    // rust: while !options.is_empty() {
    // rust: let mut choice = random.next_int_bound(total).unwrap_or(0);
    // rust: let mut index = 0;
    // rust: for option in &options {
    // rust: choice -= option.1;
    // rust: if choice < 0 {
    // rust: break;
}
    // rust: index += 1;
}
    // rust: let selected = options[index];
    // rust: if let Some(start) = try_generate(
    // rust: registry, resources, bindings, context, selected.0, chunk, false,
    // rust: ) {
    // rust: starts.push(start);
    // rust: break;
}
    // rust: options.remove(index);
    // rust: total -= selected.1;
}
}
    // rust: starts
}
// `Structure.generate` of one structure for one chunk: what the chunk's
// structure set would build there, or, for `/place structure`, the start this
// structure builds in any chunk (the set's placement is not consulted, and
// `any_biome` is vanilla's `biome -> true` predicate there).
    // rust: pub(crate) fn try_generate(
    // rust: registry: &StructureRegistry,
    // rust: resources: &StructureResources,
    // rust: bindings: &FeatureBlockBindings<'_>,
    // rust: context: &mut impl StartContext,
    // rust: structure: usize,
    // rust: chunk: ChunkPos,
    // rust: any_biome: bool,
    // rust: ) -> Option<StructureStart> {
    // rust: match generate(
    // rust: registry, resources, bindings, context, structure, chunk, any_biome, false,
    // rust: )? {
    // rust: Generated::Start(start) => Some(start),
    // rust: Generated::Stub => None,
}
}
// `StructureCheck.canCreateStructure`: whether `structure` may start in `chunk`, by
// `Structure.findValidGenerationPoint` alone. A jigsaw's start piece is placed and its biome
// checked; its children are not laid out. Other structures answer true: their starts are
// cheap to build. False only where [`try_generate`] can't start it, so a search may skip
// the chunk's full starts then (#8669).
    // rust: pub(crate) fn may_start(
    // rust: registry: &StructureRegistry,
    // rust: resources: &StructureResources,
    // rust: bindings: &FeatureBlockBindings<'_>,
    // rust: context: &mut impl StartContext,
    // rust: structure: usize,
    // rust: chunk: ChunkPos,
    // rust: ) -> bool {
    // rust: generate(
    // rust: registry, resources, bindings, context, structure, chunk, false, true,
    // rust: )
    // rust: .is_some()
}
// What [`generate`] made: the start, or with `stub_only` only that it may start.
Generated :: enum {
    Start(StructureStart),
    Stub,
}
    // rust: fn generate(
    // rust: registry: &StructureRegistry,
    // rust: resources: &StructureResources,
    // rust: bindings: &FeatureBlockBindings<'_>,
    // rust: context: &mut impl StartContext,
    // rust: structure: usize,
    // rust: chunk: ChunkPos,
    // rust: any_biome: bool,
    // rust: stub_only: bool,
    // rust: ) -> Option<Generated> {
    // rust: let def = &registry.structures[structure];
    // rust: let vanilla_jigsaw =
    // rust: matches!(&def.kind, StructureKind::Jigsaw(jigsaw) if jigsaw.piece_limited.is_none());
    // rust: if stub_only && !vanilla_jigsaw {
    // rust: return Some(Generated::Stub);
}
    // rust: context.set_valid_biomes((!any_biome).then_some(&def.biomes));
    // rust: let seed = context.seed();
    // rust: let mut random = WorldgenRandom::new(LegacyRandom::new(0));
    // rust: random.set_large_feature_seed(seed, chunk.x, chunk.z);
    // rust: let (position, pieces) = match &def.kind {
    // rust: StructureKind::Jigsaw(jigsaw) => {
    // rust: let height = jigsaw
    // rust: .start_height
    // rust: .sample(&mut random, context.generation())
    // rust: .ok()?;
            // A carried mod's own start rules keep the structure's biome set:
            // they read it directly, not through the context's predicate.
    // rust: if !jigsaw
    // rust: .checks
    // rust: .pass(context, &def.biomes, chunk, height, jigsaw.project_to)
    // rust: {
    // rust: return None;
}
    // rust: let start = [chunk.x * 16, height, chunk.z * 16];
    // rust: let aliases = resolve_aliases(&jigsaw.aliases, start, seed);
    // rust: let config = JigsawConfig {
    // rust: start_pool: &jigsaw.start_pool,
    // rust: start_jigsaw: jigsaw.start_jigsaw.as_deref(),
    // rust: max_depth: jigsaw.max_depth,
    // rust: use_expansion_hack: jigsaw.use_expansion_hack,
    // rust: project_to: jigsaw.project_to,
    // rust: max_distance: jigsaw.max_distance,
    // rust: aliases: &aliases,
    // rust: padding: jigsaw.padding,
    // rust: waterlogging: jigsaw.waterlogging,
}
    // rust: let (position, mut pieces) = match &jigsaw.piece_limited {
    // rust: Some(limits) => super::piece_limited::assemble(
    // rust: &config,
    // rust: limits,
    // rust: context,
    // rust: &registry.pools,
    // rust: resources,
    // rust: bindings,
    // rust: chunk,
    // rust: start,
    // rust: )?,
    // rust: None => {
    // rust: let placed = place_start(
    // rust: jigsaw.draws,
    // rust: &config,
    // rust: context,
    // rust: &registry.pools,
    // rust: resources,
    // rust: bindings,
    // rust: &mut random,
    // rust: start,
    // rust: )?;
                    // Structure.findValidGenerationPoint checks the stub's biome before its
                    // GenerationStub lays the pieces out: a start in another biome costs its
                    // start piece, not its whole layout (an ancient city's, a camp's).
    // rust: let quart = placed.position.map(|v| v >> 2);
    // rust: if !any_biome && !def.biomes.contains(&context.noise_biome(quart)) {
    // rust: return None;
}
    // rust: if stub_only {
    // rust: return Some(Generated::Stub);
}
    // rust: lay_out_children(
    // rust: jigsaw.draws,
    // rust: placed,
    // rust: &config,
    // rust: context,
    // rust: &registry.pools,
    // rust: resources,
    // rust: bindings,
    // rust: &mut random,
    // rust: )
}
}
            // Vanilla's JigsawPlacement keeps no piece at size 0; the
            // piece-limited assembler keeps the start piece.
    // rust: if jigsaw.max_depth <= 0 && jigsaw.piece_limited.is_none() {
    // rust: pieces.clear();
}
    // rust: (
    // rust: position,
    // rust: pieces.into_iter().map(Piece::Pool).collect::<Vec<_>>(),
    // rust: )
}
    // rust: StructureKind::BuriedTreasure => {
    // rust: let stub = top_of_chunk_center(context, chunk, HeightmapType::OceanFloorWg)?;
    // rust: let piece = super::simple::BuriedTreasurePiece {
    // rust: position: [chunk.x * 16 + 9, 90, chunk.z * 16 + 9],
    // rust: found: std::sync::Mutex::new(None),
}
    // rust: (stub, legacy(vec![piece]))
}
    // rust: StructureKind::Igloo => {
    // rust: let stub = top_of_chunk_center(context, chunk, HeightmapType::WorldSurfaceWg)?;
    // rust: let rotation = super::Rotation::random(&mut random);
    // rust: let pieces = super::simple::igloo_pieces(
    // rust: resources,
    // rust: [chunk.x * 16, 90, chunk.z * 16],
    // rust: rotation,
    // rust: &mut random,
    // rust: )?;
    // rust: (stub, legacy(pieces))
}
    // rust: StructureKind::SwampHut => {
    // rust: let stub = top_of_chunk_center(context, chunk, HeightmapType::WorldSurfaceWg)?;
    // rust: let piece = super::simple::SwampHutPiece::new(&mut random, chunk.x * 16, chunk.z * 16);
    // rust: (stub, legacy(vec![piece]))
}
    // rust: StructureKind::DesertPyramid | StructureKind::JungleTemple => {
    // rust: let desert = matches!(def.kind, StructureKind::DesertPyramid);
    // rust: let (width, depth) = if desert { (21, 21) } else { (12, 15) };
    // rust: let (x, z) = (chunk.x * 16, chunk.z * 16);
    // rust: if !context.column_has_valid_biome(x + 8, z + 8, context.min_y() - 1, context.max_y()) {
    // rust: return None;
}
    // rust: let lowest = corner_heights(context, x, width, z, depth)
    // rust: .into_iter()
    // rust: .min()
    // rust: .unwrap_or(0);
    // rust: if lowest < context.sea_level() {
    // rust: return None;
}
    // rust: let stub = [x + 8, first_occupied(context, x + 8, z + 8), z + 8];
    // rust: let piece: Box<dyn LegacyPiece> = if desert {
    // rust: Box::new(super::temple::DesertPyramidPiece::new(&mut random, x, z))
    // rust: } else {
    // rust: Box::new(super::temple::JungleTemplePiece::new(&mut random, x, z))
}
    // rust: (stub, vec![Piece::Legacy(piece)])
}
    // rust: StructureKind::Monument(surrounding) => {
    // rust: let (x, z) = (chunk.x * 16 + 9, chunk.z * 16 + 9);
    // rust: let (y, r) = (context.sea_level(), 29);
    // rust: for qz in (z - r) >> 2..=(z + r) >> 2 {
    // rust: for qx in (x - r) >> 2..=(x + r) >> 2 {
    // rust: for qy in (y - r) >> 2..=(y + r) >> 2 {
    // rust: if !surrounding.contains(&context.noise_biome([qx, qy, qz])) {
    // rust: return None;
}
}
}
}
    // rust: let stub = top_of_chunk_center(context, chunk, HeightmapType::OceanFloorWg)?;
    // rust: let direction = super::legacy::random_horizontal(&mut random);
    // rust: let piece = super::monument::MonumentBuilding::new(
    // rust: &mut random,
    // rust: chunk.x * 16 - 29,
    // rust: chunk.z * 16 - 29,
    // rust: direction,
    // rust: );
    // rust: (stub, legacy(vec![piece]))
}
    // rust: StructureKind::Mansion => {
    // rust: let (x, z) = (chunk.x * 16 + 7, chunk.z * 16 + 7);
    // rust: if !context.column_has_valid_biome(x, z, context.min_y() - 1, context.max_y()) {
    // rust: return None;
}
    // rust: let rotation = super::Rotation::random(&mut random);
    // rust: let (sx, sz) = match rotation {
    // rust: super::Rotation::None => (5, 5),
    // rust: super::Rotation::Clockwise90 => (-5, 5),
    // rust: super::Rotation::Clockwise180 => (-5, -5),
    // rust: super::Rotation::Counterclockwise90 => (5, -5),
}
    // rust: let y = corner_heights(context, x, sx, z, sz)
    // rust: .into_iter()
    // rust: .min()
    // rust: .unwrap_or(0);
    // rust: if y < 60 {
    // rust: return None;
}
    // rust: let start = [x, y, z];
    // rust: let pieces = super::mansion::pieces(resources, start, rotation, &mut random)?;
    // rust: (start, legacy(pieces))
}
    // rust: StructureKind::RuinedPortal(setups) => {
    // rust: let (position, piece) = super::ruined_portal::start(
    // rust: context,
    // rust: resources,
    // rust: bindings,
    // rust: &mut random,
    // rust: chunk,
    // rust: setups,
    // rust: )?;
    // rust: (position, legacy(vec![piece]))
}
    // rust: StructureKind::Shipwreck { beached } => {
    // rust: let kind = if *beached {
    // rust: HeightmapType::WorldSurfaceWg
    // rust: } else {
    // rust: HeightmapType::OceanFloorWg
}
    // rust: let stub = top_of_chunk_center(context, chunk, kind)?;
    // rust: let rotation = super::Rotation::random(&mut random);
    // rust: let piece = super::simple::shipwreck_piece(
    // rust: resources,
    // rust: [chunk.x * 16, 90, chunk.z * 16],
    // rust: rotation,
    // rust: &mut random,
    // rust: *beached,
    // rust: )?;
    // rust: if super::simple::shipwreck_too_big(&piece.template) {
    // rust: let b = piece.bounding_box;
    // rust: let [sx, _, sz] = b.span();
    // rust: let heights = corner_heights(context, b.min[0], sx, b.min[2], sz);
    // rust: let height = if *beached {
    // rust: let min = heights.into_iter().min().unwrap_or(0);
    // rust: min - piece.template.size[1] / 2 - random.next_int_bound(3).unwrap_or(0)
    // rust: } else {
    // rust: heights.iter().sum::<i32>() / 4
}
    // rust: *piece.state.lock().unwrap() = Some(height);
}
    // rust: (stub, legacy(vec![piece]))
}
    // rust: StructureKind::OceanRuin {
    // rust: warm,
    // rust: large,
    // rust: cluster,
    // rust: } => {
    // rust: let stub = top_of_chunk_center(context, chunk, HeightmapType::OceanFloorWg)?;
    // rust: let rotation = super::Rotation::random(&mut random);
    // rust: let config = super::ocean_ruin::OceanRuinConfig {
    // rust: warm: *warm,
    // rust: large_probability: *large,
    // rust: cluster_probability: *cluster,
}
    // rust: let pieces = super::ocean_ruin::pieces(
    // rust: resources,
    // rust: bindings,
    // rust: [chunk.x * 16, 90, chunk.z * 16],
    // rust: rotation,
    // rust: &mut random,
    // rust: &config,
    // rust: )?;
    // rust: (stub, legacy(pieces))
}
    // rust: StructureKind::Mineshaft { mesa, blocking } => {
    // rust: let (sea, min) = (context.sea_level(), context.generator_min_y());
    // rust: let (position, pieces) = super::mineshaft::generate(
    // rust: &mut random,
    // rust: [chunk.x, chunk.z],
    // rust: *mesa,
    // rust: blocking.clone(),
    // rust: sea,
    // rust: min,
    // rust: &mut |x, z| context.base_height(x, z, HeightmapType::WorldSurfaceWg),
    // rust: );
    // rust: (position, legacy(pieces))
}
    // rust: StructureKind::Stronghold => {
    // rust: let (sea, min) = (context.sea_level(), context.generator_min_y());
    // rust: let pieces =
    // rust: super::stronghold::generate(&mut random, seed, [chunk.x, chunk.z], sea, min);
    // rust: ([chunk.x * 16, 0, chunk.z * 16], legacy(pieces))
}
    // rust: StructureKind::EndCity => {
    // rust: let (x, z) = (chunk.x * 16 + 7, chunk.z * 16 + 7);
    // rust: if !context.column_has_valid_biome(x, z, context.min_y() - 1, context.max_y()) {
    // rust: return None;
}
    // rust: let rotation = super::Rotation::random(&mut random);
    // rust: let (sx, sz) = match rotation {
    // rust: super::Rotation::None => (5, 5),
    // rust: super::Rotation::Clockwise90 => (-5, 5),
    // rust: super::Rotation::Clockwise180 => (-5, -5),
    // rust: super::Rotation::Counterclockwise90 => (5, -5),
}
    // rust: let y = corner_heights(context, x, sx, z, sz)
    // rust: .into_iter()
    // rust: .min()
    // rust: .unwrap_or(0);
    // rust: if y < 60 {
    // rust: return None;
}
    // rust: let start = [x, y, z];
    // rust: if !any_biome
    // rust: && !def
    // rust: .biomes
    // rust: .contains(&context.noise_biome(start.map(|v| v >> 2)))
    // rust: {
    // rust: return None;
}
    // rust: let pieces = super::end_city::pieces(resources, start, rotation, &mut random)?;
    // rust: (start, legacy(pieces))
}
    // rust: StructureKind::Fortress => {
    // rust: let pieces = super::fortress::generate(&mut random, [chunk.x, chunk.z]);
    // rust: ([chunk.x * 16, 64, chunk.z * 16], legacy(pieces))
}
    // rust: StructureKind::NetherFossil(height) => {
    // rust: let x = chunk.x * 16 + random.next_int_bound(16).unwrap_or(0);
    // rust: let z = chunk.z * 16 + random.next_int_bound(16).unwrap_or(0);
    // rust: let sea = context.sea_level();
    // rust: let y = height.sample(&mut random, context.generation()).ok()?;
    // rust: let columns = context.base_columns(
    // rust: x,
    // rust: z,
    // rust: &[HeightmapType::WorldSurfaceWg, HeightmapType::OceanFloorWg],
    // rust: );
    // rust: let y = super::nether_fossil::find_floor(
    // rust: &columns[0],
    // rust: &columns[1],
    // rust: context.min_y(),
    // rust: y,
    // rust: sea,
    // rust: )?;
    // rust: let position = [x, y, z];
    // rust: let quart = position.map(|v| v >> 2);
    // rust: if !any_biome && !def.biomes.contains(&context.noise_biome(quart)) {
    // rust: return None;
}
    // rust: let piece = super::nether_fossil::piece(resources, &mut random, position)?;
    // rust: (position, legacy(vec![piece]))
}
    // rust: StructureKind::Formations(formations) => {
    // rust: let (position, pieces) = super::formations::generate(
    // rust: formations,
    // rust: context,
    // rust: &registry.pools,
    // rust: resources,
    // rust: bindings,
    // rust: &mut random,
    // rust: chunk,
    // rust: )?;
    // rust: (position, pieces.into_iter().map(Piece::Pool).collect())
}
    // rust: StructureKind::Unsupported(_) => return None,
}
    // rust: let quart = position.map(|v| v >> 2);
    // rust: if (!any_biome && !def.biomes.contains(&context.noise_biome(quart))) || pieces.is_empty() {
    // rust: return None;
}
    // rust: Some(Generated::Start(StructureStart::new(
    // rust: structure, def, chunk, pieces,
    // rust: )))
}
    // rust: impl StructureStart {
    // A start of `def` (registry index `structure`) from its pieces, at
    // least one: their box, grown where the structure adapts the terrain.
new :: proc(structure: uint, def: ^StructureDef, chunk: ChunkPos, pieces: [dynamic]Piece) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let mut bounding_box = pieces[0].bounding_box();
    // rust: for piece in &pieces[1..] {
    // rust: bounding_box.encapsulate(&piece.bounding_box());
}
    // rust: if def.terrain != TerrainAdjustment::None {
    // rust: bounding_box = bounding_box.inflated(12, 12);
}
    // rust: if let Some(enhanced) = def.enhanced_terrain.as_ref().filter(|e| e.inflate) {
    // rust: let r = enhanced.radius();
    // rust: bounding_box = bounding_box.inflated(r, r);
}
    // rust: Self {
    // rust: structure,
    // rust: name: def.name.clone(),
    // rust: chunk,
    // rust: pieces,
    // rust: bounding_box,
}
}
}
// PoolAliasLookup.create.
resolve_aliases :: proc(bindings: ^[Value], position: [i32; 3], seed: i64) -> B {
    // Ported from Horizon
    return {}
}
    // rust: let mut map = BTreeMap::new();
    // rust: if bindings.is_empty() {
    // rust: return map;
}
    // rust: let mut random = LegacyRandom::new(seed).fork_positional().at(BlockPos::new(
    // rust: position[0],
    // rust: position[1],
    // rust: position[2],
    // rust: ));
visit :: proc(binding: ^Value, random: ^LegacyRandom, map: ^BTreeMap<string) {
}
    // rust: let weighted = |key: &str| -> Option<WeightedList<Value>> {
    // rust: let raw: Box<RawValue> = serde_json::from_str(&binding[key].to_string()).ok()?;
    // rust: WeightedList::decode(&raw, |v| Ok(serde_json::from_str::<Value>(v.get())?)).ok()
}
    // rust: match binding["type"].as_str().unwrap_or_default() {
    // rust: "minecraft:direct" => {
    // rust: map.insert(
    // rust: binding["alias"].as_str().unwrap_or_default().to_owned(),
    // rust: binding["target"].as_str().unwrap_or_default().to_owned(),
    // rust: );
}
    // rust: "minecraft:random" => {
    // rust: if let Some(target) =
    // rust: weighted("targets").and_then(|w| w.sample(random).ok().cloned())
    // rust: {
    // rust: map.insert(
    // rust: binding["alias"].as_str().unwrap_or_default().to_owned(),
    // rust: target.as_str().unwrap_or_default().to_owned(),
    // rust: );
}
}
    // rust: "minecraft:random_group" => {
    // rust: if let Some(group) = weighted("groups").and_then(|w| w.sample(random).ok().cloned())
    // rust: {
    // rust: for b in group.as_array().into_iter().flatten() {
    // rust: visit(b, random, map);
}
}
}
    // rust: _ => {}
}
}
    // rust: for binding in bindings {
    // rust: visit(binding, &mut random, &mut map);
}
    // rust: map
}

// Beardifier.forStructuresInChunk over the starts referencing a chunk.
    // rust: pub fn beardifier(
    // rust: registry: &StructureRegistry,
    // rust: starts: &[Arc<StructureStart>],
    // rust: chunk: ChunkPos,
    // rust: ) -> Option<Beardifier> {
    // rust: let (bx, bz) = (chunk.x * 16, chunk.z * 16);
    // rust: let mut rigids = Vec::new();
    // rust: let mut junctions = Vec::new();
    // rust: let mut any: Option<BoundingBox> = None;
    // rust: let include = |b: BoundingBox, any: &mut Option<BoundingBox>| match any {
    // rust: Some(a) => a.encapsulate(&b),
    // rust: None => *any = Some(b),
}
    // rust: let (mut kernel_pieces, mut kernel_junctions) = (Vec::new(), Vec::new());
    // rust: let mut kernels: Option<BoundingBox> = None;
    // rust: for start in starts {
    // rust: let def = &registry.structures[start.structure];
    // rust: if let Some(enhanced) = &def.enhanced_terrain {
    // rust: if let Some(b) =
    // rust: enhanced.collect(start, chunk, &mut kernel_pieces, &mut kernel_junctions)
    // rust: {
    // rust: include(b, &mut kernels);
}
}
    // rust: let adjustment = def.terrain;
    // rust: if adjustment == TerrainAdjustment::None {
    // rust: continue;
}
    // rust: for piece in &start.pieces {
    // rust: let b = piece.bounding_box();
    // rust: let near = b.max[0] >= bx - 12
    // rust: && b.min[0] <= bx + 15 + 12
    // rust: && b.max[2] >= bz - 12
    // rust: && b.min[2] <= bz + 15 + 12;
    // rust: if !near {
    // rust: continue;
}
    // rust: let Piece::Pool(pool) = piece else {
    // rust: rigids.push(RigidPiece {
    // rust: bounds: StructureBounds::new(b.min, b.max)?,
    // rust: adjustment,
    // rust: ground_level_delta: 0,
    // rust: });
    // rust: include(b, &mut any);
    // rust: continue;
}
    // rust: if pool.element.projection() == Projection::Rigid {
    // rust: rigids.push(RigidPiece {
    // rust: bounds: StructureBounds::new(b.min, b.max)?,
    // rust: adjustment,
    // rust: ground_level_delta: pool.ground_level_delta,
    // rust: });
    // rust: include(b, &mut any);
}
    // rust: for j in &pool.junctions {
    // rust: if j.source_x > bx - 12
    // rust: && j.source_z > bz - 12
    // rust: && j.source_x < bx + 15 + 12
    // rust: && j.source_z < bz + 15 + 12
    // rust: {
    // rust: junctions.push(JigsawJunction {
    // rust: source_x: j.source_x,
    // rust: source_ground_y: j.source_ground_y,
    // rust: source_z: j.source_z,
    // rust: });
    // rust: let p = [j.source_x, j.source_ground_y, j.source_z];
    // rust: include(BoundingBox::new(p, p), &mut any);
}
}
}
}
    // The libraries' kernels reach as far as their radius, beyond vanilla's.
    // rust: let mut affected = any.map(|a| a.inflated(24, 24));
    // rust: if let Some(k) = kernels {
    // rust: include(k, &mut affected);
}
    // rust: let affected = affected?;
    // rust: Some(
    // rust: Beardifier::new(
    // rust: rigids,
    // rust: junctions,
    // rust: StructureBounds::new(affected.min, affected.max),
    // rust: )
    // rust: .with_kernels(kernel_pieces, kernel_junctions),
    // rust: )
}

// StructureStart.placeInChunk for pieces intersecting the chunk's writable box.
    // rust: pub fn place_in_chunk<W: FeatureWorld + PlacementContext, R: RandomSource + 'static>(
    // rust: start: &StructureStart,
    // rust: world: &mut W,
    // rust: resources: &StructureResources,
    // rust: blocks: &dyn crate::worldgen::structure::legacy::SolidRender,
    // rust: random: &mut R,
    // rust: chunk_box: BoundingBox,
    // rust: place_feature: &mut PlaceFeature<'_, W, R>,
    // rust: ) -> Result<(), PlacementQueryError> {
    // rust: let Some(first) = start.pieces.first() else {
    // rust: return Ok(());
}
    // rust: let center_box = first.bounding_box();
    // rust: let center = center_box.center();
    // rust: let reference = [center[0], center_box.min[1], center[2]];
    // rust: for piece in &start.pieces {
    // rust: if piece.bounding_box().intersects(&chunk_box) {
    // rust: match piece {
    // rust: Piece::Pool(p) => {
    // rust: p.place(
    // rust: world,
    // rust: resources,
    // rust: random,
    // rust: chunk_box,
    // rust: reference,
    // rust: false,
    // rust: place_feature,
    // rust: )?;
}
    // rust: Piece::Legacy(p) => {
    // rust: let mut context = PieceContext {
    // rust: world,
    // rust: resources,
    // rust: blocks,
    // rust: random,
    // rust: chunk_box,
    // rust: chunk: ChunkPos::new(chunk_box.min[0] >> 4, chunk_box.min[2] >> 4),
    // rust: reference,
}
    // rust: p.post_process(&mut context)?;
}
}
}
}
    // rust: if let Piece::Legacy(p) = first {
    // rust: let boxes: Vec<BoundingBox> = start.pieces.iter().map(Piece::bounding_box).collect();
    // rust: let mut context = PieceContext {
    // rust: world,
    // rust: resources,
    // rust: blocks,
    // rust: random,
    // rust: chunk_box,
    // rust: chunk: ChunkPos::new(chunk_box.min[0] >> 4, chunk_box.min[2] >> 4),
    // rust: reference,
}
    // rust: p.after_place(&mut context, &boxes)?;
}
    // rust: Ok(())
}

    // rust: mod tests {
//     use super::*;
//     use serde_json::json;

registry :: proc(structures: ^[(string) {
}
    // rust: let text = |l: &[(&str, Value)]| {
    // rust: l.iter()
    // rust: .map(|(k, v)| ((*k).to_owned(), v.to_string()))
    // rust: .collect::<BTreeMap<_, _>>()
}
        // Biome tags: `#t:one` is biome 1, `#t:two` biome 2.
    // rust: StructureRegistry::new(&text(structures), &text(sets), BTreeMap::new(), &|v| {
    // rust: Ok(match v.as_str() {
    // rust: Some("#t:one") => BTreeSet::from([BiomeId(1)]),
    // rust: Some("#t:two") => BTreeSet::from([BiomeId(2)]),
    // rust: _ => BTreeSet::new(),
    // rust: })
    // rust: })
    // rust: .unwrap()
}

try_registry :: proc(placement: Value) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let structures = BTreeMap::from([(
    // rust: "t:s".to_owned(),
    // rust: json!({"type": "minecraft:igloo", "biomes": []}).to_string(),
    // rust: )]);
    // rust: let sets = BTreeMap::from([(
    // rust: "t:set".to_owned(),
    // rust: json!({"structures": [{"structure": "t:s", "weight": 1}],
    // rust: "placement": placement})
    // rust: .to_string(),
    // rust: )]);
    // rust: StructureRegistry::new(
    // rust: &structures,
    // rust: &sets,
    // rust: BTreeMap::new(),
    // rust: &|_| Ok(BTreeSet::new()),
    // rust: )
}

a_random_spread_needs_more_spacing_than_separation :: proc() {
}
        // RandomSpreadStructurePlacement.validate: "Spacing has to be larger
        // than separation", and the codec's intRange(0, 4096) on both.
    // rust: let spread = |spacing: i64, separation: i64| {
    // rust: json!({"type": "minecraft:random_spread", "spacing": spacing,
    // rust: "separation": separation})
}
    // rust: assert!(try_registry(spread(8, 8)).is_err(), "separation == spacing");
    // rust: assert!(try_registry(spread(4, 8)).is_err(), "separation > spacing");
    // rust: assert!(try_registry(spread(0, 0)).is_err(), "both zero");
    // rust: assert!(try_registry(spread(4097, 0)).is_err(), "spacing past 4096");
    // rust: assert!(try_registry(spread(8, -1)).is_err(), "negative separation");
    // rust: assert!(try_registry(spread(8, 7)).is_ok());
    // rust: assert!(try_registry(spread(4096, 0)).is_ok());
}

a_structure_set_frequency_is_a_fraction :: proc() {
}
        // Codec.floatRange(0.0F, 1.0F) on frequency.
    // rust: let set = |frequency: Value| {
    // rust: json!({"type": "minecraft:random_spread", "spacing": 8, "separation": 4,
    // rust: "frequency": frequency})
}
    // rust: assert!(try_registry(set(json!(1.5))).is_err());
    // rust: assert!(try_registry(set(json!(-0.25))).is_err());
    // rust: assert!(try_registry(set(json!(1.0))).is_ok());
    // rust: assert!(try_registry(set(json!(0.0))).is_ok());
}

dimension_origin_places_the_generators_origin_chunk_alone :: proc() {
}
    // rust: let mut r = registry(
    // rust: &[("t:s", json!({"type": "minecraft:igloo", "biomes": []}))],
    // rust: &[(
    // rust: "t:origin",
    // rust: json!({"structures": [{"structure": "t:s", "weight": 1}],
    // rust: "placement": {"type": "minecraft:dimension_origin"}}),
    // rust: )],
    // rust: );
    // rust: let set = |r: &StructureRegistry, name: &str| {
    // rust: r.sets.iter().position(|set| set.name == name).unwrap()
}
    // rust: let at = |r: &StructureRegistry, x: i32, z: i32| {
    // rust: r.is_structure_chunk(&r.sets[set(r, "t:origin")], 0, x, z, &Rings::new())
}
        // ChunkGenerator.getOrigin is chunk 0 0 until a generator says otherwise.
    // rust: assert_eq!(r.dimension_origin(), ChunkPos::new(0, 0));
    // rust: assert!(at(&r, 0, 0), "the origin chunk holds the start");
    // rust: assert!(!at(&r, 1, 0));
    // rust: assert!(!at(&r, 0, -1));
    // rust: assert!(r.needs_dimension_origin());
    // rust: r.set_dimension_origin(ChunkPos::new(-37, 12));
    // rust: assert!(at(&r, -37, 12));
    // rust: assert!(!at(&r, 0, 0), "the origin moved with the generator's");
    // rust: assert!(!at(&r, -36, 12));
    // rust: assert!(!at(&r, -37, 13));
}

dimension_origin_ignores_a_frequency_and_an_exclusion_zone :: proc() {
}
        // DimensionOriginStructurePlacement is no
        // AbstractSpreadingStructurePlacement: the generator's origin chunk
        // decides alone, with no frequency reduction and no exclusion zone.
    // rust: let mut r = registry(
    // rust: &[("t:s", json!({"type": "minecraft:igloo", "biomes": []}))],
    // rust: &[
    // rust: (
    // rust: "t:origin",
    // rust: json!({"structures": [{"structure": "t:s", "weight": 1}],
    // rust: "placement": {"type": "minecraft:dimension_origin",
    // rust: "frequency": 0.0,
    // rust: "exclusion_zone": {"other_set": "t:other", "chunk_count": 8}}}),
    // rust: ),
    // rust: (
    // rust: "t:other",
    // rust: json!({"structures": [{"structure": "t:s", "weight": 1}],
    // rust: "placement": {"type": "minecraft:random_spread", "spacing": 1,
    // rust: "separation": 0, "salt": 1}}),
    // rust: ),
    // rust: ],
    // rust: );
    // rust: let set = |r: &StructureRegistry, name: &str| {
    // rust: r.sets.iter().position(|set| set.name == name).unwrap()
}
    // rust: r.set_dimension_origin(ChunkPos::new(2, 2));
        // The other set spreads over every chunk, so its zone covers the origin.
    // rust: assert!(r.is_structure_chunk(&r.sets[set(&r, "t:other")], 0, 2, 2, &Rings::new()));
    // rust: assert!(r.is_structure_chunk(&r.sets[set(&r, "t:origin")], 0, 2, 2, &Rings::new()));
    // rust: assert!(!r.is_structure_chunk(&r.sets[set(&r, "t:origin")], 0, 3, 2, &Rings::new()));
}

exclusion_zones_may_skip_the_other_sets_own :: proc() {
}
    // rust: let set = |avoid: Value| {
    // rust: json!({"structures": [{"structure": "t:s", "weight": 1}],
    // rust: "placement": {"type": "minecraft:random_spread", "spacing": 1, "separation": 0,
    // rust: "salt": 1, "horizon:exclusion_zone": avoid}})
}
    // rust: let r = registry(
    // rust: &[("t:s", json!({"type": "minecraft:igloo", "biomes": []}))],
    // rust: &[
    // rust: ("t:c", set(json!({"other_sets": [], "chunk_count": 0}))),
                // Every chunk is b's spread chunk, and c keeps b out of all.
    // rust: ("t:b", set(json!({"other_sets": ["t:c"], "chunk_count": 1}))),
    // rust: (
    // rust: "t:full",
    // rust: set(json!({"other_sets": ["t:b"], "chunk_count": 1})),
    // rust: ),
    // rust: (
    // rust: "t:spread",
    // rust: set(json!({"other_sets": ["t:b"], "chunk_count": 1, "their_zones": false})),
    // rust: ),
    // rust: ],
    // rust: );
    // rust: let chunk = |name: &str| {
    // rust: let s = r.sets.iter().find(|s| s.name == name).unwrap();
    // rust: r.is_structure_chunk(s, 0, 5, -3, &Rings::new())
}
    // rust: assert!(!chunk("t:b"));
    // rust: assert!(
    // rust: chunk("t:full"),
    // rust: "b places nothing once its own zone is checked"
    // rust: );
    // rust: assert!(!chunk("t:spread"), "b's spread alone is in range");
}

ring_sections_keep_the_odd_rings :: proc() {
}
    // rust: let rings = RingSections::decode(
    // rust: &json!({"distance_to_first_ring": 80, "thickness": 96, "max_section": 3}),
    // rust: );
        // (d + 16) / 96: 0 inside 80 chunks, 1 to 175, 2 to 271, 3 to 367.
    // rust: assert!(!rings.allows(79, 0));
    // rust: assert!(rings.allows(80, 0));
    // rust: assert!(rings.allows(0, -175));
    // rust: assert!(!rings.allows(176, 0));
    // rust: assert!(rings.allows(272, 0));
    // rust: assert!(!rings.allows(464, 0), "section 5 is past max_section 3");
        // Java's int square wraps: 50,000² + 0 is negative, its root NaN, 0.
    // rust: assert!(!rings.allows(50_000, 0));
    // rust: let open = RingSections::decode(&json!({"distance_to_first_ring": 80, "thickness": 96}));
    // rust: assert!(open.allows(464, 0));
}

avoid_biomes_samples_around_the_middle_block :: proc() {
}
    // rust: let r = registry(
    // rust: &[],
    // rust: &[(
    // rust: "yung:temples",
    // rust: json!({"structures": [], "placement": {"type": "minecraft:random_spread",
    // rust: "spacing": 24, "separation": 8, "salt": 1,
    // rust: "horizon:avoid_biomes": {"biomes": ["#t:one", "#t:two"],
    // rust: "radius": 48, "step": 2, "y": 120}}}),
    // rust: )],
    // rust: );
    // rust: let avoid = r.sets[0].avoid_biomes.as_ref().unwrap();
    // rust: assert_eq!(avoid.biomes, BTreeSet::from([BiomeId(1), BiomeId(2)]));
        // Chunk (1, -1): middle block (24, 120, -8), quart (6, 30, -2).
    // rust: let mut asked = Vec::new();
    // rust: assert!(!avoid.near(ChunkPos::new(1, -1), |q| {
    // rust: asked.push(q);
    // rust: BiomeId(0)
    // rust: }));
    // rust: assert_eq!(asked[0], [6, 30, -2]);
        // Every even offset within 12 quarts, once: 13 x 13.
    // rust: assert_eq!(asked.len(), 169);
    // rust: assert!(asked.contains(&[6 - 12, 30, -2 + 12]));
    // rust: assert!(!asked.contains(&[7, 30, -2]));
        // An ocean on the edge of the square is found.
    // rust: assert!(avoid.near(ChunkPos::new(1, -1), |q| {
    // rust: BiomeId(if q == [18, 30, 10] { 2 } else { 0 })
    // rust: }));
}
}
