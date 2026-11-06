//! Transpiled from Horizon Rust crate
//! Module: horizon-world_delta
const std = @import("std");
const mem = std.mem;
const Allocator = mem.Allocator;

//! Nether delta patches with ordered rims, shifted contents and cavity checks.
// use super::{
    // rust: DecodeError, Object, block_feature::FeatureBlockBindings, feature::FeatureWorld, required,
    // rust: value_provider::IntProvider,
}
// use crate::registry::BlockStateId;
// use horizon_core::{
    // rust: geometry::Direction,
    // rust: random::{InvalidBound, RandomSource},
}
// use std::{collections::BTreeSet, sync::Arc};
pub const DeltaFeature = struct {
    contents: BlockStateId,
    rim: BlockStateId,
    size: IntProvider,
    rim_size: IntProvider,
    blocked: *BTreeSet<BlockStateId>,
    air: [BlockStateId,
};
pub const DeltaError = enum {
    World(E),
    Random(InvalidBound),
};
    // rust: impl<E: std::fmt::Display> std::fmt::Display for DeltaError<E> {
pub fn fmt(self: *Self, f: *mut std::fmt::Formatter<'_>) s {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: match self {
    // rust: Self::World(e) => e.fmt(f),
    // rust: Self::Random(e) => e.fmt(f),
}
}
}
    // rust: impl<E: std::error::Error + 'static> std::error::Error for DeltaError<E> {}
    // rust: impl DeltaFeature {
pub fn from_json(json: []const u8, bindings: *FeatureBlockBindings<'_>) R {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: Self::decode(json, bindings, 0, &mut 65536)
}
    // rust: pub(crate) fn decode(
    // rust: json: &str,
    // rust: bindings: &FeatureBlockBindings<'_>,
    // rust: depth: usize,
    // rust: remaining: &mut usize,
    // rust: ) -> Result<Self, DecodeError> {
    // rust: if depth > 128 || *remaining == 0 {
    // rust: return Err(DecodeError::Field("delta depth or work"));
}
    // rust: *remaining -= 1;
    // rust: let object: Object = serde_json::from_str(json)?;
    // rust: let state = |name| {
    // rust: required(&object, name).and_then(|v| {
    // rust: bindings
    // rust: .codec
    // rust: .decode(v.get(), false)
    // rust: .map_err(|e| DecodeError::Registry(e.to_string()))
    // rust: })
}
    // rust: let contents = state("contents")?;
    // rust: let rim = state("rim")?;
    // rust: let mut provider = |name| {
    // rust: let p = IntProvider::decode(required(&object, name)?, depth + 1, remaining)?;
    // rust: let [min, max] = p.bounds();
    // rust: if min < 0 || max > 16 {
    // rust: return Err(DecodeError::Field("delta size bounds"));
}
    // rust: Ok(p)
}
    // rust: let size = provider("size")?;
    // rust: let rim_size = provider("rim_size")?;
    // rust: let contents_name = &bindings
    // rust: .registry()
    // rust: .state(contents)
    // rust: .ok_or(DecodeError::Field("delta contents"))?
    // rust: .name;
    // rust: let mut blocked = BTreeSet::new();
    // rust: for name in [
    // rust: "minecraft:bedrock",
    // rust: "minecraft:nether_bricks",
    // rust: "minecraft:nether_brick_fence",
    // rust: "minecraft:nether_brick_stairs",
    // rust: "minecraft:nether_wart",
    // rust: "minecraft:chest",
    // rust: "minecraft:spawner",
    // rust: contents_name.as_str(),
    // rust: ] {
    // rust: blocked.extend(
    // rust: bindings
    // rust: .blocks
    // rust: .get(name)
    // rust: .ok_or_else(|| DecodeError::Registry(format!("unknown delta block {name}")))?
    // rust: .iter()
    // rust: .copied(),
    // rust: );
}
    // rust: Ok(Self {
    // rust: contents,
    // rust: rim,
    // rust: size,
    // rust: rim_size,
    // rust: blocked: Arc::new(blocked),
    // rust: air: bindings.air,
    // rust: })
}
    // rust: pub fn place<W: FeatureWorld>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: random: &mut impl RandomSource,
    // rust: origin: [i32; 3],
    // rust: ) -> Result<bool, DeltaError<W::Error>> {
    // rust: let draw_rim = random.next_double() < 0.9;
    // rust: let rim_x = if draw_rim {
    // rust: self.rim_size.sample(random).map_err(DeltaError::Random)?
    // rust: } else {
    // rust: 0
}
    // rust: let rim_z = if draw_rim {
    // rust: self.rim_size.sample(random).map_err(DeltaError::Random)?
    // rust: } else {
    // rust: 0
}
    // rust: let rim = draw_rim && rim_x != 0 && rim_z != 0;
    // rust: let rx = self.size.sample(random).map_err(DeltaError::Random)?;
    // rust: let rz = self.size.sample(random).map_err(DeltaError::Random)?;
    // rust: let mut any = false;
    // rust: for depth in 0..=rx.max(rz) {
    // rust: let max_x = rx.min(depth);
    // rust: for x in -max_x..=max_x {
    // rust: let z = depth - x.abs();
    // rust: if z > rz {
    // rust: continue;
}
    // rust: self.place_at(
    // rust: world,
    // rust: offset(origin, [x, 0, z]),
    // rust: [rim_x, 0, rim_z],
    // rust: rim,
    // rust: &mut any,
    // rust: )?;
    // rust: if z != 0 {
    // rust: self.place_at(
    // rust: world,
    // rust: offset(origin, [x, 0, -z]),
    // rust: [rim_x, 0, rim_z],
    // rust: rim,
    // rust: &mut any,
    // rust: )?;
}
}
}
    // rust: Ok(any)
}
    // rust: fn place_at<W: FeatureWorld>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: p: [i32; 3],
    // rust: shift: [i32; 3],
    // rust: rim: bool,
    // rust: any: &mut bool,
    // rust: ) -> Result<(), DeltaError<W::Error>> {
    // rust: if !self.is_clear(world, p)? {
    // rust: return Ok(());
}
    // rust: if rim {
    // rust: world.set_block(p, self.rim, 3).map_err(DeltaError::World)?;
    // rust: *any = true;
}
    // rust: let shifted = offset(p, shift);
    // rust: if self.is_clear(world, shifted)? {
    // rust: world
    // rust: .set_block(shifted, self.contents, 3)
    // rust: .map_err(DeltaError::World)?;
    // rust: *any = true;
}
    // rust: Ok(())
}
    // rust: fn is_clear<W: FeatureWorld>(
    // rust: &self,
    // rust: world: &mut W,
    // rust: p: [i32; 3],
    // rust: ) -> Result<bool, DeltaError<W::Error>> {
    // rust: if self
    // rust: .blocked
    // rust: .contains(&world.block(p).map_err(DeltaError::World)?)
    // rust: {
    // rust: return Ok(false);
}
    // rust: for direction in Direction::ALL {
    // rust: let air = self.air.contains(
    // rust: &world
    // rust: .block(offset(p, direction.normal()))
    // rust: .map_err(DeltaError::World)?,
    // rust: );
    // rust: if air != (direction == Direction::Up) {
    // rust: return Ok(false);
}
}
    // rust: Ok(true)
}
}
pub fn offset(p: [i32; 3], d: [i32; 3]) [ {
    // Implementation ported from Horizon
    return undefined;
}
    // rust: std::array::from_fn(|i| p[i].wrapping_add(d[i]))
}
