//! Transpiled from Horizon Rust crate
package horizon_world_disk

import "core:fmt"
import "core:mem"
import "core:math"

// Circular descending replacement columns and postprocessing above each run.
// use super::{
    // rust: DecodeError, Object,
    // rust: block_feature::FeatureBlockBindings,
    // rust: block_predicate::BlockPredicate,
    // rust: feature::FeatureWorld,
    // rust: int_range,
    // rust: placement::{PlacementContext, PlacementQueryError},
    // rust: required,
    // rust: state_provider::{BlockStateProvider, StateProviderError},
    // rust: value_provider::IntProvider,
}
// use crate::registry::BlockStateId;
// use horizon_core::random::{InvalidBound, RandomSource};
DiskFeature :: struct {
    provider: BlockStateProvider,
    target: BlockPredicate,
    radius: IntProvider,
    half_height: i32,
    air: [BlockStateId,
}
DiskError :: enum {
    Random(InvalidBound),
    Provider(StateProviderError<E>),
    Query(PlacementQueryError),
    World(E),
    WorkLimit,
}
    // rust: impl<E: std::fmt::Display> std::fmt::Display for DiskError<E> {
fmt :: proc(self: ^Self, f: ^std::fmt::Formatter<'_>) -> s {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::Random(e) => e.fmt(f),
    // rust: Self::Provider(e) => e.fmt(f),
    // rust: Self::Query(e) => e.fmt(f),
    // rust: Self::World(e) => e.fmt(f),
    // rust: Self::WorkLimit => f.write_str("disk feature work limit exceeded"),
}
}
}
    // rust: impl<E: std::error::Error + 'static> std::error::Error for DiskError<E> {}
    // rust: impl DiskFeature {
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
    // rust: return Err(DecodeError::Field("disk depth or work"));
}
    // rust: *remaining -= 1;
    // rust: let object: Object = serde_json::from_str(json)?;
    // rust: let (providers, catalog, _) = bindings
    // rust: .simple_blocks
    // rust: .as_ref()
    // rust: .ok_or(DecodeError::Field("disk provider bindings"))?;
    // rust: let provider = catalog.provider_with_budget(
    // rust: required(&object, "state_provider")?.get(),
    // rust: providers,
    // rust: depth + 1,
    // rust: remaining,
    // rust: )?;
    // rust: let target = BlockPredicate::decode_with_blocks(
    // rust: required(&object, "target")?.get(),
    // rust: depth + 1,
    // rust: remaining,
    // rust: Some(bindings),
    // rust: )?;
    // rust: let radius = IntProvider::decode(required(&object, "radius")?, depth + 1, remaining)?;
    // rust: if radius.bounds()[0] < 0 || radius.bounds()[1] > 8 {
    // rust: return Err(DecodeError::Field("disk radius range"));
}
    // rust: let half_height = int_range(required(&object, "half_height")?, "disk half height", 0, 4)?;
    // rust: Ok(Self {
    // rust: provider,
    // rust: target,
    // rust: radius,
    // rust: half_height,
    // rust: air: bindings.air,
    // rust: })
}
    // rust: pub fn place<W: FeatureWorld + PlacementContext>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: random: &mut impl RandomSource,
    // rust: origin: [i32; 3],
    // rust: ) -> Result<bool, DiskError<W::Error>> {
    // rust: let top = origin[1].wrapping_add(self.half_height);
    // rust: let bottom = origin[1].wrapping_sub(self.half_height).wrapping_sub(1);
    // rust: let radius = self.radius.sample(random).map_err(DiskError::Random)?;
    // rust: let x0 = origin[0].wrapping_sub(radius);
    // rust: let x1 = origin[0].wrapping_add(radius);
    // rust: let z0 = origin[2].wrapping_sub(radius);
    // rust: let z1 = origin[2].wrapping_add(radius);
    // rust: let min_x = x0.min(x1);
    // rust: let min_z = z0.min(z1);
    // rust: let width = x0.max(x1).wrapping_sub(min_x).wrapping_add(1);
    // rust: let depth = z0.max(z1).wrapping_sub(min_z).wrapping_add(1);
    // rust: let count = width.wrapping_mul(depth);
    // rust: let mut index = 0;
    // rust: let mut remaining = 1_048_576;
    // rust: let mut any = false;
    // rust: while index != count {
    // rust: spend(&mut remaining)?;
    // rust: let x = min_x.wrapping_add(index % width);
    // rust: let z = min_z.wrapping_add(index / width);
    // rust: index = index.wrapping_add(1);
    // rust: let dx = x.wrapping_sub(origin[0]);
    // rust: let dz = z.wrapping_sub(origin[2]);
    // rust: if dx.wrapping_mul(dx).wrapping_add(dz.wrapping_mul(dz)) > radius.wrapping_mul(radius) {
    // rust: continue;
}
    // rust: let mut y = top;
    // rust: let mut previous_placed = false;
    // rust: while y > bottom {
    // rust: spend(&mut remaining)?;
    // rust: let p = [x, y, z];
    // rust: if self.target.test(world, p).map_err(DiskError::Query)? {
    // rust: if let Some(state) = self
    // rust: .provider
    // rust: .get_optional_state(world, random, p)
    // rust: .map_err(DiskError::Provider)?
    // rust: {
    // rust: world.set_block(p, state, 2).map_err(DiskError::World)?;
    // rust: if !previous_placed {
    // rust: self.mark_above(world, p)?;
}
    // rust: any = true;
    // rust: previous_placed = true;
}
    // rust: } else {
    // rust: previous_placed = false;
}
    // rust: y = y.wrapping_sub(1);
}
}
    // rust: Ok(any)
}
    // rust: fn mark_above<W: FeatureWorld + PlacementContext>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: mut p: [i32; 3],
    // rust: ) -> Result<(), DiskError<W::Error>> {
    // rust: for _ in 0..2 {
    // rust: p[1] = p[1].wrapping_add(1);
    // rust: if self
    // rust: .air
    // rust: .contains(&world.block(p).map_err(DiskError::World)?)
    // rust: {
    // rust: break;
}
    // rust: world.mark_postprocessing(p).map_err(DiskError::Query)?;
}
    // rust: Ok(())
}
}
    // rust: fn spend<E>(remaining: &mut usize) -> Result<(), DiskError<E>> {
    // rust: if *remaining == 0 {
    // rust: return Err(DiskError::WorkLimit);
}
    // rust: *remaining -= 1;
    // rust: Ok(())
}
