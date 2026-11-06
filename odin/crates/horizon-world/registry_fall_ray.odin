//! Transpiled from Horizon Rust crate
package horizon_world_registry_fall_ray

import "core:fmt"
import "core:mem"
import "core:math"

// Fall-reset rays bound to registered interactions, fluid states and live queries.
// use crate::{
    // rust: compression::invalid,
    // rust: entity_obstruction::EntityIdentity,
    // rust: fluid::{FluidHeightWorld, FluidKind, FluidState},
    // rust: fluid_shape::FluidShapeCache,
    // rust: interaction_shapes::InteractionShapes,
    // rust: registry::BlockStateId,
    // rust: world_ray::{
    // rust: self, FallResetWorld, RayBlockMode, RayError, RayFluidMode, RayResult, RayWorld,
    // rust: ResetPortal,
    // rust: },
}
// use horizon_core::{
    // rust: geometry::{Vec3, VoxelShape},
    // rust: position::BlockPos,
}
// use std::{collections::BTreeSet, fmt, io};
State :: struct {
    reset: bool,
    portal: Maybe(ResetPortal),
    fluid: FluidState,
}
FallRayRegistry :: struct {
    interactions: ^'s InteractionShapes<'r>,
    states: [dynamic]State,
    water_mask: u8,
}
    // rust: impl<'s, 'r> FallRayRegistry<'s, 'r> {
    // Tags are resolved snapshots; build a new binding after a tag reload.
    // rust: pub fn new(
    // rust: interactions: &'s InteractionShapes<'r>,
    // rust: reset_blocks: &BTreeSet<String>,
    // rust: water_fluids: &BTreeSet<String>,
    // rust: ) -> io::Result<Self> {
    // rust: let registry = interactions.registry();
    // rust: if reset_blocks
    // rust: .iter()
    // rust: .any(|name| registry.default_state(name).is_none())
    // rust: {
    // rust: return Err(invalid("unknown fall-reset block tag member"));
}
    // rust: let mut water_mask = 0;
    // rust: for name in water_fluids {
    // rust: water_mask |= FluidKind::from_name(name)
    // rust: .ok_or_else(|| invalid("unknown water fluid tag member"))?
    // rust: .mask();
}
    // rust: let mut states = Vec::with_capacity(registry.len());
    // rust: for i in 0..registry.len() {
    // rust: let state = registry.state(BlockStateId(i as u32)).unwrap();
    // rust: states.push(State {
    // rust: reset: reset_blocks.contains(&state.name),
    // rust: portal: match state.name.as_str() {
    // rust: "minecraft:end_gateway" => Some(ResetPortal::EndGateway),
    // rust: "minecraft:end_portal" => Some(ResetPortal::EndPortal),
    // rust: "minecraft:nether_portal" => Some(ResetPortal::NetherPortal),
    // rust: _ => None,
    // rust: },
    // rust: fluid: FluidState::from_block(state)?,
    // rust: });
}
    // rust: Ok(Self {
    // rust: interactions,
    // rust: states,
    // rust: water_mask,
    // rust: })
}
state :: proc(self: ^Self, id: BlockStateId) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.states
    // rust: .get(id.0 as usize)
    // rust: .copied()
    // rust: .ok_or_else(|| invalid("ray block state outside registry"))
}
fluid_for_block :: proc(self: ^Self, id: BlockStateId) -> i {
    // Ported from Horizon
    return {}
}
    // rust: Ok(self.state(id)?.fluid)
}
}
    // rust: pub trait FallRayWorld {
    // rust: type Error;
block_state :: proc(self: ^Self, p: BlockPos) -> R {
    // Ported from Horizon
    return {}
}
fluid_state :: proc(self: ^Self, p: BlockPos) -> R {
    // Ported from Horizon
    return {}
}
is_server_level :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
entity_is_player :: proc(self: ^Self, e: EntityIdentity) -> R {
    // Ported from Horizon
    return {}
}
players_nether_portal_delay :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
}
FallRayError :: enum {
    Data(io::Error),
    World(E),
}
    // rust: impl<E: fmt::Display> fmt::Display for FallRayError<E> {
fmt :: proc(self: ^Self, f: ^fmt::Formatter<'_>) -> f {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::Data(e) => e.fmt(f),
    // rust: Self::World(e) => e.fmt(f),
}
}
}
    // rust: impl<E: std::error::Error + 'static> std::error::Error for FallRayError<E> {}
Bound :: struct {
    registry: ^'a FallRayRegistry<'s,
    cache: ^'a mut FluidShapeCache,
    entity: Maybe(EntityIdentity),
    world: ^'a mut W,
}
    // rust: impl<W: FallRayWorld> FallResetWorld for Bound<'_, '_, '_, W> {
    // rust: type Error = FallRayError<W::Error>;
    // rust: type Block = BlockStateId;
