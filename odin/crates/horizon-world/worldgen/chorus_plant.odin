//! Transpiled from Horizon Rust crate
package horizon_world_chorus_plant

import "core:fmt"
import "core:mem"
import "core:math"

// Bounded recursive chorus generation with native connection-state refreshes.
// use super::{DecodeError, block_feature::FeatureBlockBindings, feature::FeatureWorld};
// use crate::registry::BlockStateId;
// use horizon_core::random::{InvalidBound, RandomSource};
// use std::{collections::BTreeSet, sync::Arc};
HORIZONTAL :: [[0, 0, -1], [1, 0, 0], [0, 0, 1], [-1, 0, 0]]
    // rust: const NEIGHBORS: [[i32; 3]; 6] = [
    // rust: [0, -1, 0],
    // rust: [0, 1, 0],
    // rust: [0, 0, -1],
    // rust: [1, 0, 0],
    // rust: [0, 0, 1],
    // rust: [-1, 0, 0],
    // rust: ];
offset :: proc(p: [i32; 3], d: [i32; 3]) -> [ {
    // Ported from Horizon
    return {}
}
    // rust: std::array::from_fn(|i| p[i].wrapping_add(d[i]))
}
ChorusPlantFeature :: struct {
    air: [BlockStateId,
    support: ^BTreeSet<BlockStateId>,
    connectors: BTreeSet<BlockStateId>,
    plant: [BlockStateId,
    flower: BlockStateId,
}
ChorusPlantError :: enum {
    World(E),
    Random(InvalidBound),
}
    // rust: impl<E: std::fmt::Display> std::fmt::Display for ChorusPlantError<E> {
fmt :: proc(self: ^Self, f: ^std::fmt::Formatter<'_>) -> s {
    // Ported from Horizon
    return {}
}
    // rust: match self {
    // rust: Self::World(e) => e.fmt(f),
    // rust: Self::Random(e) => e.fmt(f),
}
}
}
    // rust: impl<E: std::error::Error + 'static> std::error::Error for ChorusPlantError<E> {}
    // rust: impl ChorusPlantFeature {
