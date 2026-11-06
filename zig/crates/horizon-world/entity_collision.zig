//! Transpiled from Horizon Rust crate
//! Module: horizon-world_entity_collision
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! EntityGetter collision shape selection over an ordered entity snapshot.
// use crate::entity_obstruction::EntityIdentity;
// use horizon_core::geometry::{Aabb, ShapeError, Vec3, VoxelShape};

pub const CollisionCandidate = struct {
    identity: EntityIdentity,
    bounds: Aabb,
    spectator: bool,
};
    // rust: pub trait EntityCollisionWorld {
    // rust: type Error;
    /// Query the inflated bounds, preserving native entity iteration order.
    /// The implementation may return a broad-phase superset. Snapshot entities
    /// must remain available for the following collision-policy callbacks.
    // rust: fn collision_candidates(
    // rust: &mut self,
    // rust: source: Option<EntityIdentity>,
    // rust: bounds: Aabb,
    // rust: ) -> Result<Vec<CollisionCandidate>, Self::Error>;
    /// With a source, invoke source.canCollideWith(candidate). Without one,
    /// invoke candidate.canBeCollidedWith(null). Entity-specific policies and
    /// vehicle relationships belong to the provider, and run only after filters.
    // rust: fn can_collide(
    // rust: &mut self,
    // rust: source: Option<EntityIdentity>,
    // rust: candidate: EntityIdentity,
    // rust: ) -> Result<bool, Self::Error>;
}
pub const EntityCollisionError = enum {
    World(E),
    Shape(ShapeError),
};
    // rust: impl<E: std::fmt::Display> std::fmt::Display for EntityCollisionError<E> {
pub fn fmt(self: *Self, f: *mut std::fmt::Formatter<'_>) s {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::World(e) => e.fmt(f),
    // rust: Self::Shape(e) => e.fmt(f),
}
}
}
    // rust: impl<E: std::error::Error + 'static> std::error::Error for EntityCollisionError<E> {}

    // rust: pub fn entity_collision_shapes<W: EntityCollisionWorld>(
    // rust: world: &mut W,
    // rust: source: Option<EntityIdentity>,
    // rust: bounds: Aabb,
    // rust: ) -> Result<Vec<VoxelShape>, EntityCollisionError<W::Error>> {
    // rust: let size = bounds.size();
    // rust: if (size.x + size.y + size.z) / 3.0 < 1.0e-7 {
    // rust: return Ok(Vec::new());
}
    // rust: let query = bounds.inflate(Vec3::new(1.0e-7, 1.0e-7, 1.0e-7));
    // rust: let candidates = world
    // rust: .collision_candidates(source, query)
    // rust: .map_err(EntityCollisionError::World)?;
    // rust: let mut selected = Vec::new();
    // rust: for candidate in candidates {
    // rust: if source == Some(candidate.identity)
    // rust: || !candidate.bounds.intersects(query)
    // rust: || candidate.spectator
    // rust: {
    // rust: continue;
}
    // rust: if world
    // rust: .can_collide(source, candidate.identity)
    // rust: .map_err(EntityCollisionError::World)?
    // rust: {
    // rust: selected.push(candidate.bounds);
}
}
    // rust: selected
    // rust: .into_iter()
    // rust: .map(|bounds| VoxelShape::from_box(bounds).map_err(EntityCollisionError::Shape))
    // rust: .collect()
}
