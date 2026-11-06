//! Transpiled from Horizon Rust crate
//! Module: horizon-world_end_podium
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! End exit podium construction and active-portal replacement requests.
// use super::{
    // rust: DecodeError, Object,
    // rust: block_feature::FeatureBlockBindings,
    // rust: feature::FeatureWorld,
    // rust: optional,
    // rust: placement::{PlacementContext, PlacementQueryError},
}
// use crate::registry::BlockStateId;
// use std::{collections::BTreeSet, sync::Arc};
pub const EndPodiumFeature = struct {
    active: bool,
    bedrock: BlockStateId,
    air: BlockStateId,
    end_stone: BlockStateId,
    portal: BlockStateId,
    torches: [BlockStateId,
    same_blocks: [*BTreeSet<BlockStateId>,
};
pub const EndPodiumError = enum {
    World(E),
    Query(PlacementQueryError),
    WorkLimit,
};
    // rust: impl<E: std::fmt::Display> std::fmt::Display for EndPodiumError<E> {
pub fn fmt(self: *Self, f: *mut std::fmt::Formatter<'_>) s {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::World(e) => e.fmt(f),
    // rust: Self::Query(e) => e.fmt(f),
    // rust: Self::WorkLimit => f.write_str("end podium work limit exceeded"),
}
}
}
    // rust: impl<E: std::error::Error + 'static> std::error::Error for EndPodiumError<E> {}
    // rust: impl EndPodiumFeature {
pub fn from_json(json: []const u8, bindings: *FeatureBlockBindings<'_>) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: let object: Object = serde_json::from_str(json)?;
    // rust: let active = optional(&object, "active")
    // rust: .map(|v| serde_json::from_str(v.get()))
    // rust: .transpose()?
    // rust: .unwrap_or(false);
    // rust: let get = |name| {
    // rust: bindings
    // rust: .registry()
    // rust: .default_state(name)
    // rust: .ok_or_else(|| DecodeError::Registry(format!("unknown podium block {name}")))
}
    // rust: let torches = ["north", "east", "south", "west"].map(|direction| {
    // rust: bindings
    // rust: .codec
    // rust: .decode(
    // rust: &format!(r#"{{"id":"wall_torch","properties":{{"facing":"{direction}"}}}}"#),
    // rust: false,
    // rust: )
    // rust: .map_err(|e| DecodeError::Registry(e.to_string()))
    // rust: });
    // rust: let [north, east, south, west] = torches;
    // rust: let same_blocks = [
    // rust: "minecraft:end_stone",
    // rust: "minecraft:air",
    // rust: "minecraft:end_portal",
    // rust: ]
    // rust: .map(|name| {
    // rust: bindings
    // rust: .blocks
    // rust: .get(name)
    // rust: .cloned()
    // rust: .ok_or_else(|| DecodeError::Registry(format!("unknown podium block {name}")))
    // rust: });
    // rust: let [end_stone, air, portal] = same_blocks;
    // rust: Ok(Self {
    // rust: active,
    // rust: bedrock: get("minecraft:bedrock")?,
    // rust: air: get("minecraft:air")?,
    // rust: end_stone: get("minecraft:end_stone")?,
    // rust: portal: get("minecraft:end_portal")?,
    // rust: torches: [north?, east?, south?, west?],
    // rust: same_blocks: [end_stone?, air?, portal?],
    // rust: })
}
    // rust: pub fn place<W: FeatureWorld + PlacementContext>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: origin: [i32; 3],
    // rust: ) -> Result<bool, EndPodiumError<W::Error>> {
    // rust: let a = offset(origin, [-4, -1, -4]);
    // rust: let b = offset(origin, [4, 32, 4]);
    // rust: let min: [i32; 3] = std::array::from_fn(|i| a[i].min(b[i]));
    // rust: let sizes: [i32; 3] =
    // rust: std::array::from_fn(|i| a[i].max(b[i]).wrapping_sub(min[i]).wrapping_add(1));
    // rust: let count = sizes[0].wrapping_mul(sizes[1]).wrapping_mul(sizes[2]);
    // rust: let mut index: i32 = 0;
    // rust: let mut remaining = 1_048_576;
    // rust: while index != count {
    // rust: if remaining == 0 {
    // rust: return Err(EndPodiumError::WorkLimit);
}
    // rust: remaining -= 1;
    // rust: let quotient = index / sizes[0];
    // rust: let p = [
    // rust: min[0].wrapping_add(index % sizes[0]),
    // rust: min[1].wrapping_add(quotient % sizes[1]),
    // rust: min[2].wrapping_add(quotient / sizes[1]),
    // rust: ];
    // rust: index = index.wrapping_add(1);
    // rust: let d: [f64; 3] = std::array::from_fn(|i| f64::from(p[i]) - f64::from(origin[i]));
    // rust: let distance = d[0] * d[0] + d[1] * d[1] + d[2] * d[2];
    // rust: let inner = distance < 2.5 * 2.5;
    // rust: if !inner && distance >= 3.5 * 3.5 {
    // rust: continue;
}
    // rust: if p[1] < origin[1] {
    // rust: if inner {
    // rust: world
    // rust: .set_block(p, self.bedrock, 3)
    // rust: .map_err(EndPodiumError::World)?;
    // rust: } else {
    // rust: self.replace(world, p, self.end_stone, 0)?;
}
    // rust: } else if p[1] > origin[1] {
    // rust: self.replace(world, p, self.air, 1)?;
    // rust: } else if !inner {
    // rust: world
    // rust: .set_block(p, self.bedrock, 3)
    // rust: .map_err(EndPodiumError::World)?;
    // rust: } else if self.active {
    // rust: self.replace(world, p, self.portal, 2)?;
    // rust: } else {
    // rust: world
    // rust: .set_block(p, self.air, 3)
    // rust: .map_err(EndPodiumError::World)?;
}
}
    // rust: for y in 0..4 {
    // rust: world
    // rust: .set_block(offset(origin, [0, y, 0]), self.bedrock, 3)
    // rust: .map_err(EndPodiumError::World)?;
}
    // rust: for (delta, state) in [[0, 2, -1], [1, 2, 0], [0, 2, 1], [-1, 2, 0]]
    // rust: .into_iter()
    // rust: .zip(self.torches)
    // rust: {
    // rust: world
    // rust: .set_block(offset(origin, delta), state, 3)
    // rust: .map_err(EndPodiumError::World)?;
}
    // rust: Ok(true)
}
    // rust: fn replace<W: FeatureWorld + PlacementContext>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: p: [i32; 3],
    // rust: state: BlockStateId,
    // rust: kind: usize,
    // rust: ) -> Result<(), EndPodiumError<W::Error>> {
    // rust: if self.active {
    // rust: if self.same_blocks[kind].contains(&world.block(p).map_err(EndPodiumError::World)?) {
    // rust: return Ok(());
}
    // rust: world
    // rust: .destroy_block_without_entity(p, true)
    // rust: .map_err(EndPodiumError::Query)?;
}
    // rust: world
    // rust: .set_block(p, state, 3)
    // rust: .map_err(EndPodiumError::World)?;
    // rust: Ok(())
}
}
pub fn offset(p: [i32; 3], d: [i32; 3]) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: std::array::from_fn(|i| p[i].wrapping_add(d[i]))
}
