//! Transpiled from Horizon Rust crate
package horizon_client_placement

import "core:fmt"
import "core:mem"
import "core:math"

// BoatItem's server POV clip; deliberately separate from renderer/mining picks.
// use super::{Fluid, Game};
// use horizon_core::{
    // rust: geometry::{Aabb, ShapeOp, Vec3, VoxelShape},
    // rust: position::BlockPos,
}
// use horizon_world::{
    // rust: registry::BlockStateId,
    // rust: world_ray::{RayBlockMode, RayFluidMode, RayWorld, clip_world},
}
// use std::io;

BoatItemRay :: struct {
    // rust: impl RayWorld for BoatItemRay<'_, '_> {
    // rust: type Error = io::Error;
    // rust: type Block = BlockStateId;
    // rust: type Fluid = Option<(f32, bool, Fluid)>;
block_state :: proc(self: ^Self, p: BlockPos) -> i {
    // Ported from Horizon
    return {}
}
    // rust: Ok(self.0.world.block(p.x, p.y, p.z))
}
fluid_state :: proc(self: ^Self, p: BlockPos) -> i {
    // Ported from Horizon
    return {}
}
    // rust: Ok(self
    // rust: .0
    // rust: .fluid_height_of(p.x, p.y, p.z, None)
    // rust: .map(|(h, source)| {
    // rust: (
    // rust: h,
    // rust: source,
    // rust: self.0
    // rust: .res
    // rust: .facts()
    // rust: .get(self.0.world.block(p.x, p.y, p.z))
    // rust: .fluid,
    // rust: )
    // rust: }))
}
    // rust: fn block_shape(
    // rust: &mut self,
    // rust: state: BlockStateId,
    // rust: p: BlockPos,
    // rust: _: RayBlockMode,
    // rust: ) -> io::Result<VoxelShape> {
        // LiquidBlock.getShape is empty. Waterlogged blocks retain their outline.
    // rust: if matches!(
    // rust: &*self.0.res.facts().get(state).name,
    // rust: "minecraft:water" | "minecraft:lava" | "minecraft:bubble_column"
    // rust: ) {
    // rust: return Ok(VoxelShape::empty());
}
    // rust: let mut shape = VoxelShape::empty();
    // rust: for b in self.0.outline_boxes([p.x, p.y, p.z]) {
    // rust: let b: [f64; 6] = std::array::from_fn(|i| b[i] - f64::from([p.x, p.y, p.z][i % 3]));
    // rust: let part = VoxelShape::from_box(Aabb::new(
    // rust: Vec3::new(b[0], b[1], b[2]),
    // rust: Vec3::new(b[3], b[4], b[5]),
    // rust: ))
    // rust: .map_err(|e| io::Error::other(format!("{e:?}")))?;
    // rust: shape = shape
    // rust: .join(&part, ShapeOp::OR)
    // rust: .map_err(|e| io::Error::other(format!("{e:?}")))?;
}
    // rust: Ok(shape)
}
interaction_shape :: proc(self: ^Self, _: BlockStateId, _: BlockPos) -> i {
    // Ported from Horizon
    return {}
}
        // Pinned vanilla's registered interaction shapes are all empty;
        // interaction_shapes::InteractionShapes validates that same table.
    // rust: Ok(VoxelShape::empty())
}
fluid_is_source :: proc(self: ^Self, s: Self::Fluid) -> i {
    // Ported from Horizon
    return {}
}
    // rust: Ok(s.is_some_and(|s| s.1))
}
fluid_is_empty :: proc(self: ^Self, s: Self::Fluid) -> i {
    // Ported from Horizon
    return {}
}
    // rust: Ok(s.is_none())
}
fluid_is_water :: proc(self: ^Self, s: Self::Fluid) -> i {
    // Ported from Horizon
    return {}
}
    // rust: Ok(s.is_some_and(|s| s.2 == Fluid::Water))
}
fluid_shape :: proc(self: ^Self, s: Self::Fluid, _: BlockPos) -> i {
    // Ported from Horizon
    return {}
}
    // rust: match s {
    // rust: None => Ok(VoxelShape::empty()),
    // rust: Some((h, _, _)) => {
    // rust: VoxelShape::from_box(Aabb::new(Vec3::ZERO, Vec3::new(1.0, f64::from(h), 1.0)))
    // rust: .map_err(|e| io::Error::other(format!("{e:?}")))
}
}
}
}
    // rust: impl Game<'_> {
    // `Item.getPlayerPOVHitResult`: float view vector, OUTLINE and Fluid.ANY.
    // rust: pub(super) fn boat_item_hit(&self) -> Option<[f64; 3]> {
    // rust: let [x, y, z] = self.eye_position()?;
    // rust: let start = Vec3::new(x, y, z);
    // rust: let dir = horizon_world::view_direction::view_vector(self.pitch, self.yaw);
    // rust: let end = start.add_vector(dir.scale(self.reach()));
    // rust: let hit = clip_world(
    // rust: &mut BoatItemRay(self),
    // rust: start,
    // rust: end,
    // rust: RayBlockMode::Outline,
    // rust: RayFluidMode::Any,
    // rust: 256,
    // rust: )
    // rust: .ok()?;
    // rust: (!hit.miss).then_some([hit.hit.location.x, hit.hit.location.y, hit.hit.location.z])
}
}
