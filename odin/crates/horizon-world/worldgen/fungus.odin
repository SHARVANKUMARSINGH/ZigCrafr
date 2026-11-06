//! Transpiled from Horizon Rust crate
package horizon_world_fungus

import "core:fmt"
import "core:mem"
import "core:math"

// `minecraft:huge_fungus` (crimson and warped fungi, natural and planted).
// use super::{
    // rust: DecodeError, Object,
    // rust: block_feature::FeatureBlockBindings,
    // rust: block_predicate::BlockPredicate,
    // rust: feature::FeatureWorld,
    // rust: feature_graph::FeatureExecutionError,
    // rust: optional,
    // rust: placement::{PlacementContext, PlacementQueryError},
    // rust: required,
    // rust: tree::{TreeResult, kind, read, write},
    // rust: tree_blocks::{self as tb, TreeBlocks},
}
// use crate::registry::BlockStateId;
// use horizon_core::random::RandomSource;
// use std::sync::Arc;

    // rust: fn query<E>(error: PlacementQueryError) -> FeatureExecutionError<E> {
    // rust: FeatureExecutionError::Query(error)
}
// Mth.nextInt(random, min, max).
    // rust: fn next_int<E>(random: &mut impl RandomSource, min: i32, max: i32) -> TreeResult<i32, E> {
    // rust: if min >= max {
    // rust: Ok(min)
    // rust: } else {
    // rust: Ok(random.next_int_bound(max - min + 1)? + min)
}
}

