//! Transpiled from Horizon Rust crate
//! Module: horizon-world_end_spike
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! `minecraft:end_spike`: the obsidian pillars around the main End island.
// use super::{
    // rust: DecodeError, Object,
    // rust: block_feature::FeatureBlockBindings,
    // rust: feature::FeatureWorld,
    // rust: feature_graph::FeatureExecutionError,
    // rust: integer, optional,
    // rust: placement::{PlacementContext, PlacementQueryError},
    // rust: required,
    // rust: tree::{TreeResult, kind, write},
    // rust: tree_blocks::{self as tb, TreeBlocks},
}
// use crate::registry::BlockStateId;
// use horizon_core::random::{LegacyRandom, RandomSource};
// use std::sync::Arc;

    // rust: fn query<E>(error: PlacementQueryError) -> FeatureExecutionError<E> {
    // rust: FeatureExecutionError::Query(error)
}

pub const EndSpike = struct {
    center_x: i32,
    center_z: i32,
    radius: i32,
    height: i32,
    guarded: bool,
};
/// EndSpikeFeature.getSpikesForLevel (SpikeCacheLoader), from the world seed.
pub fn spikes_for_seed(seed: i64) V {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let key = LegacyRandom::new(seed).next_long() & 65535;
    // rust: let mut random = LegacyRandom::new(key);
    // rust: let mut sizes: Vec<i32> = (0..10).collect();
    // rust: tb::shuffle(&mut sizes, &mut random).expect("positive shuffle bounds");
    // rust: (0..10)
    // rust: .map(|i| {
    // rust: let angle =
    // rust: 2.0 * (-std::f64::consts::PI + (std::f64::consts::PI / 10.0) * f64::from(i));
    // rust: let size = sizes[i as usize];
    // rust: EndSpike {
    // rust: center_x: (42.0 * horizon_core::jmath::cos(angle)).floor() as i32,
    // rust: center_z: (42.0 * horizon_core::jmath::sin(angle)).floor() as i32,
    // rust: radius: 2 + size / 3,
    // rust: height: 76 + size * 3,
    // rust: guarded: size == 1 || size == 2,
}
    // rust: })
    // rust: .collect()
}

