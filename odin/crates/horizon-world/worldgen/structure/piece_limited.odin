//! Transpiled from Horizon Rust crate
package horizon_world_piece_limited

import "core:fmt"
import "core:mem"
import "core:math"

// The piece-limited jigsaw assembler of Repurposed Structures and Moog's
// Structure Lib (PieceLimitedJigsawManager, the same code in both), for
// their structures carried over from a modpack (docs/modpacks.md). Carry
// maps their jigsaw types to `minecraft:jigsaw` with a
// `"horizon:piece_limited"` key; vanilla data never has it.
//
// ```json
// "horizon:piece_limited": {
//   "library": "moogs",            // or "repurposed": their few differences
//   "min_y": 40, "max_y": 120,     // y_allowance: pieces stay inside, unless buried
//   "burying": "lowest_corner",    // or "average_land", "lowest_side"
//   "no_liquid": true,             // cannot_spawn_in_liquid, as burying reads it
//   "ignore_bounds_pools": ["x:pool"],
//   "land_search": "highest_land", // the Nether variants: or "lowest_land", "fixed_height"
//   "ledge_offset_y": 2,
//   "pieces": [{"name": "x:piece", "required": 1, "min_depth": 3, "max": 2}],
//   "layout": "mineshaft"          // Repurposed's mineshafts: moved under the terrain
// }
// ```
//
// It differs from vanilla's JigsawPlacement: a fresh random seeded by the
// chunk, the start piece drawn uniformly and moved to the surface at its
// center, a bounding volume 120 blocks down and 180 up, children drawn by
// weight from the pools' weighted entries in order (`nextInt(total) + 1`,
// counted down), pieces capped by template (`max`) and some required
// (`required`, from `min_depth`), the whole layout retried up to 40 times
// until every required piece is in, and after it the pieces centred on the
// chunk corner, then buried in the terrain or moved onto Nether land.
// Repurposed's overworld mineshafts are not centred: their top goes 15
// blocks under the terrain around the chunk.
// use super::{
    // rust: BoundingBox, Rotation, StructureResources, StructureTemplate,
    // rust: jigsaw::{
    // rust: Free, JigsawConfig, Junction, PoolElement, PoolPiece, Pools, Projection, can_attach,
    // rust: shuffle, step,
    // rust: },
    // rust: start::StartContext,
}
// use crate::{
    // rust: heightmap::HeightmapType, identifier::Identifier, java_hash_map::JavaHashMap,
    // rust: worldgen::block_feature::FeatureBlockBindings,
}
// use horizon_core::{
    // rust: position::ChunkPos,
    // rust: random::{LegacyRandom, RandomSource, WorldgenRandom},
}
// use serde_json::Value;
// use std::{
    // rust: cell::RefCell,
    // rust: collections::{HashSet, VecDeque},
    // rust: rc::Rc,
    // rust: sync::Arc,
}

// Which mod's copy of the code: they differ in a few post-layout steps.
Library :: enum {
    Moogs,
    Repurposed,
}

Burying :: enum {
    LowestCorner,
    AverageLand,
    LowestSide,
}

// The structure type's postLayoutAdjustments.
Layout :: enum {
    // GenericJigsawStructure's: centred, then buried or moved onto land.
    Generic,
    // Repurposed Structures' MineshaftStructure.
    Mineshaft,
}

LandSearch :: enum {
    Highest,
    Lowest,
    Fixed,
}

// One template's counts (`*_pieces_spawn_counts`).
Counted :: struct {
    required: Maybe(i32),
    min_depth: i32,
    max: Maybe(i32),
}