HugeFungusFeature :: struct {
    valid_base: BlockStateId,
    stem: BlockStateId,
    hat: BlockStateId,
    decor: BlockStateId,
    replaceable: BlockPredicate,
    planted: bool,
    air: BlockStateId,
    weeping_vines: BlockStateId,
    weeping_vines_plant: BlockStateId,
    nether_wart_block: BlockStateId,
    blocks: ^TreeBlocks,
}
    // rust: impl HugeFungusFeature {
    // rust: pub(crate) fn decode(
    // rust: json: &str,
    // rust: bindings: &FeatureBlockBindings<'_>,
    // rust: depth: usize,
    // rust: remaining: &mut usize,
    // rust: ) -> Result<Self, DecodeError> {
    // rust: let object: Object = serde_json::from_str(json)?;
    // rust: if kind(&object)? != "minecraft:huge_fungus" {
    // rust: return Err(DecodeError::Field("huge fungus type"));
}
    // rust: let state = |name: &'static str| {
    // rust: bindings
    // rust: .codec
    // rust: .decode(required(&object, name)?.get(), false)
    // rust: .map_err(|e| DecodeError::Registry(e.to_string()))
}
    // rust: let registry = bindings.registry();
    // rust: let default = |name: &str| {
    // rust: registry
    // rust: .default_state(name)
    // rust: .ok_or_else(|| DecodeError::Registry(format!("missing fungus block {name}")))
}
    // rust: Ok(Self {
    // rust: valid_base: state("valid_base_block")?,
    // rust: stem: state("stem_state")?,
    // rust: hat: state("hat_state")?,
    // rust: decor: state("decor_state")?,
    // rust: replaceable: BlockPredicate::decode_with_blocks(
    // rust: required(&object, "replaceable_blocks")?.get(),
    // rust: depth + 1,
    // rust: remaining,
    // rust: Some(bindings),
    // rust: )?,
    // rust: planted: optional(&object, "planted")
    // rust: .map(|raw| serde_json::from_str::<bool>(raw.get()))
    // rust: .transpose()?
    // rust: .unwrap_or(false),
    // rust: air: default("minecraft:air")?,
    // rust: weeping_vines: default("minecraft:weeping_vines")?,
    // rust: weeping_vines_plant: default("minecraft:weeping_vines_plant")?,
    // rust: nether_wart_block: default("minecraft:nether_wart_block")?,
    // rust: blocks: bindings.tree_blocks()?,
    // rust: })
}
    // rust: pub(crate) fn place<W: FeatureWorld + PlacementContext, R: RandomSource>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: random: &mut R,
    // rust: origin: [i32; 3],
    // rust: ) -> TreeResult<bool, W::Error> {
    // rust: let below = read(world, tb::offset(origin, 0, -1, 0))?;
    // rust: if !self.blocks.same_block(below, self.valid_base) {
    // rust: return Ok(false);
}
    // rust: let mut height = next_int(random, 4, 13)?;
    // rust: if random.next_int_bound(12)? == 0 {
    // rust: height *= 2;
}
    // rust: if !self.planted {
            // ChunkGenerator.getGenDepth, compared against the absolute Y.
    // rust: let depth = world.generation().height;
    // rust: if origin[1].wrapping_add(height).wrapping_add(1) >= depth {
    // rust: return Ok(false);
}
}
    // rust: let huge = !self.planted && random.next_float() < 0.06;
    // rust: write(world, origin, self.air, 260)?;
    // rust: self.stem(world, random, origin, height, huge)?;
    // rust: self.hat(world, random, origin, height, huge)?;
    // rust: Ok(true)
}
    // rust: fn replaceable<W: FeatureWorld + PlacementContext>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: p: [i32; 3],
    // rust: plants: bool,
    // rust: ) -> TreeResult<bool, W::Error> {
    // rust: if self.blocks.has(read(world, p)?, tb::REPLACEABLE) {
    // rust: return Ok(true);
}
    // rust: if plants {
    // rust: return self.replaceable.test(world, p).map_err(query);
}
    // rust: Ok(false)
}
    // rust: fn stem<W: FeatureWorld + PlacementContext, R: RandomSource>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: random: &mut R,
    // rust: origin: [i32; 3],
    // rust: height: i32,
    // rust: huge: bool,
    // rust: ) -> TreeResult<(), W::Error> {
    // rust: let r = i32::from(huge);
    // rust: for dx in -r..=r {
    // rust: for dz in -r..=r {
    // rust: let corner = huge && dx.abs() == r && dz.abs() == r;
    // rust: for dy in 0..height {
    // rust: let p = tb::offset(origin, dx, dy, dz);
    // rust: if !self.replaceable(world, p, true)? {
    // rust: continue;
}
    // rust: if self.planted {
    // rust: if !self.blocks.is_air(read(world, tb::offset(p, 0, -1, 0))?) {
    // rust: world.destroy_block_without_entity(p, true).map_err(query)?;
}
    // rust: write(world, p, self.stem, 3)?;
    // rust: } else if corner {
    // rust: if random.next_float() < 0.1 {
    // rust: write(world, p, self.stem, 3)?;
}
    // rust: } else {
    // rust: write(world, p, self.stem, 3)?;
}
}
}
}
    // rust: Ok(())
}
    // rust: fn hat<W: FeatureWorld + PlacementContext, R: RandomSource>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: random: &mut R,
    // rust: origin: [i32; 3],
    // rust: height: i32,
    // rust: huge: bool,
    // rust: ) -> TreeResult<(), W::Error> {
    // rust: let vines = self.blocks.same_block(self.hat, self.nether_wart_block);
    // rust: let hat_height = (random.next_int_bound(1 + height / 3)? + 5).min(height);
    // rust: let start = height - hat_height;
    // rust: for dy in start..=height {
    // rust: let mut radius = if dy < height - random.next_int_bound(3)? {
    // rust: 2
    // rust: } else {
    // rust: 1
}
    // rust: if hat_height > 8 && dy < start + 4 {
    // rust: radius = 3;
}
    // rust: if huge {
    // rust: radius += 1;
}
    // rust: for dx in -radius..=radius {
    // rust: for dz in -radius..=radius {
    // rust: let edge_x = dx == -radius || dx == radius;
    // rust: let edge_z = dz == -radius || dz == radius;
    // rust: let inside = !edge_x && !edge_z && dy != height;
    // rust: let corner = edge_x && edge_z;
    // rust: let bottom = dy < start + 3;
    // rust: let p = tb::offset(origin, dx, dy, dz);
    // rust: if !self.replaceable(world, p, false)? {
    // rust: continue;
}
    // rust: if self.planted && !self.blocks.is_air(read(world, tb::offset(p, 0, -1, 0))?) {
    // rust: world.destroy_block_without_entity(p, true).map_err(query)?;
}
    // rust: if bottom {
    // rust: if !inside {
    // rust: self.hat_drop(world, random, p, vines)?;
}
    // rust: } else if inside {
    // rust: self.hat_block(world, random, p, 0.1, 0.2, if vines { 0.1 } else { 0.0 })?;
    // rust: } else if corner {
    // rust: self.hat_block(
    // rust: world,
    // rust: random,
    // rust: p,
    // rust: 0.01,
    // rust: 0.7,
    // rust: if vines { 0.083 } else { 0.0 },
    // rust: )?;
    // rust: } else {
    // rust: self.hat_block(
    // rust: world,
    // rust: random,
    // rust: p,
    // rust: 5.0e-4,
    // rust: 0.98,
    // rust: if vines { 0.07 } else { 0.0 },
    // rust: )?;
}
}
}
}
    // rust: Ok(())
}
    // rust: fn hat_block<W: FeatureWorld + PlacementContext, R: RandomSource>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: random: &mut R,
    // rust: p: [i32; 3],
    // rust: decor: f32,
    // rust: hat: f32,
    // rust: vines: f32,
    // rust: ) -> TreeResult<(), W::Error> {
    // rust: if random.next_float() < decor {
    // rust: write(world, p, self.decor, 3)?;
    // rust: } else if random.next_float() < hat {
    // rust: write(world, p, self.hat, 3)?;
    // rust: if random.next_float() < vines {
    // rust: self.weeping_vines(world, random, p)?;
}
}
    // rust: Ok(())
}
    // rust: fn hat_drop<W: FeatureWorld + PlacementContext, R: RandomSource>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: random: &mut R,
    // rust: p: [i32; 3],
    // rust: vines: bool,
    // rust: ) -> TreeResult<(), W::Error> {
    // rust: let below = read(world, tb::offset(p, 0, -1, 0))?;
    // rust: if self.blocks.same_block(below, self.hat) {
    // rust: write(world, p, self.hat, 3)?;
    // rust: } else if f64::from(random.next_float()) < 0.15 {
    // rust: write(world, p, self.hat, 3)?;
    // rust: if vines && random.next_int_bound(11)? == 0 {
    // rust: self.weeping_vines(world, random, p)?;
}
}
    // rust: Ok(())
}
    // rust: fn weeping_vines<W: FeatureWorld + PlacementContext, R: RandomSource>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: random: &mut R,
    // rust: hat: [i32; 3],
    // rust: ) -> TreeResult<(), W::Error> {
    // rust: let mut p = tb::offset(hat, 0, -1, 0);
    // rust: if !self.blocks.is_air(read(world, p)?) {
    // rust: return Ok(());
}
    // rust: let mut goal = next_int(random, 1, 5)?;
    // rust: if random.next_int_bound(7)? == 0 {
    // rust: goal *= 2;
}
    // rust: for height in 0..=goal {
    // rust: if self.blocks.is_air(read(world, p)?) {
    // rust: if height == goal || !self.blocks.is_air(read(world, tb::offset(p, 0, -1, 0))?) {
    // rust: let age = next_int(random, 23, 25)?;
    // rust: let state = self
    // rust: .blocks
    // rust: .with(self.weeping_vines, "age", &age.to_string())
    // rust: .ok_or(FeatureExecutionError::InvalidState)?;
    // rust: write(world, p, state, 2)?;
    // rust: break;
}
    // rust: write(world, p, self.weeping_vines_plant, 2)?;
}
    // rust: p = tb::offset(p, 0, -1, 0);
}
    // rust: Ok(())
}
}
