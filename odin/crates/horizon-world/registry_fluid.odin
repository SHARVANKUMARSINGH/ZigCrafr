//! Transpiled from Horizon Rust crate
package horizon_world_registry_fluid

import "core:fmt"
import "core:mem"
import "core:math"

// Registered fluid contents, flow tags and native block support composition.
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
FluidBlock :: struct {
    id: BlockStateId,
    fluid: FluidState,
    blocks_flow: bool,
    ice: bool,
}
FluidRegistry :: struct {
    registry: ^'r BlockRegistry,
    states: [dynamic]FluidBlock,
}
    // rust: impl<'r> FluidRegistry<'r> {
    // Rebuild on BLOCKS_FLUID_FLOW tag reload. Ice names come from actual class
    // membership; name suffixes do not distinguish ice from packed/blue ice.
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
registry :: proc(self: ^Self) -> ^ {
    // Ported from Horizon
    return {}
}
    // rust: self.registry
}
state :: proc(self: ^Self, id: BlockStateId) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.states
    // rust: .get(id.0 as usize)
    // rust: .copied()
    // rust: .ok_or_else(|| invalid("fluid block state outside registry"))
}
fluid :: proc(self: ^Self, id: BlockStateId) -> i {
    // Ported from Horizon
    return {}
}
    // rust: Ok(self.state(id)?.fluid)
}
blocks_flow :: proc(self: ^Self, id: BlockStateId) -> i {
    // Ported from Horizon
    return {}
}
    // rust: Ok(self.state(id)?.blocks_flow)
}
}
// Both queries return state IDs from the same registry. Separate entry points
// preserve native world dispatch when reading a block versus its fluid cell.
    // rust: pub trait FluidBlockWorld: DynamicSupportWorld {
block_state :: proc(self: ^Self, position: BlockPos) -> R {
    // Ported from Horizon
    return {}
}
fluid_block_state :: proc(self: ^Self, position: BlockPos) -> R {
    // Ported from Horizon
    return {}
}
}
FluidQueryError :: enum {
    World(E),
    Data(io::Error),
    Support(SupportQueryError<E>),
}
    // rust: impl<E: fmt::Display> fmt::Display for FluidQueryError<E> {
fmt :: proc(self: ^Self, f: ^fmt::Formatter<'_>) -> f {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::World(e) => e.fmt(f),
    // rust: Self::Data(e) => e.fmt(f),
    // rust: Self::Support(e) => e.fmt(f),
}
}
}
    // rust: impl<E: std::error::Error + 'static> std::error::Error for FluidQueryError<E> {}
RegistryFluidWorld :: struct {
    registry: ^'a FluidRegistry<'r>,
    support: ^'a BlockSupportRegistry<'r>,
    world: ^'a mut W,
}
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
fluid :: proc(self: ^Self, p: BlockPos) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let id = self
    // rust: .world
    // rust: .fluid_block_state(p)
    // rust: .map_err(FluidQueryError::World)?;
    // rust: self.registry.fluid(id).map_err(FluidQueryError::Data)
}
block :: proc(self: ^Self, p: BlockPos) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let id = self.world.block_state(p).map_err(FluidQueryError::World)?;
    // rust: self.registry.state(id).map_err(FluidQueryError::Data)
}
blocks_fluid_flow :: proc(self: ^Self, s: FluidBlock) -> b {
    // Ported from Horizon
    return {}
}
    // rust: s.blocks_flow
}
is_ice_class :: proc(self: ^Self, s: FluidBlock) -> b {
    // Ported from Horizon
    return {}
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
fluid :: proc(self: ^Self, p: [i32; 3]) -> R {
    // Ported from Horizon
    return {}
}
    // rust: FluidFlowWorld::fluid(self, BlockPos::new(p[0], p[1], p[2]))
}
sturdy_down :: proc(self: ^Self, p: [i32; 3]) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let p = BlockPos::new(p[0], p[1], p[2]);
    // rust: let s = FluidFlowWorld::block(self, p)?;
    // rust: self.is_face_sturdy(s, p, Direction::Down)
}
}

// use crate::entity_fluid::{FluidInteractionWorld, FluidMembership, FluidSections, FluidTagId};
// use horizon_core::geometry::{Aabb, Vec3};
// Entity fields and loaded chunk views needed by the registered immersion scan.
// Cell height/current behavior comes from this module's registry/support binding.
    // rust: pub trait FluidEntityWorld: FluidBlockWorld + FluidMembership {
    // rust: type Chunk: Copy;
interaction_box :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
loaded_chunk :: proc(self: ^Self, x: i32, z: i32) -> R {
    // Ported from Horizon
    return {}
}
chunk_sections :: proc(self: ^Self, chunk: Self::Chunk) -> R {
    // Ported from Horizon
    return {}
}
bounding_box_min_y :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
block_x :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
eye_y :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
block_z :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
}
    // rust: impl<W: FluidMembership> FluidMembership for RegistryFluidWorld<'_, '_, W> {
fluid_in_tag :: proc(self: ^Self, fluid: crate::fluid::FluidKind, tag: FluidTagId) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.world.fluid_in_tag(fluid, tag)
}
}
    // rust: impl<W: FluidEntityWorld> FluidInteractionWorld for RegistryFluidWorld<'_, '_, W> {
    // rust: type Error = FluidQueryError<W::Error>;
    // rust: type Chunk = W::Chunk;
interaction_box :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.world.interaction_box().map_err(FluidQueryError::World)
}
loaded_chunk :: proc(self: ^Self, x: i32, z: i32) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.world
    // rust: .loaded_chunk(x, z)
    // rust: .map_err(FluidQueryError::World)
}
chunk_sections :: proc(self: ^Self, c: Self::Chunk) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.world.chunk_sections(c).map_err(FluidQueryError::World)
}
bounding_box_min_y :: proc(self: ^Self) -> f {
    // Ported from Horizon
    return {}
}
    // rust: self.world.bounding_box_min_y()
}
block_x :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.world.block_x()
}
eye_y :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.world.eye_y().map_err(FluidQueryError::World)
}
block_z :: proc(self: ^Self) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.world.block_z()
}
fluid_state :: proc(self: ^Self, p: BlockPos) -> R {
    // Ported from Horizon
    return {}
}
    // rust: FluidFlowWorld::fluid(self, p)
}
fluid_height :: proc(self: ^Self, s: FluidState, p: BlockPos) -> R {
    // Ported from Horizon
    return {}
}
    // rust: s.height_at(self, [p.x, p.y, p.z])
}
camera_height :: proc(self: ^Self, s: FluidState, p: BlockPos) -> R {
    // Ported from Horizon
    return {}
}
    // rust: s.camera_height_at(self, [p.x, p.y, p.z])
}
flow :: proc(self: ^Self, s: FluidState, p: BlockPos) -> R {
    // Ported from Horizon
    return {}
}
    // rust: crate::fluid_flow::flow_at(self, s, p)
}
}