// `"horizon:piece_limited"` of a jigsaw structure.
Config :: struct {
    library: Library,
    min_y: Maybe(i32),
    max_y: Maybe(i32),
    burying: Maybe(Burying),
    no_liquid: bool,
    ignore_bounds: map[string]struct{},
    land_search: Maybe(LandSearch),
    ledge: i32,
    layout: Layout,
    // Counted templates by id, in the order of Java's HashMap of the
    // required pieces (the first one still short is forced in first).
    pieces: Vec<(Identifier,
}

    // rust: impl Config {
decode :: proc(v: ^Value) -> S {
    // Ported from Horizon
    return {}
}
    // rust: let int = |k: &str| v[k].as_i64().map(|n| n as i32);
    // rust: let mut pieces: Vec<(Identifier, Counted)> = Vec::new();
    // rust: for p in v["pieces"].as_array().into_iter().flatten() {
    // rust: let Some(id) = p["name"].as_str().and_then(|n| Identifier::parse(n).ok()) else {
    // rust: continue;
}
    // rust: let counted = Counted {
    // rust: required: p["required"].as_i64().map(|n| n as i32),
    // rust: min_depth: p["min_depth"].as_i64().unwrap_or(0) as i32,
    // rust: max: p["max"].as_i64().map(|n| n as i32),
}
            // A later entry for the same piece replaces it, as HashMap.put.
    // rust: match pieces.iter_mut().find(|(k, _)| *k == id) {
    // rust: Some(slot) => slot.1 = counted,
    // rust: None => pieces.push((id, counted)),
}
}
        // getRequirePieces builds a HashMap of the required ones and the
        // assembler copies it (new HashMap(map)): iterate as that copy does.
    // rust: let mut map = JavaHashMap::default();
    // rust: for (i, (id, c)) in pieces.iter().enumerate() {
    // rust: if c.required.is_some() {
    // rust: map.put(id.clone(), i);
}
}
    // rust: let order: Vec<usize> = map.copied().entries().map(|(_, &i)| i).collect();
    // rust: let mut sorted: Vec<(Identifier, Counted)> =
    // rust: order.iter().map(|&i| pieces[i].clone()).collect();
    // rust: sorted.extend(pieces.iter().filter(|(_, c)| c.required.is_none()).cloned());
    // rust: Self {
    // rust: library: match v["library"].as_str() {
    // rust: Some("repurposed") => Library::Repurposed,
    // rust: _ => Library::Moogs,
    // rust: },
    // rust: min_y: int("min_y"),
    // rust: max_y: int("max_y"),
    // rust: burying: match v["burying"].as_str() {
    // rust: Some("lowest_corner") => Some(Burying::LowestCorner),
    // rust: Some("average_land") => Some(Burying::AverageLand),
    // rust: Some("lowest_side") => Some(Burying::LowestSide),
    // rust: _ => None,
    // rust: },
    // rust: no_liquid: v["no_liquid"].as_bool().unwrap_or(false),
    // rust: ignore_bounds: v["ignore_bounds_pools"]
    // rust: .as_array()
    // rust: .into_iter()
    // rust: .flatten()
    // rust: .filter_map(|p| Some(p.as_str()?.to_owned()))
    // rust: .collect(),
    // rust: land_search: match v["land_search"].as_str() {
    // rust: Some("highest_land") => Some(LandSearch::Highest),
    // rust: Some("lowest_land") => Some(LandSearch::Lowest),
    // rust: Some("fixed_height") => Some(LandSearch::Fixed),
    // rust: _ => None,
    // rust: },
    // rust: ledge: int("ledge_offset_y").unwrap_or(0),
    // rust: layout: match v["layout"].as_str() {
    // rust: Some("mineshaft") => Layout::Mineshaft,
    // rust: _ => Layout::Generic,
    // rust: },
    // rust: pieces: sorted,
}
}
required :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.pieces
    // rust: .iter()
    // rust: .map(|(_, c)| c)
    // rust: .filter(|c| c.required.is_some())
}
}

// The counted templates, loaded, in [`Config::pieces`] order.
Counts :: struct {
    // rust: impl Counts {
new :: proc(limits: ^Config, resources: ^StructureResources) -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self(
    // rust: limits
    // rust: .pieces
    // rust: .iter()
    // rust: .map(|(id, _)| {
    // rust: resources
    // rust: .template(&id.to_string())
    // rust: .unwrap_or_else(|| Arc::new(StructureTemplate::empty()))
    // rust: })
    // rust: .collect(),
    // rust: )
}
    // The index of a single element's template among the counted ones.
of :: proc(self: ^Self, element: ^PoolElement) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let PoolElement::Single { template, .. } = element else {
    // rust: return None;
}
    // rust: self.0.iter().position(|t| Arc::ptr_eq(t, template))
}
}

// PieceLimitedJigsawManager.assembleJigsawStructure and the structure's
// postLayoutAdjustments: the start's center and the pieces, or None when
// nothing starts. `start` is the chunk's corner at the sampled start height.
    // rust: pub fn assemble(
    // rust: config: &JigsawConfig<'_>,
    // rust: limits: &Config,
    // rust: context: &mut impl StartContext,
    // rust: pools: &Pools,
    // rust: resources: &StructureResources,
    // rust: bindings: &FeatureBlockBindings<'_>,
    // rust: chunk: ChunkPos,
    // rust: start: [i32; 3],
    // rust: ) -> Option<([i32; 3], Vec<PoolPiece>)> {
    // rust: let mut random = WorldgenRandom::new(LegacyRandom::new(0));
    // rust: random.set_large_feature_seed(context.seed(), chunk.x, chunk.z);
    // rust: let rotation = Rotation::random(&mut random);
    // rust: let pool = pools.get(config.start_pool, resources, bindings)?;
    // An empty start pool crashes the mod's generation; nothing starts.
    // rust: if pool.templates.is_empty() {
    // rust: return None;
}
    // rust: let element = pool.random_template(&mut random);
    // rust: if matches!(element.as_ref(), PoolElement::Empty) {
    // rust: return None;
}
    // rust: let mut first = PoolPiece {
    // rust: bounding_box: element.bounding_box(start, rotation),
    // rust: ground_level_delta: element.ground_level_delta(),
    // rust: element,
    // rust: position: start,
    // rust: rotation,
    // rust: junctions: Vec::new(),
    // rust: waterlogging: config.waterlogging,
}
    // rust: let b = first.bounding_box;
    // rust: let (cx, cz) = ((b.max[0] + b.min[0]) / 2, (b.max[2] + b.min[2]) / 2);
    // rust: let top = limits.max_y.unwrap_or(i32::MAX);
    // rust: let bottom = limits.min_y.unwrap_or(i32::MIN);
    // rust: let cy = match config.project_to {
    // rust: Some(kind) => {
    // rust: let y = start[1] + context.base_height(cx, cz, kind);
    // rust: if y > top || y < bottom {
    // rust: return None;
}
    // rust: y
}
    // rust: None => start[1],
}
    // rust: first.moved(cy - (b.min[1] + first.ground_level_delta));
    // rust: let start_box = first.bounding_box;
    // rust: let (start_position, start_rotation) = (first.position, first.rotation);
    // rust: let counts = Counts::new(limits, resources);
    // rust: let run_once = limits.required().next().is_none();
    // rust: let mut pieces = vec![first];
    // rust: let mut attempts = 0;
    // `for (attempts = 0; runOnce || doesNotHaveAllRequiredPieces(...); attempts++)`:
    // the first test sees the start piece alone.
    // rust: while run_once || lacks_required(limits, &counts, &pieces) {
    // rust: if attempts == 40 {
    // rust: break;
}
    // rust: if attempts > 0 {
    // rust: let element = pool.random_template(&mut random);
    // rust: pieces = vec![PoolPiece {
    // rust: bounding_box: element.bounding_box(start_position, start_rotation),
    // rust: ground_level_delta: element.ground_level_delta(),
    // rust: element,
    // rust: position: start_position,
    // rust: rotation: start_rotation,
    // rust: junctions: Vec::new(),
    // rust: waterlogging: config.waterlogging,
    // rust: }];
    // rust: } else {
    // rust: pieces.truncate(1);
}
    // rust: if config.max_depth > 0 {
    // rust: let r = config.max_distance[0];
    // rust: let free = Rc::new(RefCell::new(Free {
    // rust: container: BoundingBox::new([cx - r, cy - 120, cz - r], [cx + r, cy + 180, cz + r]),
    // rust: removed: vec![start_box],
    // rust: }));
    // rust: let buried = limits.burying.is_some();
    // rust: let mut assembler = Assembler {
    // rust: config,
    // rust: limits,
    // rust: counted: &counts,
    // rust: pools,
    // rust: resources,
    // rust: bindings,
    // rust: pieces: std::mem::take(&mut pieces),
    // rust: states: vec![(free, 0)],
    // rust: counts: vec![0; limits.pieces.len()],
    // rust: max_y: if buried { i32::MAX } else { top },
    // rust: min_y: if buried { i32::MIN } else { bottom },
}
    // rust: let mut queue = VecDeque::from([0]);
    // rust: while let Some(piece) = queue.pop_front() {
    // rust: assembler.children(piece, &mut queue, context, &mut random);
}
    // rust: pieces = assembler.pieces;
}
    // rust: if run_once {
    // rust: break;
}
    // rust: attempts += 1;
}
    // rust: adjust(config, limits, context, start, &mut pieces);
    // rust: if pieces.is_empty() {
    // rust: return None;
}
    // rust: let mut whole = pieces[0].bounding_box;
    // rust: for p in &pieces[1..] {
    // rust: whole.encapsulate(&p.bounding_box);
}
    // The builder is cleared when the layout reaches past the build height.
    // rust: if whole.max[1] > context.max_y() + 1 {
    // rust: return None;
}
    // rust: Some(([cx, cy, cz], pieces))
}

