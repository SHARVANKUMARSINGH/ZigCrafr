//! Transpiled from Horizon Rust crate
package horizon_world_speleothem

import "core:fmt"
import "core:mem"
import "core:math"

// Small pointed formations, base patches and contained-water placement.
// use super::{
    // rust: DecodeError, Object,
    // rust: block_feature::FeatureBlockBindings,
    // rust: block_predicate::PredicateBlockResolver,
    // rust: feature::FeatureWorld,
    // rust: number_text, optional,
    // rust: placement::{PlacementContext, PlacementQueryError},
    // rust: required,
}
// use crate::registry::BlockStateId;
// use horizon_core::{
    // rust: geometry::Direction,
    // rust: random::{InvalidBound, RandomSource},
}
// use std::{collections::BTreeSet, sync::Arc};
SpeleothemFeature :: struct {
    base: BlockStateId,
    base_states: ^BTreeSet<BlockStateId>,
    replace: ^BTreeSet<BlockStateId>,
    empty_or_water: BTreeSet<BlockStateId>,
    // Direction (up/down), thickness (tip/frustum), waterlogged. Unsupported
    // properties remain deferred placement failures, as in the native codec.
    pointed: [[Maybe([Option<BlockStateId),
    chances: [f32,
}
SpeleothemError :: enum {
    World(E),
    Query(PlacementQueryError),
    Random(InvalidBound),
    InvalidPointedState,
}
    // rust: impl<E: std::fmt::Display> std::fmt::Display for SpeleothemError<E> {
fmt :: proc(self: ^Self, f: ^std::fmt::Formatter<'_>) -> s {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::World(e) => e.fmt(f),
    // rust: Self::Query(e) => e.fmt(f),
    // rust: Self::Random(e) => e.fmt(f),
    // rust: Self::InvalidPointedState => f.write_str("pointed block lacks required properties"),
}
}
}
    // rust: impl<E: std::error::Error + 'static> std::error::Error for SpeleothemError<E> {}
    // rust: impl SpeleothemFeature {
from_json :: proc(json: string, bindings: ^FeatureBlockBindings<'_>) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let object: Object = serde_json::from_str(json)?;
    // rust: let registry = bindings.registry();
    // rust: let block = |field| -> Result<BlockStateId, DecodeError> {
    // rust: let state = bindings
    // rust: .codec
    // rust: .decode(required(&object, field)?.get(), false)
    // rust: .map_err(|e| DecodeError::Registry(e.to_string()))?;
    // rust: registry
    // rust: .default_state(&registry.state(state).unwrap().name)
    // rust: .ok_or(DecodeError::Field("speleothem block identity"))
}
    // rust: let base = block("base_block")?;
    // rust: let point = registry.state(block("pointed_block")?).unwrap();
    // rust: let mut pointed = [[None; 2]; 2];
    // rust: for (direction, row) in ["up", "down"].into_iter().zip(&mut pointed) {
    // rust: for (thickness, entry) in ["tip", "frustum"].into_iter().zip(row) {
    // rust: let mut state = point.clone();
    // rust: state
    // rust: .properties
    // rust: .insert("vertical_direction".into(), direction.into());
    // rust: state
    // rust: .properties
    // rust: .insert("thickness".into(), thickness.into());
    // rust: if registry.id(&state).is_some() {
    // rust: *entry = Some([false, true].map(|water| {
    // rust: let mut wet = state.clone();
    // rust: wet.properties
    // rust: .insert("waterlogged".into(), water.to_string());
    // rust: registry.id(&wet)
    // rust: }));
}
}
}
    // rust: let mut chances = [0.2, 0.7, 0.5, 0.5];
    // rust: for (name, chance) in [
    // rust: "chance_of_taller_generation",
    // rust: "chance_of_directional_spread",
    // rust: "chance_of_spread_radius2",
    // rust: "chance_of_spread_radius3",
    // rust: ]
    // rust: .into_iter()
    // rust: .zip(&mut chances)
    // rust: {
    // rust: if let Some(raw) = optional(&object, name) {
    // rust: *chance = number_text(raw)?
    // rust: .parse::<f64>()
    // rust: .map_err(|_| DecodeError::Field("speleothem chance"))?
    // rust: as f32;
    // rust: if !(0.0..=1.0).contains(chance) || chance.is_sign_negative() {
    // rust: return Err(DecodeError::Field("speleothem chance"));
}
}
}
    // rust: let mut empty_or_water = BTreeSet::from(bindings.air);
    // rust: empty_or_water.extend(
    // rust: bindings
    // rust: .blocks
    // rust: .get("minecraft:water")
    // rust: .ok_or(DecodeError::Field("water bindings"))?
    // rust: .iter()
    // rust: .copied(),
    // rust: );
    // rust: Ok(Self {
    // rust: base,
    // rust: base_states: bindings.blocks[&registry.state(base).unwrap().name].clone(),
    // rust: replace: bindings
    // rust: .predicate_block_set(required(&object, "replaceable_blocks")?.get())?,
    // rust: empty_or_water,
    // rust: pointed,
    // rust: chances,
    // rust: })
}
is_base :: proc(self: ^Self, state: BlockStateId) -> b {
    // Ported from Horizon
    return {}
}
    // rust: self.base_states.contains(&state) || self.replace.contains(&state)
}
    // rust: fn base_at<W: FeatureWorld>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: p: [i32; 3],
    // rust: ) -> Result<(), SpeleothemError<W::Error>> {
    // rust: if self
    // rust: .replace
    // rust: .contains(&world.block(p).map_err(SpeleothemError::World)?)
    // rust: {
    // rust: world
    // rust: .set_block(p, self.base, 2)
    // rust: .map_err(SpeleothemError::World)?;
}
    // rust: Ok(())
}
    // rust: pub fn place<W: FeatureWorld + PlacementContext>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: random: &mut impl RandomSource,
    // rust: origin: [i32; 3],
    // rust: ) -> Result<bool, SpeleothemError<W::Error>> {
    // rust: let ceiling = self.is_base(
    // rust: world
    // rust: .block(offset(origin, [0, 1, 0]))
    // rust: .map_err(SpeleothemError::World)?,
    // rust: );
    // rust: let floor = self.is_base(
    // rust: world
    // rust: .block(offset(origin, [0, -1, 0]))
    // rust: .map_err(SpeleothemError::World)?,
    // rust: );
    // rust: let direction = match (ceiling, floor) {
    // rust: (true, true) => {
    // rust: if random.next_boolean() {
    // rust: Direction::Down
    // rust: } else {
    // rust: Direction::Up
}
}
    // rust: (true, false) => Direction::Down,
    // rust: (false, true) => Direction::Up,
    // rust: (false, false) => return Ok(false),
}
    // rust: let step = direction.normal();
    // rust: let base = offset(origin, step.map(|v| -v));
    // rust: self.base_at(world, base)?;
    // rust: for d in [[0, 0, -1], [1, 0, 0], [0, 0, 1], [-1, 0, 0]] {
    // rust: if random.next_float() > self.chances[1] {
    // rust: continue;
}
    // rust: let mut p = offset(base, d);
    // rust: self.base_at(world, p)?;
    // rust: for chance in &self.chances[2..] {
    // rust: if random.next_float() > *chance {
    // rust: break;
}
    // rust: let d = Direction::ALL
    // rust: [random.next_int_bound(6).map_err(SpeleothemError::Random)? as usize];
    // rust: p = offset(p, d.normal());
    // rust: self.base_at(world, p)?;
}
}
    // rust: let tall = random.next_float() < self.chances[0]
    // rust: && self.empty_or_water.contains(
    // rust: &world
    // rust: .block(offset(origin, step))
    // rust: .map_err(SpeleothemError::World)?,
    // rust: );
    // rust: if self.is_base(world.block(base).map_err(SpeleothemError::World)?) {
    // rust: let row = &self.pointed[usize::from(direction == Direction::Down)];
    // rust: let mut p = origin;
    // rust: for thickness in if tall { &[1, 0][..] } else { &[0][..] } {
    // rust: let variants = row[*thickness].ok_or(SpeleothemError::InvalidPointedState)?;
    // rust: let water = world.water_at(p).map_err(SpeleothemError::Query)?;
    // rust: let state =
    // rust: variants[usize::from(water)].ok_or(SpeleothemError::InvalidPointedState)?;
    // rust: world
    // rust: .set_block(p, state, 2)
    // rust: .map_err(SpeleothemError::World)?;
    // rust: p = offset(p, step);
}
}
    // rust: Ok(true)
}
}
offset :: proc(p: [i32; 3], d: [i32; 3]) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: std::array::from_fn(|i| p[i].wrapping_add(d[i]))
}
