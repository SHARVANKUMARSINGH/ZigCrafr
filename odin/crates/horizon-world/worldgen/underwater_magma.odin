//! Transpiled from Horizon Rust crate
package horizon_world_underwater_magma

import "core:fmt"
import "core:mem"
import "core:math"

// Water-column floor scans and randomized magma replacement in occluded cells.
// use super::{
    // rust: DecodeError, Object, block_feature::FeatureBlockBindings,
    // rust: block_predicate::PredicateBlockResolver, feature::FeatureWorld, int_range, number_text,
    // rust: required,
}
// use crate::{block_properties::BoundOcclusionFaces, registry::BlockStateId};
// use horizon_core::{geometry::Direction, random::RandomSource};
// use std::{collections::BTreeSet, sync::Arc};
UnderwaterMagmaFeature :: struct {
    search: i32,
    radius: i32,
    probability: f32,
    water: ^BTreeSet<BlockStateId>,
    air: [BlockStateId,
    magma: BlockStateId,
    faces: BoundOcclusionFaces,
}
UnderwaterMagmaError :: enum {
    World(E),
    Registry(std::io::Error),
    InvalidColumn,
    WorkLimit,
}
    // rust: impl<E: std::fmt::Display> std::fmt::Display for UnderwaterMagmaError<E> {
fmt :: proc(self: ^Self, f: ^std::fmt::Formatter<'_>) -> s {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::World(e) => e.fmt(f),
    // rust: Self::Registry(e) => e.fmt(f),
    // rust: Self::InvalidColumn => f.write_str("negative scanned column height"),
    // rust: Self::WorkLimit => f.write_str("magma placement work limit exceeded"),
}
}
}
    // rust: impl<E: std::error::Error + 'static> std::error::Error for UnderwaterMagmaError<E> {}
    // rust: impl UnderwaterMagmaFeature {