// doesNotHaveAllRequiredPieces.
lacks_required :: proc(limits: ^Config, counts: ^Counts, pieces: ^[PoolPiece]) -> b {
    // Ported from Horizon
    return {}
}
    // rust: let mut left: Vec<i32> = limits
    // rust: .pieces
    // rust: .iter()
    // rust: .map(|(_, c)| c.required.unwrap_or(0))
    // rust: .collect();
    // rust: for p in pieces {
    // rust: if let Some(i) = counts.of(&p.element) {
    // rust: left[i] -= 1;
}
}
    // rust: left.iter().any(|&n| n > 0)
}

// Moves a piece; Repurposed Structures' movePieceProperly also writes its
// junctions, all three setters into the source X, so only the last sticks.
shift :: proc(limits: ^Config, piece: ^PoolPiece, d: [i32; 3]) {
}
    // rust: piece.position = std::array::from_fn(|i| piece.position[i] + d[i]);
    // rust: piece.bounding_box = piece.bounding_box.moved(d);
    // rust: if limits.library == Library::Repurposed {
    // rust: for j in &mut piece.junctions {
    // rust: j.source_x = j.source_z + d[2];
}
}
}
shift_all :: proc(limits: ^Config, pieces: ^[PoolPiece], d: [i32; 3]) {
}
    // rust: for p in pieces {
    // rust: shift(limits, p, d);
}
}

