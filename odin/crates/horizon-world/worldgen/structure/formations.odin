//! Transpiled from Horizon Rust crate
package horizon_world_formations

import "core:fmt"
import "core:mem"
import "core:math"

// Formations' SimpleStructure (`horizon:formations`, which
// `horizon-port-pack` writes for its `formations:simple`; docs/modpacks.md):
// one pool element at a random spot of the chunk, at a height its
// placement finds in the noise columns under the element's corners and
// centre ([`StartContext::noise_column`]).
//
// Its PiecedStructure (the fountain) starts the same way, then lays out
// the element's jigsaw children with vanilla's jigsaw
// ([`super::jigsaw::add_children`]): `horizon:pieced` on the structure
// holds its `max_depth` and `max_distance_from_center`.
// use super::{
    // rust: BoundingBox, Rotation, StructureResources,
    // rust: jigsaw::{JigsawConfig, PoolElement, PoolPiece, Pools, add_children},
    // rust: start::{NoiseBlock, NoiseColumn, StartContext},
}
// use crate::{
    // rust: heightmap::HeightmapType,
    // rust: worldgen::{DecodeError, block_feature::FeatureBlockBindings},
}
// use horizon_core::position::ChunkPos;
// use horizon_core::random::RandomSource;
// use serde_json::Value;

// StructurePlacement: how the height is found.
Placement :: enum {
    Surface,
    Ceiling,
    OnWater,
    OnLava,
    Underground,
    UndergroundSurface,
    UndergroundCeiling,
    UndergroundBuried,
    UndergroundOnLava,
}
    // rust: impl Placement {
decode :: proc(name: string) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(match name {
    // rust: "surface" => Self::Surface,
    // rust: "ceiling" => Self::Ceiling,
    // rust: "on_water" => Self::OnWater,
    // rust: "on_lava" => Self::OnLava,
    // rust: "underground" => Self::Underground,
    // rust: "underground_surface" => Self::UndergroundSurface,
    // rust: "underground_ceiling" => Self::UndergroundCeiling,
    // rust: "underground_buried" => Self::UndergroundBuried,
    // rust: "underground_on_lava" => Self::UndergroundOnLava,
    // rust: _ => return Err(DecodeError::Field("formations placement")),
    // rust: })
}
}

// The structure: a pool to draw the element from, and its placement.
Def :: struct {
    pool: string,
    placement: Placement,
    // PiecedStructure's jigsaw: (max depth, max distance from the centre).
    pieced: Option<(i32,
}
    // rust: impl Def {
decode :: proc(v: ^Value) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(Self {
            // An inline element is never written by Formations' generators.
    // rust: pool: v["template"]
    // rust: .as_str()
    // rust: .ok_or(DecodeError::Field("formations template"))?
    // rust: .to_owned(),
    // rust: placement: Placement::decode(v["placement"].as_str().unwrap_or_default())?,
    // rust: pieced: match v.get("horizon:pieced") {
    // rust: None => None,
    // rust: Some(p) => {
    // rust: let int = |k: &'static str| {
    // rust: p[k].as_i64().map(|n| n as i32).ok_or(DecodeError::Field(k))
}
    // rust: Some((int("max_depth")?, int("max_distance_from_center")?))
}
    // rust: },
    // rust: })
}
}

