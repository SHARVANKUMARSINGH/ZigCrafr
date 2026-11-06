//! Transpiled from Horizon Rust crate
package horizon_world_piston_shape

import "core:fmt"
import "core:mem"
import "core:math"

// Moving-piston collision selection and interpolation over immutable state IDs.
// Tick progression, entity pushing and world mutation belong to the world loop.
// use crate::{
    // rust: compression::invalid,
    // rust: registry::{BlockRegistry, BlockStateId},
}
// use horizon_core::geometry::{Direction, ShapeError, ShapeOp, Vec3, VoxelShape};
// use std::{collections::BTreeMap, io};
MovingPistonState :: struct {
    moved_state: BlockStateId,
    direction: Direction,
    extending: bool,
    source: bool,
    progress: f32,
    previous_progress: f32,
}
    // rust: impl MovingPistonState {
movement_direction :: proc(self: ^Self) -> D {
    // Ported from Horizon
    return {}
}
    // rust: if self.extending {
    // rust: self.direction
    // rust: } else {
    // rust: self.direction.opposite()
}
}
interpolated_progress :: proc(self: ^Self, partial: f32) -> f {
    // Ported from Horizon
    return {}
}
    // rust: let partial = if partial > 1.0 { 1.0 } else { partial };
    // rust: self.previous_progress + partial * (self.progress - self.previous_progress)
}
interpolated_offset :: proc(self: ^Self, partial: f32) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: self.offset(self.interpolated_progress(partial))
}
offset :: proc(self: ^Self, progress: f32) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: let extended = if self.extending {
    // rust: progress - 1.0
    // rust: } else {
    // rust: 1.0 - progress
}
    // rust: self.direction.normal().map(|step| step as f32 * extended)
}
}
    // rust: pub trait PistonCollisionWorld {
    // rust: type Error;
    // The no-entity-context BlockState collision query at the supplied position.
    // rust: fn collision_shape(
    // rust: &mut self,
    // rust: state: BlockStateId,
    // rust: position: [i32; 3],
    // rust: ) -> Result<VoxelShape, Self::Error>;
}
PistonShapeError :: enum {
    World(E),
    Shape(ShapeError),
    Registry(io::Error),
}
    // rust: impl<E: std::fmt::Display> std::fmt::Display for PistonShapeError<E> {
fmt :: proc(self: ^Self, f: ^std::fmt::Formatter<'_>) -> s {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::World(e) => e.fmt(f),
    // rust: Self::Shape(e) => e.fmt(f),
    // rust: Self::Registry(e) => e.fmt(f),
}
}
}
    // rust: impl<E: std::error::Error + 'static> std::error::Error for PistonShapeError<E> {}
