//! Transpiled from Horizon Rust crate
//! Module: horizon-world_world_ray
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! BlockGetter clipping: ordered block/fluid queries and interaction-face override.
// use crate::entity_obstruction::EntityIdentity;
// use horizon_core::{
    // rust: geometry::{BlockHit, Direction, TraversalError, Vec3, VoxelShape, traverse_blocks},
    // rust: position::BlockPos,
}
// use std::fmt;
pub const RayBlockMode = enum {
    Collider,
    Outline,
    Visual,
    FallDamageResetting,
};
pub const RayFluidMode = enum {
    None,
    SourceOnly,
    Any,
    Water,
};
pub const RayResult = struct {
    hit: BlockHit,
    miss: bool,
};
pub const RayError = enum {
    Traversal(TraversalError),
    World(E),
};
    // rust: impl<E: fmt::Display> fmt::Display for RayError<E> {
pub fn fmt(self: *Self, f: *mut fmt::Formatter<'_>) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::Traversal(e) => e.fmt(f),
    // rust: Self::World(e) => e.fmt(f),
}
}
}
    // rust: impl<E: std::error::Error + 'static> std::error::Error for RayError<E> {}
/// Block/shape providers retain the captured collision context for the query.
/// State handles must remain valid when later provider calls change the world.
    // rust: pub trait RayWorld {
    // rust: type Error;
    // rust: type Block: Copy;
    // rust: type Fluid: Copy;
pub fn block_state(self: *Self, p: BlockPos) R;
pub fn fluid_state(self: *Self, p: BlockPos) R;
    // rust: fn block_shape(
    // rust: &mut self,
    // rust: state: Self::Block,
    // rust: p: BlockPos,
    // rust: mode: RayBlockMode,
    // rust: ) -> Result<VoxelShape, Self::Error>;
    // rust: fn interaction_shape(
    // rust: &mut self,
    // rust: state: Self::Block,
    // rust: p: BlockPos,
    // rust: ) -> Result<VoxelShape, Self::Error>;