// The structure's postLayoutAdjustments.
    // rust: fn adjust(
    // rust: config: &JigsawConfig<'_>,
    // rust: limits: &Config,
    // rust: context: &mut impl StartContext,
    // rust: start: [i32; 3],
    // rust: pieces: &mut Vec<PoolPiece>,
    // rust: ) {
    // rust: if pieces.is_empty() {
    // rust: return;
}
    // rust: if limits.layout == Layout::Mineshaft {
    // rust: below_terrain(limits, context, start, pieces);
    // rust: return;
}
    // GeneralUtils.centerAllPieces on the chunk's corner.
    // rust: let center = pieces[0].bounding_box.center();
    // rust: let d = [start[0] - center[0], 0, start[2] - center[2]];
    // rust: for p in pieces.iter_mut() {
        // Centring uses StructurePiece.move in both mods.
    // rust: p.position = std::array::from_fn(|i| p.position[i] + d[i]);
    // rust: p.bounding_box = p.bounding_box.moved(d);
}
    // rust: let offset_y = start[1];
    // rust: let sea = context.sea_level();
    // rust: if let Some(search) = limits.land_search {
    // rust: nether(limits, context, search, offset_y, pieces);
    // rust: return;
}
    // rust: let Some(burying) = limits.burying else {
    // rust: return;
}
    // rust: let kind = config.project_to.unwrap_or(HeightmapType::WorldSurfaceWg);
    // rust: let ocean_floor = matches!(
    // rust: kind,
    // rust: HeightmapType::OceanFloorWg | HeightmapType::OceanFloor
    // rust: );
    // rust: let box0 = pieces[0].bounding_box;
    // rust: let mut land = match burying {
    // rust: Burying::LowestCorner => [
    // rust: (box0.min[0], box0.min[2]),
    // rust: (box0.min[0], box0.max[2]),
    // rust: (box0.max[0], box0.min[2]),
    // rust: (box0.max[0], box0.max[2]),
    // rust: ]
    // rust: .into_iter()
    // rust: .map(|(x, z)| context.base_height(x, z, kind) - 1)
    // rust: .min()
    // rust: .unwrap_or(0),
    // rust: Burying::LowestSide => {
    // rust: let c = box0.center();
    // rust: let mut highest = i32::MAX;
    // rust: for (x, z) in [
    // rust: (box0.min[0], c[2]),
    // rust: (c[0], box0.max[2]),
    // rust: (c[0], box0.min[2]),
    // rust: (box0.max[0], c[2]),
    // rust: ] {
                // getFirstOccupiedHeight (Repurposed's cached free height - 1).
    // rust: let land = context.base_height(x, z, kind) - 1;
    // rust: match limits.min_y {
    // rust: Some(min) if land >= min => highest = land,
    // rust: Some(_) => {}
    // rust: None => highest = highest.min(land),
}
}
    // rust: if let Some(min) = limits.min_y.filter(|_| highest == i32::MAX) {
    // rust: highest = min;
}
    // rust: highest
}
    // rust: Burying::AverageLand => {
    // rust: average_land(limits, context, kind, ocean_floor, offset_y, pieces);
    // rust: return;
}
}
    // rust: if limits.no_liquid || !ocean_floor {
    // rust: land = land.max(sea);
    // rust: } else {
    // rust: land = land.min(sea - box0.span()[1]);
}
    // offsetToNewHeight.
    // rust: if limits.max_y.is_some()
    // rust: && let Some(min) = limits.min_y
    // rust: && box0.max[1] + offset_y < min
    // rust: {
    // rust: land = land.max(limits.max_y.unwrap_or(land));
}
    // rust: if let Some(min) = limits.min_y
    // rust: && box0.min[1] + offset_y < min
    // rust: {
    // rust: land = land.min(min);
}
    // rust: let dy = land - box0.min[1] + offset_y;
    // rust: shift_all(limits, pieces, [0, dy, 0]);
}

// MineshaftStructure.postLayoutAdjustments: the layout's top moved to 15
// blocks under the lowest ocean floor at the chunk's middle and 16 blocks
// to each side, within y_allowance; never up.
    // rust: fn below_terrain(
    // rust: limits: &Config,
    // rust: context: &mut impl StartContext,
    // rust: start: [i32; 3],
    // rust: pieces: &mut [PoolPiece],
    // rust: ) {
    // rust: let target = mineshaft_top(start, limits.min_y, |x, z| {
    // rust: context.base_height(x, z, HeightmapType::OceanFloorWg)
    // rust: });
    // rust: let top = pieces
    // rust: .iter()
    // rust: .map(|p| p.bounding_box.max[1])
    // rust: .max()
    // rust: .unwrap_or(i32::MIN);
    // rust: if target < limits.max_y.unwrap_or(i32::MAX) && target < top {
    // rust: shift_all(limits, pieces, [0, target - top, 0]);
}
}

// Where [`below_terrain`] puts a mineshaft's top: `floor` is the first free
// height over the ocean floor (getFirstFreeHeight, OCEAN_FLOOR_WG).
    // rust: fn mineshaft_top(
    // rust: start: [i32; 3],
    // rust: min_y: Option<i32>,
    // rust: mut floor: impl FnMut(i32, i32) -> i32,
    // rust: ) -> i32 {
    // rust: let (x, z) = (start[0] + 7, start[2] + 7);
    // rust: let mut terrain = floor(x, z) - 1;
    // Plane.HORIZONTAL's order; the mod takes one more off after each.
    // rust: for (dx, dz) in [(0, -16), (16, 0), (0, 16), (-16, 0)] {
    // rust: terrain = terrain.min(floor(x + dx, z + dz)) - 1;
}
    // rust: (terrain - 15).max(min_y.unwrap_or(i32::MIN))
}

// AVERAGE_LAND: the mean land height over a grid on the first piece's
// footprint; no structure when none of the heights is allowed.
    // rust: fn average_land(
    // rust: limits: &Config,
    // rust: context: &mut impl StartContext,
    // rust: kind: HeightmapType,
    // rust: ocean_floor: bool,
    // rust: offset_y: i32,
    // rust: pieces: &mut Vec<PoolPiece>,
    // rust: ) {
    // rust: let b = pieces[0].bounding_box;
    // rust: let c = b.center();
    // rust: let (lx, lz) = (b.max[0] - b.min[0], b.max[2] - b.min[2]);
    // rust: let radius = (f64::from(lx * lx + lz * lz).sqrt() as i32) / 2;
    // The mod's loop never ends with a step of 0; one block apart instead.
    // rust: let step = (radius / 2).max(1);
    // rust: let (min, max) = (
    // rust: limits.min_y.unwrap_or(i32::MIN),
    // rust: limits.max_y.unwrap_or(i32::MAX),
    // rust: );
    // rust: let (mut sum, mut n) = (0i64, 0i64);
    // rust: let mut x = -radius;
    // rust: while x <= radius {
    // rust: let mut z = -radius;
    // rust: while z <= radius {
    // rust: let h = context.base_height(c[0] + x, c[2] + z, kind) - 1;
    // rust: if h > min && h < max {
    // rust: sum += i64::from(h);
    // rust: n += 1;
}
    // rust: z += step;
}
    // rust: x += step;
}
    // rust: let mut average = (n > 0).then(|| sum as f64 / n as f64);
    // rust: if average.is_none() {
    // rust: average = limits.max_y.or(limits.min_y).map(f64::from);
}
    // rust: let Some(mut average) = average else {
    // rust: pieces.clear();
    // rust: return;
}
    // rust: if limits.no_liquid && !ocean_floor {
    // rust: average = average.max(f64::from(context.sea_level()));
    // rust: if let Some(max) = limits.max_y {
            // Math.max, as the mod has it.
    // rust: average = average.max(f64::from(max));
}
}
    // rust: let dy = average as i32 - b.min[1] + offset_y;
    // rust: shift_all(limits, pieces, [0, dy, 0]);
}

