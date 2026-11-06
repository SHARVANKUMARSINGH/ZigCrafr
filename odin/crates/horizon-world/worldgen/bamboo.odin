//! Transpiled from Horizon Rust crate
package horizon_world_bamboo

import "core:fmt"
import "core:mem"
import "core:math"

// Bamboo stalks, podzol patches and ordered cap overwrites.
// use super::{
    // rust: DecodeError, Object,
    // rust: block_feature::FeatureBlockBindings,
    // rust: feature::FeatureWorld,
    // rust: number_text,
    // rust: placement::{PlacementContext, PlacementQueryError},
    // rust: required,
}
// use crate::{heightmap::HeightmapType, registry::BlockStateId};
// use horizon_core::random::{InvalidBound, RandomSource};
// use std::{collections::BTreeSet, sync::Arc};
BambooFeature :: struct {
    probability: f32,
    air: [BlockStateId,
    bamboo: BlockStateId,
    trunk: BlockStateId,
    caps: [BlockStateId,
    podzol: BlockStateId,
    replaceable: ^BTreeSet<BlockStateId>,
}
BambooError :: enum {
    World(E),
    Query(PlacementQueryError),
    Random(InvalidBound),
    WorkLimit,
}
    // rust: impl<E: std::fmt::Display> std::fmt::Display for BambooError<E> {
fmt :: proc(self: ^Self, f: ^std::fmt::Formatter<'_>) -> s {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::World(e) => e.fmt(f),
    // rust: Self::Query(e) => e.fmt(f),
    // rust: Self::Random(e) => e.fmt(f),
    // rust: Self::WorkLimit => f.write_str("bamboo work limit exceeded"),
}
}
}
    // rust: impl<E: std::error::Error + 'static> std::error::Error for BambooError<E> {}
    // rust: impl BambooFeature {
from_json :: proc(json: string, bindings: ^FeatureBlockBindings<'_>) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let object: Object = serde_json::from_str(json)?;
    // rust: let probability = number_text(required(&object, "probability")?)?
    // rust: .parse::<f64>()
    // rust: .map_err(|_| DecodeError::Field("bamboo probability"))?
    // rust: as f32;
    // rust: if !(0.0..=1.0).contains(&probability) || probability.is_sign_negative() {
    // rust: return Err(DecodeError::Field("bamboo probability"));
}
    // rust: let state = |leaves, stage| {
    // rust: bindings.codec.decode(&format!(r#"{{"id":"bamboo","properties":{{"age":"1","leaves":"{leaves}","stage":"{stage}"}}}}"#),false).map_err(|e|DecodeError::Registry(e.to_string()))
}
    // rust: let get = |name| {
    // rust: bindings
    // rust: .registry()
    // rust: .default_state(name)
    // rust: .ok_or_else(|| DecodeError::Registry(format!("unknown bamboo block {name}")))
}
    // rust: Ok(Self {
    // rust: probability,
    // rust: air: bindings.air,
    // rust: bamboo: get("minecraft:bamboo")?,
    // rust: trunk: state("none", 0)?,
    // rust: caps: [state("large", 1)?, state("large", 0)?, state("small", 0)?],
    // rust: podzol: get("minecraft:podzol")?,
    // rust: replaceable: bindings
    // rust: .tags
    // rust: .get("minecraft:beneath_bamboo_podzol_replaceable")
    // rust: .cloned()
    // rust: .unwrap_or_default(),
    // rust: })
}
    // rust: pub fn place<W: FeatureWorld + PlacementContext>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: random: &mut impl RandomSource,
    // rust: origin: [i32; 3],
    // rust: ) -> Result<bool, BambooError<W::Error>> {
    // rust: if !self
    // rust: .air
    // rust: .contains(&world.block(origin).map_err(BambooError::World)?)
    // rust: {
    // rust: return Ok(false);
}
        // Native success records the air-origin attempt, even if survival fails.
    // rust: if !world
    // rust: .block_survives(self.bamboo, origin)
    // rust: .map_err(BambooError::Query)?
    // rust: {
    // rust: return Ok(true);
}
    // rust: let height = random.next_int_bound(12).map_err(BambooError::Random)? + 5;
    // rust: if random.next_float() < self.probability {
    // rust: let radius = random.next_int_bound(4).map_err(BambooError::Random)? + 1;
    // rust: let mut x = origin[0].wrapping_sub(radius);
    // rust: let max_x = origin[0].wrapping_add(radius);
    // rust: let mut remaining = 1_048_576;
    // rust: while x <= max_x {
    // rust: let mut z = origin[2].wrapping_sub(radius);
    // rust: let max_z = origin[2].wrapping_add(radius);
    // rust: while z <= max_z {
    // rust: if remaining == 0 {
    // rust: return Err(BambooError::WorkLimit);
}
    // rust: remaining -= 1;
    // rust: let dx = x.wrapping_sub(origin[0]);
    // rust: let dz = z.wrapping_sub(origin[2]);
    // rust: if dx.wrapping_mul(dx).wrapping_add(dz.wrapping_mul(dz)) <= radius * radius {
    // rust: let y = world
    // rust: .height(HeightmapType::WorldSurface, x, z)
    // rust: .map_err(BambooError::Query)?
    // rust: .wrapping_sub(1);
    // rust: let p = [x, y, z];
    // rust: if self
    // rust: .replaceable
    // rust: .contains(&world.block(p).map_err(BambooError::World)?)
    // rust: {
    // rust: world
    // rust: .set_block(p, self.podzol, 2)
    // rust: .map_err(BambooError::World)?;
}
}
    // rust: z = z.wrapping_add(1);
}
                // Also bound overflow loops when the inner range is empty.
    // rust: if remaining == 0 {
    // rust: return Err(BambooError::WorkLimit);
}
    // rust: remaining -= 1;
    // rust: x = x.wrapping_add(1);
}
}
    // rust: let mut p = origin;
    // rust: for _ in 0..height {
    // rust: if !self
    // rust: .air
    // rust: .contains(&world.block(p).map_err(BambooError::World)?)
    // rust: {
    // rust: break;
}
    // rust: world
    // rust: .set_block(p, self.trunk, 2)
    // rust: .map_err(BambooError::World)?;
    // rust: p[1] = p[1].wrapping_add(1);
}
    // rust: if p[1].wrapping_sub(origin[1]) >= 3 {
            // The first cap occupies the stopping position, including an obstacle.
    // rust: for state in self.caps {
    // rust: world.set_block(p, state, 2).map_err(BambooError::World)?;
    // rust: p[1] = p[1].wrapping_sub(1);
}
}
    // rust: Ok(true)
}
}