Base :: struct {
    extended: BlockStateId,
    facing: Direction,
    sticky: bool,
}
PistonBlockBindings :: struct {
    registry: ^'r BlockRegistry,
    bases: BTreeMap<BlockStateId,
    heads: [[[BlockStateId,
}
DIRECTION_NAMES :: ["down", "up", "north", "south", "west", "east"]
    // rust: impl<'r> PistonBlockBindings<'r> {
new :: proc(registry: ^'r BlockRegistry) -> i {
    // Ported from Horizon
    return {}
}
    // rust: let mut bases = BTreeMap::new();
    // rust: for id in 0..registry.len() {
    // rust: let id = BlockStateId(id as u32);
    // rust: let state = registry.state(id).unwrap();
    // rust: if !matches!(
    // rust: state.name.as_str(),
    // rust: "minecraft:piston" | "minecraft:sticky_piston"
    // rust: ) {
    // rust: continue;
}
    // rust: let facing = state
    // rust: .properties
    // rust: .get("facing")
    // rust: .and_then(|name| DIRECTION_NAMES.iter().position(|v| v == name))
    // rust: .ok_or_else(|| invalid("invalid piston facing"))?;
    // rust: let mut extended = state.clone();
    // rust: extended.properties.insert("extended".into(), "true".into());
    // rust: bases.insert(
    // rust: id,
    // rust: Base {
    // rust: extended: registry
    // rust: .id(&extended)
    // rust: .ok_or_else(|| invalid("missing extended piston state"))?,
    // rust: facing: Direction::ALL[facing],
    // rust: sticky: state.name == "minecraft:sticky_piston",
    // rust: },
    // rust: );
}
    // rust: let default = registry
    // rust: .default_state("minecraft:piston_head")
    // rust: .and_then(|id| registry.state(id))
    // rust: .ok_or_else(|| invalid("missing piston head"))?;
    // rust: let mut heads = [[[BlockStateId(0); 2]; 6]; 2];
    // rust: for (kind, type_heads) in heads.iter_mut().enumerate() {
    // rust: for (direction, variants) in type_heads.iter_mut().enumerate() {
    // rust: for (short, id) in variants.iter_mut().enumerate() {
    // rust: let mut state = default.clone();
    // rust: state.properties.insert(
    // rust: "type".into(),
    // rust: if kind == 0 { "normal" } else { "sticky" }.into(),
    // rust: );
    // rust: state
    // rust: .properties
    // rust: .insert("facing".into(), DIRECTION_NAMES[direction].into());
    // rust: state
    // rust: .properties
    // rust: .insert("short".into(), (short != 0).to_string());
    // rust: *id = registry
    // rust: .id(&state)
    // rust: .ok_or_else(|| invalid("missing piston head variant"))?;
}
}
}
    // rust: Ok(Self {
    // rust: registry,
    // rust: bases,
    // rust: heads,
    // rust: })
}
validate :: proc(self: ^Self, state: BlockStateId) -> i {
    // Ported from Horizon
    return {}
}
    // rust: if self.registry.state(state).is_none() {
    // rust: Err(invalid("piston moved state outside registry"))
    // rust: } else {
    // rust: Ok(())
}
}
    // The collision-related state used by the native entity-pushing path.
    // Its sticky/short/facing rules differ from the entity's own collision head.
collision_related_state :: proc(self: ^Self, piston: MovingPistonState) -> i {
    // Ported from Horizon
    return {}
}
    // rust: self.validate(piston.moved_state)?;
    // rust: if !piston.extending && piston.source {
    // rust: if let Some(base) = self.bases.get(&piston.moved_state) {
    // rust: return Ok(self.heads[usize::from(base.sticky)][base.facing as usize]
    // rust: [usize::from(piston.progress > 0.25)]);
}
}
    // rust: Ok(piston.moved_state)
}
    // rust: pub fn collision_shape<W: PistonCollisionWorld>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: position: [i32; 3],
    // rust: piston: MovingPistonState,
    // rust: noclip: Option<Direction>,
    // rust: ) -> Result<VoxelShape, PistonShapeError<W::Error>> {
    // rust: self.validate(piston.moved_state)
    // rust: .map_err(PistonShapeError::Registry)?;
    // rust: let base = if !piston.extending && piston.source {
    // rust: if let Some(base) = self.bases.get(&piston.moved_state) {
    // rust: world
    // rust: .collision_shape(base.extended, position)
    // rust: .map_err(PistonShapeError::World)?
    // rust: } else {
    // rust: VoxelShape::empty()
}
    // rust: } else {
    // rust: VoxelShape::empty()
}
        // The stationary base is queried before this native noclip shortcut.
    // rust: if piston.progress < 1.0 && noclip == Some(piston.movement_direction()) {
    // rust: return Ok(base);
}
    // rust: let state = if piston.source {
    // rust: let short = piston.extending != (1.0f32 - piston.progress < 0.25f32);
    // rust: self.heads[0][piston.direction as usize][usize::from(short)]
    // rust: } else {
    // rust: piston.moved_state
}
    // rust: let offset = piston.offset(piston.progress).map(f64::from);
    // rust: let moving = world
    // rust: .collision_shape(state, position)
    // rust: .map_err(PistonShapeError::World)?
    // rust: .moved(Vec3::new(offset[0], offset[1], offset[2]));
    // rust: base.join(&moving, ShapeOp::OR)
    // rust: .map_err(PistonShapeError::Shape)
}
}
