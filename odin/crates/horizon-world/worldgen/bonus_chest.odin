//! Transpiled from Horizon Rust crate
package horizon_world_bonus_chest

import "core:fmt"
import "core:mem"
import "core:math"

// Spawn bonus chest search, loot-table assignment and surrounding torches.
// use super::{
    // rust: DecodeError,
    // rust: block_feature::FeatureBlockBindings,
    // rust: feature::FeatureWorld,
    // rust: placement::{PlacementContext, PlacementQueryError},
}
// use crate::{heightmap::HeightmapType, registry::BlockStateId};
// use horizon_core::random::{InvalidBound, RandomSource};
BonusChestFeature :: struct {
    air: [BlockStateId,
    chest: BlockStateId,
    torch: BlockStateId,
}
BonusChestError :: enum {
    World(E),
    Query(PlacementQueryError),
    Random(InvalidBound),
}
    // rust: impl<E: std::fmt::Display> std::fmt::Display for BonusChestError<E> {
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
    // rust: impl<E: std::error::Error + 'static> std::error::Error for BonusChestError<E> {}
    // rust: impl BonusChestFeature {
new :: proc(bindings: ^FeatureBlockBindings<'_>) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let get = |name| {
    // rust: bindings
    // rust: .registry()
    // rust: .default_state(name)
    // rust: .ok_or_else(|| DecodeError::Registry(format!("unknown bonus chest block {name}")))
}
    // rust: Ok(Self {
    // rust: air: bindings.air,
    // rust: chest: get("minecraft:chest")?,
    // rust: torch: get("minecraft:torch")?,
    // rust: })
}
    // rust: pub fn place<W: FeatureWorld + PlacementContext>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: random: &mut impl RandomSource,
    // rust: origin: [i32; 3],
    // rust: ) -> Result<bool, BonusChestError<W::Error>> {
    // rust: let mut xs: [i32; 16] = std::array::from_fn(|i| (origin[0] & !15).wrapping_add(i as i32));
    // rust: let mut zs: [i32; 16] = std::array::from_fn(|i| (origin[2] & !15).wrapping_add(i as i32));
    // rust: for values in [&mut xs, &mut zs] {
    // rust: for end in (2..=16).rev() {
    // rust: let other = random
    // rust: .next_int_bound(end as i32)
    // rust: .map_err(BonusChestError::Random)? as usize;
    // rust: values.swap(end - 1, other);
}
}
    // rust: for x in xs {
    // rust: for z in zs {
    // rust: let y = world
    // rust: .height(HeightmapType::MotionBlockingNoLeaves, x, z)
    // rust: .map_err(BonusChestError::Query)?;
    // rust: let p = [x, y, z];
    // rust: if !self
    // rust: .air
    // rust: .contains(&world.block(p).map_err(BonusChestError::World)?)
    // rust: {
    // rust: let state = world.block(p).map_err(BonusChestError::World)?;
    // rust: if !world
    // rust: .state_collision_empty(state, p)
    // rust: .map_err(BonusChestError::Query)?
    // rust: {
    // rust: continue;
}
}
    // rust: world
    // rust: .set_block(p, self.chest, 2)
    // rust: .map_err(BonusChestError::World)?;
    // rust: world
    // rust: .set_block_entity_loot_table(p, "minecraft:chests/spawn_bonus_chest", random)
    // rust: .map_err(BonusChestError::Query)?;
    // rust: for [dx, dz] in [[0, -1], [1, 0], [0, 1], [-1, 0]] {
    // rust: let at = [x.wrapping_add(dx), y, z.wrapping_add(dz)];
    // rust: if world
    // rust: .block_survives(self.torch, at)
    // rust: .map_err(BonusChestError::Query)?
    // rust: {
    // rust: world
    // rust: .set_block(at, self.torch, 2)
    // rust: .map_err(BonusChestError::World)?;
}
}
    // rust: return Ok(true);
}
}
    // rust: Ok(false)
}
}