pub fn fluid_is_source(self: *Self, state: Self::Fluid) R;
pub fn fluid_is_empty(self: *Self, state: Self::Fluid) R;
pub fn fluid_is_water(self: *Self, state: Self::Fluid) R;
pub fn fluid_shape(self: *Self, state: Self::Fluid, p: BlockPos) R;
}
    // rust: pub fn clip_with_interaction<W: RayWorld>(
    // rust: world: &mut W,
    // rust: start: Vec3,
    // rust: end: Vec3,
    // rust: p: BlockPos,
    // rust: shape: &VoxelShape,
    // rust: state: W::Block,
    // rust: ) -> Result<Option<BlockHit>, W::Error> {
    // rust: let mut hit = shape.clip(start, end, p);
    // rust: if let Some(hit) = &mut hit {
    // rust: if let Some(interaction) = world.interaction_shape(state, p)?.clip(start, end, p) {
    // rust: if interaction.location.subtract(start).length_squared()
    // rust: < hit.location.subtract(start).length_squared()
    // rust: {
    // rust: hit.direction = interaction.direction;
}
}
}
    // rust: Ok(hit)
}
    // rust: fn pick_fluid<W: RayWorld>(
    // rust: world: &mut W,
    // rust: state: W::Fluid,
    // rust: mode: RayFluidMode,
    // rust: ) -> Result<bool, W::Error> {
    // rust: match mode {
    // rust: RayFluidMode::None => Ok(false),
    // rust: RayFluidMode::SourceOnly => world.fluid_is_source(state),
    // rust: RayFluidMode::Any => Ok(!world.fluid_is_empty(state)?),
    // rust: RayFluidMode::Water => world.fluid_is_water(state),
}
}
/// Finite rays only, with an explicit traversal budget. Budget/provider failures
/// preserve preceding queries and return an error rather than a fabricated miss.
    // rust: pub fn clip_world<W: RayWorld>(
    // rust: world: &mut W,
    // rust: start: Vec3,
    // rust: end: Vec3,
    // rust: blocks: RayBlockMode,
    // rust: fluids: RayFluidMode,
    // rust: max_visits: usize,
    // rust: ) -> Result<RayResult, RayError<W::Error>> {
    // rust: let result = traverse_blocks(start, end, max_visits, |p| {
    // rust: let mut query = || -> Result<Option<BlockHit>, W::Error> {
    // rust: let block = world.block_state(p)?;
    // rust: let fluid = world.fluid_state(p)?;
    // rust: let shape = world.block_shape(block, p, blocks)?;
    // rust: let solid = clip_with_interaction(world, start, end, p, &shape, block)?;
    // rust: let liquid = if pick_fluid(world, fluid, fluids)? {
    // rust: world.fluid_shape(fluid, p)?.clip(start, end, p)
    // rust: } else {
    // rust: None
}
    // rust: let solid_distance = solid.map_or(f64::MAX, |h| start.distance_squared(h.location));
    // rust: let liquid_distance = liquid.map_or(f64::MAX, |h| start.distance_squared(h.location));
    // rust: Ok(if solid_distance <= liquid_distance {
    // rust: solid
    // rust: } else {
    // rust: liquid
    // rust: })
}
    // rust: match query() {
    // rust: Ok(Some(hit)) => Some(Ok(hit)),
    // rust: Ok(None) => None,
    // rust: Err(e) => Some(Err(e)),
}
    // rust: })
    // rust: .map_err(RayError::Traversal)?;
    // rust: match result {
    // rust: Some(hit) => Ok(RayResult {
    // rust: hit: hit.map_err(RayError::World)?,
    // rust: miss: false,
    // rust: }),
    // rust: None => Ok(RayResult {
    // rust: hit: BlockHit {
    // rust: location: end,
    // rust: direction: Direction::approximate_nearest(start.subtract(end)),
    // rust: block: BlockPos::new(
    // rust: end.x.floor() as i32,
    // rust: end.y.floor() as i32,
    // rust: end.z.floor() as i32,
    // rust: ),
    // rust: inside: false,
    // rust: },
    // rust: miss: true,
    // rust: }),
}
}
pub const ResetPortal = enum {
    EndGateway,
    EndPortal,
    NetherPortal,
};
    // rust: pub trait FallResetWorld {
    // rust: type Error;
    // rust: type Block: Copy;
pub fn fall_reset_tag(self: *Self, state: Self::Block) R;
pub fn entity_is_player(self: *Self, entity: EntityIdentity) R;
pub fn is_portal(self: *Self, state: Self::Block, portal: ResetPortal) R;
pub fn is_server_level(self: *Self) b;
pub fn players_nether_portal_delay(self: *Self) R;
}
/// Supply an entity only when the native context is an EntityCollisionContext
/// containing one. Player testing is entity type identity, not a class check.
    // rust: pub fn fall_reset_shape<W: FallResetWorld>(
    // rust: world: &mut W,
    // rust: state: W::Block,
    // rust: entity: Option<EntityIdentity>,
    // rust: ) -> Result<VoxelShape, W::Error> {
    // rust: if world.fall_reset_tag(state)? {
    // rust: return Ok(VoxelShape::block());
}
    // rust: if let Some(entity) = entity {
    // rust: if world.entity_is_player(entity)? {
    // rust: if world.is_portal(state, ResetPortal::EndGateway)?
    // rust: || world.is_portal(state, ResetPortal::EndPortal)?
    // rust: {
    // rust: return Ok(VoxelShape::block());
}
    // rust: if world.is_server_level()
    // rust: && world.is_portal(state, ResetPortal::NetherPortal)?
    // rust: && world.players_nether_portal_delay()? == 0
    // rust: {
    // rust: return Ok(VoxelShape::block());
}
}
}
    // rust: Ok(VoxelShape::empty())
}
