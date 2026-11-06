//! Transpiled from Horizon Rust crate
//! Module: horizon-world_registry_fluid
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Registered fluid contents, flow tags and native block support composition.
// use crate::{
    // rust: block_support::{BlockSupportRegistry, SupportQueryError, SupportType},
    // rust: compression::invalid,
    // rust: dynamic_support::DynamicSupportWorld,
    // rust: fluid::{FluidHeightWorld, FluidState},
    // rust: fluid_flow::FluidFlowWorld,
    // rust: registry::{BlockRegistry, BlockStateId},
}
// use horizon_core::{geometry::Direction, position::BlockPos};
// use std::{collections::BTreeSet, fmt, io};
pub const FluidBlock = struct {
    id: BlockStateId,
    fluid: FluidState,
    blocks_flow: bool,
    ice: bool,
};
pub const FluidRegistry = struct {
    registry: *'r BlockRegistry,
    states: std.ArrayList(FluidBlock),
};
    // rust: impl<'r> FluidRegistry<'r> {
    /// Rebuild on BLOCKS_FLUID_FLOW tag reload. Ice names come from actual class
    /// membership; name suffixes do not distinguish ice from packed/blue ice.
    // rust: pub fn new(
    // rust: registry: &'r BlockRegistry,
    // rust: blocks_flow: &BTreeSet<String>,
    // rust: ice: &BTreeSet<String>,
    // rust: ) -> io::Result<Self> {
    // rust: for names in [blocks_flow, ice] {
    // rust: if names.iter().any(|n| registry.default_state(n).is_none()) {
    // rust: return Err(invalid("unknown fluid block member"));
}
}
    // rust: let states = (0..registry.len())
    // rust: .map(|i| {
    // rust: let id = BlockStateId(i as u32);
    // rust: let s = registry.state(id).unwrap();
    // rust: Ok(FluidBlock {
    // rust: id,
    // rust: fluid: FluidState::from_block(s)?,
    // rust: blocks_flow: blocks_flow.contains(&s.name),
    // rust: ice: ice.contains(&s.name),
    // rust: })
    // rust: })
    // rust: .collect::<io::Result<Vec<_>>>()?;
    // rust: Ok(Self { registry, states })
}
pub fn registry(self: *Self) * {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.registry
}
pub fn state(self: *Self, id: BlockStateId) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.states
    // rust: .get(id.0 as usize)
    // rust: .copied()
    // rust: .ok_or_else(|| invalid("fluid block state outside registry"))
}
pub fn fluid(self: *Self, id: BlockStateId) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.state(id)?.fluid)
}
pub fn blocks_flow(self: *Self, id: BlockStateId) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Ok(self.state(id)?.blocks_flow)
}
}
/// Both queries return state IDs from the same registry. Separate entry points
/// preserve native world dispatch when reading a block versus its fluid cell.
    // rust: pub trait FluidBlockWorld: DynamicSupportWorld {
pub fn block_state(self: *Self, position: BlockPos) R;
pub fn fluid_block_state(self: *Self, position: BlockPos) R;
}
pub const FluidQueryError = enum {
    World(E),
    Data(io::Error),
    Support(SupportQueryError<E>),
};
    // rust: impl<E: fmt::Display> fmt::Display for FluidQueryError<E> {
pub fn fmt(self: *Self, f: *mut fmt::Formatter<'_>) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::World(e) => e.fmt(f),
    // rust: Self::Data(e) => e.fmt(f),
    // rust: Self::Support(e) => e.fmt(f),
}
}
}
    // rust: impl<E: std::error::Error + 'static> std::error::Error for FluidQueryError<E> {}
pub const RegistryFluidWorld = struct {
    registry: *'a FluidRegistry<'r>,
    support: *'a BlockSupportRegistry<'r>,
    world: *'a mut W,
};
    // rust: impl<'a, 'r, W> RegistryFluidWorld<'a, 'r, W> {
    // rust: pub fn new(
    // rust: registry: &'a FluidRegistry<'r>,
    // rust: support: &'a BlockSupportRegistry<'r>,
    // rust: world: &'a mut W,
    // rust: ) -> io::Result<Self> {
    // rust: if !std::ptr::eq(registry.registry(), support.registry()) {
    // rust: return Err(invalid("fluid and support registry identities differ"));
}
    // rust: Ok(Self {
    // rust: registry,
    // rust: support,
    // rust: world,
    // rust: })
}
}
    // rust: impl<W: FluidBlockWorld> FluidFlowWorld for RegistryFluidWorld<'_, '_, W> {
    // rust: type Error = FluidQueryError<W::Error>;
    // rust: type Block = FluidBlock;