pub const EndSpikeFeature = struct {
    spikes: std.ArrayList(EndSpike),
    crystal_invulnerable: bool,
    beam_target: Option<[i32,
    obsidian: BlockStateId,
    air: BlockStateId,
    iron_bars: BlockStateId,
    bedrock: BlockStateId,
    fire: BlockStateId,
    blocks: *TreeBlocks,
};
    // rust: impl EndSpikeFeature {
    // rust: pub(crate) fn decode(
    // rust: json: &str,
    // rust: bindings: &FeatureBlockBindings<'_>,
    // rust: ) -> Result<Self, DecodeError> {
    // rust: let object: Object = serde_json::from_str(json)?;
    // rust: if kind(&object)? != "minecraft:end_spike" {
    // rust: return Err(DecodeError::Field("end spike type"));
}
    // rust: let raw: Vec<Object> = serde_json::from_str(required(&object, "spikes")?.get())?;
    // rust: let int = |o: &Object, name: &str| -> Result<i32, DecodeError> {
    // rust: optional(o, name)
    // rust: .map(integer)
    // rust: .transpose()
    // rust: .map(|v| v.unwrap_or(0))
}
    // rust: let spikes = raw
    // rust: .iter()
    // rust: .map(|o| {
    // rust: Ok(EndSpike {
    // rust: center_x: int(o, "centerX")?,
    // rust: center_z: int(o, "centerZ")?,
    // rust: radius: int(o, "radius")?,
    // rust: height: int(o, "height")?,
    // rust: guarded: optional(o, "guarded")
    // rust: .map(|v| serde_json::from_str::<bool>(v.get()))
    // rust: .transpose()?
    // rust: .unwrap_or(false),
    // rust: })
    // rust: })
    // rust: .collect::<Result<_, DecodeError>>()?;
    // rust: let beam_target = optional(&object, "crystal_beam_target")
    // rust: .map(|raw| -> Result<[i32; 3], DecodeError> {
    // rust: let v: Vec<Box<serde_json::value::RawValue>> = serde_json::from_str(raw.get())?;
    // rust: if v.len() != 3 {
    // rust: return Err(DecodeError::Field("beam target"));
}
    // rust: Ok([integer(&v[0])?, integer(&v[1])?, integer(&v[2])?])
    // rust: })
    // rust: .transpose()?;
    // rust: let registry = bindings.registry();
    // rust: let default = |name: &str| {
    // rust: registry
    // rust: .default_state(name)
    // rust: .ok_or_else(|| DecodeError::Registry(format!("missing spike block {name}")))
}
    // rust: Ok(Self {
    // rust: spikes,
    // rust: crystal_invulnerable: optional(&object, "crystal_invulnerable")
    // rust: .map(|v| serde_json::from_str::<bool>(v.get()))
    // rust: .transpose()?
    // rust: .unwrap_or(false),
    // rust: beam_target,
    // rust: obsidian: default("minecraft:obsidian")?,
    // rust: air: default("minecraft:air")?,
    // rust: iron_bars: default("minecraft:iron_bars")?,
    // rust: bedrock: default("minecraft:bedrock")?,
    // rust: fire: default("minecraft:fire")?,
    // rust: blocks: bindings.tree_blocks()?,
    // rust: })
}
    // rust: pub(crate) fn place<W: FeatureWorld + PlacementContext, R: RandomSource>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: random: &mut R,
    // rust: origin: [i32; 3],
    // rust: ) -> TreeResult<bool, W::Error> {
    // rust: let spikes = if self.spikes.is_empty() {
    // rust: spikes_for_seed(world.world_seed().map_err(query)?)
    // rust: } else {
    // rust: self.spikes.clone()
}
    // rust: for spike in spikes {
    // rust: if origin[0] >> 4 == spike.center_x >> 4 && origin[2] >> 4 == spike.center_z >> 4 {
    // rust: self.place_spike(world, random, spike)?;
}
}
    // rust: Ok(true)
}
    // rust: fn bars<E>(
    // rust: &self,
    // rust: north: bool,
    // rust: south: bool,
    // rust: west: bool,
    // rust: east: bool,
    // rust: ) -> TreeResult<BlockStateId, E> {
    // rust: let mut state = self.iron_bars;
    // rust: for (name, value) in [
    // rust: ("north", north),
    // rust: ("south", south),
    // rust: ("west", west),
    // rust: ("east", east),
    // rust: ] {
    // rust: state = self
    // rust: .blocks
    // rust: .with(state, name, if value { "true" } else { "false" })
    // rust: .ok_or(FeatureExecutionError::InvalidState)?;
}
    // rust: Ok(state)
}
    // rust: fn place_spike<W: FeatureWorld + PlacementContext, R: RandomSource>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: random: &mut R,
    // rust: spike: EndSpike,
    // rust: ) -> TreeResult<(), W::Error> {
    // rust: let r = spike.radius;
    // rust: let min_y = world.min_y().map_err(query)?;
    // rust: let (cx, cz) = (spike.center_x, spike.center_z);
    // rust: for z in cz - r..=cz + r {
    // rust: for y in min_y..=spike.height + 10 {
    // rust: for x in cx - r..=cx + r {
    // rust: let dx = f64::from(x) - f64::from(cx);
    // rust: let dz = f64::from(z) - f64::from(cz);
    // rust: let p = [x, y, z];
    // rust: if dx * dx + dz * dz <= f64::from(r * r + 1) && y < spike.height {
    // rust: write(world, p, self.obsidian, 3)?;
    // rust: } else if y > 65 {
    // rust: write(world, p, self.air, 3)?;
}
}
}
}
    // rust: if spike.guarded {
    // rust: for dx in -2i32..=2 {
    // rust: for dz in -2i32..=2 {
    // rust: for dy in 0..=3 {
    // rust: let x_side = dx.abs() == 2;
    // rust: let z_side = dz.abs() == 2;
    // rust: let top = dy == 3;
    // rust: if x_side || z_side || top {
    // rust: let x_edge = dx == -2 || dx == 2 || top;
    // rust: let z_edge = dz == -2 || dz == 2 || top;
    // rust: let state = self.bars(
    // rust: x_edge && dz != -2,
    // rust: x_edge && dz != 2,
    // rust: z_edge && dx != -2,
    // rust: z_edge && dx != 2,
    // rust: )?;
    // rust: write(world, [cx + dx, spike.height + dy, cz + dz], state, 3)?;
}
}
}
}
}
    // rust: let yaw = random.next_float() * 360.0;
    // rust: world
    // rust: .spawn_end_crystal(
    // rust: [
    // rust: f64::from(cx) + 0.5,
    // rust: f64::from(spike.height + 1),
    // rust: f64::from(cz) + 0.5,
    // rust: ],
    // rust: yaw,
    // rust: self.beam_target,
    // rust: self.crystal_invulnerable,
    // rust: )
    // rust: .map_err(query)?;
    // rust: let crystal = [cx, spike.height + 1, cz];
    // rust: write(world, tb::offset(crystal, 0, -1, 0), self.bedrock, 3)?;
        // FireBlock.getState above sturdy bedrock is the plain fire default.
    // rust: write(world, crystal, self.fire, 3)?;
    // rust: Ok(())
}
}

    // rust: mod tests {
//     use super::*;
pub fn spike_layout_is_a_permutation_of_sizes() void {
}
    // rust: let spikes = spikes_for_seed(0);
    // rust: assert_eq!(spikes.len(), 10);
    // rust: let mut heights: Vec<i32> = spikes.iter().map(|s| s.height).collect();
    // rust: heights.sort_unstable();
    // rust: assert_eq!(heights, (0..10).map(|s| 76 + s * 3).collect::<Vec<_>>());
    // rust: assert_eq!(spikes.iter().filter(|s| s.guarded).count(), 2);
    // rust: assert_eq!((spikes[0].center_x, spikes[0].center_z), (42, 0));
    // rust: assert_eq!(spikes_for_seed(0), spikes_for_seed(0));
}
}