// SimpleStructure.findGenerationPoint, or PiecedStructure's: the start's
// position and pieces.
    // rust: pub fn generate(
    // rust: def: &Def,
    // rust: context: &mut impl StartContext,
    // rust: pools: &Pools,
    // rust: resources: &StructureResources,
    // rust: bindings: &FeatureBlockBindings<'_>,
    // rust: random: &mut impl RandomSource,
    // rust: chunk: ChunkPos,
    // rust: ) -> Option<([i32; 3], Vec<PoolPiece>)> {
    // rust: let element = pools
    // rust: .get(&def.pool, resources, bindings)?
    // rust: .random_template(random);
    // rust: if matches!(element.as_ref(), PoolElement::Empty) {
    // rust: return None;
}
    // rust: let x = chunk.x * 16 + random.next_int_bound(16).ok()?;
    // rust: let z = chunk.z * 16 + random.next_int_bound(16).ok()?;
    // rust: let rotation = Rotation::random(random);
    // rust: let b = element.bounding_box([x, 0, z], rotation);
    // rust: let height = find_height(def.placement, context, b, random)?;
    // rust: let ground = element.ground_level_delta();
    // rust: let y = height - ground + 1;
    // rust: if def.pieced.is_none() && y < context.min_y() {
    // rust: return None;
}
    // rust: let piece = PoolPiece {
    // rust: bounding_box: b.moved([0, y, 0]),
    // rust: ground_level_delta: ground,
    // rust: element,
    // rust: position: [x, y, z],
    // rust: rotation,
    // rust: junctions: Vec::new(),
        // LiquidSettings.APPLY_WATERLOGGING.
    // rust: waterlogging: true,
}
    // rust: let Some((max_depth, distance)) = def.pieced else {
    // rust: return Some(([x, y, z], vec![piece]));
}
    // PiecedStructure.addPieces: the start sits at the element's centre, one
    // above the height found, and its children may fill the box of
    // `distance` around it (not clamped to the world's height) less its own.
    // rust: let (cx, cy, cz) = (
    // rust: (b.max[0] + b.min[0]) / 2,
    // rust: height + 1,
    // rust: (b.max[2] + b.min[2]) / 2,
    // rust: );
    // rust: let mut pieces = vec![piece];
    // rust: if max_depth > 0 {
    // rust: let config = JigsawConfig {
    // rust: start_pool: &def.pool,
    // rust: start_jigsaw: None,
    // rust: max_depth,
    // rust: use_expansion_hack: false,
    // rust: project_to: None,
    // rust: max_distance: [distance, distance],
    // rust: aliases: &Default::default(),
    // rust: padding: [0, 0],
    // rust: waterlogging: true,
}
    // rust: let container = BoundingBox::new(
    // rust: [cx - distance, cy - distance, cz - distance],
    // rust: [cx + distance, cy + distance, cz + distance],
    // rust: );
    // rust: add_children(
    // rust: &config,
    // rust: context,
    // rust: pools,
    // rust: resources,
    // rust: bindings,
    // rust: random,
    // rust: &mut pieces,
    // rust: container,
    // rust: );
}
    // rust: Some(([cx, cy, cz], pieces))
}

// The four corners (min x min z, min x max z, max x max z, max x min z)
// and the centre, as Formations' cornersAndCenter.
corners_and_center :: proc(b: BoundingBox) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: let c = b.center();
    // rust: [
    // rust: [b.min[0], b.min[2]],
    // rust: [b.min[0], b.max[2]],
    // rust: [b.max[0], b.max[2]],
    // rust: [b.max[0], b.min[2]],
    // rust: [c[0], c[2]],
    // rust: ]
}

// ChunkGenerator.getFirstOccupiedHeight on WORLD_SURFACE_WG.
first_occupied :: proc(context: ^impl StartContext, x: i32, z: i32) -> i {
    // Ported from Horizon
    return {}
}
    // rust: context.base_height(x, z, HeightmapType::WorldSurfaceWg) - 1
}

// (int) Math.round of the heights' mean.
average :: proc(heights: ^[i32]) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let mean = heights.iter().map(|h| f64::from(*h)).sum::<f64>() / heights.len() as f64;
    // rust: (mean + 0.5).floor() as i32
}