pub fn fluid(self: *Self, p: BlockPos) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let id = self
    // rust: .world
    // rust: .fluid_block_state(p)
    // rust: .map_err(FluidQueryError::World)?;
    // rust: self.registry.fluid(id).map_err(FluidQueryError::Data)
}
pub fn block(self: *Self, p: BlockPos) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let id = self.world.block_state(p).map_err(FluidQueryError::World)?;
    // rust: self.registry.state(id).map_err(FluidQueryError::Data)
}
pub fn blocks_fluid_flow(self: *Self, s: FluidBlock) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: s.blocks_flow
}
pub fn is_ice_class(self: *Self, s: FluidBlock) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: s.ice
}
    // rust: fn is_face_sturdy(
    // rust: &mut self,
    // rust: s: FluidBlock,
    // rust: p: BlockPos,
    // rust: d: Direction,
    // rust: ) -> Result<bool, Self::Error> {
    // rust: self.support
    // rust: .is_face_sturdy(self.world, s.id, [p.x, p.y, p.z], d, SupportType::Full)
    // rust: .map_err(FluidQueryError::Support)
}
}
    // rust: impl<W: FluidBlockWorld> FluidHeightWorld for RegistryFluidWorld<'_, '_, W> {
    // rust: type Error = FluidQueryError<W::Error>;
pub fn fluid(self: *Self, p: [i32; 3]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: FluidFlowWorld::fluid(self, BlockPos::new(p[0], p[1], p[2]))
}
pub fn sturdy_down(self: *Self, p: [i32; 3]) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let p = BlockPos::new(p[0], p[1], p[2]);
    // rust: let s = FluidFlowWorld::block(self, p)?;
    // rust: self.is_face_sturdy(s, p, Direction::Down)
}
}

// use crate::entity_fluid::{FluidInteractionWorld, FluidMembership, FluidSections, FluidTagId};
// use horizon_core::geometry::{Aabb, Vec3};
/// Entity fields and loaded chunk views needed by the registered immersion scan.
/// Cell height/current behavior comes from this module's registry/support binding.
    // rust: pub trait FluidEntityWorld: FluidBlockWorld + FluidMembership {
    // rust: type Chunk: Copy;
pub fn interaction_box(self: *Self) R;
pub fn loaded_chunk(self: *Self, x: i32, z: i32) R;
pub fn chunk_sections(self: *Self, chunk: Self::Chunk) R;
pub fn bounding_box_min_y(self: *Self) f;
pub fn block_x(self: *Self) i;
pub fn eye_y(self: *Self) R;
pub fn block_z(self: *Self) i;
}
    // rust: impl<W: FluidMembership> FluidMembership for RegistryFluidWorld<'_, '_, W> {
pub fn fluid_in_tag(self: *Self, fluid: crate::fluid::FluidKind, tag: FluidTagId) b {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.world.fluid_in_tag(fluid, tag)
}
}
    // rust: impl<W: FluidEntityWorld> FluidInteractionWorld for RegistryFluidWorld<'_, '_, W> {
    // rust: type Error = FluidQueryError<W::Error>;
    // rust: type Chunk = W::Chunk;
pub fn interaction_box(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.world.interaction_box().map_err(FluidQueryError::World)
}
pub fn loaded_chunk(self: *Self, x: i32, z: i32) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.world
    // rust: .loaded_chunk(x, z)
    // rust: .map_err(FluidQueryError::World)
}
pub fn chunk_sections(self: *Self, c: Self::Chunk) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.world.chunk_sections(c).map_err(FluidQueryError::World)
}
pub fn bounding_box_min_y(self: *Self) f {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.world.bounding_box_min_y()
}
pub fn block_x(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.world.block_x()
}
pub fn eye_y(self: *Self) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.world.eye_y().map_err(FluidQueryError::World)
}
pub fn block_z(self: *Self) i {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: self.world.block_z()
}
pub fn fluid_state(self: *Self, p: BlockPos) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: FluidFlowWorld::fluid(self, p)
}
pub fn fluid_height(self: *Self, s: FluidState, p: BlockPos) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: s.height_at(self, [p.x, p.y, p.z])
}
pub fn camera_height(self: *Self, s: FluidState, p: BlockPos) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: s.camera_height_at(self, [p.x, p.y, p.z])
}
pub fn flow(self: *Self, s: FluidState, p: BlockPos) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: crate::fluid_flow::flow_at(self, s, p)
}
}