// The Nether variants: onto the highest or lowest land at the layout's
// center (or a fixed height), a ledge above it, within y_allowance.
    // rust: fn nether(
    // rust: limits: &Config,
    // rust: context: &mut impl StartContext,
    // rust: search: LandSearch,
    // rust: offset_y: i32,
    // rust: pieces: &mut [PoolPiece],
    // rust: ) {
    // rust: let mut whole = pieces[0].bounding_box;
    // rust: for p in &pieces[1..] {
    // rust: whole.encapsulate(&p.bounding_box);
}
    // rust: let sea = context.sea_level();
    // rust: let generation = context.generation();
    // rust: let terrain_limit = generation.min_y + generation.height;
    // rust: let base = pieces[0].bounding_box.min[1];
    // rust: let found = |context: &mut dyn ColumnQuery, highest: bool| {
    // rust: let c = whole.center();
    // rust: context.land(c[0], c[2], highest, !limits.no_liquid, sea, terrain_limit)
}
    // rust: let mut target = match (limits.library, search) {
    // rust: (Library::Moogs, LandSearch::Fixed) => offset_y + limits.ledge,
    // rust: (library, search) => {
    // rust: let y = found(context, search == LandSearch::Highest);
    // rust: let at = if y < terrain_limit && y > sea + 1 {
    // rust: y
    // rust: } else {
    // rust: sea
}
    // rust: if library == Library::Repurposed {
    // rust: shift_all(limits, pieces, [0, at + limits.ledge - base, 0]);
    // rust: return;
}
    // rust: at + limits.ledge + offset_y
}
}
    // rust: let height = whole.max[1] - whole.min[1];
    // rust: let below = whole.min[1] - base;
    // rust: if let Some(top) = limits.max_y {
    // rust: target = target.min(top - height - below);
}
    // rust: if let Some(bottom) = limits.min_y {
    // rust: target = target.max(bottom - below);
}
    // rust: shift_all(limits, pieces, [0, target - base, 0]);
}

// GeneralUtils.getHighestLand and getLowestLand on the noise column.
    // rust: trait ColumnQuery {
    // rust: fn land(
    // rust: &mut self,
    // rust: x: i32,
    // rust: z: i32,
    // rust: highest: bool,
    // rust: on_liquid: bool,
    // rust: sea: i32,
    // rust: terrain_limit: i32,
    // rust: ) -> i32;
}
    // rust: impl<C: StartContext> ColumnQuery for C {
    // rust: fn land(
    // rust: &mut self,
    // rust: x: i32,
    // rust: z: i32,
    // rust: highest: bool,
    // rust: on_liquid: bool,
    // rust: sea: i32,
    // rust: terrain_limit: i32,
    // rust: ) -> i32 {
    // rust: let min = self.generation().min_y;
    // rust: let mut columns = self.base_columns(
    // rust: x,
    // rust: z,
    // rust: &[HeightmapType::WorldSurfaceWg, HeightmapType::OceanFloorWg],
    // rust: );
    // rust: let solid = columns.pop().unwrap_or_default();
    // rust: let filled = columns.pop().unwrap_or_default();
    // rust: land_in(&filled, &solid, min, highest, on_liquid, sea, terrain_limit)
}
}

// The land search over one noise column: `filled` (not air) and `solid`
// (canOcclude, for the noise's own blocks) from `min` up; past the
// column's ends a NoiseColumn reads air.
    // rust: fn land_in(
    // rust: filled: &[bool],
    // rust: solid: &[bool],
    // rust: min: i32,
    // rust: highest: bool,
    // rust: on_liquid: bool,
    // rust: sea: i32,
    // rust: terrain_limit: i32,
    // rust: ) -> i32 {
    // rust: let at = |c: &[bool], y: i32| {
    // rust: usize::try_from(y - min)
    // rust: .ok()
    // rust: .and_then(|i| c.get(i).copied())
    // rust: .unwrap_or(false)
}
    // rust: let air = |y: i32| !at(filled, y);
    // rust: let stands = |y: i32| if on_liquid { !air(y) } else { at(solid, y) };
    // rust: if highest {
    // rust: let mut y = terrain_limit - 40;
    // rust: while y > sea {
    // rust: if at(solid, y) && air(y + 3) && stands(y) {
    // rust: return y;
}
    // rust: y -= 1;
}
    // rust: y
    // rust: } else {
    // rust: let mut y = sea + 1;
    // rust: while y <= terrain_limit - 40 {
    // rust: if stands(y) && air(y + 1) && air(y + 5) {
    // rust: return y + 1;
}
    // rust: y += 1;
}
    // rust: sea
}
}

