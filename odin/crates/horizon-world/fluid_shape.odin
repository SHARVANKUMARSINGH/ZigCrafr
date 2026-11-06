//! Transpiled from Horizon Rust crate
package horizon_world_fluid_shape

import "core:fmt"
import "core:mem"
import "core:math"

// Persistent pinned-fluid collision/ray shapes, including first-query caching.
// use crate::fluid::{FluidHeightWorld, FluidKind, FluidState};
// use horizon_core::{
    // rust: geometry::{Aabb, Vec3, VoxelShape},
    // rust: position::BlockPos,
}

// Share this cache across world views using the same fluid registry, as native
// registered Fluid instances retain their shape maps across world queries.
// The pinned registry has no amount-nine state; amounts are zero through eight.
FluidShapeCache :: struct {
    shapes: [dynamic]Maybe(VoxelShape),
}
    // rust: impl Default for FluidShapeCache {
default :: proc() -> S {
    // Ported from Horizon
    return {}
}
    // rust: Self {
    // rust: shapes: vec![None; 5 * 18],
}
}
}
    // rust: impl FluidShapeCache {
cached_states :: proc(self: ^Self) -> u {
    // Ported from Horizon
    return {}
}
    // rust: self.shapes.iter().filter(|v| v.is_some()).count()
}
    // rust: pub fn shape<W: FluidHeightWorld>(
    // rust: &mut self,
    // rust: world: &mut W,
    // rust: state: FluidState,
    // rust: position: BlockPos,
    // rust: ) -> Result<VoxelShape, W::Error> {
    // rust: if state.kind() == FluidKind::Empty {
    // rust: return Ok(VoxelShape::empty());
}
    // rust: let index = state.kind() as usize * 18
    // rust: + usize::from(state.falling()) * 9
    // rust: + usize::from(state.amount());
    // rust: if let Some(shape) = &self.shapes[index] {
    // rust: return Ok(shape.clone());
}
    // rust: let height = f64::from(state.height_at(world, [position.x, position.y, position.z])?);
        // FluidState validates all amounts and height_at returns [0,1].
    // rust: let shape = VoxelShape::from_box(Aabb::new(Vec3::ZERO, Vec3::new(1.0, height, 1.0)))
    // rust: .expect("validated pinned fluid height");
    // rust: self.shapes[index] = Some(shape.clone());
    // rust: Ok(shape)
}
}
