//! Transpiled from Horizon Rust crate
package horizon_world_blue_ice

import "core:fmt"
import "core:mem"
import "core:math"

// Packed-ice seeding and 200 ordered blue-ice growth attempts.
// use super::{
    // rust: DecodeError,
    // rust: block_feature::FeatureBlockBindings,
    // rust: block_predicate::PredicateBlockResolver,
    // rust: feature::FeatureWorld,
    // rust: placement::{PlacementContext, PlacementQueryError},
}
// use crate::registry::BlockStateId;
// use horizon_core::{
    // rust: geometry::Direction,
    // rust: random::{InvalidBound, RandomSource},
}
// use std::{collections::BTreeSet, sync::Arc};
BlueIceFeature :: struct {
    water: ^BTreeSet<BlockStateId>,
    packed: ^BTreeSet<BlockStateId>,
    blue: ^BTreeSet<BlockStateId>,
    replaceable: BTreeSet<BlockStateId>,
    output: BlockStateId,
}
BlueIceError :: enum {
    World(E),
    Query(PlacementQueryError),
    Random(InvalidBound),
}
    // rust: impl<E: std::fmt::Display> std::fmt::Display for BlueIceError<E> {
fmt :: proc(self: ^Self, f: ^std::fmt::Formatter<'_>) -> s {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::World(e) => e.fmt(f),
    // rust: Self::Query(e) => e.fmt(f),
    // rust: Self::Random(e) => e.fmt(f),
}
}
}
    // rust: impl<E: std::error::Error + 'static> std::error::Error for BlueIceError<E> {}
    // rust: impl BlueIceFeature {
new :: proc(bindings: ^FeatureBlockBindings<'_>) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let water = bindings.predicate_block_set(r#""minecraft:water""#)?;
    // rust: let packed = bindings.predicate_block_set(r#""minecraft:packed_ice""#)?;
    // rust: let blue = bindings.predicate_block_set(r#""minecraft:blue_ice""#)?;
    // rust: let mut replaceable: BTreeSet<_> = bindings.air.into_iter().collect();
    // rust: replaceable.extend(water.iter().copied());
    // rust: replaceable.extend(packed.iter().copied());
    // rust: replaceable.extend(
    // rust: bindings
    // rust: .predicate_block_set(r#""minecraft:ice""#)?
    // rust: .iter()
    // rust: .copied(),
    // rust: );
    // rust: Ok(Self {
    // rust: water,
    // rust: packed,
    // rust: blue,
    // rust: replaceable,
    // rust: output: bindings
    // rust: .registry()
    // rust: .default_state("minecraft:blue_ice")
    // rust: .ok_or(DecodeError::Field("blue ice block"))?,
    // rust: })
}
    // rust: pub fn place<W: FeatureWorld + PlacementContext>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: random: &mut impl RandomSource,
    // rust: origin: [i32; 3],
    // rust: ) -> Result<bool, BlueIceError<W::Error>> {
    // rust: if origin[1]
    // rust: > world
    // rust: .sea_level()
    // rust: .map_err(BlueIceError::Query)?
    // rust: .wrapping_sub(1)
    // rust: {
    // rust: return Ok(false);
}
    // rust: if !self
    // rust: .water
    // rust: .contains(&world.block(origin).map_err(BlueIceError::World)?)
    // rust: && !self.water.contains(
    // rust: &world
    // rust: .block([origin[0], origin[1].wrapping_sub(1), origin[2]])
    // rust: .map_err(BlueIceError::World)?,
    // rust: )
    // rust: {
    // rust: return Ok(false);
}
    // rust: let mut nearby = false;
    // rust: for direction in Direction::ALL {
    // rust: if direction == Direction::Down {
    // rust: continue;
}
    // rust: let at = offset(origin, direction.normal());
    // rust: if self
    // rust: .packed
    // rust: .contains(&world.block(at).map_err(BlueIceError::World)?)
    // rust: {
    // rust: nearby = true;
    // rust: break;
}
}
    // rust: if !nearby {
    // rust: return Ok(false);
}
    // rust: world
    // rust: .set_block(origin, self.output, 2)
    // rust: .map_err(BlueIceError::World)?;
    // rust: for _ in 0..200 {
    // rust: let dy = random.next_int_bound(5).map_err(BlueIceError::Random)?
    // rust: - random.next_int_bound(6).map_err(BlueIceError::Random)?;
    // rust: let mut radius = 3;
    // rust: if dy < 2 {
    // rust: radius += dy / 2;
}
    // rust: if radius < 1 {
    // rust: continue;
}
    // rust: let dx = random
    // rust: .next_int_bound(radius)
    // rust: .map_err(BlueIceError::Random)?
    // rust: - random
    // rust: .next_int_bound(radius)
    // rust: .map_err(BlueIceError::Random)?;
    // rust: let dz = random
    // rust: .next_int_bound(radius)
    // rust: .map_err(BlueIceError::Random)?
    // rust: - random
    // rust: .next_int_bound(radius)
    // rust: .map_err(BlueIceError::Random)?;
    // rust: let p = offset(origin, [dx, dy, dz]);
    // rust: if !self
    // rust: .replaceable
    // rust: .contains(&world.block(p).map_err(BlueIceError::World)?)
    // rust: {
    // rust: continue;
}
    // rust: for direction in Direction::ALL {
    // rust: if self.blue.contains(
    // rust: &world
    // rust: .block(offset(p, direction.normal()))
    // rust: .map_err(BlueIceError::World)?,
    // rust: ) {
    // rust: world
    // rust: .set_block(p, self.output, 2)
    // rust: .map_err(BlueIceError::World)?;
    // rust: break;
}
}
}
    // rust: Ok(true)
}
}
offset :: proc(p: [i32; 3], d: [i32; 3]) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: std::array::from_fn(|i| p[i].wrapping_add(d[i]))
}