// PieceLimitedJigsawManager.Assembler.
Assembler :: struct {
    config: ^'a JigsawConfig<'a>,
    limits: ^'a Config,
    counted: ^'a Counts,
    pools: ^'a Pools,
    resources: ^'a StructureResources,
    bindings: ^'a FeatureBlockBindings<'a>,
    pieces: [dynamic]PoolPiece,
    // Per piece: the free space it was placed in, and its depth.
    states: [dynamic](^RefCell<Free,
    // Pieces placed per counted template.
    counts: [dynamic]i32,
    max_y: i32,
    min_y: i32,
}

// Where a child goes: the parent's jigsaw and what it needs.
Slot :: struct {
    source: uint,
    jigsaw: ^'s super::jigsaw::Jigsaw<'s>,
    target_pos: [i32,
    free: ^RefCell<Free>,
    depth: i32,
}

    // rust: impl Assembler<'_> {
pool :: proc(self: ^Self, name: string) -> O {
    // Ported from Horizon
    return {}
}
    // rust: let name = self.config.aliases.get(name).map_or(name, String::as_str);
    // rust: self.pools.get(name, self.resources, self.bindings)
}
    // generatePiece: one child per jigsaw where one fits, from the target
    // pool unless the piece is at the last depth, else from its fallback.
    // rust: fn children(
    // rust: &mut self,
    // rust: source: usize,
    // rust: queue: &mut VecDeque<usize>,
    // rust: context: &mut impl StartContext,
    // rust: random: &mut impl RandomSource,
    // rust: ) {
    // rust: let (element, position, rotation, source_box) = {
    // rust: let s = &self.pieces[source];
    // rust: (s.element.clone(), s.position, s.rotation, s.bounding_box)
}
    // rust: let (context_free, depth) = self.states[source].clone();
    // rust: let mut source_free: Option<Rc<RefCell<Free>>> = None;
    // rust: for jigsaw in element.shuffled_jigsaws(self.resources, position, rotation, random) {
    // rust: let Some(target) = self.pool(&jigsaw.pool) else {
    // rust: continue;
}
    // rust: if target.templates.is_empty() && jigsaw.pool != "minecraft:empty" {
    // rust: continue;
}
    // rust: let s = step(jigsaw.front);
    // rust: let target_pos: [i32; 3] = std::array::from_fn(|i| jigsaw.pos[i] + s[i]);
    // rust: let free = if source_box.is_inside(target_pos) {
    // rust: source_free
    // rust: .get_or_insert_with(|| {
    // rust: Rc::new(RefCell::new(Free {
    // rust: container: source_box,
    // rust: removed: Vec::new(),
    // rust: }))
    // rust: })
    // rust: .clone()
    // rust: } else {
    // rust: context_free.clone()
}
    // rust: let slot = Slot {
    // rust: source,
    // rust: jigsaw: &jigsaw,
    // rust: target_pos,
    // rust: free,
    // rust: depth,
}
    // rust: if depth != self.config.max_depth
    // rust: && self.process(&slot, target.raw.clone(), false, queue, context, random)
    // rust: {
    // rust: continue;
}
    // rust: let Some(fallback) = self.pool(&target.fallback) else {
    // rust: continue;
}
    // rust: let ignore = self.limits.ignore_bounds.contains(&target.fallback);
    // rust: self.process(&slot, fallback.raw.clone(), ignore, queue, context, random);
}
}
    // processList: whether a piece was placed.
    // rust: fn process(
    // rust: &mut self,
    // rust: slot: &Slot<'_>,
    // rust: mut candidates: Vec<(Arc<PoolElement>, i32)>,
    // rust: ignore_bounds: bool,
    // rust: queue: &mut VecDeque<usize>,
    // rust: context: &mut impl StartContext,
    // rust: random: &mut impl RandomSource,
    // rust: ) -> bool {
    // rust: let jigsaw = slot.jigsaw;
    // rust: let (source_rigid, source_y, source_ground) = {
    // rust: let s = &self.pieces[slot.source];
    // rust: (
    // rust: s.element.projection() == Projection::Rigid,
    // rust: s.bounding_box.min[1],
    // rust: s.ground_level_delta,
    // rust: )
}
    // rust: let local_y = jigsaw.pos[1] - source_y;
    // rust: let mut surface = None;
    // rust: let (x, z) = (jigsaw.pos[0], jigsaw.pos[2]);
    // rust: let mut base =
    // rust: |context: &mut dyn SurfaceQuery| *surface.get_or_insert_with(|| context.surface(x, z));
    // rust: let mut total: i32 = candidates.iter().map(|c| c.1).sum();
    // rust: while !candidates.is_empty() {
    // rust: let mut chosen = None;
            // The first required piece still short is forced in once deep enough.
    // rust: let needed = self
    // rust: .limits
    // rust: .pieces
    // rust: .iter()
    // rust: .enumerate()
    // rust: .find(|(i, (_, c))| c.required.is_some_and(|r| self.counts[*i] < r));
    // rust: if let Some((need_index, (_, need))) = needed {
    // rust: let need_template = &self.counted.0[need_index];
    // rust: let found = candidates.iter().position(|(e, _)| {
    // rust: matches!(e.as_ref(), PoolElement::Single { template, .. }
    // rust: if Arc::ptr_eq(template, need_template))
    // rust: });
    // rust: if let Some(i) = found {
    // rust: if slot.depth >= (self.config.max_depth - 1).min(need.min_depth) {
    // rust: chosen = Some(i);
    // rust: } else {
    // rust: total -= candidates[i].1;
    // rust: candidates.remove(i);
}
}
}
    // rust: let index = match chosen {
    // rust: Some(i) => i,
    // rust: None => {
    // rust: if total <= 0 || candidates.is_empty() {
    // rust: return false;
}
    // rust: let mut weight = random.next_int_bound(total).unwrap_or(0) + 1;
    // rust: let mut found = candidates.len() - 1;
    // rust: for (i, (_, w)) in candidates.iter().enumerate() {
    // rust: weight -= w;
    // rust: if weight <= 0 {
    // rust: found = i;
    // rust: break;
}
}
    // rust: found
}
}
    // rust: let (target, weight) = candidates[index].clone();
    // rust: if matches!(target.as_ref(), PoolElement::Empty) {
    // rust: return false;
}
    // rust: let counted = self.counted.of(&target);
    // rust: let full = counted.is_some_and(|i| {
    // rust: self.limits.pieces[i]
    // rust: .1
    // rust: .max
    // rust: .is_some_and(|m| self.counts[i] >= m)
    // rust: });
    // rust: if full {
    // rust: total -= weight;
    // rust: candidates.remove(index);
    // rust: continue;
}
    // rust: let mut rotations = Rotation::ALL;
    // rust: shuffle(&mut rotations, random);
    // rust: for rotation in rotations {
    // rust: let target_jigsaws =
    // rust: target.shuffled_jigsaws(self.resources, [0; 3], rotation, random);
    // rust: let hack_box = target.bounding_box([0; 3], rotation);
    // rust: let expand_to = if self.config.use_expansion_hack && hack_box.span()[1] <= 16 {
    // rust: target_jigsaws
    // rust: .iter()
    // rust: .map(|tj| {
    // rust: let st = step(tj.front);
    // rust: if !hack_box.is_inside(std::array::from_fn(|i| tj.pos[i] + st[i])) {
    // rust: return 0;
}
    // rust: let child = self.pool(&tj.pool);
    // rust: let child_size = child.as_ref().map_or(0, |p| p.max_size());
    // rust: let fallback_size = child
    // rust: .and_then(|p| self.pool(&p.fallback))
    // rust: .map_or(0, |p| p.max_size());
    // rust: child_size.max(fallback_size)
    // rust: })
    // rust: .max()
    // rust: .unwrap_or(0)
    // rust: } else {
    // rust: 0
}
    // rust: for target_jigsaw in &target_jigsaws {
    // rust: if !can_attach(jigsaw, target_jigsaw) {
    // rust: continue;
}
    // rust: let target_local = target_jigsaw.pos;
    // rust: let raw_position: [i32; 3] =
    // rust: std::array::from_fn(|i| slot.target_pos[i] - target_local[i]);
    // rust: let raw_box = target.bounding_box(raw_position, rotation);
    // rust: let target_rigid = target.projection() == Projection::Rigid;
    // rust: let delta_y = local_y - target_local[1] + step(jigsaw.front)[1];
    // rust: let target_y = if source_rigid && target_rigid {
    // rust: source_y + delta_y
    // rust: } else {
    // rust: base(context) - target_local[1]
}
    // rust: let offset = target_y - raw_box.min[1];
    // rust: let mut target_box = raw_box.moved([0, offset, 0]);
    // rust: let target_position =
    // rust: [raw_position[0], raw_position[1] + offset, raw_position[2]];
    // rust: if expand_to > 0 {
    // rust: let size = (expand_to + 1).max(target_box.max[1] - target_box.min[1]);
    // rust: target_box.max[1] = target_box.min[1] + size;
}
    // rust: if target_box.max[1] > self.max_y || target_box.min[1] < self.min_y {
    // rust: continue;
}
    // rust: if !ignore_bounds && !slot.free.borrow().fits(&target_box) {
    // rust: continue;
}
    // rust: let target_ground = if target_rigid {
    // rust: source_ground - delta_y
    // rust: } else {
    // rust: target.ground_level_delta()
}
    // rust: let junction_y = if source_rigid {
    // rust: source_y + local_y
    // rust: } else if target_rigid {
    // rust: target_y + target_local[1]
    // rust: } else {
    // rust: base(context) + delta_y / 2
}
    // rust: self.pieces[slot.source].junctions.push(Junction {
    // rust: source_x: slot.target_pos[0],
    // rust: source_ground_y: junction_y - local_y + source_ground,
    // rust: source_z: slot.target_pos[2],
    // rust: delta_y,
    // rust: dest_projection: target.projection(),
    // rust: });
    // rust: slot.free.borrow_mut().removed.push(target_box);
    // rust: self.pieces.push(PoolPiece {
    // rust: element: target.clone(),
    // rust: position: target_position,
    // rust: ground_level_delta: target_ground,
    // rust: rotation,
    // rust: bounding_box: target_box,
    // rust: junctions: vec![Junction {
    // rust: source_x: jigsaw.pos[0],
    // rust: source_ground_y: junction_y - target_local[1] + target_ground,
    // rust: source_z: jigsaw.pos[2],
    // rust: delta_y: -delta_y,
    // rust: dest_projection: if source_rigid {
    // rust: Projection::Rigid
    // rust: } else {
    // rust: Projection::TerrainMatching
    // rust: },
    // rust: }],
    // rust: waterlogging: self.config.waterlogging,
    // rust: });
    // rust: self.states.push((slot.free.clone(), slot.depth + 1));
    // rust: if slot.depth < self.config.max_depth {
    // rust: queue.push_back(self.pieces.len() - 1);
}
    // rust: if let Some(i) = counted {
    // rust: self.counts[i] += 1;
}
    // rust: return true;
}
}
    // rust: total -= weight;
    // rust: candidates.remove(index);
}
    // rust: false
}
}

