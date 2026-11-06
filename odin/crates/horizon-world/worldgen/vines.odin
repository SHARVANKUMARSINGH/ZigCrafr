//! Transpiled from Horizon Rust crate
package horizon_world_vines

import "core:fmt"
import "core:mem"
import "core:math"

// One vine attachment in native direction priority order.
// use super::{
    // rust: DecodeError,
    // rust: block_feature::{BlockFeatureError, FeatureBlockBindings},
    // rust: feature::FeatureWorld,
    // rust: placement::PlacementContext,
}
// use crate::registry::BlockStateId;
// use horizon_core::geometry::Direction;
    // rust: const DIRECTIONS: [Direction; 5] = [
    // rust: Direction::Up,
    // rust: Direction::North,
    // rust: Direction::South,
    // rust: Direction::West,
    // rust: Direction::East,
    // rust: ];
VinesFeature :: struct {
    air: [BlockStateId,
    states: [BlockStateId,
}
    // rust: impl VinesFeature {
new :: proc(bindings: ^FeatureBlockBindings<'_>) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let registry = bindings.registry();
    // rust: let default = registry
    // rust: .default_state("minecraft:vine")
    // rust: .ok_or(DecodeError::Field("vine block missing"))?;
    // rust: let mut states = [default; 5];
    // rust: for (i, name) in ["up", "north", "south", "west", "east"]
    // rust: .into_iter()
    // rust: .enumerate()
    // rust: {
    // rust: let mut state = registry.state(default).unwrap().clone();
    // rust: state.properties.insert(name.into(), "true".into());
    // rust: states[i] = registry
    // rust: .id(&state)
    // rust: .ok_or(DecodeError::Field("vine face missing"))?;
}
    // rust: Ok(Self {
    // rust: air: bindings.air,
    // rust: states,
    // rust: })
}
    // rust: pub fn place<W: FeatureWorld + PlacementContext>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: p: [i32; 3],
    // rust: ) -> Result<bool, BlockFeatureError<W::Error>> {
    // rust: if !self
    // rust: .air
    // rust: .contains(&world.block(p).map_err(BlockFeatureError::World)?)
    // rust: {
    // rust: return Ok(false);
}
    // rust: for (direction, state) in DIRECTIONS.into_iter().zip(self.states) {
    // rust: if world
    // rust: .attachment_at(p, direction)
    // rust: .map_err(BlockFeatureError::Query)?
    // rust: {
    // rust: world
    // rust: .set_block(p, state, 2)
    // rust: .map_err(BlockFeatureError::World)?;
    // rust: return Ok(true);
}
}
    // rust: Ok(false)
}
}
