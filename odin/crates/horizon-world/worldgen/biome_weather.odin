//! Transpiled from Horizon Rust crate
package horizon_world_biome_weather

import "core:fmt"
import "core:mem"
import "core:math"

// Registry-bound freezing and snow-placement eligibility using biome temperature.
// use super::{
    // rust: DecodeError,
    // rust: biome_temperature::{BiomeTemperature, Precipitation},
    // rust: block_feature::FeatureBlockBindings,
    // rust: placement::{PlacementContext, PlacementQueryError},
}
// use crate::{fluid::FluidKind, registry::BlockStateId};
// use horizon_core::position::BlockPos;
// use std::{collections::BTreeSet, sync::Arc};
BiomeWeatherBindings :: struct {
    liquid_blocks: ^BTreeSet<BlockStateId>,
    snow_states: ^BTreeSet<BlockStateId>,
    snow: BlockStateId,
    air: [BlockStateId,
}
    // rust: impl BiomeWeatherBindings {
new :: proc(bindings: ^FeatureBlockBindings<'_>) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let mut liquids = BTreeSet::new();
        // WATER and LAVA are the pinned vanilla registry's LiquidBlock instances.
    // rust: for name in ["minecraft:water", "minecraft:lava"] {
    // rust: liquids.extend(
    // rust: bindings
    // rust: .blocks
    // rust: .get(name)
    // rust: .ok_or(DecodeError::Field("weather liquid blocks"))?
    // rust: .iter()
    // rust: .copied(),
    // rust: );
}
    // rust: Ok(Self {
    // rust: liquid_blocks: Arc::new(liquids),
    // rust: snow_states: bindings
    // rust: .blocks
    // rust: .get("minecraft:snow")
    // rust: .cloned()
    // rust: .ok_or(DecodeError::Field("weather snow states"))?,
    // rust: snow: bindings
    // rust: .registry()
    // rust: .default_state("minecraft:snow")
    // rust: .ok_or(DecodeError::Field("weather snow state"))?,
    // rust: air: bindings.air,
    // rust: })
}
    // rust: pub fn should_freeze(
    // rust: &self,
    // rust: world: &mut impl PlacementContext,
    // rust: temperature: &mut BiomeTemperature,
    // rust: p: [i32; 3],
    // rust: require_edge: bool,
    // rust: ) -> Result<bool, PlacementQueryError> {
    // rust: if temperature.warm_enough_to_rain(BlockPos::new(p[0], p[1], p[2]), world.sea_level()?) {
    // rust: return Ok(false);
}
    // rust: if !world.inside_build_height(p)? || world.block_brightness(p)? >= 10 {
    // rust: return Ok(false);
}
    // rust: let state = world.block_state(p)?;
    // rust: let fluid = world.fluid_state(p)?;
    // rust: if fluid.kind() != FluidKind::Water || !self.liquid_blocks.contains(&state) {
    // rust: return Ok(false);
}
    // rust: if !require_edge {
    // rust: return Ok(true);
}
    // rust: for d in [[-1, 0, 0], [1, 0, 0], [0, 0, -1], [0, 0, 1]] {
    // rust: if !world.water_at(std::array::from_fn(|i| p[i].wrapping_add(d[i])))? {
    // rust: return Ok(true);
}
}
    // rust: Ok(false)
}
    // rust: pub fn should_snow(
    // rust: &self,
    // rust: world: &mut impl PlacementContext,
    // rust: temperature: &mut BiomeTemperature,
    // rust: p: [i32; 3],
    // rust: ) -> Result<bool, PlacementQueryError> {
    // rust: if temperature.precipitation_at(BlockPos::new(p[0], p[1], p[2]), world.sea_level()?)
    // rust: != Precipitation::Snow
    // rust: {
    // rust: return Ok(false);
}
    // rust: if !world.inside_build_height(p)? || world.block_brightness(p)? >= 10 {
    // rust: return Ok(false);
}
    // rust: let state = world.block_state(p)?;
    // rust: if !self.air.contains(&state) && !self.snow_states.contains(&state) {
    // rust: return Ok(false);
}
    // rust: world.block_survives(self.snow, p)
}
}