from_json :: proc(json: string, bindings: ^FeatureBlockBindings<'_>) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let object: Object = serde_json::from_str(json)?;
    // rust: let probability = number_text(required(
    // rust: &object,
    // rust: "placement_probability_per_valid_position",
    // rust: )?)?
    // rust: .parse::<f64>()
    // rust: .map_err(|_| DecodeError::Field("magma probability"))? as f32;
    // rust: if !(0.0..=1.0).contains(&probability) || probability.is_sign_negative() {
    // rust: return Err(DecodeError::Field("magma probability"));
}
    // rust: Ok(Self {
    // rust: search: int_range(
    // rust: required(&object, "floor_search_range")?,
    // rust: "magma floor range",
    // rust: 0,
    // rust: 512,
    // rust: )?,
    // rust: radius: int_range(
    // rust: required(&object, "placement_radius_around_floor")?,
    // rust: "magma radius",
    // rust: 0,
    // rust: 64,
    // rust: )?,
    // rust: probability,
    // rust: water: bindings.predicate_block_set(r#""minecraft:water""#)?,
    // rust: air: bindings.air,
    // rust: magma: bindings
    // rust: .registry()
    // rust: .default_state("minecraft:magma_block")
    // rust: .ok_or(DecodeError::Field("magma block"))?,
    // rust: faces: bindings
    // rust: .occlusion_faces
    // rust: .clone()
    // rust: .ok_or(DecodeError::Field("magma occlusion bindings"))?,
    // rust: })
}
    // rust: pub fn place<W: FeatureWorld>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: random: &mut impl RandomSource,
    // rust: origin: [i32; 3],
    // rust: ) -> Result<bool, UnderwaterMagmaError<W::Error>> {
    // rust: if !self
    // rust: .water
    // rust: .contains(&world.block(origin).map_err(UnderwaterMagmaError::World)?)
    // rust: {
    // rust: return Ok(false);
}
    // rust: let ceiling = self.scan(world, origin, 1)?;
    // rust: let floor = self.scan(world, origin, -1)?;
    // rust: if let (Some(floor), Some(ceiling)) = (floor, ceiling) {
    // rust: if ceiling.wrapping_sub(floor).wrapping_sub(1) < 0 {
    // rust: return Err(UnderwaterMagmaError::InvalidColumn);
}
}
    // rust: let Some(y) = floor else {
    // rust: return Ok(false);
}
    // rust: let center = [origin[0], y, origin[2]];
    // rust: let a: [i32; 3] = std::array::from_fn(|i| center[i].wrapping_sub(self.radius));
    // rust: let b: [i32; 3] = std::array::from_fn(|i| center[i].wrapping_add(self.radius));
    // rust: let min: [i32; 3] = std::array::from_fn(|i| a[i].min(b[i]));
    // rust: let sizes: [i32; 3] =
    // rust: std::array::from_fn(|i| a[i].max(b[i]).wrapping_sub(min[i]).wrapping_add(1));
    // rust: let count = sizes[0].wrapping_mul(sizes[1]).wrapping_mul(sizes[2]);
    // rust: let mut index: i32 = 0;
    // rust: let mut any = false;
    // rust: while index != count {
            // Includes the full valid radius-64 cube (2,146,689 positions).
    // rust: if index == 8_388_608 {
    // rust: return Err(UnderwaterMagmaError::WorkLimit);
}
    // rust: let quotient = index / sizes[0];
    // rust: let p = [
    // rust: min[0].wrapping_add(index % sizes[0]),
    // rust: min[1].wrapping_add(quotient % sizes[1]),
    // rust: min[2].wrapping_add(quotient / sizes[1]),
    // rust: ];
    // rust: index += 1;
    // rust: if random.next_float() < self.probability && self.valid(world, p)? {
    // rust: world
    // rust: .set_block(p, self.magma, 2)
    // rust: .map_err(UnderwaterMagmaError::World)?;
    // rust: any = true;
}
}
    // rust: Ok(any)
}
    // rust: fn scan<W: FeatureWorld>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: mut p: [i32; 3],
    // rust: step: i32,
    // rust: ) -> Result<Option<i32>, UnderwaterMagmaError<W::Error>> {
    // rust: let mut distance = 1;
    // rust: while distance < self.search {
    // rust: if !self
    // rust: .water
    // rust: .contains(&world.block(p).map_err(UnderwaterMagmaError::World)?)
    // rust: {
    // rust: break;
}
    // rust: p[1] = p[1].wrapping_add(step);
    // rust: distance += 1;
}
    // rust: Ok((!self
    // rust: .water
    // rust: .contains(&world.block(p).map_err(UnderwaterMagmaError::World)?))
    // rust: .then_some(p[1]))
}
    // rust: fn valid<W: FeatureWorld>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: p: [i32; 3],
    // rust: ) -> Result<bool, UnderwaterMagmaError<W::Error>> {
    // rust: let state = world.block(p).map_err(UnderwaterMagmaError::World)?;
    // rust: if self.water.contains(&state) || self.air.contains(&state) {
    // rust: return Ok(false);
}
    // rust: if !self.occluded(world, [p[0], p[1].wrapping_sub(1), p[2]], Direction::Up)? {
    // rust: return Ok(false);
}
    // rust: for direction in [
    // rust: Direction::North,
    // rust: Direction::East,
    // rust: Direction::South,
    // rust: Direction::West,
    // rust: ] {
    // rust: let step = direction.normal();
    // rust: let at = std::array::from_fn(|i| p[i].wrapping_add(step[i]));
    // rust: if !self.occluded(world, at, direction.opposite())? {
    // rust: return Ok(false);
}
}
    // rust: Ok(true)
}
    // rust: fn occluded<W: FeatureWorld>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: p: [i32; 3],
    // rust: direction: Direction,
    // rust: ) -> Result<bool, UnderwaterMagmaError<W::Error>> {
    // rust: let state = world.block(p).map_err(UnderwaterMagmaError::World)?;
    // rust: self.faces
    // rust: .is_full(state, direction)
    // rust: .map_err(UnderwaterMagmaError::Registry)
}
}
