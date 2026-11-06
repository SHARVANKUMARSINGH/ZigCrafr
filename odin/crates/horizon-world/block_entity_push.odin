//! Transpiled from Horizon Rust crate
package horizon_world_block_entity_push

import "core:fmt"
import "core:mem"
import "core:math"

// Block.pushEntitiesUp when replacement collision geometry adds occupied space.
// use crate::{entity_obstruction::EntityIdentity, registry::BlockStateId};
// use horizon_core::{
    // rust: geometry::{Aabb, Axis, ShapeError, ShapeOp, Vec3, VoxelShape},
    // rust: position::BlockPos,
}

    // rust: pub trait BlockPushWorld {
    // rust: type Error;
    // Native no-context block collision query, first old state, then new state.
    // rust: fn collision_shape(
    // rust: &mut self,
    // rust: state: BlockStateId,
    // rust: position: BlockPos,
    // rust: ) -> Result<VoxelShape, Self::Error>;
    // Return the native-selected nonspectator entities in query order. Selection
    // excludes no entity and uses the added shape's bounds, not exact overlap.
entities :: proc(self: ^Self, bounds: Aabb) -> R {
    // Ported from Horizon
    return {}
}
    // Read each current box just before its teleport: an earlier teleport can
    // change later entities. Handles must remain valid throughout this call.
entity_bounds :: proc(self: ^Self, entity: EntityIdentity) -> A {
    // Ported from Horizon
    return {}
}
    // rust: fn teleport_relative(
    // rust: &mut self,
    // rust: entity: EntityIdentity,
    // rust: movement: Vec3,
    // rust: ) -> Result<(), Self::Error>;
}
BlockPushError :: enum {
    World(E),
    Shape(ShapeError),
}
    // rust: impl<E: std::fmt::Display> std::fmt::Display for BlockPushError<E> {
fmt :: proc(self: ^Self, f: ^std::fmt::Formatter<'_>) -> s {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::World(e) => e.fmt(f),
    // rust: Self::Shape(e) => e.fmt(f),
}
}
}
    // rust: impl<E: std::error::Error + 'static> std::error::Error for BlockPushError<E> {}
    // rust: pub fn push_entities_up<W: BlockPushWorld>(
    // rust: world: &mut W,
    // rust: old: BlockStateId,
    // rust: new: BlockStateId,
    // rust: position: BlockPos,
    // rust: ) -> Result<BlockStateId, BlockPushError<W::Error>> {
    // rust: let old_shape = world
    // rust: .collision_shape(old, position)
    // rust: .map_err(BlockPushError::World)?;
    // rust: let new_shape = world
    // rust: .collision_shape(new, position)
    // rust: .map_err(BlockPushError::World)?;
    // rust: let added = old_shape
    // rust: .join_unoptimized(&new_shape, ShapeOp::ONLY_SECOND)
    // rust: .map_err(BlockPushError::Shape)?
    // rust: .moved(Vec3::new(
    // rust: f64::from(position.x),
    // rust: f64::from(position.y),
    // rust: f64::from(position.z),
    // rust: ));
    // rust: if let Some(bounds) = added.bounds() {
    // rust: let entities = world.entities(bounds).map_err(BlockPushError::World)?;
    // rust: for entity in entities {
    // rust: let bounds = world
    // rust: .entity_bounds(entity)
    // rust: .move_by(Vec3::new(0.0, 1.0, 0.0));
    // rust: let dy = added.collide(Axis::Y, bounds, -1.0);
    // rust: world
    // rust: .teleport_relative(entity, Vec3::new(0.0, 1.0 + dy, 0.0))
    // rust: .map_err(BlockPushError::World)?;
}
}
    // rust: Ok(new)
}
