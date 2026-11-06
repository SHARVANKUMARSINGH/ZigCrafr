//! Transpiled from Horizon Rust crate
package horizon_world_block_blob

import "core:fmt"
import "core:mem"
import "core:math"

// Descending support search and three overlapping randomized block blobs.
// use super::{
    // rust: DecodeError, Object,
    // rust: block_feature::FeatureBlockBindings,
    // rust: block_predicate::BlockPredicate,
    // rust: feature::FeatureWorld,
    // rust: placement::{PlacementContext, PlacementQueryError},
    // rust: required,
}
// use crate::registry::BlockStateId;
// use horizon_core::random::{InvalidBound, RandomSource};
BlockBlobFeature :: struct {
    state: BlockStateId,
    can_place_on: BlockPredicate,
}
BlockBlobError :: enum {
    Random(InvalidBound),
    Query(PlacementQueryError),
    World(E),
    WorkLimit,
}
    // rust: impl<E: std::fmt::Display> std::fmt::Display for BlockBlobError<E> {
fmt :: proc(self: ^Self, f: ^std::fmt::Formatter<'_>) -> s {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::Random(e) => e.fmt(f),
    // rust: Self::Query(e) => e.fmt(f),
    // rust: Self::World(e) => e.fmt(f),
    // rust: Self::WorkLimit => f.write_str("block blob work limit exceeded"),
}
}
}
    // rust: impl<E: std::error::Error + 'static> std::error::Error for BlockBlobError<E> {}
    // rust: impl BlockBlobFeature {
from_json :: proc(json: string, bindings: ^FeatureBlockBindings<'_>) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Self::decode(json, bindings, 0, &mut 65536)
}
    // rust: pub(crate) fn decode(
    // rust: json: &str,
    // rust: bindings: &FeatureBlockBindings<'_>,
    // rust: depth: usize,
    // rust: remaining: &mut usize,
    // rust: ) -> Result<Self, DecodeError> {
    // rust: if depth > 128 || *remaining == 0 {
    // rust: return Err(DecodeError::Field("block blob depth or work"));
}
    // rust: *remaining -= 1;
    // rust: let object: Object = serde_json::from_str(json)?;
    // rust: Ok(Self {
    // rust: state: bindings
    // rust: .codec
    // rust: .decode(required(&object, "state")?.get(), false)
    // rust: .map_err(|e| DecodeError::Registry(e.to_string()))?,
    // rust: can_place_on: BlockPredicate::decode_with_blocks(
    // rust: required(&object, "can_place_on")?.get(),
    // rust: depth + 1,
    // rust: remaining,
    // rust: Some(bindings),
    // rust: )?,
    // rust: })
}
    // rust: pub fn place<W: FeatureWorld + PlacementContext>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: random: &mut impl RandomSource,
    // rust: mut origin: [i32; 3],
    // rust: ) -> Result<bool, BlockBlobError<W::Error>> {
    // rust: let mut remaining = 1_048_576;
    // rust: while origin[1]
    // rust: > world
    // rust: .min_y()
    // rust: .map_err(BlockBlobError::Query)?
    // rust: .wrapping_add(3)
    // rust: {
    // rust: spend(&mut remaining)?;
    // rust: let below = [origin[0], origin[1].wrapping_sub(1), origin[2]];
    // rust: if self
    // rust: .can_place_on
    // rust: .test(world, below)
    // rust: .map_err(BlockBlobError::Query)?
    // rust: {
    // rust: break;
}
    // rust: origin = below;
}
    // rust: if origin[1]
    // rust: <= world
    // rust: .min_y()
    // rust: .map_err(BlockBlobError::Query)?
    // rust: .wrapping_add(3)
    // rust: {
    // rust: return Ok(false);
}
    // rust: for _ in 0..3 {
    // rust: let rx = random.next_int_bound(2).map_err(BlockBlobError::Random)?;
    // rust: let ry = random.next_int_bound(2).map_err(BlockBlobError::Random)?;
    // rust: let rz = random.next_int_bound(2).map_err(BlockBlobError::Random)?;
    // rust: let radius = (rx + ry + rz) as f32 * 0.333 + 0.5;
    // rust: let offset = [rx, ry, rz];
    // rust: let a: [i32; 3] = std::array::from_fn(|i| origin[i].wrapping_sub(offset[i]));
    // rust: let b: [i32; 3] = std::array::from_fn(|i| origin[i].wrapping_add(offset[i]));
    // rust: let min: [i32; 3] = std::array::from_fn(|i| a[i].min(b[i]));
    // rust: let sizes: [i32; 3] =
    // rust: std::array::from_fn(|i| a[i].max(b[i]).wrapping_sub(min[i]).wrapping_add(1));
    // rust: let count = sizes[0].wrapping_mul(sizes[1]).wrapping_mul(sizes[2]);
    // rust: let mut index: i32 = 0;
    // rust: while index != count {
    // rust: spend(&mut remaining)?;
    // rust: let quotient = index / sizes[0];
    // rust: let p = [
    // rust: min[0].wrapping_add(index % sizes[0]),
    // rust: min[1].wrapping_add(quotient % sizes[1]),
    // rust: min[2].wrapping_add(quotient / sizes[1]),
    // rust: ];
    // rust: index = index.wrapping_add(1);
    // rust: let d: [f64; 3] = std::array::from_fn(|i| f64::from(p[i]) - f64::from(origin[i]));
    // rust: if d[0] * d[0] + d[1] * d[1] + d[2] * d[2] <= f64::from(radius * radius) {
    // rust: world
    // rust: .set_block(p, self.state, 3)
    // rust: .map_err(BlockBlobError::World)?;
}
}
    // rust: origin[0] = origin[0]
    // rust: .wrapping_add(-1 + random.next_int_bound(2).map_err(BlockBlobError::Random)?);
    // rust: origin[1] =
    // rust: origin[1].wrapping_sub(random.next_int_bound(2).map_err(BlockBlobError::Random)?);
    // rust: origin[2] = origin[2]
    // rust: .wrapping_add(-1 + random.next_int_bound(2).map_err(BlockBlobError::Random)?);
}
    // rust: Ok(true)
}
}
    // rust: fn spend<E>(remaining: &mut usize) -> Result<(), BlockBlobError<E>> {
    // rust: if *remaining == 0 {
    // rust: return Err(BlockBlobError::WorkLimit);
}
    // rust: *remaining -= 1;
    // rust: Ok(())
}