// The largest and the mean distance of the heights from `average`.
spread :: proc(heights: ^[i32], average: i32) -> ( {
    // Ported from Horizon
    return {}
}
    // rust: let d: Vec<i32> = heights.iter().map(|h| (average - h).abs()).collect();
    // rust: let max = d.iter().copied().max().unwrap_or(0);
    // rust: let mean = d.iter().map(|v| f64::from(*v)).sum::<f64>() / d.len() as f64;
    // rust: (max, mean)
}

    // rust: fn find_height(
    // rust: placement: Placement,
    // rust: context: &mut impl StartContext,
    // rust: b: BoundingBox,
    // rust: random: &mut impl RandomSource,
    // rust: ) -> Option<i32> {
    // rust: let solid = NoiseBlock::is_solid;
    // rust: match placement {
    // rust: Placement::Surface => from_top(context, b, 10, 3.0, solid),
    // rust: Placement::OnWater => from_top(context, b, 1, 1.0, |n| n == NoiseBlock::Water),
    // rust: Placement::OnLava => from_top(context, b, 1, 1.0, |n| n == NoiseBlock::Lava),
    // rust: Placement::Ceiling => {
    // rust: let min = context.min_y();
    // rust: let top = context.max_y() + 1;
    // rust: let mut heights = Vec::with_capacity(5);
    // rust: for [x, z] in corners_and_center(b) {
    // rust: let highest = first_occupied(context, x, z).min(top);
    // rust: let column = context.noise_column(x, z);
    // rust: heights.push(((min + 1)..highest).find(|y| column.get(*y) != NoiseBlock::Air)?);
}
    // rust: let average = average(&heights);
    // rust: (spread(&heights, average).1 <= 4.0).then_some(average)
}
    // rust: _ => underground(placement, context, b, random),
}
}

// findFromTop: every column's top block (WORLD_SURFACE_WG) passes
// `target`, and the heights are close enough.
    // rust: fn from_top(
    // rust: context: &mut impl StartContext,
    // rust: b: BoundingBox,
    // rust: max_offset: i32,
    // rust: max_average_offset: f64,
    // rust: target: impl Fn(NoiseBlock) -> bool,
    // rust: ) -> Option<i32> {
    // rust: let min = context.min_y();
    // rust: let points = corners_and_center(b);
    // rust: let heights: Vec<i32> = points
    // rust: .iter()
    // rust: .map(|[x, z]| first_occupied(context, *x, *z))
    // rust: .collect();
    // rust: if heights.iter().any(|y| *y <= min) {
    // rust: return None;
}
    // rust: for ([x, z], y) in points.iter().zip(&heights) {
    // rust: if !target(context.noise_column(*x, *z).get(*y)) {
    // rust: return None;
}
}
    // rust: let average = average(&heights);
    // rust: let (max, mean) = spread(&heights, average);
    // rust: (max <= max_offset && mean <= max_average_offset).then_some(average)
}