fall_reset_tag :: proc(self: ^Self, s: BlockStateId) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(self.registry.state(s).map_err(FallRayError::Data)?.reset)
}
entity_is_player :: proc(self: ^Self, e: EntityIdentity) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.world.entity_is_player(e).map_err(FallRayError::World)
}
is_portal :: proc(self: ^Self, s: BlockStateId, p: ResetPortal) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(self.registry.state(s).map_err(FallRayError::Data)?.portal == Some(p))
}
is_server_level :: proc(self: ^Self) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.world.is_server_level()
}
players_nether_portal_delay :: proc(self: ^Self) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.world
    // rust: .players_nether_portal_delay()
    // rust: .map_err(FallRayError::World)
}
}
Height :: struct {
    // rust: impl<W: FallRayWorld> FluidHeightWorld for Height<'_, W> {
    // rust: type Error = FallRayError<W::Error>;
fluid :: proc(self: ^Self, p: [i32; 3]) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.0
    // rust: .fluid_state(BlockPos::new(p[0], p[1], p[2]))
    // rust: .map_err(FallRayError::World)
}
sturdy_down :: proc(self: ^Self, _: [i32; 3]) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Err(FallRayError::Data(invalid(
    // rust: "camera support is outside a fluid shape query",
    // rust: )))
}
}
    // rust: impl<W: FallRayWorld> RayWorld for Bound<'_, '_, '_, W> {
    // rust: type Error = FallRayError<W::Error>;
    // rust: type Block = BlockStateId;
    // rust: type Fluid = FluidState;
block_state :: proc(self: ^Self, p: BlockPos) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let state = self.world.block_state(p).map_err(FallRayError::World)?;
    // rust: self.registry.state(state).map_err(FallRayError::Data)?;
    // rust: Ok(state)
}
fluid_state :: proc(self: ^Self, p: BlockPos) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.world.fluid_state(p).map_err(FallRayError::World)
}
    // rust: fn block_shape(
    // rust: &mut self,
    // rust: s: BlockStateId,
    // rust: _: BlockPos,
    // rust: mode: RayBlockMode,
    // rust: ) -> Result<VoxelShape, Self::Error> {
    // rust: if mode != RayBlockMode::FallDamageResetting {
    // rust: return Err(FallRayError::Data(invalid("fall ray block mode mismatch")));
}
    // rust: let entity = self.entity;
    // rust: world_ray::fall_reset_shape(self, s, entity)
}
    // rust: fn interaction_shape(
    // rust: &mut self,
    // rust: s: BlockStateId,
    // rust: _: BlockPos,
    // rust: ) -> Result<VoxelShape, Self::Error> {
    // rust: Ok(self
    // rust: .registry
    // rust: .interactions
    // rust: .shape(s)
    // rust: .map_err(FallRayError::Data)?
    // rust: .clone())
}
fluid_is_source :: proc(self: ^Self, s: FluidState) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(s.is_source())
}
fluid_is_empty :: proc(self: ^Self, s: FluidState) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(s.kind() == FluidKind::Empty)
}
fluid_is_water :: proc(self: ^Self, s: FluidState) -> R {
    // Ported from Horizon
    return {}
}
    // rust: Ok(self.registry.water_mask & s.kind().mask() != 0)
}
fluid_shape :: proc(self: ^Self, s: FluidState, p: BlockPos) -> R {
    // Ported from Horizon
    return {}
}
    // rust: self.cache.shape(&mut Height(self.world), s, p)
}
}
// `entity` represents the optional entity in a native EntityCollisionContext.
// Keep the cache shared across calls to preserve native first-query behavior.
    // rust: pub fn fall_reset_ray<W: FallRayWorld>(
    // rust: world: &mut W,
    // rust: registry: &FallRayRegistry<'_, '_>,
    // rust: cache: &mut FluidShapeCache,
    // rust: entity: Option<EntityIdentity>,
    // rust: from: Vec3,
    // rust: to: Vec3,
    // rust: max_visits: usize,
    // rust: ) -> Result<RayResult, RayError<FallRayError<W::Error>>> {
    // rust: world_ray::clip_world(
    // rust: &mut Bound {
    // rust: world,
    // rust: registry,
    // rust: cache,
    // rust: entity,
    // rust: },
    // rust: from,
    // rust: to,
    // rust: RayBlockMode::FallDamageResetting,
    // rust: RayFluidMode::Water,
    // rust: max_visits,
    // rust: )
}