// The surface height query, object-safe for the per-call cache.
    // rust: trait SurfaceQuery {
surface :: proc(self: ^Self, x: i32, z: i32) -> i {
    // Ported from Horizon
    return {}
}
}
    // rust: impl<C: StartContext> SurfaceQuery for C {
surface :: proc(self: ^Self, x: i32, z: i32) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.base_height(x, z, HeightmapType::WorldSurfaceWg)
}
}

    // rust: mod tests {
//     use super::*;
//     use serde_json::json;

required_pieces_follow_javas_hash_map :: proc() {
}
    // rust: let limits = Config::decode(&json!({"library": "repurposed", "pieces": [
    // rust: {"name": "rs:city/a", "required": 1},
    // rust: {"name": "rs:city/x", "max": 2},
    // rust: {"name": "rs:city/b", "required": 1, "min_depth": 3},
    // rust: {"name": "rs:city/c", "required": 2},
    // rust: {"name": "rs:city/a", "required": 4}]}));
    // rust: let names: Vec<String> = limits.pieces.iter().map(|(id, _)| id.to_string()).collect();
        // Buckets 3, 2, 1 of the copied map's 4: c, b, a; then the capped one.
    // rust: assert_eq!(names, ["rs:city/c", "rs:city/b", "rs:city/a", "rs:city/x"]);
    // rust: assert_eq!(
    // rust: limits.pieces[2].1.required,
    // rust: Some(4),
    // rust: "a later entry replaces"
    // rust: );
    // rust: assert_eq!(limits.pieces[1].1.min_depth, 3);
    // rust: assert_eq!(limits.library, Library::Repurposed);
}

