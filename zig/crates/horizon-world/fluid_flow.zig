//! Transpiled from Horizon Rust crate
//! Module: horizon-world_fluid_flow
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Neighbor-derived water/lava currents and falling-fluid wall deflection.
// use crate::fluid::{FluidKind, FluidState};
// use horizon_core::{
    // rust: geometry::{Direction, Vec3},
    // rust: position::BlockPos,
}

    // rust: pub trait FluidFlowWorld {
    // rust: type Error;
    // rust: type Block: Copy;
pub fn fluid(self: *Self, position: BlockPos) R;
pub fn block(self: *Self, position: BlockPos) R;
    /// Resolved BLOCKS_FLUID_FLOW tag membership for the captured state.
pub fn blocks_fluid_flow(self: *Self, state: Self::Block) b;
    /// Actual IceBlock class membership, including its subclasses.
pub fn is_ice_class(self: *Self, state: Self::Block) b;
    // rust: fn is_face_sturdy(
    // rust: &mut self,
    // rust: state: Self::Block,
    // rust: position: BlockPos,
    // rust: direction: Direction,
    // rust: ) -> Result<bool, Self::Error>;
}
/// Native wall test reads both block and fluid before any early return. The
/// supplied face is the scan direction, rather than its opposite.
    // rust: pub fn solid_face<W: FluidFlowWorld>(
    // rust: world: &mut W,
    // rust: kind: FluidKind,
    // rust: position: BlockPos,
    // rust: direction: Direction,
    // rust: ) -> Result<bool, W::Error> {
    // rust: let block = world.block(position)?;
    // rust: let fluid = world.fluid(position)?;
    // rust: if fluid.kind().same_family(kind) {
    // rust: return Ok(false);
}
    // rust: if direction == Direction::Up {
    // rust: return Ok(true);
}
    // rust: if world.is_ice_class(block) {
    // rust: return Ok(false);
}
    // rust: world.is_face_sturdy(block, position, direction)
}
pub fn affects_flow(kind: FluidKind, neighbor: FluidState) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: neighbor.kind() == FluidKind::Empty || neighbor.kind().same_family(kind)
}
    // rust: const HORIZONTAL: [Direction; 4] = [
    // rust: Direction::North,
    // rust: Direction::East,
    // rust: Direction::South,
    // rust: Direction::West,
    // rust: ];
/// The height differences and directional products round as f32 before being
/// accumulated in f64. Falling currents normalize before and after the Y push.
    // rust: pub fn flow_at<W: FluidFlowWorld>(
    // rust: world: &mut W,
    // rust: state: FluidState,
    // rust: position: BlockPos,
    // rust: ) -> Result<Vec3, W::Error> {
    // rust: if state.kind() == FluidKind::Empty {
    // rust: return Ok(Vec3::ZERO);
}
    // rust: let mut x = 0.0;
    // rust: let mut z = 0.0;
    // rust: for direction in HORIZONTAL {
    // rust: let [dx, dy, dz] = direction.normal();
    // rust: let p = position.offset(dx, dy, dz);
    // rust: let neighbor = world.fluid(p)?;
    // rust: if !affects_flow(state.kind(), neighbor) {
    // rust: continue;
}
    // rust: let mut height = neighbor.own_height();
    // rust: let mut difference = 0.0f32;
    // rust: if height == 0.0 {
    // rust: let block = world.block(p)?;
    // rust: if !world.blocks_fluid_flow(block) {
    // rust: let below = world.fluid(p.offset(0, -1, 0))?;
    // rust: if affects_flow(state.kind(), below) {
    // rust: height = below.own_height();
    // rust: if height > 0.0 {
    // rust: difference = state.own_height() - (height - 0.8888889f32);
}
}
}
    // rust: } else if height > 0.0 {
    // rust: difference = state.own_height() - height;
}
    // rust: if difference != 0.0 {
    // rust: x += f64::from(dx as f32 * difference);
    // rust: z += f64::from(dz as f32 * difference);
}
}
    // rust: let mut result = Vec3::new(x, 0.0, z);
    // rust: if state.falling() {
    // rust: for direction in HORIZONTAL {
    // rust: let [dx, dy, dz] = direction.normal();
    // rust: let p = position.offset(dx, dy, dz);
    // rust: if solid_face(world, state.kind(), p, direction)?
    // rust: || solid_face(world, state.kind(), p.offset(0, 1, 0), direction)?
    // rust: {
    // rust: result = result.normalize().add_vector(Vec3::new(0.0, -6.0, 0.0));
    // rust: break;
}
}
}
    // rust: Ok(result.normalize())
}