// The underground placements: the space between the highest first block
// above the bottom and the lowest surface of the five columns, then a
// random height in it, which each column adjusts to its floor (or
// ceiling, or lava), within limits.
    // rust: fn underground(
    // rust: placement: Placement,
    // rust: context: &mut impl StartContext,
    // rust: b: BoundingBox,
    // rust: random: &mut impl RandomSource,
    // rust: ) -> Option<i32> {
    // rust: let (bottom, top) = (context.min_y(), context.max_y() + 1);
    // rust: let mut columns: Vec<(NoiseColumn, i32, i32)> = Vec::with_capacity(5);
    // rust: for [x, z] in corners_and_center(b) {
    // rust: let highest = first_occupied(context, x, z).min(top);
    // rust: let column = context.noise_column(x, z);
    // rust: let lowest = ((bottom + 1)..highest).find(|y| column.get(*y) != NoiseBlock::Air)?;
    // rust: columns.push((column, highest, lowest));
}
    // rust: let min = columns.iter().map(|c| c.2).max()?;
    // rust: let max = columns.iter().map(|c| c.1).min()?;
    // rust: let span = b.span()[1];
    // rust: if max - min - 2 <= span {
    // rust: return None;
}
    // rust: let draw = random.next_int_bound(max - min - span - 2).ok()?;
    // rust: let air = |c: &NoiseColumn, y: i32| c.get(y) == NoiseBlock::Air;
    // rust: let solid = |c: &NoiseColumn, y: i32| c.get(y).is_solid();
    // A floor (or lava) under air near `height`: down through up to 10
    // blocks (`step` -1) or up (`step` 1, the ceiling), then through up to
    // `reach` blocks of air.
    // rust: let floor = |c: &NoiseColumn, height: i32, step: i32, reach: i32, lava: bool| {
    // rust: let mut y = height;
    // rust: let mut i = 0;
    // rust: while i < 10 && y > min && !air(c, y) {
    // rust: y += step;
    // rust: i += 1;
}
    // rust: if !air(c, y) {
    // rust: return None;
}
    // rust: y += step;
    // rust: let mut i = 0;
    // rust: while i < reach && air(c, y) {
    // rust: y += step;
    // rust: i += 1;
}
    // rust: let ok = if lava {
    // rust: c.get(y) == NoiseBlock::Lava
    // rust: } else {
    // rust: solid(c, y)
}
    // rust: ok.then_some(y)
}
    // rust: let heights: Option<Vec<i32>> = match placement {
    // rust: Placement::Underground => return Some(min + 1 + draw),
    // rust: Placement::UndergroundSurface => {
    // rust: let h = min + 1 + draw;
    // rust: columns
    // rust: .iter()
    // rust: .map(|c| floor(&c.0, h, -1, 20, false))
    // rust: .collect()
}
    // rust: Placement::UndergroundCeiling => {
    // rust: let h = min + 1 + draw;
    // rust: columns
    // rust: .iter()
    // rust: .map(|c| floor(&c.0, h, 1, 30, false))
    // rust: .collect()
}
    // rust: Placement::UndergroundOnLava => {
    // rust: let h = min + 1 + draw;
    // rust: columns
    // rust: .iter()
    // rust: .map(|c| floor(&c.0, h, -1, 40, true))
    // rust: .collect()
}
    // rust: Placement::UndergroundBuried => {
    // rust: let h = min + span + 1 + draw;
    // rust: let heights: Option<Vec<i32>> = columns
    // rust: .iter()
    // rust: .map(|(c, _, _)| {
    // rust: let mut y = h;
    // rust: let mut i = 0;
    // rust: while i < 10 && y > min && !solid(c, y) {
    // rust: y -= 1;
    // rust: i += 1;
}
    // rust: if !solid(c, y) {
    // rust: return None;
}
    // rust: y -= 2;
    // rust: for _ in 0..span {
    // rust: if !solid(c, y) {
    // rust: return None;
}
    // rust: y -= 1;
}
    // rust: (solid(c, y) && solid(c, y - 1)).then_some(y)
    // rust: })
    // rust: .collect();
    // rust: let heights = heights?;
    // rust: let average = average(&heights);
    // rust: let held = columns
    // rust: .iter()
    // rust: .all(|(c, _, _)| solid(c, average) && solid(c, average + span));
    // rust: return held.then_some(average);
}
    // rust: _ => None,
}
    // rust: let heights = heights?;
    // rust: let average = average(&heights);
    // rust: let (max, mean) = spread(&heights, average);
    // rust: (max <= 5 && mean <= 3.0).then_some(average)
}

    // rust: mod tests {
//     use super::*;

averages_round_as_math_round :: proc() {
}
    // rust: assert_eq!(average(&[1, 2]), 2);
    // rust: assert_eq!(average(&[-1, -2]), -1);
    // rust: assert_eq!(average(&[64, 64, 65, 66, 64]), 65);
    // rust: assert_eq!(spread(&[61, 64, 66], 63), (3, 2.0));
}

corners_then_centre :: proc() {
}
    // rust: let b = BoundingBox::new([0, 0, 10], [6, 4, 13]);
    // rust: assert_eq!(
    // rust: corners_and_center(b),
    // rust: [[0, 10], [0, 13], [6, 13], [6, 10], [3, 12]]
    // rust: );
}

placements_by_name :: proc() {
}
    // rust: assert_eq!(
    // rust: Placement::decode("underground_on_lava").unwrap(),
    // rust: Placement::UndergroundOnLava
    // rust: );
    // rust: assert!(Placement::decode("floating").is_err());
    // rust: let def = Def::decode(&serde_json::json!({"template": "a:b", "placement": "surface"}));
    // rust: let def = def.unwrap();
    // rust: assert_eq!((def.placement, def.pieced), (Placement::Surface, None));
    // rust: let pieced = Def::decode(
    // rust: &serde_json::json!({"template": "a:b", "placement": "surface",
    // rust: "horizon:pieced": {"max_depth": 2, "max_distance_from_center": 116}}),
    // rust: );
    // rust: assert_eq!(pieced.unwrap().pieced, Some((2, 116)));
    // rust: let broken = serde_json::json!({"template": "a:b", "placement": "surface",
    // rust: "horizon:pieced": {"max_depth": 2}});
    // rust: assert!(Def::decode(&broken).is_err());
}
}