mineshafts_go_under_the_lowest_floor_around :: proc() {
}
        // Floor 80 at the middle (7, 7), 70 north, 90 east, 60 south, 85 west.
    // rust: let floor = |x, z| match (x, z) {
    // rust: (7, 7) => 80,
    // rust: (7, -9) => 70,
    // rust: (23, 7) => 90,
    // rust: (7, 23) => 60,
    // rust: (-9, 7) => 85,
    // rust: other => panic!("{other:?}"),
}
        // 79, min(79, 70) - 1 = 69, 68, min(68, 60) - 1 = 59, 58; 15 under it.
    // rust: assert_eq!(mineshaft_top([0, 50, 0], None, floor), 43);
    // rust: assert_eq!(mineshaft_top([0, 50, 0], Some(48), floor), 48);
}

nether_land_is_found_in_the_column :: proc() {
}
        // A column from y 0: netherrack to 40, lava 41..=45, air, a ledge 70..=72.
    // rust: let (mut filled, mut solid) = (vec![false; 128], vec![false; 128]);
    // rust: for y in 0..=45 {
    // rust: filled[y] = true;
    // rust: solid[y] = y <= 40;
}
    // rust: for y in 70..=72 {
    // rust: filled[y] = true;
    // rust: solid[y] = true;
}
        // Highest: from 88 down, a solid block with air 3 above.
    // rust: assert_eq!(land_in(&filled, &solid, 0, true, true, 32, 128), 72);
        // Lowest: from 33 up, a block to stand on with air 1 and 5 above; one up.
    // rust: assert_eq!(land_in(&filled, &solid, 0, false, true, 32, 128), 46);
    // rust: assert_eq!(land_in(&filled, &solid, 0, false, false, 32, 128), 73);
        // Nothing found: the highest search stops at the sea level.
    // rust: let empty = vec![false; 128];
    // rust: assert_eq!(land_in(&empty, &empty, 0, true, true, 32, 128), 32);
    // rust: assert_eq!(land_in(&empty, &empty, 0, false, true, 32, 128), 32);
}

repurposed_moves_junctions_as_its_code_does :: proc() {
}
    // rust: let template = Arc::new(StructureTemplate::empty());
    // rust: let element = Arc::new(PoolElement::Single {
    // rust: template,
    // rust: processors: Default::default(),
    // rust: processors_source: serde_json::Value::Null,
    // rust: legacy: false,
    // rust: projection: Projection::Rigid,
    // rust: waterlogging: None,
    // rust: enhanced_terrain: None,
    // rust: ground_level: 1,
    // rust: });
    // rust: let piece = || PoolPiece {
    // rust: bounding_box: BoundingBox::new([0; 3], [4; 3]),
    // rust: ground_level_delta: 1,
    // rust: element: element.clone(),
    // rust: position: [0; 3],
    // rust: rotation: Rotation::None,
    // rust: junctions: vec![Junction {
    // rust: source_x: 1,
    // rust: source_ground_y: 2,
    // rust: source_z: 3,
    // rust: delta_y: 0,
    // rust: dest_projection: Projection::Rigid,
    // rust: }],
    // rust: waterlogging: true,
}
    // rust: let moogs = Config::decode(&json!({}));
    // rust: let rs = Config::decode(&json!({"library": "repurposed"}));
    // rust: let (mut a, mut b) = (piece(), piece());
    // rust: shift(&moogs, &mut a, [10, 20, 30]);
    // rust: shift(&rs, &mut b, [10, 20, 30]);
    // rust: assert_eq!(a.bounding_box, BoundingBox::new([10, 20, 30], [14, 24, 34]));
    // rust: assert_eq!(a.position, [10, 20, 30]);
    // rust: assert_eq!(a.junctions[0].source_x, 1);
        // movePieceProperly sets the source X three times; Z + dz is left.
    // rust: assert_eq!(b.junctions[0].source_x, 33);
    // rust: assert_eq!(b.junctions[0].source_ground_y, 2);
}
}