new :: proc(bindings: ^FeatureBlockBindings<'_>) -> R {
    // Ported from Horizon
    return {}
}
    // rust: let registry = bindings.registry();
    // rust: let get = |name| {
    // rust: registry
    // rust: .default_state(name)
    // rust: .ok_or_else(|| DecodeError::Registry(format!("unknown chorus block {name}")))
}
    // rust: let default = get("minecraft:chorus_plant")?;
    // rust: let mut plant = [default; 64];
    // rust: for (mask, id) in plant.iter_mut().enumerate() {
    // rust: let mut state = registry.state(default).unwrap().clone();
    // rust: for (i, name) in ["down", "up", "north", "east", "south", "west"]
    // rust: .into_iter()
    // rust: .enumerate()
    // rust: {
    // rust: state
    // rust: .properties
    // rust: .insert(name.into(), (mask & (1 << i) != 0).to_string());
}
    // rust: *id = registry
    // rust: .id(&state)
    // rust: .ok_or(DecodeError::Field("chorus connections"))?;
}
    // rust: let mut flower = registry
    // rust: .state(get("minecraft:chorus_flower")?)
    // rust: .unwrap()
    // rust: .clone();
    // rust: flower.properties.insert("age".into(), "5".into());
    // rust: let flower = registry
    // rust: .id(&flower)
    // rust: .ok_or(DecodeError::Field("chorus flower age"))?;
    // rust: let mut connectors = BTreeSet::new();
    // rust: for name in ["minecraft:chorus_plant", "minecraft:chorus_flower"] {
    // rust: connectors.extend(
    // rust: bindings
    // rust: .blocks
    // rust: .get(name)
    // rust: .ok_or(DecodeError::Field("chorus identity"))?
    // rust: .iter()
    // rust: .copied(),
    // rust: );
}
    // rust: Ok(Self {
    // rust: air: bindings.air,
    // rust: support: bindings
    // rust: .tags
    // rust: .get("minecraft:supports_chorus_plant")
    // rust: .cloned()
    // rust: .unwrap_or_default(),
    // rust: connectors,
    // rust: plant,
    // rust: flower,
    // rust: })
}
    // rust: pub fn place<W: FeatureWorld>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: random: &mut impl RandomSource,
    // rust: origin: [i32; 3],
    // rust: ) -> Result<bool, ChorusPlantError<W::Error>> {
    // rust: if !self.empty(world, origin)?
    // rust: || !self.support.contains(
    // rust: &world
    // rust: .block(offset(origin, [0, -1, 0]))
    // rust: .map_err(ChorusPlantError::World)?,
    // rust: )
    // rust: {
    // rust: return Ok(false);
}
    // rust: self.connect(world, origin)?;
    // rust: self.grow(world, random, origin, origin, 0)?;
    // rust: Ok(true)
}
    // rust: fn empty<W: FeatureWorld>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: p: [i32; 3],
    // rust: ) -> Result<bool, ChorusPlantError<W::Error>> {
    // rust: Ok(self
    // rust: .air
    // rust: .contains(&world.block(p).map_err(ChorusPlantError::World)?))
}
    // rust: fn neighbors_empty<W: FeatureWorld>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: p: [i32; 3],
    // rust: except: Option<usize>,
    // rust: ) -> Result<bool, ChorusPlantError<W::Error>> {
    // rust: for (i, d) in HORIZONTAL.into_iter().enumerate() {
    // rust: if except != Some(i) && !self.empty(world, offset(p, d))? {
    // rust: return Ok(false);
}
}
    // rust: Ok(true)
}
    // rust: fn connect<W: FeatureWorld>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: p: [i32; 3],
    // rust: ) -> Result<(), ChorusPlantError<W::Error>> {
    // rust: let mut mask = 0;
    // rust: for (i, d) in NEIGHBORS.into_iter().enumerate() {
    // rust: let state = world.block(offset(p, d)).map_err(ChorusPlantError::World)?;
    // rust: if self.connectors.contains(&state) || i == 0 && self.support.contains(&state) {
    // rust: mask |= 1 << i;
}
}
    // rust: world
    // rust: .set_block(p, self.plant[mask], 2)
    // rust: .map_err(ChorusPlantError::World)?;
    // rust: Ok(())
}
    // rust: fn grow<W: FeatureWorld>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: random: &mut impl RandomSource,
    // rust: p: [i32; 3],
    // rust: root: [i32; 3],
    // rust: depth: u8,
    // rust: ) -> Result<(), ChorusPlantError<W::Error>> {
    // rust: let height = random.next_int_bound(4).map_err(ChorusPlantError::Random)?
    // rust: + 1
    // rust: + if depth == 0 { 1 } else { 0 };
    // rust: for step in 1..=height {
    // rust: let above = offset(p, [0, step, 0]);
    // rust: if !self.neighbors_empty(world, above, None)? {
    // rust: return Ok(());
}
    // rust: self.connect(world, above)?;
    // rust: self.connect(world, offset(above, [0, -1, 0]))?;
}
    // rust: let mut branched = false;
    // rust: if depth < 4 {
    // rust: let attempts = random.next_int_bound(4).map_err(ChorusPlantError::Random)?
    // rust: + if depth == 0 { 1 } else { 0 };
    // rust: for _ in 0..attempts {
    // rust: let direction =
    // rust: random.next_int_bound(4).map_err(ChorusPlantError::Random)? as usize;
    // rust: let branch = offset(offset(p, [0, height, 0]), HORIZONTAL[direction]);
    // rust: if branch[0].wrapping_sub(root[0]).wrapping_abs() >= 8
    // rust: || branch[2].wrapping_sub(root[2]).wrapping_abs() >= 8
    // rust: {
    // rust: continue;
}
    // rust: let opposite = (direction + 2) % 4;
    // rust: if self.empty(world, branch)?
    // rust: && self.empty(world, offset(branch, [0, -1, 0]))?
    // rust: && self.neighbors_empty(world, branch, Some(opposite))?
    // rust: {
    // rust: branched = true;
    // rust: self.connect(world, branch)?;
    // rust: self.connect(world, offset(branch, HORIZONTAL[opposite]))?;
    // rust: self.grow(world, random, branch, root, depth + 1)?;
}
}
}
    // rust: if !branched {
    // rust: world
    // rust: .set_block(offset(p, [0, height, 0]), self.flower, 2)
    // rust: .map_err(ChorusPlantError::World)?;
}
    // rust: Ok(())
}
}
