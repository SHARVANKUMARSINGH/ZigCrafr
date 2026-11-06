//! Transpiled from Horizon Rust crate
//! Module: horizon-world_movement_support
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Support-dependent block positions and Entity movement factors.
// use horizon_core::{geometry::Vec3, position::BlockPos};

pub const LEGACY_SUPPORT_OFFSET: f32 = 0.2;
pub const MOVEMENT_SUPPORT_OFFSET: f32 = 0.500001;
pub const ON_SUPPORT_OFFSET: f32 = 1.0e-5;

/// State handles must remain valid for the duration of a query. Tag predicates
/// are separate to preserve native short circuits and reloadable tag membership.
    // rust: pub trait MovementBlockWorld {
    // rust: type Error;
    // rust: type State: Copy;
pub fn block_state(self: *Self, position: BlockPos) R;
pub fn is_fence(self: *Self, state: Self::State) R;
pub fn is_wall(self: *Self, state: Self::State) R;
pub fn is_fence_gate(self: *Self, state: Self::State) R;
pub fn is_water(self: *Self, state: Self::State) R;
pub fn is_bubble_column(self: *Self, state: Self::State) R;
pub fn jump_factor(self: *Self, state: Self::State) R;
pub fn speed_factor(self: *Self, state: Self::State) R;
}
pub const MovementLocation = struct {
    position: Vec3,
    /// Entity.blockPosition's captured value; do not recompute it here.
    block_position: BlockPos,
    supporting_block: ?BlockPos,
};
/// Entity.getOnPos(float). The offset is a float widened before subtraction.
    // rust: pub fn support_position<W: MovementBlockWorld>(
    // rust: world: &mut W,
    // rust: position: Vec3,
    // rust: supporting_block: Option<BlockPos>,
    // rust: offset: f32,
    // rust: ) -> Result<BlockPos, W::Error> {
    // rust: if let Some(support) = supporting_block {
    // rust: if offset > ON_SUPPORT_OFFSET {
    // rust: let block = world.block_state(support)?;
    // rust: if (f64::from(offset) <= 0.5 && world.is_fence(block)?)
    // rust: || world.is_wall(block)?
    // rust: || world.is_fence_gate(block)?
    // rust: {
    // rust: return Ok(support);
}
    // rust: Ok(BlockPos::new(
    // rust: support.x,
    // rust: (position.y - f64::from(offset)).floor() as i32,
    // rust: support.z,
    // rust: ))
    // rust: } else {
    // rust: Ok(support)
}
    // rust: } else {
    // rust: Ok(BlockPos::new(
    // rust: position.x.floor() as i32,
    // rust: (position.y - f64::from(offset)).floor() as i32,
    // rust: position.z.floor() as i32,
    // rust: ))
}
}
    // rust: fn below<W: MovementBlockWorld>(
    // rust: world: &mut W,
    // rust: location: MovementLocation,
    // rust: ) -> Result<W::State, W::Error> {
    // rust: let position = support_position(
    // rust: world,
    // rust: location.position,
    // rust: location.supporting_block,
    // rust: MOVEMENT_SUPPORT_OFFSET,
    // rust: )?;
    // rust: world.block_state(position)
}
    // rust: pub fn block_jump_factor<W: MovementBlockWorld>(
    // rust: world: &mut W,
    // rust: location: MovementLocation,
    // rust: ) -> Result<f32, W::Error> {
    // rust: let current = world.block_state(location.block_position)?;
    // rust: let current = world.jump_factor(current)?;
    // Native always evaluates the lower block, even if current is not one.
    // rust: let lower = below(world, location)?;
    // rust: let lower = world.jump_factor(lower)?;
    // rust: Ok(if current == 1.0 { lower } else { current })
}
    // rust: pub fn block_speed_factor<W: MovementBlockWorld>(
    // rust: world: &mut W,
    // rust: location: MovementLocation,
    // rust: ) -> Result<f32, W::Error> {
    // rust: let current = world.block_state(location.block_position)?;
    // rust: let factor = world.speed_factor(current)?;
    // rust: if world.is_water(current)? || world.is_bubble_column(current)? || factor != 1.0 {
    // rust: return Ok(factor);
}
    // rust: let lower = below(world, location)?;
    // rust: world.speed_factor(lower)
}
